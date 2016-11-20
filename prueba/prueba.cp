#line 1 "C:/Users/NEFT/Documents/GitHub/quadcopter-pic/prueba/prueba.c"







unsigned long CCPR = 0;
unsigned long current_period = 0;
const unsigned long total_period = 12500;



void interrupt() {
 if (PIR1.CCP1IF == 1) {


 if ((current_period > 0) && (current_period < total_period)){

 if ( RB2_bit  == 1) {
  RB2_bit  = 0;
 CCPR = total_period - current_period;
 }

 else {
  RB2_bit  = 1;
 CCPR = current_period;
 }
 }
 else {
 if (current_period == total_period) {  RB2_bit  = 1;}
 if (current_period == 0) { RB2_bit  = 0;}
 }




 CCPR1H = CCPR >> 8;
 CCPR1L = CCPR;
 PIR1.CCP1IF = 0;
 }
}



void main() {


 TRISB = 0;
 PORTB = 0;

 T1CON = 0b00110000;
 TMR1H = 0;
 TMR1L = 0;

 CCP1CON = 0x0b;
 CCPR = 0;
 PIR1.CCP1IF = 0;
 PIE1.CCP1IE = 1;
 INTCON = 0xC0;
 T1CON = 0b00110001;




 while (1) {




 current_period = total_period * 0.5;
 delay_ms(2000);
 current_period = total_period * 0.1;
 delay_ms(2000);
 current_period = total_period * 1;
 delay_ms(2000);
 current_period = total_period * 0;
 delay_ms(2000);
 }
 }
