FROM bandi13/gui-docker

# install dependencies
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y \
      gcc \
      make \
      nasm \
      software-properties-common \
      ubuntu-drivers-common \
      unzip \
      sudo \
      wget \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# nvidia-driver-440 - distro non-free recommended
# nvidia-driver-435 - distro non-free
# nvidia-driver-390 - distro non-free

# install nv-codec-headers
# RUN cd /tmp \
#   && wget https://github.com/FFmpeg/nv-codec-headers/archive/master.zip \
#   && unzip master.zip \
#   && cd nv-codec-headers-master \
#   && make \
#   && make install

# RUN cd /tmp \
#   && wget https://github.com/FFmpeg/x264/archive/master.zip \
#   && unzip master.zip \
#   && cd x264-master \
#   && ./configure --enable-static \
#   && make \
#   && make install

# compile ffmpeg
# RUN cd /tmp \
#   && wget https://ffmpeg.org/releases/ffmpeg-4.2.3.tar.bz2 \
#   && tar xvf ffmpeg-4.2.3.tar.bz2 \
#   && cd ffmpeg-4.2.3 \
#   && ./configure \
#     --enable-nvenc \
#   && make \
#   && make install
    # --enable-shared \
    # --enable-nonfree \
    # --enable-gpl \
    # --enable-libx264 \

# install obs
# RUN export DEBIAN_FRONTEND=noninteractive \
#     && add-apt-repository ppa:obsproject/obs-studio \
#     && apt-get update \
#     && apt-get install -y obs-studio \
#     && apt-get clean -y \
#     && rm -rf /var/lib/apt/lists/*

COPY Video_Codec_SDK_9.1.23.zip /root/
COPY ffmpeg-build.sh /root/
RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && cd /root \
  && chmod +x ./ffmpeg-build.sh \
  && ./ffmpeg-build.sh --dest /opt/ffmpeg-nvenc --obs

# add OBS to the right-click menu
RUN echo "?package(bash):needs=\"X11\" section=\"DockerCustom\" title=\"OBS Screencast\" command=\"/opt/ffmpeg-nvenc/scripts/obs.sh\"" >> /usr/share/menu/custom-docker && update-menus

# set up stream key and scenes
RUN mkdir -p /root/.config/obs-studio/basic/profiles/Untitled/ /root/.config/obs-studio/basic/scenes/
COPY obs-profile/basic.ini /root/.config/obs-studio/basic/profiles/Untitled
COPY obs-profile/service.json /root/.config/obs-studio/basic/profiles/Untitled
COPY Dashcam_Scenes.linux.json /root/.config/obs-studio/basic/scenes/Untitled.json
#TODO: instead of naming these both Untitled, edit ~/.config/obs-studio/global.ini
