
_init:

;icaros1.c,10 :: 		void init(){
;icaros1.c,12 :: 		CM1CON0 = 0;
	CLRF       CM1CON0+0
;icaros1.c,13 :: 		CM2CON0 = 0;
	CLRF       CM2CON0+0
;icaros1.c,14 :: 		TRISA = 0x19;
	MOVLW      25
	MOVWF      TRISA+0
;icaros1.c,15 :: 		TRISB = 0x02;
	MOVLW      2
	MOVWF      TRISB+0
;icaros1.c,16 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;icaros1.c,17 :: 		PORTA = 0x00;
	CLRF       PORTA+0
;icaros1.c,18 :: 		T1CON = 0b00110000;        // timer1 uses prescaler value of 8 and it is off.
	MOVLW      48
	MOVWF      T1CON+0
;icaros1.c,19 :: 		TMR1H = 0;                 // timer1 registers have 0 (clear).
	CLRF       TMR1H+0
;icaros1.c,20 :: 		TMR1L = 0;
	CLRF       TMR1L+0
;icaros1.c,21 :: 		CCP1CON = 0x0B;            // set CCP module to compare mode and trigger special event when interrupt happens.
	MOVLW      11
	MOVWF      CCP1CON+0
;icaros1.c,22 :: 		CCPR = 0;                  // load 0 in CCPR.
	CLRF       _CCPR+0
	CLRF       _CCPR+1
	CLRF       _CCPR+2
	CLRF       _CCPR+3
;icaros1.c,23 :: 		PIR1.CCP1IF = 0;                // clear CCP1 interrupt flag.
	BCF        PIR1+0, 2
;icaros1.c,24 :: 		PIE1.CCP1IE = 1;                // enable CCP1 interrupt.
	BSF        PIE1+0, 2
;icaros1.c,25 :: 		INTCON = 0xC0;             // enable global and peripheral interrupt.
	MOVLW      192
	MOVWF      INTCON+0
;icaros1.c,26 :: 		T1CON = 0b00110101;        // start timer1 with the same settings like before.
	MOVLW      53
	MOVWF      T1CON+0
;icaros1.c,27 :: 		ANSELA= 0x00;
	CLRF       ANSELA+0
;icaros1.c,28 :: 		ANSELB= 0x00;
	CLRF       ANSELB+0
;icaros1.c,29 :: 		TXCKSEL_bit=1;
	BSF        TXCKSEL_bit+0, BitPos(TXCKSEL_bit+0)
;icaros1.c,30 :: 		RXDTSEL_bit=1;
	BSF        RXDTSEL_bit+0, BitPos(RXDTSEL_bit+0)
;icaros1.c,31 :: 		UART1_Init(9600);
	BSF        BAUDCON+0, 3
	MOVLW      207
	MOVWF      SPBRG+0
	CLRF       SPBRG+1
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;icaros1.c,32 :: 		}
L_end_init:
	RETURN
; end of _init

_interrupt:

