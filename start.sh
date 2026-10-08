#!/bin/bash
clear

# uv self update
uv self update

# Create the virtual environment using Python 3.12.15 via uv if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating virtual environment with uv..."
    uv venv --python /root/python/3.12.15/bin/python3 venv
else
    echo "Virtual environment already exists."
fi

# Activate the virtual environment
source venv/bin/activate
echo "Virtual environment is now active!"

uv pip install --upgrade pip

# Install missing dependencies without touching existing packages
echo "Installing requirements..."

uv pip install -r ~/ComfyUI/requirements.txt
uv pip install --upgrade ComfyUI-Manager
uv pip install -r ~/ComfyUI/custom_nodes/ComfyUI-Manager/requirements.txt

uv pip install torch torchvision torchaudio --torch-backend=cu118
uv pip install imageio-ffmpeg

# Install ComfyUI extensions and requirements
cd ~/ComfyUI/custom_nodes
uv pip install -r ~/ComfyUI/custom_nodes/ComfyUI-LTXVideo/requirements.txt
uv pip install -r ~/ComfyUI/custom_nodes/ComfyUI-GGUF/requirements.txt
uv pip install -r ~/ComfyUI/custom_nodes/ComfyMath/requirements.txt
uv pip install -r ~/ComfyUI/custom_nodes/ComfyUI-Easy-Use/requirements.txt
uv pip install -r ~/ComfyUI/custom_nodes/ComfyUI-KJNodes/requirements.txt
uv pip install -r ~/ComfyUI/custom_nodes/ComfyUI-MediaMixer/requirements.txt


uv pip install PyOpenGL-accelerate

# Copy workflow file
#cp All-In-One-Workflow-260820-1.json ~/ComfyUI/user/default/workflows/
cp ~/ComfyUI-Setup/All-In-One-Workflow-260820-1.json ~/ComfyUI/user/default/workflows

cd ~/ComfyUI/models/diffusion_models
wget -c https://huggingface.co/Abiray/LTX-2.5-Distilled-GGUF/resolve/main/LTX-2.5-Distilled-Q3_K_S.gguf

cd ~/ComfyUI/models/loras
wget -c https://huggingface.co/Lightricks/LTX-2-19b-IC-LoRA-Detailer/resolve/main/ltx-2-19b-ic-lora-detailer.safetensors

cd ~/ComfyUI/models/text_encoders
wget -c https://huggingface.co/Comfy-Org/gemma-4/resolve/main/text_encoders/gemma4_e2b_it_bf16.safetensors

cd ~/ComfyUI/models/vae
wget -c https://huggingface.co/Kijai/LTX2.3_comfy/resolve/main/vae/taeltx2_3.safetensors

#Huggingface Log-in Required
#cd ~/ComfyUI/models/diffusion_models
#wget -c https://huggingface.co/Lightricks/LTX-2.5/resolve/main/diffusion_models/ltx-2.5-22b-distilled-transformer-comfy-int8-convrot.safetensors
#cd ~/ComfyUI/models/text_encoders
#wget -c https://huggingface.co/Lightricks/LTX-2.5/resolve/main/text_encoders/gemma4-12b-with-proj-ltx-2.5-comfy-int8-convrot.safetensors
#cd ~/ComfyUI/models/latent_upscale_models
#wget -c https://huggingface.co/Lightricks/LTX-2.5/resolve/main/latent_upscale_models/ltx-2.5-latent-spatial-upscaler-x2-bf16-1.0.safetensors




# Run ComfyUI
cd ~/ComfyUI
echo "Starting ComfyUI..."
export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True
python main.py --listen 0.0.0.0 --default-device 0 --enable-manager



