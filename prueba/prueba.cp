#line 1 "C:/Users/NEFT/Documents/GitHub/quadcopter-pic/prueba/prueba.c"
#pragma config OSC=HS
#pragma config PWRT = OFF, BOREN = OFF
#pragma config WDT = OFF, WDTPS = 128
#pragma config PBADEN = OFF, LVP = OFF
#line 18 "C:/Users/NEFT/Documents/GitHub/quadcopter-pic/prueba/prueba.c"
uint8 servo_active=0;
uint16 pulse[ 5 ]={600,900,1200,1500,1800};
uint16 TMR0_ini;
#pragma interrupt high_ISR
#line 28 "C:/Users/NEFT/Documents/GitHub/quadcopter-pic/prueba/prueba.c"
void high_ISR (void)
{
 PORTDbits.RD0=1;
 if (TMR0_flag)
 {
 switch (servo_active)
 {
 case 0:
  RBO =1- RBO ;
 if ( RBO ) TMR0_ini= 25-pulse[0];
 else {TMR0_ini=  (65536- (20000/ 5 ) +30) +pulse[0]; servo_active++;}
 break;
 case 1:
  RA7 =1- RA7 ;
 if ( RA7 ) TMR0_ini= 25-pulse[1];
 else {TMR0_ini=  (65536- (20000/ 5 ) +30) +pulse[1]; servo_active++; }
 break;
 case 2:
  RA3 =1- RA3 ;
 if ( RA3 ) TMR0_ini= 25-pulse[2];
 else {TMR0_ini=  (65536- (20000/ 5 ) +30) +pulse[2]; servo_active++; }
 break;
 case 3:
  RA4 =1- RA4 ;
 if ( RA4 ) TMR0_ini= 25-pulse[3];
 else {TMR0_ini=  (65536- (20000/ 5 ) +30) +pulse[3]; servo_active++; }
 break;
 case 4:
 SERVO_4=1-SERVO_4;
 if (SERVO_4) TMR0_ini= 25-pulse[4];
 else {TMR0_ini=  (65536- (20000/ 5 ) +30) +pulse[4]; servo_active=0; }
 break;
 }
  {TMR0H=(TMR0_ini>>8); TMR0L=(TMR0_ini&0x00FF);} ;
 TMR0_flag=0;
 }
 PORTDbits.RD0=0;
}
#pragma code high_vector = 0x0008
#line 69 "C:/Users/NEFT/Documents/GitHub/quadcopter-pic/prueba/prueba.c"
 void code_0x0008(void) {_asm goto high_ISR _endasm}
#pragma code
#line 74 "C:/Users/NEFT/Documents/GitHub/quadcopter-pic/prueba/prueba.c"
void main() {
 uint8 k=0;

 T0CON = 0b00000000;

 enable_global_ints; enable_TMR0_int;
  T0CONbits.TMR0ON=1; ;

 ADCON1=0x0F;
 TRISA=0b00000111;


 TRISB=0; TRISC=0; TRISD=0; PORTB=0; PORTD=0;
 while(1)
 {
 if (PORTAbits.RA0==1) {k++; if (k== 5 ) k=0; PORTB=k;}
 if (PORTAbits.RA1==1) if (pulse[k]<2100) pulse[k]++;
 if (PORTAbits.RA2==1) if (pulse[k]>500) pulse[k]--;

 Delay10TCYx(100);




 }

}
