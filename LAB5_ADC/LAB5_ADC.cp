#line 1 "D:/Users/aavog/Documents/GitHub/Microcontrollori2021/LAB5_ADC/LAB5_ADC.c"
short unsigned int adc_8bit_RD0;
unsigned int adc_10bit_RA0;
short unsigned int flag = 0;


sbit LCD_RS at LATB4_bit;
sbit LCD_EN at LATB5_bit;
sbit LCD_D4 at LATB0_bit;
sbit LCD_D5 at LATB1_bit;
sbit LCD_D6 at LATB2_bit;
sbit LCD_D7 at LATB3_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;


void main() {
 char row[17];
 char number[8];
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);


 ANSELA.RA0 = 1;
 TRISA.RA0 = 1;


 ANSELD.RD0 = 1;
 TRISD.RD0 = 1;
#line 57 "D:/Users/aavog/Documents/GitHub/Microcontrollori2021/LAB5_ADC/LAB5_ADC.c"
 ADCON2 = 0b01000001;
 ADCON0 = 0b00000001;






 PIE1.ADIE = 1;
 PIR1.ADIF = 0;
 INTCON.PEIE = 1;




 INTCON.GIE = 1;
 ADCON0.GO_NOT_DONE = 1;


 while(1){
 if(flag==1){
 strcpy(row, "RA0 [mV]: ");
 IntToStr(adc_10bit_RA0*5, number);
 flag=0;
 strcat(row, number);
 Lcd_Out(1, 1, row);
 ADCON0.CHS0=0;
 ADCON0.CHS1=0;
 ADCON0.CHS2=1;
 ADCON0.CHS3=0;
 ADCON0.CHS4=1;
 ADCON2.ADFM=0;

 ADCON0.GO_NOT_DONE = 1;
 }
 if(flag==2){
 strcpy(row, "RD0 [mV]:");
 IntToStr(adc_8bit_RD0*20, number);
 flag=0;
 strcat(row, number);
 Lcd_Out(2, 1, row);
 ADCON0.CHS0=0;
 ADCON0.CHS1=0;
 ADCON0.CHS2=0;
 ADCON0.CHS3=0;
 ADCON0.CHS4=0;
 ADCON2.ADFM=1;

 ADCON0.GO_NOT_DONE = 1;
 }
 }

}


void interrupt(){
 if (PIR1.ADIF)
 {
 PIR1.ADIF = 0;
 if(ADCON2.ADFM==1){
 adc_10bit_RA0 = ADRESH<<8|ADRESL;
 flag=1;
#line 126 "D:/Users/aavog/Documents/GitHub/Microcontrollori2021/LAB5_ADC/LAB5_ADC.c"
 }
 else{
 adc_8bit_RD0 = ADRESH;
 flag=2;
#line 138 "D:/Users/aavog/Documents/GitHub/Microcontrollori2021/LAB5_ADC/LAB5_ADC.c"
 }


 }
}
