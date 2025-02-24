# Use Python base image
FROM python:3.10-slim

# Install git and other dependencies
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Clone ComfyUI repository
RUN git clone https://github.com/comfyanonymous/ComfyUI.git

# Clone ComfyUI-Manager into custom_nodes directory
WORKDIR /ComfyUI
RUN mkdir -p custom_nodes && \
    cd custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager comfyui-manager

# Install Python dependencies for both ComfyUI and ComfyUI-Manager
WORKDIR /ComfyUI
RUN pip install -r requirements.txt && \
    cd custom_nodes/comfyui-manager && \
    pip install -r requirements.txt

# Create start script
RUN echo '#!/bin/bash\ncd /ComfyUI\npython main.py --listen' > /start.sh
RUN chmod +x /start.sh

# Set the start command
CMD ["/start.sh"]
