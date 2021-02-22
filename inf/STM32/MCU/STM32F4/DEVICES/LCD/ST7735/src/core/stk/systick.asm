@GNU AS
@.CHARSET  CP1251

@.DESC     type=module
@ +------------------------------------------------------------------+
@ |                      ������ ������� SysTick                      |
@ +------------------------------------------------------------------+
@ | ��� ������������� ���������� ���������������� ������ �������:    |
@ |     BL   SYSTICK_START                                           |
@ |                                                                  |
@ | � ���������� ��� ������������� ������������� ��������:           |
@ |    MOV R0, <����� �������� � ������������>                       |
@ |    BL  SYSTICK_DELAY                                             |
@ +------------------------------------------------------------------+
@.ENDDESC

.SYNTAX unified                     @ ��������� ��������� ����
.THUMB                              @ ��� ������������ ���������� Thumb
.CPU    cortex-m4                   @ ���������
.FPU    fpv4-sp-d16                 @ �����������

@ ����������� ��������
.EQU  SCB_BASE                      , 0xE000ED00             @ System control block (SCB)
.EQU  SHPR3                         , 0x20                   @ System handler priority registers (SHPRx)
.EQU  SYSTICK_BASE                  , 0xE000E010             @ System timer
.EQU  STK_CTRL                      , 0x00                   @ ������� ������� � ����������
.EQU  STK_LOAD                      , 0x00000004             @ �������� ��� ������������ ��������
.EQU  STK_VAL                       , 0x00000008             @ ������� �������� ��������
.EQU  STK_CTRL_CLKSOURSE            , 0x00000004             @ (RW) �������� ������������: 0: AHB/8; 1: AHB
.EQU  STK_CTRL_TICKINT              , 0x00000002             @ (RW) ��� ��������� ���������� ���������� ��� �������� ����� 0
.EQU  STK_CTRL_ENABLE               , 0x00000001             @ (RW) �������� �������.


.SECTION .bss
@ ���������� � ���
SYSTICK_COUNTER:
                         .word       0                       @ �������� ����������� ��������

.SECTION .asmcode
@.DESC     name=IRQ_SysTick type=proc
@ ****************************************************************************
@ *             ���������� ���������� ���������� ������� SysTick             *
@ ****************************************************************************
@ ���������� ��������� �������� �������� SYSTICK_COUNTER �� "1" (� ������ ����
@ �������� �������� ������ "0"
@.ENDDESC

.GLOBAL IRQ_SysTick

IRQ_SysTick:
                         PUSH        { R0, R1, LR }
                         LDR         R1, = SYSTICK_COUNTER
                         LDR         R0, [ R1, 0 ]
                         ORRS        R0, R0, 0               @ �������� R0 �� 0
                         ITT         NE                      @ ���� R0<>0 ��������� ��� �� 1
                         SUBNE       R0, R0, 1
                         STRNE       R0, [ R1, 0 ]
                         POP         { R0, R1, PC }

@.DESC     name=SYSTICK_START type=proc
@ ****************************************************************************
@ *                 ������������� ���������� ������� SysTick                 *
@ ****************************************************************************
@ ��� ������� AHB=168 ���
@ ������� ����� 1000 ��
@
@.ENDDESC

@ ��������� SysTick
.GLOBAL SYSTICK_START

SYSTICK_START:
                         PUSH        { R0, R1, LR }
                         LDR         R0, = SYSTICK_BASE

     @ ��������� �������� ��������� ��� ��������� ������� 1000 ��
                         LDR         R1, = 168000 - 1
                         STR         R1, [ R0, STK_LOAD ]

     @ �������� ������� AHB (168 ���) + ���������� + �������� SYSTICK
                         LDR         R1, = ( STK_CTRL_CLKSOURSE + STK_CTRL_TICKINT + STK_CTRL_ENABLE )
                         STR         R1, [ R0, STK_CTRL ]

     @ ��������� ���������� ���������� �� SysTick
                         LDR         R0, = SCB_BASE
                         LDR         R1, [ R0, SHPR3 ]
                         ORR         R1, R1, 0x0F << 12
                         STR         R1, [ R0, SHPR3 ]

                         POP         { R0, R1, PC }

@.DESC     name=SYSTICK_DELAY type=proc
@ ****************************************************************************
@ *             �������� ���������� ���������� ������� SysTick               *
@ ****************************************************************************
@ ������� ��������: R0 - �������� � ������������
@ �������� ��������: R0 = 0
@ ��������� ������ ���������: ���
@
@.ENDDESC

.GLOBAL SYSTICK_DELAY

SYSTICK_DELAY:
                         PUSH        { R1, R2, LR }

                         LDR         R2, = SYSTICK_BASE      @ ������� ������� �������
                         STR         R0, [ R2, STK_VAL ]

                         LDR         R1, = SYSTICK_COUNTER   @ ����� ��������
                         STR         R0, [ R1, 0 ]           @ �������� ��������� ��������
DELAY_LOOP:
                         LDR         R0, [ R1, 0 ]           @ ���� ��������� ��������
                         ORRS        R0, R0, 0
                         BNE         DELAY_LOOP
                         POP         { R1, R2, PC }
