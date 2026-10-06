#!/bin/bash
clear

#curl -LsSf https://astral.sh/uv/install.sh | sh  <--install uv if missing
uv self update

# 1. Create the virtual environment using Python 3.12 if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python -m venv venv

else
    echo "Virtual environment already exists."
fi

# 2. Activate the virtual environment
source venv/bin/activate
echo "Virtual environment is now active!"

uv pip install --python python3.12 --upgrade pip

# 3. Enter the ComfyUI directory
cd ~/ComfyUI

# 4. Install missing dependencies without touching existing packages
echo "Installing requirements..."

uv pip install --python python --upgrade ComfyUI
uv pip install --python python -r ~/ComfyUI/requirements.txt
uv pip install --python python --upgrade ComfyUI-Manager
uv pip install --python python -r ~/ComfyUI/custom_nodes/ComfyUI-Manager/requirements.txt

#python -m pip uninstall torch torchvision torchaudio -y
uv pip install --python python torch torchvision torchaudio --torch-backend=cu118

uv pip install --python python colour gguf opencv-python matrix-nio \
diffusers matplotlib scikit-image imageio-ffmpeg

#uv pip install --python python comfyui-workflow-templates

#5. Run ComfyUI
echo "Starting ComfyUI..."
export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True
python3.12 main.py --listen 0.0.0.0 --default-device 0 --enable-manager
