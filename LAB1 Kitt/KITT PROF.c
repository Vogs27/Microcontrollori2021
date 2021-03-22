int delayKitt = 500;

void main() {

    short int dir = 1; // 1 = DX=>SX, 0 = SX=>DX

    TRISC = 0; // Abilito buffer uscita
    LATC = 1; // 0b00000001

    ANSELB.RB6 = 0;
    ANSELB.RB7 = 0;

    IOCB = 0b11000000;

    INTCON.RBIE = 1;
    INTCON.RBIF = 0;
    INTCON.GIE = 1;

    while(1){
        VDelay_ms(delayKitt);

        if (dir)
            LATC <<= 1; // TRIC = TRISC << 1;
        else
            LATC >>= 1;

        if (LATC == 0b10000000)
            dir = 0;
        else if(LATC == 0b00000001)
            dir = 1;

    }

}



void interrupt(){ // ISR

    if(INTCON.RBIF){

        if(PORTB.RB6)
            delayKitt += 100;

        if(PORTB.RB7)
            delayKitt -= 100;

        if (delayKitt > 5000)
            delayKitt = 5000;

        if (delayKitt < 50)
            delayKitt = 50;

        INTCON.RBIF = 0;
    }

}