
_interrupt:

;pwm4m.c,10 :: 		void interrupt(void){
;pwm4m.c,11 :: 		control_PWM++;                //Incremento cada rebose del timer0
	INCF       _control_PWM+0, 1
;pwm4m.c,13 :: 		if (control_PWM==0){          //inicio del ciclo con todos los pulsos pwm a 1
	MOVF       _control_PWM+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt0
;pwm4m.c,14 :: 		M1=1;
	BSF        PORTB+0, 0
;pwm4m.c,15 :: 		M2=1;
	BSF        PORTA+0, 7
;pwm4m.c,16 :: 		M3=1;
	BSF        PORTA+0, 3
;pwm4m.c,17 :: 		M4=1;
	BSF        PORTA+0, 4
;pwm4m.c,19 :: 		}
L_interrupt0:
;pwm4m.c,21 :: 		if (control_PWM==PWM0) M1=0;
	MOVF       _control_PWM+0, 0
	XORWF      _PWM0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
	BCF        PORTB+0, 0
L_interrupt1:
;pwm4m.c,22 :: 		if (control_PWM==PWM1) M2=0;
	MOVF       _control_PWM+0, 0
	XORWF      _PWM1+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt2
	BCF        PORTA+0, 7
L_interrupt2:
;pwm4m.c,23 :: 		if (control_PWM==PWM2) M3=0;
	MOVF       _control_PWM+0, 0
	XORWF      _PWM2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt3
	BCF        PORTA+0, 3
L_interrupt3:
;pwm4m.c,24 :: 		if (control_PWM==PWM3) M4=0;
	MOVF       _control_PWM+0, 0
	XORWF      _PWM3+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt4
	BCF        PORTA+0, 4
L_interrupt4:
;pwm4m.c,26 :: 		TMR0= 254;                    //Carga del contador
	MOVLW      254
	MOVWF      TMR0+0
;pwm4m.c,27 :: 		INTCON.TMR0IF=0;
	BCF        INTCON+0, 2
;pwm4m.c,28 :: 		}
L_end_interrupt:
L__interrupt8:
	RETFIE     %s
; end of _interrupt

_main:

;pwm4m.c,31 :: 		void main(){
;pwm4m.c,32 :: 		ANSELA=0;
	CLRF       ANSELA+0
;pwm4m.c,33 :: 		ANSELB=0;
	CLRF       ANSELB+0
;pwm4m.c,34 :: 		TRISA=0;
	CLRF       TRISA+0
;pwm4m.c,35 :: 		PORTA=0;
	CLRF       PORTA+0
;pwm4m.c,36 :: 		TRISB=0;
	CLRF       TRISB+0
;pwm4m.c,37 :: 		PORTB=0;
	CLRF       PORTB+0
;pwm4m.c,38 :: 		OPTION_REG = 0x07;   // Pre-escalador (1:32) se le asigna al temporizador Timer0
	MOVLW      7
	MOVWF      OPTION_REG+0
;pwm4m.c,39 :: 		INTCON = 0xA0;       // Habilitada la generación de interrupción para el
	MOVLW      160
	MOVWF      INTCON+0
;pwm4m.c,40 :: 		TMR0 = 254;          // Temporizador T0 cuenta de 155 a 255
	MOVLW      254
	MOVWF      TMR0+0
;pwm4m.c,41 :: 		while(1){
L_main5:
;pwm4m.c,43 :: 		pwm0=200;                      //Impulso de 0,8 msg de pwm0 posición 0º
	MOVLW      200
	MOVWF      _PWM0+0
;pwm4m.c,44 :: 		pwm1=100;                      //Impulso de 0,8 msg de pwm1 posición 0º
	MOVLW      100
	MOVWF      _PWM1+0
;pwm4m.c,45 :: 		pwm2=50;                      //Impulso de 0,8 msg de pwm2 posición 0º
	MOVLW      50
	MOVWF      _PWM2+0
;pwm4m.c,46 :: 		pwm3=25;                      //Impulso de 0,8 msg de pwm3 posición 0º
	MOVLW      25
	MOVWF      _PWM3+0
;pwm4m.c,48 :: 		}
	GOTO       L_main5
;pwm4m.c,49 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
