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
```
PermitRootLogin yes
PasswordAuthentication yes
```
2) Press CTRL-o to save
3) Press CTRL-x to exit nano
4) Restart ssh service
```
sudo systemctl restart ssh
```
5) Run this command in the console and the ssh service should show running
```
sudo systemctl status ssh
```
6) Log into the Ubuntu 26.04 server via SSH

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

# Install NVIDIA drivers on Ubuntu 26.04 server LXC
1) Start the ComfyUI LXC vm and log in via SSH
2) Download the NVIDIA drivers
```
wget -c https://download.nvidia.com/XFree86/Linux-x86_64/535.309.01/NVIDIA-Linux-x86_64-535.309.01.run
```
```
chmod +x NVIDIA-Linux-x86_64-535.309.01.run
```
```
./NVIDIA-Linux-x86_64-535.309.01.run --no-kernel-modules -s
```
3) Reboot the PROXMOX server (which will also reboot the Ubuntu 26.04 server LXC)

# Add in the GPU via the passthru
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
Your detected NVIDIA devices may vary from mine depending upon you GPU hardware

8) Reboot the Ubuntu 26.04 server LXC
9) Log into the LXC via SSH
10) Type the following command into the LXC terminal to check of the GPU(s) are detected
```
nvidia-smi
```
Should see something like this in the terminal
```
nvidia-smi
Tue Oct  6 19:55:52 2026       
+---------------------------------------------------------------------------------------+
| NVIDIA-SMI 535.309.01             Driver Version: 535.309.01   CUDA Version: 12.2     |
|-----------------------------------------+----------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |         Memory-Usage | GPU-Util  Compute M. |
|                                         |                      |               MIG M. |
|=========================================+======================+======================|
|   0  NVIDIA GeForce GTX 1070        On  | 00000000:04:00.0 Off |                  N/A |
|  0%   36C    P8              12W / 180W |      0MiB /  8192MiB |      0%      Default |
|                                         |                      |                  N/A |
+-----------------------------------------+----------------------+----------------------+
|   1  Tesla P40                      On  | 00000000:84:00.0 Off |                    0 |
| N/A   21C    P8              10W / 250W |      0MiB / 23040MiB |      0%      Default |
|                                         |                      |                  N/A |
+-----------------------------------------+----------------------+----------------------+
                                                                                         
+---------------------------------------------------------------------------------------+
| Processes:                                                                            |
|  GPU   GI   CI        PID   Type   Process name                            GPU Memory |
|        ID   ID                                                             Usage      |
|=======================================================================================|
|  No running processes found                                                           |
+---------------------------------------------------------------------------------------+
```
# Install GIT & Curl
```
sudo apt update && sudo apt install git curl -y
```
# Install ComfyUI
https://github.com/comfy-org/comfyui \
https://docs.comfy.org/installation/manual_install#linux
```
git clone https://github.com/Comfy-Org/ComfyUI.git
```
# Install UV
```
curl -LsSf https://astral.sh/uv/install.sh | sh
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
