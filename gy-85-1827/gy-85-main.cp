#line 1 "C:/Users/NEFT/Desktop/gy-85-1827/gy-85-main.c"
#line 1 "c:/users/neft/desktop/gy-85-1827/gy85.h"


 unsigned short Read_Byte(unsigned short address_sensor,unsigned short register_address);
 void Acc_Init();
 void Acc_Read();
 void Magneto_Init();
 void Magneto_Read();
 void Gyro_Init();
 void Gyro_Read();
#line 15 "C:/Users/NEFT/Desktop/gy-85-1827/gy-85-main.c"
volatile int accel[3];
volatile int magnetom[3];
volatile int gyro[3];

 void UART1_Printf(int value){
 char txt[7];
 IntToStr(value, txt);
 UART1_Write_Text(txt);
 }

void printf_result(){
UART1_Write_Text("X_acc:");UART1_Printf(accel[0]); UART1_Write_Text("  ");
UART1_Write_Text("Y_acc:");UART1_Printf(accel[1]); UART1_Write_Text("  ");
UART1_Write_Text("Z_acc:");UART1_Printf(accel[2]); UART1_Write_Text("  ");
UART1_Write_Text("\r\n");

UART1_Write_Text("X_mag:");UART1_Printf(magnetom[0]); UART1_Write_Text("  ");
UART1_Write_Text("Y_mag:");UART1_Printf(magnetom[1]); UART1_Write_Text("  ");
UART1_Write_Text("Z_mag:");UART1_Printf(magnetom[2]); UART1_Write_Text("  ");
UART1_Write_Text("\r\n");

UART1_Write_Text("X_gyro:");UART1_Printf(gyro[0]); UART1_Write_Text("  ");
UART1_Write_Text("Y_gyro:");UART1_Printf(gyro[1]); UART1_Write_Text("  ");
UART1_Write_Text("Z_gyro:");UART1_Printf(gyro[2]); UART1_Write_Text("  ");
UART1_Write_Text("\r\n");
 }

void GY_85_Init(){
Acc_Init();
Magneto_Init();
Gyro_Init();
 }

void GY_85_Read(){
Acc_Read();
Magneto_Read();
Gyro_Read();
 }

void main() {
 OSCCON=0b01101010;
 ANSELA=0x00;
 ANSELB=0x00;
 TRISB=0;
 TXCKSEL_bit=1;
 RXDTSEL_bit=1;
 UART1_Init(9600);
 TRISB2_bit = 1;
 TRISB5_bit = 0;
 Delay_ms(100);
 UART1_Write_Text("GY-85 Start\r\n");
 I2C1_Init(100000);
 Delay_ms(100);
 GY_85_Init();
 Delay_ms(100);
 do{
 GY_85_Read();
 printf_result();
 Delay_ms(1000);
 }while(1);
 }
