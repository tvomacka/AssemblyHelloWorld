; clargs.asm
; Assemble and link with:
; ml64 clargs.asm /link /subsystem:console /entry:main

extern GetCommandLineA:proc
extern ExitProcess:proc

.data
buffer dq 0

.code
main proc
    sub rsp, 28h                    ; shadow space

    call GetCommandLineA           ; returns LPSTR to full command line
    mov buffer, rax                ; save it somewhere if needed

    ; (Optional) You could parse rax manually now...

    ; Exit
    xor ecx, ecx
    call ExitProcess
main endp

end
