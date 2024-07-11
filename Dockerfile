FROM alpine:3.20

WORKDIR /home

COPY main.txt /home
RUN apk update; apk add --no-cache $(cat main.txt)

COPY edge.txt /home
RUN apk add --no-cache -U --repository http://dl-3.alpinelinux.org/alpine/edge/testing $(cat edge.txt)

COPY py_modules.txt /home
RUN python3 -m pip install --upgrade pip --break-system-packages\
    && python3 -m pip install --break-system-packages -r py_modules.txt

RUN wget -qO- "https://yihui.org/tinytex/install-unx.sh" | sh

ENV PATH=/root/.TinyTeX/bin/x86_64-linuxmusl:$PATH
RUN /root/.TinyTeX/bin/x86_64-linuxmusl/tlmgr path add

COPY tex_packages.txt /home
RUN tlmgr install $(cat tex_packages.txt)
