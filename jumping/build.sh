nasm -f elf64 -g -F dwarf jump.asm
gcc runner.c jump.o -g -o jump.out
