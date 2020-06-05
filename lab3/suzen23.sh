#!/bin/bash

cd destination/
mv nginx1.log nginx1.log.back
mv nginx2.log nginx2.log.back
mv nginx3.log nginx3.log.back
mv nginx4.log nginx4.log.back
mv nginx5.log nginx5.log.back
cd /home/suzen/source
mv nginx* /home/suzen/destination/
cd ..
part=$(ls | egrep -o '[a-zA-Z0-9]{28}')
echo 'Flag is: ' $part
© 2020 GitHub, Inc.