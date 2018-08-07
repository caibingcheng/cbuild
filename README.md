## introduction
**if you will, please help me to complete or improve this tool.**

**email: jack_cbc@126.com**

it will help you create your C++ project quickly.

more works need to be done, but not now.

version: 0.0    base functions
version: 0.1    use template files

## install
clone this repository or download it.

default install
```shell
sh ./install.sh
```
force reinstall
```shell
sh ./install.sh -f
```

the cbuild tools will be copy to ~/.cbuild.
after installing, you'd better to restart the terminal

## usage
this tool will remember the last project you build, so you can ignore the parameter [project] if you are working on the last project.

be cautious， you can not ellipsis the second parameter at the first time

```shell
cbuild -c [project] #create your project
cbuild -r [project] #remove your project
cbuild -b [project] #build your project by cmake
cbuild -e [project] #execute your project
cbuild -h           #show help
```

otherwise, you are able to modify the template files to customize your base-project.

these template files are lay on ~/.cbuild/

## detail
project tree:

```
project
  |--bin
       |--#binara file(executable file)
  |--build
       |--#MakeFile
  |--src
       |--main.cpp    
  |--include
       |--#include file
  |--lib
       |--#libs
  |--CMakeLists.txt
```