# drone-gcloud
[![Build Status](https://cloud.drone.io/api/badges/viant/drone-gcloud/status.svg)](https://cloud.drone.io/viant/drone-gcloud)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://github.com/viant/drone-gcloud/blob/master/LICENSE)

Drone plugin to execute gcloud and gsutil commands using a bas64 encoded JSON key. It has the ability to pull down a single script for more complex usage vs executing via the `commands` section.

## Usage

The following parameter is required:

* `gke_base64_key` base64 encoded JSON key

Optional:

* `script_file` URL of a script to pull down and execute. Python 3/2, Perl, and Bash currently available. Must include the shebang.

* `script` An array of commands to execute, just like a normal `commands` section.

Note the project is pulled from the JSON key.

## Example

```yaml
kind: pipeline
name: default

steps:

- name: gcloud
  image: viant/drone-gcloud
  settings:
    gke_base64_key:
      from_secret: gke_base64_key
    script_file: https://github.vianttech.com/raw/techops/drone-gke/some_script.sh
```

```yaml
kind: pipeline
name: default

steps:

- name: gcloud
  image: viant/drone-gcloud
  settings:
    gke_base64_key:
      from_secret: gke_base64_key
    script:
      - gcloud function list
      - pwd
```


## Testing

Modify the included `test.sh` script to test. You only need to provide the location of the base64 encoded JSON key.

