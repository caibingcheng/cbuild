#!/bin/sh

INSTALL_PATH=$HOME/.cbuild
SOURCE_DIR=$(cd `dirname $0`; pwd)
COMMAND_PATH="\"sh ${INSTALL_PATH}/cmake-build.sh \" #ccb241b4014cfb8a2ba0da0a943ac9ff"
COMMAND="alias cbuild=$COMMAND_PATH "
CMP_COMMAND=$(grep "$COMMAND_PATH" ~/.bashrc)
# echo $CMP_COMMAND
if [ -n "$CMP_COMMAND" ]
then
    if [ "$1" = "-f" ]
    then
        echo "-- Install: reinstall"
        INSTALL_PATH=$HOME/.cbuild
        rm -fr $INSTALL_PATH
        mkdir $INSTALL_PATH
        cp -fr $SOURCE_DIR/* $INSTALL_PATH/
    else
        echo "-- Error: you have being installed"
    fi
    exit
else
    echo "-- Path: $SOURCE_DIR/cmake-build.sh"
    echo $COMMAND >> ~/.bashrc
    echo "-- Install: done"
    echo "-- Help： restart terminal to work"
fi

rm -fr $INSTALL_PATH 
mkdir $INSTALL_PATH
cp -fr $SOURCE_DIR/* $INSTALL_PATH/

