#include "main.h"

typedef void (*INT_FUNC)();

void function(){
    char cha[] = "asdfsadfsdaf";
    print(cha);
}

//呃，此处是此次测试的重点之一，这个是测试C语言当中的指针在操作系统当中是不是可以这样用
//指针指向一个实际的内存地址
void make_descriptor(unsigned int num,INT_FUNC func){
    void *start = (void*)0x200;
    start += num * sizeof(struct int_descriptor);
    struct int_descriptor *descriptor = (struct int_descriptor*)start;
    descriptor->low_addr=0x1234;
    descriptor->descriptor=(u16)func;
    (*func)();
}

void goto_hlt(){
hlt:
    asm volatile("hlt;");
    goto hlt;
}

void os_main(){ //原先此处我以为加一个__attribute__((section(".inittext")))就可以了，但是GCC会在函数开头动堆栈，导致问题
    //asm volatile("movw $0,%ax;movw %ax,%ds;movw %ax,%ss;movw $0xffff,%sp");
    INT_FUNC func = &function;
    make_descriptor(0,func);
    goto_hlt();
}
