# ComfyUI-Setup on Proxmox server
## Running Ubuntu 26.04 server LXC
## Nvidia Tesla P40 (24Gb) gpu and GTX 1070 (8Gb) gpu

P40 and GTX 1000 series gpu's run the Architecture 61 cards.  Modern CUDA and NVIDIA drivers no longer support these cards and require older version to work with ComfyUI.
The latest version of Python does not support the older NVIDIA drivers so we need to install Python 3.12.15 for compatibility.

# LXC setup
1) Create a LXC vm on Proxmox.  I have mine with 350Gb disk, 24Gb ram, 30 cpu cores, and a static IP.

# Update Ubuntu 26.04 server
1) Copy the update.sh and type in the Ubuntu 26.04 console:
```
nano update.sh
```
2) Paste the update.sh text into the text editor using CTRL-SHIFT-V
3) Press CTRL-o to save
4) Press CTRL-x to exit the nano text editor
5) Make the update.sh executable
```
chmod +x update.sh
```
7) In the Proxmox console run and install all updates
```
./update.sh
```
7) Reboot the Ubuntu 26.04 server
```
reboot
```

### Optional -UFW firewall setup
1) On the Ubuntu 26.04 server LXC log into the console and type:
```
sudo ufw allow ssh && sudo ufw allow 8188/tcp
```
```
sudo ufw enable
```
```
sudo ufw status verbose
```
# Install SSH server
```
apt update && apt install openssh-server -y
```
```
sudo nano /etc/ssh/sshd_config
```
### Allow ssh root logins and password logins
1) Copy/Paste this into the nano text edit
2) Press CTRL-o to save
3) Press CTRL-x to exit nano
```
PermitRootLogin yes
PasswordAuthentication yes
```
4) Restart ssh service
```
sudo systemctl restart ssh
```

5) Run this command in the console and the ssh service should show running
```
sudo systemctl status ssh
```
# Install NVIDIA drivers on Proxmox server
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
4) Start the ComfyUI LXC vm











Add in the GPU via the passthru
List all detected GPU's

```
ls -al /dev/nvidia*
```






```
git clone https://github.com/Comfy-Org/ComfyUI.git
```

# Python 3.12.15 compile from source
Download Python:
```
mkdir python3.12
cd python3.12
```
```
wget -c https://www.python.org/ftp/python/3.12.15/Python-3.12.15.tar.xz
```
```
tar -xf Python-3.12.15.tar.xz
```


https://www.build-python-from-source.com/?v=3.12.15&os=ubuntu&path=1&verify=1





# Install extensions in ComfyUI
Install ComfyUI-GGUF by city96
Install ComfyUI-GGUF-Loader by ChirsColeTech






How to Use the LTX 2.5 All-In-One Workflow in ComfyUI \
https://www.youtube.com/watch?v=v1zOJa95Bo4

LTX 2.5 ComfyUI Setup Guide \
https://ltxworkflow.com/guide/ltx-2-5-comfyui

Install ComfyUI on Linux (Ubuntu 26.04 server) \
https://docs.comfy.org/installation/manual_install
