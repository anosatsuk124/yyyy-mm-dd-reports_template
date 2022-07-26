FROM archlinux:latest

USER root

RUN pacman -Syy && pacman -S wget tar gzip perl git perl-yaml-tiny perl-file-homedir perl-unicode-linebreak fish bash --noconfirm
# icu-data-full
WORKDIR /tmp

RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz

RUN tar xvf install-tl-unx.tar.gz

RUN cd install-tl-2* && \
    perl ./install-tl -no-gui -repository http://mirror.ctan.org/systems/texlive/tlnet/ --no-interaction --scheme small

RUN /usr/local/texlive/2022/bin/x86_64-linux/tlmgr path add

RUN tlmgr init-usertree

RUN tlmgr update --self --all

RUN tlmgr install luatexja
RUN tlmgr install latexmk
RUN tlmgr install latex-bin
RUN tlmgr install cjk
RUN tlmgr install latexmk
RUN tlmgr install haranoaji haranoaji-extra

RUN wget https://github.com/jgm/pandoc/releases/download/2.18/pandoc-2.18-linux-amd64.tar.gz && \
    tar xvf pandoc-2.18-linux-amd64.tar.gz && \
    mv pandoc-2.18 /usr/local/pandoc && \
    echo "export PATH=/usr/local/pandoc/bin:${PATH}" > /etc/profile.d/pandoc.sh

RUN tlmgr install latexindent
RUN tlmgr path add

WORKDIR /work
