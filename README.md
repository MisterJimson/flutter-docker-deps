# flutter-docker-deps
A docker image with the dependancies required to install and run Flutter tests. This can be used to run tests in a consistent environment without needing to worry about system differences, updates, etc. 

This project is inspired by [appleboy/flutter-docker](https://github.com/appleboy/flutter-docker). The main difference being that the Flutter version is dynamic and set by the project instead of having to have a Docker image for each Flutter version. The version will be installed if missing from the install cache.

This also allows the same Docker image to work for mutiple Flutter projects, all using different versions of Flutter.
## How to use
See the example folder of this repo. This example Flutter project folder was created using `flutter create` with 2 scripts added.

Add scripts similar to the ones in the example, then just run `./docker-run-tests.sh`.
### docker-run-tests.sh
```
PROJECT_PATH=$PWD

docker run -ti \
    -v ${PROJECT_PATH}:/project \
    -v $FLUTTER_INSTALL_CACHE_PATH:/flutter-installs \
    jasonrai/flutter-docker-deps:latest \
    /bin/sh -c "./project/docker-flutter-install-then-test.sh"
```
This script runs the docker image, mounting 2 directories from the host OS onto the container.

`PROJECT_PATH` is the path to your flutter project. If you keep this script in the root of your Flutter project, you can keep `PROJECT_PATH=$PWD` to set the path for you.

`$FLUTTER_INSTALL_CACHE_PATH` is a bash environment variable. You need to set it to where you want to cache Flutter installs on the host machine.
### docker-flutter-install-then-test.sh
```
VERSION="1.3.8"
CHANNEL="beta"

cd /flutter-installs

if [ ! -d "v${VERSION}-${CHANNEL}" ]; then
    wget https://storage.googleapis.com/flutter_infra/releases/${CHANNEL}/linux/flutter_linux_v${VERSION}-${CHANNEL}.tar.xz
    mkdir v${VERSION}-${CHANNEL}
    tar xf flutter_linux_v${VERSION}-${CHANNEL}.tar.xz -C v${VERSION}-${CHANNEL}
fi

cd ..
export PATH=/flutter-installs/v${VERSION}-${CHANNEL}/flutter/bin:$PATH
cd project/
flutter packages get
flutter test
```
This script installs Flutter if needed then runs `flutter test`. Beware that this script is ran inside the container, it's not the bash environment of the host machine like the previous script is.

In this script set the version and release channel of Flutter that you want to test on. It will only download missing versions of Flutter. So the first time you run tests for each Flutter version expect them to take longer.
