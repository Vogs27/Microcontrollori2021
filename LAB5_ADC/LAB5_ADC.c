short unsigned int adc_8bit_RD0;
unsigned int adc_10bit_RA0;

//LCD module
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
    char row[16];
    char number[8];
    Lcd_Init();               // Initialize Lcd
    Lcd_Cmd(_LCD_CLEAR);      // Clear display
    Lcd_Cmd(_LCD_CURSOR_OFF); // Cursor off

    // RA0 AN0 --> 10 bit ADRESH | ADRESL --> LCD row 1 LSB_10bit = 5000 mV/1024 circa 5 mV
    ANSELA.RA0 = 1;
    TRISA.RA0 = 1;

    //RD0 AN20 --> 8 bit ADRESH --> LCD row 2 LSB_10bit = 5000 mV/256 circa 4*5=20 mV
    ANSELD.RD0 = 1;
    TRISD.RD0 = 1;
      /*
    ADCON0.CHS0=0;
    ADCON0.CHS1=0;
    ADCON0.CHS2=0;
    ADCON0.CHS3=0;
    ADCON0.CHS4=0;





    //TAD Fosc/8 = 1us
    ADCON2.ADCS2=0;
    ADCON2.ADCS1=0;
    ADCON2.ADCS0=1;



    //TACQT = 8Tad = 8us > 7.45us
    ADCON2.ACQT2=1;
    ADCON2.ACQT1=0;
    ADCON2.ACQT0=0;

    ADCON2.ADFM = 0;


    ADCON0.ADON = 1;
    */

    ADCON2 = 0b01000001;
    ADCON0 = 0b00000001;
    
    //ADCON0 = 0b00000001 AN0 RA0
    //ADCON2 = 0b11000001 //Right RA0, 10 bit 
    //ADCON0 = 0b01010001 AN20 RD0
    //ADCON2 = 0b01000001 //Left RD0, 8 bit

    PIE1.ADIE = 1;
    PIR1.ADIF = 0;
    INTCON.PEIE = 1;




    INTCON.GIE = 1;
    ADCON0.GO_NOT_DONE = 1;


    while(1){
        strcpy(row, "RA0 [mV]: ");
        IntToStr(adc_10bit_RA0*5, number);
        strcat(row, number);
        Lcd_Out(1, 1, row);
        strcpy(row, "RD0 [mV]:");
        IntToStr(adc_8bit_RD0*20, number);
        strcat(row, number);
        Lcd_Out(2, 1, row);
    }

}


void interrupt(){
    if (PIR1.ADIF)
    {
        PIR1.ADIF = 0;
        if(ADCON2.ADFM){
            adc_10bit_RA0 = ADRESH<<8|ADRESL;
            ADCON0.CHS0=0;
            ADCON0.CHS1=0;
            ADCON0.CHS2=1;
            ADCON0.CHS3=0;
            ADCON0.CHS4=1;
            //ADCON0 = 0b01010001; // next reading will be AN20 RD0
        }
        else{
            adc_8bit_RD0 = ADRESH;
            ADCON0.CHS0=0;
            ADCON0.CHS1=0;
            ADCON0.CHS2=0;
            ADCON0.CHS3=0;
            ADCON0.CHS4=0;
            //ADCON0 = 0b00000001; // next reading will be AN0 RA0
        }
        ADCON2.ADFM = !ADCON2.ADFM;
        ADCON0.GO_NOT_DONE = 1;
    }
}