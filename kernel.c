void _start(void)
{
        unsigned char* ptr = 0xB8000;
        *ptr = 0x41;
        ptr++;
        *ptr = 0x1E;
        while(1){}
}
