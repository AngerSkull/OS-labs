#!/bin/bash

rm *[0-9]*.txt
rm *[a-z]*.png
rm test-*.log
part=$(ls | egrep -o '[a-zA-Z0-9]{28}')
echo 'Flag is: ' $part