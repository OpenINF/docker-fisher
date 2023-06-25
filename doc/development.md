## Development

Before cloning this repository, please ensure appropriate safety precautions are taken.
This means being sure to use an air-tight and ephemeral development environment to
essentially create a disposable sandbox. This may be accomplished using virtualization
software such as [Oracle VM VirtualBox][] for local development or perhaps consider using
cloud-based virtualization offerings.<br /><br />

<details open><summary>
[EXCERPT]：<em><a title="Oracle® VM VirtualBox® User Manual" <a
  href="https://www.virtualbox.org/manual"
                >VirtualBox User Manual</a></em>&nbsp;&mdash;&nbsp;
  <b>Section 1.1, “Why is Virtualization Useful?”</b>
</summary><br />

> Once installed, a virtual machine and its virtual hard disks can be considered
> a container that can be arbitrarily frozen, woken up, copied, backed up, and
> transported between hosts.
>
> Using virtual machines enables you to build and test a multi-node networked
> service, for example. Issues with networking, operating system, and software
> configuration can be investigated easily.
>
> In addition to that, with the use of an Oracle VM VirtualBox feature called
> snapshots, one can save a particular state of a virtual machine and revert
> back to that state, if necessary. This way, one can freely experiment with a
> computing environment. If something goes wrong, such as problems after
> installing software or infecting the guest with a virus, you can easily switch
> back to a previous snapshot and avoid the need of frequent backups and
> restores.
>
> Any number of snapshots can be created, allowing you to travel back and
> forward in virtual machine time. You can delete snapshots while a VM is
> running to reclaim disk space.
>
> &mdash;&nbsp;https://www.virtualbox.org/manual/ch01.html#virt-why-useful

</details><br />

We would be remiss to mention the air-tightness of a VM architecture without
mentioning that having a [watertight privacy architecture][] would likewise
be preferable. Whonix offers detailed VirtualBox import instructions.[^1]

### Building the Docker Images

Tasks of the `docker-image` kind build the Docker images in which other Docker
tasks run.

The tasks to generate each docker image have predictable labels:
`docker-image-<name>`.

Docker images are built from subdirectories of `taskcluster/docker`, using
`docker build`. There is currently no capability for one Docker image to depend
on another in-tree docker image, without uploading the latter to a Docker
repository.[^2]


<!-- BEGIN LINK DEFINITIONS -->

[^1]: https://www.whonix.org/wiki/VirtualBox "Whonix ™ for Windows, macOS, Linux inside VirtualBox"
[^2]: https://firefox-source-docs.mozilla.org/taskcluster/kinds.html#docker-image

[`docker build`]:
  https://docs.docker.com/engine/reference/commandline/build/
  "docker build | Docker Documentation"

[Oracle VM VirtualBox]:
  https://www.virtualbox.org/
  'Oracle VM VirtualBox'

[Watertight Privacy Architecture]:
  https://www.whonix.org/#explain
  ''

[_VirtualBox User Manual_]:
  https://www.virtualbox.org/manual/
  'Oracle® VM VirtualBox® User Manual'
  
<!-- END LINK DEFINITIONS -->
