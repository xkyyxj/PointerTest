FINAL := final.bin

CC := i686-elf-gcc -c -nostdlib -m16 -O2 -o
AS := as --32 -o
OBJCOPY_OPT := -R .comment -R .note -S -O binary

$(FINAL) : main.o print.o tail.o
	ld -Tboot.ld -nostdlib -S -o final.o main.o print.o tail.o
	objcopy $(OBJCOPY_OPT) final.o $(FINAL)

main.o : main.c main.h
	$(CC) main.o main.c

print.o : print.S main.h
	$(AS) print.o print.S

tail.o : tail.S
	$(AS) tail.o tail.S
