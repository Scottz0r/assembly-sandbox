global jump_test

section .text
; Function that tests out the jump command.
; Expects two 32-bit integer arguments.
; Returns 32-bit integer.
jump_test:
    ; Note that this is not using stack memory, so the rbp is not
    ; set.
    ; Compare the first two 32-bit integers. If edi (minuend) is 
    ; greater than esi (subtrahend), go to ret_gt.
    ; Basically, if (edi > esi) => jump
    cmp edi, esi
    jg ret_gt
    ; Set function return to 42.
    mov eax, 42
    ; Skip to the end of the "if/else" block.
    jmp done
ret_gt:
    ; Set function return to 1337
    mov eax, 1337
done:
    ; Return from function.
    ret
