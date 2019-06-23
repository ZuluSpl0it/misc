/* ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <info@gerhard-bertelsmann.de> wrote this file. As long as you retain this
 * notice you can do whatever you want with this stuff. If we meet some day,
 * and you think this stuff is worth it, you can buy me a beer in return
 * Gerhard Bertelsmann
 * ----------------------------------------------------------------------------
 */

#include "main.h"

#pragma config JTAGEN   = OFF
#pragma config FNOSC    = PRIPLL
#pragma config IESO     = OFF
#pragma config FCKSM    = CSECMD
#pragma config OSCIOFNC = ON
#pragma config POSCMD   = XT

volatile uint16_t LED_Counter = 0;


/* code for Output Compare 1 ISR*/
void __attribute__((__interrupt__, no_auto_psv)) _T1Interrupt( void ) {
    /* Clear OC1 interrupt flag} */
    IFS0bits.T1IF = 0;
    LED_Counter++;
    if (LED_Counter >= 500) {
	__builtin_btg((unsigned int *)&LATB, 9);
	LED_Counter = 0;
    }
}

/* code for Output Compare 1 ISR*/
void __attribute__((__interrupt__, no_auto_psv)) _OC1Interrupt( void ) {
    /* Clear OC1 interrupt flag} */
    IFS0bits.OC1IF = 0;
}

/* code for Output Compare 2 ISR*/
void __attribute__((__interrupt__, no_auto_psv)) _OC2Interrupt( void ) {
    /* Clear OC2 interrupt flag} */
    IFS0bits.OC2IF = 0;
}

void init_timer(void) {
	/* Timer1 for msic tasks */
	T1CONbits.TON = 0;        // Disable Timer
	T1CONbits.TCS = 0;        // Select internal instruction cycle clock
	T1CONbits.TGATE = 0;      // Disable Gated Timer mode
	T1CONbits.TCKPS = 0b10;   // Select 1:256 Prescaler
	TMR1 = 0x00;              // Clear timer register
	PR1 = 999;                // Load the period value
	IPC0bits.T1IP = 0x01;     // Set Timer1 Interrupt Priority Level
	IFS0bits.T1IF = 0;        // Clear Timer1 Interrupt Flag
	IEC0bits.T1IE = 1;        // Enable Timer1 interrupt
	T1CONbits.TON = 1;        // Start Timer
}

void init_io(void) {
    /* ADC1 Digital Mode */
    // AD1CON1.bits = 0x8000;
    //_ADON = 0;
    //_CVR1OE = 0;
    CM1CON = 0;
    CM2CON = 0;
    CM3CON = 0;
    CM5CON = 0;
    ANSELA = 0;
    ANSELB = 0;
    // AD1PCFG = 0xFFFF;

    /* RB9 LED */
    TRISB = 0;
}

void init_pps(void) {
    __builtin_write_OSCCONL(OSCCON & ~(1 << 6));
    RPINR18bits.U1RXR = 34;     /* PIN 23 RB2 RPI34 U1RxD */
    RPOR0bits.RP35R   =  1;     /* PIN 22 RB3 RP35  U1TxD (U1TX = 0b0000001) */
    RPINR26bits.C1RXR = 55;     /* PIN 3  RC7 RP55 CAN1 RxD */
    RPOR6bits.RP54R   = 14;     /* PIN 2  RC6 RP54 CAN1 TxD (C1TX = 0b001110) */
    RPINR19bits.U2RXR = 42;     /* PIN 8  RB10 RP42 U2RxD */
    RPOR4bits.RP42R   =  3;     /* PIN 9  RB11 RP43 U2TxD (U2TX = 0b0000011) */
    RPOR2bits.RP39R   = 16;     /* PIN 43 RB7  RP39 B_Left  (OC1 = 0b00010000) */
    RPOR3bits.RP40R   = 17;     /* PIN 44 RB8  RP40 B_Right (OC2 = 0b00010001) */
                                /* PIN 42 RB6  RP38 B_Ena */
    __builtin_write_OSCCONL(OSCCON | (1 << 6));
}

int main(void) {
    /* Init Clock */
    PLLFBD = PLL_DIV;
    CLKDIVbits.PLLPOST = PLL_POST;
    CLKDIVbits.PLLPRE = PLL_PRE;

    __builtin_write_OSCCONH(0x03);
    __builtin_write_OSCCONL(OSCCON | 0x01);

    while (OSCCONbits.COSC != 3) ;
    while (OSCCONbits.LOCK != 1) ;

    init_io();
    init_timer();

    while (true) {
	__delay_ms(500);
    }
}
