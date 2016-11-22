#define N_MOTOR 5
#define M1 PORTB.RB0
#define M2 PORTA.RA7
#define M3 PORTA.RA3
#define M4 PORTA.RA4

unsigned short PWM0=0,PWM1=0,PWM2=0,PWM3=0; //Valores de las señales PWM
unsigned short control_PWM=0;

void interrupt(void){
  control_PWM++;                //Incremento cada rebose del timer0

   if (control_PWM==0){          //inicio del ciclo con todos los pulsos pwm a 1
      M1=1;
      M2=1;
      M3=1;
      M4=1;

   }
   //Finalizará el pulso de modulación según el valor del correspondiente pwm
   if (control_PWM==PWM0) M1=0;
   if (control_PWM==PWM1) M2=0;
   if (control_PWM==PWM2) M3=0;
   if (control_PWM==PWM3) M4=0;

   TMR0= 254;                    //Carga del contador
  INTCON.TMR0IF=0;
}


void main(){
  ANSELA=0;
  ANSELB=0;
  TRISA=0;
  PORTA=0;
  TRISB=0;
  PORTB=0;
  OPTION_REG = 0x07;   // Pre-escalador (1:32) se le asigna al temporizador Timer0
  INTCON = 0xA0;       // Habilitada la generación de interrupción para el
  TMR0 = 254;          // Temporizador T0 cuenta de 155 a 255
  while(1){

   pwm0=200;                      //Impulso de 0,8 msg de pwm0 posición 0º
   pwm1=100;                      //Impulso de 0,8 msg de pwm1 posición 0º
   pwm2=50;                      //Impulso de 0,8 msg de pwm2 posición 0º
   pwm3=25;                      //Impulso de 0,8 msg de pwm3 posición 0º

  }
}