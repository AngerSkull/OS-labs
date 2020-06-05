#! /bin/bash

flag = $(man diary | egrep -o "[A-z0-9]{28}")
echo $flag