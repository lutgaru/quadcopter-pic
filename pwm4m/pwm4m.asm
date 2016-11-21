
_interrupt:

;pwm4m.c,16 :: 		void interrupt() {
;pwm4m.c,17 :: 		if (PIR1.CCP1IF == 1) {                           // if CCP compare interrupt flag is set
	BTFSS      PIR1+0, 2
	GOTO       L_interrupt0
;pwm4m.c,20 :: 		if ((current_period1 > 0) && (current_period1 < total_period1)){ // if duty is > 0% AND < 100% then:
	MOVF       _current_period1+3, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt41
	MOVF       _current_period1+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt41
	MOVF       _current_period1+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt41
	MOVF       _current_period1+0, 0
	SUBLW      0
L__interrupt41:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt3
	MOVLW      0
	SUBWF      _current_period1+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt42
	MOVLW      0
	SUBWF      _current_period1+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt42
	MOVLW      48
	SUBWF      _current_period1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt42
	MOVLW      212
	SUBWF      _current_period1+0, 0
L__interrupt42:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt3
L__interrupt38:
;pwm4m.c,22 :: 		if (M1 == 1) {                           // if the output was 1 -> was "on-time".
	BTFSS      PORTB+0, 0
	GOTO       L_interrupt4
;pwm4m.c,23 :: 		M1 = 0;                                  // set output to 0 in order to achieve "off-time".
	BCF        PORTB+0, 0
;pwm4m.c,24 :: 		CCPR = total_period1 - current_period1;     // make it time for "off-time", off-time = full time - on time.
	MOVLW      212
	MOVWF      _CCPR+0
	MOVLW      48
	MOVWF      _CCPR+1
	MOVLW      0
	MOVWF      _CCPR+2
	MOVLW      0
	MOVWF      _CCPR+3
	MOVF       _current_period1+0, 0
	SUBWF      _CCPR+0, 1
	MOVF       _current_period1+1, 0
	SUBWFB     _CCPR+1, 1
	MOVF       _current_period1+2, 0
	SUBWFB     _CCPR+2, 1
	MOVF       _current_period1+3, 0
	SUBWFB     _CCPR+3, 1
;pwm4m.c,25 :: 		}
	GOTO       L_interrupt5
L_interrupt4:
;pwm4m.c,28 :: 		M1 = 1;                               // set output to 1 in order to achieve "on-time"
	BSF        PORTB+0, 0
;pwm4m.c,29 :: 		CCPR = current_period1;                 // make it time for "on-time".
	MOVF       _current_period1+0, 0
	MOVWF      _CCPR+0
	MOVF       _current_period1+1, 0
	MOVWF      _CCPR+1
	MOVF       _current_period1+2, 0
	MOVWF      _CCPR+2
	MOVF       _current_period1+3, 0
	MOVWF      _CCPR+3
;pwm4m.c,30 :: 		}
L_interrupt5:
;pwm4m.c,31 :: 		}
	GOTO       L_interrupt6
L_interrupt3:
;pwm4m.c,33 :: 		if (current_period1 == total_period1) { M1 = 1;}             // if duty = 100%, then output 1 all the time.
	MOVF       _current_period1+3, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt43
	MOVF       _current_period1+2, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt43
	MOVF       _current_period1+1, 0
	XORLW      48
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt43
	MOVF       _current_period1+0, 0
	XORLW      212
L__interrupt43:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt7
	BSF        PORTB+0, 0
L_interrupt7:
;pwm4m.c,34 :: 		if (current_period1 == 0)            {M1 = 0;}              // if duty = 0%, then output 0 all the time.
	MOVLW      0
	MOVWF      R0
	XORWF      _current_period1+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt44
	MOVF       R0, 0
	XORWF      _current_period1+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt44
	MOVF       R0, 0
	XORWF      _current_period1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt44
	MOVF       _current_period1+0, 0
	XORLW      0
L__interrupt44:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt8
	BCF        PORTB+0, 0
L_interrupt8:
;pwm4m.c,35 :: 		}
L_interrupt6:
;pwm4m.c,36 :: 		if ((current_period2 > 0) && (current_period2 < total_period2)){ // if duty is > 0% AND < 100% then:
	MOVF       _current_period2+3, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt45
	MOVF       _current_period2+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt45
	MOVF       _current_period2+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt45
	MOVF       _current_period2+0, 0
	SUBLW      0
L__interrupt45:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt11
	MOVLW      0
	SUBWF      _current_period2+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt46
	MOVLW      0
	SUBWF      _current_period2+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt46
	MOVLW      48
	SUBWF      _current_period2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt46
	MOVLW      212
	SUBWF      _current_period2+0, 0
L__interrupt46:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt11
L__interrupt37:
;pwm4m.c,38 :: 		if (M2 == 1) {                           // if the output was 1 -> was "on-time".
	BTFSS      PORTA+0, 7
	GOTO       L_interrupt12
;pwm4m.c,39 :: 		M2 = 0;                                  // set output to 0 in order to achieve "off-time".
	BCF        PORTA+0, 7
;pwm4m.c,40 :: 		CCPR = total_period2 - current_period2;     // make it time for "off-time", off-time = full time - on time.
	MOVLW      212
	MOVWF      _CCPR+0
	MOVLW      48
	MOVWF      _CCPR+1
	MOVLW      0
	MOVWF      _CCPR+2
	MOVLW      0
	MOVWF      _CCPR+3
	MOVF       _current_period2+0, 0
	SUBWF      _CCPR+0, 1
	MOVF       _current_period2+1, 0
	SUBWFB     _CCPR+1, 1
	MOVF       _current_period2+2, 0
	SUBWFB     _CCPR+2, 1
	MOVF       _current_period2+3, 0
	SUBWFB     _CCPR+3, 1
;pwm4m.c,41 :: 		}
	GOTO       L_interrupt13
L_interrupt12:
;pwm4m.c,44 :: 		M2 = 1;                               // set output to 1 in order to achieve "on-time"
	BSF        PORTA+0, 7
;pwm4m.c,45 :: 		CCPR = current_period2;                 // make it time for "on-time".
	MOVF       _current_period2+0, 0
	MOVWF      _CCPR+0
	MOVF       _current_period2+1, 0
	MOVWF      _CCPR+1
	MOVF       _current_period2+2, 0
	MOVWF      _CCPR+2
	MOVF       _current_period2+3, 0
	MOVWF      _CCPR+3
;pwm4m.c,46 :: 		}
L_interrupt13:
;pwm4m.c,47 :: 		}
	GOTO       L_interrupt14
