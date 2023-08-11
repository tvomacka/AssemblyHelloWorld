.data
    message db "Hello World!",0
    messageLength equ $-message

.code
    main proc
	    mov eax, 4h        ; write syscall
        mov ebx, 1h        ; stdout
        mov ecx, OFFSET message
        mov edx, messageLength
        int 80h

        mov eax, 1h
        mov ebx, 0
        int 80h
    main endp
    end