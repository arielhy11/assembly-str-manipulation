.section .rodata

.align 8
.JUMPTABLE:
.quad .Lfirst # case 50 
.quad .Ldefault # case 51: loc_def 
.quad .Lsecond # case 52
.quad .Lthird # case 53
.quad .Lforth # case 54
.quad .Lfifth # case 55
.quad .Ldefault # case 56: loc_def 
.quad .Ldefault # case 57: loc_def 
.quad .Ldefault # case 58: loc_def 
.quad .Ldefault # case 59: loc_def 
.quad .Lfirst # case 60 

format_c:   .string " %c"
format_s:   .string "%s"
format_d:   .string "%d"
format_space:   .string "\0"
print_pstrlen: .string "first pstring length: %d, second: %d\n"
print_replace_char: .string "old char: %c, new char: %c, first string %s, second string %s\n"


.text

###### BELONGS TO run_main.s
.global main
.type main, @function
main:
    movq %rsp, %rbp #for correct debugging
    # write your code here
    push %rbp
    movq %rsp, %rbp

    sub $544, %rsp #making place in stack
    
    movq $format_d, %rdi #getting first size
    leaq -544(%rbp), %rsi
    xor %rax, %rax
    call scanf
    
    movq $format_s, %rdi#getting first string
    leaq -543(%rbp), %rsi
    xorq %rax, %rax
    call scanf
    
    movq $0, %rax   #add "\0" to end of string. first delete rax
    movb -544(%rbp), %al # put the char in rax
    sub $48, %rax # make the number align to 0 from the asci (MABEY NOT GOOD!)
    leaq -543(%rbp, %rax), %rax #go to the end of string
    movq format_space, %rax #put there \0
    
    movq $format_d, %rdi #getting second size
    leaq -288(%rbp), %rsi
    xor %rax, %rax
    call scanf

    movq $format_s, %rdi #getting second string
    leaq -287(%rbp), %rsi
    xorq %rax, %rax
    call scanf
    
    movq $0, %rax   #add "\0" to end of string. first delete rax
    movb -288(%rbp), %al # put the char in rax
    sub $48, %rax # make the number align to 0 from the asci (MABEY NOT GOOD!)
    leaq -287(%rbp, %rax), %rax #go to the end of string
    movq format_space, %rax #put there \0
    
    movq $format_d, %rdi #getting switch case option CHECK IF THIS IS THE ORDER OF SCNAF!!
    leaq -32(%rbp), %rsi
    xor %rax, %rax
    call scanf
    
    
    # prepare to call func_select
    movq -32(%rbp), %rdi
    leaq -544(%rbp), %rsi
    leaq -288(%rbp), %rdx
##
#HERE WE JUMP
##
subq $50, %rdi
jmp *.JUMPTABLE(,%rdi,8)

ret


#### TEST

#cmpq $10, %r13 #check if the index is in the range.

#ja .Ldefault # if >, go to the defult case.

#jmp *.JUMPTABLE(,%rsi,8) #go to jumptable (Xi)

#case 50   

.Lfirst:
movq %rsi, %rdi #moving the strings AFTER we moved to the switch-case
movq %rdx, %rsi
call pstrlen
movq %rsi, %rdi
movq %rax, %rsi
call pstrlen
movq %rax, %rdx
movq $print_pstrlen, %rdi
xor %rax, %rax
call printf
xor %rax, %rax
add $544, %rsp
popq %rbp
ret
##call the func pstrlen


	.globl	pstrlen
	.type	pstrlen, @function
pstrlen:
xor %rax, %rax
movb (%rdi), %al
ret

#case 51   

.Ldefault:

movq $1,  %rax

#case 52   

.Lsecond:
movq %rsi, %rdi #moving the strings AFTER we moved to the switch-case
movq %rdx, %rsi
push %rbp
movq %rsp, %rbp
subq $24, %rsp #make room

movq %rdi, %r13
movq %rsi, %r14 #have to save rsi and rdi!

movq $format_c, %rdi #first char
leaq -24(%rbp), %rsi
xor %rax, %rax
call scanf

