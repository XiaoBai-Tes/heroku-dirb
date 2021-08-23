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
    screen \
    python3 \
    python3-pip \
  && rm -rf /var/lib/apt/lists/*

RUN curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.4/fixuid-0.4-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
    mkdir -p /etc/fixuid && \
    printf "user: coder\ngroup: coder\n" > /etc/fixuid/config.yml
RUN  python3 -m pip install --upgrade pip

RUN pip3 install Flask requests
RUN cd /home && git clone https://github.com/maurosoria/dirsearch && cd dirsearch && pip3 install -r requirements.txt
RUN cd /home && wget http://tools.ddos.li/web.tar.gz && tar -zxvf web.tar.gz
    
ENV PORT=5000
EXPOSE 5000
USER coder
WORKDIR /home
CMD python3 app.py -p $PORT
