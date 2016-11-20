#include <GY85.h>
#define  MOT1 RB0_bit
#define  MOT2 RA7_bit
#define  MOT3 RA3_bit
#define  MOT4 RA4_bit
unsigned long CCPR = 0;                    // holds the value needed to be put in CCP's registers.
unsigned long current_period = 0,current_period2 = 0,current_period3 = 0,current_period4 = 0;          // holds the period that timer1 will use.
const unsigned long total_period = 12500,total_period2 = 12500,total_period3 = 12500,total_period4 = 12500;  // 20ms for 50hz frequency.

void init(){
     //OSCCON=0b01111010;
     CM1CON0 = 0;
     CM2CON0 = 0;
     TRISA = 0x19;
     TRISB = 0x02;
     PORTB = 0x00;
     PORTA = 0x00;
     T1CON = 0b00110000;        // timer1 uses prescaler value of 8 and it is off.
     TMR1H = 0;                 // timer1 registers have 0 (clear).
     TMR1L = 0;
     CCP1CON = 0x0B;            // set CCP module to compare mode and trigger special event when interrupt happens.
     CCPR = 0;                  // load 0 in CCPR.
     PIR1.CCP1IF = 0;                // clear CCP1 interrupt flag.
     PIE1.CCP1IE = 1;                // enable CCP1 interrupt.
     INTCON = 0xC0;             // enable global and peripheral interrupt.
     T1CON = 0b00110101;        // start timer1 with the same settings like before.
     ANSELA= 0x00;
     ANSELB= 0x00;
     TXCKSEL_bit=1;
     RXDTSEL_bit=1;
     UART1_Init(9600);
}
   void interrupt() {
   if (PIR1.CCP1IF == 1) {                           // if CCP compare interrupt flag is set


       if ((current_period > 0) && (current_period < total_period)){ // if duty is > 0% AND < 100% then:

           if (MOT1 == 1) {                           // if the MOT1put was 1 -> was "on-time".
           MOT1 = 0;
           MOT2 = 0;                                  // set MOT1put to 0 in order to achieve "off-time".
           CCPR = total_period - current_period;     // make it time for "off-time", off-time = full time - on time.
           }

      else {                                    // if the MOT1put was 0 -> was "off-time".
         MOT1 = 1;                               // set MOT1put to 1 in order to achieve "on-time"
         MOT2 = 1;
         CCPR = current_period;                 // make it time for "on-time".
      }
       }
       else {
           if (current_period == total_period) { MOT1 = 1;MOT2 = 1;}             // if duty = 100%, then MOT1put 1 all the time.
           if (current_period == 0)            {MOT1 = 0;MOT2 = 0;}              // if duty = 0%, then MOT1put 0 all the time.
       }


      // now set the value of CCPR into CCP module's registers:

      CCPR1H = CCPR >> 8;                       // right-shift CCPR by 8 then load it into CCPR1H register (load higher byte).
      CCPR1L = CCPR;                            // put the lower byte of CCPR in CCPR1L register.
      PIR1.CCP1IF = 0;                               // reset CCP1 interrupt flag.
   }
   }



void main() {
     init();
     while(1){
     current_period = total_period * 0.5;            // 50% duty cycle.
     }



}