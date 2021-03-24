CC := riscv64-unknown-elf-gcc
AR := riscv64-unknown-elf-ar
ARFLAGS := rs --target=elf32-littleriscv
CFLAGS := -mabi=ilp32 -march=rv32imac
ASFLAGS := $(CFLAGS)

all: gd32vf103.o start.o
	$(AR) $(ARFLAGS) libgd32.a $^

clean:
	rm -vf *.a *.o
