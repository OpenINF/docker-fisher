<strong>📕 Glossary</strong>

_Defines all the specific terms and vocabulary used throughout_

Participants should use this glossary to ensure consistency and avoid
the following happenstances.

- referring to the same thing using different names
- referring to different things using the same name (even worse)

<br /><br />

---

<br />

<dl>

<dt id="etc-dir">

#### `/etc/`

</dt><br />
<dd><br />

<details><summary>Host-specific System Configuration</summary><br />

_Purpose_

The `/etc/` hierarchy contains configuration files. A "configuration file" is a 
local file used to control the operation of a program; it must be static and
cannot be an executable binary.[^3.7]

<br />


<sup>To be clear, `/etc/` may contain executable scripts, such as the command
scripts commonly called by `init` to start and shut down the system and start
daemon processes. "Executable binary" in this context refers to direct machine
code or pseudocode not in a human-readable format, such as native ELF  
executables.</sup>

<br />

_Requirements_

No binaries may be located under `/etc/`.[^3.7]

The following directories, or symbolic links to directories are required in
`/etc/`:

<br />

| Directory | Description               |
| --------- | ------------------------- |  
| `opt`     | Configuration for `/opt/` |

<br />

_Specific Options_

The following directories, or symbolic links to directories must be in `/etc/`,
if the corresponding subsystem is installed:

<br />

| Directory   | Description                                      |
| :---------- | :----------------------------------------------- |
| `X11`       | Configuration for the X Window system (optional) |
| `sgml`      | Configuration for SGML (optional)                |
| `xml`       | Configuration for XML (optional)                 |

<br />

<sup>Systems that use the shadow password suite will have additional 
configuration files in `/etc/` (`/etc/shadow/` and others) and programs in
`/usr/sbin/` (**`useradd`**, **`usermod`**, and others).</sup>

<br />

The following files, or symbolic links to files, must be in `/etc/` if the
corresponding subsystem is installed:

| File          | Description                                                         |
| :------------ | :------------------------------------------------------------------ |
| `csh.login`   | Systemwide initialization file for C shell logins (optional)        |
| `exports`     | NFS filesystem access control list (optional)                       |
| [`fstab`][]   | Static information about filesystems (optional)                     |
| `ftpusers`    | FTP daemon user access control list (optional)                      |
| `gateways`    | File which lists gateways for routed (optional)                     |
| `gettydefs`   | Speed and terminal settings used by getty (optional)                |
| `group`       | User group file (optional)                                          |
| `host.conf`   | Resolver configuration file (optional)                              |
| `hosts`       | Static information about host names (optional)                      |
| `hosts.allow` | Host access file for TCP wrappers (optional)                        |
| `hosts.deny`  | Host access file for TCP wrappers (optional)                        |
| `hosts.equiv` | List of trusted hosts for rlogin, rsh, rcp (optional)               |
| `hosts.lpd`   | List of trusted hosts for lpd (optional)                            |
| `inetd.conf`  | Configuration file for inetd (optional)                             |  
| `inittab`     | Configuration file for init (optional)                              |
| `issue`       | Pre-login message and identification file (optional)                |
| `ld.so.conf`  | List of extra directories to search for shared libraries (optional) |
| `motd`        | Post-login message of the day file (optional)                       |
| [`mtab`][]    | Dynamic information about filesystems (optional)                    |
| `mtools.conf` | Configuration file for mtools (optional)                            |
| `networks`    | Static information about network names (optional)                   |
| `passwd`      | The password file (optional)                                        |
| `printcap`    | The lpd printer capability database (optional)                      |
| `profile`     | Systemwide initialization file for sh shell logins (optional)       |
| `protocols`   | IP protocol listing (optional)                                      |
| `resolv.conf` | Resolver configuration file (optional)                              |
| `rpc`         | RPC protocol listing (optional)                                     |
| `securetty`   | TTY access control for root login (optional)                        |
| `services`    | Port names for network services (optional)                          | 
| `shells`      | Pathnames of valid login shells (optional)                          |
| `syslog.conf` | Configuration file for syslogd (optional)                           |

<br />

[`mtab`][] does not fit the static nature of `/etc/`: it is excepted for historical
reasons.[^3.7]

