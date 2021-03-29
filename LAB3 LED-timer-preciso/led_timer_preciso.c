unsigned int led_ms = 0;

void main() {


    TRISC.RC0 = 0;
    LATC.RC0 = 1;

    TRISC.RC7 = 0;
    LATC.RC7 = 1;

    T0CON = 0b11000111;
    TMR0L = 0b10001011;
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

   INTCON.TMR0IE = 1;
   INTCON.TMR0IF = 0;
   



    // Others ph ....



    INTCON.GIE = 1;

    while(1){

        // Come faccio a farlo più preciso?
        /*Delay_ms(300);
        LATC.RC0 = !LATC.RC0;*/

        if(led_ms>=300){
            led_ms = 0;
            LATC.RC0 = !LATC.RC0;
        }


    }

}


void interrupt(){


    if(INTCON.TMR0IF){
        INTCON.TMR0IF = 0;
        led_ms += 15;


    }
    // Come gest una ISR con N interrupt?



}