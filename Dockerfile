FROM fedora:35

WORKDIR /home

COPY packages.txt /home
RUN dnf install -y $(cat packages.txt) && dnf autoremove && dnf clean all

COPY requirements.txt /home
RUN python3 -m pip install -r requirements.txt
