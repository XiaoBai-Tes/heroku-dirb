FROM debian:10

ENV SHELL=/bin/bash

RUN apt update \
 && apt install -y \
    git \
    unzip \
    sudo \
    curl \
    wget \
    vim \
    #nginx \
    screen \
    python3 \
    python3-pip \
  && rm -rf /var/lib/apt/lists/*

RUN  python3 -m pip install --upgrade pip

RUN pip3 install Flask requests
RUN cd / && mkdir dirsearch && cd dirsearch && git clone https://github.com/maurosoria/dirsearch && cd dirsearch && pip3 install -r requirements.txt
RUN cd /dirsearch && wget http://tools.ddos.li/web.tar.gz && tar -zxvf web.tar.gz

USER coder

CMD python3 app.py -p 80
