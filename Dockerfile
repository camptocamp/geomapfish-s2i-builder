# This image is an Ubuntu base image for Source-to-Image builds
FROM camptocamp/geomapfish_build:jenkins
MAINTAINER Steven Mirabito <smirabito@csh.rit.edu>

LABEL \
      # Location of the STI scripts inside the image.
      io.openshift.s2i.scripts-url=image:///usr/libexec/s2i

ENV \
    # Path to be used in other layers to place s2i scripts into
    STI_SCRIPTS_PATH=/usr/libexec/s2i \

    # The $HOME is not set by default, but some applications needs this variable
    HOME=/opt/app-root/src \
    PATH=/opt/app-root/src/bin:/opt/app-root/bin:$PATH

RUN cat /etc/apt/sources.list

# This is the list of basic dependencies that all language Docker images can consume.
RUN INSTALL_PKGS="build-essential \
bzip2 \
git \
patch \
procps \
tar \
unzip \
wget" && \
export DEBIAN_FRONTEND=noninteractive && \
apt-get -yq update && \
apt-get -yq install $INSTALL_PKGS && \
apt-get clean

# Setup the 'openshift' user that is used for build execution and for the
# application runtime execution.
RUN useradd -u 1001 -r -g 0 -d ${HOME} -s /sbin/nologin \
-c "Default Application User" default && \
mkdir -p /opt/app-root && \
chown -R 1001:0 /opt/app-root

#Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image
COPY ./.s2i/bin/ /usr/libexec/s2i

# Copy executable utilities.
COPY bin/ /usr/bin/

# Directory with the sources is set as the working directory so all STI scripts
# can execute relative to this path.
WORKDIR ${HOME}


# Set the default user for the image, the user itself was created in the base image
USER 1001

ENTRYPOINT ["container-entrypoint"]
CMD ["base-usage"]
