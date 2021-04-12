int kitt_ms = 0;
int kitt_delay = 1000;
void main()
{
    short unsigned int dir = 1; //usato in while 1
    //Timer conf
    T0CON = 0b11000111;
    //TMR0L = 6;
    /*
    T0CON.TMR0ON = 1;
    T0CON.T08BIT = 1;
    T0CON.T0CS = 0;
    T0CON.T0SE = 0;
    T0CON.PSA = 0;
    T0CON.T0PS2 = 1;
    T0CON.T0PS1 = 1;
    T0CON.T0PS0 = 1;
    */

    //PORT B conf
    TRISB.RB6 = 1;  //RB6 input
    TRISB.RB7 = 1;  //RB7 input
    ANSELB.RB6 = 0; //RB6 digital input
    ANSELB.RB7 = 0; //RB7 digital inpunt
    IOCB = 0b11000000;

    //PORT C conf
    TRISC = 0b00000000; //all port as output
    LATC = 0b00000001;  //RC0 high

    //INTERRUPT conf
    INTCON.TMR0IE = 1;
    INTCON.TMR0IF = 0;
    INTCON.RBIE = 1;
    INTCON.RBIF = 0;
    INTCON.GIE = 1;

    /*while (1)
    {
        for (i = 1; i <= 7; i++)
        {
            LATC = LATC << 1;
            VDelay_ms(delayLED);
        }
        for (i = 7; i > 0; i--)
        {
            LATC = LATC >> 1;
            VDelay_ms(delayLED);
        }
    }*/
     while(1){
        if(kitt_ms>=kitt_delay){

            kitt_ms = 0;
            //kitt_ms -= kitt_delay;

            if(dir)
                LATC <<= 1;
            else
                LATC >>= 1;

            /*
            NOTE LAT vs PORT
            here it is a case where using LAT can be different than using PORT,
            PORT == 0bxxxxxxxx can get different result compared to
            LATC == 0bxxxxxxxx because the time needed to the buffer for
            rising up or down the output voltage level can be bigger than
            rising up the time needed for reach the instruction "if".
            */

            if(LATC == 0b00000001)
                dir = 1;
            else if(LATC == 0b10000000)
                dir = 0;
        }
    }
}

void interrupt()
{ // ISR
    if (INTCON.RBIF)
    { //Se la flag di interrupt su porta b è alta
        if (PORTB.RB7)
        { //se l'interrupt è su RB7
            if (kitt_delay < 5000)
            {
                kitt_delay += 50;
            }
        }
        if (PORTB.RB6)
        {
            if (kitt_delay > 50)
            {
                kitt_delay -= 50;
            }
        }
        INTCON.RBIF = 0; //pulisco l'interrupt flag
    }
    else if (INTCON.TMR0IF)
    { //se la flag di interrupt per timer0 è alta
        INTCON.TMR0IF = 0;
        INTCON.TMR0IF = 0;
        //TMR0L = 6;
        kitt_ms += 33;
        
        // kitt_ms += 33;   //+32.7 PLL OFF 8MHz = Fosc
        //kitt_ms += 8;   //+8.192 PLL ON 32MHz = Fosc

    }
}