FROM ubuntu:18.04

ENV LANG C.UTF-8

RUN sed -i "s@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g" /etc/apt/sources.list

RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get dist-upgrade -y && \
  apt-get install -y tzdata
ENV TZ Asia/Tokyo

RUN apt-get install -y \
  git wget \
  texlive-latex-extra texlive-latex-recommended \
  texlive-lang-japanese texlive-fonts-recommended texlive-luatex \
  fonts-noto-cjk fonts-noto-cjk-extra fonts-noto-color-emoji fonts-noto-mono fonts-ubuntu fontconfig \
  build-essential curl libgmp-dev libffi-dev libncurses-dev libtinfo5 && \
  apt-get autoremove -y

RUN fc-cache -fv && luaotfload-tool -vvv --update

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
  cabal v2-update --global

RUN cabal v2-install doctest shake fused-effects --global --installdir=/root/.cabal/bin

RUN git clone --depth 1 https://github.com/wtsnjp/llmk.git /root/llmk && \
  cd /root/llmk && \
  ln -s llmk.lua llmk
ENV PATH /root/llmk:$PATH

# RUN wget --trust-server-names "https://osdn.net/frs/redir.php?m=ymu&f=mytexpert%2F26068%2Fjlisting.sty.bz2" && \
#   bunzip2 jlisting.sty.bz2 && \
#   cp jlisting.sty /usr/share/texlive/texmf-dist/tex/latex/listings/ && \
#   chmod 644 /usr/share/texlive/texmf-dist/tex/latex/listings/jlisting.sty && \
#   mktexlsr

ENTRYPOINT ["./Shakefile.hs", "scratch"]
