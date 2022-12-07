# Pinned to 2022-11-12 version of "ubuntu" tag
FROM codercom/enterprise-base@sha256:f58cce5a5c00dca76e53a54aab3eea0fcac3be9875fd0b9bda1d8e16f6bf5c22

USER root

RUN sed -i 's#/archive.ubuntu.com#/au.archive.ubuntu.com#g' /etc/apt/sources.list \
    && apt-get update \
    && apt-get install --no-install-recommends -y \
        apt-utils \
        bash-completion \
        ca-certificates \
        curl \
        dialog \
        direnv \
        dnsutils \
        ffmpeg \
        git \
        iproute2 \
        iputils-ping \
        libsm6 \
        libxext6 \
        net-tools \
        openssh-client \
        python3.8 \
        python3.8-venv \
        tmux \
        unzip \
        zsh \
        nano \
        emacs \
    && apt-get upgrade -y \
    && yes | unminimize \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen \
    && update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN pip install -Uq pip pip-tools
ENV PATH="${PATH}:/home/coder/.local/bin"

ARG AWS_VERSION=2.7.18
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_VERSION}.zip" -o "/tmp/awscliv2.zip" && \
    unzip -q /tmp/awscliv2.zip -d /tmp && \
    /tmp/aws/install && \
    rm -rf /tmp/aws /tmp/awscliv2.zip

ARG KUBE_VERSION=1.22.12
RUN curl -LO "https://dl.k8s.io/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin

RUN ssh-keyscan github.com 2>/dev/null > /etc/ssh/ssh_known_hosts

USER coder
WORKDIR /home/coder
