FROM my-ffmpeg:latest

# install dependencies
# most of these come from the obs-studio
# install from source instructions
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y \
      build-essential \
      checkinstall \
      cmake \
      fluxbox \
      git \
      libasound2-dev \
      libavcodec-dev \
      libavdevice-dev \
      libavfilter-dev \
      libavformat-dev \
      libavutil-dev \
      libcurl4-openssl-dev \
      libfdk-aac-dev \
      libfontconfig-dev \
      libgl1-mesa-dev \
      libjack-jackd2-dev \
      libjansson-dev \
      libluajit-5.1-dev \
      libmbedtls-dev \
      libnss3-dev \
      libpulse-dev \
      libqt5svg5-dev \
      libqt5svg5-dev\
      libqt5x11extras5-dev \
      libspeexdsp-dev \
      libswresample-dev \
      libswscale-dev \
      libudev-dev \
      libv4l-dev \
      libvlc-dev \
      libx11-dev \
      libx11-xcb-dev \
      libx264-dev \
      libxcb-randr0-dev \
      libxcb-shm0-dev \
      libxcb-xfixes0-dev \
      libxcb-xinerama0-dev \
      libxcb1-dev \
      libxcomposite-dev \
      libxinerama-dev \
      net-tools \
      pkg-config \
      python3-dev \
      qtbase5-dev \
      scrot \
      software-properties-common \
      swig \
      tigervnc-standalone-server \
      ubuntu-drivers-common \
      vim \
      wget \
      xterm \
      zlib1g-dev \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# for the VNC connection
EXPOSE 5900
# for the browser VNC client
# EXPOSE 5901
# Use environment variable to allow custom VNC passwords
ENV VNC_PASSWD=123456

# Install VNC. Requires net-tools, python and python-numpy
# RUN git clone --branch v1.0.0 --single-branch https://github.com/novnc/noVNC.git /opt/noVNC
# RUN git clone --branch v0.8.0 --single-branch https://github.com/novnc/websockify.git /opt/noVNC/utils/websockify
# RUN ln -s /opt/noVNC/vnc.html /opt/noVNC/index.html

# install obs
RUN cd /tmp \
  && git clone https://github.com/obsproject/obs-studio \
  && cd obs-studio \
  && wget https://cdn-fastly.obsproject.com/downloads/cef_binary_3770_linux64.tar.bz2 \
  && tar xjf cef_binary_3770_linux64.tar.bz2 \
  && rm cef_binary_3770_linux64.tar.bz2 \
  && git clone https://github.com/obsproject/obs-browser ./plugins/obs-browser \
  && mkdir -p build \
  && cd build \
  && cmake -DUNIX_STRUCTURE=1 -DBUILD_BROWSER=ON -DCEF_ROOT_DIR="../cef_binary_3770_linux64" .. \
  && make -j2 \
  && make install
  #TODO: possibly add obs-vst?
  # && git clone https://github.com/obsproject/obs-vst ./plugins/obs-vst \

# Add menu entries to the container
RUN echo "?package(bash):needs=\"X11\" section=\"DockerCustom\" title=\"OBS Screencast\" command=\"obs\"" >> /usr/share/menu/custom-docker \
  && echo "?package(bash):needs=\"X11\" section=\"DockerCustom\" title=\"Xterm\" command=\"xterm -ls -bg black -fg white\"" >> /usr/share/menu/custom-docker \
  && update-menus

# set up stream key and scenes
RUN mkdir -p /root/.config/obs-studio/basic/profiles/Untitled/ /root/.config/obs-studio/basic/scenes/
COPY obs-profile/basic.ini /root/.config/obs-studio/basic/profiles/Untitled
COPY obs-profile/service.json /root/.config/obs-studio/basic/profiles/Untitled
COPY Dashcam_Scenes.linux.json /root/.config/obs-studio/basic/scenes/Untitled.json
COPY obs-profile/global.ini /root/.config/obs-studio/global.ini
#TODO: instead of naming these both Untitled, edit ~/.config/obs-studio/global.ini

# Copy various files to their respective places
COPY container_startup.sh /opt/container_startup.sh
COPY x11vnc_entrypoint.sh /opt/x11vnc_entrypoint.sh

# Subsequent images can put their scripts to run at startup here
RUN mkdir /opt/startup_scripts \
  && echo "#!/usr/bin/env bash\nobs --startstreaming" > /opt/startup_scripts/start-obs.sh \
  && chmod +x /opt/startup_scripts/start-obs.sh

ENTRYPOINT ["/opt/container_startup.sh"]
