FROM codercom/example-base:ubuntu-20260223

USER root

RUN sed -i 's#/archive.ubuntu.com#/au.archive.ubuntu.com#g' /etc/apt/sources.list \
    # Adding deadsnakes ppa to install more Python versions packaged for Ubuntu.
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
        libmagic1 \
        libsm6 \
        libxext6 \
        net-tools \
        openssh-client \
        python3.10 \
        python3.10-dev \
        python3.10-venv \
        python3.10-distutils \
        python3.11 \
        python3.11-dev \
        python3.11-venv \
        python3.11-distutils \
        python3.12 \
        python3.12-dev \
        python3.12-venv \
    # utils ---
        tmux \
        unzip \
        zsh \
        nano \
        emacs \
        screen \
        postgresql-client \
        # --- NVIDIA based utils ---
        nvtop \
        # --- infiniband verbs are required for GPU-GPU commms --
        libibverbs1 \
        libibverbs-dev \
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
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# RUN pip install -Uq pip pip-tools
ENV PATH="${PATH}:/home/coder/.local/bin"

ARG S5CMD_VERSION=2.3.0
RUN curl -L -o "/tmp/s5cmd.tar.gz" "https://github.com/peak/s5cmd/releases/download/v${S5CMD_VERSION}/s5cmd_${S5CMD_VERSION}_Linux-64bit.tar.gz" && \
    tar -xzf /tmp/s5cmd.tar.gz -C /tmp && \
    cp -p /tmp/s5cmd /usr/local/bin && \
    rm -rf /tmp/s5cmd*

ARG RCLONE_VERSION=1.73.2
RUN curl -L -o "/tmp/rclone.zip" "https://github.com/rclone/rclone/releases/download/v${RCLONE_VERSION}/rclone-v${RCLONE_VERSION}-linux-amd64.zip" && \
    unzip /tmp/rclone.zip -d /tmp && \
    cp -p /tmp/rclone-v${RCLONE_VERSION}-linux-amd64/rclone /usr/local/bin && \
    rm -rf /tmp/rclone*

ARG AWS_VERSION=2.34.7
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_VERSION}.zip" -o "/tmp/awscliv2.zip" && \
    unzip -q /tmp/awscliv2.zip -d /tmp && \
    /tmp/aws/install && \
    rm -rf /tmp/aws /tmp/awscliv2.zip

ARG KUBE_VERSION=1.35.2
RUN curl -LO "https://dl.k8s.io/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin

# zlib packed in ubuntu is of version 1.12.11,
# while newer versions give faster reads of gz files.
ARG ZLIB_VERSION=1.3.2
RUN curl -L -o "/tmp/zlib.zip" "https://github.com/madler/zlib/releases/download/v${ZLIB_VERSION}/zlib${ZLIB_VERSION//./}.zip" && \
    unzip /tmp/zlib.zip -d /tmp && \
    cd /tmp/zlib-${ZLIB_VERSION} && \
    ./configure && \
    make install && \
    cd / && \
    rm -rf /tmp/zlib*

COPY --from=ghcr.io/astral-sh/uv:0.10.10 /uv /uvx /bin/

RUN ssh-keyscan github.com 2>/dev/null > /etc/ssh/ssh_known_hosts

USER coder

WORKDIR /home/coder
