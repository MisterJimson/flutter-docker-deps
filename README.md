# flutter-docker-deps
A docker image with the dependancies required to install and run Flutter tests. This can be used to run tests in a consistent environment without needing to worry about system differences, updates, etc. 

This project is inspired by [appleboy/flutter-docker](https://github.com/appleboy/flutter-docker). The main difference being that the Flutter version is dynamic and set by the project instead of having to have a Docker image for each Flutter version. The version will be installed if missing from the install cache.

This also allows the same Docker image to work for mutiple Flutter projects, all using different versions of Flutter.
## How to use
See the example folder of this repo. This example Flutter project folder was created using `flutter create` with 2 scripts added.
### docker-run-tests.sh
```
PROJECT_PATH=$PWD

docker run -ti \
    -v ${PROJECT_PATH}:/example \
    -v $FLUTTER_INSTALL_CACHE_PATH:/flutter-installs \
    jasonrai/flutter-docker-deps:latest \
    /bin/sh -c "./example/docker-flutter-install-then-test.sh"
```
This script runs the docker image, mounting 2 directories from the host OS onto the container.

`PROJECT_PATH` would be the path to your flutter project, mounted as `/example` in this example. If you keep this script in the root of your Flutter project, you can keep `PROJECT_PATH=$PWD` to set the path for you.

`$FLUTTER_INSTALL_CACHE_PATH` is a bash environment variable. You need to set it to where you want to cache Flutter installs on the host machine.
