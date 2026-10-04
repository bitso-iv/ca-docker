FROM ubuntu:noble-20260917
RUN apt-get update && apt-get install -y openssl && rm -rf /var/lib/apt/lists/*
WORKDIR /pki
COPY scripts/ /scripts/
RUN chmod +x /scripts/*.sh
ENTRYPOINT ["tail", "-f", "/dev/null"]