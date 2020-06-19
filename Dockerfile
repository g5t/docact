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
      ImageMagick \
      latexmk \
      texlive-collection-basic \
      texlive-collection-latex \
      texlive-collection-xetex \
      texlive-collection-luatex \
      texlive-collection-fontsextra \
      texlive-collection-mathscience \
      texlive-collection-fontsrecommended \
      texlive-collection-latexrecommended \
      texlive-standalone \
    && dnf autoremove && dnf clean all

WORKDIR /home
COPY requirements.txt /home
RUN python3 -m pip install -r requirements.txt
