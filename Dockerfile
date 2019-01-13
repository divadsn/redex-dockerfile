FROM ubuntu:trusty
LABEL maintainer "Harsh Shandilya <msfjarvis@gmail.com>"

# Set C++ compiler
ENV CXX "g++-4.9"

# Install software-properties-common
RUN apt-get update && apt-get install software-properties-common -y

# Add the ubuntu-toolchain PPA
RUN add-apt-repository ppa:ubuntu-toolchain-r/test -y

# Update repos and pull in deps
RUN apt-get update && apt-get install -y \
    git \
    wget \
    curl \
    $CXX \
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

# Symlink current g++ to /usr/bin/g++
RUN ln -s /usr/bin/$CXX /usr/bin/g++

# Get the damn repo
RUN rm -rf redex && git clone https://github.com/MSF-Jarvis/redex --single-branch --depth 1

# Get the boost library && run ze bild
RUN cd redex && ./get_boost.sh && autoreconf -ivf && ./configure CXX=$CXX && make -j8

# At this point we're about ready to enter
ENTRYPOINT [ "/bin/bash" ]
