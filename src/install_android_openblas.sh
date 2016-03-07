# This assumes you've build the android toolchain, and that you want to build arm.
# This will install to /opt/arm-tools

export TOOLCHAIN_PREFIX=/tmp/my-android-toolchain/bin/arm-linux-androideabi

export CPP=${TOOLCHAIN_PREFIX}-cpp
export AR=${TOOLCHAIN_PREFIX}-ar
export AS=${TOOLCHAIN_PREFIX}-as
export NM=${TOOLCHAIN_PREFIX}-nm
export CC=${TOOLCHAIN_PREFIX}-g++
export CXX=${TOOLCHAIN_PREFIX}-g++
export LD=${TOOLCHAIN_PREFIX}-ld
export RANLIB=${TOOLCHAIN_PREFIX}-ranlib

./configure --mathlib=OPENBLAS --static --fst-root=/opt/arm-tools/ --openblas-root=/opt/arm-tools
sed -i.bak 's/CXX = g++//g' ./kaldi.mk
sed -i.bak 's/CC = $(CXX)//g' ./kaldi.mk
sed -i.bak 's/RANLIB = ranlib//g' ./kaldi.mk
sed -i.bak 's/AR = ar//g' ./kaldi.mk
# Add some openblas flags to use hardfloat
sed -i.bak 's/CXXFLAGS += -msse -msse2 / CXXFLAGS += -mhard-float -D_NDK_MATH_NO_SOFTFP=1 -I\/opt\/arm-tools\/include  -I\/tmp\/my-android-toolchain\/sysroot\/usr\/include /g' ./kaldi.mk
sed -i.bak 's/-DHAVE_EXECINFO_H=1//g' ./kaldi.mk
# Openblas flags for hardfloat
sed -i.bak 's/LDFLAGS = -g/LDFLAGS = -Wl,--no-warn-mismatch -lm_hard/g' ./kaldi.mk
# android does not need pthread
sed -i.bak 's/-lpthread//g' ./kaldi.mk
sed -i.bak 's/-ldl -lm  -framework Accelerate/ \/opt\/arm-tools\/lib\/libopenblas.a \/opt\/arm-tools\/lib\/libclapack.a \/opt\/arm-tools\/lib\/liblapack.a \/opt\/arm-tools\/lib\/libblas.a \/opt\/arm-tools\/lib\/libf2c.a -ldl -lm/g' ./kaldi.mk
make
make install