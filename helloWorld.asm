.code
	mov eax, 0x4        ; write syscall
    mov ebx, 0x1        ; stdout
    mov ecx, message
    mov edx, message-length
    int 0x80

    mov eax, 0x1
    mov ebx, 0
    int 0x80

.data:
    message: db "Hello World!", 0xA
    message-length equ $-message