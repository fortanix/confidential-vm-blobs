#!/bin/bash
set -euo pipefail

CONFIDENTIAL_VM_BLOBS_PACKAGE_BASE_VERSION="0.1"

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")
DEBIAN_BLOBS_DIR="debian/opt/fortanix/confidential-vm-blobs"
DEBIAN_META_DIR="debian/DEBIAN"

parse_args() {
    if [ $# -lt 2 ] || [ $# -gt 3 ]; then
        echo "$0: ERROR: Wrong number of arguments" >>/dev/stderr
        echo "$0: Usage: $0 build_number kernel_artifacts_dir" >>/dev/stderr
        exit 1
    fi

    kernel_artifacts_dir=$1
    build_number=$2
}

create_deb_skeleton() {
    rm -f fortanix-confidential-vm-blobs*.deb
    rm -rf debian
    mkdir -p "$DEBIAN_BLOBS_DIR"
    mkdir -p "$DEBIAN_META_DIR"

    sed -e "s/__VERSION__/${confidential_vm_blobs_package_version}/g" "$SCRIPT_DIR/debian_control" >"$DEBIAN_META_DIR/control"
}

parse_args "$@"
confidential_vm_blobs_package_version="${CONFIDENTIAL_VM_BLOBS_PACKAGE_BASE_VERSION}.${build_number}"

create_deb_skeleton

# Copy linux kernel over
cp "$kernel_artifacts_dir"/* "$DEBIAN_BLOBS_DIR"/

# Download apt artefacts and add to docker
"$SCRIPT_DIR/build-docker-and-extract.sh" -C "$SCRIPT_DIR/apt_extract" --output "$DEBIAN_BLOBS_DIR/" --image_name "confidential_vm_blobs_apt_extract_${confidential_vm_blobs_package_version}"

# Build `init` executable used in initramfs
"$SCRIPT_DIR/build-docker-and-extract.sh" -C "$SCRIPT_DIR/build_init" --output "$DEBIAN_BLOBS_DIR/" --image_name "confidential_vm_blobs_init_${confidential_vm_blobs_package_version}"

# build package
fakeroot dpkg-deb --build debian fortanix-confidential-vm-blobs-"${confidential_vm_blobs_package_version}"-amd64.deb
rm -rf debian
