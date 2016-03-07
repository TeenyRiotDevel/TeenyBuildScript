#!/bin/bash

#!/bin/bash
REMOTE="xcorex@172.16.225.131"
PORT="22"
HELLO="world"

REPO_URL="https://github.com/ATtinyTeenageRiot/AvrdudeGnusbuinoMidi2Kicker.git"
REPO_BRANCH="windows-box"
REPO_DIR="/c/Users/xcorex/AvrdudeGnusbuinoMidi2Kicker"
DESTINATION_REPO="./staging/avrdude"

COMMIT_HASH="4175faef"
ssh ${REMOTE} -p ${PORT} bash -c "'

cd ${REPO_DIR}
git checkout ${COMMIT_HASH}
git pull origin ${REPO_BRANCH}

cd "${REPO_DIR}/babygnusbsysex"
mkdir -p "Release"
make

cd "${REPO_DIR}/avrdude-6.0rc1"

make

./avrdude -cusbasp -pt85


'"
