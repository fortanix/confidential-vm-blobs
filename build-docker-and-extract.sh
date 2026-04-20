#!/bin/bash
set -euo pipefail

cleanup() {
    docker rm "$container_name" || true
    docker rmi "$image_name" || true
}

run_folder=$(pwd) # run in cwd by default
output_folder="$run_folder"
while [ $# -gt 0 ]; do
    case "$1" in
    --image_name)
        shift
        image_name=$1
        ;;
    -C)
        shift
        run_folder=$1
        ;;
    --output)
        shift
        output_folder=$1
        ;;
    --*)
        echo "Error: bad option $1"
        exit 1
        ;;
    *)
        echo "Error: bad argument $1"
        exit 1
        ;;
    esac
    shift
done

if [ -z $image_name ]; then
    echo "ERROR: --image_name is required and cannot be empty" >&2
fi
container_name="${image_name}_container"

trap cleanup EXIT

docker build -t "$image_name" "$run_folder"

docker run --name "$container_name" "$image_name"
docker cp "${container_name}:/blobs/." "$output_folder"
