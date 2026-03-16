./mk_clean

set -xe

make clean
make

rm dtoa.o mquickjs.o example

# maybe should link the builtin_tcc separately
# tcc -Wall -g -D_GNU_SOURCE -fno-math-errno -fno-trapping-math -O0 -c -o builtin_tcc.o builtin_tcc.c
tcc -Wall -g -D_GNU_SOURCE -fno-math-errno -fno-trapping-math -O0 -c -o mquickjs.o mquickjs_tcc.c
tcc -Wall -g -D_GNU_SOURCE -fno-math-errno -fno-trapping-math -O0 -c -o dtoa.o dtoa.c

tcc -g -o example example.o mquickjs.o dtoa.o libm.o cutils.o -lm
