#!/bin/bash

{
	sleep 2m;
	bash 1.sh;
}  && {
	tail -f report
}
