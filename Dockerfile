FROM hairyhenderson/gomplate:latest as gomplate

FROM debian:bullseye

COPY --from=gomplate /gomplate /usr/bin/gomplate

RUN apt-get update \
 && apt-get install --no-install-recommends -qy samba \
 && rm -rf /var/lib/apt/lists/*

COPY smb.conf.tmpl /etc/samba/smb.conf.tmpl
COPY docker-entrypoint.sh /usr/bin/docker-entrypoint.sh

ENTRYPOINT [ "/usr/bin/docker-entrypoint.sh" ]
