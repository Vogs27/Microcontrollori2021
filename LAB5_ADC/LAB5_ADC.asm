
_main:

;LAB5_ADC.c,21 :: 		void main() {
;LAB5_ADC.c,24 :: 		Lcd_Init();               // Initialize Lcd
	CALL        _Lcd_Init+0, 0
;LAB5_ADC.c,25 :: 		Lcd_Cmd(_LCD_CLEAR);      // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LAB5_ADC.c,26 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LAB5_ADC.c,29 :: 		ANSELA.RA0 = 1;
	BSF         ANSELA+0, 0 
;LAB5_ADC.c,30 :: 		TRISA.RA0 = 1;
	BSF         TRISA+0, 0 
;LAB5_ADC.c,33 :: 		ANSELD.RD0 = 1;
	BSF         ANSELD+0, 0 
;LAB5_ADC.c,34 :: 		TRISD.RD0 = 1;
	BSF         TRISD+0, 0 
;LAB5_ADC.c,57 :: 		ADCON2 = 0b01000001;
	MOVLW       65
	MOVWF       ADCON2+0 
;LAB5_ADC.c,58 :: 		ADCON0 = 0b00000001;
	MOVLW       1
	MOVWF       ADCON0+0 
;LAB5_ADC.c,65 :: 		PIE1.ADIE = 1;
	BSF         PIE1+0, 6 
;LAB5_ADC.c,66 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;LAB5_ADC.c,67 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;LAB5_ADC.c,72 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;LAB5_ADC.c,73 :: 		ADCON0.GO_NOT_DONE = 1;
	BSF         ADCON0+0, 1 
;LAB5_ADC.c,76 :: 		while(1){
L_main0:
;LAB5_ADC.c,77 :: 		if(flag==1){
	MOVF        _flag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main2
;LAB5_ADC.c,78 :: 		strcpy(row, "RA0 [mV]: ");
	MOVLW       main_row_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(main_row_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr1_LAB5_ADC+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr1_LAB5_ADC+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;LAB5_ADC.c,79 :: 		IntToStr(adc_10bit_RA0*5, number);
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
;LAB5_ADC.c,80 :: 		flag=0;
	CLRF        _flag+0 
;LAB5_ADC.c,81 :: 		strcat(row, number);
	MOVLW       main_row_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_row_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       main_number_L0+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(main_number_L0+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;LAB5_ADC.c,82 :: 		Lcd_Out(1, 1, row);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_row_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_row_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LAB5_ADC.c,83 :: 		ADCON0.CHS0=0;
	BCF         ADCON0+0, 2 
;LAB5_ADC.c,84 :: 		ADCON0.CHS1=0;
	BCF         ADCON0+0, 3 
;LAB5_ADC.c,85 :: 		ADCON0.CHS2=1;
	BSF         ADCON0+0, 4 
;LAB5_ADC.c,86 :: 		ADCON0.CHS3=0;
	BCF         ADCON0+0, 5 
;LAB5_ADC.c,87 :: 		ADCON0.CHS4=1;
	BSF         ADCON0+0, 6 
;LAB5_ADC.c,88 :: 		ADCON2.ADFM=0;
	BCF         ADCON2+0, 7 
;LAB5_ADC.c,90 :: 		ADCON0.GO_NOT_DONE = 1;
	BSF         ADCON0+0, 1 
;LAB5_ADC.c,91 :: 		}
L_main2:
;LAB5_ADC.c,92 :: 		if(flag==2){
	MOVF        _flag+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main3
;LAB5_ADC.c,93 :: 		strcpy(row, "RD0 [mV]:");
	MOVLW       main_row_L0+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(main_row_L0+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr2_LAB5_ADC+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr2_LAB5_ADC+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;LAB5_ADC.c,94 :: 		IntToStr(adc_8bit_RD0*20, number);
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
;LAB5_ADC.c,95 :: 		flag=0;
	CLRF        _flag+0 
;LAB5_ADC.c,96 :: 		strcat(row, number);
	MOVLW       main_row_L0+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(main_row_L0+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       main_number_L0+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(main_number_L0+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;LAB5_ADC.c,97 :: 		Lcd_Out(2, 1, row);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_row_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_row_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LAB5_ADC.c,98 :: 		ADCON0.CHS0=0;
	BCF         ADCON0+0, 2 
;LAB5_ADC.c,99 :: 		ADCON0.CHS1=0;
	BCF         ADCON0+0, 3 
;LAB5_ADC.c,100 :: 		ADCON0.CHS2=0;
	BCF         ADCON0+0, 4 
;LAB5_ADC.c,101 :: 		ADCON0.CHS3=0;
	BCF         ADCON0+0, 5 
;LAB5_ADC.c,102 :: 		ADCON0.CHS4=0;
	BCF         ADCON0+0, 6 
;LAB5_ADC.c,103 :: 		ADCON2.ADFM=1;
	BSF         ADCON2+0, 7 
;LAB5_ADC.c,105 :: 		ADCON0.GO_NOT_DONE = 1;
	BSF         ADCON0+0, 1 
;LAB5_ADC.c,106 :: 		}
L_main3:
;LAB5_ADC.c,107 :: 		}
	GOTO        L_main0
;LAB5_ADC.c,109 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;LAB5_ADC.c,112 :: 		void interrupt(){
;LAB5_ADC.c,113 :: 		if (PIR1.ADIF)
	BTFSS       PIR1+0, 6 
	GOTO        L_interrupt4
;LAB5_ADC.c,115 :: 		PIR1.ADIF = 0;
	BCF         PIR1+0, 6 
;LAB5_ADC.c,116 :: 		if(ADCON2.ADFM==1){
	BTFSS       ADCON2+0, 7 
	GOTO        L_interrupt5
;LAB5_ADC.c,117 :: 		adc_10bit_RA0 = ADRESH<<8|ADRESL;
	MOVF        ADRESH+0, 0 
	MOVWF       _adc_10bit_RA0+1 
	CLRF        _adc_10bit_RA0+0 
	MOVF        ADRESL+0, 0 
	IORWF       _adc_10bit_RA0+0, 1 
	MOVLW       0
	IORWF       _adc_10bit_RA0+1, 1 
;LAB5_ADC.c,118 :: 		flag=1;
	MOVLW       1
	MOVWF       _flag+0 
;LAB5_ADC.c,126 :: 		}
	GOTO        L_interrupt6
L_interrupt5:
;LAB5_ADC.c,128 :: 		adc_8bit_RD0 = ADRESH;
	MOVF        ADRESH+0, 0 
	MOVWF       _adc_8bit_RD0+0 
;LAB5_ADC.c,129 :: 		flag=2;
	MOVLW       2
	MOVWF       _flag+0 
;LAB5_ADC.c,138 :: 		}
L_interrupt6:
;LAB5_ADC.c,141 :: 		}
L_interrupt4:
;LAB5_ADC.c,142 :: 		}
L_end_interrupt:
L__interrupt9:
	RETFIE      1
; end of _interrupt
