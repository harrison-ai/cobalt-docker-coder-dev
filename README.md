# cobalt-docker-coder-dev

Base Docker images for Coder development

## 💡 Motivation
Our goal is to provide a base Docker image for the [Coder](https://coder.com/) environment that allows developers to quickly get started with basic prerequisites for ML development.

## 🔧 What’s inside ?

Currently we provide a single image based on [Coder’s “Enterprise Base” Docker image](https://hub.docker.com/r/codercom/enterprise-base), with the following additional tools included:

* Python 3.8
* [AWS CLI](https://aws.amazon.com/cli/)
* [Kubernetes CL tool (`kubectl`)](https://kubernetes.io/docs/reference/kubectl/)
* other useful utilities (`ffmpeg`, `libsm6`, `libxext6`, `direnv`, `net-tools`, `iputils-ping`, `dnsutils`, `iproute2`, `tmux`, `bash-completion`, `zsh`)

## 🚀 Usage

To launch a CLI:

```bash
docker run -it --entrypoint /bin/bash harrisonai/coder-dev:base
```

## 📖 License
This project is licensed under [Apache License 2.0](https://github.com/harrison-ai/cobalt-docker-coder-dev/blob/main/LICENSE).
