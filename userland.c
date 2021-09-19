void _start(void)
{       clearscreen();
        while(1);
}

void clearscreen(void)
{
        unsigned char* vram = 0xB8000;
        while (vram < 0xBFFFF)
        {
                *vram = 0x12;
                vram++;
        }
}
