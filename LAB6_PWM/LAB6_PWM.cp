#line 1 "D:/Users/aavog/Documents/GitHub/Microcontrollori2021/LAB6_PWM/LAB6_PWM.c"
void main() {

 ANSELA.RA0 = 1;
 TRISA.RA0 = 1;
 ADCON0 = 0b00000001;
 ADCON2 = 0b00000001;


 PIE1.ADIE = 1;
 PIR1.ADIF = 0;
 INTCON.PEIE = 1;
 INTCON.GIE = 1;
 ADCON0.GO_NOT_DONE = 1;






 TRISE.RE2 = 1;

 CCPTMRS1.C5TSEL0 = 1;
 CCPTMRS1.C5TSEL1 = 0;

 CCP5CON.CCP5M3=1;
 CCP5CON.CCP5M2=1;

 CCPR5L = 0;

 PR4 = 255;

 T4CON = 0b00000111;

 TRISE.RE2 = 0;
 while(1){
 }


}

void interrupt(){
 if (PIR1.ADIF)
 {
 PIR1.ADIF = 0;
#line 49 "D:/Users/aavog/Documents/GitHub/Microcontrollori2021/LAB6_PWM/LAB6_PWM.c"
 CCPR5L = ADRESH;
 ADCON0.GO_NOT_DONE = 1;
 }
}
