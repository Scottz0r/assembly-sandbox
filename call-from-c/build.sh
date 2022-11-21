# Assembly the assembly part.
nasm -f elf64 -g -F dwarf asm_part.asm
# Build the C file with GCC and link with GCC.
gcc c_part.c asm_part.o -g -o call-from-c.out
