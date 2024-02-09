[![Orange banner indicating a preview software component][release-level-banner--unstable]](##)

<br />

**📘 Development**

_Explains how to fork, set up a development environment, and iterate to get
started contributing_

<br />

<!--<div align="center">
<figure>
  <img
    alt="Depiction of the creation story"
    src="./img/Jailbot_creation.png"
  /><br />
  <figcaption>Depiction of the creation story</figcaption>
</figure>
</div><br /><br />-->

Before cloning this repository, please ensure appropriate safety precautions are
taken. This means being sure to use an air-tight and ephemeral development
environment to essentially create a disposable sandbox. This may be accomplished
using virtualization software. There are several excellent and free
virtualization products (called hypervisors or virtual machine managers). One
such as product is [Oracle VM VirtualBox][], which can be used for local
development or perhaps consider using cloud-based virtualization
offerings.<br /><br />

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
> &mdash;&nbsp;<https://www.virtualbox.org/manual/ch01.html#virt-why-useful>

</details><br />

<!-- TODO(DerekNonGeneric):

We would be remiss to mention the air-tightness of a VM architecture without
mentioning that having a [watertight privacy architecture][] would likewise
be preferable. Whonix offers detailed VirtualBox import instructions.[^1]

Please note usage of Whonix implies use of the Tor network, which it uses
to provide the strongest protection of client IP addresses. However, this may
be contentious in some academic and workplace settings. Usage of Whonix was,
however, suggested to the original author of this document by his professor.

-->

### Building the Docker Images

<br />

<details open><summary>
[EXCERPT]：<em><a title="Task Kinds &mdash; Firefox Source Documentation" <a
  href="https://firefox-source-docs.mozilla.org/taskcluster/kinds.html"
                >Task Kinds &mdash; Firefox Source
                  Documentation</a></em>&nbsp;&mdash;&nbsp;
  <strong>Section&nbsp;&ldquo;<code>docker-image</code>&rdquo;, Firefox CI and
    Taskgraph Reference</strong>
</summary><br />

> Tasks of the `docker-image` kind build the Docker images in which other Docker
> tasks run.
>
> The tasks to generate each docker image have predictable labels:
> `docker-image-<name>`.
>
> Docker images are built from subdirectories of `taskcluster/docker`, using
> [`docker build`][]. There is currently no capability for one Docker image to
> depend on another in-tree docker image, without uploading the latter to a
> Docker repository.
>
> &mdash;&nbsp;<https://firefox-source-docs.mozilla.org/taskcluster/kinds.html#docker-image>

</details><br />

<br /><br />

[![Orange banner indicating a preview software component][release-level-banner--unstable]](##)

<!-- LINK LABEL DEFINITIONS - START -->

[^1]:
    <https://www.whonix.org/wiki/VirtualBox> "Whonix ™ for Windows, macOS,
    Linux inside VirtualBox"

[`docker build`]:
  https://docs.docker.com/engine/reference/commandline/build/
  'docker build | Docker Documentation'
[Oracle VM VirtualBox]: https://www.virtualbox.org 'Oracle VM VirtualBox'
[Watertight Privacy Architecture]:
  https://www.whonix.org/wiki/About#Whonix_%E2%84%A2_Architecture
  'Whonix ™ Architecture'
[_VirtualBox User Manual_]:
  https://www.virtualbox.org/manual/
  'Oracle® VM VirtualBox® User Manual'
[release-level-banner--unstable]:
  https://raw.githubusercontent.com/OpenINF/openinf.github.io/live/assets/img/svg/release-level-banner--unstable.svg?sanitize=true
  'Banner for Release Level: Unstable'

<!-- LINK LABEL DEFINITIONS - END -->
