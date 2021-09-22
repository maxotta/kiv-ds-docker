# ![DS Logo](images/icon-64-ds.png) Distributed Systems Lab Base Docker Image

## Introduction

This Docker image is supposed to be used as a base for demos and examples available in the [Distributed Systems Lab Demo Projects repo "kiv-ds-vagrant"](https://github.com/maxotta/kiv-ds-vagrant) and your own projects.

## Image description

The image is based on the [official Centos 7 Docker image](https://hub.docker.com/_/centos) `centos:centos7`. It adds the `net-tools` package which contains basic networking tools, including ifconfig, netstat, route, and others. The `less` command line utility and `mc` - the [GNU Midnight Commander](https://midnight-commander.org/) visual file manager are added, together with the [OpenSSH](https://www.openssh.com/) daemon. The OpenSSH server is configured to accept the default Vagrant public key from the [Vagrant insecure keypair](https://github.com/hashicorp/vagrant/tree/master/keys), in order to enable Vagrant to perform all operations on the boxes automatically.

## Using the image

If you want to use this image, just use it's identifier either in the `Vagrantfile` or the `Dockerfile`. Because this image is published in the [Github Container Registry](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry), the identifier has the following form: `ghcr.io/maxotta/kiv-ds-docker:v0.9.1`.
The version can differ, depending on the [current image release](https://github.com/maxotta/kiv-ds-docker/releases). If you want to use always the most recent version, just use the `latest` version marker and refer to the image as `ghcr.io/maxotta/kiv-ds-docker:latest`.

## Building images based on this base

Just use the `FROM <image>` clause to build a new image based on this image. You must only pay special attention to how to start services inside you container.
The base image has already an `ENTRYPOINT`, which is a shell script that starts the OpenSSH daemon and then you service - in other words: runs anything you pass to it in the `CMD` command. For instance, if you want to start a simple service written in [Python](https://www.python.org/), add this line to your `Dockerfile`:

```
CMD /usr/bin/python3 /opt/backend/simple-backend.py
```
