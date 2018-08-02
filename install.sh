#!/bin/sh

SOURCE_DIR=$(cd `dirname $0`; pwd)
COMMAND_PATH="\"sh ${SOURCE_DIR}/cmake-build.sh \$1 \$2\""
COMMAND="alias cbuild=$COMMAND_PATH "
CMP_COMMAND=$(grep "$COMMAND_PATH" ~/.bashrc)
# echo $CMP_COMMAND
if [ -n "$CMP_COMMAND" ]
then
    echo
    echo Error: you have being installed
    echo
    exit
fi

echo
echo Path: $SOURCE_DIR/cmake-build.sh
echo $COMMAND >> ~/.bashrc
echo Command: cbuild \<[-c][-r][-b][-e][-h]\> [your_project_name]
echo Help： restart terminal to work
echo