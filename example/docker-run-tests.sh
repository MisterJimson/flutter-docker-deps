#!/usr/bin/env bash

PROJECT_PATH=$PWD

docker run -ti \
    -v ${PROJECT_PATH}:/project \
    -v $FLUTTER_INSTALL_CACHE_PATH:/flutter-installs \
    jasonrai/flutter-docker-deps:latest \
    /bin/sh -c "./project/docker-flutter-install-then-test.sh"