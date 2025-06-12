; clargs.asm
; Assemble and link with:
; ml64 clargs.asm /link /subsystem:console /entry:main

extern GetCommandLineA:proc
extern ExitProcess:proc

.data
buffer dq 0
bufferSize dq 0
dummyWritten dq 0

.code
main proc
    sub rsp, 28h                    ; shadow space

    call GetCommandLineA            ; returns LPSTR to full command line
    mov buffer, rax                 ; save it somewhere if needed
    
    ; Get length of command line
    mov     rcx, buffer       ; argument goes in rcx
    sub     rsp, 28h          ; shadow space (32 bytes) + 8-byte alignment padding
    call    strlo
    add     rsp, 28h          ; restore stack
    mov     bufferSize, rax  ; save length of command line

    ; Get handle to stdout
    mov     rcx, -11                ; STD_OUTPUT_HANDLE
    call    GetStdHandle

    ; Save handle
    mov     rcx, rax                ; hConsoleOutput
    mov     rdx, buffer             ; lpBuffer
    movzx   r8d, byte ptr [bufferSize]         ; nNumberOfCharsToWrite
    lea     r9, dummyWritten        ; lpNumberOfCharsWritten
    sub     rsp, 20h                ; Allocate shadow space
    call    WriteConsoleA
    add     rsp, 20h

    ; Exit
    xor     ecx, ecx
    call    ExitProcess
main endp

strlo proc
    xor     rax, rax
    mov     rdi, rcx  ; rdi points to the command line string
    l1:
    cmp     word ptr [rdi], 0
    je      l2
    inc     rdi
    inc     rax
    jmp     l1
    l2:
    ret
strlo endp

; Manually import the necessary Windows API functions
; These are declared as extern and resolved during linking
extern GetStdHandle:proc
extern WriteConsoleA:proc
extern ExitProcess:proc

end
