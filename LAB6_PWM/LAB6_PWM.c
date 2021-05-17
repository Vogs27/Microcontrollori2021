void main() {
    //Configurazione ingresso adc
    ANSELA.RA0 = 1; //RA0 analog in
    TRISA.RA0 = 1; //RA0 Input
    ADCON0 = 0b00000001;
    ADCON2 = 0b00000001;

    // Interrupt
    PIE1.ADIE = 1;
    PIR1.ADIF = 0;
    INTCON.PEIE = 1;
    INTCON.GIE = 1;
            ADCON0.GO_NOT_DONE = 1;

    // AN0 ADC ad 8 bit  V
    // RE2 PWM a 8 bit dove Ton è V letta su AN0
    // CCP5 con TMR4
    // ADC con interrupt
// - Disable CCP Out -
    TRISE.RE2 = 1;
// --- TMR4 - CCP5 ---
    CCPTMRS1.C5TSEL0 = 1;
    CCPTMRS1.C5TSEL1 = 0;
// CCP5 as PWM
    CCP5CON.CCP5M3=1;
    CCP5CON.CCP5M2=1;
// Starting value
    CCPR5L = 0;
// PR
    PR4 = 255;
// TMR4
    T4CON = 0b00000111;
// - Enable CCP Out -
    TRISE.RE2 = 0;
    while(1){
    }


}

void interrupt(){
    if (PIR1.ADIF)
    {
        PIR1.ADIF = 0;
        /*
        LETTURA E CODICE CCP
        CCPR5L = ADRESH;
        */
        CCPR5L = ADRESH;
        ADCON0.GO_NOT_DONE = 1;
    }
}