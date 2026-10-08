#!/bin/bash
clear

cd ~/ComfyUI || { echo "Directory ComfyUI not found!"; exit 1; }

echo "Pulling latest updates from master..."
git fetch origin --tags
git checkout v0.39.0

cd ~/ComfyUI/custom_nodes/ComfyMath
git pull

cd ~/ComfyUI/custom_nodes/ComfyUI-Custom-Scripts
git pull

cd ~/ComfyUI/custom_nodes/ComfyUI-Easy-Use
git fetch origin --tags
git checkout v1.4.1

cd ~/ComfyUI/custom_nodes/ComfyUI-GGUF
git pull

cd ~/ComfyUI/custom_nodes/ComfyUI-KJNodes
git pull

cd ~/ComfyUI/custom_nodes/ComfyUI-LTXVideo
git pull

cd ~/ComfyUI/custom_nodes/ComfyUI-Manager
git fetch origin --tags
git checkout 4.3

cd ~/ComfyUI/custom_nodes/ComfyUI-MediaMixer
git pull

cd ~/ComfyUI/custom_nodes/ComfyUI-VideoHelperSuite
git pull

cd ~/ComfyUI/custom_nodes/ComfyUI-mxToolkit
git pull

cd ~/ComfyUI/custom_nodes/rgthree-comfy
git pull
