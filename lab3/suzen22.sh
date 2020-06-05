#!/bin/bash

i=1; while [ $i -le 999 ] ; do touch $i.txt ; let i++ ; done
part=$(ls | egrep -o '[a-zA-Z0-9]{28}')
echo 'Flag is: ' $part