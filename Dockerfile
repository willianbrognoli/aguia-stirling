FROM stirlingtools/stirling-pdf:latest
USER root
RUN apt-get update && apt-get install -y --no-install-recommends libreoffice-math && rm -rf /var/lib/apt/lists/*
COPY fonts/ /usr/share/fonts/custom/
RUN fc-cache -f
