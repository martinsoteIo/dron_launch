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
cd ~/rl_bouncer/
docker compose build dron_launch
docker compose up -d
docker exec -it dron_launch-dron_launch-1 bash
./setup.sh
```

Once the container is running you can attach any terminal to the container by running:
```
docker exec -it dron_launch-dron_launch-1 bash
```