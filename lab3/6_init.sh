#!/bin/bash

bash 6_obrabotchik.sh & a=$!
bash 6_generator.sh $a
