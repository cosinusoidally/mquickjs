./mk_clean

set -xe

make clean
make

rm dtoa.o mquickjs.o example example.o libm.o cutils.o mqjs_stdlib.h mquickjs_build.host.o mquickjs_atom.h

# maybe should build this to be shared
# tcc -Wall -g -D_GNU_SOURCE -fno-math-errno -fno-trapping-math -O0 -c -o builtin_tcc.o builtin_tcc.c

# tcc -Wall -g -D_GNU_SOURCE -fno-math-errno -fno-trapping-math -O0 -c -o mqjs_stdlib.host.o mqjs_stdlib.c
tcc -Wall -g -D_GNU_SOURCE -fno-math-errno -fno-trapping-math -O0 -c -o mquickjs_build.host.o mquickjs_build_tcc.c
tcc -g -o mqjs_stdlib mqjs_stdlib.host.o mquickjs_build.host.o

./mqjs_stdlib  > mqjs_stdlib.h
./mqjs_stdlib -a  > mquickjs_atom.h

tcc -Wall -g -D_GNU_SOURCE -fno-math-errno -fno-trapping-math -O0 -c -o mquickjs.o mquickjs_tcc.c
tcc -Wall -g -D_GNU_SOURCE -fno-math-errno -fno-trapping-math -O0 -c -o dtoa.o dtoa.c
tcc -Wall -g -D_GNU_SOURCE -fno-math-errno -fno-trapping-math -O0 -c -o example.o example.c
tcc -Wall -g -D_GNU_SOURCE -fno-math-errno -fno-trapping-math -O0 -c -o libm.o libm.c
tcc -Wall -g -D_GNU_SOURCE -fno-math-errno -fno-trapping-math -O0 -c -o cutils.o cutils.c

tcc -g -o example example.o mquickjs.o dtoa.o libm.o cutils.o -lm
