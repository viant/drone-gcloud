# drone-gcloud
[![Build Status](https://cloud.drone.io/api/badges/viant/drone-gcloud/status.svg)](https://cloud.drone.io/viant/drone-gcloud)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://github.com/viant/drone-gcloud/blob/master/LICENSE)

Drone plugin to execute gcloud and gsutil commands using a bas64 encoded JSON key. It has the ability to pull down a single script for more complex usage vs executing via the `commands` section.

## Usage

The following parameters are required:

* `gke_base64_key` base64 encoded JSON key
* `zone` Zone to execute in

Optional:

* `script` URL of a script to pull down and execute. Python and Bash currently available. Must include the shebang.
