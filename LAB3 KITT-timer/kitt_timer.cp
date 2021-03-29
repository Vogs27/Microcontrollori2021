#line 1 "D:/Users/aavog/Documents/GitHub/Microcontrollori2021/LAB3 KITT-timer/kitt_timer.c"
int kitt_ms = 0;
int kitt_delay = 1000;
void main()
{
 short unsigned int dir = 1;

 T0CON = 0b11000111;
#line 21 "D:/Users/aavog/Documents/GitHub/Microcontrollori2021/LAB3 KITT-timer/kitt_timer.c"
 TRISB.RB6 = 1;
 TRISB.RB7 = 1;
 ANSELB.RB6 = 0;
 ANSELB.RB7 = 0;
 IOCB = 0b11000000;


 TRISC = 0b00000000;
 LATC = 0b00000001;


 INTCON.TMR0IE = 1;
 INTCON.TMR0IF = 0;
 INTCON.RBIE = 1;
 INTCON.RBIF = 0;
 INTCON.GIE = 1;
#line 51 "D:/Users/aavog/Documents/GitHub/Microcontrollori2021/LAB3 KITT-timer/kitt_timer.c"
 while(1){
 if(kitt_ms>=kitt_delay){

 kitt_ms = 0;


 if(dir)
 LATC <<= 1;
 else
 LATC >>= 1;
#line 71 "D:/Users/aavog/Documents/GitHub/Microcontrollori2021/LAB3 KITT-timer/kitt_timer.c"
 if(LATC == 0b00000001)
 dir = 1;
 else if(LATC == 0b10000000)
 dir = 0;




 }


 }
}

void interrupt()
{
 if (INTCON.RBIF)
 {
 if (PORTB.RB7)
 {
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
 INTCON.RBIF = 0;
 }
 else if (INTCON.TMR0IF)
 {
 INTCON.TMR0IF = 0;
 INTCON.TMR0IF = 0;

 kitt_ms += 33;




 }
}
