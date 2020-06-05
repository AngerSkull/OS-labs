#!/bin/bash

cd /home/john/
rm -R Desktop/
rm -R Documents/
rm file1
rm file2
rm file3
cd /home/suzen/
part=$(ls)
echo 'Flag if: ' $part