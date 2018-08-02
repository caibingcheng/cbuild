#!/bin/sh

help()
{
    echo 
    echo "Usage:" 
    echo "  cbuild <command> [your_project_name]"
    echo 
    echo "Commands:"
    echo "  -c       create project"
    echo "  -r       remove project"
    echo "  -b       build project"
    echo "  -e       execute project"
    echo
}

# no more than 2 parameter
if [ $# -gt 2 ]
then
    echo
    echo "-- Usage: cbuild <[-c][-r][-b][-e]> [your_project_name]"
    echo
    exit
fi

# help information
if [ "$1" = "-h" ]
then
    help;
    exit     
else
    if [ $# -ne 2 ]
    then
        echo
        echo "-- Usage: cbuild <[-c][-r][-b][-e]> [your_project_name]"
        echo
        exit
    fi 
fi

# remove the project
if [ "$1" = "-r" ]
then
    PROJECT_NAME="$2"
    if [ -d "${PROJECT_NAME}" ]
    then 
        echo 
        echo "-- Remove: ${PROJECT_NAME}"
        echo
        rm -fr ${PROJECT_NAME}
        exit
    fi
    echo 
    echo "-- Error: no such project"
    echo
    exit     
fi

# build the project
if [ "$1" = "-b" ]
then
    PROJECT_NAME="$2"
    if [ -d "${PROJECT_NAME}" ]
    then 
        echo 
        echo "-- Building: ${PROJECT_NAME}"
        echo
        cd ${PROJECT_NAME}/build
        cmake ..
        make -j4
        exit
    fi
    echo 
    echo "-- Error: no such project"
    echo
    exit     
fi

# execute the project
if [ "$1" = "-e" ]
then
    PROJECT_NAME="$2"
    if [ -d "${PROJECT_NAME}" ]
    then 
        echo 
        echo "-- Execute: ${PROJECT_NAME}"
        echo
        ${PROJECT_NAME}/bin/${PROJECT_NAME}
        exit
    fi
    echo 
    echo "-- Error: no such project"
    echo
    exit     
fi


# remove the project
if [ "$1" = "-c" ]
then
    PROJECT_NAME="$2"

    # make sure the project is unique in the current workstation
    if [ -d "${PROJECT_NAME}" ]
    then 
        echo 
        echo "-- Error: ${PROJECT_NAME} exist"
        echo
        exit
    fi
 
    # text content
    CMAKE_CONTENT="cmake_minimum_required(VERSION 2.8)\nproject(${PROJECT_NAME})\nset(CMAKE_CXX_STANDARD 11)\nset(CMAKE_RUNTIME_OUTPUT_DIRECTORY \${PROJECT_SOURCE_DIR}/bin/)\nadd_executable(${PROJECT_NAME} ./src/main.cpp)\n"
    MAIN_CONTENT='#include <iostream>\nint main()\n{\n    std::cout << "hello world!" << std::endl;\n    return 1;\n}\n'

    echo
    echo "-- Build Project: ${PROJECT_NAME}"

    # build the project
    mkdir ${PROJECT_NAME}
    echo ${CMAKE_CONTENT} > ${PROJECT_NAME}/CMakeLists.txt
    mkdir ${PROJECT_NAME}/build
    mkdir ${PROJECT_NAME}/bin
    mkdir ${PROJECT_NAME}/src
    echo ${MAIN_CONTENT} > ${PROJECT_NAME}/src/main.cpp
    mkdir ${PROJECT_NAME}/include
    mkdir ${PROJECT_NAME}/lib
    echo
    exit     
fi

help;

