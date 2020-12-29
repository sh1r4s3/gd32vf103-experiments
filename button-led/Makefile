AS = riscv64-unknown-elf-as
OBJCOPY = riscv64-unknown-elf-objcopy
ASFLAGS = -march=rv32imac -mabi=ilp32

all: main
	$(OBJCOPY) -O binary $< main.bin

%: %.S
	$(AS) $(ASFLAGS) $< -o $@

clean:
	rm -vf main{,.bin}
