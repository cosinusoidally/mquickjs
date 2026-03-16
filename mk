./mk_clean

DEST=.

FLAGS="-I.. -I $DEST -Wall -g -D_GNU_SOURCE -fno-math-errno -fno-trapping-math -O0"

set -xe

make clean
# make

# rm dtoa.o mquickjs.o example example.o libm.o cutils.o mqjs_stdlib.h mquickjs_build.host.o mquickjs_atom.h

cd artifacts

# maybe should build this to be shared
# tcc $FLAGS -O0 -c -o builtin_tcc.o builtin_tcc.c

tcc $FLAGS -c -o $DEST/mqjs_stdlib.host.o ../mqjs_stdlib_tcc.c
tcc $FLAGS -O0 -c -o $DEST/mquickjs_build.host.o ../mquickjs_build_tcc.c
tcc -g -o $DEST/mqjs_stdlib $DEST/mqjs_stdlib.host.o $DEST/mquickjs_build.host.o

$DEST/mqjs_stdlib  > $DEST/mqjs_stdlib.h
$DEST/mqjs_stdlib -a  > $DEST/mquickjs_atom.h

tcc $FLAGS -c -o $DEST/example_stdlib.host.o ../example_stdlib_tcc.c
tcc $FLAGS -o $DEST/example_stdlib $DEST/example_stdlib.host.o $DEST/mquickjs_build.host.o
$DEST/example_stdlib  > $DEST/example_stdlib.h

tcc $FLAGS -c -o $DEST/mquickjs.o ../mquickjs_tcc.c
tcc $FLAGS -c -o $DEST/dtoa.o ../dtoa.c
tcc $FLAGS -c -o $DEST/example.o ../example.c
tcc $FLAGS -c -o $DEST/libm.o ../libm.c
tcc $FLAGS -c -o $DEST/cutils.o ../cutils.c

tcc -g -o $DEST/example $DEST/example.o $DEST/mquickjs.o $DEST/dtoa.o $DEST/libm.o $DEST/cutils.o -lm
