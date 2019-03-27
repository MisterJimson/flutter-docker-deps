#!/usr/bin/env bash

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
cd example/
flutter packages get
flutter test