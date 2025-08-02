# Drone launching on moving platform

## Getting Started

### Prerequisites

#### Install Docker
> [!NOTE]  
> Follow these [Docker Installation Steps](https://docs.docker.com/engine/install/ubuntu/)

> [!IMPORTANT]  
> Make sure it can run without sudo by following [these steps](https://docs.docker.com/engine/install/linux-postinstall/).

### Clone Repository
Clone this repository using:
```
cd ~/
git clone https://github.com/martinsoteIo/dron_launch.git
```

### Build the Docker Image and Run the Container
Building the Docker Image and running the container from the Dockerfile using Docker Compose is really simple, you just need to run:
```
cd ~/dron_launch/
docker compose build dron_launch
docker compose up -d
docker exec -it dron_launch-dron_launch-1 bash
./setup.sh
```

Once the container is running you can attach any terminal to the container by running:
```
docker exec -it dron_launch-dron_launch-1 bash
```
### Move platform file to PX4-Autopilot models
mv ~/workspace/moving_platform/ ~/workspace/PX4-Autopilot/Tools/simulation/gz/models/moving_platform/

### Launch Moving Platform
cd ~/workspace/ws
colcon build --packages-select moving_platform_description
source install/setup.bash
ros2 launch moving_platform_description moving_platform.launch.py
