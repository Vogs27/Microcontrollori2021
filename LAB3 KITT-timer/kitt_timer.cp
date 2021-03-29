#line 1 "D:/Users/aavog/Documents/GitHub/Microcontrollori2021/LAB3 KITT-timer/kitt_timer.c"
int delayLED = 500;
void main() {
 short int i = 0;
 TRISB.RB6 = 1;
 TRISB.RB7 = 1;
 ANSELB.RB6 = 0;
 ANSELB.RB7 = 0;
 IOCB = 0b11000000;
 INTCON = 0b10001000;
 TRISC = 0b00000000;
 LATC = 0b00000001;
 VDelay_ms(delayLED);

 while(1){
 for(i=1; i<=7; i++){
 LATC = LATC<<1;
 VDelay_ms(delayLED);
 }
 for(i=7; i>0; i--){
 LATC = LATC>>1;
 VDelay_ms(delayLED);
 }
 }
}

void interrupt(){
 if(INTCON.RBIF){
 if(PORTB.RB7){
 if(delayLED<5000){
 delayLED += 50;
 }
 }
 if(PORTB.RB6){
 if(delayLED>50){
 delayLED -= 50;
 }
 }
 }
 INTCON.RBIF = 0;
}
