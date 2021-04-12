#line 1 "D:/Users/aavog/Documents/GitHub/Microcontrollori2021/LAB4_Step0/LAB4_Step0.c"
unsigned int counter_ms = 0;
unsigned int counter_sec = 0;
char pattern[5]={0b11111111, 0b01111110, 0b00111100, 0b00011000, 0b00000000};
int dir = 1;
short cycle = 0;
void main() {
 T0CON = 0b11000111;
 TMR0L = 248;
 TRISD = 0b00000000;



 INTCON.TMR0IE = 1;
 INTCON.GIE = 1;

 while(1){
 LATD = pattern[cycle];
 if (cycle == 4)
 dir = -1;
 if (cycle == 0)
 dir = 1;
 }
}

void interrupt(){
 if(INTCON.TMR0IF){
 INTCON.TMR0IF=0;
 TMR0L = 248;
 counter_ms++;
 if(counter_ms>=1000){
 counter_sec++;
 counter_ms=0;
 if (dir == 1){
 cycle ++;
 }
 else {
 cycle --;
 }
 }
 }
}
