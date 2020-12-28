#!/bin/bash

whoI=`whoami`
pcmds=$(ps -xu | awk '{ if($1=="'$whoI'") print $2, $11}')
echo "$pcmds" | wc -l > 2_1.txt
echo "$pcmds" >> 2_1.txt
