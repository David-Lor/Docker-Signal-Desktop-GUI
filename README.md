# Signal Desktop app - Docker image

Docker image for the Signal messaging desktop app, using the [jlesage/docker-baseimage-gui](https://github.com/jlesage/docker-baseimage-gui) image (debian-10).
Once deployed, the app can be accessed through a modern web browser or a VNC client.
This image is only available for **linux/amd64**.

**This image is experimental and might have undesirable effects. Use it under your responsability!**

_This image is not official and is not associated with the Signal Foundation._

## Getting started

```bash
docker volume create --name=signal-desktop-data
docker run -d --name=signal-desktop -p 5800:5800 -v signal-desktop-data:/config -v /etc/localtime:/etc/localtime:ro davidlor/signal-desktop:latest
```

## Configuration

- Volumes:
  - All the configuration is persisted in `/config`
- Environment variables:
  - Please refer to the [base image documentation for a list of all the available environment variables](https://github.com/jlesage/docker-baseimage-gui#environment-variables) that can be configured.
  - Some of the most important may be:
    - `VNC_PASSWORD`: password for the VNC and noVNC (web) access (default: no password!)
    - `DISPLAY_WIDTH` and `DISPLAY_HEIGHT`: customize the size of the app window (default: 1280x720)
    - `TZ`: timezone for the container, used for displaying dates on the app (default: UTC). Can be one of the available [here](http://en.wikipedia.org/wiki/List_of_tz_database_time_zones) ("TZ database name" column). Can be synchronized with the host by bind-mounting the `/etc/localtime` path (read-only).
- Ports:
  - 5800: noVNC (web) where the app is displayed
  - 5900: pure VNC server that can be accessed with any VNC client app

## Building

The image can be built with the following command:

```bash
docker build ./docker -t {image tag}
```

The available build args are:

- `APP_ICON`: URL of a PNG image to use as app logo/icon, on web noVNC view
- `IMAGE_TAG`: variant of the base image (other variants have not been tested)

## Changelog

- 0.0.1
  - Initial version: functional app
