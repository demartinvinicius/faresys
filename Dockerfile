#This docker file implements a Blender System - Headless
#This blender system will be used to render video files faster using the Fargate service from AWS
#Starting from a Ubuntu distribuition
FROM ubuntu

#These evenrioment variables are used to determine the blender version to be used.
#It may be changed by the Fargate System
ENV BLENDER_MAJOR 2.83
ENV BLENDER_VERSION 2.83.1
ENV BLENDER_URL https://download.blender.org/release/Blender${BLENDER_MAJOR}/blender-${BLENDER_VERSION}-linux64.tar.xz

#Install the basic components to run blender on ubuntu
RUN apt-get update && apt-get install -y \
    curl \
    xz-utils \
    libgl1-mesa-dev \
    libxi6 \
    libxrender1

#Download and install blender
RUN mkdir /usr/local/blender && \
	curl -sL ${BLENDER_URL} -o blender.tar.xz && \
    tar -xf blender.tar.xz -C /usr/local/blender --strip-components=1 && \
    rm blender.tar.xz

#Put blender on the PATH Variable
ENV PATH /usr/local/blender:$PATH

#Copy the blend sample file to image
RUN mkdir /works
COPY ./animals.blend /works

