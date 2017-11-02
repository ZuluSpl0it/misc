;-------------------------------------------------------------------------------
;
;   The Cowboy Boot Loader for Enhanced PIC12/PIC16
;
;   Boot Loader Project
;
;   Copyright (c) 2017 Darron M Broad
;
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
;   This file is part of The Cowboy Boot Loader.
;
;   The Cowboy Boot Loader is free software: you can redistribute it and/or
;   modify it under the terms of the GNU General Public License as published
;   by the Free Software Foundation.
;
;   The Cowboy Boot Loader is distributed in the hope that it will be
;   useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
;   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;   GNU General Public License for more details.
;
;   You should have received a copy of the GNU General Public License along
;   with The Cowboy Boot Loader. If not, see http://www.gnu.org/licenses/
;-------------------------------------------------------------------------------

                RADIX       DEC

;-------------------------------------------------------------------------------
; Device
;-------------------------------------------------------------------------------

                PROCESSOR   16f15325

;-------------------------------------------------------------------------------
; Device Pinout
;-------------------------------------------------------------------------------
;
; VDD        1-----14 VSS
; RA5        2     13 RA0 PGD TX1
; RA4        3     12 RA1 PGC RX1
; MCLR       4     11 RA2
; RC5        5     10 RC0 TX2
; RC4        6      9 RC1 RX2
; RC3        7      8 RC2 DE
;
;-------------------------------------------------------------------------------
; Device Constants
;-------------------------------------------------------------------------------

ERRORLEVEL      -1302
#INCLUDE        "p16f15325.inc"


; Boot Loader Size
BOOTSIZE        EQU         8

; Boot Loader Ident
; __IDLOCS 0x6666

;-------------------------------------------------------------------------------
; Device Settings
;-------------------------------------------------------------------------------

; Clock Rate
#DEFINE         CLOCK       32000000

; UART Baud Rates
#DEFINE		BAUDRATE1	57600  
#DEFINE		BAUDRATE2	62500

#DEFINE UBAUD1   ((((CLOCK / BAUDRATE1) / 2) - 1) / 2)
#IF UBAUD1 > 65535
    ERROR       "UART1 BRG overflow"
#ENDIF
#IF UBAUD1 == 0
    ERROR       "UART1 BRG zero"
#ENDIF

#DEFINE UBAUD2   ((((CLOCK / BAUDRATE2) / 2) - 1) / 2)
#IF UBAUD1 > 65535
    ERROR       "UART2 BRG overflow"
#ENDIF
#IF UBAUD1 == 0
    ERROR       "UART2 BRG zero"
#ENDIF

; BOOT/LED/SWITCH
#DEFINE		DDR	TRISC
#DEFINE		OUTPUT	LATC
#DEFINE		DE	2
#DEFINE		LED	3

CBLOCK          0x70
    frame_start	:	1
ENDC


;-------------------------------------------------------------------------------
; Device Configuration
;-------------------------------------------------------------------------------

  __CONFIG _CONFIG1, _FEXTOSC_OFF & _RSTOSC_HFINT32 & _CLKOUTEN_ON & _CSWEN_ON & _FCMEN_OFF
  __CONFIG _CONFIG2, _MCLRE_ON & _PWRTE_ON & _LPBOREN_OFF & _BOREN_OFF & _BORV_HI & _ZCD_OFF & _PPS1WAY_OFF & _STVREN_ON
  __CONFIG _CONFIG3, _WDTCPS_WDTCPS_5 & _WDTE_SWDTEN & _WDTCWS_WDTCWS_7 & _WDTCCS_HFINTOSC & _WDTCCS_SC
  __CONFIG _CONFIG4, _BBSIZE_BB512 & _BBEN_OFF & _SAFEN_OFF & _WRTAPP_OFF & _WRTB_OFF & _WRTC_OFF & _WRTSAF_OFF & _LVP_ON
  __CONFIG _CONFIG5, _CP_OFF

;-------------------------------------------------------------------------------
; Device Init.
;-------------------------------------------------------------------------------

		ORG	0
                GOTO	START

		ORG     4
		RETFIE

PPS_INIT	MACRO
                BANKSEL ANSELA              ;BANK 62
                CLRF    ANSELA
                CLRF    ANSELC
; PPSUnlock
                BANKSEL PPSLOCK             ;BANK ?
                MOVLW   0x55
                MOVWF   PPSLOCK
                MOVLW   0xAA
                MOVWF   PPSLOCK
                BCF     PPSLOCK,PPSLOCKED
; PPSInput
                BANKSEL RX1DTPPS            ;BANK ?
                MOVLW   0x01
                MOVWF   RX1DTPPS            ;RA1 = RX1

		BANKSEL RX2DTPPS            ;BANK ?
                MOVLW   0x0F
                MOVWF   RX1DTPPS            ;RC1 = RX1

