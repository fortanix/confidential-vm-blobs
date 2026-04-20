# Jammy packages have been tested to be sufficiently new
FROM ubuntu:25.10

COPY extract_downloadable_artefacts.sh /rootfs/
RUN DEBIAN_FRONTEND=noninteractive apt-get update

WORKDIR /rootfs

ENTRYPOINT ["./extract_downloadable_artefacts.sh"]
