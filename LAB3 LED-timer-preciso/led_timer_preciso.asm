
_main:

;led_timer_preciso.c,3 :: 		void main() {
;led_timer_preciso.c,6 :: 		TRISC.RC0 = 0;
	BCF         TRISC+0, 0 
;led_timer_preciso.c,7 :: 		LATC.RC0 = 1;
	BSF         LATC+0, 0 
;led_timer_preciso.c,9 :: 		TRISC.RC7 = 0;
	BCF         TRISC+0, 7 
;led_timer_preciso.c,10 :: 		LATC.RC7 = 1;
	BSF         LATC+0, 7 
;led_timer_preciso.c,12 :: 		T0CON = 0b11000111;
	MOVLW       199
	MOVWF       T0CON+0 
;led_timer_preciso.c,13 :: 		TMR0L = 0b10001011;
	MOVLW       139
	MOVWF       TMR0L+0 
;led_timer_preciso.c,25 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;led_timer_preciso.c,26 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;led_timer_preciso.c,35 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;led_timer_preciso.c,37 :: 		while(1){
L_main0:
;led_timer_preciso.c,43 :: 		if(led_ms>=300){
	MOVLW       1
	SUBWF       _led_ms+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main5
	MOVLW       44
	SUBWF       _led_ms+0, 0 
L__main5:
	BTFSS       STATUS+0, 0 
	GOTO        L_main2
;led_timer_preciso.c,44 :: 		led_ms = 0;
	CLRF        _led_ms+0 
	CLRF        _led_ms+1 
;led_timer_preciso.c,45 :: 		LATC.RC0 = !LATC.RC0;
	BTG         LATC+0, 0 
;led_timer_preciso.c,46 :: 		}
L_main2:
;led_timer_preciso.c,49 :: 		}
	GOTO        L_main0
;led_timer_preciso.c,51 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;led_timer_preciso.c,54 :: 		void interrupt(){
;led_timer_preciso.c,57 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt3
;led_timer_preciso.c,58 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;led_timer_preciso.c,59 :: 		led_ms += 15;
	MOVLW       15
	ADDWF       _led_ms+0, 1 
	MOVLW       0
	ADDWFC      _led_ms+1, 1 
;led_timer_preciso.c,62 :: 		}
L_interrupt3:
;led_timer_preciso.c,67 :: 		}
L_end_interrupt:
L__interrupt7:
	RETFIE      1
; end of _interrupt
