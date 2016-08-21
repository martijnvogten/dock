#!/bin/bash
export DOCK_HOME="$( cd "$( dirname "$(readlink "$0")" )" && pwd -P)" 
export DOCKER_SSH=$1
exec bash --rcfile $DOCK_HOME/bash_init.rc
