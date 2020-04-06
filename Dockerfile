FROM alpine:3.11.5

# Installing required packages
RUN apk add bash
RUN apk add bison
RUN apk add gawk
RUN apk add gcc
RUN apk add g++
RUN apk add git
RUN apk add m4
RUN apk add make
RUN apk add perl
RUN apk add python3
RUN apk add texinfo

# Symlinks
RUN ln -sf /bin/bash /bin/sh
RUN mkdir /lightbulb
WORKDIR /lightbulb
