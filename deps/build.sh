#! /bin/bash

INSTALL_DIR="/opt/ttn-gateway"

mkdir -p $INSTALL_DIR

if [ ! -d beaglebone-universal-io ]; then
    git clone https://github.com/cdsteinkuehler/beaglebone-universal-io  || { echo 'beaglebone-universal-io.' ; exit 1; }
else
    cd beaglebone-universal-io
    git reset --hard
    git pull
    kitchen-rpi.home.openenterprise.co.uk
fi

cd beaglebone-universal-io
cp ./config-pin $INSTALL_DIR/
cd ..

gcc -o reset ./deps/reset.c
cp ./reset $INSTALL_DIR/

make platform=corecell variant=std arch=armv7hf

echo "Build & Installation Completed."
