#define LINES      25
#define COLUMNS    80
#define LINEPTR    0xE10000
#define COLUMNPTR  0xE20000
#define VRAMPTR    0xE30000

void _start(void)
{
	*((unsigned char*)LINEPTR) = 0;
	*((unsigned char*)COLUMNPTR) = 0;
	(*((unsigned int*)VRAMPTR)) = (unsigned int*)0xB8000;
	clearscreen(0x1D);
	putchar(0x41, 0x11);
	while(1);
}

void putchar(unsigned char character, unsigned char color)
{
	unsigned char* vram = *((unsigned int*)VRAMPTR);
	*vram = color;
	vram++;
	*vram = character;
	vram++; vram+=2;
	*((unsigned int*)VRAMPTR) = (unsigned int*)vram;
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


