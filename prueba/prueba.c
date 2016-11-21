

#pragma config OSC=HS
#pragma config PWRT = OFF, BOREN = OFF
#pragma config WDT = OFF, WDTPS = 128
#pragma config PBADEN = OFF, LVP = OFF


#define set_TMR0(x) {TMR0H=(x>>8); TMR0L=(x&0x00FF);}
#define start_TMR0 T0CONbits.TMR0ON=1;

#define N_SERVO 5
#define SERVO_0 RBO
#define SERVO_1 RA7
#define SERVO_2 RA3
#define SERVO_3 RA4

uint8 servo_active=0;
uint16 pulse[N_SERVO]={600,900,1200,1500,1800};    // in microsec
uint16 TMR0_ini;

#define slot   (20000/N_SERVO)   // Time slot allocated to each servo
#define c_slot (65536-slot+30)


// High priority interruption
#pragma interrupt high_ISR
void high_ISR (void)
{
 PORTDbits.RD0=1;
 if (TMR0_flag) // ISR de la interrupcion de TMR1
  {
	 switch (servo_active)
	  {
	   case 0:
       SERVO_0=1-SERVO_0;                  // Changes states of SERVO_1
	     if (SERVO_0) TMR0_ini= 25-pulse[0]; // if HIGH program pulse[0]delay
	     else {TMR0_ini= c_slot+pulse[0]; servo_active++;} // else program 20msec/N_SERVO - pulse[0] delay
	     break;
	   case 1:
       SERVO_1=1-SERVO_1;
	     if (SERVO_1) TMR0_ini= 25-pulse[1];
	     else {TMR0_ini= c_slot+pulse[1]; servo_active++; }
	     break;
	   case 2:
       SERVO_2=1-SERVO_2;
	     if (SERVO_2) TMR0_ini= 25-pulse[2];
	     else {TMR0_ini= c_slot+pulse[2]; servo_active++; }
	     break;
	   case 3:
       SERVO_3=1-SERVO_3;
	     if (SERVO_3) TMR0_ini= 25-pulse[3];
	     else {TMR0_ini= c_slot+pulse[3]; servo_active++; }
	     break;
	   case 4:
       SERVO_4=1-SERVO_4;
	     if (SERVO_4) TMR0_ini= 25-pulse[4];
	     else {TMR0_ini= c_slot+pulse[4]; servo_active=0; }
	     break;
	  }
	 set_TMR0(TMR0_ini);
   TMR0_flag=0;
  }
 PORTDbits.RD0=0;
}

// Code @ 0x0008 -> Jump to ISR for Low priority interruption
#pragma code high_vector = 0x0008
  void code_0x0008(void) {_asm goto high_ISR _endasm}
#pragma code



void main() {
  uint8 k=0;

  T0CON = 0b00000000;

   enable_global_ints; enable_TMR0_int;
   start_TMR0;

   ADCON1=0x0F;  // No PORTS used as AD
   TRISA=0b00000111;


   TRISB=0; TRISC=0;  TRISD=0; PORTB=0; PORTD=0;
   while(1)
    {
     if (PORTAbits.RA0==1) {k++; if (k==N_SERVO) k=0; PORTB=k;}
     if (PORTAbits.RA1==1) if (pulse[k]<2100) pulse[k]++;
     if (PORTAbits.RA2==1) if (pulse[k]>500) pulse[k]--;
     //PORTB = pulse[0]/10;
     Delay10TCYx(100);
     //xx=ADC_Read(2); PORTB=(xx>>2);
     //xx = xx*26; xx>>=4;
     //pulse[0]=800+xx; //pulse[1]=1975-xx;
     //delay_ms(20);
    }

}