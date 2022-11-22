# Assembly the assembly part.
nasm -f elf64 -g -F dwarf my_strlen.asm
# Build the C file with GCC and link with GCC.
gcc runner.c my_strlen.o -g -o strlen.out
