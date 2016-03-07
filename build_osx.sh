#!/bin/bash
REMOTE=""
PORT=""

cwd=$(pwd)

REPO_URL="https://github.com/ATtinyTeenageRiot/AvrdudeGnusbuinoMidi2Kicker.git"
STAGING_DIR="staging"
REPO_DIR="${STAGING_DIR}/AvrdudeGnusbuinoMidi2Kicker"

DESTINATION_REPO="../platform/avr/tools/avrdude"
COMMIT_HASH="129f96f7"

#rm -fr "${REPO_DIR}"
mkdir -p "${cwd}/${REPO_DIR}"
cd "${cwd}/${STAGING_DIR}"

git clone "${REPO_URL}"

cd "${cwd}/${REPO_DIR}"
pwd

git fetch --all
git pull --all
git checkout ${COMMIT_HASH}
git reset --hard ${COMMIT_HASH}

cd "${cwd}/${REPO_DIR}/avrdude-6.0rc1"
pwd
chmod +x ./configure
./configure
make
pwd

git log -1 > changelog.txt

mkdir -p "${cwd}/${DESTINATION_REPO}/macosx"

rm -fr "${cwd}/${DESTINATION_REPO}/macosx/*"

cp ./avrdude "${cwd}/${DESTINATION_REPO}/macosx"
cp ./avrdude.conf "${cwd}/${DESTINATION_REPO}/macosx"
cp ./changelog.txt "${cwd}/${DESTINATION_REPO}/macosx"

cp "/usr/local/opt/libusb/lib/libusb-1.0.0.dylib" "${cwd}/${DESTINATION_REPO}/macosx"

cd "${cwd}/${DESTINATION_REPO}/macosx"

chmod 755 "./libusb-1.0.0.dylib"
install_name_tool -change  /usr/lib/libedit.3.dylib /usr/lib/libedit.2.dylib ./avrdude
install_name_tool -change "/usr/local/opt/libusb/lib/libusb-1.0.0.dylib" "@executable_path/libusb-1.0.0.dylib" ./avrdude
install_name_tool -id "@executable_path/libusb-1.0.0.dylib" ./libusb-1.0.0.dylib
