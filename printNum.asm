option casemap:none

extern GetProcessHeap:proc
extern HeapAlloc:proc
extern ExitProcess:proc

.data
allocSize dq 32	; Size of the memory to allocate (4 bytes for int + 28 bytes for string)
num dq 42	; The number to convert to a string

.code
main proc
	sub		rsp, 40h ; Allocate stack space for local variables

	call	GetProcessHeap ; Get the process heap handle
	mov		rcx, rax ; Store the heap handle in rcx
	mov		rdx, 0 ; Zero out rdx for the flags parameter
	mov		r8, allocSize ; Size of the memory to allocate
	call	HeapAlloc ; Allocate memory from the heap

	sub		rsp, 40h ; Allocate space for the string (32 bytes)
	mov		rcx, num ; Load the number to convert into rcx
	mov 	rdx, rax ; Pointer to the allocated memory for the string in rdx
	call	convert ; Convert the number to a string
	add		rsp, 40h ; Adjust stack pointer for alignment

	; Clean up and exit
	add		rsp, 40h ; Deallocate stack space
	xor		ecx, ecx ; Set exit code to 0
	call	ExitProcess ; Exit the process
main endp

; Convert a number to a string representation
; rcx - the number to convert
; rdx - pointer to the allocated memory for the string
; returns the number of characters written in rax
convert proc
	mov		r8, rdx	; store the memory pointer
	xor		r9, r9	; how many numbers have been written
	xor		rdx, rdx
	mov		rax, rcx	;rdx:rax are to be divided
	mov		r10, 10	; divide by base 10

	div		r10

	ret
convert endp

end