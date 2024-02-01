# Ethically sourced from official fish-shell/fish-shell project:
# See: https://github.com/fish-shell/fish-shell/blob/HEAD/Dockerfile

FROM centos:centos7

# Build dependency
RUN yum update -y \
  && yum install -y epel-release \
  && yum install -y clang cmake3 gcc-c++ make ncurses-devel \
  && yum clean all

# Test dependency
RUN yum install -y expect vim-common

# ADD . /src
# WORKDIR /src

# Build fish
# RUN cmake3 . &&\
#   make &&\
#   make install

