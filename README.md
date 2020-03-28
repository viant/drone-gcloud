# drone-gcloud
[![Build Status](https://cloud.drone.io/api/badges/viant/drone-gcloud/status.svg)](https://cloud.drone.io/viant/drone-gcloud)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://github.com/viant/drone-gcloud/blob/master/LICENSE)

Drone plugin to execute gcloud and gsutil commands using a bas64 encoded JSON key. It has the ability to pull down a single script for more complex usage vs executing via the `commands` section. Image now contains `packer` by Hashicorp. 

## Usage

The following parameter is required:

* `base64_key` base64 encoded JSON key

Optional:

* `script_file` URL of a script to pull down and execute. Python 3/2, Perl, and Bash currently available. Must include the shebang.

* `script` An array of commands to execute, just like a normal `commands` section.

* `kubectl` Setup `kubectl`. If set the `cluster` and `zone` settings are required 

Note the project is pulled from the JSON key.

## Example

```yaml
kind: pipeline
name: default

steps:

- name: gcloud
  image: viant/drone-gcloud
  settings:
    base64_key:
      from_secret: base64_key
    script_file: https://github.com/raw/viant/drone-gcloud/some_script.sh
```

```yaml
kind: pipeline
name: default

steps:

- name: gcloud
  image: viant/drone-gcloud
  settings:
    base64_key:
      from_secret: base64_key
    script:
      - gcloud function list
      - pwd
```

```yaml
kind: pipeline
name: default

steps:

- name: gcloud
  image: viant/drone-gcloud
  settings:
    base64_key:
      from_secret: base64_key
    kubectl: True
    cluster: my_cluster
    zone: us-east4-a
    script:
      - kubectl get pods
```

## Packer example

```yaml
- name: gcloud
  image: viant/drone-gcloud
  environment:
    GOOGLE_APPLICATION_CREDENTIALS: /gcloud.json
  settings:
    base64_key:
      from_secret: base64_key
    script:
      - packer build path/to/config.json
```




## Testing

Modify the included `test.sh` script to test. You only need to provide the location of the base64 encoded JSON key.
