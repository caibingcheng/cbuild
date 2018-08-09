#!/bin/sh

help()
{
    echo "Usage:" 
    echo "  cbuild <command> [your_project_name]"
    echo 
    echo "Commands:"
    echo "  -a       add project"
    echo "  -c       create project"
    echo "  -r       remove project"
    echo "  -b       build project"
    echo "  -e       execute project"
    echo "  -p       add parameters for the execute program"
    echo "  -f       force"
    echo "  -R       remove project without parameter"
    echo "  -B       build project without parameter"
    echo "  -E       execute project without parameter"
    echo "  -h       show help"
}

cbuild_uninstall()
{
    COMMAND_PATH="\"sh ${INSTALL_PATH}/cmake-build.sh \" #ccb241b4014cfb8a2ba0da0a943ac9ff"
    CBUILD_PATH="$HOME/.cbuild"
    rm -fr $CBUILD_PATH
    sed -i '/#ccb241b4014cfb8a2ba0da0a943ac9ff/d' $HOME/.bashrc
    echo "-- Uninstall: done"
}

cbuild_add()
{
    CBUILD_PATH="$HOME/.cbuild"

    if [ ! -d "${1}" ]
    then 
        echo "-- Error: no such project ${1}"
        return
    fi

    echo "-- Add: ${1}"
    echo $(pwd)/${1} > ${CBUILD_PATH}/cbuild.path
    echo ${1} >> ${CBUILD_PATH}/cbuild.path
    return
}

cbuild_create()
{
    CBUILD_PATH="$HOME/.cbuild"
    # $1 PROJECT_NAME
    # $2 PROJECT_EXECUTE
    # $3 FORCE

    if [ ${3} -eq 1 ]
    then
        if [ -d "${1}" ]
        then
            if ! read -p "-- ${1} has already exist, force create [y/n]? " RECREATRE_FLAG
            then
                RECREATRE_FLAG=n
            fi
            case $RECREATRE_FLAG in
                Y | y)
                    rm -fr ${1}
                    ;;
                N | n)
                    return
                    ;;
                *)
                    return
                    ;;
            esac
        fi
    fi
    
    # make sure the project is unique in the current workstation
    if [ -d "${1}" ]
    then 
        echo "-- Error: ${1} exist"
        return
    fi
 
    echo "-- Create: ${1}"

    # build the project
    mkdir ${1}
    sed 's/{__CBUILD_PROJECT__}/'${2}'/g' ${CBUILD_PATH}/template/CMakeLists.txt > ${1}/CMakeLists.txt
    mkdir ${1}/build
    mkdir ${1}/bin
    mkdir ${1}/src
    cp ${CBUILD_PATH}/template/main.cpp ${1}/src/main.cpp
    mkdir ${1}/include
    mkdir ${1}/lib

    echo $(pwd)/${1} > ${CBUILD_PATH}/cbuild.path
    echo ${1} >> ${CBUILD_PATH}/cbuild.path

    return     
}

cbuild_remove()
{
    # $1 PROJECT_NAME
    if [ -d "${1}" ]
    then 
        echo "-- Remove: ${1}"
        rm -fr ${1}
        return
    fi
    echo "-- Error: no such project ${1}"
    return
}

cbuild_build()
{
    # $1 PROJECT_NAME
    if [ -d "${1}" ]
    then 
        echo "-- Build: ${1}"
        cd ${1}/build
        if [ ${2} -eq 1 ]
        then
            rm -fr ./*
        fi
        cmake ..
        make -j4
        return
    fi
    echo "-- Error: no such project ${1}"
    return     
}


cbuild_execute()
{
    # $1 PROJECT_NAME
    # $2 PROJECT_EXECUTE
    if [ -d "${1}" ]
    then 
        echo "-- Execute: ${1}"
        ${1}/bin/${2}
        return
    fi
    echo "-- Error: no such project ${1}"
    return  
}