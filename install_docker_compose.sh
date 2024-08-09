# install_docker_compose.sh
#!/bin/bash

# 替换成正确的版本号
VERSION="v2.0.1"

# Step 1: Download Docker Compose
curl -L "https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-darwin-aarch64" -o ~/docker-compose

# Step 2: Make Docker Compose executable
chmod +x ~/docker-compose

# Step 3: Move Docker Compose to a directory in your PATH
sudo mv ~/docker-compose /usr/local/bin/docker-compose

# Step 4: Verify the installation
docker-compose --version
