FROM alpine:3.18.2@sha256:82d1e9d7ed48a7523bdebc18cf6290bdb97b82302a8a9c27d4fe885949ea94d1

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
