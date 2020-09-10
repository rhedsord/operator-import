#!/usr/bin/env bash

oc adm catalog build \
    --appregistry-org redhat-operators \
    --from=registry.redhat.io/openshift4/ose-operator-registry:${OCP_VERSION} \
    --filter-by-os="linux/amd64" \
    --to=${LOCAL_REGISTRY}:${LOCAL_VERSION} \
    -a ${AUTH_FILE} \
    --insecure

oc adm catalog mirror \
    ${LOCAL_REGISTRY}:${LOCAL_VERSION} \
    ${LOCAL_REGISTRY} \
    -a ${AUTH_FILE} \
    --insecure