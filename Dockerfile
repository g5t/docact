FROM alpine:latest

WORKDIR /home

COPY main.txt /home
COPY community.txt /home

RUN apk add -U --repository http://dl-3.alpinelinux.org/alpine/edge/main $(cat main.txt)
RUN apk add -U --repository http://dl-3.alpinelinux.org/alpine/edge/community $(cat community.txt)

COPY requirements.txt /home
RUN python3 -m pip install -r requirements.txt

COPY tex.txt /home
COPY TinyTex* /home 
RUN sh TinyTex-install.sh
RUN tlmgr install $(cat tex.txt)
