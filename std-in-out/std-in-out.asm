; This demo is a pure assembly program that reads data from the standard input
; and echos the data back to the standard output. It will also print out the
; number of bytes read by the operation.
;
; Note that reading from stdin will include newlines, so character counts
; printed will look off by 1.

; Define a macro to specify number of bytes in the input buffer.
%define buff_size 64

global _start

section .text
_start:
    ; Read from stdin.
    mov rax, 0          ; Read syscall number
    mov rdi, 0          ; stdin handle
    mov rsi, buffer     ; Buffer address
    mov rdx, buff_size  ; Buffer size (from macro)
    syscall

    ; Save the count of bytes read in r12 register.
    mov r12, rax

    ; Make a 20 byte charcter buffer on the stack. Use subtraction because the
    ; stack grows towards zero address. 20 was selected because that is the
    ; number of characters needed to hold a 64-bit integer 
    ; (18446744073709551615) No need to reclaim this stack space because the 
    ; program exits from this routine.
    sub rsp, 20

    ; Print out the number of bytes read, converting the integer to ASCII
    ; via our custom subroutine. RAX should be the number to convert at this
    ; point. This will pass the stack allocated buffer to the function. Note
    ; that the address of the stack allocated buffer is where rsp is becuase
    ; the stack "grows" towards zero, so the buffer is contained in the range
    ; [rsp, rsp + 16), which is convinenant in this case becase we do not need
    ; to add anything to get to the start of the buffer.
    mov rdi, r12        ; Function param 1
    mov rsi, rsp        ; Function param 2.
    call uint_to_str

    ; Print the converted number. rax will have the number of characters to
    ; print, so move this out of rax first.
    mov rdx, rax        ; Number of bytes to write
    mov rax, 1          ; Write syscall number
    mov rdi, 1          ; stdout handle
    mov rsi, rsp        ; buffer address (stack allocated buffer)
    syscall

    ; Print out a newline. Use the stack allocated buffer to do this.
    ; Move newline character into first byte of buffer.
    mov BYTE [rsp], `\n`
    ; Make system call to print.
    mov rax, 1          ; Write syscall number
    mov rdi, 1          ; stdout handle
    mov rsi, rsp        ; buffer address (stack allocated buffer)
    mov rdx, 1          ; Just write 1 byte
    syscall

    ; Echo back to stdout.
    mov rax, 1          ; Write syscall number
    mov rdi, 1          ; stdout handle
    mov rsi, buffer     ; Buffer address
    mov rdx, r12        ; Number of bytes to write
    syscall

    ; Must call exit, otherwise it'll seg fault.
    mov rax, 60
    mov rdi, 0
    syscall


; Convert an unsigned integer into an ASCII string, not null terminated. This
; assumes (poorly) that the buffer given by rsi is large enough to hold the
; result.
; 
; Arguments:
;   rdi: Unsigned Number
;   rsi: Buffer to write to
;
; Returns:
;   rax: Number of bytes
uint_to_str:
    ; Standard function entry (Save caller's base pointer, set this frame's base
    ; pointer).
    push rbp
    mov rbp, rsp

    ; Move the number to convert (rdi) into rax because rax is used as the
    ; dividend in the DIV operation.
    mov rax, rdi

    ; Local variables stored in registers. r10 and r11 are selected because the
    ; Unix ABI states these will be destroyed by function calls, so we do not
    ; need to preserve them in the stack (technically, the Unix ABI is not at
    ; play here because this is a pure assembly program).
    mov r10, 0          ; Initialize character count to 0.
    mov r11, 10         ; Initialize register that is divisor.
.loop:
    ; Divide working number by 10. This works on a 128-bit number, so need to
    ; clear out the bits in the "high" register rdx. There is no immediate
    ; flavor of DIV, so the constant 10 is stored in r11. The quotient will
    ; be in rax, and the remainder will be in rdx.
    xor rdx, rdx
    div r11

    ; Push the remainder to the stack.
    push rdx

    ; Add one character count
    inc r10

    ; Check if the quotent still has a value. If so, keep looping.
    cmp rax, 0
    jne .loop

    ; Set rax to 0 so it can be used to track the numbers popped off the stack
    ; and converted to ASCII.
    mov rax, 0

    ; Pop the stack to get the numbers in reverse order. Convert these to ASCII
    ; by adding it to '0'. Place into the return buffer.
.pop_loop:
    ; Get number off stack.
    pop rdx

    ; Add to '0' to convert to ASCII.
    add rdx, '0'

    ; Place in result buffer.
    mov [rsi], dl

    ; Go to next byte in buffer
    inc rsi

    ; Track count of characters processed.
    inc rax

    ; Jump back to the start if there are more characters to process.
    cmp r10, rax
    jne .pop_loop

    ; At this point rax will have the number of characters popped of the stack,
    ; which is the value we want to return.

    ; Restore the stack. This isn't strictly needed, but done for safety in
    ; case something extra got added to the stack. Converting an integer to 
    ; ASCII isn't the highest performance feature, so an extra instruction here
    ; is reasonable.
    mov rsp, rbp
    ; Restore caller's base pointer.
    pop rbp
    ; Return from subroutine.
    ret


; Uninitialized data section ("static" data in C)
section .bss
; Define a character buffer.
buffer: resb buff_size
