
_interrupt:

;prueba.c,14 :: 		void interrupt() {
;prueba.c,15 :: 		if (PIR1.CCP1IF == 1) {                           // if CCP compare interrupt flag is set
	BTFSS      PIR1+0, 2
	GOTO       L_interrupt0
;prueba.c,18 :: 		if ((current_period > 0) && (current_period < total_period)){ // if duty is > 0% AND < 100% then:
	MOVF       _current_period+3, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt18
	MOVF       _current_period+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt18
	MOVF       _current_period+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt18
	MOVF       _current_period+0, 0
	SUBLW      0
L__interrupt18:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt3
	MOVLW      0
	SUBWF      _current_period+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt19
	MOVLW      0
	SUBWF      _current_period+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt19
	MOVLW      48
	SUBWF      _current_period+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt19
	MOVLW      212
	SUBWF      _current_period+0, 0
L__interrupt19:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt3
L__interrupt15:
;prueba.c,20 :: 		if (OUT == 1) {                           // if the output was 1 -> was "on-time".
	BTFSS      RB2_bit+0, BitPos(RB2_bit+0)
	GOTO       L_interrupt4
;prueba.c,21 :: 		OUT = 0;                                  // set output to 0 in order to achieve "off-time".
	BCF        RB2_bit+0, BitPos(RB2_bit+0)
;prueba.c,22 :: 		CCPR = total_period - current_period;     // make it time for "off-time", off-time = full time - on time.
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
;prueba.c,23 :: 		}
	GOTO       L_interrupt5
L_interrupt4:
;prueba.c,26 :: 		OUT = 1;                               // set output to 1 in order to achieve "on-time"
	BSF        RB2_bit+0, BitPos(RB2_bit+0)
;prueba.c,27 :: 		CCPR = current_period;                 // make it time for "on-time".
	MOVF       _current_period+0, 0
	MOVWF      _CCPR+0
	MOVF       _current_period+1, 0
	MOVWF      _CCPR+1
	MOVF       _current_period+2, 0
	MOVWF      _CCPR+2
	MOVF       _current_period+3, 0
	MOVWF      _CCPR+3
;prueba.c,28 :: 		}
L_interrupt5:
;prueba.c,29 :: 		}
	GOTO       L_interrupt6
L_interrupt3:
;prueba.c,31 :: 		if (current_period == total_period) { OUT = 1;}             // if duty = 100%, then output 1 all the time.
	MOVF       _current_period+3, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt20
	MOVF       _current_period+2, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt20
	MOVF       _current_period+1, 0
	XORLW      48
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt20
	MOVF       _current_period+0, 0
	XORLW      212
L__interrupt20:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt7
	BSF        RB2_bit+0, BitPos(RB2_bit+0)
L_interrupt7:
;prueba.c,32 :: 		if (current_period == 0)            {OUT = 0;}              // if duty = 0%, then output 0 all the time.
	MOVLW      0
	MOVWF      R0
	XORWF      _current_period+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt21
	MOVF       R0, 0
	XORWF      _current_period+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt21
	MOVF       R0, 0
	XORWF      _current_period+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt21
	MOVF       _current_period+0, 0
	XORLW      0
L__interrupt21:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt8
	BCF        RB2_bit+0, BitPos(RB2_bit+0)
L_interrupt8:
;prueba.c,33 :: 		}
L_interrupt6:
;prueba.c,38 :: 		CCPR1H = CCPR >> 8;                       // right-shift CCPR by 8 then load it into CCPR1H register (load higher byte).
	MOVF       _CCPR+1, 0
	MOVWF      R0
	MOVF       _CCPR+2, 0
	MOVWF      R1
	MOVF       _CCPR+3, 0
	MOVWF      R2
	CLRF       R3
	MOVF       R0, 0
	MOVWF      CCPR1H+0
;prueba.c,39 :: 		CCPR1L = CCPR;                            // put the lower byte of CCPR in CCPR1L register.
	MOVF       _CCPR+0, 0
	MOVWF      CCPR1L+0
;prueba.c,40 :: 		PIR1.CCP1IF = 0;                               // reset CCP1 interrupt flag.
	BCF        PIR1+0, 2
;prueba.c,41 :: 		}
L_interrupt0:
;prueba.c,42 :: 		}
L_end_interrupt:
L__interrupt17:
	RETFIE     %s
; end of _interrupt

_main:

