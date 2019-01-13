FROM ubuntu:trusty
LABEL maintainer "Harsh Shandilya <msfjarvis@gmail.com>"

# Install software-properties-common
RUN apt-get update && apt-get install software-properties-common -y

# Add the ubuntu-toolchain PPA
RUN add-apt-repository ppa:ubuntu-toolchain-r/test -y

# Update repos and pull in deps
RUN apt-get update && apt-get install -y \
    git \
    wget \
    curl \
    g++-4.9 \
    automake \
    autoconf \
    autoconf-archive \
    libtool \
    liblz4-dev \
    liblzma-dev \
    make \
    zlib1g-dev \
    binutils-dev \
    libjemalloc-dev \
    libiberty-dev \
    libjsoncpp-dev \
    aria2

# Set C++ compiler
RUN export CXX='g++-4.9'

# Symlink g++-4.9 to /usr/bin/g++
RUN ln -s /usr/bin/g++-4.9 /usr/bin/g++

# Get the damn repo
RUN rm -rf redex && git clone https://github.com/MSF-Jarvis/redex --single-branch --depth 1

# Get the boost library && run ze bild
RUN cd redex && ./get_boost.sh && autoreconf -ivf && ./configure CXX='g++-4.9' && make -j8

# At this point we're about ready to enter
ENTRYPOINT [ "/bin/bash" ]
