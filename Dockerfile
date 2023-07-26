FROM debian:bookworm

ARG JANET_VERSION
ARG JPM_VERSION

RUN apt update && apt install -y git make build-essential libssl-dev wget

RUN mkdir -p /home/janet

RUN cd /home/janet && git clone https://github.com/janet-lang/janet.git

RUN cd /home/janet/janet && git pull && git reset --hard $JANET_VERSION

RUN cd /home/janet/janet && make

RUN cd /home/janet/janet && make install

RUN cd /home && git clone --depth 1 --branch $JPM_VERSION https://github.com/janet-lang/jpm.git

RUN cd /home/jpm && janet bootstrap.janet

WORKDIR /home/binary-size-test

CMD ["/usr/bin/bash"]
