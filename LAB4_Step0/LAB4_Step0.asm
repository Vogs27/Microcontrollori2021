
_main:

;LAB4_Step0.c,20 :: 		void main() {
;LAB4_Step0.c,21 :: 		char pattern[5]={0b11111111, 0b01111110, 0b00111100, 0b00011000, 0b00000000};
	MOVLW       255
	MOVWF       main_pattern_L0+0 
	MOVLW       126
	MOVWF       main_pattern_L0+1 
	MOVLW       60
	MOVWF       main_pattern_L0+2 
	MOVLW       24
	MOVWF       main_pattern_L0+3 
	CLRF        main_pattern_L0+4 
	MOVLW       1
	MOVWF       main_dir_L0+0 
	CLRF        main_cycle_L0+0 
;LAB4_Step0.c,26 :: 		T0CON = 0b11000111;
	MOVLW       199
	MOVWF       T0CON+0 
;LAB4_Step0.c,27 :: 		TMR0L = 248;
	MOVLW       248
	MOVWF       TMR0L+0 
;LAB4_Step0.c,28 :: 		TRISD = 0b00000000;
	CLRF        TRISD+0 
;LAB4_Step0.c,31 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;LAB4_Step0.c,32 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;LAB4_Step0.c,35 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LAB4_Step0.c,36 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LAB4_Step0.c,38 :: 		while(1){
L_main0:
;LAB4_Step0.c,40 :: 		if(counter_kitt > 1000){
	MOVF        _counter_kitt+1, 0 
	SUBLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L__main9
	MOVF        _counter_kitt+0, 0 
	SUBLW       232
L__main9:
	BTFSC       STATUS+0, 0 
	GOTO        L_main2
;LAB4_Step0.c,41 :: 		counter_kitt = 0;
	CLRF        _counter_kitt+0 
	CLRF        _counter_kitt+1 
;LAB4_Step0.c,42 :: 		LATD = pattern[cycle];
	MOVLW       main_pattern_L0+0
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(main_pattern_L0+0)
	MOVWF       FSR0L+1 
	MOVF        main_cycle_L0+0, 0 
	ADDWF       FSR0L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0L+1, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       LATD+0 
;LAB4_Step0.c,43 :: 		if (cycle == 4){
	MOVF        main_cycle_L0+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_main3
;LAB4_Step0.c,44 :: 		dir = 0;
	CLRF        main_dir_L0+0 
;LAB4_Step0.c,45 :: 		}
L_main3:
;LAB4_Step0.c,46 :: 		if (cycle == 0){
	MOVF        main_cycle_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
;LAB4_Step0.c,47 :: 		dir = 1;
	MOVLW       1
	MOVWF       main_dir_L0+0 
;LAB4_Step0.c,48 :: 		}
L_main4:
;LAB4_Step0.c,49 :: 		if (dir == 1){
	MOVF        main_dir_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
;LAB4_Step0.c,50 :: 		cycle ++;
	INCF        main_cycle_L0+0, 1 
;LAB4_Step0.c,51 :: 		}
	GOTO        L_main6
L_main5:
;LAB4_Step0.c,53 :: 		cycle --;
	DECF        main_cycle_L0+0, 1 
;LAB4_Step0.c,54 :: 		}
L_main6:
;LAB4_Step0.c,55 :: 		}
L_main2:
;LAB4_Step0.c,66 :: 		}
	GOTO        L_main0
;LAB4_Step0.c,67 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;LAB4_Step0.c,69 :: 		void interrupt(){
;LAB4_Step0.c,70 :: 		if(INTCON.TMR0IF){
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt7
;LAB4_Step0.c,71 :: 		INTCON.TMR0IF=0;
	BCF         INTCON+0, 2 
;LAB4_Step0.c,72 :: 		TMR0L = 248;
	MOVLW       248
	MOVWF       TMR0L+0 
;LAB4_Step0.c,73 :: 		counter_ms++;
	INFSNZ      _counter_ms+0, 1 
	INCF        _counter_ms+1, 1 
;LAB4_Step0.c,74 :: 		counter_kitt++;
	INFSNZ      _counter_kitt+0, 1 
	INCF        _counter_kitt+1, 1 
;LAB4_Step0.c,75 :: 		}
L_interrupt7:
;LAB4_Step0.c,76 :: 		}
L_end_interrupt:
L__interrupt11:
	RETFIE      1
; end of _interrupt
