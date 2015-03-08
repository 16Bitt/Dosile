ASFLAGS	= -fbin -Iinclude/

SOURCES	= boot.bin

all: bootsector

floppy.img:
	dd if=/dev/zero of=floppy.img bs=1k count=1440
	/sbin/mkdosfs -F 16 -s 2 -n DOSILE floppy.img

bootsector: floppy.img $(SOURCES)
	dd conv=notrunc if=boot.bin of=floppy.img bs=1 seek=64 count=448

clean:
	-rm *.bin
	-rm *.img

%.bin : %.asm
	nasm $(ASFLAGS) $< -o $@

run: all
	qemu-system-x86_64 -display sdl -fda floppy.img -net none 
