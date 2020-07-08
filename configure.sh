#!/bin/bash

if ! command -v aws &> /dev/null
then
    echo "aws cil not installed EXITING..!"
    exit
fi
if [ ! -f ~/.aws/credentials ]
then
    echo "!! NO AWS CREDENTIALS FOUND !!"
    echo "Running aws configure"
    aws configure
fi

if [ ! -f /var/run/docker.pid ]
then
    echo "!!! Docker service is probably not running !!!"
fi


function prepare_venv() {
	virtualenv -p python3.7 venv && source venv/bin/activate && python3.7 `which pip3` install -r requirements.txt
}

[ "$NOVENV" == "1" ] || prepare_venv || exit 1

PYTHONDONTWRITEBYTECODE=1 python3.7 setup.py