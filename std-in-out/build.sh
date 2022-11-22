nasm -f elf64 -g -F dwarf std-in-out.asm
ld std-in-out.o -o std-in-out.out
