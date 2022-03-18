#define LINES      25
#define COLUMNS    80
#define LINE    0xE10000
#define COLUMN  0xE10001
#define TEXT_POSITION    0xE10002

void _start(void)
{
	*((unsigned char*)LINE) = 0;
	*((unsigned char*)COLUMN) = 0;
	(*((unsigned int*)TEXT_POSITION)) = 0;
	clearscreen(0);
	
	unsigned char* addr;
	while(1) for (addr = 0x1000; addr <= 0xFFFF; addr++) putchar(*addr, 1); 
}

void putchar(unsigned char ch, unsigned char cl)
{
	putchar_offset(ch, cl, (*((unsigned int*)TEXT_POSITION))*2);
	(*((unsigned int*)TEXT_POSITION))++;
}

void putchar_offset(unsigned char character, unsigned char color, unsigned int offset)
{
	volatile unsigned char* vram;
	vram = 0xB8001+offset;
        *vram = character;
        vram++;
        *vram = color;
}

void clearscreen(unsigned char c)
{
        unsigned char* vram = 0xB8000;
        while (vram < 0xBFFFF)
        {
                *vram = c;
                vram++;
        }
}
