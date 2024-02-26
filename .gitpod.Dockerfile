FROM gitpod/workspace-full-vnc

RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

SHELL ["/bin/bash", "-c"]

RUN source ~/.ghcup/env

RUN echo 'export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"' >> ~/.bash_profile

RUN /home/gitpod/.ghcup/bin/ghcup install ghc 9.8.1

RUN /home/gitpod/.ghcup/bin/ghcup set ghc 9.8.1

RUN /home/gitpod/.ghcup/bin/ghcup install cabal 3.10.2.1

RUN /home/gitpod/.ghcup/bin/cabal update