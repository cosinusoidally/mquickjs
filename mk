./mk_clean

FLAGS="-I.. -I . -Wall -g -D_GNU_SOURCE -fno-math-errno -fno-trapping-math -O0"

CC=tcc

set -xe

make clean

# rm dtoa.o mquickjs.o example example.o libm.o cutils.o mqjs_stdlib.h mquickjs_build.host.o mquickjs_atom.h

cd artifacts

# maybe should build this to be shared
# $CC $FLAGS -O0 -c -o builtin_tcc.o builtin_tcc.c

$CC $FLAGS -c -o mqjs_stdlib.host.o ../mqjs_stdlib_tcc.c
$CC $FLAGS -O0 -c -o mquickjs_build.host.o ../mquickjs_build_tcc.c
$CC -g -o mqjs_stdlib mqjs_stdlib.host.o mquickjs_build.host.o

./mqjs_stdlib  > mqjs_stdlib.h
./mqjs_stdlib -a  > mquickjs_atom.h

$CC $FLAGS -c -o example_stdlib.host.o ../example_stdlib_tcc.c
$CC $FLAGS -o example_stdlib example_stdlib.host.o mquickjs_build.host.o
./example_stdlib  > example_stdlib.h

$CC $FLAGS -c -o mquickjs.o ../mquickjs_tcc.c
$CC $FLAGS -c -o dtoa.o ../dtoa.c
$CC $FLAGS -c -o example.o ../example.c
$CC $FLAGS -c -o libm.o ../libm.c
$CC $FLAGS -c -o cutils.o ../cutils.c

$CC -g -o example example.o mquickjs.o dtoa.o libm.o cutils.o -lm
