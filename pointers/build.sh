# Assembly the assembly part.
nasm -f elf64 -g -F dwarf pointers.asm
# Build the C file with GCC and link with GCC.
gcc runner.c pointers.o -g -o pointers.out
