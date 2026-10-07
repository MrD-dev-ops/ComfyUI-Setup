# ComfyUI-Setup on Proxmox server
## LTX-2.5 setup running Ubuntu 26.04 server LXC
## Nvidia Tesla P40 (24Gb) gpu and GTX 1070 (8Gb) gpu

P40 and GTX 1000 series gpu's run the Architecture 61 cards.  Modern CUDA and NVIDIA drivers no longer support these cards and require older version to work with ComfyUI.
The latest version of Python does not support the older NVIDIA drivers so we need to install Python 3.12.15 for compatibility.

# LXC setup
1) Create a CT/LXC vm on Proxmox.  I have mine with 350Gb disk, 24Gb ram, 30 cpu cores, and a static IP.
2) Start the LXC vm and log into from the shell
```
ssh root@IP_Address
```

# Install GIT
```
sudo apt update && sudo apt install git -y
```

# Git Clone this repo
```
git clone https://github.com/MrD-dev-ops/ComfyUI-Setup.git
```
```
cd ~/ComfyUI-Setup
```
```
chmod +x *.sh
```
```
./install_comfy.sh
```
After the script finishes, reboot the Ubuntu 26.04 server LXC
```
reboot
```




# Install NVIDIA drivers on PROXMOX Host server
1) Download the older version of NVIDIA driver 535.309-01 onto the Proxmox server
```
wget -c https://download.nvidia.com/XFree86/Linux-x86_64/535.309.01/NVIDIA-Linux-x86_64-535.309.01.run
```
```
chmod +x NVIDIA-Linux-x86_64-535.309.01.run
```
```
./NVIDIA-Linux-x86_64-535.309.01.run --dkms -s
```

# Add in the GPU via the passthru on Ubuntu 26.04 server LXC
1) List all detected GPU's on the PROXMOX server
2) Open the Proxmox shell and type:
```
ls -al /dev/nvidia*
```
Should display something similar:
```
ls -al /dev/nvidia*
crw-rw-rw- 1 root root 195,   0 Oct  6 13:39 /dev/nvidia0
crw-rw-rw- 1 root root 195,   1 Oct  6 13:39 /dev/nvidia1
crw-rw-rw- 1 root root 195, 255 Oct  6 13:39 /dev/nvidiactl
crw-rw-rw- 1 root root 237,   0 Oct  6 13:39 /dev/nvidia-uvm
crw-rw-rw- 1 root root 237,   1 Oct  6 13:39 /dev/nvidia-uvm-tools

/dev/nvidia-caps:
total 0
drwxr-xr-x  2 root root     80 Oct  6 13:39 .
drwxr-xr-x 21 root root   4920 Oct  6 13:39 ..
cr--------  1 root root 240, 1 Oct  6 13:39 nvidia-cap1
cr--r--r--  1 root root 240, 2 Oct  6 13:39 nvidia-cap2
```
3) In the Ubuntu 26.04 server LXC click Resources in the menu
4) Click Add button and Device Passthrough from the menu dropdown
5) Copy/Paste these settings into the Device Passthrough
6) Click the Add button
7) Rinse and repeat for each device listed from the "ls -al /dev/nvidia*" command
```
/dev/nvidia0
/dev/nvidia1
/dev/nvidiactl
/dev/nvidia-uvm
/dev/nvidia-uvm-tools
/dev/nvidia-caps/nvidia-cap1
/dev/nvidia-caps/nvidia-cap2
```
Your detected NVIDIA devices may vary from mine depending upon you GPU hardware \
8 ) Reboot the Ubuntu 26.04 server LXC
```
reboot
```

# Start ComfyUI
1) Log into the Ubuntu 26.04 server LXC
2) Run the following command:
```
cd ComfuUI-Setup/
```
```
source start.sh
```



# Install extensions in ComfyUI
Install ComfyUI-GGUF by city96
Install ComfyUI-GGUF-Loader by ChirsColeTech


How to Use the LTX 2.5 All-In-One Workflow in ComfyUI \
https://www.youtube.com/watch?v=v1zOJa95Bo4

LTX 2.5 ComfyUI Setup Guide \
https://ltxworkflow.com/guide/ltx-2-5-comfyui

Install ComfyUI on Linux (Ubuntu 26.04 server) \
https://docs.comfy.org/installation/manual_install
