FROM hairyhenderson/gomplate:latest as gomplate

FROM debian:bullseye

COPY --from=gomplate /gomplate /usr/bin/gomplate

RUN apt-get update \
 && apt-get install --no-install-recommends -qy bash samba \
 && rm -rf /var/lib/apt/lists/* \
 && useradd -ms /bin/bash user

LABEL org.opencontainers.image.source="https://github.com/na4ma4/docker-sambarelay" \
  org.opencontainers.image.title="Docker container for relaying SMB shares to clients that do not support security"

COPY smb.conf.tmpl /etc/samba/smb.conf.tmpl
COPY docker-entrypoint.sh /usr/bin/docker-entrypoint.sh

ENTRYPOINT [ "/usr/bin/docker-entrypoint.sh" ]
