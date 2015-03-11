ASFLAGS	= -fbin -Iinclude/

SOURCES	= boot.bin kernel.bin

all: bootsector

floppy.img:
	/sbin/mkdosfs -F 12 -s 2 -C floppy.img 1440

bootsector: floppy.img $(SOURCES)
	dd conv=notrunc if=boot.bin of=floppy.img bs=1 seek=64 count=448
	mcopy -o -i floppy.img boot.asm ::/
	mcopy -o -i floppy.img kernel.bin ::/DOSILE.SYS

clean:
	-rm *.bin
	-rm *.img

%.bin : %.asm
	nasm $(ASFLAGS) $< -o $@

run: all
	qemu-system-x86_64 -display sdl -fda floppy.img -net none 
