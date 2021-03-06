#define N_MOTOR 5
#define M1 PORTB.RB0
#define M2 PORTA.RA7
#define M3 PORTA.RA3
#define M4 PORTA.RA4

unsigned short PWM0=0,PWM1=0,PWM2=0,PWM3=0; //Valores de las se�ales PWM
unsigned short control_PWM=0;
unsigned char control;

void interrupt(void){
  control_PWM++;                //Incremento cada rebose del timer0

   if (control_PWM==0){          //inicio del ciclo con todos los pulsos pwm a 1
      M1=1;
      M2=1;
      M3=1;
      M4=1;

   }
   //Finalizar� el pulso de modulaci�n seg�n el valor del correspondiente pwm
   if (control_PWM==PWM0) M1=0;
   if (control_PWM==PWM1) M2=0;
   if (control_PWM==PWM2) M3=0;
   if (control_PWM==PWM3) M4=0;

   TMR0= 254;                    //Carga del contador
  INTCON.TMR0IF=0;
}


void main(){
  OSCCON=0b11110000;
  ANSELA=0;
  ANSELB=0;
  TRISA=0;
  PORTA=0;
  TRISB=0;
  PORTB=0;
  TXCKSEL_bit=1;
  RXDTSEL_bit=1;
  OPTION_REG = 0x07;   // Pre-escalador (1:32) se le asigna al temporizador Timer0
  INTCON = 0xA0;       // Habilitada la generaci�n de interrupci�n para el
  TMR0 = 254;          // Temporizador T0 cuenta de 155 a 255
  UART1_Init(9600);
  TRISB2_bit = 1;     // only change if pin remap done
  TRISB5_bit = 0;     // only change if pin remap done
  Delay_ms(100);
  PWM0 = 4;
  PWM1 = 1;
  PWM2 = 1;
  PWM3 = 15 ;
  while(1){
  //UART_Write_Text("PWM+\n\r");
   control = UART1_Read();
   if(control == 'a'){
   UART_Write_Text("PWM+\n\r");
   Delay_ms(100);
   PWM0++;                    //Impulso de 0,8 msg de pwm0 posici�n 0�
   PWM1++;                      //Impulso de 0,8 msg de pwm1 posici�n 0�
   PWM2++;                      //Impulso de 0,8 msg de pwm2 posici�n 0�
   PWM3++;                      //Impulso de 0,8 msg de pwm3 posici�n 0�

   }
   if(control == 'b'){
   UART_Write_Text("PWM-\n\r");
   Delay_ms(100);
   PWM0--;                    //Impulso de 0,8 msg de pwm0 posici�n 0�
   PWM1--;                      //Impulso de 0,8 msg de pwm1 posici�n 0�
   PWM2--;                      //Impulso de 0,8 msg de pwm2 posici�n 0�
   PWM3--;                      //Impulso de 0,8 msg de pwm3 posici�n 0�

   }
  }
}