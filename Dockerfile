FROM ubuntu

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-suggests \
    ffmpeg \
    xubuntu-core \
    tightvncserver \
  && rm -rf /var/lib/apt/lists/*


# xfce4-goodies?

RUN add-apt-repository ppa:obsproject/obs-studio \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-suggests \
    obs-studio \
  && rm -rf /var/lib/apt/lists/*

RUN touch /root/.Xresources
COPY vnc/xstartup /root/.vnc/xstartup
RUN chmod +x /root/.vnc/xstartup
#COPY vnc/passwd /root/.vnc/passwd
RUN printf "password\npassword\n\n" | vncpasswd



WORKDIR /data
CMD ["bash"]

# expose VNC port
EXPOSE 5901
