#!/bin/bash
# script that makes a local clone of all relevant go-ready-blockchain repositories

REPO_URL_PREFIX="https://github.com/go-ready-blockchain/"

REPOSITORIES="
student-go-node
blockchain-go-node
placementdept-go-node
academicdept-go-node
company-go-node"

mkdir repositories
pushd repositories

for repository in $REPOSITORIES
do
    echo $repository
    if [ -d $repository ]
    then
        echo "Pulling changes into $repository"
        pushd $repository
        git pull
        pushd src
            go mod download
        popd
        popd
    else
        repo_url="${REPO_URL_PREFIX}${repository}.git"
        echo "Cloning from $repo_url"
        git clone $repo_url
        pushd $repository
        pushd src
            go mod download
        popd
        popd
    fi
    echo $repository
done

popd

