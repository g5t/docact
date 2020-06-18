FROM fedora:31

RUN dnf install -y \
      libomp-devel \
      pybind11-devel \
      make \
      cmake \
      git \
      doxygen \
      rsync \
      python3-devel \
      python3-pip \
    && dnf autoremove && dnf clean all

WORKDIR /home
COPY requirements.txt /home
RUN python3 -m pip install -r requirements.txt
