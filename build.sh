#!/bin/bash
clear

cd ~/ComfyUI || { echo "Directory ComfyUI not found!"; exit 1; }

echo "Pulling latest updates from master..."
git fetch origin --tags
# Check https://github.com/Comfy-Org/ComfyUI/releases for the latest releases and update the version number below
git checkout v0.39.0

cd ~/ComfyUI/custom_nodes/ComfyMath

cd ~/ComfyUI/custom_nodes/ComfyUI-Custom-Scripts

cd ~/ComfyUI/custom_nodes/ComfyUI-Easy-Use

cd ~/ComfyUI/custom_nodes/ComfyUI-GGUF

cd ~/ComfyUI/custom_nodes/ComfyUI-KJNodes

cd ~/ComfyUI/custom_nodes/ComfyUI-LTXVideo
git pull

cd ~/ComfyUI/custom_nodes/ComfyUI-Manager
git fetch origin --tags
git checkout 4.3

cd ~/ComfyUI/custom_nodes/ComfyUI-MediaMixer

cd ~/ComfyUI/custom_nodes/ComfyUI-VideoHelperSuite

cd ~/ComfyUI/custom_nodes/ComfyUI-mxToolkit

cd ~/ComfyUI/custom_nodes/rgthree-comfy
