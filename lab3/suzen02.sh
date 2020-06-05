#! /bin/bash

for file in ./*
do
text = $(cat $file)
if [[ $text =~ ^[A-Ba-b0-1]+$ ]]
then
echo $text
fi
done