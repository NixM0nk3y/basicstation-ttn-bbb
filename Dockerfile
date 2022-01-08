FROM balenalib/raspberrypi3-debian-node:10.10-buster-build as builder
# Install build tools and remove layer cache afterwards 


# Switch to working directory for our app
WORKDIR /usr/src/app

# Copy all the source code in.
COPY . .

# Compile our source code
RUN ./deps/build.sh

FROM balenalib/raspberrypi3-debian-node:10.10-debian:buster

RUN install_packages jq

WORKDIR /usr/src/app

COPY --from=builder /opt/ttn-gateway /opt/ttn-gateway
COPY --from=builder /usr/src/app/ ./

COPY start* ./

# Launch our binary on container startup.
CMD ["bash", "start.sh"]


