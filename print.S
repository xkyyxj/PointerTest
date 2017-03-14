#include "main.h"
.code16
.section .inittext,"ax"
    movw $0x07c0,%ax;
    movw %ax,%ds;
    movw %ax,%ss;
    movw $0xffff,%sp;
    call os_main;

.type print,@function
.globl print
print:
    pushw %esi;
    pushw %eax;
    pushw %ebx;
    movw %eax,%esi;

1:
    cld;
    lodsb;
    andb %al,%al;
    jz 2f;
    movw $0x07,%bx;
    movb $0x0e,%ah;
    int $0x10;
    jmp 1b;
2:
    popw %ebx;
    popw %eax;
    popw %esi;
    lret;               #此处应该是用lret，此前此处使用了ret指令，导致返回地址错误，
                        #从而使返回地址超出了实模式下的访问范围
