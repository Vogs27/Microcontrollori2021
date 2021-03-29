
_main:

;kitt_timer.c,3 :: 		void main()
;kitt_timer.c,5 :: 		short unsigned int dir = 1; //usato in while 1
	MOVLW       1
	MOVWF       main_dir_L0+0 
;kitt_timer.c,7 :: 		T0CON = 0b11000111;
	MOVLW       199
	MOVWF       T0CON+0 
;kitt_timer.c,21 :: 		TRISB.RB6 = 1;  //RB6 input
	BSF         TRISB+0, 6 
;kitt_timer.c,22 :: 		TRISB.RB7 = 1;  //RB7 input
	BSF         TRISB+0, 7 
;kitt_timer.c,23 :: 		ANSELB.RB6 = 0; //RB6 digital input
	BCF         ANSELB+0, 6 
;kitt_timer.c,24 :: 		ANSELB.RB7 = 0; //RB7 digital inpunt
	BCF         ANSELB+0, 7 
;kitt_timer.c,25 :: 		IOCB = 0b11000000;
	MOVLW       192
	MOVWF       IOCB+0 
;kitt_timer.c,28 :: 		TRISC = 0b00000000; //all port as output
	CLRF        TRISC+0 
;kitt_timer.c,29 :: 		LATC = 0b00000001;  //RC0 high
	MOVLW       1
	MOVWF       LATC+0 
;kitt_timer.c,32 :: 		INTCON.TMR0IE = 1;
	BSF         INTCON+0, 5 
;kitt_timer.c,33 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;kitt_timer.c,34 :: 		INTCON.RBIE = 1;
	BSF         INTCON+0, 3 
;kitt_timer.c,35 :: 		INTCON.RBIF = 0;
	BCF         INTCON+0, 0 
;kitt_timer.c,36 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;kitt_timer.c,51 :: 		while(1){
L_main0:
;kitt_timer.c,52 :: 		if(kitt_ms>=kitt_delay){
	MOVLW       128
	XORWF       _kitt_ms+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _kitt_delay+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main16
	MOVF        _kitt_delay+0, 0 
	SUBWF       _kitt_ms+0, 0 
L__main16:
	BTFSS       STATUS+0, 0 
	GOTO        L_main2
;kitt_timer.c,54 :: 		kitt_ms = 0;
	CLRF        _kitt_ms+0 
	CLRF        _kitt_ms+1 
;kitt_timer.c,57 :: 		if(dir)
	MOVF        main_dir_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main3
;kitt_timer.c,58 :: 		LATC <<= 1;
	MOVF        LATC+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       LATC+0 
	GOTO        L_main4
L_main3:
;kitt_timer.c,60 :: 		LATC >>= 1;
	MOVF        LATC+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVF        R0, 0 
	MOVWF       LATC+0 
L_main4:
;kitt_timer.c,71 :: 		if(LATC == 0b00000001)
	MOVF        LATC+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
;kitt_timer.c,72 :: 		dir = 1;
	MOVLW       1
	MOVWF       main_dir_L0+0 
	GOTO        L_main6
L_main5:
;kitt_timer.c,73 :: 		else if(LATC == 0b10000000)
	MOVF        LATC+0, 0 
	XORLW       128
	BTFSS       STATUS+0, 2 
	GOTO        L_main7
;kitt_timer.c,74 :: 		dir = 0;
	CLRF        main_dir_L0+0 
L_main7:
L_main6:
;kitt_timer.c,79 :: 		}
L_main2:
;kitt_timer.c,82 :: 		}
	GOTO        L_main0
;kitt_timer.c,83 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_interrupt:

;kitt_timer.c,85 :: 		void interrupt()
;kitt_timer.c,87 :: 		if (INTCON.RBIF)
	BTFSS       INTCON+0, 0 
	GOTO        L_interrupt8
;kitt_timer.c,89 :: 		if (PORTB.RB7)
	BTFSS       PORTB+0, 7 
	GOTO        L_interrupt9
;kitt_timer.c,91 :: 		if (kitt_delay < 5000)
	MOVLW       128
	XORWF       _kitt_delay+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       19
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt19
	MOVLW       136
	SUBWF       _kitt_delay+0, 0 
L__interrupt19:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt10
;kitt_timer.c,93 :: 		kitt_delay += 50;
	MOVLW       50
	ADDWF       _kitt_delay+0, 1 
	MOVLW       0
	ADDWFC      _kitt_delay+1, 1 
;kitt_timer.c,94 :: 		}
L_interrupt10:
;kitt_timer.c,95 :: 		}
L_interrupt9:
;kitt_timer.c,96 :: 		if (PORTB.RB6)
	BTFSS       PORTB+0, 6 
	GOTO        L_interrupt11
;kitt_timer.c,98 :: 		if (kitt_delay > 50)
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _kitt_delay+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt20
	MOVF        _kitt_delay+0, 0 
	SUBLW       50
L__interrupt20:
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt12
;kitt_timer.c,100 :: 		kitt_delay -= 50;
	MOVLW       50
	SUBWF       _kitt_delay+0, 1 
	MOVLW       0
	SUBWFB      _kitt_delay+1, 1 
;kitt_timer.c,101 :: 		}
L_interrupt12:
;kitt_timer.c,102 :: 		}
L_interrupt11:
;kitt_timer.c,103 :: 		INTCON.RBIF = 0; //pulisco l'interrupt flag
	BCF         INTCON+0, 0 
;kitt_timer.c,104 :: 		}
	GOTO        L_interrupt13
L_interrupt8:
;kitt_timer.c,105 :: 		else if (INTCON.TMR0IF)
	BTFSS       INTCON+0, 2 
	GOTO        L_interrupt14
;kitt_timer.c,107 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;kitt_timer.c,108 :: 		INTCON.TMR0IF = 0;
	BCF         INTCON+0, 2 
;kitt_timer.c,110 :: 		kitt_ms += 33;
	MOVLW       33
	ADDWF       _kitt_ms+0, 1 
	MOVLW       0
	ADDWFC      _kitt_ms+1, 1 
;kitt_timer.c,115 :: 		}
L_interrupt14:
L_interrupt13:
;kitt_timer.c,116 :: 		}
L_end_interrupt:
L__interrupt18:
	RETFIE      1
; end of _interrupt