L_interrupt11:
;pwm4m.c,49 :: 		if (current_period2 == total_period2) { M2 = 1;}             // if duty = 100%, then output 1 all the time.
	MOVF       _current_period2+3, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt47
	MOVF       _current_period2+2, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt47
	MOVF       _current_period2+1, 0
	XORLW      48
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt47
	MOVF       _current_period2+0, 0
	XORLW      212
L__interrupt47:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt15
	BSF        PORTA+0, 7
L_interrupt15:
;pwm4m.c,50 :: 		if (current_period2 == 0)            {M2 = 0;}              // if duty = 0%, then output 0 all the time.
	MOVLW      0
	MOVWF      R0
	XORWF      _current_period2+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt48
	MOVF       R0, 0
	XORWF      _current_period2+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt48
	MOVF       R0, 0
	XORWF      _current_period2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt48
	MOVF       _current_period2+0, 0
	XORLW      0
L__interrupt48:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt16
	BCF        PORTA+0, 7
L_interrupt16:
;pwm4m.c,51 :: 		}
L_interrupt14:
;pwm4m.c,52 :: 		if ((current_period3 > 0) && (current_period3 < total_period3)){ // if duty is > 0% AND < 100% then:
	MOVF       _current_period3+3, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt49
	MOVF       _current_period3+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt49
	MOVF       _current_period3+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt49
	MOVF       _current_period3+0, 0
	SUBLW      0
L__interrupt49:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt19
	MOVLW      0
	SUBWF      _current_period3+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt50
	MOVLW      0
	SUBWF      _current_period3+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt50
	MOVLW      48
	SUBWF      _current_period3+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt50
	MOVLW      212
	SUBWF      _current_period3+0, 0
L__interrupt50:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt19
L__interrupt36:
;pwm4m.c,54 :: 		if (M3 == 1) {                           // if the output was 1 -> was "on-time".
	BTFSS      PORTA+0, 3
	GOTO       L_interrupt20
;pwm4m.c,55 :: 		M3 = 0;                                  // set output to 0 in order to achieve "off-time".
	BCF        PORTA+0, 3
;pwm4m.c,56 :: 		CCPR = total_period3 - current_period3;     // make it time for "off-time", off-time = full time - on time.
	MOVLW      212
	MOVWF      _CCPR+0
	MOVLW      48
	MOVWF      _CCPR+1
	MOVLW      0
	MOVWF      _CCPR+2
	MOVLW      0
	MOVWF      _CCPR+3
	MOVF       _current_period3+0, 0
	SUBWF      _CCPR+0, 1
	MOVF       _current_period3+1, 0
	SUBWFB     _CCPR+1, 1
	MOVF       _current_period3+2, 0
	SUBWFB     _CCPR+2, 1
	MOVF       _current_period3+3, 0
	SUBWFB     _CCPR+3, 1
;pwm4m.c,57 :: 		}
	GOTO       L_interrupt21
L_interrupt20:
;pwm4m.c,60 :: 		M3 = 1;                               // set output to 1 in order to achieve "on-time"
	BSF        PORTA+0, 3
;pwm4m.c,61 :: 		CCPR = current_period3;                 // make it time for "on-time".
	MOVF       _current_period3+0, 0
	MOVWF      _CCPR+0
	MOVF       _current_period3+1, 0
	MOVWF      _CCPR+1
	MOVF       _current_period3+2, 0
	MOVWF      _CCPR+2
	MOVF       _current_period3+3, 0
	MOVWF      _CCPR+3
;pwm4m.c,62 :: 		}
L_interrupt21:
;pwm4m.c,63 :: 		}
	GOTO       L_interrupt22
