; Define start as a global symbol. "_start" is the special
; entry point for programs. This label must be defined
; in this module.
global _start

; This section holds data. This is similar to a C
; static constant. The "Dx" commands declares initialized
; data.
section .data
; Delcare a string message. Null termnate with 0. The ` are
; used to allow for escapes in NASM.
message0: db `Hello, World\n`, 0
; Define the length of the message. The $ takes the current
; address. Taking the current address and subtracting the
; message's start gives the length in bytes.
message0_len: equ $ - message0

; This uses double quotes, so \n cannot be used for newline.
; Commas can be used to add specific bytes.
message1: db "Hello, World", 10, 0
message1_len: equ $ - message1

; The code section.
section .text
_start:
    ; System call number for write.
    mov rax, 1
    ; stdout handle = 1 (arg1)
    mov rdi, 1
    ; Move message pointer (arg2)
    mov rsi, message0
    ; Move number of bytes in message (arg3)
    mov rdx, message0_len
    ; Invoke system call.
    syscall

    ; Do the same for the second message.
    mov rax, 1
    mov rdi, 1
    mov rsi, message1
    mov rdx, message1_len
    syscall

    ; Must call exit syscall, otherwise this will segfault.
    ; System call number for exit
    mov rax, 60
    ; Exit code argument. Make this not zero to be more obvious
    ; when testing.
    mov rdi, 4
    ; Invoke system call.
    syscall

    ; Now the program is done.
