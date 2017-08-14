# Ubuntu S2I Base Docker Image

This repository contains a Dockerfile that serves as the base image with all essential libraries and tools needed for OpenShift geomapfish images.

## Installation and Usage

This image is available on DockerHub. To pull the latest image, run:

```
docker pull camptocamp/geomapfish-s2i-builder
```

To build the base image from scratch, run:

```
git clone https://github.com/camptocamp/geomapfish-s2i-builder
cd geomapfish-s2i-builder
make
```

## Usage on openshift

Import the image

```
oc import-image --from='camptocamp/geomapfish-s2i-builder' geomapfish-s2i-builder
```

Build geomapfish code

```
oc new-bu': oc new-build https://github.com/camptocamp/demo_geomapfish_openshift.git -i geomapfish-s2i-builder --name demo-geomapfish
```

## Test

This repository includes the S2I test framework, which launches a simple test to make sure the image builds and runs properly.

```
cd geomapfish-s2i-builder
make
```