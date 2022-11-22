; This module shows a more realistic use of assembly, even though
; the string length implementations here are probably just as
; good or worse than the standard library's implementation.
;
; Concepts used here are:
;   - Pointers
;   - Comparison
;   - Basic arithmetic
;
; Note about labels used in this file:
;
;   NASM syntax uses periods on labels to denote a local label.
;   These labels are scoped to the previous label without a
;   period. This makes it very useful to declare labels with
;   common names (i.e. "loop").
global my_strlen
global my_strlen_safe

section .text

; String length implemented in assembly.
; Expects first argument to be a pointer to a null terminated
;   character array (const char*). [rdi]
my_strlen:
    ; Initialize return value to zero.
    mov rax, 0

    ; Test that the given char pointer, in rdi, is not null.
    cmp rdi, 0
    je .return

    ; Not null pointer, so loop until a null charcter is found.
    ; Move the pointer into rax so the original pointer address
    ; is preserved for the end.
    mov rax, rdi
.loop:
    ; Test if null character. If it is, stop looping.
    cmp BYTE [rax], BYTE 0
    je .done

    ; Advance the pointer address by one byte and jump to the
    ; start of the loop.
    inc rax
    jmp .loop

.done:
    ; At this point, rax points to the null character and rdi
    ; points to the beginning of the string. A simple subtraction
    ; will get the length of the string, not including the null
    ; terminator. Keep the result in rax as the return value of
    ; the function.
    sub rax, rdi

.return:
    ; No stack used by this function, so no need to restore rbp.
    ret


; Safe string length implementation in assembly.
; Expects first argument to be a pointer to a null terminated
;   string (const char*). [rdi]
; Expects second argument to be the maximum possible length 
;   (size_t). [rsi]
my_strlen_safe:
    ; Initialize rax to the start of the string.
    mov rax, rdi

    ; Null pointer case. Safe to jump to the return block
    ; because rax will be the same address as rdi, resulting
    ; in 0 length.
    cmp rdi, 0
    je .return

.loop:
    ; Test if the length limit has been reached. Do this
    ; before decrement (ie x-- instead of --x).
    cmp rsi, 0
    je .return

    ; Reduce the remaining bytes available by 1.
    dec rsi

    ; Test if character pointer to by rax is null. If it is,
    ; stop looping.
    cmp BYTE [rax], BYTE 0
    je .return

    ; Advance the pointer by one byte and loop again.
    inc rax
    jmp .loop

.return:
    ; Calculate the length by simple subtraction of null char
    ; address - start. If this is the null pointer case, the
    ; start and end will be the same, safely resulting in 0.
    sub rax, rdi

    ; No stack used by this function, so no need to restore rbp.
    ret
