
_main:

;LAB4_Step0.c,6 :: 		void main() {
;LAB4_Step0.c,7 :: 		T0CON = 0b11000111;
	MOVLW       199
	MOVWF       T0CON+0 
;LAB4_Step0.c,8 :: 		TMR0L = 248;
	MOVLW       248
	MOVWF       TMR0L+0 
;LAB4_Step0.c,9 :: 		TRISD = 0b00000000;
	CLRF        TRISD+0 
;LAB4_Step0.c,13 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;LAB4_Step0.c,14 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;LAB4_Step0.c,16 :: 		while(1){
L_main0:
;LAB4_Step0.c,17 :: 		LATD = pattern[cycle];
	MOVLW       _pattern+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_pattern+0)
	MOVWF       FSR0L+1 
	MOVF        _cycle+0, 0 
	ADDWF       FSR0L+0, 1 
	MOVLW       0
	BTFSC       _cycle+0, 7 
	MOVLW       255
	ADDWFC      FSR0L+1, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       LATD+0 
;LAB4_Step0.c,18 :: 		if (cycle == 4)
	MOVF        _cycle+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_main2
;LAB4_Step0.c,19 :: 		dir = -1;
	MOVLW       255
	MOVWF       _dir+0 
	MOVLW       255
	MOVWF       _dir+1 
L_main2:
;LAB4_Step0.c,20 :: 		if (cycle == 0)
	MOVF        _cycle+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main3
;LAB4_Step0.c,21 :: 		dir = 1;
	MOVLW       1
	MOVWF       _dir+0 
	MOVLW       0
	MOVWF       _dir+1 
L_main3:
;LAB4_Step0.c,22 :: 		}
	GOTO        L_main0
;LAB4_Step0.c,23 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;LAB4_Step0.c,25 :: 		void interrupt(){
;LAB4_Step0.c,26 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt4
;LAB4_Step0.c,27 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;LAB4_Step0.c,28 :: 		TMR0L = 248;
	MOVLW       248
	MOVWF       TMR0L+0 
;LAB4_Step0.c,29 :: 		counter_ms++;
	INFSNZ      _counter_ms+0, 1 
	INCF        _counter_ms+1, 1 
;LAB4_Step0.c,30 :: 		if(counter_ms>=1000){
	MOVLW       3
	SUBWF       _counter_ms+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt11
	MOVLW       232
	SUBWF       _counter_ms+0, 0 
L__interrupt11:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt5
;LAB4_Step0.c,31 :: 		counter_sec++;
	INFSNZ      _counter_sec+0, 1 
	INCF        _counter_sec+1, 1 
;LAB4_Step0.c,32 :: 		counter_ms=0;
	CLRF        _counter_ms+0 
	CLRF        _counter_ms+1 
;LAB4_Step0.c,33 :: 		if (dir == 1){
	MOVLW       0
	XORWF       _dir+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt12
	MOVLW       1
	XORWF       _dir+0, 0 
L__interrupt12:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt6
;LAB4_Step0.c,34 :: 		cycle ++;
	INCF        _cycle+0, 1 
;LAB4_Step0.c,35 :: 		}
	GOTO        L_interrupt7
L_interrupt6:
;LAB4_Step0.c,37 :: 		cycle --;
	DECF        _cycle+0, 1 
;LAB4_Step0.c,38 :: 		}
L_interrupt7:
;LAB4_Step0.c,39 :: 		}
L_interrupt5:
;LAB4_Step0.c,40 :: 		}
L_interrupt4:
;LAB4_Step0.c,41 :: 		}
L_end_interrupt:
L__interrupt10:
	RETFIE      1
; end of _interrupt
