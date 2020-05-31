FROM bandi13/gui-docker

# install OBS
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y software-properties-common \
    && add-apt-repository ppa:obsproject/obs-studio \
    && apt-get update \
    && apt-get install -y \
      ubuntu-drivers-common \
      obs-studio \
      wget \
      nasm \
      make \
      gcc \
      unzip \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# nvidia-driver-440 - distro non-free recommended
# nvidia-driver-435 - distro non-free
# nvidia-driver-390 - distro non-free

RUN cd /tmp \
  && wget https://github.com/FFmpeg/nv-codec-headers/archive/master.zip \
  && unzip master.zip \
  && cd nv-codec-headers-master \
  && make \
  && make install

RUN cd /tmp \
  && wget https://ffmpeg.org/releases/ffmpeg-4.2.3.tar.bz2 \
  && tar xvf ffmpeg-4.2.3.tar.bz2 \
  && cd ffmpeg-4.2.3 \
  && ./configure \
    --enable-nvenc \
    --enable-nonfree \
    --enable-gpl \
    --enable-shared \
    --enable-libx264 \
  && make \
  && make install

# add OBS to the right-click menu
RUN echo "?package(bash):needs=\"X11\" section=\"DockerCustom\" title=\"OBS Screencast\" command=\"obs\"" >> /usr/share/menu/custom-docker && update-menus

# set up stream key and scenes
RUN mkdir -p /root/.config/obs-studio/basic/profiles/Untitled/ /root/.config/obs-studio/basic/scenes/
COPY obs-profile/basic.ini /root/.config/obs-studio/basic/profiles/Untitled
COPY obs-profile/service.json /root/.config/obs-studio/basic/profiles/Untitled
COPY Dashcam_Scenes.linux.json /root/.config/obs-studio/basic/scenes/Untitled.json
#TODO: instead of naming these both Untitled, edit ~/.config/obs-studio/global.ini
