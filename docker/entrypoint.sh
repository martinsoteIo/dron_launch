#!/bin/bash
set -e

# Source ROS 2 installation
source /opt/ros/${ROS_DISTRO}/setup.bash

if [ "$(stat -c '%u' /home/admin/workspace)" = "0" ]; then
  echo "🛠 Fixing ownership of /home/admin/workspace to $(id -u):$(id -g)"
  sudo chown -R $(id -u):$(id -g) /home/admin/workspace
fi

# Copy setup.sh to workspace if needed
if [ ! -f "/home/admin/workspace/setup.sh" ]; then
    cp /home/admin/scripts/setup.sh /home/admin/workspace/setup.sh
    chmod +x /home/admin/workspace/setup.sh
fi

exec "$@"
