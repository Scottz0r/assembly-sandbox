; Define the "add_one" symbol. Basically "extern".
global add_one

section .text
add_one:
    ; For this demo, this is a very simple function that doesn't
    ; use the stack. There are some standard steps that would
    ; need to be done if the stack was being used.

    ; On x64 ABI, the first argument is passed in rdi.
    ; The return value from functions is expected in rax.

    ; This demo is using 32-bit integers, so use the 32-bit
    ; register names ("e" instead of "r"). Move the input
    ; into the "result" register.
    mov eax, edi

    ; Add one to the result register.
    inc eax

    ; Return from the function. The x64 ABI uses "call",
    ; which pushes the return address to the stack. The
    ; "ret" command will use the return address on the
    ; stack.
    ret
