# [Choice] Ubuntu version (use jammy or bionic on local arm64/Apple Silicon): jammy, focal, bionic
ARG VARIANT="lunar"
FROM --platform=linux/amd64 buildpack-deps:${VARIANT}-curl

# Options for setup script
ARG INSTALL_ZSH="false"
ARG UPGRADE_PACKAGES="true"
ARG USERNAME=vscode
ARG USER_UID=1001
ARG USER_GID=$USER_UID
ARG TARGETARCH="amd64"

ENV APP_TMP_DATA=/tmp
# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
COPY library-scripts/*.sh library-scripts/*.env /tmp/library-scripts/

# First adds the architecture to the system. This is necessary for the Docker image to be built on right architecture.
RUN yes | unminimize 2>&1 \
  && dpkg --add-architecture ${TARGETARCH} \
  && export DEBIAN_FRONTEND=noninteractive \
  && /bin/bash /tmp/library-scripts/common-debian.sh "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" \
  && /bin/bash /tmp/library-scripts/fish-debian.sh "true" "${USERNAME}" \
  && /bin/bash /tmp/library-scripts/sshd-debian.sh "2222" "${USERNAME}" "true" "root" \
  && /bin/bash /tmp/library-scripts/github-debian.sh "${USERNAME}" \
  && /bin/bash /tmp/library-scripts/ruby-debian.sh "3.2.2" "${USERNAME}" \
  #
  #
  # ****************************************************************************
  # * TODO: Add any additional OS packages you want included in the definition *
  # * here. We want to do this before cleanup to keep the "layer" small.       *
  # ****************************************************************************
  # && apt-get -y install --no-install-recommends <your-package-list-here> \
  && apt-get autoremove -y && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/* /tmp/library-scripts

# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends autoconf bison patch build-essential default-jre cmake pkg-config libc6:${TARGETARCH} libicu-dev rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libcurl4-openssl-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN echo "StreamLocalBindUnlink yes" >> /etc/ssh/sshd_config && \
  systemctl --global mask gpg-agent.service \
  gpg-agent.socket gpg-agent-ssh.socket \
  gpg-agent-extra.socket gpg-agent-browser.socket && \
  systemctl enable ssh

# Set up default fish config.
RUN su ${USERNAME} -c "fish --command 'cp /usr/share/fish/config.fish ~/.config/fish/'"

# Configure default Git editor.
RUN su ${USERNAME} -c "echo 'set -Ux GIT_EDITOR vim' >> ~/.config/fish/config.fish"

# Install Fisher and plugins.
RUN su ${USERNAME} -c "fish --command 'curl -sL https://git.io/fisher | source && fisher install jorgebucaran/{fisher,nvm.fish}'"

# ENV Variables required by Jekyll.
ENV LANG=en_US.UTF-8 \
  LANGUAGE=en_US:en \
  TZ=Etc/UTC \
  LC_ALL=en_US.UTF-8 \
  LANG=en_US.UTF-8 \
  LANGUAGE=en_US

USER ${USERNAME}
ENTRYPOINT ["/usr/local/share/ssh-init.sh"]
CMD ["sleep", "infinity"]
