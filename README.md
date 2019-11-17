
[uri_license]: http://www.gnu.org/licenses/gpl.html
[uri_license_image]: https://img.shields.io/badge/License-GPL%20v3-blue.svg

[![License: GPL v3][uri_license_image]][uri_license]
[![Build Status](https://travis-ci.org/Monogramm/docker-roundcube.svg)](https://travis-ci.org/Monogramm/docker-roundcube)
[![Docker Automated buid](https://img.shields.io/docker/cloud/build/monogramm/docker-roundcube.svg)](https://hub.docker.com/r/monogramm/docker-roundcube/)
[![Docker Pulls](https://img.shields.io/docker/pulls/monogramm/docker-roundcube.svg)](https://hub.docker.com/r/monogramm/docker-roundcube/)
[![](https://images.microbadger.com/badges/version/monogramm/docker-roundcube.svg)](https://microbadger.com/images/monogramm/docker-roundcube)
[![](https://images.microbadger.com/badges/image/monogramm/docker-roundcube.svg)](https://microbadger.com/images/monogramm/docker-roundcube)

# RoundCube custom Docker

Custom Docker image for RoundCube.

Provides a RoundCube with additional extensions for integrations of additional plugins.

Additional plugins included:
* https://github.com/sblaisot/automatic_addressbook
* https://github.com/blind-coder/rcmcarddav

* https://github.com/texxasrulez/Caldav_Calendar

## What is RoundCube ?

Roundcube Webmail is a browser-based multilingual IMAP client with an application-like user interface.

> [roundcube.net](https://roundcube.net/)

## Supported tags

https://hub.docker.com/r/monogramm/docker-roundcube/

* `master` branch
    -	`1.4-apache`, `1.4-apache`, `production-apache`, `1.4`, `production` (*images/1.4-apache/Dockerfile*)
    -	`1.4-fpm`, `1.4-fpm`, `production-fpm` (*images/1.4-fpm/Dockerfile*)
    -	`1.4-alpine`, `1.4-alpine`, `production-alpine` (*images/1.4-alpine/Dockerfile*)
* `develop` branch
    -	`apache`, `latest` (*images/1.4-apache/Dockerfile*)
    -	`fpm` (*images/1.4-fpm/Dockerfile*)
    -	`alpine` (*images/1.4-alpine/Dockerfile*)

## How to run this image ?

See RoundCube base image documentation for details.

> [RoundCube GitHub](https://github.com/roundcube/roundcubemail-docker)

> [RoundCube DockerHub](https://hub.docker.com/r/roundcube/roundcubemail/)

# Questions / Issues
If you got any questions or problems using the image, please visit our [Github Repository](https://github.com/Monogramm/docker-roundcube) and write an issue.
