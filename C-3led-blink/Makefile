CC := riscv64-unknown-elf-gcc
AS := riscv64-unknown-elf-as
LD := riscv64-unknown-elf-ld
OBJCOPY := riscv64-unknown-elf-objcopy
LDFLAGS := -m elf32lriscv -b elf32-littleriscv -nostdlib --script ../C_helper/link.ld
CFLAGS := -mabi=ilp32 -march=rv32imac
CPPFLAGS := -I../C_helper
ASFLAGS := -mabi=ilp32 -march=rv32imac
LIBGD32 := ../C_helper/libgd32.a

all: prog.bin

prog.bin: prog
	$(OBJCOPY) -O binary $< $@

prog: main.o
	$(LD) $(LDFLAGS) $^ $(LIBGD32) -o prog

clean:
	rm -vf prog{,.bin} *.o
