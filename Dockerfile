FROM stirlingtools/stirling-pdf:latest
USER root
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq \
 && apt-get install -y -qq --reinstall debconf 2>&1 | (grep -v "files list file" || true) \
 && apt-get install -y -qq --no-install-recommends libreoffice-math 2>&1 | (grep -v "files list file" || true) \
 && rm -rf /var/lib/apt/lists/*
COPY fonts/ /usr/share/fonts/custom/
RUN fc-cache -f
