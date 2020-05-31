FROM bandi13/gui-docker

# install OBS
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y software-properties-common \
    && add-apt-repository ppa:obsproject/obs-studio \
    && apt-get update \
    && apt-get install -y \
      ubuntu-drivers-common \
      nvidia-driver-390 \
      obs-studio \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# add OBS to the right-click menu
RUN echo "?package(bash):needs=\"X11\" section=\"DockerCustom\" title=\"OBS Screencast\" command=\"obs\"" >> /usr/share/menu/custom-docker && update-menus

# set up stream key and scenes
RUN mkdir -p /root/.config/obs-studio/basic/profiles/Untitled/ /root/.config/obs-studio/basic/scenes/
COPY obs-profile/basic.ini /root/.config/obs-studio/basic/profiles/Untitled
COPY obs-profile/service.json /root/.config/obs-studio/basic/profiles/Untitled
COPY Dashcam_Scenes.linux.json /root/.config/obs-studio/basic/scenes/Untitled.json
#TODO: instead of naming these both Untitled, edit ~/.config/obs-studio/global.ini
