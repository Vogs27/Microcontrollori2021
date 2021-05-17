
_main:

;LAB6_PWM.c,1 :: 		void main() {
;LAB6_PWM.c,3 :: 		ANSELA.RA0 = 1; //RA0 analog in
	BSF         ANSELA+0, 0 
;LAB6_PWM.c,4 :: 		TRISA.RA0 = 1; //RA0 Input
	BSF         TRISA+0, 0 
;LAB6_PWM.c,5 :: 		ADCON0 = 0b00000001;
	MOVLW       1
	MOVWF       ADCON0+0 
;LAB6_PWM.c,6 :: 		ADCON2 = 0b00000001;
	MOVLW       1
	MOVWF       ADCON2+0 
;LAB6_PWM.c,9 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;LAB6_PWM.c,10 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;LAB6_PWM.c,11 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;LAB6_PWM.c,12 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;LAB6_PWM.c,13 :: 		ADCON0.GO_NOT_DONE = 1;
	BSF         ADCON0+0, 1 
;LAB6_PWM.c,20 :: 		TRISE.RE2 = 1;
	BSF         TRISE+0, 2 
;LAB6_PWM.c,22 :: 		CCPTMRS1.C5TSEL0 = 1;
	BSF         CCPTMRS1+0, 2 
;LAB6_PWM.c,23 :: 		CCPTMRS1.C5TSEL1 = 0;
	BCF         CCPTMRS1+0, 3 
;LAB6_PWM.c,25 :: 		CCP5CON.CCP5M3=1;
	BSF         CCP5CON+0, 3 
;LAB6_PWM.c,26 :: 		CCP5CON.CCP5M2=1;
	BSF         CCP5CON+0, 2 
;LAB6_PWM.c,28 :: 		CCPR5L = 0;
	CLRF        CCPR5L+0 
;LAB6_PWM.c,30 :: 		PR4 = 255;
	MOVLW       255
	MOVWF       PR4+0 
;LAB6_PWM.c,32 :: 		T4CON = 0b00000111;
	MOVLW       7
	MOVWF       T4CON+0 
;LAB6_PWM.c,34 :: 		TRISE.RE2 = 0;
	BCF         TRISE+0, 2 
;LAB6_PWM.c,35 :: 		while(1){
L_main0:
;LAB6_PWM.c,36 :: 		}
	GOTO        L_main0
;LAB6_PWM.c,39 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;LAB6_PWM.c,41 :: 		void interrupt(){
;LAB6_PWM.c,42 :: 		if (PIR1.ADIF)
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt2
;LAB6_PWM.c,44 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;LAB6_PWM.c,49 :: 		CCPR5L = ADRESH;
	MOVF        ADRESH+0, 0 
	MOVWF       CCPR5L+0 
;LAB6_PWM.c,50 :: 		ADCON0.GO_NOT_DONE = 1;
	BSF         ADCON0+0, 1 
;LAB6_PWM.c,51 :: 		}
L_interrupt2:
;LAB6_PWM.c,52 :: 		}
L_end_interrupt:
L__interrupt5:
	RETFIE      1
; end of _interrupt
