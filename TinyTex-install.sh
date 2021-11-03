#!/bin/sh

OSNAME=$(uname)
[ -z $OSNAME ] && echo "This operating system is not supported." && exit 1

if [ -z $OSTYPE ]; then
  OSTYPE=$([ -x "$(command -v bash)" ] && bash -c 'echo $OSTYPE')
fi

TINYTEX_PRECOMPILED="TinyTex-1"
TINYTEX_SOURCE="TinyTex-source-installer"

TEXDIR=${TINYTEX_DIR:-~}/.TinyTeX
rm -rf $TEXDIR

if [ $OSNAME != 'Linux' -o $(uname -m) != 'x86_64' -o "$OSTYPE" != 'linux-gnu' ]; then
  echo "We do not have a prebuilt TinyTeX package for this operating system ${OSTYPE}."
  echo "I will try to install from source for you instead."
  tar xzf ${TINYTEX_SOURCE}.tar.gz
  ./install.sh
  mkdir -p $TEXDIR
  mv texlive/* $TEXDIR
  rm -r texlive install.sh
else
  tar xzf ${TINYTEX_PRECOMPILED}.tar.gz -C $(dirname $TEXDIR)
fi

rm -r ${TINYTEX_PRECOMPILED}.tar.gz ${TINYTEX_SOURCE}.tar.gz

cd $TEXDIR/bin/*/
./tlmgr option sys_bin ${TINYTEX_BIN:-/usr}/bin
./tlmgr postaction install script xetex  # GH issue #313
([ -z $CI ] || [ $(echo $CI | tr "[:upper:]" "[:lower:]") != "true" ]) && ./tlmgr option repository ctan
./tlmgr path add
