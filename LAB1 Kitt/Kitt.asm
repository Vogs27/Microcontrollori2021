
_main:

;Kitt.c,2 :: 		void main() {
;Kitt.c,3 :: 		short int i = 0; //usato in while 1
	CLRF        main_i_L0+0 
;Kitt.c,4 :: 		TRISB.RB6 = 1; //RB6 input
	BSF         TRISB+0, 6 
;Kitt.c,5 :: 		TRISB.RB7 = 1; //RB7 input
	BSF         TRISB+0, 7 
;Kitt.c,6 :: 		ANSELB.RB6 = 0; //RB6 digital input
	BCF         ANSELB+0, 6 
;Kitt.c,7 :: 		ANSELB.RB7 = 0; //RB7 digital inpunt
	BCF         ANSELB+0, 7 
;Kitt.c,8 :: 		INTCON = 0b10001000; //interrupt conf
	MOVLW       136
	MOVWF       INTCON+0 
;Kitt.c,9 :: 		TRISC = 0b00000000; //all port as output
	CLRF        TRISC+0 
;Kitt.c,10 :: 		LATC = 0b00000001; //RC0 high
	MOVLW       1
	MOVWF       LATC+0 
;Kitt.c,11 :: 		VDelay_ms(delayLED);
	MOVF        _delayLED+0, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+0 
	MOVF        _delayLED+1, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+1 
	CALL        _VDelay_ms+0, 0
;Kitt.c,13 :: 		while(1){
L_main0:
;Kitt.c,14 :: 		for(i=1; i<=7; i++){
	MOVLW       1
	MOVWF       main_i_L0+0 
L_main2:
	MOVLW       128
	XORLW       7
	MOVWF       R0 
	MOVLW       128
	XORWF       main_i_L0+0, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main3
;Kitt.c,15 :: 		LATC = LATC<<1;
	MOVF        LATC+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       LATC+0 
;Kitt.c,16 :: 		VDelay_ms(delayLED);
	MOVF        _delayLED+0, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+0 
	MOVF        _delayLED+1, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+1 
	CALL        _VDelay_ms+0, 0
;Kitt.c,14 :: 		for(i=1; i<=7; i++){
	INCF        main_i_L0+0, 1 
;Kitt.c,17 :: 		}
	GOTO        L_main2
L_main3:
;Kitt.c,18 :: 		for(i=7; i>0; i--){
	MOVLW       7
	MOVWF       main_i_L0+0 
L_main5:
	MOVLW       128
	XORLW       0
	MOVWF       R0 
	MOVLW       128
	XORWF       main_i_L0+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main6
;Kitt.c,19 :: 		LATC = LATC>>1;
	MOVF        LATC+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVF        R0, 0 
	MOVWF       LATC+0 
;Kitt.c,20 :: 		VDelay_ms(delayLED);
	MOVF        _delayLED+0, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+0 
	MOVF        _delayLED+1, 0 
	MOVWF       FARG_VDelay_ms_Time_ms+1 
	CALL        _VDelay_ms+0, 0
;Kitt.c,18 :: 		for(i=7; i>0; i--){
	DECF        main_i_L0+0, 1 
;Kitt.c,21 :: 		}
	GOTO        L_main5
L_main6:
;Kitt.c,22 :: 		}
	GOTO        L_main0
;Kitt.c,23 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;Kitt.c,25 :: 		void interrupt(){ // ISR
;Kitt.c,26 :: 		if(INTCON.RBIF){ //Se la flag di interrupt su porta b è alta
	BTFSS       INTCON+0, 0 
	GOTO        L_interrupt8
;Kitt.c,27 :: 		if(PORTB.RB7){ //se l'interrupt è su RB7
	BTFSS       PORTB+0, 7 
	GOTO        L_interrupt9
;Kitt.c,28 :: 		if(delayLED<5000){
	MOVLW       128
	XORWF       _delayLED+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       19
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt16
	MOVLW       136
	SUBWF       _delayLED+0, 0 
L__interrupt16:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt10
;Kitt.c,29 :: 		delayLED += 50;
	MOVLW       50
	ADDWF       _delayLED+0, 1 
	MOVLW       0
	ADDWFC      _delayLED+1, 1 
;Kitt.c,30 :: 		}
L_interrupt10:
;Kitt.c,31 :: 		}
L_interrupt9:
;Kitt.c,32 :: 		if(PORTB.RB6){
	BTFSS       PORTB+0, 6 
	GOTO        L_interrupt11
;Kitt.c,33 :: 		if(delayLED>50){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _delayLED+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt17
	MOVF        _delayLED+0, 0 
	SUBLW       50
L__interrupt17:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt12
;Kitt.c,34 :: 		delayLED -= 50;
	MOVLW       50
	SUBWF       _delayLED+0, 1 
	MOVLW       0
	SUBWFB      _delayLED+1, 1 
;Kitt.c,35 :: 		}
L_interrupt12:
;Kitt.c,36 :: 		}
L_interrupt11:
;Kitt.c,37 :: 		}
L_interrupt8:
;Kitt.c,38 :: 		INTCON.RBIF = 0; //pulisco l'interrupt flag
	BCF         INTCON+0, 0 
;Kitt.c,39 :: 		}
L_end_interrupt:
L__interrupt15:
	RETFIE      1
; end of _interrupt
