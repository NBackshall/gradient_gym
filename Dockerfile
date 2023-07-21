FROM nvidia/cuda:11.6.0-base-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive

ARG uid
ARG user

RUN \
  apt update && \
  apt install -y \
    sudo \
    python3-pip \
    git \
    zsh

RUN \
  useradd -u ${uid} ${user} && \
  echo "${user} ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/${user} && \
  chmod 0440 /etc/sudoers.d/${user} && \
  mkdir -p /home/${user} && \
  chown ${user}:${user} /home/${user} && \
  chsh -s /usr/bin/zsh ${user}

USER ${user}

RUN \
  cd /home/${user} && \
  git clone https://github.com/NBackshall/dotfiles.git && \
  cd dotfiles && \
  make

WORKDIR /home/${user}

ENTRYPOINT ["/usr/bin/zsh"]
