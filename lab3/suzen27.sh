#! /bin/bash

tail -f diary | egrep -o "[A-z0-9]{28}"