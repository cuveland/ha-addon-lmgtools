ARG BUILD_FROM
FROM $BUILD_FROM

# Version of cuveland/lmgtools to install (git tag)
ARG LMGTOOLS_VERSION=v0.2.0

RUN apk add --no-cache python3 py3-pip && \
    pip3 install --no-cache-dir --break-system-packages \
        "https://github.com/cuveland/lmgtools/archive/refs/tags/${LMGTOOLS_VERSION}.tar.gz"

COPY run.sh /
RUN chmod +x /run.sh

CMD ["/run.sh"]
