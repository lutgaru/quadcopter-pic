
_interrupt:

;pwm4m.c,11 :: 		void interrupt(void){
;pwm4m.c,12 :: 		control_PWM++;                //Incremento cada rebose del timer0
	INCF       _control_PWM+0, 1
;pwm4m.c,14 :: 		if (control_PWM==0){          //inicio del ciclo con todos los pulsos pwm a 1
	MOVF       _control_PWM+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt0
;pwm4m.c,15 :: 		M1=1;
	BSF        PORTB+0, 0
;pwm4m.c,16 :: 		M2=1;
	BSF        PORTA+0, 7
;pwm4m.c,17 :: 		M3=1;
	BSF        PORTA+0, 3
;pwm4m.c,18 :: 		M4=1;
	BSF        PORTA+0, 4
;pwm4m.c,20 :: 		}
L_interrupt0:
;pwm4m.c,22 :: 		if (control_PWM==PWM0) M1=0;
	MOVF       _control_PWM+0, 0
	XORWF      _PWM0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
	BCF        PORTB+0, 0
L_interrupt1:
;pwm4m.c,23 :: 		if (control_PWM==PWM1) M2=0;
	MOVF       _control_PWM+0, 0
	XORWF      _PWM1+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt2
	BCF        PORTA+0, 7
L_interrupt2:
;pwm4m.c,24 :: 		if (control_PWM==PWM2) M3=0;
	MOVF       _control_PWM+0, 0
	XORWF      _PWM2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt3
	BCF        PORTA+0, 3
L_interrupt3:
;pwm4m.c,25 :: 		if (control_PWM==PWM3) M4=0;
	MOVF       _control_PWM+0, 0
	XORWF      _PWM3+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt4
	BCF        PORTA+0, 4
L_interrupt4:
;pwm4m.c,27 :: 		TMR0= 254;                    //Carga del contador
	MOVLW      254
	MOVWF      TMR0+0
;pwm4m.c,28 :: 		INTCON.TMR0IF=0;
	BCF        INTCON+0, 2
;pwm4m.c,29 :: 		}
L_end_interrupt:
L__interrupt13:
	RETFIE     %s
; end of _interrupt

_main:

