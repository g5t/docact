FROM fedora:31

RUN dnf install -y \
      gcc-c++ \
      pybind11-devel \
      libomp-devel \
      cmake \
      git \
      doxygen \
      rsync \
      python3-pip \
    && dnf autoremove && dnf clean all

WORKDIR /home
COPY requirements.txt /home
RUN python3 -m pip install -r requirements.txt
