# Download and verify the integrity of the download first
FROM sethvargo/hashicorp-installer AS installer
RUN /install-hashicorp-tool "vault" "1.3.1"

# Now copy the binary over into a smaller base image
FROM stedolan/jq:latest

RUN apt-get install -y build-essential curl jq nano ca-certificates && \
  rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8

COPY --from=installer /software/vault /vault
