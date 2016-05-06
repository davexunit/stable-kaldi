# This assumes you've build the android toolchain, and that you want to build arm.
# This will install to /opt/arm-tools

TOOLCHAIN_PREFIX=${1:-/tmp/my-android-toolchain/bin/arm-linux-androideabi}
INSTALL_PREFIX=${2:-/opt/arm-tools}
TOOLCHAIN_INCLUDE=${3:-/tmp/my-android-toolchain/sysroot/usr/include/}
OPENBLAS_ROOT=${4:-/opt/arm-tools}

export TOOLCHAIN_PREFIX=$TOOLCHAIN_PREFIX

export CPP=${TOOLCHAIN_PREFIX}-cpp
export AR=${TOOLCHAIN_PREFIX}-ar
export AS=${TOOLCHAIN_PREFIX}-as
export NM=${TOOLCHAIN_PREFIX}-nm
export CC=${TOOLCHAIN_PREFIX}-g++
export CXX=${TOOLCHAIN_PREFIX}-g++
export LD=${TOOLCHAIN_PREFIX}-ld
export RANLIB=${TOOLCHAIN_PREFIX}-ranlib

./configure --android-openblas=yes --fst-root=/opt/arm-tools/ --openblas-root=$OPENBLAS_ROOT \
	--toolchain-includes=$TOOLCHAIN_INCLUDE --prefix=$INSTALL_PREFIX

make libs -j7
make install_libs
