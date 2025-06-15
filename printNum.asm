option casemap:none

extern GetProcessHeap:proc
extern HeapAlloc:proc
extern ExitProcess:proc

.data
allocSize dq 32	; Size of the memory to allocate (4 bytes for int + 28 bytes for string)

.code
main proc
	sub		rsp, 40h ; Allocate stack space for local variables

	call	GetProcessHeap ; Get the process heap handle
	mov		rcx, rax ; Store the heap handle in rcx
	mov		rdx, 0 ; Zero out rdx for the flags parameter
	mov		r8, allocSize ; Size of the memory to allocate
	call	HeapAlloc ; Allocate memory from the heap

	; Clean up and exit
	add		rsp, 40h ; Deallocate stack space
	xor		ecx, ecx ; Set exit code to 0
	call	ExitProcess ; Exit the process
main endp
end