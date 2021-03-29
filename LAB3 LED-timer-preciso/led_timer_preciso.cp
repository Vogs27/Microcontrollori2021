#line 1 "D:/Users/aavog/Documents/GitHub/Microcontrollori2021/LAB3 LED-timer-preciso/led_timer_preciso.c"
unsigned int led_ms = 0;

void main() {


 TRISC.RC0 = 0;
 LATC.RC0 = 1;

 TRISC.RC7 = 0;
 LATC.RC7 = 1;

 T0CON = 0b11000111;
 TMR0L = 0b10001011;
#line 25 "D:/Users/aavog/Documents/GitHub/Microcontrollori2021/LAB3 LED-timer-preciso/led_timer_preciso.c"
 INTCON.TMR0IE = 1;
 INTCON.TMR0IF = 0;








 INTCON.GIE = 1;

 while(1){
#line 43 "D:/Users/aavog/Documents/GitHub/Microcontrollori2021/LAB3 LED-timer-preciso/led_timer_preciso.c"
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




}
