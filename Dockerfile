FROM stirlingtools/stirling-pdf:latest
USER root
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq \
 && apt-get install -y -qq --reinstall debconf 2>&1 | (grep -v "files list file" || true) \
 && for i in 1 2 3 4 5; do \
      apt-get install -y -qq --no-install-recommends libreoffice-math 2>&1 | (grep -v "files list file" || true) && break; \
      for p in $(dpkg -l | awk '$1=="iF" || $1=="iU" {print $2}'); do \
        for f in "/var/lib/dpkg/info/$p.postinst" "/var/lib/dpkg/info/${p%%:*}.postinst"; do \
          [ -e "$f" ] && printf '#!/bin/sh\nexit 0\n' > "$f" && chmod +x "$f"; \
        done; \
      done; \
      dpkg --configure -a 2>&1 | (grep -v "files list file" || true) || true; \
    done \
 && test -f /usr/lib/libreoffice/program/libsmlo.so \
 && rm -rf /var/lib/apt/lists/*
COPY fonts/ /usr/share/fonts/custom/
RUN fc-cache -f
