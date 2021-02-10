#!/bin/bash

echo "# Running $0.."
export MY_IP=$(ip -4 route get 8.8.8.8 | awk {'print $7'} | tr -d '\n')
TOTAL_MEMORY_KB=$(grep MemTotal /proc/meminfo | awk {'print $2'})
export VIEWER_MEMORY_LIMIT_KB=$(echo "$TOTAL_MEMORY_KB" \* 0.7 | bc)

# Hard code this to latest for now.
export DOCKER_TAG="latest"

if grep -qF "Raspberry Pi 4" /proc/device-tree/model; then
  export DEVICE_TYPE="pi4"
elif grep -qF "Raspberry Pi 3" /proc/device-tree/model; then
  export DEVICE_TYPE="pi3"
elif grep -qF "Raspberry Pi 2" /proc/device-tree/model; then
  export DEVICE_TYPE="pi2"
else
  export DEVICE_TYPE="pi1"
fi

echo -e "\n# Restarting docker service to clear potential errors.." && sudo systemctl restart docker.service
echo -e "\n# Stopping all containers.." && docker container stop $(docker container ls -aq)

echo -e "\n# Running docker compose.."
sudo -E docker-compose \
    -f /home/pi/screenly/docker-compose.yml \
    -f /home/pi/screenly/docker-compose.override.yml \
    pull

sudo -E docker-compose \
    -f /home/pi/screenly/docker-compose.yml \
    -f /home/pi/screenly/docker-compose.override.yml \
    up -d

echo -e "\n# Cleaning up.."
sudo apt-get autoclean
sudo apt-get clean
sudo docker system prune -f
sudo apt autoremove -y

echo -e "\n# Ready to reboot.."
read -p "Reboot now?" -n 1 -r -s REBOOTANS
if [[ "$REBOOTANS" == "y" ]]; then
 sudo reboot;
else
 echo -e "\nReboot aborted, remember to reboot in order for changes to take effect."
fi
