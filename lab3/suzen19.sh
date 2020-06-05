#! /bin/bash

mkdir Documents/projects/lab19/using/simple/bash/commands -p
cd Documents/projects/lab19/using/simple/bash/commands
flag = $(ls | egrep -o "[A-z0-9]{28}")
echo $flag