
_main:

;LAB4_Step3.c,20 :: 		void main()
;LAB4_Step3.c,22 :: 		char pattern[5] = {0b11111111, 0b01111110, 0b00111100, 0b00011000, 0b00000000};
	MOVLW       ?ICSmain_pattern_L0+0
	MOVWF       TBLPTRL+0 
	MOVLW       hi_addr(?ICSmain_pattern_L0+0)
	MOVWF       TBLPTRL+1 
	MOVLW       higher_addr(?ICSmain_pattern_L0+0)
	MOVWF       TBLPTRL+2 
	MOVLW       main_pattern_L0+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(main_pattern_L0+0)
	MOVWF       FSR1L+1 
	MOVLW       29
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
;LAB4_Step3.c,34 :: 		T0CON = 0b11000111;
	MOVLW       199
	MOVWF       T0CON+0 
;LAB4_Step3.c,35 :: 		TMR0L = 248;
	MOVLW       248
	MOVWF       TMR0L+0 
;LAB4_Step3.c,36 :: 		TRISD = 0b00000000;
	CLRF        TRISD+0 
;LAB4_Step3.c,37 :: 		TRISA = 0b00011111;
	MOVLW       31
	MOVWF       TRISA+0 
;LAB4_Step3.c,38 :: 		ANSELA = 0b00000000;
	CLRF        ANSELA+0 
;LAB4_Step3.c,40 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;LAB4_Step3.c,41 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;LAB4_Step3.c,42 :: 		PORTA_Old = PORTA;
	MOVF        PORTA+0, 0 
	MOVWF       main_PORTA_Old_L0+0 
	MOVLW       0
	MOVWF       main_PORTA_Old_L0+1 
;LAB4_Step3.c,43 :: 		Lcd_Init();               // Initialize Lcd
	CALL        _Lcd_Init+0, 0
;LAB4_Step3.c,44 :: 		Lcd_Cmd(_LCD_CLEAR);      // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LAB4_Step3.c,45 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LAB4_Step3.c,47 :: 		while (1)
L_main0:
;LAB4_Step3.c,50 :: 		if (!((PORTA_Old & 0b00011111) & (PORTA & 0b00011111)) && (PORTA & 0b00011111) != 0)
	MOVLW       31
	ANDWF       main_PORTA_Old_L0+0, 0 
	MOVWF       R2 
	MOVF        main_PORTA_Old_L0+1, 0 
	MOVWF       R3 
	MOVLW       0
	ANDWF       R3, 1 
	MOVLW       31
	ANDWF       PORTA+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
	ANDWF       R0, 1 
	MOVF        R3, 0 
	ANDWF       R1, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main4
	MOVLW       31
	ANDWF       PORTA+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main4
L__main35:
;LAB4_Step3.c,52 :: 		PORTA_Old = PORTA;
	MOVF        PORTA+0, 0 
	MOVWF       main_PORTA_Old_L0+0 
	MOVLW       0
	MOVWF       main_PORTA_Old_L0+1 
;LAB4_Step3.c,53 :: 		if (PORTA.RA0)
	BTFSS       PORTA+0, 0 
	GOTO        L_main5
;LAB4_Step3.c,55 :: 		timer_go = 1;
	MOVLW       1
	MOVWF       _timer_go+0 
	MOVLW       0
	MOVWF       _timer_go+1 
;LAB4_Step3.c,56 :: 		}
	GOTO        L_main6
L_main5:
;LAB4_Step3.c,57 :: 		else if (PORTA.RA1)
	BTFSS       PORTA+0, 1 
	GOTO        L_main7
;LAB4_Step3.c,59 :: 		timer_go = 0;
	CLRF        _timer_go+0 
	CLRF        _timer_go+1 
;LAB4_Step3.c,60 :: 		}
	GOTO        L_main8
L_main7:
;LAB4_Step3.c,61 :: 		else if (PORTA.RA2)
	BTFSS       PORTA+0, 2 
	GOTO        L_main9
;LAB4_Step3.c,63 :: 		counter_sec = 0;
	CLRF        main_counter_sec_L0+0 
;LAB4_Step3.c,64 :: 		counter_min = 0;
	CLRF        main_counter_min_L0+0 
;LAB4_Step3.c,65 :: 		counter_hours = 0;
	CLRF        main_counter_hours_L0+0 
	CLRF        main_counter_hours_L0+1 
