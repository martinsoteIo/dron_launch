#!/bin/bash
set -e

# Colores para la salida
CYAN='\033[0;36m'
DARK_CYAN='\033[1;36m'
RED='\033[0;31m'
NC='\033[0m' # Sin color
LINE="======================================================================="

cd ~/workspace

echo -e "${DARK_CYAN}${LINE}\n[SETUP.SH] 🧹 Limpiando conflictos previos de setuptools y jaraco\n${LINE}${NC}"
rm -rf ~/.local/lib/python3.10/site-packages/setuptools*
rm -rf ~/.local/lib/python3.10/site-packages/jaraco*

echo -e "${DARK_CYAN}${LINE}\n[SETUP.SH] 🔁 Reinstalando python3-setuptools del sistema\n${LINE}${NC}"
sudo apt update
sudo apt install --reinstall -y python3-setuptools

echo -e "${DARK_CYAN}${LINE}\n[SETUP.SH] ⬇ Instalando setuptools seguro (v79.0.0)\n${LINE}${NC}"
pip install --user setuptools==79.0.0

echo -e "${DARK_CYAN}${LINE}\n[SETUP.SH] 🐍 Instalando dependencias Python\n${LINE}${NC}"
pip install --user -U empy==3.3.4 pyros-genmsg

echo -e "${DARK_CYAN}${LINE}\n[SETUP.SH] ⚙ Instalando dependencias del sistema\n${LINE}${NC}"
sudo apt install -y ros-humble-rmw-cyclonedds-cpp libgflags-dev fuse libfuse2

# echo -e "${DARK_CYAN}${LINE}\n[SETUP] --- INSTALAR PX4\n${LINE}${NC}"
# git clone https://github.com/PX4/PX4-Autopilot.git --recursive
# bash PX4-Autopilot/Tools/setup/ubuntu.sh
# cd PX4-Autopilot/
# make px4_sitl
# cd ..

echo -e "${DARK_CYAN}${LINE}\n[SETUP] --- INSTALAR QGroundControl\n${LINE}${NC}"
export USER=${USER:-admin}
sudo usermod -a -G dialout ${USER:-admin}
sudo apt-get remove modemmanager -y
sudo apt install gstreamer1.0-plugins-bad gstreamer1.0-libav gstreamer1.0-gl -y
sudo apt install libfuse2 -y
sudo apt install libxcb-xinerama0 libxkbcommon-x11-0 libxcb-cursor-dev -y
wget https://github.com/mavlink/qgroundcontrol/releases/download/v4.4.4/QGroundControl.AppImage -O QGroundControl.AppImage
chmod +x QGroundControl.AppImage

echo -e "${DARK_CYAN}${LINE}\n[SETUP] --- INSTALAR MAVSDK-Python\n${LINE}${NC}"
pip3 install --user mavsdk
git clone https://github.com/mavlink/MAVSDK-Python.git

echo -e "${DARK_CYAN}${LINE}\n[SETUP] --- INSTALAR ROS2\n${LINE}${NC}"
sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8
sudo apt install software-properties-common
sudo add-apt-repository universe
sudo apt update && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
sudo apt update && sudo apt upgrade -y
sudo apt install ros-humble-desktop
sudo apt install ros-dev-tools
source /opt/ros/humble/setup.bash && echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
pip install --user -U empy==3.3.4 pyros-genmsg

echo -e "${DARK_CYAN}${LINE}\n[SETUP] --- INSTALAR Micro XRCE-DDS Agent & Client\n${LINE}${NC}"
git clone -b v2.4.2 https://github.com/eProsima/Micro-XRCE-DDS-Agent.git
cd Micro-XRCE-DDS-Agent
mkdir build
cd build
cmake ..

echo -e "${DARK_CYAN}${LINE}\n[SETUP] 🔧 Corrigiendo versión en fastdds-gitclone.cmake...\n${LINE}${NC}"
FASTDDS_PATCH_FILE="fastdds/tmp/fastdds-gitclone.cmake"
if [ -f "$FASTDDS_PATCH_FILE" ]; then
  sed -i 's/2\.12\.x/v2.12.2/g' "$FASTDDS_PATCH_FILE"
else
  echo -e "${RED}[WARN] No se encontró $FASTDDS_PATCH_FILE. ¿La estructura de CMake cambió?${NC}"
fi

make
sudo make install
sudo ldconfig /usr/local/lib
cd ~/workspace

# echo -e "${DARK_CYAN}${LINE}\n[SETUP] --- INSTALAR px4_msgs\n${LINE}${NC}"
# mkdir -p ws_sensor_combined/src
# cd ws_sensor_combined/src
# git clone https://github.com/PX4/px4_msgs.git
# git clone https://github.com/PX4/px4_ros_com.git
# cd ..
# source /opt/ros/humble/setup.bash
# colcon build
# cd ~/workspace

# echo -e "${DARK_CYAN}${LINE}\n[SETUP] --- INSTALAR ros_gz\n${LINE}${NC}"
# export GZ_VERSION=harmonic
# mkdir -p ws/src
# cd ws/src
# git clone https://github.com/gazebosim/ros_gz.git -b humble
# cd ~/workspace/ws
# rosdep install -r --from-paths src -i -y --rosdistro humble
# source /opt/ros/humble/setup.bash
# colcon build
# cd ~/workspace

# echo -e "${DARK_CYAN}${LINE}\n[SETUP] --- CREAR ENTORNO VIRTUAL\n${LINE}${NC}"
# python3 -m venv simulacion

# echo -e "${DARK_CYAN}${LINE}\n[SETUP] --- INSTALAR dependencias Python (aisladas)\n${LINE}${NC}"
# pip install opencv-python torch torchvision torchaudio "numpy<2.0" timm mavsdk

echo -e "${DARK_CYAN}${LINE}\n[SETUP] ✅ Todo listo."

