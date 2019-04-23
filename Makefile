.SUFFIXES: .asm

NASM	= nasm
GCC		= gcc
LD		= ld
OBJDUMP	= objdump

SRC		= $(wildcard ./src/*.asm)
OBJ		= $(SRC:./src/%.asm=./build/%.o)
EXE		= $(OBJ:%.o=%.x)

CSRC	= $(wildcard ./csrc/*.c)
COBJ	= $(CSRC:./csrc/%.c=./build/%.o)
CEXE	= $(COBJ:%.o=%.x)


.PHONY: all
all: ./build $(EXE) $(CEXE)

./build:
	@echo -e "\033[0;33m*\033[0m $@"
	@[ -d $@ ] || mkdir $@

.SECONDARY:
./build/c_%.x: ./build/c_%.o
	@echo -e "\033[0;33m*\033[0m $@"
	@$(GCC) $< -o $@

.SECONDARY:
./build/%.x: ./build/%.o
	@echo -e "\033[0;33m*\033[0m $@"
	@$(LD) -m elf_i386 -s -o $@ $<

./build/c_%.o: ./csrc/c_%.c
	@echo -e "\033[0;33m*\033[0m $@"
	@$(GCC) -g -c $< -o $@

./build/%.o: ./src/%.asm
	@echo -e "\033[0;33m*\033[0m $@"
	@$(NASM) -f elf $< -o $@

%.s: %.o
	@echo -e "\033[0;33m*\033[0m $@"
	@$(OBJDUMP) -d -M intel -l -S $< > $@

.PHONY: clean
clean:
	@rm -r ./build