;icaros1.c,33 :: 		void interrupt() {
;icaros1.c,34 :: 		if (PIR1.CCP1IF == 1) {                           // if CCP compare interrupt flag is set
	BTFSS      PIR1+0, 2
	GOTO       L_interrupt0
;icaros1.c,37 :: 		if ((current_period > 0) && (current_period < total_period)){ // if duty is > 0% AND < 100% then:
	MOVF       _current_period+3, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt15
	MOVF       _current_period+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt15
	MOVF       _current_period+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt15
	MOVF       _current_period+0, 0
	SUBLW      0
L__interrupt15:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt3
	MOVLW      0
	SUBWF      _current_period+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt16
	MOVLW      0
	SUBWF      _current_period+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt16
	MOVLW      48
	SUBWF      _current_period+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt16
	MOVLW      212
	SUBWF      _current_period+0, 0
L__interrupt16:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt3
L__interrupt11:
;icaros1.c,39 :: 		if (MOT1 == 1) {                           // if the MOT1put was 1 -> was "on-time".
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_interrupt4
;icaros1.c,40 :: 		MOT1 = 0;
	BCF        RB0_bit+0, BitPos(RB0_bit+0)
;icaros1.c,41 :: 		MOT2 = 0;                                  // set MOT1put to 0 in order to achieve "off-time".
	BCF        RA7_bit+0, BitPos(RA7_bit+0)
;icaros1.c,42 :: 		CCPR = total_period - current_period;     // make it time for "off-time", off-time = full time - on time.
	MOVLW      212
	MOVWF      _CCPR+0
	MOVLW      48
	MOVWF      _CCPR+1
	MOVLW      0
	MOVWF      _CCPR+2
	MOVLW      0
	MOVWF      _CCPR+3
	MOVF       _current_period+0, 0
	SUBWF      _CCPR+0, 1
	MOVF       _current_period+1, 0
	SUBWFB     _CCPR+1, 1
	MOVF       _current_period+2, 0
	SUBWFB     _CCPR+2, 1
	MOVF       _current_period+3, 0
	SUBWFB     _CCPR+3, 1
;icaros1.c,43 :: 		}
	GOTO       L_interrupt5
L_interrupt4:
;icaros1.c,46 :: 		MOT1 = 1;                               // set MOT1put to 1 in order to achieve "on-time"
	BSF        RB0_bit+0, BitPos(RB0_bit+0)
;icaros1.c,47 :: 		MOT2 = 1;
	BSF        RA7_bit+0, BitPos(RA7_bit+0)
;icaros1.c,48 :: 		CCPR = current_period;                 // make it time for "on-time".
	MOVF       _current_period+0, 0
	MOVWF      _CCPR+0
	MOVF       _current_period+1, 0
	MOVWF      _CCPR+1
	MOVF       _current_period+2, 0
	MOVWF      _CCPR+2
	MOVF       _current_period+3, 0
	MOVWF      _CCPR+3
;icaros1.c,49 :: 		}
L_interrupt5:
;icaros1.c,50 :: 		}
	GOTO       L_interrupt6
L_interrupt3:
;icaros1.c,52 :: 		if (current_period == total_period) { MOT1 = 1;MOT2 = 1;}             // if duty = 100%, then MOT1put 1 all the time.
	MOVF       _current_period+3, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt17
	MOVF       _current_period+2, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt17
	MOVF       _current_period+1, 0
	XORLW      48
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt17
	MOVF       _current_period+0, 0
	XORLW      212
L__interrupt17:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt7
	BSF        RB0_bit+0, BitPos(RB0_bit+0)
	BSF        RA7_bit+0, BitPos(RA7_bit+0)
L_interrupt7:
;icaros1.c,53 :: 		if (current_period == 0)            {MOT1 = 0;MOT2 = 0;}              // if duty = 0%, then MOT1put 0 all the time.
	MOVLW      0
	MOVWF      R0
	XORWF      _current_period+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt18
	MOVF       R0, 0
	XORWF      _current_period+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt18
	MOVF       R0, 0
	XORWF      _current_period+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt18
	MOVF       _current_period+0, 0
	XORLW      0
L__interrupt18:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt8
	BCF        RB0_bit+0, BitPos(RB0_bit+0)
	BCF        RA7_bit+0, BitPos(RA7_bit+0)
L_interrupt8:
;icaros1.c,54 :: 		}
L_interrupt6:
;icaros1.c,59 :: 		CCPR1H = CCPR >> 8;                       // right-shift CCPR by 8 then load it into CCPR1H register (load higher byte).
	MOVF       _CCPR+1, 0
	MOVWF      R0
	MOVF       _CCPR+2, 0
	MOVWF      R1
	MOVF       _CCPR+3, 0
	MOVWF      R2
	CLRF       R3
	MOVF       R0, 0
	MOVWF      CCPR1H+0
;icaros1.c,60 :: 		CCPR1L = CCPR;                            // put the lower byte of CCPR in CCPR1L register.
	MOVF       _CCPR+0, 0
	MOVWF      CCPR1L+0
;icaros1.c,61 :: 		PIR1.CCP1IF = 0;                               // reset CCP1 interrupt flag.
	BCF        PIR1+0, 2
;icaros1.c,62 :: 		}
L_interrupt0:
;icaros1.c,63 :: 		}
L_end_interrupt:
L__interrupt14:
	RETFIE     %s
; end of _interrupt

_main:

;icaros1.c,67 :: 		void main() {
;icaros1.c,68 :: 		init();
	CALL       _init+0
;icaros1.c,69 :: 		while(1){
L_main9:
;icaros1.c,70 :: 		current_period = total_period * 0.5;            // 50% duty cycle.
	MOVLW      106
	MOVWF      _current_period+0
	MOVLW      24
	MOVWF      _current_period+1
	CLRF       _current_period+2
	CLRF       _current_period+3
;icaros1.c,71 :: 		}
	GOTO       L_main9
;icaros1.c,75 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
