/* @.CHARSET CP1251 */

/* 1921��035, flash 64 kb, sram 16 kb */

MEMORY
{
     /* FLASH - ����������� flash ������ */
     FLASH      (RX)  : ORIGIN = 0x00000000, LENGTH = 64K

     /* SRAM1 - ��� ������ ���������� */
     SRAM       (RWX)  : ORIGIN = 0x20000000, LENGTH = 16K

}
SECTIONS
{
     .code : {
          . = ALIGN(4);
          *(.vectors);   /* ��������� �������� ���������� */
          *(.text);      /*  */
          *(.asmcode);   /* ����� ��������� */
          *(.rodata);    /* ���������  */
     } > FLASH
     .bss : {
          . = ALIGN(1);
          *(.bss);        /* ���������� � SRAM */
      } > SRAM
}
