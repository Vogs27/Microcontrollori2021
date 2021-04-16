
_main:

;LAB4_Step1.c,20 :: 		void main()
;LAB4_Step1.c,22 :: 		char pattern[5] = {0b11111111, 0b01111110, 0b00111100, 0b00011000, 0b00000000};
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
	CLRF        main_counter_sec_L0+0 
	CLRF        main_PORTA_Old_L0+0 
	CLRF        main_PORTA_Old_L0+1 
	MOVLW       244
	MOVWF       main_kitt_delay_L0+0 
	MOVLW       1
	MOVWF       main_kitt_delay_L0+1 
;LAB4_Step1.c,29 :: 		T0CON = 0b11000111;
	MOVLW       199
	MOVWF       T0CON+0 
;LAB4_Step1.c,30 :: 		TMR0L = 248;
	MOVLW       248
	MOVWF       TMR0L+0 
;LAB4_Step1.c,31 :: 		TRISD = 0b00000000;
	CLRF        TRISD+0 
;LAB4_Step1.c,32 :: 		TRISA = 0b00011111;
	MOVLW       31
	MOVWF       TRISA+0 
;LAB4_Step1.c,33 :: 		ANSELA = 0b00000000;
	CLRF        ANSELA+0 
;LAB4_Step1.c,35 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;LAB4_Step1.c,36 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;LAB4_Step1.c,37 :: 		PORTA_Old = PORTA;
	MOVF        PORTA+0, 0 
	MOVWF       main_PORTA_Old_L0+0 
	MOVLW       0
	MOVWF       main_PORTA_Old_L0+1 
;LAB4_Step1.c,38 :: 		Lcd_Init();               // Initialize Lcd
	CALL        _Lcd_Init+0, 0
;LAB4_Step1.c,39 :: 		Lcd_Cmd(_LCD_CLEAR);      // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LAB4_Step1.c,40 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LAB4_Step1.c,42 :: 		while (1)
L_main0:
;LAB4_Step1.c,45 :: 		if (!(PORTA_Old && PORTA) && PORTA != 0)
	MOVF        main_PORTA_Old_L0+0, 0 
	IORWF       main_PORTA_Old_L0+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main3
	MOVF        PORTA+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main3
	MOVLW       1
	MOVWF       R0 
	GOTO        L_main2
L_main3:
	CLRF        R0 
L_main2:
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main6
	MOVF        PORTA+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main6
L__main26:
;LAB4_Step1.c,47 :: 		PORTA_Old = PORTA;
	MOVF        PORTA+0, 0 
	MOVWF       main_PORTA_Old_L0+0 
	MOVLW       0
	MOVWF       main_PORTA_Old_L0+1 
;LAB4_Step1.c,48 :: 		if (PORTA.RA0)
	BTFSS       PORTA+0, 0 
	GOTO        L_main7
;LAB4_Step1.c,50 :: 		timer_go = 1;
	MOVLW       1
	MOVWF       _timer_go+0 
	MOVLW       0
	MOVWF       _timer_go+1 
;LAB4_Step1.c,51 :: 		}
	GOTO        L_main8
L_main7:
;LAB4_Step1.c,52 :: 		else if (PORTA.RA1)
	BTFSS       PORTA+0, 1 
	GOTO        L_main9
;LAB4_Step1.c,54 :: 		timer_go = 0;
	CLRF        _timer_go+0 
	CLRF        _timer_go+1 
;LAB4_Step1.c,55 :: 		}
	GOTO        L_main10
L_main9:
;LAB4_Step1.c,56 :: 		else if (PORTA.RA2)
	BTFSS       PORTA+0, 2 
	GOTO        L_main11
;LAB4_Step1.c,58 :: 		counter_sec = 0;
	CLRF        main_counter_sec_L0+0 
;LAB4_Step1.c,59 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LAB4_Step1.c,60 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LAB4_Step1.c,61 :: 		Lcd_Out(1, 1, 0);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	CLRF        FARG_Lcd_Out_text+0 
	CLRF        FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LAB4_Step1.c,62 :: 		}
	GOTO        L_main12
L_main11:
;LAB4_Step1.c,63 :: 		else if (PORTA.RA3)
	BTFSS       PORTA+0, 3 
	GOTO        L_main13
;LAB4_Step1.c,65 :: 		if (kitt_delay < 2000)
	MOVLW       128
	XORWF       main_kitt_delay_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       7
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main28
	MOVLW       208
	SUBWF       main_kitt_delay_L0+0, 0 
L__main28:
	BTFSC       STATUS+0, 0 
	GOTO        L_main14
;LAB4_Step1.c,67 :: 		kitt_delay = kitt_delay + 300;
	MOVLW       44
	ADDWF       main_kitt_delay_L0+0, 1 
	MOVLW       1
	ADDWFC      main_kitt_delay_L0+1, 1 
;LAB4_Step1.c,68 :: 		}
L_main14:
;LAB4_Step1.c,69 :: 		}
	GOTO        L_main15
L_main13:
;LAB4_Step1.c,70 :: 		else if (PORTA.RA4)
	BTFSS       PORTA+0, 4 
	GOTO        L_main16
;LAB4_Step1.c,72 :: 		if (kitt_delay > 500)
	MOVLW       128
	XORLW       1
	MOVWF       R0 
	MOVLW       128
	XORWF       main_kitt_delay_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main29
	MOVF        main_kitt_delay_L0+0, 0 
	SUBLW       244
L__main29:
	BTFSC       STATUS+0, 0 
	GOTO        L_main17
;LAB4_Step1.c,74 :: 		kitt_delay = kitt_delay - 300;
	MOVLW       44
	SUBWF       main_kitt_delay_L0+0, 1 
	MOVLW       1
	SUBWFB      main_kitt_delay_L0+1, 1 
;LAB4_Step1.c,75 :: 		}
L_main17:
;LAB4_Step1.c,76 :: 		}
L_main16:
L_main15:
L_main12:
L_main10:
L_main8:
;LAB4_Step1.c,77 :: 		}
L_main6:
;LAB4_Step1.c,79 :: 		if (counter_kitt > kitt_delay)
	MOVF        _counter_kitt+1, 0 
	SUBWF       main_kitt_delay_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main30
	MOVF        _counter_kitt+0, 0 
	SUBWF       main_kitt_delay_L0+0, 0 
L__main30:
	BTFSC       STATUS+0, 0 
	GOTO        L_main18
;LAB4_Step1.c,81 :: 		counter_kitt = 0;
	CLRF        _counter_kitt+0 
	CLRF        _counter_kitt+1 
;LAB4_Step1.c,82 :: 		LATD = pattern[cycle];
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
;LAB4_Step1.c,83 :: 		if (cycle == 4)
	MOVF        main_cycle_L0+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_main19
;LAB4_Step1.c,85 :: 		dir = 0;
	CLRF        main_dir_L0+0 
;LAB4_Step1.c,86 :: 		}
L_main19:
;LAB4_Step1.c,87 :: 		if (cycle == 0)
	MOVF        main_cycle_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main20
;LAB4_Step1.c,89 :: 		dir = 1;
	MOVLW       1
	MOVWF       main_dir_L0+0 
;LAB4_Step1.c,90 :: 		}
L_main20:
;LAB4_Step1.c,91 :: 		if (dir == 1)
	MOVF        main_dir_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main21
;LAB4_Step1.c,93 :: 		cycle++;
	INCF        main_cycle_L0+0, 1 
;LAB4_Step1.c,94 :: 		}
	GOTO        L_main22
L_main21:
;LAB4_Step1.c,97 :: 		cycle--;
	DECF        main_cycle_L0+0, 1 
;LAB4_Step1.c,98 :: 		}
L_main22:
;LAB4_Step1.c,99 :: 		}
L_main18:
;LAB4_Step1.c,102 :: 		if (counter_ms > 1000)
	MOVF        _counter_ms+1, 0 
	SUBLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L__main31
	MOVF        _counter_ms+0, 0 
	SUBLW       232
L__main31:
	BTFSC       STATUS+0, 0 
	GOTO        L_main23
;LAB4_Step1.c,104 :: 		counter_sec++;
	INCF        main_counter_sec_L0+0, 1 
;LAB4_Step1.c,105 :: 		counter_ms = 0;
	CLRF        _counter_ms+0 
	CLRF        _counter_ms+1 
;LAB4_Step1.c,106 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LAB4_Step1.c,107 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LAB4_Step1.c,108 :: 		IntToStr(counter_sec, output_num);
	MOVF        main_counter_sec_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_output_num_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_output_num_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;LAB4_Step1.c,109 :: 		Lcd_Out(1, 1, output_num);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_output_num_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_output_num_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LAB4_Step1.c,110 :: 		}
L_main23:
;LAB4_Step1.c,111 :: 		}
	GOTO        L_main0
;LAB4_Step1.c,112 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;LAB4_Step1.c,114 :: 		void interrupt()
;LAB4_Step1.c,116 :: 		if (INTCON.TMR0IF)
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt24
;LAB4_Step1.c,118 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;LAB4_Step1.c,119 :: 		TMR0L = 248;
	MOVLW       248
	MOVWF       TMR0L+0 
;LAB4_Step1.c,120 :: 		if (timer_go==1)
	MOVLW       0
	XORWF       _timer_go+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt34
	MOVLW       1
	XORWF       _timer_go+0, 0 
L__interrupt34:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt25
;LAB4_Step1.c,122 :: 		counter_ms++;
	INFSNZ      _counter_ms+0, 1 
	INCF        _counter_ms+1, 1 
;LAB4_Step1.c,123 :: 		}
L_interrupt25:
;LAB4_Step1.c,124 :: 		counter_kitt++;
	INFSNZ      _counter_kitt+0, 1 
	INCF        _counter_kitt+1, 1 
;LAB4_Step1.c,125 :: 		}
L_interrupt24:
;LAB4_Step1.c,126 :: 		}
L_end_interrupt:
L__interrupt33:
	RETFIE      1
; end of _interrupt
