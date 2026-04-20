FROM nixos/nix:2.21.4 AS build
ARG TARGET=all
ENV TARGET=${TARGET}

RUN mkdir /build
ADD ./ /build/
WORKDIR /build

RUN nix-build -A ${TARGET}

FROM alpine AS artifacts
COPY --from=build /build/result/* /blobs/
CMD ["true"]
