# Ethically sourced from official fish-shell/fish-shell project:
# See: https://github.com/fish-shell/fish-shell/blob/HEAD/Dockerfile

FROM centos:centos7@sha256:be65f488b7764ad3638f236b7b515b3678369a5124c47b8d32916d6487418ea4

# Build dependency # skipcq: DOK-W1003
RUN yum update -y \
  && yum install -y epel-release \
  && yum install -y clang cmake3 gcc-c++ make ncurses-devel ShellCheck \
  && yum clean all

# Test dependency # skipcq: DOK-W1003
RUN yum install -y expect vim-common \
  && yum clean all

# ADD . /src
# WORKDIR /src

# Build fish
# RUN cmake3 . &&\
#   make &&\
#   make install

