typedef void (*func) ();

void printcha(char *cha){
    *cha = '2';
}

void printall(){
    char *ch = 0;
    char cha = '1';
    ch = &cha;
    printcha(ch);
}

void getFunc(func _func){
    (*_func)();
}

void hao(){
    func _func = &printall;
    getFunc(_func);
}
