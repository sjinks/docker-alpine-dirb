FROM alpine:3.16.2@sha256:bc41182d7ef5ffc53a40b044e725193bc10142a1243f395ee852a8d9730fc2ad

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
