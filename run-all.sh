#!/bin/bash

REPOSITORIES="
student-go-node
blockchain-go-node
placementdept-go-node
academicdept-go-node
company-go-node"

pushd repositories

for repository in $REPOSITORIES
do
    echo $repository
    if [ -d $repository ]
    then
        echo "Starting server of $repository"
        pushd $repository
        
            pushd src
            go mod download
            gnome-terminal -e 'sh -c "go run main.go; sleep 10; exec bash"' 
            popd
        
        popd
    else
        
        echo "NO Repository Found"
        
    fi
done

popd
