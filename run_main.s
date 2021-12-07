#   313450249 Ariel Mantel
.section .rodata
.align 8
format_c:   .string " %c"
format_s:   .string "%s"
format_d:   .string "%d"
format_space:   .string "\0"
print_pstrlen: .string "first pstring length: %d, second: %d\n"
print_replace_char: .string "old char: %c, new char: %c, first string %s, second string %s\n"
print_pstrijcpy: .string "length: %d, string: %s\n"
print_swap_case: .string "length: %d, string: %s\n"
print_compare_result: .string "compare result: %d\n"
print_default: .string "invalid option!\n"
print_invalid: .string "invalid input!\n"

.text
.global run_main
.extern run_func
.type run_main, @function
run_main:
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
    movq -32(%rbp), %rdi # the function
    leaq -544(%rbp), %rsi # first string
    leaq -288(%rbp), %rdx # second string
call run_func
# finishing
add $544, %rsp
pop %rbp
xor %rax, %rax
ret