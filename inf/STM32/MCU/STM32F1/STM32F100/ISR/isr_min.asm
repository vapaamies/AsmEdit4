@GNU AS
@.CharSet=CP1251

.syntax unified     @ ��������� ��������� ����
.thumb               @ ��� ������������ ���������� Thumb
.CPU       cortex-m3 @ ���������


.section .vectors

@ ������� �������� ����������
     .word     0x20020000             @ 0x0000 ������� �����
     .word     Start+1                  @ 0x0004 RESET

@ �������� !!
@ ��� ����������� ������� ���������� ! ��� ��������� ���������� ��
@ �������������� � �� ������������� �������� � ���������� ���������
@ ������ ���������
