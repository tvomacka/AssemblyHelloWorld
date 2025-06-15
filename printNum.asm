option casemap:none

extern GetProcessHeap:proc
extern HeapAlloc:proc
extern ExitProcess:proc

.data
allocSize dq 32	; Size of the memory to allocate
num dq 2	; The number to convert to a string

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
; returns the number of characters written in rax, without the trailing \0 (this might be wrong, check when outputing to console)
convert proc
	mov		r8, rdx	; store the memory pointer
	xor		r9, r9	; how many numbers have been written
	
	mov		rax, rcx	;rdx:rax are to be divided
Divide:
	xor		rdx, rdx
	mov		r10, 10	; divide by base 10

	div		r10

	add		dl, '0'	; char representation of the resulting remainder
	mov		[r8+r9], dl	; write the resulting char to memory + offset
	inc		r9	; increase the offset

	cmp		rax, 0
	jne		Divide	; if there's more to divide, keep going

	; otherwise, write the ending \0 and exit
	xor		dl, dl
	mov		[r8+r9], dl
	mov		rax, r9

	; this might need checking if we are still in the bounds of the allocated memory

	ret
convert endp

end