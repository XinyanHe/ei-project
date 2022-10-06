#!/bin/bash -e

CTL=ext/ei/scripts/ctl.sh

echo "Creating pipe between 1.1 and 1.2..."
$CTL 1 1 pipe_new_basic --remote=1.2 --r-addr=127.0.1.2 --l-addr=127.0.1.1 --l-id=1
$CTL 1 2 pipe_new_basic --remote=1.1 --r-addr=127.0.1.1 --l-addr=127.0.1.2 --l-id=1

echo "Adding CP connection from 1.1 to 1.2..."
$CTL 1 1 tree_add --tree=config --path='./"cp"/"persistent"/"tcp:127.0.1.2:12099"'

echo "Putting up pipe 1 (1.1 <-> 1.2)..."
$CTL 1 1 pipe_enable=1
$CTL 1 2 pipe_enable=1

echo "Adding a host stack to 1.1..."
$CTL 1 1 pipe_new_host_stack --id=2
$CTL 1 1 pipe_enable=2
echo "Adding a host stack to 1.2..."
$CTL 1 2 pipe_new_host_stack --id=2
$CTL 1 2 pipe_enable=2
