## Development

Before you even clone this repository, please practice good safety measures and
ensure that you are using an air-tight and ephemeral development environment
such as [VirtualBox][] VM if developing locally or perhaps consider using a
cloud-based VM offering.

### Building the Docker Images

Tasks of the `docker-image` kind build the Docker images in which other Docker
tasks run.

The tasks to generate each docker image have predictable labels:
`docker-image-<name>`.

Docker images are built from subdirectories of `taskcluster/docker`, using
`docker build`. There is currently no capability for one Docker image to depend
on another in-tree docker image, without uploading the latter to a Docker
repository.[^1]


<!-- BEGIN LINK DEFINITIONS -->

[^1]: https://firefox-source-docs.mozilla.org/taskcluster/kinds.html#docker-image

[`docker build`]:
  https://docs.docker.com/engine/reference/commandline/build/
  "docker build | Docker Documentation"

[VirtualBox]:
  https://www.virtualbox.org/
  "Oracle VM VirtualBox"
  
<!-- END LINK DEFINITIONS -->
