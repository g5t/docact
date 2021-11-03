FROM alpine:3.14

WORKDIR /home

COPY main.txt /home
RUN apk add -U --repository http://dl-3.alpinelinux.org/alpine/3.14/main $(cat main.txt)

COPY community.txt /home
RUN apk add -U --repository http://dl-3.alpinelinux.org/alpine/3.14/community $(cat community.txt)

COPY testing.txt /home
RUN apk add -U --repository http://dl-3.alpinelinux.org/alpine/edge/testing $(cat testing.txt)

COPY py_modules.txt /home
RUN python3 -m pip install -r py_modules.txt

COPY tex_packages.txt /home
COPY TinyTex* /home 
RUN sh TinyTex-install.sh
RUN tlmgr install $(cat tex_packages.txt)
