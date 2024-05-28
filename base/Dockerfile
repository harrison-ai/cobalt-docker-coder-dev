# Pinned to 2023-03-14 version of "ubuntu" tag
FROM codercom/enterprise-base@sha256:991819021919f7e7132f8843f9b49de7c7072e6c4e1e358c6a9d0ba0587f4c87

USER root

RUN sed -i 's#/archive.ubuntu.com#/au.archive.ubuntu.com#g' /etc/apt/sources.list \
    # Adding deadsnakes ppa to install more recent Python versions packaged for Ubuntu.
    && add-apt-repository ppa:deadsnakes/ppa \
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
        jq \
        iproute2 \
        iputils-ping \
        libsm6 \
        libxext6 \
        net-tools \
        openssh-client \
        python3.8 \
        python3.8-venv \
        python3.11 \
        python3.11-venv \
        tmux \
        unzip \
        zsh \
        nano \
        emacs \
        screen \
        # --- NVIDIA based utils ---
        nvtop \
        # --- pyenv dependencies ---
        libssl-dev \
        libbz2-dev \
        libncurses5-dev \
        libffi-dev \
        libreadline-dev \
        libsqlite3-dev \
        liblzma-dev \
        # -x- pyenv dependencies -x-
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

ARG S5CMD_VERSION=2.1.0
RUN curl -L -o "/tmp/s5cmd.tar.gz" "https://github.com/peak/s5cmd/releases/download/v${S5CMD_VERSION}/s5cmd_${S5CMD_VERSION}_Linux-64bit.tar.gz" && \
    tar -xzf /tmp/s5cmd.tar.gz -C /tmp && \
    cp -p /tmp/s5cmd /usr/local/bin && \
    rm -rf /tmp/s5cmd*

ARG RCLONE_VERSION=1.62.2
RUN curl -L -o "/tmp/rclone.zip" "https://github.com/rclone/rclone/releases/download/v${RCLONE_VERSION}/rclone-v${RCLONE_VERSION}-linux-amd64.zip" && \
    unzip /tmp/rclone.zip -d /tmp && \
    cp -p /tmp/rclone-v${RCLONE_VERSION}-linux-amd64/rclone /usr/local/bin && \
    rm -rf /tmp/rclone*

ARG AWS_VERSION=2.7.18
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_VERSION}.zip" -o "/tmp/awscliv2.zip" && \
    unzip -q /tmp/awscliv2.zip -d /tmp && \
    /tmp/aws/install && \
    rm -rf /tmp/aws /tmp/awscliv2.zip

ARG KUBE_VERSION=1.22.12
RUN curl -LO "https://dl.k8s.io/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin

# Workaround issue described here https://github.com/harrison-ai/cobalt-docker-coder-dev/issues/8
# Until Ubuntu upgrade.
RUN curl -L -o "/tmp/sudo.deb" https://github.com/sudo-project/sudo/releases/download/SUDO_1_9_14p3/sudo_1.9.14-4_ubu2004_amd64.deb && \
    dpkg -i /tmp/sudo.deb && \
    rm -rf /tmp/sudo.deb

RUN ssh-keyscan github.com 2>/dev/null > /etc/ssh/ssh_known_hosts

USER coder

WORKDIR /home/coder
