# geomapfish S2I Base Docker Image

This repository contains a Dockerfile that serves as the base image with all essential libraries and tools needed for building geopmapfish

The origin/entrypoint of the build is camptocamp/geomapfish_build:jenkins

## Installation and Usage

To build the base image from scratch, run:

```
git clone https://github.com/camptocamp/geomapfish-s2i-builder.git
cd geomapfish-s2i-builder
make build
```

Or

To build within openshift, run:

```
oc new-build openshift/sti-image-builder~git@github.com:camptocamp/geomapfish-s2i-builder.git --name=geomapfish-s2i-builder
```

## Test

This repository includes the S2I test framework, which launches a simple test to make sure the image builds and runs properly.

```
cd s2i-base-ubuntu/16.04
make test
```
