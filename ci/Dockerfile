FROM ubuntu:18.04

ENV LANG C.UTF-8

RUN sed -i "s@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g" /etc/apt/sources.list

RUN apt-get update && \
  apt-get install -y tzdata
ENV TZ Asia/Tokyo

RUN apt-get install -y \
  git \
  texlive-latex-extra texlive-latex-recommended \
  texlive-lang-japanese texlive-fonts-recommended texlive-luatex \
  fonts-noto-cjk fonts-noto-color-emoji fonts-noto-mono \
  build-essential curl libgmp-dev libffi-dev libncurses-dev libtinfo5 && \
  apt-get autoremove -y

RUN mkdir -p ~/.ghcup/bin && \
  mkdir -p ~/.cabal/bin && \
  curl https://gitlab.haskell.org/haskell/ghcup/raw/master/ghcup > ~/.ghcup/bin/ghcup && \
  chmod +x ~/.ghcup/bin/ghcup
ENV PATH /root/.ghcup/bin:/root/.cabal/bin:$PATH

RUN ghcup list -t all && \
  ghcup install 8.8.1 && \
  ghcup set 8.8.1 && \
  ghcup install-cabal latest

RUN cabal user-config init && \
  sed -E -i "s/^-- *write-ghc-environment-files:.*$/write-ghc-environment-files: ghc8.4.4+/g" /root/.cabal/config && \
  cabal v2-update

RUN cabal v2-install doctest shake --installdir=/root/.cabal/bin

RUN git clone --depth 1 https://github.com/wtsnjp/llmk.git /root/llmk && \
  cd /root/llmk && \
  ln -s llmk.lua llmk
ENV PATH /root/llmk:$PATH

CMD shake