movq $format_c, %rdi #second char
leaq -8(%rbp), %rsi
xor %rax, %rax
call scanf

movq %r13, %rdi #sending for the first time with first str
movq -24(%rbp), %rsi
movq %rsi, %r15
movq -8(%rbp), %rdx
#call replaceChar!!!!
call replaceChar
movq %rax, %rcx

movq %r14, %rdi #sending for the first time with second str
movq -16(%rbp), %rsi
movq -8(%rbp), %rdx
call replaceChar
movq %rax, %r8

#print:
movq $print_replace_char, %rdi
xor %rax, %rax
movq %r15, %rsi
call printf
xor %rax, %rax
add $24, %rsp
pop %rbp
add $544, %rsp
popq %rbp
ret


####FUNC replaceChar:

        .globl	replaceChar
	.type	replaceChar, @function
replaceChar:

movq %rdi, %rax #save rdi
addq $1, %rdi
.for:
    cmpq $0, (%rdi)
    je .return
    
    cmpb %sil, %dil #checking if the char in rsi is equel to current char in rdi
    je .switch
    addq $1, %rdi
    jmp .for


.switch:
    movb %dl, (%rdi)
    addq $1, %rdi
    jmp .for
.return:
    ret
    
#case 53   
.Lthird:
movq %rsi, %rdi #moving the strings AFTER we moved to the switch-case
movq %rdx, %rsi
push %rbp
movq %rsp, %rbp
subq $24, %rsp #make room

movq %rdi, %r13
movq %rsi, %r14 #have to save rsi and rdi!

movq $format_d, %rdi #first num
leaq -24(%rbp), %rsi
xor %rax, %rax
call scanf

movq $format_d, %rdi #second num
leaq -8(%rbp), %rsi
xor %rax, %rax
call scanf
movq %r13, %rdi
movq %r14, %rsi
movq -24(%rbp), %rdx
movq -8(%rbp), %rcx

#### call the function pstrijcpy
#### the function:
movq %rdi, %rax #save rdi

addq $1, %rdi #skip the str size
addq $1, %rsi #skip the str size
addq %rdx, %rdi #get to the right index
addq %rdx, %rsi

.while:
    cmp %rcx, %rdx
    jg .return
    movq (%rsi), %r10
    movq %r10, (%rdi)
    add $1, %rdx
    add $1, %rdi
    add $1, %rsi
    jmp .while
    

#case 54   

.Lforth:
movq %rsi, %rdi #moving the strings AFTER we moved to the switch-case
movq %rdx, %rsi
jmp .swapCase #to the func
#call Func
movq %rsi, %rdi
### CALL THE FUNCTION swapCase
#the func:
.swapCase:
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
    
    
    
    

#case 55   

.Lfifth:
movq %rsi, %rdi #moving the strings AFTER we moved to the switch-case
movq %rdx, %rsi
push %rbp
movq %rsp, %rbp
subq $24, %rsp #make room

movq %rdi, %r13
movq %rsi, %r14 #have to save rsi and rdi!

movq $format_d, %rdi #first num
leaq -24(%rbp), %rsi
xor %rax, %rax
call scanf

movq $format_d, %rdi #second num
leaq -8(%rbp), %rsi
xor %rax, %rax
call scanf
movq %r13, %rdi
movq %r14, %rsi
movq -24(%rbp), %rdx
movq -8(%rbp), %rcx

### CAL THE FUNC pstrijcmp
##the func:
movq %rdi, %rax #save rdi

addq $1, %rdi #skip the str size
addq $1, %rsi #skip the str size
addq %rdx, %rdi #get to the right index
addq %rdx, %rsi

.whileFifth:
    cmpq %rcx, %rdx
    jg .return
    movq (%rdi), %r15
    cmpq %r15, (%rsi)
    jg .greater
    jl .less
    movq (%rsi), %r10
    movq %r10, (%rdi)
    add $1, %rdx
    add $1, %rdi
    add $1, %rsi
    jmp .whileFifth

.greater:
    movq $1, %rax
    ret
.less:
    movq $-1, %rax

    

#NEED TO RETURN

####### BELONGS TO pstring.s
