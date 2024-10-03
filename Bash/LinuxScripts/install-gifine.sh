sudo apt install ffmpeg graphicsmagick gifsicle luarocks cmake \
compiz gengetopt slop libxext-dev libimlib2-dev mesa-utils \
libxrender-dev glew-utils libglm-dev libglu1-mesa-dev \
libglew-dev libxrandr-dev libgirepository1.0-dev
sudo luarocks install lgi && \
sudo luarocks install --server=http://luarocks.org/dev gifine && \
gifine
