
_main:

;LAB5_ADC.c,20 :: 		void main() {
;LAB5_ADC.c,23 :: 		Lcd_Init();               // Initialize Lcd
	CALL        _Lcd_Init+0, 0
;LAB5_ADC.c,24 :: 		Lcd_Cmd(_LCD_CLEAR);      // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LAB5_ADC.c,25 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LAB5_ADC.c,28 :: 		ANSELA.RA0 = 1;
	BSF         ANSELA+0, 0 
;LAB5_ADC.c,29 :: 		TRISA.RA0 = 1;
	BSF         TRISA+0, 0 
;LAB5_ADC.c,32 :: 		ANSELD.RD0 = 1;
	BSF         ANSELD+0, 0 
;LAB5_ADC.c,33 :: 		TRISD.RD0 = 1;
	BSF         TRISD+0, 0 
;LAB5_ADC.c,63 :: 		ADCON2 = 0b01000001;
	MOVLW       65
	MOVWF       ADCON2+0 
;LAB5_ADC.c,64 :: 		ADCON0 = 0b00000001;
	MOVLW       1
	MOVWF       ADCON0+0 
;LAB5_ADC.c,71 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;LAB5_ADC.c,72 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;LAB5_ADC.c,73 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;LAB5_ADC.c,78 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;LAB5_ADC.c,79 :: 		ADCON0.GO_NOT_DONE = 1;
	BSF         ADCON0+0, 1 
;LAB5_ADC.c,82 :: 		while(1){
L_main0:
;LAB5_ADC.c,83 :: 		strcpy(row, "RA0 [mV]: ");
	MOVLW       main_row_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(main_row_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr1_LAB5_ADC+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr1_LAB5_ADC+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;LAB5_ADC.c,84 :: 		IntToStr(adc_10bit_RA0*5, number);
	MOVF        _adc_10bit_RA0+0, 0 
	MOVWF       R0 
	MOVF        _adc_10bit_RA0+1, 0 
	MOVWF       R1 
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_number_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_number_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;LAB5_ADC.c,85 :: 		strcat(row, number);
	MOVLW       main_row_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_row_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       main_number_L0+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(main_number_L0+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;LAB5_ADC.c,86 :: 		Lcd_Out(1, 1, row);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_row_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_row_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LAB5_ADC.c,87 :: 		strcpy(row, "RD0 [mV]:");
	MOVLW       main_row_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(main_row_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr2_LAB5_ADC+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr2_LAB5_ADC+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;LAB5_ADC.c,88 :: 		IntToStr(adc_8bit_RD0*20, number);
	MOVLW       20
	MULWF       _adc_8bit_RD0+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        PRODH+0, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_number_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_number_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;LAB5_ADC.c,89 :: 		strcat(row, number);
	MOVLW       main_row_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_row_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       main_number_L0+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(main_number_L0+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;LAB5_ADC.c,90 :: 		Lcd_Out(2, 1, row);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_row_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_row_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LAB5_ADC.c,91 :: 		}
	GOTO        L_main0
;LAB5_ADC.c,93 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;LAB5_ADC.c,96 :: 		void interrupt(){
;LAB5_ADC.c,97 :: 		if (PIR1.ADIF)
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt2
;LAB5_ADC.c,99 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;LAB5_ADC.c,100 :: 		if(ADCON2.ADFM){
	BTFSS       ADCON2+0, 7 
	GOTO        L_interrupt3
;LAB5_ADC.c,101 :: 		adc_10bit_RA0 = ADRESH<<8|ADRESL;
	MOVF        ADRESH+0, 0 
	MOVWF       _adc_10bit_RA0+1 
	CLRF        _adc_10bit_RA0+0 
	MOVF        ADRESL+0, 0 
	IORWF       _adc_10bit_RA0+0, 1 
	MOVLW       0
	IORWF       _adc_10bit_RA0+1, 1 
;LAB5_ADC.c,102 :: 		ADCON0.CHS0=0;
	BCF         ADCON0+0, 2 
;LAB5_ADC.c,103 :: 		ADCON0.CHS1=0;
	BCF         ADCON0+0, 3 
;LAB5_ADC.c,104 :: 		ADCON0.CHS2=1;
	BSF         ADCON0+0, 4 
;LAB5_ADC.c,105 :: 		ADCON0.CHS3=0;
	BCF         ADCON0+0, 5 
;LAB5_ADC.c,106 :: 		ADCON0.CHS4=1;
	BSF         ADCON0+0, 6 
;LAB5_ADC.c,108 :: 		}
	GOTO        L_interrupt4
L_interrupt3:
;LAB5_ADC.c,110 :: 		adc_8bit_RD0 = ADRESH;
	MOVF        ADRESH+0, 0 
	MOVWF       _adc_8bit_RD0+0 
;LAB5_ADC.c,111 :: 		ADCON0.CHS0=0;
	BCF         ADCON0+0, 2 
;LAB5_ADC.c,112 :: 		ADCON0.CHS1=0;
	BCF         ADCON0+0, 3 
;LAB5_ADC.c,113 :: 		ADCON0.CHS2=0;
	BCF         ADCON0+0, 4 
;LAB5_ADC.c,114 :: 		ADCON0.CHS3=0;
	BCF         ADCON0+0, 5 
;LAB5_ADC.c,115 :: 		ADCON0.CHS4=0;
	BCF         ADCON0+0, 6 
;LAB5_ADC.c,117 :: 		}
L_interrupt4:
;LAB5_ADC.c,118 :: 		ADCON2.ADFM = !ADCON2.ADFM;
	BTG         ADCON2+0, 7 
;LAB5_ADC.c,119 :: 		ADCON0.GO_NOT_DONE = 1;
	BSF         ADCON0+0, 1 
;LAB5_ADC.c,120 :: 		}
L_interrupt2:
;LAB5_ADC.c,121 :: 		}
L_end_interrupt:
L__interrupt7:
	RETFIE      1
; end of _interrupt
