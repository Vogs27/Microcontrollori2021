unsigned int counter_ms = 0;
unsigned int counter_kitt = 0;
volatile int timer_go = 1;

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

void main()
{
    char pattern[5] = {0b11111111, 0b01111110, 0b00111100, 0b00011000, 0b00000000};
    char dir = 1;
    char cycle = 0;
    char counter_sec = 0;
    char counter_min = 0;
    int counter_hours = 0;
    unsigned int old_counter_ms = 0;
    char output_string[17];
    char output_num[10];
    char zeroes[] = "0:00:00:000";
    int PORTA_Old = 0;
    int kitt_delay = 500;
    T0CON = 0b11000111;
    TMR0L = 248;
    TRISD = 0b00000000;
    TRISA = 0b00011111;
    ANSELA = 0b00000000;
    //Interrupt
    INTCON.TMR0IE = 1;
    INTCON.GIE = 1;
    PORTA_Old = PORTA;
    Lcd_Init();               // Initialize Lcd
    Lcd_Cmd(_LCD_CLEAR);      // Clear display
    Lcd_Cmd(_LCD_CURSOR_OFF); // Cursor off

    while (1)
    {
        //PORTA SECTION
        if (!((PORTA_Old & 0b00011111) & (PORTA & 0b00011111)) && (PORTA & 0b00011111) != 0)
        {
            PORTA_Old = PORTA;
            if (PORTA.RA0)
            {
                timer_go = 1;
            }
            else if (PORTA.RA1)
            {
                timer_go = 0;
            }
            else if (PORTA.RA2)
            {
                counter_sec = 0;
                counter_min = 0;
                counter_hours = 0;
                Lcd_Cmd(_LCD_CLEAR);
                Lcd_Cmd(_LCD_CURSOR_OFF);
                Lcd_Out(1, 16-strlen(zeroes), zeroes);
            }
            else if (PORTA.RA3)
            {
                if (kitt_delay < 2000)
                {
                    kitt_delay = kitt_delay + 300;
                }
            }
            else if (PORTA.RA4)
            {
                if (kitt_delay > 500)
                {
                    kitt_delay = kitt_delay - 300;
                }
            }
        }
        //KIT SECTION
        if (counter_kitt > kitt_delay)
        {
            counter_kitt = 0;
            LATD = pattern[cycle];
            if (cycle == 4)
            {
                dir = 0;
            }
            if (cycle == 0)
            {
                dir = 1;
            }
            if (dir == 1)
            {
                cycle++;
            }
            else
            {
                cycle--;
            }
        }
        //COUNTER AND DISPLAY SECTION
        if (counter_ms != old_counter_ms)
        {
            if (counter_ms > 1000)
            {
                counter_sec++;
                counter_ms = 0;
                if (counter_sec > 60)
                {
                    counter_min++;
                    counter_sec = 0;
                    if (counter_min > 60)
                    {
                        counter_hours++;
                        counter_min = 0;
                    }
                }
            }
            //Lcd_Cmd(_LCD_CLEAR);
            //Lcd_Cmd(_LCD_CURSOR_OFF);
            //xx:xx:xx:xxx
            output_string[0] = '\0'; //clean the ouput string
            IntToStr(counter_hours, output_num);
            strcat(output_string, output_num+3);
            strcat(output_string,":");
            IntToStr(counter_min, output_num);
            if (counter_min < 10)
            {
                strcat(output_string, "0");
                strcat(output_string, output_num+5);
            }
            else{
            strcat(output_string, output_num+4);
            }
            strcat(output_string, ":");
            IntToStr(counter_sec, output_num);
            if (counter_sec < 10)
            {
                strcat(output_string, "0");
                strcat(output_string, output_num+5);
            }else{
            strcat(output_string, output_num+4);
            }
            strcat(output_string,":");
            IntToStr(counter_ms, output_num);
            if (counter_ms < 10)
            {
                strcat(output_string, "00");
                strcat(output_string, output_num+5);
            }
            else if (counter_ms < 100)
            {
                strcat(output_string, "0");
                strcat(output_string, output_num+4);
            }else{
            strcat(output_string, output_num+3);
            }
            Lcd_Out(1, 16-strlen(output_string), output_string);
            old_counter_ms = counter_ms;
        }
    }
}

void interrupt()
{
    if (INTCON.TMR0IF)
    {
        INTCON.TMR0IF = 0;
        TMR0L = 248;
        if (timer_go == 1)
        {
            counter_ms++;
        }
        counter_kitt++;
    }
}
