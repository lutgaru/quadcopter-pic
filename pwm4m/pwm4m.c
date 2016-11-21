#define TMR1PRESCALE 8                     // timer1 prescaler is 8.
#define M1 PORTB.RB0                            // use the name OUT for RC2 pin.
#define M2 PORTA.RA7
#define M3 PORTA.RA3
#define M4 PORTA.RA4



// variables and constants declarations
unsigned long CCPR = 0;                    // holds the value needed to be put in CCP's registers.
unsigned long current_period1 = 0,current_period2 = 0,current_period3 = 0,current_period4 = 0;          // holds the period that timer1 will use.
const unsigned long total_period1 = 12500,total_period2 = 12500,total_period3 = 12500,total_period4 = 12500;  // 20ms for 50hz frequency.


// interrupt service routine
void interrupt() {
   if (PIR1.CCP1IF == 1) {                           // if CCP compare interrupt flag is set


       if ((current_period1 > 0) && (current_period1 < total_period1)){ // if duty is > 0% AND < 100% then:

           if (M1 == 1) {                           // if the output was 1 -> was "on-time".
           M1 = 0;                                  // set output to 0 in order to achieve "off-time".
           CCPR = total_period1 - current_period1;     // make it time for "off-time", off-time = full time - on time.
           }

          else {                                    // if the output was 0 -> was "off-time".
             M1 = 1;                               // set output to 1 in order to achieve "on-time"
             CCPR = current_period1;                 // make it time for "on-time".
          }
       }
       else {
           if (current_period1 == total_period1) { M1 = 1;}             // if duty = 100%, then output 1 all the time.
           if (current_period1 == 0)            {M1 = 0;}              // if duty = 0%, then output 0 all the time.
       }
       if ((current_period2 > 0) && (current_period2 < total_period2)){ // if duty is > 0% AND < 100% then:

           if (M2 == 1) {                           // if the output was 1 -> was "on-time".
           M2 = 0;                                  // set output to 0 in order to achieve "off-time".
           CCPR = total_period2 - current_period2;     // make it time for "off-time", off-time = full time - on time.
           }

          else {                                    // if the output was 0 -> was "off-time".
             M2 = 1;                               // set output to 1 in order to achieve "on-time"
             CCPR = current_period2;                 // make it time for "on-time".
          }
       }
       else {
           if (current_period2 == total_period2) { M2 = 1;}             // if duty = 100%, then output 1 all the time.
           if (current_period2 == 0)            {M2 = 0;}              // if duty = 0%, then output 0 all the time.
       }
       if ((current_period3 > 0) && (current_period3 < total_period3)){ // if duty is > 0% AND < 100% then:

           if (M3 == 1) {                           // if the output was 1 -> was "on-time".
           M3 = 0;                                  // set output to 0 in order to achieve "off-time".
           CCPR = total_period3 - current_period3;     // make it time for "off-time", off-time = full time - on time.
           }

          else {                                    // if the output was 0 -> was "off-time".
             M3 = 1;                               // set output to 1 in order to achieve "on-time"
             CCPR = current_period3;                 // make it time for "on-time".
          }
       }
       else {
           if (current_period3 == total_period3) { M3 = 1;}             // if duty = 100%, then output 1 all the time.
           if (current_period3 == 0)            {M3 = 0;}              // if duty = 0%, then output 0 all the time.
       }
       if ((current_period4 > 0) && (current_period4 < total_period4)){ // if duty is > 0% AND < 100% then:

           if (M4 == 1) {                           // if the output was 1 -> was "on-time".
           M4 = 0;                                  // set output to 0 in order to achieve "off-time".
           CCPR = total_period4 - current_period4;     // make it time for "off-time", off-time = full time - on time.
           }

          else {                                    // if the output was 0 -> was "off-time".
             M4 = 1;                               // set output to 1 in order to achieve "on-time"
             CCPR = current_period4;                 // make it time for "on-time".
          }
       }
       else {
           if (current_period4 == total_period4) { M4 = 1;}             // if duty = 100%, then output 1 all the time.
           if (current_period4 == 0)            {M4 = 0;}              // if duty = 0%, then output 0 all the time.
       }


      // now set the value of CCPR into CCP module's registers:

      CCPR1H = CCPR >> 8;                       // right-shift CCPR by 8 then load it into CCPR1H register (load higher byte).
      CCPR1L = CCPR;                            // put the lower byte of CCPR in CCPR1L register.
      PIR1.CCP1IF = 0;                               // reset CCP1 interrupt flag.
   }

}


// main function:
void main() {

   ANSELA = 0;
   ANSELB = 0;
   TRISA = 0;                 // port c is output.
   TRISB = 0;
   PORTA = 0;
   PORTB = 0;                 // port c = 0.

   T1CON = 0b00110000;        // timer1 uses prescaler value of 8 and it is off.
   TMR1H = 0;                 // timer1 registers have 0 (clear).
   TMR1L = 0;

   CCP1CON = 0x0b;            // set CCP module to compare mode and trigger special event when interrupt happens.
   CCP2CON = 0x0b;            // set CCP module to compare mode and trigger special event when interrupt happens.
   CCP3CON = 0x0b;            // set CCP module to compare mode and trigger special event when interrupt happens.
   CCP4CON = 0x0b;            // set CCP module to compare mode and trigger special event when interrupt happens.
   CCPR = 0;                  // load 0 in CCPR.
   PIR1.CCP1IF = 0;                // clear CCP1 interrupt flag.
   PIR2.CCP2IF = 0;                // clear CCP1 interrupt flag.
   PIR3.CCP3IF = 0;                // clear CCP1 interrupt flag.
   PIR3.CCP4IF = 0;                // clear CCP1 interrupt flag.
   PIE1.CCP1IE = 1;                // enable CCP1 interrupt.
   PIE2.CCP2IE = 1;                // enable CCP1 interrupt.
   PIE3.CCP3IE = 1;                // enable CCP1 interrupt.
   PIE3.CCP4IE = 1;                // enable CCP1 interrupt.
   INTCON = 0xC0;             // enable global and peripheral interrupt.
   T1CON = 0b00110001;        // start timer1 with the same settings like before.




   while (1) {                                          // infinite loop.


       // TEST CODE...

       current_period1 = total_period1 * 0.9;            // 50% duty cycle.
       current_period2 = total_period2 * 0.5;            // 50% duty cycle.
       current_period3 = total_period3 * 0.2;            // 50% duty cycle.
       current_period4 = total_period4 * 0.9;            // 50% duty cycle.
   }                                           }