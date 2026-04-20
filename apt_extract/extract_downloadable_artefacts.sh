#!/bin/bash
set -euo pipefail
OUTPUT_FOLDER="/blobs/"

mkdir "$OUTPUT_FOLDER"

EFI_STUB_PATH="usr/lib/systemd/boot/efi/linuxx64.efi.stub"
AMD_SEV_OVMF="usr/share/ovmf/OVMF.amdsev.fd"

# Download EFI boot stub
apt-get download systemd-boot-efi
dpkg -x systemd-boot-efi*.deb system_boot_efi_dir
cp "system_boot_efi_dir/$EFI_STUB_PATH" "$OUTPUT_FOLDER"

# Download two OVMF versions (simulator mode and AMD SEV mode)
apt-get download ovmf
dpkg -x ovmf*.deb ovmf_dir
cp "ovmf_dir/$AMD_SEV_OVMF" "$OUTPUT_FOLDER"
