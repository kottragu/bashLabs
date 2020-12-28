#!/bin/bash

ps -Ao pid,command | grep -E "[[:space:]]+/sbin/" | grep -Eo "[0-9]+ "  > lab2_2.txt
