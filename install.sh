#!/bin/sh

INSTALL_PATH=$HOME/.cbuild
SOURCE_DIR=$(cd `dirname $0`; pwd)
COMMAND_PATH="\"sh ${INSTALL_PATH}/cmake-build.sh \$1 \$2\""
COMMAND="alias cbuild=$COMMAND_PATH "
CMP_COMMAND=$(grep "$COMMAND_PATH" ~/.bashrc)
# echo $CMP_COMMAND
if [ -n "$CMP_COMMAND" ]
then
    if [ "$1" = "-f" ]
    then
        echo
        echo Install: reinstall
        echo
        INSTALL_PATH=$HOME/.cbuild
        rm -fr $INSTALL_PATH
        mkdir $INSTALL_PATH
        cp -fr $SOURCE_DIR/* $INSTALL_PATH/
    else
        echo
        echo Error: you have being installed
        echo
    fi
    exit
else
    echo
    echo Path: $SOURCE_DIR/cmake-build.sh
    echo $COMMAND >> ~/.bashrc
    echo Command: cbuild \<[-c][-r][-b][-rb][-e][-h]\> [your_project_name]
    echo Help： restart terminal to work
    echo
fi

rm -fr $INSTALL_PATH
mkdir $INSTALL_PATH
cp -fr $SOURCE_DIR/* $INSTALL_PATH/