;LAB4_Step3.c,66 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LAB4_Step3.c,67 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LAB4_Step3.c,68 :: 		Lcd_Out(1, 16-strlen(zeroes), zeroes);
	MOVLW       main_zeroes_L0+0
	MOVWF       FARG_strlen_s+0 
	MOVLW       hi_addr(main_zeroes_L0+0)
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVF        R0, 0 
	SUBLW       16
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       main_zeroes_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_zeroes_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LAB4_Step3.c,69 :: 		}
	GOTO        L_main10
L_main9:
;LAB4_Step3.c,70 :: 		else if (PORTA.RA3)
	BTFSS       PORTA+0, 3 
	GOTO        L_main11
;LAB4_Step3.c,72 :: 		if (kitt_delay < 2000)
	MOVLW       128
	XORWF       main_kitt_delay_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       7
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main37
	MOVLW       208
	SUBWF       main_kitt_delay_L0+0, 0 
L__main37:
	BTFSC       STATUS+0, 0 
	GOTO        L_main12
;LAB4_Step3.c,74 :: 		kitt_delay = kitt_delay + 300;
	MOVLW       44
	ADDWF       main_kitt_delay_L0+0, 1 
	MOVLW       1
	ADDWFC      main_kitt_delay_L0+1, 1 
;LAB4_Step3.c,75 :: 		}
L_main12:
;LAB4_Step3.c,76 :: 		}
	GOTO        L_main13
L_main11:
;LAB4_Step3.c,77 :: 		else if (PORTA.RA4)
	BTFSS       PORTA+0, 4 
	GOTO        L_main14
;LAB4_Step3.c,79 :: 		if (kitt_delay > 500)
	MOVLW       128
	XORLW       1
	MOVWF       R0 
	MOVLW       128
	XORWF       main_kitt_delay_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main38
	MOVF        main_kitt_delay_L0+0, 0 
	SUBLW       244
L__main38:
	BTFSC       STATUS+0, 0 
	GOTO        L_main15
;LAB4_Step3.c,81 :: 		kitt_delay = kitt_delay - 300;
	MOVLW       44
	SUBWF       main_kitt_delay_L0+0, 1 
	MOVLW       1
	SUBWFB      main_kitt_delay_L0+1, 1 
;LAB4_Step3.c,82 :: 		}
L_main15:
;LAB4_Step3.c,83 :: 		}
L_main14:
L_main13:
L_main10:
L_main8:
L_main6:
;LAB4_Step3.c,84 :: 		}
L_main4:
;LAB4_Step3.c,86 :: 		if (counter_kitt > kitt_delay)
	MOVF        _counter_kitt+1, 0 
	SUBWF       main_kitt_delay_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main39
	MOVF        _counter_kitt+0, 0 
	SUBWF       main_kitt_delay_L0+0, 0 
L__main39:
	BTFSC       STATUS+0, 0 
	GOTO        L_main16
;LAB4_Step3.c,88 :: 		counter_kitt = 0;
	CLRF        _counter_kitt+0 
	CLRF        _counter_kitt+1 
;LAB4_Step3.c,89 :: 		LATD = pattern[cycle];
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
;LAB4_Step3.c,90 :: 		if (cycle == 4)
	MOVF        main_cycle_L0+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_main17
;LAB4_Step3.c,92 :: 		dir = 0;
	CLRF        main_dir_L0+0 
;LAB4_Step3.c,93 :: 		}
L_main17:
;LAB4_Step3.c,94 :: 		if (cycle == 0)
	MOVF        main_cycle_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main18
;LAB4_Step3.c,96 :: 		dir = 1;
	MOVLW       1
	MOVWF       main_dir_L0+0 
;LAB4_Step3.c,97 :: 		}
L_main18:
;LAB4_Step3.c,98 :: 		if (dir == 1)
	MOVF        main_dir_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main19
;LAB4_Step3.c,100 :: 		cycle++;
	INCF        main_cycle_L0+0, 1 
;LAB4_Step3.c,101 :: 		}
	GOTO        L_main20
L_main19:
;LAB4_Step3.c,104 :: 		cycle--;
	DECF        main_cycle_L0+0, 1 
;LAB4_Step3.c,105 :: 		}
L_main20:
;LAB4_Step3.c,106 :: 		}
L_main16:
;LAB4_Step3.c,108 :: 		if (counter_ms != old_counter_ms)
	MOVF        _counter_ms+1, 0 
	XORWF       main_old_counter_ms_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main40
	MOVF        main_old_counter_ms_L0+0, 0 
	XORWF       _counter_ms+0, 0 
L__main40:
	BTFSC       STATUS+0, 2 
	GOTO        L_main21