L_interrupt19:
;pwm4m.c,65 :: 		if (current_period3 == total_period3) { M3 = 1;}             // if duty = 100%, then output 1 all the time.
	MOVF       _current_period3+3, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt51
	MOVF       _current_period3+2, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt51
	MOVF       _current_period3+1, 0
	XORLW      48
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt51
	MOVF       _current_period3+0, 0
	XORLW      212
L__interrupt51:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt23
	BSF        PORTA+0, 3
L_interrupt23:
;pwm4m.c,66 :: 		if (current_period3 == 0)            {M3 = 0;}              // if duty = 0%, then output 0 all the time.
	MOVLW      0
	MOVWF      R0
	XORWF      _current_period3+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt52
	MOVF       R0, 0
	XORWF      _current_period3+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt52
	MOVF       R0, 0
	XORWF      _current_period3+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt52
	MOVF       _current_period3+0, 0
	XORLW      0
L__interrupt52:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt24
	BCF        PORTA+0, 3
L_interrupt24:
;pwm4m.c,67 :: 		}
L_interrupt22:
;pwm4m.c,68 :: 		if ((current_period4 > 0) && (current_period4 < total_period4)){ // if duty is > 0% AND < 100% then:
	MOVF       _current_period4+3, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt53
	MOVF       _current_period4+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt53
	MOVF       _current_period4+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt53
	MOVF       _current_period4+0, 0
	SUBLW      0
L__interrupt53:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt27
	MOVLW      0
	SUBWF      _current_period4+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt54
	MOVLW      0
	SUBWF      _current_period4+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt54
	MOVLW      48
	SUBWF      _current_period4+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt54
	MOVLW      212
	SUBWF      _current_period4+0, 0
L__interrupt54:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt27
L__interrupt35:
;pwm4m.c,70 :: 		if (M4 == 1) {                           // if the output was 1 -> was "on-time".
	BTFSS      PORTA+0, 4
	GOTO       L_interrupt28
;pwm4m.c,71 :: 		M4 = 0;                                  // set output to 0 in order to achieve "off-time".
	BCF        PORTA+0, 4
;pwm4m.c,72 :: 		CCPR = total_period4 - current_period4;     // make it time for "off-time", off-time = full time - on time.
	MOVLW      212
	MOVWF      _CCPR+0
	MOVLW      48
	MOVWF      _CCPR+1
	MOVLW      0
	MOVWF      _CCPR+2
	MOVLW      0
	MOVWF      _CCPR+3
	MOVF       _current_period4+0, 0
	SUBWF      _CCPR+0, 1
	MOVF       _current_period4+1, 0
	SUBWFB     _CCPR+1, 1
	MOVF       _current_period4+2, 0
	SUBWFB     _CCPR+2, 1
	MOVF       _current_period4+3, 0
	SUBWFB     _CCPR+3, 1
;pwm4m.c,73 :: 		}
	GOTO       L_interrupt29
L_interrupt28:
;pwm4m.c,76 :: 		M4 = 1;                               // set output to 1 in order to achieve "on-time"
	BSF        PORTA+0, 4
;pwm4m.c,77 :: 		CCPR = current_period4;                 // make it time for "on-time".
	MOVF       _current_period4+0, 0
	MOVWF      _CCPR+0
	MOVF       _current_period4+1, 0
	MOVWF      _CCPR+1
	MOVF       _current_period4+2, 0
	MOVWF      _CCPR+2
	MOVF       _current_period4+3, 0
	MOVWF      _CCPR+3
;pwm4m.c,78 :: 		}
L_interrupt29:
;pwm4m.c,79 :: 		}
	GOTO       L_interrupt30
