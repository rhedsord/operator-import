#!/bin/bash -x
clear
mkdir aws 2>/dev/null
sudo podman run -it --rm \
    --pull always \
    --name operators \
    --entrypoint bash \
    --workdir /root/operator-import \
    --volume $(pwd):/root/operator-import:z \
    --volume $(pwd)/docker/:/root/docker/:z \
  docker.io/codesparta/konductor