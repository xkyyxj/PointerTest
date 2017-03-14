OUTPUT_FORMAT("elf32-i386","elf32-i386","elf32-i386")
OUTPUT_ARCH(i386)
ENTRY(os_main)

SECTIONS
{
	. = 0;
	.inittext	:{*.inittext}
	.text	:{*.text}
	.data	:{*.data}
	.bss :
	{
		*(.bss)
	}
	. = 510;
	.finaldata	:{*.finaldata}
}
