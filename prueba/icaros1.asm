
_main:

;icaros1.c,1 :: 		void main(){
;icaros1.c,2 :: 		ANSELA=0;
	CLRF       ANSELA+0
;icaros1.c,3 :: 		ANSELB=0;
	CLRF       ANSELB+0
;icaros1.c,4 :: 		TRISA=0b00000000;
	CLRF       TRISA+0
;icaros1.c,5 :: 		PORTA=255;
	MOVLW      255
	MOVWF      PORTA+0
;icaros1.c,6 :: 		TRISB=0b00000000;
	CLRF       TRISB+0
;icaros1.c,7 :: 		PORTB=255;
	MOVLW      255
	MOVWF      PORTB+0
;icaros1.c,8 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
