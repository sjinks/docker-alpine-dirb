FROM alpine:3.23.0@sha256:51183f2cfa6320055da30872f211093f9ff1d3cf06f39a0bdb212314c5dc7375

RUN \
    apk add --no-cache gcc make curl-dev musl-dev libcurl && \
    mkdir /build && cd /build && \
    wget -q https://downloads.sourceforge.net/project/dirb/dirb/2.22/dirb222.tar.gz -O - | tar -xz --strip-components=1 -f - && \
    chmod -R a+x wordlists configure && \
    ./configure CFLAGS="-O2 -g -fcommon" && make && make install && mkdir -p /usr/share/dirb && cp -aR wordlists /usr/share/dirb && \
    cd / && apk del --no-cache gcc make curl-dev musl-dev && rm -rf /build && \
    install -d -m 0700 -o nobody -g nobody /.cache

USER nobody:nobody
VOLUME /usr/share/dirb
VOLUME /.cache
ENTRYPOINT ["/usr/local/bin/dirb"]
