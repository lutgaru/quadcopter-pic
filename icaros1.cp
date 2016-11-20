#line 1 "C:/Users/NEFT/Documents/GitHub/quadcopter-pic/icaros1.c"
#line 1 "c:/users/neft/documents/github/quadcopter-pic/gy-85-1827/gy85.h"


 unsigned short Read_Byte(unsigned short address_sensor,unsigned short register_address);
 void Acc_Init();
 void Acc_Read();
 void Magneto_Init();
 void Magneto_Read();
 void Gyro_Init();
 void Gyro_Read();
#line 6 "C:/Users/NEFT/Documents/GitHub/quadcopter-pic/icaros1.c"
unsigned long CCPR = 0;
unsigned long current_period = 0,current_period2 = 0,current_period3 = 0,current_period4 = 0;
const unsigned long total_period = 12500,total_period2 = 12500,total_period3 = 12500,total_period4 = 12500;

void init(){

 TRISA = 0x19;
 TRISB = 0x02;
 PORTB = 0x00;
 PORTA = 0x00;
 T1CON = 0b00110000;
 TMR1H = 0;
 TMR1L = 0;
 CCP1CON = 0x0B;
 CCPR = 0;
 PIR1.CCP1IF = 0;
 PIE1.CCP1IE = 1;
 INTCON = 0xC0;
 T1CON = 0b00110101;
 ANSELA= 0x00;
 ANSELB= 0x00;
 TXCKSEL_bit=1;
 RXDTSEL_bit=1;
 UART1_Init(9600);
}
 void interrupt() {
 if (PIR1.CCP1IF == 1) {


 if ((current_period > 0) && (current_period < total_period)){

 if ( RB0_bit  == 1) {
  RB0_bit  = 0;
  RA7_bit  = 0;
 CCPR = total_period - current_period;
 }

 else {
  RB0_bit  = 1;
  RA7_bit  = 1;
 CCPR = current_period;
 }
 }
 else {
 if (current_period == total_period) {  RB0_bit  = 1; RA7_bit  = 1;}
 if (current_period == 0) { RB0_bit  = 0; RA7_bit  = 0;}
 }




 CCPR1H = CCPR >> 8;
 CCPR1L = CCPR;
 PIR1.CCP1IF = 0;
 }
 }



void main() {
 init();
 while(1){
 current_period = total_period * 0.5;
 }



}
