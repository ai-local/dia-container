FROM quay.io/centos/centos:stream9

# Enable EPEL and rpm-fusion-free (needed for ffmpeg package)
RUN dnf config-manager --set-enabled crb
RUN dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-$(rpm -E %rhel).noarch.rpm https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-$(rpm -E %rhel).noarch.rpm

RUN dnf install -y git python3.12 python3.12-pip ffmpeg

RUN git clone https://github.com/nari-labs/dia.git
WORKDIR /dia

RUN pip3.12 install -e .

# Download the model files in to the container
RUN sed '/Launch the App/Q' app.py > download.py
RUN python3.12 download.py

# This is running in a container, listen on 0.0.0.0 to enable communication outside the container
ENV GRADIO_SERVER_NAME=0.0.0.0

EXPOSE 7680
CMD ["python3.12", "app.py"]

# If running rootless Podman, enable the container_use_devices SELinux boolean:  sudo setsebool -P container_use_devices=true
# Build with:  podman build --device nvidia.com/gpu=all . -t dia-speech
# Run with:  podman run --rm --device nvidia.com/gpu=all --name dia-speech -p 7860:7860 dia-speech
