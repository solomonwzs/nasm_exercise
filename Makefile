.SUFFIXES: .asm

NASM	= nasm
LD		= ld

SRC		= $(wildcard ./src/*.asm)
OBJ		= $(SRC:./src/%.asm=./build/%.o)
EXE		= $(OBJ:%.o=%.x)


.PHONY: all
all: ./build $(EXE)

./build:
	@echo -e "\033[0;33m*\033[0m $@"
	@[ -d $@ ] || mkdir $@

.SECONDARY:
./build/%.x: ./build/%.o
	@echo -e "\033[0;33m*\033[0m $@"
	@$(LD) -m elf_i386 -s -o $@ $<

./build/%.o: ./src/%.asm
	@echo -e "\033[0;33m*\033[0m $@"
	@$(NASM) -f elf $< -o $@

.PHONY: clean
clean:
	@rm -r ./build