; PPSOutput
                BANKSEL RA0PPS              ;BANK 62
                MOVLW   0x11
                MOVWF   RA0PPS              ;RA0 = TX1

		; BANKSEL RC0PPS	    ;BANK 62
                MOVLW   0x11
                MOVWF   RA0PPS              ;RC0 = TX2
; PPSLock
                BANKSEL PPSLOCK             ;BANK ?
                MOVLW   0x55
                MOVWF   PPSLOCK
                MOVLW   0xAA
                MOVWF   PPSLOCK
                BSF     PPSLOCK,PPSLOCKED
		ENDM

GPIO_INIT	MACRO
		BANKSEL	DDR
		; LED and DE are aoutputs
		MOVLW	0xFF ^ ( (1 << DE) + (1 << LED))
		MOVLW	0xF3
		MOVWF	DDR
		ENDM

;-------------------------------------------------------------------------------
; Init. UART
;
;  Modifies W, BSR
;-------------------------------------------------------------------------------
UART1_INIT	MACRO
                BANKSEL BAUD1CON		;BANK 2
                MOVLW   (1 << BRG16)
                MOVWF   BAUD1CON

                MOVLW   HIGH (UBAUD1)
                MOVWF   SP1BRGH
                MOVLW   LOW  (UBAUD1)
                MOVWF   SP1BRGL

                ; Enable Enable Transmit + High Speed Mode
                MOVLW   (1 << TXEN) + (1 << BRGH)
                MOVWF   TX1STA

                ; Enable Serial Port + Disable Receiver
                MOVLW   (1 << SPEN)
                MOVWF   RC1STA

                ; Enable Receiver
                BSF     RC1STA,CREN

                ; Flush Receivers
                MOVF    RC1REG,W
                MOVF    RC1REG,W
                MOVF    RC1REG,W
		ENDM

UART2_INIT	MACRO
		BANKSEL BAUD2CON		;BANK 20
                MOVLW   (1 << BRG16)
                MOVWF   BAUD2CON

                MOVLW   HIGH (UBAUD2)
                MOVWF   SP2BRGH
                MOVLW   LOW  (UBAUD2)
                MOVWF   SP2BRGL

                ; Enable Enable 9-bit + Enable Transmit + High Speed Mode
                MOVLW   (1 << TX9) + (1 << TXEN) + (1 << BRGH)
                MOVWF   TXSTA2

                ; Enable Serial Port 2 + Disable Receiver
                MOVLW   (1 << SPEN)
                MOVWF   RCSTA2

                ; Enable Receiver
                BSF     RCSTA2,CREN

                ; Flush Receivers
		MOVF	RC2REG,W
		MOVF	RC2REG,W
		MOVF	RC2REG,W

		ENDM


;-------------------------------------------------------------------------------
; Main Loop
;  Looking for data either on PC or RS485 site and copy it to the opposit
;  set DE for start frame and delete it
; 
;-------------------------------------------------------------------------------

START
		PPS_INIT
		GPIO_INIT
		UART1_INIT
		UART2_INIT
		CLRF	frame_start

LOOP		BANKSEL	PIR3
		BTFSC	PIR3,RC1IF
		BRA	DATA_ON_RS232

		; if the counter was started and overflows
		;  delete the DE
		MOVF	frame_start,F
		BTFSC	STATUS,Z
		BRA	RX2_CHECK
		INCF	frame_start
		BTFSC	STATUS,Z
		BRA	RX2_CHECK
		BANKSEL	OUTPUT
		BCF	OUTPUT,DE
		BRA	RX2_CHECK

DATA_ON_RS232	; there is data
		BANKSEL	RC1REG
		MOVF	RC1REG,W

		; check for start char
		MOVF	frame_start,F
		BTFSC	STATUS,Z
		BRA	FRAME_START

		; clear 9th bit -> data byte
		BANKSEL TX1STA
		BCF	TX1STA,TX9D
		BRA	TX2_CONT
FRAME_START
		BANKSEL	OUTPUT
		BSF	OUTPUT,DE
		; set 9th bit -> address
		BANKSEL TX1STA
		BSF	TX1STA,TX9D
		INCF	frame_start

TX2_CONT
		BANKSEL	PIR3
TX2_WAIT	BTFSS   PIR3,TX2IF
		BRA	TX2_WAIT
		BANKSEL	TX2REG
		MOVWF	TX2REG

RX2_CHECK
		BANKSEL PIR3
		BTFSS	PIR3,RC2IF
		BRA	LOOP
		BANKSEL	RC2REG
                MOVF	RC2REG,W

		BANKSEL PIR3
TX1_WAIT	BTFSS	PIR3,TX1IF
		BRA	TX1_WAIT
		BANKSEL	TX1REG
		MOVWF	TX1REG

		; testing
		BANKSEL	DDR
		MOVLW	1 << LED
		XORWF	OUTPUT,F

		GOTO	LOOP

;-------------------------------------------------------------------------------
THE
                END
;-------------------------------------------------------------------------------