<br />

<sup>On some Linux systems, [`/etc/mtab`][] may be a symbolic link to 
`/proc/mounts`, in which case this exception is not required.</sup>

</details>
</dd><br />
<dt id="etc-fstab">
  
#### `/etc/fstab`

</dt><br />
<dd>

A configuration file that contains entries identifying the storage device
partitions Linux should mount at boot time.

</dd><br />
<dt id="etc-mtab">
  
#### `/etc/mtab`

</dt><br />
<dd>

A dynamic file that identifies the currently mounted partitions on the Linux
system.

</dd><br />
<dt id="etc-rsyslog-conf">

#### `/etc/rsyslog.conf`

</dt>
<dd>

The main configuration file for [`rsyslog`][], you can specify the rules
according to which [`rsyslogd`][] handles the messages. Generally, you can
classify messages by their source and topic (facility) and urgency (priority),
and then assign an action that should be performed when a message fits these
criteria.[^9]

In `/etc/rsyslog.conf`, you can also see a list of log files maintained by
`rsyslogd`. Most log files are located in the `/var/log/` directory. Some
applications, such as `httpd` and `samba`, store their log files in a
subdirectory within `/var/log/`.[^9]

**Additional resources**

- The `rsyslogd(8)` and `rsyslog.conf(5)` man pages.
- Documentation installed with the `rsyslog-doc` package in the
  `/usr/share/doc/rsyslog/html/index.html` file.[^9]

</dd>
</dl>

<br /><br />

## A

<br />

<dl>
<dt id="acl">

#### access control list (ACL)

</dt>
<div align="right"><note place="source"><ref target="chap15">

[⑮📑][]

</ref></note></div>
<dd>

A detailed method of assigning granular user and group permissions to files and
directories in a Linux system distinct from and more advanced than that which is
governed by the [`chmod`][] command; involves setting an [access control list
(ACL)][] for each file and directory.

