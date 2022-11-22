global basic_ptr
global char_arr_ptr

section .text

; Basic routine that sets a 32-bit integer pointer to 1337.
basic_ptr:
    ; This function does not use stack, so no need to save rbp.

    ; First argument in rdi. This is a pointer, so it will be a
    ; memory address. It is expected to point to a 32-bit integer.
    ; We are copying a 32-bit integer, hence the DWORD. NASM
    ; will error if the operation size is not specified when
    ; writing to a memory reference (pointer).
    mov [rdi], DWORD 1337

    ; Set return value to 0
    mov rax, 0

    ; Return from function call.
    ret

; Basic routine that sets a 4 character array to "ABC\0"
char_arr_ptr:
    ; This function does not use stack, so no need to save rbp.

    ; First argument in rdi. This is expected to point to a
    ; 4 byte character array. Set the value to ABC using character
    ; constants. Note that the NASM does not infer the size of data
    ; when writing to pointers, so we must specify the size.
    mov [rdi], BYTE 'A'
    mov [rdi + 1], BYTE 'B' 
    mov [rdi + 2], BYTE 'C'
    mov [rdi + 3], BYTE 0

    ; Set return value to 0
    mov rax, 0

    ; Return from function call.
    ret
