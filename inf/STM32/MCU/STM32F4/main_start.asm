@.CharSet=CP1251
@GNU AS

.syntax unified     @ ��������� ��������� ����
.thumb              @ ��� ������������ ���������� Thumb
.cpu cortex-m4      @ ���������
.fpu fpv4-sp-d16    @ �����������


.section .asmcode

@ �������� ���������
.global Start
Start:
                    @ ���������  ������������
                    BL   SYSCLK168_START

MAIN_LOOP:          B    MAIN_LOOP
