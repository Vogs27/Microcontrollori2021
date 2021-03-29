int delayLED = 500;
void main() {
    short int i = 0; //usato in while 1
    TRISB.RB6 = 1; //RB6 input
    TRISB.RB7 = 1; //RB7 input
    ANSELB.RB6 = 0; //RB6 digital input
    ANSELB.RB7 = 0; //RB7 digital inpunt
    IOCB = 0b11000000;
    INTCON = 0b10001000; //interrupt conf
    TRISC = 0b00000000; //all port as output
    LATC = 0b00000001; //RC0 high
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

void interrupt(){ // ISR
    if(INTCON.RBIF){ //Se la flag di interrupt su porta b è alta
        if(PORTB.RB7){ //se l'interrupt è su RB7
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
    INTCON.RBIF = 0; //pulisco l'interrupt flag
}