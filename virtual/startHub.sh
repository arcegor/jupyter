#!/bin/bash

apt-get update

apt install -yq --no-install-recommends \
    build-essential \
    ca-certificates \
    locales \
    python3-dev \
    python3-pip \
    python3-venv \
    nodejs \
    npm \

npm install -g configurable-http-proxy@^4.2.0 \
 && rm -rf ~/.npm

python3 -m venv jupyter

source jupyter/bin/activate

python3 -m pip install jupyterhub notebook

rm -f  jupyterhub_cookie_secret

jupyterhub