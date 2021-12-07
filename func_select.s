#   313450249 Ariel Mantel
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
print_pstrlen: .string "first pstring length: %d, second pstring length: %d\n"
print_replace_char: .string "old char: %c, new char: %c, first string: %s, second string: %s\n"
print_pstrijcpy: .string "length: %d, string: %s\n"
print_swap_case: .string "length: %d, string: %s\n"
print_compare_result: .string "compare result: %d\n"
print_default: .string "invalid option!\n"
print_invalid: .string "invalid input!\n"
print_55: .string "compare result: -2"

.text
        .globl	run_func
        .extern pstrlen, replaceChar, pstrijcpy, swapCase, pstrijcmp
	.type	run_func, @function
run_func:
subq $50, %rdi
cmp $0, %rdi
jl .Ldefault
cmp $10, %rdi
jg .Ldefault
jmp *.JUMPTABLE(,%rdi,8)

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
ret

#case 51   
.Ldefault:
movq $print_default, %rdi
xor %rax, %rax
call printf
ret

#case 52   
.Lsecond:
movq %rsi, %rdi #moving the strings AFTER we moved to the switch-case
movq %rdx, %rsi
push %rbp
movq %rsp, %rbp
subq $32, %rsp #make room

movq %rdi, %r13
movq %rsi, %r14 #have to save rsi and rdi!

movq $format_c, %rdi #first char
leaq -32(%rbp), %rsi
xor %rax, %rax
call scanf

movq $format_c, %rdi #second char
leaq -16(%rbp), %rsi
xor %rax, %rax
call scanf

movq %r13, %rdi #sending for the first time with first str
movq -32(%rbp), %rsi
movq %rsi, %r15
movq -16(%rbp), %rdx

#call replaceChar!!!!
call replaceChar
movq %rax, %rcx

movq %r14, %rdi #sending for the first time with second str
movq -16(%rbp), %rdx
call replaceChar
movq %rax, %r8

#print:
movq $print_replace_char, %rdi
xor %rax, %rax
movq %r15, %rsi
incq %rcx
incq %r8
call printf
xor %rax, %rax
add $32, %rsp
pop %rbp
ret

#case 53   
.Lthird:
movq %rsi, %rdi #moving the strings AFTER we moved to the switch-case
movq %rdx, %rsi
push %rbp
movq %rsp, %rbp
subq $32, %rsp #make room

movq %rdi, %r13
movq %rsi, %r14 #have to save rsi and rdi!

movq $format_d, %rdi #first num
leaq -32(%rbp), %rsi
xor %rax, %rax
call scanf

movq $format_d, %rdi #second num
leaq -16(%rbp), %rsi
xor %rax, %rax
call scanf
movq %r13, %rdi
movq %r14, %rsi
movq -32(%rbp), %rdx
movq -16(%rbp), %rcx

movq $0, %rax
movb %dl, %al
movq %rax, %rdx
# check if indexes are OK
cmp $0, %rsi
jl .badI3
cmpb (%rdi), %cl
jg .badI3
cmpb (%rdi), %cl
jg .badI3


call pstrijcpy
movq %rax, %rdx
movq $print_pstrijcpy, %rdi
movq $0, %rsi
movb (%rax), %sil
xor %rax, %rax
addq $1, %rdx
call printf
movq $print_pstrijcpy, %rdi
movq $0, %rsi
movq %r14, %rdx
movb (%rdx), %sil
xor %rax, %rax
addq $1, %rdx
call printf

#clearing the stack
add $32, %rsp
pop %rbp
ret

.badI3:
    movq $print_invalid, %rdi
    call printf
    movq $print_pstrijcpy, %rdi    
    movq %r13, %rdx
    movq $0, %rsi
    movb (%rdx), %sil
    xor %rax, %rax
    add $1, %rdx
    call printf  
    movq $print_pstrijcpy, %rdi    
    movq %r14, %rdx
    movq $0, %rsi
    movb (%rdx), %sil
    xor %rax, %rax
    add $1, %rdx
    call printf      
    #clearing the stack
    add $32, %rsp
    pop %rbp
    ret

#case 54   
.Lforth:
movq %rsi, %rdi #moving the strings AFTER we moved to the switch-case
movq %rdx, %rsi
movq %rsi, %r15
call swapCase
movq $print_swap_case, %rdi
movq $0, %rsi
movb (%rax), %sil
movq %rax, %rdx
xor %rax, %rax
add $1, %rdx
call printf

#call Func
movq %r15, %rdi
call swapCase
movq $print_swap_case, %rdi
movq $0, %rsi
movb (%rax), %sil
movq %rax, %rdx
xor %rax, %rax
add $1, %rdx
call printf
ret


    
#case 55   
.Lfifth:
movq %rsi, %rdi #moving the strings AFTER we moved to the switch-case
movq %rdx, %rsi
push %rbp
movq %rsp, %rbp
subq $32, %rsp #make room

movq %rdi, %r13
movq %rsi, %r14 #have to save rsi and rdi!

movq $format_d, %rdi #first num
leaq -32(%rbp), %rsi
xor %rax, %rax
call scanf

movq $format_d, %rdi #second num
leaq -16(%rbp), %rsi
xor %rax, %rax
call scanf
movq %r13, %rdi
movq %r14, %rsi
movq -32(%rbp), %rdx
movq -16(%rbp), %rcx

movq $0, %rax
movb %dl, %al
movq %rax, %rdx

# check if indexes are OK
cmpb (%rdi), %cl
jg .badI5
cmpb (%rdi), %cl
jg .badI5

call pstrijcmp
movq $print_compare_result, %rdi
movq %rax, %rsi
xor %rax, %rax
call printf

add $32, %rsp
pop %rbp
ret

.badI5:
    movq $print_invalid, %rdi
    movq $0, %rax
    call printf
    movq $print_55, %rdi
    movq $-2, %rsi
    movq $0, %rax
    call printf
    #clearing the stack
    add $32, %rsp
    pop %rbp
    ret