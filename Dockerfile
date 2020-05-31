# I don't love using snaps, but the ffmpeg/obs snaps
# come with built-in support for GPUs and that makes
# all of this quite simpler
FROM snapcore/snapcraft

ENV SNAPCRAFT_SETUP_CORE 1

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-suggests \
    xubuntu-core \
    tightvncserver \
  && rm -rf /var/lib/apt/lists/*


ENV container docker
ENV PATH "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
RUN apt-get update &&\
 DEBIAN_FRONTEND=noninteractive\
 apt-get install -y snapd snap-confine &&\
 apt-get clean &&\
 dpkg-divert --local --rename --add /sbin/udevadm &&\
 ln -s /bin/true /sbin/udevadm
RUN systemctl enable snapd
VOLUME ["/sys/fs/cgroup"]
STOPSIGNAL SIGRTMIN+3
#CMD ["/sbin/init"]

#RUN systemctl start snapd
RUN snap install ffmpeg obs-studio

# RUN add-apt-repository ppa:obsproject/obs-studio \
#   && apt-get update \
#   && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-suggests \
#     obs-studio \
#   && rm -rf /var/lib/apt/lists/*

RUN touch /root/.Xresources
COPY xstartup /root/.vnc/xstartup
RUN chmod +x /root/.vnc/xstartup

WORKDIR /data

CMD ["bash"]

# expose VNC port
EXPOSE 5901
