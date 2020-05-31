FROM ubuntu

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-suggests \
    xubuntu-core \
    tightvncserver \
  && rm -rf /var/lib/apt/lists/*

RUN add-apt-repository ppa:obsproject/obs-studio \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-suggests \
    obs-studio \
  && rm -rf /var/lib/apt/lists/*

RUN touch /root/.Xresources
COPY xstartup /root/.vnc/xstartup
RUN chmod +x /root/.vnc/xstartup

WORKDIR /data

CMD ["bash"]

# expose VNC port
EXPOSE 5901
