This repository contains a Containerfile to build and run a container with the Dia text to speech model (https://github.com/nari-labs/dia)

For use with an NVIDIA GPU with the NVIDIA container toolkit installed and configured for use with Podman.

Clone this repository: `git clone https://github.com/ai-local/dia-container.git`

If running rootless Podman, enable the container_use_devices SELinux boolean: `sudo setsebool -P container_use_devices=true`

Build container with:  `podman build --device nvidia.com/gpu=all . -t dia-speech`

Run container with:  `podman run --rm --device nvidia.com/gpu=all --name dia-speech -p 7860:7860 dia-speech`

Then use a web browser to connect to port 7860 to access the Gradio web interface
