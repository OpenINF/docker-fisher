<strong>📕 Glossary</strong>

_Defines all the specific terms and vocabulary used throughout_

Participants should use this glossary to ensure consistency and avoid
the following happenstances.

- referring to the same thing using different names
- referring to different things using the same name (even worse)

---

## A

<br /><br />

## B

<br /><br />

## C

<br />

<dl>
<dt>Community Enterprise Operating System (CentOS)</dt><br />
<dd>

A Linux distribution derived from the sources of Red Hat Enterprise
Linux (RHEL).[^1]

</dd>
</dl>

<br /><br />

## D

<br />

<dl>
<dt id="docker-image">Docker image</dt><br />
<dd>

An _image_ is a read-only template with instructions for creating a
Docker container. Often, an image is _based on_ another image, with some
additional customization. For example, you may build an image which is
based on the `ubuntu` image, but installs the Apache web server and your
application, as well as the configuration details needed to make your
application run.[^2]

</dd><br /><br />
<dt id="docker-image-layer">Docker image layer</dt><br />
<dd>

The order of Dockerfile instructions matter. A Docker build consists of
a series of ordered build instructions. Each instruction in a Dockerfile
roughly translates to an _image layer_. The following diagram illustrates
how a Dockerfile translates into a stack of layers in a container image.[^3]
<br /><br />

<div align="center">
<figure>
  <img
    alt="From Dockerfile to layers"
    src="https://docs.docker.com/build/guide/images/layers.png"
  >
  </img>
  <figcaption>From Dockerfile to layers</figcaption>
</figure>
</div><br /><br />

Docker images have _intermediate layers_ that increase reusability,
decrease disk usage, and speed up docker build by allowing each step to
be cached. These intermediate layers are not shown by default.[^4]

</dd>
</dl>

<br /><br />

## F

<br />

<dl>

<dt>Fedora</dt><br />
<dd>

The upstream source of the commercial Red Hat Enterprise Linux
distribution.[^5]

</dd>
</dl>

<br /><br />

## H

<br />

<dl>

<dt>Hypervisor</dt><br />
<dd>

Also known as a virtual machine monitor or VMM, is software that creates and
runs virtual machines (VMs). A hypervisor allows one host computer to support
multiple guest VMs by virtually sharing its resources, such as memory and
processing.[^6]

<dl>
  <dt>Type 1 Hypervisor</dt><br />
  <dd>
    Also known as bare-metal or native hypervisor. It runs directly on the
    host's hardware and controls the hardware; manages and monitors guest
    operating systems, which run on a separate level above the hypervisor.
  </dd>
  <dt>Type 2 Hypervisor</dt><br />
  <dd>
    Also known as hosted hypervisor. It runs as a software layer on an
    operating system (the host OS), like other computer programs. Guest
    operating systems run on a third level above the hardware (within host OS).
  </dd>
</dl>

</dd>

</dl>

<br /><br />

## O

<br />

<dl>
<dt>Oracle VirtualBox</dt><br />
<dd>

Runs multiple Linux distributions at the same time, assuming that
hardware has enough resources.

</dd>
</dl>

<br /><br />

## U

<br />

<dl>
<dt>﻿﻿Ubuntu</dt><br />
<dd>

An open-source operating system based on the Debian Linux distribution.

</dd>
</dl>

<br /><br />

## Y

<br />

<dl>
<dt>Yet another Setup Tool (YaST)</dt><br />
<dd>

An operating system setup and configuration tool unique to openSUSE.
It can be thought of as a command-center utility; allows the control of
many system services from one interface.

</dd>
</dl>

<br /><br />

<!-- BEGIN LINK DEFINITIONS -->

[^1]: https://www.redhat.com/en/topics/linux/what-is-centos
[^2]: https://docs.docker.com/get-started/overview/#images
[^3]: https://docs.docker.com/build/guide/layers/
[^4]: https://docs.docker.com/engine/reference/commandline/images/#description
[^5]: https://docs.fedoraproject.org/en-US/quick-docs/fedora-and-red-hat-enterprise-linux/#relationship-between-fedora-and-red-hat-enterprise-linux
[^6]: https://www.vmware.com/topics/glossary/content/hypervisor.html

<!-- END LINK DEFINITIONS -->
