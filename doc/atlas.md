## Atlas

### Key Terms<a id="key-terms"></a>

<dl>

<dt>Community Enterprise Operating System (CentOS)</dt>
<dd>

A Linux distribution derived from the sources of Red Hat Enterprise
Linux (RHEL).

</dd>
<dt id="docker-image">Docker image</dt><br />
<dd>

An _image_ is a read-only template with instructions for creating a
Docker container. Often, an image is _based on_ another image, with some
additional customization. For example, you may build an image which is
based on the `ubuntu` image, but installs the Apache web server and your
application, as well as the configuration details needed to make your
application run.[^1]
<br /><br />

</dd>
<dt id="docker-image-layer">Docker image layer</dt><br />
<dd>

The order of Dockerfile instructions matter. A Docker build consists of
a series of ordered build instructions. Each instruction in a Dockerfile
roughly translates to an _image layer_. The following diagram illustrates
how a Dockerfile translates into a stack of layers in a container image.[^2]
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
be cached. These intermediate layers are not shown by default.[^3]

</dd>
<dt>Fedora</dt>
<dd>

The upstream source of the commercial Red Hat Enterprise Linux
distribution.

</dd>
<dt>Oracle VirtualBox</dt>
<dd>

Runs multiple Linux distributions at the same time, assuming that
hardware has enough resources.

</dd>
<dt>﻿﻿Ubuntu</dt>
<dd>

An open-source operating system based on the Debian Linux distribution.

</dd>
<dt>Yet another Setup Tool (YaST)</dt>
<dd>

An operating system setup and configuration tool. One of opeSUSE's unique and popular utilities: the Yet another Setup Tool (YaST).
YaST, which can be thought of as a command-center utility, allows you to control many system services from one interface.

</dd>
</dl>

<br /><br />

<!-- BEGIN LINK DEFINITIONS -->

[^1]: https://docs.docker.com/get-started/overview/#images
[^2]: https://docs.docker.com/build/guide/layers/
[^3]: https://docs.docker.com/engine/reference/commandline/images/#description

