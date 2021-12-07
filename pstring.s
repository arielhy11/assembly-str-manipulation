#   //313450249 Ariel Mantel
	.globl	pstrlen
	.type	pstrlen, @function
pstrlen:
xor %rax, %rax
movb (%rdi), %al
ret

        .globl	replaceChar
	.type	replaceChar, @function
replaceChar:
movq %rdi, %rax #save rdi
addq $1, %rdi
.for:
    cmpq $0, (%rdi)
    je .return
    
    cmpb (%rdi), %sil #checking if the char in rsi is equel to current char in rdi
    je .switch
    addq $1, %rdi
    jmp .for


.switch:
    movb %dl, (%rdi)
    addq $1, %rdi
    jmp .for
.return:
    ret
    
        .globl	pstrijcpy
	.type	pstrijcpy, @function
pstrijcpy:
movq %rdi, %rax #save rdi

addq $1, %rdi #skip the str size
addq $1, %rsi #skip the str size
addq %rdx, %rdi #get to the right index
addq %rdx, %rsi

.while:
    cmp %rcx, %rdx
    jg .return
    movb (%rsi), %bl
    movb %bl, (%rdi)
    add $1, %rdx
    add $1, %rdi
    add $1, %rsi
    jmp .while
    
        .globl	swapCase
	.type	swapCase, @function
swapCase:
movq %rdi, %rax #save rdi
addq $1, %rdi
.forForth:
    cmp $0, (%rdi)
    je .return
    
    cmpb $65, (%rdi)
    jge .secondUpperTest #if yes upCase
    jmp .lowerCheck #if not
    
.secondUpperTest:
    cmpb $90, (%rdi)
    jle .swapDown
    jmp .lowerCheck
.swapDown:
    addb $32, (%rdi)
    addq $1, %rdi
    jmp .forForth

.lowerCheck:
    cmpb $97, (%rdi)
    jge .secondLowerCheck
    add $1, %rdi
    jmp .forForth
.secondLowerCheck:
    cmpb $122, (%rdi)
    jle .swapUp
.swapUp:
    subb $32, (%rdi)
    addq $1, %rdi
    jmp .forForth
    
        .globl	pstrijcmp
	.type	pstrijcmp, @function
pstrijcmp:
movq %rdi, %rax #save rdi

addq $1, %rdi #skip the str size
addq $1, %rsi #skip the str size
addq %rdx, %rdi #get to the right index
addq %rdx, %rsi

.whileFifth:
    cmpq %rcx, %rdx
    movq $0, %rax
    jg .return
    movb (%rdi), %r10b
    cmpb %r10b, (%rsi)
    jg .greater
    jl .less
    movb (%rsi), %bl
    movb %bl, (%rdi)
    add $1, %rdx
    add $1, %rdi
    add $1, %rsi
    jmp .whileFifth

.greater:
    movq $-1, %rax
    ret
.less:
    movq $1, %rax
    ret
    