;prueba.c,46 :: 		void main() {
;prueba.c,49 :: 		TRISB = 0;                 // port c is output.
	CLRF       TRISB+0
;prueba.c,50 :: 		PORTB = 0;                 // port c = 0.
	CLRF       PORTB+0
;prueba.c,52 :: 		T1CON = 0b00110000;        // timer1 uses prescaler value of 8 and it is off.
	MOVLW      48
	MOVWF      T1CON+0
;prueba.c,53 :: 		TMR1H = 0;                 // timer1 registers have 0 (clear).
	CLRF       TMR1H+0
;prueba.c,54 :: 		TMR1L = 0;
	CLRF       TMR1L+0
;prueba.c,56 :: 		CCP1CON = 0x0b;            // set CCP module to compare mode and trigger special event when interrupt happens.
	MOVLW      11
	MOVWF      CCP1CON+0
;prueba.c,57 :: 		CCPR = 0;                  // load 0 in CCPR.
	CLRF       _CCPR+0
	CLRF       _CCPR+1
	CLRF       _CCPR+2
	CLRF       _CCPR+3
;prueba.c,58 :: 		PIR1.CCP1IF = 0;                // clear CCP1 interrupt flag.
	BCF        PIR1+0, 2
;prueba.c,59 :: 		PIE1.CCP1IE = 1;                // enable CCP1 interrupt.
	BSF        PIE1+0, 2
;prueba.c,60 :: 		INTCON = 0xC0;             // enable global and peripheral interrupt.
	MOVLW      192
	MOVWF      INTCON+0
;prueba.c,61 :: 		T1CON = 0b00110001;        // start timer1 with the same settings like before.
	MOVLW      49
	MOVWF      T1CON+0
;prueba.c,66 :: 		while (1) {                                          // infinite loop.
L_main9:
;prueba.c,71 :: 		current_period = total_period * 0.5;            // 50% duty cycle.
	MOVLW      106
	MOVWF      _current_period+0
	MOVLW      24
	MOVWF      _current_period+1
	CLRF       _current_period+2
	CLRF       _current_period+3
;prueba.c,72 :: 		delay_ms(2000);                               // delay 2s.
	MOVLW      51
	MOVWF      R11
	MOVLW      187
	MOVWF      R12
	MOVLW      223
	MOVWF      R13
L_main11:
	DECFSZ     R13, 1
	GOTO       L_main11
	DECFSZ     R12, 1
	GOTO       L_main11
	DECFSZ     R11, 1
	GOTO       L_main11
	NOP
	NOP
;prueba.c,73 :: 		current_period = total_period * 0.1;            // 10% duty cycle.
	MOVLW      226
	MOVWF      _current_period+0
	MOVLW      4
	MOVWF      _current_period+1
	CLRF       _current_period+2
	CLRF       _current_period+3
;prueba.c,74 :: 		delay_ms(2000);                               // delay 2s.
	MOVLW      51
	MOVWF      R11
	MOVLW      187
	MOVWF      R12
	MOVLW      223
	MOVWF      R13
L_main12:
	DECFSZ     R13, 1
	GOTO       L_main12
	DECFSZ     R12, 1
	GOTO       L_main12
	DECFSZ     R11, 1
	GOTO       L_main12
	NOP
	NOP
;prueba.c,75 :: 		current_period = total_period * 1;              // 100% duty cycle.
	MOVLW      212
	MOVWF      _current_period+0
	MOVLW      48
	MOVWF      _current_period+1
	CLRF       _current_period+2
	CLRF       _current_period+3
;prueba.c,76 :: 		delay_ms(2000);                               // delay 2s.
	MOVLW      51
	MOVWF      R11
	MOVLW      187
	MOVWF      R12
	MOVLW      223
	MOVWF      R13
L_main13:
	DECFSZ     R13, 1
	GOTO       L_main13
	DECFSZ     R12, 1
	GOTO       L_main13
	DECFSZ     R11, 1
	GOTO       L_main13
	NOP
	NOP
;prueba.c,77 :: 		current_period = total_period * 0;              // 0% duty cycle.
	CLRF       _current_period+0
	CLRF       _current_period+1
	CLRF       _current_period+2
	CLRF       _current_period+3
;prueba.c,78 :: 		delay_ms(2000);                               // delay 2s.
	MOVLW      51
	MOVWF      R11
	MOVLW      187
	MOVWF      R12
	MOVLW      223
	MOVWF      R13
L_main14:
	DECFSZ     R13, 1
	GOTO       L_main14
	DECFSZ     R12, 1
	GOTO       L_main14
	DECFSZ     R11, 1
	GOTO       L_main14
	NOP
	NOP
;prueba.c,79 :: 		}
	GOTO       L_main9
;prueba.c,80 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
