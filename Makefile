KIND=4
IFLAGS=-funroll-all-loops -WB -std08 -module ./out -implicitnone -fpp -warn all -pedantic -fpp -Iout/ -DDKIND=$(KIND) -g

.PHONY: clean

all: out/main

out/main: src/utils.F90 src/gauss.F90 src/main.F90
	@mkdir -p out
	ifort $^ -o $@ $(IFLAGS)

out/gauss.mod: src/gauss.F90 out/utils.mod
	@mkdir -p out
	ifort $^ -c -o $@ $(IFLAGS)

out/utils.mod: src/utils.F90
	@mkdir -p out
	ifort $^ -c -o $@ $(IFLAGS)

clean:
	rm -rf out/