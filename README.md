# OBS Dockerfile

This repo represents the research I did while trying to get OBS running inside Docker.

If you want to use it, you might need to make some adjustments for your own purposes.

I stopped developing this repo at the first moment I had OBS successfully running in Docker, and at that point moved development over to my primary codebase: https://github.com/dmerrick/tripbot (exact PR: https://github.com/dmerrick/tripbot/pull/24).


### Running
```bash
build.sh
run.sh
ssh.sh
```

### Adapted from
* https://github.com/amitsudharshan/xubuntu-desktop-docker
* https://github.com/bandi13/gui-docker
   * for the VNC setup
* https://github.com/bandi13/gui-obs
   * for inspiration
* https://github.com/jrottenberg/ffmpeg
   * for a copy of `ffmpeg` with nvenc built in
   * I had to rebuild this with a version of Freetype that matches the one in apt

### Worth reading
* https://www.nvidia.com/en-us/geforce/guides/broadcasting-guide/
* https://obsproject.com/wiki/General-Performance-and-Encoding-Issues