ACLs allow **system administrators** to define not just read, write, and execute
permissions for multiple users or groups but also more advanced rules like set
user ID on execution, set group ID on execution, and
[inherited permissions](#inheritance).

On the flip side, ACLs allow **file owners** to specify extended access information
about a file, granting additional rights to users/groups other than those owning
the file. This form of _discretionary access control_ allows users to manage
their own collaborative projects without intervention of **system administrators**
to maintain groups, but also without granting rights to all users on the system
via use of the "other" permission bits.[^17.7]

The [`setfacl`][] command allows one
to set these permissions, and the [`getfacl`][] command allows one to view these
permissions as they exist in real-time.

For example, an ACL could allow user Bob read/write access to `file1.txt` while
denying access to `file2.txt`, allow the `sysadmin` group full access to a set
of configuration files, and set the `setuid` bit on a program while removing
access for other users.

ACLs are implemented as extended attributes in the [Linux ext file systems][]
and store the security rules in the metadata of the file or directory being
protected rather than altering the standard Unix permission bits. This allows
them to augment and extend the standard [Unix file permissions][] model and are
critical for implementing least privilege and defense in depth when securing
sensitive Linux resources.

The next level of security involves setting context-based permissions à la
[SELinux][] (for Red Hat–based Linux distributions) and [AppArmor][] (for
Debian-based Linux distributions).

</dd><br />
<dt>

#### AppArmor

</dt>
<div align="right"><note place="source"><ref target="chap15">

[⑮📑][]

</ref></note></div>
<dd>

An application used by Debian-based distributions to implement context-based
permissions for applications.

</dd><br />
</dl>

<br /><br />

## B

<br /><br />

## C

<br />

<dl>
<dt id="chgrp">

#### `chgrp`

</dt>
<div align="right"><note place="source"><ref target="chap15">

[⑮📑][]

</ref></note></div>
<dd>

A command-line command that allows the owner or system administrator to change
the group assigned to a file or directory.

</dd><br />
<dt id="chmod">
  
#### `chmod`

</dt>
<div align="right"><note place="source"><ref target="chap15">

[⑮📑][]

</ref></note></div>
<dd>

A command-line command that allows the system administrator to change the
permissions assigned to a file or directory.

</dd><br />
<dt id="chown">
  
#### `chown`

</dt>
<div align="right"><note place="source"><ref target="chap15">

[⑮📑][]

</ref></note></div>
<dd>

A command-line command that allows the system administrator to change the owner
of a file or directory.

</dd><br />
<dt>

#### Community Enterprise Operating System (CentOS)

</dt><br />
<dd>

A Linux distribution derived from the sources of Red Hat Enterprise
Linux (RHEL).[^1]

</dd>
</dl>

<br /><br />

## D

<br />

<dl>
<dt id="doas">

#### `doas`

</dt>
<div align="right"><note place="source"><ref target="chap15">

[⑮📑][]

</ref></note></div>
<dd>

A command-line command that allows a way to perform commands as another user. It
aims to be a a simplified and lightweight replacement for [`sudo`][]. [`doas`][]
is easy to configure and use and suits most use cases.[^15.4] The [`doas`][]
tool was originally developed for OpenBSD as a simpler and safer [`sudo`][]
replacement and was released with OpenBSD 5.8 in October 2015 replacing
[`sudo`][].[^15.1][^15.2]

For a smooth transition from [`sudo`][] to [`doas`][] and to stay downward
compatible, one may add the following to one's own shell environment.[^15.3]

```fish
alias sudo='doas'
alias sudoedit='doas rnano'
```

</dd><br/>
<dt id="docker-image">

#### Docker image

</dt><br />
<dd>

An _image_ is a read-only template with instructions for creating a
Docker container. Often, an image is _based on_ another image, with some
additional customization. For example, you may build an image which is
based on the `ubuntu` image, but installs the Apache web server and your
application, as well as the configuration details needed to make your
application run.[^2]

</dd><br /><br />
<dt id="docker-image-layer">

#### Docker image layer

</dt><br />
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
  /><br />
  <figcaption>From Dockerfile to layers</figcaption>
</figure>
</div><br /><br />

Docker images have _intermediate layers_ that increase reusability,
decrease disk usage, and speed up docker build by allowing each step to
be cached. These intermediate layers are not shown by default.[^4]

Each `RUN` instruction will create a new layer in the resulting image.
Therefore squashing consecutive `RUN` instructions will reduce the layer
count (see https://docs.docker.com/develop/dev-best-practices/). In
addition to that, each `RUN` instruction runs in its own shell, which
can be the source of confusion when part of a `RUN` instruction changes
something about the environment, because these changes may vanish in the
next `RUN` instruction.[^4.1]

</dd>
</dl>

<br /><br />

## E

<br />

<dl>
<dt></dt><br />
<dd>

</dd>
</dl>

<br /><br />

## F

<br />

<dl>
<dt id="facility">
  
#### facility

</dt><br />
<dd>

The type of <mark>event log</mark>ged by [syslog][].

</dd><br />
<dt>

#### Fedora

</dt><br />
<dd>

The upstream source of the commercial Red Hat Enterprise Linux
distribution.[^5]

</dd>
</dl>

<br /><br />

## G

<br />

<dl>
<dt id="getfacl">

#### `getfacl`

</dt>
<div align="right"><note place="source"><ref target="chap15">

[⑮📑][]

</ref></note></div>
<dd>

A command-line command that displays the advanced [access control list (ACL)][]
permission entries for a file or directory.

</dd><br />
<dt id="gid">
  
####  Group Identification Number (GID)

</dt>
<div align="right"><note place="source"><ref target="chap15">

[⑮📑][]

</ref></note></div>
<dd>

A number that is used by Linux to identify groups.

</dd><br />
</dl>

<br /><br />

## H

<br />

<dl>
<dt>
  
#### Hypervisor

</dt><br />
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

<div align="center"><br /><br />
<figure>
  <a href="https://www.researchgate.net/figure/Type-1-and-type-2-hypervisors_fig2_335866538">
  <img src="./img/Type-1-and-type-2-hypervisors.png" alt="Type 1 and type 2 hypervisors"/>
  </a><br />
  <figcaption>Type 1 and type 2 hypervisors</figcaption>
</figure>
</div><br /><br />

</dd>

</dl>

<br /><br />

## I

<br />

<dl>
<dt id="inheritance">
  
#### inheritance

</dt>
<div align="right"><note place="source"><ref target="chap15">

[⑮📑][]

</ref></note></div>

<dd>

The Linux system assigns the [access control list (ACL)][] permissions assigned to a
directory to all files contained within the directory.

</dd><br />
</dl>

<br /><br />

## J

<br />

<dl>
<dt></dt><br />
<dd>

</dd>
</dl>

<br /><br />

## K

<br />

<dl>
<dt></dt><br />
<dd>

</dd>
</dl>

<br /><br />

## L

<br />

<dl>
<dt></dt><br />
<dd>

</dd>
</dl>

<br /><br />

## M

<br />

<dl>
<dt></dt><br />
<dd>

</dd>
</dl>

<br /><br />

## N

<br />

<dl>
<dt></dt><br />
<dd>

</dd>
</dl>

<br /><br />

## O

<br />

<dl>
<dt id="octal-notation">
  
#### octal notation

</dt>
<div align="right"><note place="source"><ref target="chap15">

[⑮📑][]

</ref></note></div>
<dd>

The method of defining standard [Unix file permissions][] of owner, group, and
other using three octal numbers.

</dd><br />
<dt>
  
#### Oracle VM VirtualBox

</dt><br />
<dd>

Runs multiple Linux distributions at the same time, assuming that
hardware has enough resources.

</dd>
</dl>

<br /><br />

## P

<br />

<dl>
<dt></dt><br />
<dd>

</dd>
</dl>

<br /><br />

## Q

<br />

<dl>
<dt></dt><br />
<dd>

</dd>
</dl>

<br /><br />

## R

<br />

<dl>

<section id="rsyslog"><dt>

#### rsyslog <a role="button" aria-expanded="false" tabindex="0" href="#rsyslog" id="rsyslog-ref">⚓</a>

</dt><br />
<div align="right"><note place="source"><ref target="chap17">

[⑰📑][]

</ref></note></div>
<dd>
<dfn>

A faster [`syslog`][] program for Linux.

</dfn>
<details>

<summary>Learn more&hellip;</summary>

The project claims the _r_ stands for _rocket fast_. Speed is
the focus of the rsyslog project and the rsyslog application had quickly
become the standard logging package for many Linux distributions.

It offers high performance, great security features, and a modular design. While
it started as a regular [syslogd][], [rsyslog][] has evolved into a kind of
Swiss army knife of logging, being able to:

- accept inputs from a wide variety of sources
- transform them
- output the results to diverse destinations

Rsyslog has a strong enterprise focus but also scales down to small systems. It
supports, among others, MySQL, PostgreSQL, failover log destinations,
ElasticSearch, syslog/tcp transport, fine grain output format control, high
precision timestamps, queued operations, and the ability to filter on any
message part.[^8]

</details>
</dd>
</section><br />
<section id="rsyslogd"><dt>
  
#### rsyslogd <a role="button" aria-expanded="false" tabindex="0" href="#rsyslogd" id="rsyslogd-ref">⚓</a>
  
</dt>
<div align="right"><note place="source"><ref target="chap17">

[⑰📑][]

</ref></note></div>
<dd>
<dfn>

The SysVinit method of logging events on a server and accepting log events from remote servers.

</dfn>
<details>
<summary>Learn more&hellip;</summary>

The [`rsyslogd`][] daemon also provides extended filtering, encryption-protected
relaying of messages, input and output modules, and support for transportation
using the TCP and UDP protocols.[^9]

See entry for [`/etc/rsyslog.conf`][], which is the main configuration file for
[`rsyslog`][].

</details>
</dd>
</section>
</dl>

<br /><br />

## S

<br />

<dl>

<dt id="security-context">
  
#### security context

</dt>
<div align="right"><note place="source"><ref target="chap15">

[⑮📑][]

</ref></note></div>
<dd>

Used in context-based permissions applications such as SELinux to define a user,
role, and type assigned to a file or directory.

</dd><br />
<dt id="selinux">
  
#### Security-Enhanced Linux (SELinux)

</dt>
<div align="right"><note place="source"><ref target="chap15">

[⑮📑][]

</ref></note></div>
<dd>

An application commonly used on Red Hat-based Linux distributions to implement
context-based permissions.

</dd><br />
<dt id="sgid">
  
####  Set Group ID (SGID) bit

</dt>
<div align="right"><note place="source"><ref target="chap15">

[⑮📑][]

</ref></note></div>

<dd>

A bit set on a directory that forces all files created in the directory to have
the same group assigned as the directory and not that of the user who creates
the file.

</dd><br />
<dt id="suid">
  
#### Set User ID (SUID) bit

</dt>
<div align="right"><note place="source"><ref target="chap15">

[⑮📑][]

</ref></note></div>
<dd>

A bit set on a file that allows standard users the ability to run the file as
the file owner.

</dd><br />
<dt id="setfacl">

#### `setfacl`

</dt>
<div align="right"><note place="source"><ref target="chap15">

[⑮📑][]

</ref></note></div>
<dd>

A command-line command to set the [access control list (ACL)][] permissions for a
file or directory.

</dd><br />
<dt id="severity">
  
#### severity

</dt><br />
<dd>

The importance of <mark>event log</mark>ged by [syslog][].

</dd><br />
<dt id="sticky-bit">
  
#### sticky bit

</dt>
<div align="right"><note place="source"><ref target="chap15">

[⑮📑][]

</ref></note></div>
<dd>

A bit set on a file that prevents users from deleting the file unless they are
the file owner, even if the user is a member of the group that has write
permissions to the file.

</dd><br />
<dt id="su">

#### `su`

</dt>
<div align="right"><note place="source"><ref target="chap15">

[⑮📑][]

</ref></note></div>
<dd>

A command-line command that allows users to run applications as another user
account on the system.

</dd><br/>
<dt id="sudo">

#### `sudo`

</dt>
<div align="right"><note place="source"><ref target="chap15">

[⑮📑][]

</ref></note></div>
<dd>

A command-line command that allows users to run commands with root privileges.

</dd><br/>
<dt id="sudoedit">

#### `sudoedit`

</dt>
<div align="right"><note place="source"><ref target="chap15">

[⑮📑][]

</ref></note></div>
<dd>

A command-line command that opens the specified file in an editor using the root
account privileges.

</dd><br />
<dt id="syslog">
  
#### Syslog

</dt><br />
<dd>

A de facto Unix and Linux protocol for storing event messages.

The syslog protocol has become the de facto standard for most Linux logging
applications. It identifies events using a [facility](#facility) code, which
defines the event type, and a [severity](#severity), which defines how important
the event message is. The [`sysklogd`][], [`syslogd-ng`][], and [`rsyslogd`][]
applications all use the syslog protocol for managing system and application
events in Linux.

</dd><br />
<anchor 𝚡𝚖𝚕:id="syslogd" id="syslogd" />
<anchor 𝚡𝚖𝚕:id="klogd" id="klogd" />
<dt id="sysklogd">
  
#### `sysklogd`

</dt><br />
<dd>

The original [Syslog][] application; includes two programs:

1. [`syslogd`][]: to monitor the system and applications for events
2. [`klogd`][]: to monitor the Linux kernel for events

</dd><br />
<dt id="syslogd-ng">
  
#### `syslogd-ng`

</dt><br />
<dd>

An application that is used to manage log messages and implement centralized
logging where the aim is to collect log messages of several devices on a single
and central log server. This program added advanced features, such as message
filtering and the ability to send messages to remote hosts.

`syslog-ng` is available on a number of different Linux and Unix distributions.
Some install it as the system default, or provide it as a package that replaces
the previous standard syslogd. Several Linux distributions that used `syslog-ng`
have replaced it with [`rsyslog`][].[^7]

</dd><br />
<dt id="systemd">

#### Systemd

</dt>
<dd>

A system and session manager for Linux, compatible with System V and
LSB init scripts.[^10] The main features are:

- provides aggressive parallelization capabilities
- uses socket and D-Bus activation for starting services
- offers on-demand starting of daemons
- keeps track of processes using Linux cgroups
- supports snapshotting and restoring of the system state
- maintains mount and automount points
- implements an elaborate transactional dependency-based service control logic

</dd><br />
<dt id="systemd-journald">

#### `systemd-journald`

</dt>
<dd>

This is part of the [Systemd][] application for system startup and initialization.
Many Linux distributions are now using this for logging. It does not follow the
[syslog][] protocol, but uses a completely different way of reporting and storing
system and application events.

</dd>
</dl>

<br /><br />

## T

<br />

<dl>
<dt></dt><br />
<dd>

</dd>
</dl>

<br /><br />

## U

<br />

<dl>
<dt>﻿﻿
  
#### Ubuntu

</dt><br />
<dd>

An open-source operating system based on the Debian Linux distribution.

</dd><br />
<dt id="unix-access-mode">
  
#### Unix access mode

</dt>
<div align="right"><note place="source"><ref target="chap15">

[⑮📑][]

</ref></note></div>
<dd>

A particular form of access permitted to a file.[^17.2]

</dd><br />
<dt id="unix-file-perms">
  
#### Unix file permissions

</dt>
<div align="right"><note place="source"><ref target="chap15">

[⑮📑][]

</ref></note></div>

<dd>

The base standard POSIX file access control mechanism that uses file permission
bits for the file permission model and is found on almost all Linux and
Unix-like systems nowadays.

</dd><br />
</dl>

<br /><br />

## V

<br />

<dl>
<dt></dt><br />
<dd>

</dd>
</dl>

<br /><br />

## W

<br />

<dl>
<dt></dt><br />
<dd>

</dd>
</dl>

<br /><br />

## X

<br />

<dl>
<dt></dt><br />
<dd>

</dd>
</dl>

<br /><br />

## Y

<br />

<dl>
<dt>
  
#### Yet another Setup Tool (YaST)

</dt><br />
<dd>

An operating system setup and configuration tool unique to openSUSE.
It can be thought of as a command-center utility; allows the control of
many system services from one interface.

</dd>
</dl>

<br /><br />

## Z

<br />

<dl>
<dt></dt><br />
<dd>

</dd>
</dl>

<br /><br />

<!-- BEGIN LINK DEFINITIONS -->

[^1]: https://www.redhat.com/en/topics/linux/what-is-centos
[^2]: https://docs.docker.com/get-started/overview/#images
[^3]: https://docs.docker.com/build/guide/layers/
[^3.7]: https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch03s07.html
[^4]: https://docs.docker.com/engine/reference/commandline/images/#description
[^4.1]: https://app.deepsource.com/directory/analyzers/docker/issues/DOK-W1001
[^5]: https://docs.fedoraproject.org/en-US/quick-docs/fedora-and-red-hat-enterprise-linux/#relationship-between-fedora-and-red-hat-enterprise-linux
[^6]: https://www.vmware.com/topics/glossary/content/hypervisor.html
[^7]: https://en.wikipedia.org/wiki/Syslog-ng#Distributions
[^8]: https://www.rsyslog.com/doc/master/index.html
[^9]: https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/configuring_basic_system_settings/assembly_configuring-a-remote-logging-solution_configuring-basic-system-settings#the-rsyslog-logging-service_assembly_configuring-a-remote-logging-solution
[^10]: https://documentation.suse.com/sles/12-SP5/html/SLES-all/cha-systemd.html#sec-boot-systemd-whatissystemd
[^15.1]: https://en.wikipedia.org/wiki/Doas
[^15.2]: https://wiki.gentoo.org/wiki/Doas
[^15.3]: https://wiki.archlinux.org/title/Doas
[^15.4]: https://why-openbsd.rocks/fact/doas/

[^17.2]: https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_03
[^17.7]: http://www.watson.org/fbsd-hardening/posix1e/acl/

<!-- Glossary Entries -->

[access control list (ACL)]: ./glossary.md#acl
[AppArmor]: ./glossary.md#apparmor
[`doas`]: ./glossary.md#doas

[`chmod`]: ./glossary.md#chmod

[`fstab`]: ./glossary.md#etc-fstab

[`getfacl`]: ./glossary.md#getfacl

[inheritance]: ./glossary.md#inheritance

[Linux ext file systems]: https://ext4.wiki.kernel.org/index.php/Main_Page

[`mtab`]: ./glossary.md#etc-mtab
[`/etc/mtab`]: ./glossary.md#etc-mtab
[`/etc/rsyslog.conf`]: ./glossary.md#etc-rsyslog-conf
[`klogd`]: ./glossary.md#klogd
[`syslog`]: ./glossary.md#syslog
[`syslogd`]: ./glossary.md#syslogd
[`sysklogd`]: ./glossary.md#sysklogd
[`syslogd-ng`]: ./glossary.md#syslogd-ng
[`rsyslog`]: ./glossary.md#rsyslog
[`rsyslogd`]: ./glossary.md#rsyslogd

[Rsyslog]: ./glossary.md#rsyslog
[rsyslogd]: ./glossary.md#rsyslogd

[SELinux]: ./glossary.md#selinux
[`setfacl`]: ./glossary.md#setfacl
[Syslog]: ./glossary.md#syslog
[syslogd]: ./glossary.md#syslogd
[Systemd]: ./glossary.md#systemd

[`su`]: ./glossary.md#su
[`sudo`]: ./glossary.md#sudo
[`sudoedit`]: ./glossary.md#sudoedit

[Unix file permissions]: ./glossary.md#unix-file-perms

<!-- uCertify Chapter Markers -->

<!-- BEGIN LINK DEFINITIONS -->

<!-- uCertify Chapter Markers -->

[⓪📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=1#top "uCertify ch. 0"
[①📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=2#top "uCertify ch. 1"
[②📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=3#top "uCertify ch. 2" 
[③📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=4#top "uCertify ch. 3"
[④📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=5#top "uCertify ch. 4"
[⑤📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=6#top "uCertify ch. 5"
[⑥📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=7#top "uCertify ch. 6"
[⑦📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=8#top "uCertify ch. 7"  
[⑧📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=9#top "uCertify ch. 8"
[⑨📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=10#top "uCertify ch. 9"
[⑩📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=11#top "uCertify ch. 10" 
[⑪📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=12#top "uCertify ch. 11"
[⑫📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=13#top "uCertify ch. 12"
[⑬📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=14#top "uCertify ch. 13"
[⑭📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=15#top "uCertify ch. 14"
[⑮📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=16#top "uCertify ch. 15"  
[⑯📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=17#top "uCertify ch. 16"
[⑰📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=18#top "uCertify ch. 17"
[⑱📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=19#top "uCertify ch. 18"
[⑲📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=20#top "uCertify ch. 19"
[⑳📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=21#top "uCertify ch. 20"
[㉑📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=22#top "uCertify ch. 21"
[㉒📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=23#top "uCertify ch. 22"
[㉓📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=24#top "uCertify ch. 23"
[㉔📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=25#top "uCertify ch. 24"
[㉕📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=26#top "uCertify ch. 25"
[㉖📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=27#top "uCertify ch. 26"
[㉗📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=28#top "uCertify ch. 27"
[㉘📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=29#top "uCertify ch. 28"
[㉙📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=30#top "uCertify ch. 29"
[㉚📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=31#top "uCertify ch. 30"
[㉛📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=32#top "uCertify ch. 31"
[㉜📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=33#top "uCertify ch. 32"
[㉝📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=34#top "uCertify ch. 33"
[㉞📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=35#top "uCertify ch. 34"
[㉟📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=36#top "uCertify ch. 35"
[㊱📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=37#top "uCertify ch. 36"
[㊲📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=38#top "uCertify ch. 37"
[㊳📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=39#top "uCertify ch. 38"
[㊴📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=40#top "uCertify ch. 39"
[㊵📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=41#top "uCertify ch. 40"
[㊶📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=42#top "uCertify ch. 41"
[㊷📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=43#top "uCertify ch. 42"
[㊸📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=44#top "uCertify ch. 43"
[㊹📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=45#top "uCertify ch. 44"
[㊺📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=46#top "uCertify ch. 45"
[㊻📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=47#top "uCertify ch. 46"
[㊼📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=48#top "uCertify ch. 47"
[㊽📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=49#top "uCertify ch. 48"
[㊾📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=50#top "uCertify ch. 49"
[㊿📑]: https://www.ucertify.com/app/?func=ebook&chapter_no=51#top "uCertify ch. 50"

<!-- END LINK DEFINITIONS -->