;LAB4_Step3.c,110 :: 		if (counter_ms > 1000)
	MOVF        _counter_ms+1, 0 
	SUBLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L__main41
	MOVF        _counter_ms+0, 0 
	SUBLW       232
L__main41:
	BTFSC       STATUS+0, 0 
	GOTO        L_main22
;LAB4_Step3.c,112 :: 		counter_sec++;
	INCF        main_counter_sec_L0+0, 1 
;LAB4_Step3.c,113 :: 		counter_ms = 0;
	CLRF        _counter_ms+0 
	CLRF        _counter_ms+1 
;LAB4_Step3.c,114 :: 		if (counter_sec > 60)
	MOVF        main_counter_sec_L0+0, 0 
	SUBLW       60
	BTFSC       STATUS+0, 0 
	GOTO        L_main23
;LAB4_Step3.c,116 :: 		counter_min++;
	INCF        main_counter_min_L0+0, 1 
;LAB4_Step3.c,117 :: 		counter_sec = 0;
	CLRF        main_counter_sec_L0+0 
;LAB4_Step3.c,118 :: 		if (counter_min > 60)
	MOVF        main_counter_min_L0+0, 0 
	SUBLW       60
	BTFSC       STATUS+0, 0 
	GOTO        L_main24
;LAB4_Step3.c,120 :: 		counter_hours++;
	INFSNZ      main_counter_hours_L0+0, 1 
	INCF        main_counter_hours_L0+1, 1 
;LAB4_Step3.c,121 :: 		counter_min = 0;
	CLRF        main_counter_min_L0+0 
;LAB4_Step3.c,122 :: 		}
L_main24:
;LAB4_Step3.c,123 :: 		}
L_main23:
;LAB4_Step3.c,124 :: 		}
L_main22:
;LAB4_Step3.c,128 :: 		output_string[0] = '\0'; //clean the ouput string
	CLRF        main_output_string_L0+0 
;LAB4_Step3.c,129 :: 		IntToStr(counter_hours, output_num);
	MOVF        main_counter_hours_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        main_counter_hours_L0+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_output_num_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_output_num_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;LAB4_Step3.c,130 :: 		strcat(output_string, output_num+3);
	MOVLW       main_output_string_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_output_string_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       main_output_num_L0+3
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(main_output_num_L0+3)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;LAB4_Step3.c,131 :: 		strcat(output_string,":");
	MOVLW       main_output_string_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_output_string_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr1_LAB4_Step3+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr1_LAB4_Step3+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;LAB4_Step3.c,132 :: 		IntToStr(counter_min, output_num);
	MOVF        main_counter_min_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_output_num_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_output_num_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;LAB4_Step3.c,133 :: 		if (counter_min < 10)
	MOVLW       10
	SUBWF       main_counter_min_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main25
;LAB4_Step3.c,135 :: 		strcat(output_string, "0");
	MOVLW       main_output_string_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_output_string_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr2_LAB4_Step3+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr2_LAB4_Step3+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;LAB4_Step3.c,136 :: 		strcat(output_string, output_num+5);
	MOVLW       main_output_string_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_output_string_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       main_output_num_L0+5
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(main_output_num_L0+5)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;LAB4_Step3.c,137 :: 		}
	GOTO        L_main26
L_main25:
;LAB4_Step3.c,139 :: 		strcat(output_string, output_num+4);
	MOVLW       main_output_string_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_output_string_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       main_output_num_L0+4
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(main_output_num_L0+4)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;LAB4_Step3.c,140 :: 		}
L_main26:
;LAB4_Step3.c,141 :: 		strcat(output_string, ":");
	MOVLW       main_output_string_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_output_string_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr3_LAB4_Step3+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr3_LAB4_Step3+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;LAB4_Step3.c,142 :: 		IntToStr(counter_sec, output_num);
	MOVF        main_counter_sec_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_output_num_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_output_num_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;LAB4_Step3.c,143 :: 		if (counter_sec < 10)
	MOVLW       10
	SUBWF       main_counter_sec_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main27
