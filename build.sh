#!/bin/bash
clear

cd ~/ComfyUI || { echo "Directory ComfyUI not found!"; exit 1; }

echo "Pulling latest updates from master..."
git fetch origin --tags
# Check https://github.com/Comfy-Org/ComfyUI/releases for the latest releases and update the version number below
git checkout v0.39.0

cd ~/ComfyUI/custom_nodes/comfyui-manager
git fetch origin --tags
# Check https://github.com/Comfy-Org/ComfyUI-Manager/tags for the latest releases and update the version number below
git checkout 4.3
