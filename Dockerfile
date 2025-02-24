# Use Python base image
FROM python:3.10-slim

# Install git and other dependencies
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Clone ComfyUI repository
RUN git clone https://github.com/comfyanonymous/ComfyUI.git

# Install Python dependencies
WORKDIR /ComfyUI
RUN pip install -r requirements.txt

# Create start script
RUN echo '#!/bin/bash\ncd /ComfyUI\npython main.py' > /start.sh
RUN chmod +x /start.sh

# Set the start command
CMD ["/start.sh"]
