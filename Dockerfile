FROM alpine:3.16.1

USER root

RUN apk update && apk add --no-cache wget icu-data-full tar gzip perl

WORKDIR /tmp

RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz

RUN tar xvf install-tl-unx.tar.gz

RUN cd install-tl-2* && \
    perl ./install-tl -no-gui -repository http://mirror.ctan.org/systems/texlive/tlnet/ --no-interaction --scheme small

RUN /usr/local/texlive/2022/bin/x86_64-linuxmusl/tlmgr path add

RUN tlmgr init-usertree

RUN tlmgr update --self --all

RUN tlmgr install luatexja
RUN tlmgr install latexmk
RUN tlmgr install latex-bin
RUN tlmgr install cjk

WORKDIR /work