;pwm4m.c,32 :: 		void main(){
;pwm4m.c,33 :: 		OSCCON=0b11110000;
	MOVLW      240
	MOVWF      OSCCON+0
;pwm4m.c,34 :: 		ANSELA=0;
	CLRF       ANSELA+0
;pwm4m.c,35 :: 		ANSELB=0;
	CLRF       ANSELB+0
;pwm4m.c,36 :: 		TRISA=0;
	CLRF       TRISA+0
;pwm4m.c,37 :: 		PORTA=0;
	CLRF       PORTA+0
;pwm4m.c,38 :: 		TRISB=0;
	CLRF       TRISB+0
;pwm4m.c,39 :: 		PORTB=0;
	CLRF       PORTB+0
;pwm4m.c,40 :: 		TXCKSEL_bit=1;
	BSF        TXCKSEL_bit+0, BitPos(TXCKSEL_bit+0)
;pwm4m.c,41 :: 		RXDTSEL_bit=1;
	BSF        RXDTSEL_bit+0, BitPos(RXDTSEL_bit+0)
;pwm4m.c,42 :: 		OPTION_REG = 0x07;   // Pre-escalador (1:32) se le asigna al temporizador Timer0
	MOVLW      7
	MOVWF      OPTION_REG+0
;pwm4m.c,43 :: 		INTCON = 0xA0;       // Habilitada la generación de interrupción para el
	MOVLW      160
	MOVWF      INTCON+0
;pwm4m.c,44 :: 		TMR0 = 254;          // Temporizador T0 cuenta de 155 a 255
	MOVLW      254
	MOVWF      TMR0+0
;pwm4m.c,45 :: 		UART1_Init(9600);
	BSF        BAUDCON+0, 3
	MOVLW      64
	MOVWF      SPBRG+0
	MOVLW      3
	MOVWF      SPBRG+1
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;pwm4m.c,46 :: 		TRISB2_bit = 1;     // only change if pin remap done
	BSF        TRISB2_bit+0, BitPos(TRISB2_bit+0)
;pwm4m.c,47 :: 		TRISB5_bit = 0;     // only change if pin remap done
	BCF        TRISB5_bit+0, BitPos(TRISB5_bit+0)
;pwm4m.c,48 :: 		Delay_ms(100);
	MOVLW      5
	MOVWF      R11
	MOVLW      15
	MOVWF      R12
	MOVLW      241
	MOVWF      R13
L_main5:
	DECFSZ     R13, 1
	GOTO       L_main5
	DECFSZ     R12, 1
	GOTO       L_main5
	DECFSZ     R11, 1
	GOTO       L_main5
;pwm4m.c,49 :: 		PWM0 = 4;
	MOVLW      4
	MOVWF      _PWM0+0
;pwm4m.c,50 :: 		PWM1 = 1;
	MOVLW      1
	MOVWF      _PWM1+0
;pwm4m.c,51 :: 		PWM2 = 1;
	MOVLW      1
	MOVWF      _PWM2+0
;pwm4m.c,52 :: 		PWM3 = 15 ;
	MOVLW      15
	MOVWF      _PWM3+0
;pwm4m.c,53 :: 		while(1){
L_main6:
;pwm4m.c,55 :: 		control = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0, 0
	MOVWF      _control+0
;pwm4m.c,56 :: 		if(control == 'a'){
	MOVF       R0, 0
	XORLW      97
	BTFSS      STATUS+0, 2
	GOTO       L_main8
;pwm4m.c,57 :: 		UART_Write_Text("PWM+\n\r");
	MOVLW      ?lstr1_pwm4m+0
	MOVWF      FARG_UART_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr1_pwm4m+0)
	MOVWF      FARG_UART_Write_Text_uart_text+1
	CALL       _UART_Write_Text+0
;pwm4m.c,58 :: 		Delay_ms(100);
	MOVLW      5
	MOVWF      R11
	MOVLW      15
	MOVWF      R12
	MOVLW      241
	MOVWF      R13
L_main9:
	DECFSZ     R13, 1
	GOTO       L_main9
	DECFSZ     R12, 1
	GOTO       L_main9
	DECFSZ     R11, 1
	GOTO       L_main9
;pwm4m.c,59 :: 		PWM0++;                    //Impulso de 0,8 msg de pwm0 posición 0º
	INCF       _PWM0+0, 1
;pwm4m.c,60 :: 		PWM1++;                      //Impulso de 0,8 msg de pwm1 posición 0º
	INCF       _PWM1+0, 1
;pwm4m.c,61 :: 		PWM2++;                      //Impulso de 0,8 msg de pwm2 posición 0º
	INCF       _PWM2+0, 1
;pwm4m.c,62 :: 		PWM3++;                      //Impulso de 0,8 msg de pwm3 posición 0º
	INCF       _PWM3+0, 1
;pwm4m.c,64 :: 		}
L_main8:
;pwm4m.c,65 :: 		if(control == 'b'){
	MOVF       _control+0, 0
	XORLW      98
	BTFSS      STATUS+0, 2
	GOTO       L_main10
;pwm4m.c,66 :: 		UART_Write_Text("PWM-\n\r");
	MOVLW      ?lstr2_pwm4m+0
	MOVWF      FARG_UART_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr2_pwm4m+0)
	MOVWF      FARG_UART_Write_Text_uart_text+1
	CALL       _UART_Write_Text+0
;pwm4m.c,67 :: 		Delay_ms(100);
	MOVLW      5
	MOVWF      R11
	MOVLW      15
	MOVWF      R12
	MOVLW      241
	MOVWF      R13
L_main11:
	DECFSZ     R13, 1
	GOTO       L_main11
	DECFSZ     R12, 1
	GOTO       L_main11
	DECFSZ     R11, 1
	GOTO       L_main11
;pwm4m.c,68 :: 		PWM0--;                    //Impulso de 0,8 msg de pwm0 posición 0º
	DECF       _PWM0+0, 1
;pwm4m.c,69 :: 		PWM1--;                      //Impulso de 0,8 msg de pwm1 posición 0º
	DECF       _PWM1+0, 1
;pwm4m.c,70 :: 		PWM2--;                      //Impulso de 0,8 msg de pwm2 posición 0º
	DECF       _PWM2+0, 1
;pwm4m.c,71 :: 		PWM3--;                      //Impulso de 0,8 msg de pwm3 posición 0º
	DECF       _PWM3+0, 1
;pwm4m.c,73 :: 		}
L_main10:
;pwm4m.c,74 :: 		}
	GOTO       L_main6
;pwm4m.c,75 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
