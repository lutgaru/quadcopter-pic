#line 1 "C:/Users/NEFT/Documents/GitHub/quadcopter-pic/pwm4m/pwm4m.c"






unsigned short PWM0=0,PWM1=0,PWM2=0,PWM3=0;
unsigned short control_PWM=0;

void interrupt(void){
 control_PWM++;

 if (control_PWM==0){
  PORTB.RB0 =1;
  PORTA.RA7 =1;
  PORTA.RA3 =1;
  PORTA.RA4 =1;

 }

 if (control_PWM==PWM0)  PORTB.RB0 =0;
 if (control_PWM==PWM1)  PORTA.RA7 =0;
 if (control_PWM==PWM2)  PORTA.RA3 =0;
 if (control_PWM==PWM3)  PORTA.RA4 =0;

 TMR0= 254;
 INTCON.TMR0IF=0;
}


void main(){
 ANSELA=0;
 ANSELB=0;
 TRISA=0;
 PORTA=0;
 TRISB=0;
 PORTB=0;
 OPTION_REG = 0x07;
 INTCON = 0xA0;
 TMR0 = 254;
 while(1){

 pwm0=200;
 pwm1=100;
 pwm2=50;
 pwm3=25;

 }
}
