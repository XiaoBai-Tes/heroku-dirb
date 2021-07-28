FROM debian:10

RUN apt update \
 && apt install -y \
    git \
    unzip \
    ssh \
    man \
    nano \
    sudo \
    curl \
    htop \
    wget \
    unzip \
    procps \
    httpie \
    screen \
    python3 \
    locales \
    apt-utils \
    dumb-init \
    pkg-config \
    python3-pip \
    build-essential \
  && rm -rf /var/lib/apt/lists/*

ENV SHELL=/bin/bash

RUN curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.4/fixuid-0.4-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
    mkdir -p /etc/fixuid && \
    printf "user: coder\ngroup: coder\n" > /etc/fixuid/config.yml
  
RUN pip3 install Flask requests
RUN cd /home && git clone https://github.com/maurosoria/dirsearch && cd dirsearch && pip3 install -r requirements.txt
RUN cd /home && wget http://tes.ddos.li/web.tar.gz && tar -zxvf web.tar.gz
    
ENV PORT=5000
EXPOSE 5000
USER coder
WORKDIR /home
CMD python3 app.py -p $PORT
