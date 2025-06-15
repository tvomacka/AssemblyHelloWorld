; hello.asm
; Assemble with: ml64 hello.asm /link /subsystem:console /entry:main

.data
    helloMessage db "Hello, world!", 0Dh, 0Ah
    helloLength  equ $ - helloMessage
    dummyWritten dq 0

.code
main proc
    sub     rsp, 28h                ; Shadow space

    ; Get handle to stdout
    mov     rcx, -11                ; STD_OUTPUT_HANDLE
    call    GetStdHandle

    ; Save handle
    mov     rcx, rax                ; hConsoleOutput
    lea     rdx, helloMessage       ; lpBuffer
    mov     r8d, helloLength        ; nNumberOfCharsToWrite
    lea     r9, dummyWritten        ; lpNumberOfCharsWritten
    sub     rsp, 20h                ; Allocate shadow space
    call    WriteConsoleA
    add     rsp, 20h

    ; Exit process
    xor     ecx, ecx                ; uExitCode
    call    ExitProcess
main endp

; Manually import the necessary Windows API functions
; These are declared as extern and resolved during linking
extern GetStdHandle:proc
extern WriteConsoleA:proc
extern ExitProcess:proc

end
