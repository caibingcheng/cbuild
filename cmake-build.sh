#!/bin/sh

CBUILD_PATH="$HOME/.cbuild"

. $CBUILD_PATH/functions.sh

if [ "$1" = "uninstall" ]
then
    cbuild_uninstall
    exit
fi

if [ ! -d "$CBUILD_PATH" ]
then 
    mkdir $CBUILD_PATH
    SOURCE_DIR=$(cd `dirname $0`; pwd)
    cp -fr $SOURCE_DIR/* $CBUILD_PATH/
fi

CBUILD_PATH_EXIST=0
if [ -f "${CBUILD_PATH}/cbuild.path" ] 
then 
    i=0
    while read line
    do
        if [ $i -eq 0 ]
        then
            PROJECT_NAME=$line
        fi
        if [ $i -eq 1 ]
        then        
            PROJECT_EXECUTE=$line
        fi
        i=`expr $i + 1`
    done < $CBUILD_PATH/cbuild.path
    CBUILD_PATH_EXIST=1
fi

FORCE=0
while getopts :"a:c:r:b:e:fRBEh" opt 
do
    case $opt in
        a)
            cbuild_add $OPTARG
            ;;
        c)
            cbuild_create $OPTARG $OPTARG $FORCE
            FORCE=0
            ;;
        r)
            cbuild_remove $OPTARG
            ;;
        R)
            if [ $CBUILD_PATH_EXIST -eq 1 ]
            then
                cbuild_remove $PROJECT_NAME
            fi 
            ;;
        b)
            cbuild_build $OPTARG $FORCE
            FORCE=0
            ;;
        B)
            if [ $CBUILD_PATH_EXIST -eq 1 ]
            then
                cbuild_build $PROJECT_NAME $FORCE
            fi 
            FORCE=0
            ;;
        e)
            cbuild_execute $OPTARG $OPTARG
            ;;
        E)
            if [ $CBUILD_PATH_EXIST -eq 1 ]
            then
                cbuild_execute $PROJECT_NAME $PROJECT_EXECUTE
            fi 
            ;;
        f)
            FORCE=1
            ;;
        h)
            help
            exit
            ;;
        ?)  
            help
            exit
            ;;
    esac
done
