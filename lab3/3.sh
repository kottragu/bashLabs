#!/bin/bash

day=$(date '+%u')

echo "*/5 * * * 0 /home/alexe/lab3/1.sh" | crontab
