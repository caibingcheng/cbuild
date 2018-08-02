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

CBUILD_PATH="$HOME/.cbuild.path"
# help information
if [ "$1" = "-h" ]
then
    help;
    exit     
else
    if [ $# -ne 2 ]
    then
        if [ -f "${CBUILD_PATH}" ] 
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
            done < $CBUILD_PATH
        else 
        echo
        echo "-- Usage: cbuild <[-c][-r][-b][-e]> [your_project_name]"
        echo
        exit
        fi
    else
        PROJECT_NAME="$2"
        PROJECT_EXECUTE="$2"
        echo $(pwd)/$PROJECT_NAME > $CBUILD_PATH
        echo $PROJECT_NAME >> $CBUILD_PATH
    fi 
fi
# remove the project
if [ "$1" = "-r" ]
then
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
    if [ -d "${PROJECT_NAME}" ]
    then 
        echo 
        echo "-- Building: ${PROJECT_NAME}"
        echo
        cd ${PROJECT_NAME}/build
        echo `pwd`
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
    if [ -d "${PROJECT_NAME}" ]
    then 
        echo 
        echo "-- Execute: ${PROJECT_NAME}"
        echo
        ${PROJECT_NAME}/bin/${PROJECT_EXECUTE}
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

    # make sure the project is unique in the current workstation
    if [ -d "${PROJECT_NAME}" ]
    then 
        echo 
        echo "-- Error: ${PROJECT_NAME} exist"
        echo
        exit
    fi
 
    # text content
    CMAKE_CONTENT="cmake_minimum_required(VERSION 2.8)\nproject(${PROJECT_EXECUTE})\nset(CMAKE_CXX_STANDARD 11)\nset(CMAKE_RUNTIME_OUTPUT_DIRECTORY \${PROJECT_SOURCE_DIR}/bin/)\nadd_executable(${PROJECT_EXECUTE} ./src/main.cpp)\n"
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

