#!/bin/bash
clear

cd ~/ComfyUI || { echo "Directory ComfyUI not found!"; exit 1; }

echo "Pulling latest updates from master..."
#git fetch --all --tags
git fetch origin --tags
git checkout v0.39.0

cd ~/ComfyUI/custom_nodes/comfyui-manager
#git fetch --all --tags
git fetch origin --tags
git checkout 4.3
