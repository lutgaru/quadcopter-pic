#line 1 "C:/Users/NEFT/Documents/GitHub/quadcopter-pic/pwm4m/pwm4m.c"









unsigned long CCPR = 0;
unsigned long current_period1 = 0,current_period2 = 0,current_period3 = 0,current_period4 = 0;
const unsigned long total_period1 = 12500,total_period2 = 12500,total_period3 = 12500,total_period4 = 12500;



void interrupt() {
 if (PIR1.CCP1IF == 1) {


 if ((current_period1 > 0) && (current_period1 < total_period1)){

 if ( PORTB.RB0  == 1) {
  PORTB.RB0  = 0;
 CCPR = total_period1 - current_period1;
 }

 else {
  PORTB.RB0  = 1;
 CCPR = current_period1;
 }
 }
 else {
 if (current_period1 == total_period1) {  PORTB.RB0  = 1;}
 if (current_period1 == 0) { PORTB.RB0  = 0;}
 }
 if ((current_period2 > 0) && (current_period2 < total_period2)){

 if ( PORTA.RA7  == 1) {
  PORTA.RA7  = 0;
 CCPR = total_period2 - current_period2;
 }

 else {
  PORTA.RA7  = 1;
 CCPR = current_period2;
 }
 }
 else {
 if (current_period2 == total_period2) {  PORTA.RA7  = 1;}
 if (current_period2 == 0) { PORTA.RA7  = 0;}
 }
 if ((current_period3 > 0) && (current_period3 < total_period3)){

 if ( PORTA.RA3  == 1) {
  PORTA.RA3  = 0;
 CCPR = total_period3 - current_period3;
 }

 else {
  PORTA.RA3  = 1;
 CCPR = current_period3;
 }
 }
 else {
 if (current_period3 == total_period3) {  PORTA.RA3  = 1;}
 if (current_period3 == 0) { PORTA.RA3  = 0;}
 }
 if ((current_period4 > 0) && (current_period4 < total_period4)){

 if ( PORTA.RA4  == 1) {
  PORTA.RA4  = 0;
 CCPR = total_period4 - current_period4;
 }

 else {
  PORTA.RA4  = 1;
 CCPR = current_period4;
 }
 }
 else {
 if (current_period4 == total_period4) {  PORTA.RA4  = 1;}
 if (current_period4 == 0) { PORTA.RA4  = 0;}
 }




 CCPR1H = CCPR >> 8;
 CCPR1L = CCPR;
 PIR1.CCP1IF = 0;
 }

}



void main() {

 ANSELA = 0;
 ANSELB = 0;
 TRISA = 0;
 TRISB = 0;
 PORTA = 0;
 PORTB = 0;

 T1CON = 0b00110000;
 TMR1H = 0;
 TMR1L = 0;

 CCP1CON = 0x0b;
 CCP2CON = 0x0b;
 CCP3CON = 0x0b;
 CCP4CON = 0x0b;
 CCPR = 0;
 PIR1.CCP1IF = 0;
 PIR2.CCP2IF = 0;
 PIR3.CCP3IF = 0;
 PIR3.CCP4IF = 0;
 PIE1.CCP1IE = 1;
 PIE2.CCP2IE = 1;
 PIE3.CCP3IE = 1;
 PIE3.CCP4IE = 1;
 INTCON = 0xC0;
 T1CON = 0b00110001;




 while (1) {




 current_period1 = total_period1 * 0.9;
 current_period2 = total_period2 * 0.5;
 current_period3 = total_period3 * 0.2;
 current_period4 = total_period4 * 0.9;
 } }
