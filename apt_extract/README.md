We spin up a docker file with a newer ubuntu version to download the AMD-SEV OVMF,
because the OVMF that ubuntu 24 packages is too old to work with AMD-SEV-SNP,
and the upstream edk2 repository does not ship pre-built binaries,
nor does it apply security patches to existing branches to produce stable build artifacts.
