#!/bin/bash
clear

#curl -LsSf https://astral.sh/uv/install.sh | sh  <--install uv if missing
uv self update

# Create the virtual environment using Python 3.12 if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python -m venv venv

else
    echo "Virtual environment already exists."
fi

# Activate the virtual environment
source venv/bin/activate
echo "Virtual environment is now active!"

uv pip install --python python3 --upgrade pip

# Install missing dependencies without touching existing packages
echo "Installing requirements..."

uv pip install --python python -r ~/ComfyUI/requirements.txt
uv pip install --python python --upgrade ComfyUI-Manager
uv pip install --python python -r ~/ComfyUI/custom_nodes/ComfyUI-Manager/requirements.txt

#python -m pip uninstall torch torchvision torchaudio -y
uv pip install --python python torch torchvision torchaudio --torch-backend=cu118

#Install ComfyUI-GGUF extension
cd ~/ComfyUI/custom_nodes
git clone https://github.com/Lightricks/ComfyUI-LTXVideo.git
git clone https://github.com/city96/ComfyUI-GGUF.git

uv pip install --python python -r ~/ComfyUI/custom_nodes/ComfyUI-GGUF/requirements.txt
uv pip install --python python -r ~/ComfyUI/custom_nodes/ComfyUI-LTXVideo/requirements.txt


#uv pip install --python python colour gguf opencv-python matrix-nio \
#diffusers matplotlib scikit-image imageio-ffmpeg

#uv pip install --python python comfyui-workflow-templates

# Run ComfyUI
echo "Starting ComfyUI..."
export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True
python main.py --listen 0.0.0.0 --default-device 0 --enable-manager
