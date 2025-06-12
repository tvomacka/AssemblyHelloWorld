; barebones.asm
; Assembles and links with:
; ml64 barebones.asm /link /entry:start /subsystem:console

; === Define syscall numbers (adjust for your Windows version if needed) ===
NtWriteFile       equ 3Ch  ; Syscall number for NtWriteFile (Win10 19041+)
NtTerminateProcess equ 2Eh ; Syscall number for NtTerminateProcess
NtStdoutHandle equ 07h ; Standard output handle (usually 07h)

.code

start proc
    ; Windows syscall numbers (valid for Windows 10.19041)
    ; These can change per Windows version!
    mov     eax, NtWriteFile              ; NtWriteFile syscall number (Windows 10 19041)
    mov     rcx, NtStdoutHandle ; Handle to stdout (usually 0x7)
    lea     rdx, io_status_block
    lea     r8, hello_message
    mov     r9d, hello_length
    mov     r10, rcx               ; syscall convention: r10 = rcx
    syscall

    ; Exit with status 0
    mov     eax, NtTerminateProcess              ; NtTerminateProcess syscall (Windows 10 19041)
    xor     rcx, rcx               ; Handle 0 = current process
    xor     rdx, rdx               ; Exit code = 0
    mov     r10, rcx
    syscall
start endp

.data
hello_message db "Hello, world!", 0Dh, 0Ah
hello_length = $ - hello_message
io_status_block dq 0, 0

end
