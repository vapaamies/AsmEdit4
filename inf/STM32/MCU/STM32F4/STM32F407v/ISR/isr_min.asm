@GNU AS
@.CharSet=CP1251

.syntax unified	@ ��������� ��������� ����
.thumb			@ ��� ������������ ���������� Thumb
.cpu cortex-m4		@ ���������
.fpu fpv4-sp-d16	@ �����������


.section .vectors

@ ������� �������� ����������
	.word	0x20020000	        @ 0x0000 ������� �����
	.word	Start+1		        @ 0x0004 RESET

@ �������� !!
@ ��� ����������� ������� ���������� ! ��� ��������� ���������� ��
@ �������������� � �� ������������� �������� � ���������� ���������
@ ������ ���������
