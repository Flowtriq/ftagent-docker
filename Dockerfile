FROM python:3.12-slim

LABEL maintainer="Flowtriq <hello@flowtriq.com>"
LABEL org.opencontainers.image.title="ftagent"
LABEL org.opencontainers.image.description="Flowtriq DDoS Detection Agent"
LABEL org.opencontainers.image.url="https://flowtriq.com"
LABEL org.opencontainers.image.source="https://github.com/Flowtriq/ftagent"
LABEL org.opencontainers.image.vendor="Flowtriq"

RUN apt-get update && apt-get install -y --no-install-recommends \
    libpcap-dev \
    tcpdump \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir ftagent[full]

RUN mkdir -p /etc/ftagent /var/log/ftagent /var/lib/ftagent

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENV FTAGENT_CONFIG=/etc/ftagent/config.json

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["ftagent"]
