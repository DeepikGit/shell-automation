#!/bin/bash

cd /var/log/myapp/



for ((i=$1; i<=$2; i++)); do

  sudo touch "${i}.log"
done

