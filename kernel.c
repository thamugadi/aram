extern unsigned char inp(unsigned int);

void clearscreen(void)
{
        unsigned char* vram = 0xB8000;
        while (vram < 0xBFFFF)
        {
                *vram = 0x0;
                vram++;
        }
}

void _start(void)
{        clearscreen();
        while(1);
}
