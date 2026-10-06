#!/bin/bash
clear
#Install latest security updates
sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y \
&& sudo apt autoremove -y && sudo apt clean && sudo apt autoclean

#Install packages required to build python3.12.15
sudo apt update && sudo apt install -y build-essential pkg-config wget xz-utils libssl-dev zlib1g-dev \
libbz2-dev liblzma-dev libffi-dev libsqlite3-dev libreadline-dev libncurses-dev tk-dev uuid-dev libgdbm-dev libgdbm-compat-dev libzstd-dev
