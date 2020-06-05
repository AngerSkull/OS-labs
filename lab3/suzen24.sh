#!/bin/bash

mkdir Music
cp -R /home/suzen/Desktop/music/ololo /home/suzen/Music/
cp -R /home/suzen/Desktop/music/azaza /home/suzen/Music/
part=$(ls | egrep -o '[a-zA-Z0-9]{28}')
echo 'Flag is: ' $part