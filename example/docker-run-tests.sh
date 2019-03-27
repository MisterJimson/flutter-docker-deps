REPO_PATH=$PWD

docker run -ti \
    -v ${REPO_PATH}:/example \
    -v $FLUTTER_INSTALL_CACHE_PATH:/flutter-installs \
    jasonrai/flutter-docker-deps:latest \
    /bin/sh -c "./example/docker-flutter-install-then-test.sh"