;LAB4_Step3.c,145 :: 		strcat(output_string, "0");
	MOVLW       main_output_string_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_output_string_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr4_LAB4_Step3+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr4_LAB4_Step3+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;LAB4_Step3.c,146 :: 		strcat(output_string, output_num+5);
	MOVLW       main_output_string_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_output_string_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       main_output_num_L0+5
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(main_output_num_L0+5)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;LAB4_Step3.c,147 :: 		}else{
	GOTO        L_main28
L_main27:
;LAB4_Step3.c,148 :: 		strcat(output_string, output_num+4);
	MOVLW       main_output_string_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_output_string_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       main_output_num_L0+4
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(main_output_num_L0+4)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;LAB4_Step3.c,149 :: 		}
L_main28:
;LAB4_Step3.c,150 :: 		strcat(output_string,":");
	MOVLW       main_output_string_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_output_string_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr5_LAB4_Step3+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr5_LAB4_Step3+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;LAB4_Step3.c,151 :: 		IntToStr(counter_ms, output_num);
	MOVF        _counter_ms+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _counter_ms+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_output_num_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_output_num_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;LAB4_Step3.c,152 :: 		if (counter_ms < 10)
	MOVLW       0
	SUBWF       _counter_ms+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main42
	MOVLW       10
	SUBWF       _counter_ms+0, 0 
L__main42:
	BTFSC       STATUS+0, 0 
	GOTO        L_main29
;LAB4_Step3.c,154 :: 		strcat(output_string, "00");
	MOVLW       main_output_string_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_output_string_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr6_LAB4_Step3+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr6_LAB4_Step3+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;LAB4_Step3.c,155 :: 		strcat(output_string, output_num+5);
	MOVLW       main_output_string_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_output_string_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       main_output_num_L0+5
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(main_output_num_L0+5)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;LAB4_Step3.c,156 :: 		}
	GOTO        L_main30
L_main29:
;LAB4_Step3.c,157 :: 		else if (counter_ms < 100)
	MOVLW       0
	SUBWF       _counter_ms+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main43
	MOVLW       100
	SUBWF       _counter_ms+0, 0 
L__main43:
	BTFSC       STATUS+0, 0 
	GOTO        L_main31
;LAB4_Step3.c,159 :: 		strcat(output_string, "0");
	MOVLW       main_output_string_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_output_string_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr7_LAB4_Step3+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr7_LAB4_Step3+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;LAB4_Step3.c,160 :: 		strcat(output_string, output_num+4);
	MOVLW       main_output_string_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_output_string_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       main_output_num_L0+4
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(main_output_num_L0+4)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;LAB4_Step3.c,161 :: 		}else{
	GOTO        L_main32
L_main31:
;LAB4_Step3.c,162 :: 		strcat(output_string, output_num+3);
	MOVLW       main_output_string_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_output_string_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       main_output_num_L0+3
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(main_output_num_L0+3)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;LAB4_Step3.c,163 :: 		}
L_main32:
L_main30:
;LAB4_Step3.c,164 :: 		Lcd_Out(1, 16-strlen(output_string), output_string);
	MOVLW       main_output_string_L0+0
	MOVWF       FARG_strlen_s+0 
	MOVLW       hi_addr(main_output_string_L0+0)
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVF        R0, 0 
	SUBLW       16
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       main_output_string_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_output_string_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LAB4_Step3.c,165 :: 		old_counter_ms = counter_ms;
	MOVF        _counter_ms+0, 0 
	MOVWF       main_old_counter_ms_L0+0 
	MOVF        _counter_ms+1, 0 
	MOVWF       main_old_counter_ms_L0+1 
;LAB4_Step3.c,166 :: 		}
L_main21:
;LAB4_Step3.c,167 :: 		}
	GOTO        L_main0
;LAB4_Step3.c,168 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;LAB4_Step3.c,170 :: 		void interrupt()
;LAB4_Step3.c,172 :: 		if (INTCON.TMR0IF)
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt33
;LAB4_Step3.c,174 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;LAB4_Step3.c,175 :: 		TMR0L = 248;
	MOVLW       248
	MOVWF       TMR0L+0 
;LAB4_Step3.c,176 :: 		if (timer_go == 1)
	MOVLW       0
	XORWF       _timer_go+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt46
	MOVLW       1
	XORWF       _timer_go+0, 0 
L__interrupt46:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt34
;LAB4_Step3.c,178 :: 		counter_ms++;
	INFSNZ      _counter_ms+0, 1 
	INCF        _counter_ms+1, 1 
;LAB4_Step3.c,179 :: 		}
L_interrupt34:
;LAB4_Step3.c,180 :: 		counter_kitt++;
	INFSNZ      _counter_kitt+0, 1 
	INCF        _counter_kitt+1, 1 
;LAB4_Step3.c,181 :: 		}
L_interrupt33:
;LAB4_Step3.c,182 :: 		}
L_end_interrupt:
L__interrupt45:
	RETFIE      1
; end of _interrupt
