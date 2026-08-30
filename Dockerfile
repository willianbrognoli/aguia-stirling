FROM stirlingtools/stirling-pdf:latest
USER root
RUN apk add --no-cache libreoffice-math
COPY fonts/ /usr/share/fonts/custom/
RUN fc-cache -f
