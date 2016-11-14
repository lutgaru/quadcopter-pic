
_UART1_Printf:

;gy-85-main.c,19 :: 		void UART1_Printf(int value){
;gy-85-main.c,21 :: 		IntToStr(value, txt);
	MOVF       FARG_UART1_Printf_value+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       FARG_UART1_Printf_value+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      UART1_Printf_txt_L0+0
	MOVWF      FARG_IntToStr_output+0
	MOVLW      hi_addr(UART1_Printf_txt_L0+0)
	MOVWF      FARG_IntToStr_output+1
	CALL       _IntToStr+0
;gy-85-main.c,22 :: 		UART1_Write_Text(txt);
	MOVLW      UART1_Printf_txt_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(UART1_Printf_txt_L0+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;gy-85-main.c,23 :: 		}
L_end_UART1_Printf:
	RETURN
; end of _UART1_Printf

_printf_result:

;gy-85-main.c,25 :: 		void printf_result(){
;gy-85-main.c,26 :: 		UART1_Write_Text("X_acc:");UART1_Printf(accel[0]); UART1_Write_Text("  ");
	MOVLW      ?lstr1_gy_4585_45main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr1_gy_4585_45main+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
	MOVF       _accel+0, 0
	MOVWF      FARG_UART1_Printf_value+0
	MOVF       _accel+1, 0
	MOVWF      FARG_UART1_Printf_value+1
	CALL       _UART1_Printf+0
	MOVLW      ?lstr2_gy_4585_45main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr2_gy_4585_45main+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;gy-85-main.c,27 :: 		UART1_Write_Text("Y_acc:");UART1_Printf(accel[1]); UART1_Write_Text("  ");
	MOVLW      ?lstr3_gy_4585_45main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr3_gy_4585_45main+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
	MOVF       _accel+2, 0
	MOVWF      FARG_UART1_Printf_value+0
	MOVF       _accel+3, 0
	MOVWF      FARG_UART1_Printf_value+1
	CALL       _UART1_Printf+0
	MOVLW      ?lstr4_gy_4585_45main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr4_gy_4585_45main+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;gy-85-main.c,28 :: 		UART1_Write_Text("Z_acc:");UART1_Printf(accel[2]); UART1_Write_Text("  ");
	MOVLW      ?lstr5_gy_4585_45main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr5_gy_4585_45main+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
	MOVF       _accel+4, 0
	MOVWF      FARG_UART1_Printf_value+0
	MOVF       _accel+5, 0
	MOVWF      FARG_UART1_Printf_value+1
	CALL       _UART1_Printf+0
	MOVLW      ?lstr6_gy_4585_45main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr6_gy_4585_45main+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;gy-85-main.c,29 :: 		UART1_Write_Text("\r\n");
	MOVLW      ?lstr7_gy_4585_45main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr7_gy_4585_45main+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;gy-85-main.c,31 :: 		UART1_Write_Text("X_mag:");UART1_Printf(magnetom[0]); UART1_Write_Text("  ");
	MOVLW      ?lstr8_gy_4585_45main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr8_gy_4585_45main+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
	MOVF       _magnetom+0, 0
	MOVWF      FARG_UART1_Printf_value+0
	MOVF       _magnetom+1, 0
	MOVWF      FARG_UART1_Printf_value+1
	CALL       _UART1_Printf+0
	MOVLW      ?lstr9_gy_4585_45main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr9_gy_4585_45main+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;gy-85-main.c,32 :: 		UART1_Write_Text("Y_mag:");UART1_Printf(magnetom[1]); UART1_Write_Text("  ");
	MOVLW      ?lstr10_gy_4585_45main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr10_gy_4585_45main+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
	MOVF       _magnetom+2, 0
	MOVWF      FARG_UART1_Printf_value+0
	MOVF       _magnetom+3, 0
	MOVWF      FARG_UART1_Printf_value+1
	CALL       _UART1_Printf+0
	MOVLW      ?lstr11_gy_4585_45main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr11_gy_4585_45main+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;gy-85-main.c,33 :: 		UART1_Write_Text("Z_mag:");UART1_Printf(magnetom[2]); UART1_Write_Text("  ");
	MOVLW      ?lstr12_gy_4585_45main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr12_gy_4585_45main+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
	MOVF       _magnetom+4, 0
	MOVWF      FARG_UART1_Printf_value+0
	MOVF       _magnetom+5, 0
	MOVWF      FARG_UART1_Printf_value+1
	CALL       _UART1_Printf+0
	MOVLW      ?lstr13_gy_4585_45main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr13_gy_4585_45main+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;gy-85-main.c,34 :: 		UART1_Write_Text("\r\n");
	MOVLW      ?lstr14_gy_4585_45main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr14_gy_4585_45main+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;gy-85-main.c,36 :: 		UART1_Write_Text("X_gyro:");UART1_Printf(gyro[0]); UART1_Write_Text("  ");
	MOVLW      ?lstr15_gy_4585_45main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr15_gy_4585_45main+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
	MOVF       _gyro+0, 0
	MOVWF      FARG_UART1_Printf_value+0
	MOVF       _gyro+1, 0
	MOVWF      FARG_UART1_Printf_value+1
	CALL       _UART1_Printf+0
	MOVLW      ?lstr16_gy_4585_45main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr16_gy_4585_45main+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;gy-85-main.c,37 :: 		UART1_Write_Text("Y_gyro:");UART1_Printf(gyro[1]); UART1_Write_Text("  ");
	MOVLW      ?lstr17_gy_4585_45main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr17_gy_4585_45main+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
	MOVF       _gyro+2, 0
	MOVWF      FARG_UART1_Printf_value+0
	MOVF       _gyro+3, 0
	MOVWF      FARG_UART1_Printf_value+1
	CALL       _UART1_Printf+0
	MOVLW      ?lstr18_gy_4585_45main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr18_gy_4585_45main+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;gy-85-main.c,38 :: 		UART1_Write_Text("Z_gyro:");UART1_Printf(gyro[2]); UART1_Write_Text("  ");
	MOVLW      ?lstr19_gy_4585_45main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr19_gy_4585_45main+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
	MOVF       _gyro+4, 0
	MOVWF      FARG_UART1_Printf_value+0
	MOVF       _gyro+5, 0
	MOVWF      FARG_UART1_Printf_value+1
	CALL       _UART1_Printf+0
	MOVLW      ?lstr20_gy_4585_45main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr20_gy_4585_45main+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;gy-85-main.c,39 :: 		UART1_Write_Text("\r\n");
	MOVLW      ?lstr21_gy_4585_45main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr21_gy_4585_45main+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;gy-85-main.c,40 :: 		}
L_end_printf_result:
	RETURN
; end of _printf_result

_GY_85_Init:

;gy-85-main.c,42 :: 		void GY_85_Init(){
;gy-85-main.c,43 :: 		Acc_Init();
	CALL       _Acc_Init+0
;gy-85-main.c,44 :: 		Magneto_Init();
	CALL       _Magneto_Init+0
;gy-85-main.c,45 :: 		Gyro_Init();
	CALL       _Gyro_Init+0
;gy-85-main.c,46 :: 		}
L_end_GY_85_Init:
	RETURN
; end of _GY_85_Init

_GY_85_Read:

;gy-85-main.c,48 :: 		void GY_85_Read(){
;gy-85-main.c,49 :: 		Acc_Read();
	CALL       _Acc_Read+0
;gy-85-main.c,50 :: 		Magneto_Read();
	CALL       _Magneto_Read+0
;gy-85-main.c,51 :: 		Gyro_Read();
	CALL       _Gyro_Read+0
;gy-85-main.c,52 :: 		}
L_end_GY_85_Read:
	RETURN
; end of _GY_85_Read

_main:

;gy-85-main.c,54 :: 		void main() {
;gy-85-main.c,55 :: 		OSCCON=0b01101010;
	MOVLW      106
	MOVWF      OSCCON+0
;gy-85-main.c,56 :: 		ANSELA=0x00;
	CLRF       ANSELA+0
;gy-85-main.c,57 :: 		ANSELB=0x00;
	CLRF       ANSELB+0
;gy-85-main.c,58 :: 		TRISB=0;
	CLRF       TRISB+0
;gy-85-main.c,59 :: 		TXCKSEL_bit=1;
	BSF        TXCKSEL_bit+0, BitPos(TXCKSEL_bit+0)
;gy-85-main.c,60 :: 		RXDTSEL_bit=1;
	BSF        RXDTSEL_bit+0, BitPos(RXDTSEL_bit+0)
;gy-85-main.c,61 :: 		UART1_Init(9600);
	BSF        BAUDCON+0, 3
	MOVLW      103
	MOVWF      SPBRG+0
	MOVLW      0
	MOVWF      SPBRG+1
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;gy-85-main.c,62 :: 		TRISB2_bit = 1;     // only change if pin remap done
	BSF        TRISB2_bit+0, BitPos(TRISB2_bit+0)
;gy-85-main.c,63 :: 		TRISB5_bit = 0;     // only change if pin remap done
	BCF        TRISB5_bit+0, BitPos(TRISB5_bit+0)
;gy-85-main.c,64 :: 		Delay_ms(100);
	MOVLW      130
	MOVWF      R12
	MOVLW      221
	MOVWF      R13
L_main0:
	DECFSZ     R13, 1
	GOTO       L_main0
	DECFSZ     R12, 1
	GOTO       L_main0
	NOP
	NOP
;gy-85-main.c,65 :: 		UART1_Write_Text("GY-85 Start\r\n");
	MOVLW      ?lstr22_gy_4585_45main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	MOVLW      hi_addr(?lstr22_gy_4585_45main+0)
	MOVWF      FARG_UART1_Write_Text_uart_text+1
	CALL       _UART1_Write_Text+0
;gy-85-main.c,66 :: 		I2C1_Init(100000);
	MOVLW      10
	MOVWF      SSP1ADD+0
	CALL       _I2C1_Init+0
;gy-85-main.c,67 :: 		Delay_ms(100);
	MOVLW      130
	MOVWF      R12
	MOVLW      221
	MOVWF      R13
L_main1:
	DECFSZ     R13, 1
	GOTO       L_main1
	DECFSZ     R12, 1
	GOTO       L_main1
	NOP
	NOP
;gy-85-main.c,68 :: 		GY_85_Init(); // Init GY-85 sensor
	CALL       _GY_85_Init+0
;gy-85-main.c,69 :: 		Delay_ms(100);
	MOVLW      130
	MOVWF      R12
	MOVLW      221
	MOVWF      R13
L_main2:
	DECFSZ     R13, 1
	GOTO       L_main2
	DECFSZ     R12, 1
	GOTO       L_main2
	NOP
	NOP
;gy-85-main.c,70 :: 		do{
L_main3:
;gy-85-main.c,71 :: 		GY_85_Read(); // Read GY-85 sensor
	CALL       _GY_85_Read+0
;gy-85-main.c,72 :: 		printf_result();// Send the data to the USART
	CALL       _printf_result+0
;gy-85-main.c,73 :: 		Delay_ms(1000);
	MOVLW      6
	MOVWF      R11
	MOVLW      19
	MOVWF      R12
	MOVLW      173
	MOVWF      R13
L_main6:
	DECFSZ     R13, 1
	GOTO       L_main6
	DECFSZ     R12, 1
	GOTO       L_main6
	DECFSZ     R11, 1
	GOTO       L_main6
	NOP
	NOP
;gy-85-main.c,74 :: 		}while(1);
	GOTO       L_main3
;gy-85-main.c,75 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
