# ComfyUI-Setup on Proxmox server
## Running Ubuntu 26.04 server cli LXC
## Nvidia Tesla P40 (24Gb) gpu and GTX 1070 gpu

How to Use the LTX 2.5 All-In-One Workflow in ComfyUI \
https://www.youtube.com/watch?v=v1zOJa95Bo4

LTX 2.5 ComfyUI Setup Guide \
https://ltxworkflow.com/guide/ltx-2-5-comfyui

Install ComfyUI on Linux (Ubuntu 26.04 server) \
https://docs.comfy.org/installation/manual_install

P40 and GTX 1000 series gpu's run the Architecture 61 cards.  Modern CUDA and NVIDIA drivers no longer support these cards and require older version to work with ComfyUI.

```
git clone https://github.com/Comfy-Org/ComfyUI.git
```