L_interrupt27:
;pwm4m.c,81 :: 		if (current_period4 == total_period4) { M4 = 1;}             // if duty = 100%, then output 1 all the time.
	MOVF       _current_period4+3, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt55
	MOVF       _current_period4+2, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt55
	MOVF       _current_period4+1, 0
	XORLW      48
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt55
	MOVF       _current_period4+0, 0
	XORLW      212
L__interrupt55:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt31
	BSF        PORTA+0, 4
L_interrupt31:
;pwm4m.c,82 :: 		if (current_period4 == 0)            {M4 = 0;}              // if duty = 0%, then output 0 all the time.
	MOVLW      0
	MOVWF      R0
	XORWF      _current_period4+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt56
	MOVF       R0, 0
	XORWF      _current_period4+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt56
	MOVF       R0, 0
	XORWF      _current_period4+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt56
	MOVF       _current_period4+0, 0
	XORLW      0
L__interrupt56:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt32
	BCF        PORTA+0, 4
L_interrupt32:
;pwm4m.c,83 :: 		}
L_interrupt30:
;pwm4m.c,88 :: 		CCPR1H = CCPR >> 8;                       // right-shift CCPR by 8 then load it into CCPR1H register (load higher byte).
	MOVF       _CCPR+1, 0
	MOVWF      R0
	MOVF       _CCPR+2, 0
	MOVWF      R1
	MOVF       _CCPR+3, 0
	MOVWF      R2
	CLRF       R3
	MOVF       R0, 0
	MOVWF      CCPR1H+0
;pwm4m.c,89 :: 		CCPR1L = CCPR;                            // put the lower byte of CCPR in CCPR1L register.
	MOVF       _CCPR+0, 0
	MOVWF      CCPR1L+0
;pwm4m.c,90 :: 		PIR1.CCP1IF = 0;                               // reset CCP1 interrupt flag.
	BCF        PIR1+0, 2
;pwm4m.c,91 :: 		}
L_interrupt0:
;pwm4m.c,93 :: 		}
L_end_interrupt:
L__interrupt40:
	RETFIE     %s
; end of _interrupt

_main:

;pwm4m.c,97 :: 		void main() {
;pwm4m.c,99 :: 		ANSELA = 0;
	CLRF       ANSELA+0
;pwm4m.c,100 :: 		ANSELB = 0;
	CLRF       ANSELB+0
;pwm4m.c,101 :: 		TRISA = 0;                 // port c is output.
	CLRF       TRISA+0
;pwm4m.c,102 :: 		TRISB = 0;
	CLRF       TRISB+0
;pwm4m.c,103 :: 		PORTA = 0;
	CLRF       PORTA+0
;pwm4m.c,104 :: 		PORTB = 0;                 // port c = 0.
	CLRF       PORTB+0
;pwm4m.c,106 :: 		T1CON = 0b00110000;        // timer1 uses prescaler value of 8 and it is off.
	MOVLW      48
	MOVWF      T1CON+0
;pwm4m.c,107 :: 		TMR1H = 0;                 // timer1 registers have 0 (clear).
	CLRF       TMR1H+0
;pwm4m.c,108 :: 		TMR1L = 0;
	CLRF       TMR1L+0
;pwm4m.c,110 :: 		CCP1CON = 0x0b;            // set CCP module to compare mode and trigger special event when interrupt happens.
	MOVLW      11
	MOVWF      CCP1CON+0
;pwm4m.c,111 :: 		CCP2CON = 0x0b;            // set CCP module to compare mode and trigger special event when interrupt happens.
	MOVLW      11
	MOVWF      CCP2CON+0
;pwm4m.c,112 :: 		CCP3CON = 0x0b;            // set CCP module to compare mode and trigger special event when interrupt happens.
	MOVLW      11
	MOVWF      CCP3CON+0
;pwm4m.c,113 :: 		CCP4CON = 0x0b;            // set CCP module to compare mode and trigger special event when interrupt happens.
	MOVLW      11
	MOVWF      CCP4CON+0
;pwm4m.c,114 :: 		CCPR = 0;                  // load 0 in CCPR.
	CLRF       _CCPR+0
	CLRF       _CCPR+1
	CLRF       _CCPR+2
	CLRF       _CCPR+3
;pwm4m.c,115 :: 		PIR1.CCP1IF = 0;                // clear CCP1 interrupt flag.
	BCF        PIR1+0, 2
;pwm4m.c,116 :: 		PIR2.CCP2IF = 0;                // clear CCP1 interrupt flag.
	BCF        PIR2+0, 0
;pwm4m.c,117 :: 		PIR3.CCP3IF = 0;                // clear CCP1 interrupt flag.
	BCF        PIR3+0, 4
;pwm4m.c,118 :: 		PIR3.CCP4IF = 0;                // clear CCP1 interrupt flag.
	BCF        PIR3+0, 5
;pwm4m.c,119 :: 		PIE1.CCP1IE = 1;                // enable CCP1 interrupt.
	BSF        PIE1+0, 2
;pwm4m.c,120 :: 		PIE2.CCP2IE = 1;                // enable CCP1 interrupt.
	BSF        PIE2+0, 0
;pwm4m.c,121 :: 		PIE3.CCP3IE = 1;                // enable CCP1 interrupt.
	BSF        PIE3+0, 4
;pwm4m.c,122 :: 		PIE3.CCP4IE = 1;                // enable CCP1 interrupt.
	BSF        PIE3+0, 5
;pwm4m.c,123 :: 		INTCON = 0xC0;             // enable global and peripheral interrupt.
	MOVLW      192
	MOVWF      INTCON+0
;pwm4m.c,124 :: 		T1CON = 0b00110001;        // start timer1 with the same settings like before.
	MOVLW      49
	MOVWF      T1CON+0
;pwm4m.c,129 :: 		while (1) {                                          // infinite loop.
L_main33:
;pwm4m.c,134 :: 		current_period1 = total_period1 * 0.9;            // 50% duty cycle.
	MOVLW      242
	MOVWF      _current_period1+0
	MOVLW      43
	MOVWF      _current_period1+1
	CLRF       _current_period1+2
	CLRF       _current_period1+3
;pwm4m.c,135 :: 		current_period2 = total_period2 * 0.5;            // 50% duty cycle.
	MOVLW      106
	MOVWF      _current_period2+0
	MOVLW      24
	MOVWF      _current_period2+1
	CLRF       _current_period2+2
	CLRF       _current_period2+3
;pwm4m.c,136 :: 		current_period3 = total_period3 * 0.2;            // 50% duty cycle.
	MOVLW      196
	MOVWF      _current_period3+0
	MOVLW      9
	MOVWF      _current_period3+1
	CLRF       _current_period3+2
	CLRF       _current_period3+3
;pwm4m.c,137 :: 		current_period4 = total_period4 * 0.9;            // 50% duty cycle.
	MOVLW      242
	MOVWF      _current_period4+0
	MOVLW      43
	MOVWF      _current_period4+1
	CLRF       _current_period4+2
	CLRF       _current_period4+3
;pwm4m.c,138 :: 		}                                           }
	GOTO       L_main33
L_end_main:
	GOTO       $+0
; end of _main
