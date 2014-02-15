
_print_time:

	MOVF       _HH+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_print_time0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _HH+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      _d1+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _HH+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _d2+0
	MOVF       _MM+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_print_time1
	CLRF       _d3+0
	CLRF       _d4+0
	GOTO       L_print_time2
L_print_time1:
	MOVLW      10
	MOVWF      R4+0
	MOVF       _MM+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      _d3+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _MM+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _d4+0
L_print_time2:
	GOTO       L_print_time3
L_print_time0:
	MOVF       _MM+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_print_time4
	CLRF       _d1+0
	CLRF       _d2+0
	GOTO       L_print_time5
L_print_time4:
	MOVLW      10
	MOVWF      R4+0
	MOVF       _MM+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      _d1+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _MM+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _d2+0
L_print_time5:
	MOVF       _SS+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_print_time6
	CLRF       _d3+0
	CLRF       _d4+0
	GOTO       L_print_time7
L_print_time6:
	MOVLW      10
	MOVWF      R4+0
	MOVF       _SS+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      _d3+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _SS+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _d4+0
L_print_time7:
L_print_time3:
	MOVLW      255
	MOVWF      PORTB+0
	MOVLW      255
	MOVWF      PORTC+0
	MOVLW      255
	MOVWF      PORTD+0
	MOVLW      16
	MOVWF      R13+0
L_print_time8:
	DECFSZ     R13+0, 1
	GOTO       L_print_time8
	NOP
	MOVF       _d2+0, 0
	XORLW      9
	BTFSS      STATUS+0, 2
	GOTO       L_print_time9
	CLRF       _d2+0
	GOTO       L_print_time10
L_print_time9:
	MOVF       _d2+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_print_time11
	MOVLW      9
	MOVWF      _d2+0
L_print_time11:
L_print_time10:
	MOVF       _d4+0, 0
	XORLW      9
	BTFSS      STATUS+0, 2
	GOTO       L_print_time12
	CLRF       _d4+0
	GOTO       L_print_time13
L_print_time12:
	MOVF       _d4+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_print_time14
	MOVLW      9
	MOVWF      _d4+0
L_print_time14:
L_print_time13:
	MOVF       _d4+0, 0
	ADDLW      _bcd+0
	MOVWF      R0+0
	MOVLW      hi_addr(_bcd+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R2+0
	MOVLW      4
	MOVWF      R1+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
L__print_time62:
	BTFSC      STATUS+0, 2
	GOTO       L__print_time63
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__print_time62
L__print_time63:
	MOVF       R0+0, 0
	MOVWF      PORTC+0
	MOVF       _d3+0, 0
	ADDLW      _bcd+0
	MOVWF      R0+0
	MOVLW      hi_addr(_bcd+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R2+0
	MOVLW      4
	MOVWF      R1+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
L__print_time64:
	BTFSC      STATUS+0, 2
	GOTO       L__print_time65
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__print_time64
L__print_time65:
	MOVF       R0+0, 0
	MOVWF      PORTD+0
	MOVF       _d1+0, 0
	ADDLW      _bcd+0
	MOVWF      R0+0
	MOVLW      hi_addr(_bcd+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R1+0
	MOVLW      4
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      R2+0
	MOVF       R0+0, 0
L__print_time66:
	BTFSC      STATUS+0, 2
	GOTO       L__print_time67
	RLF        R2+0, 1
	BCF        R2+0, 0
	ADDLW      255
	GOTO       L__print_time66
L__print_time67:
	MOVF       _d2+0, 0
	ADDLW      _bcd+0
	MOVWF      R0+0
	MOVLW      hi_addr(_bcd+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R0+0
	MOVF       R0+0, 0
	IORWF      R2+0, 0
	MOVWF      PORTB+0
L_end_print_time:
	RETURN
; end of _print_time

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

	BTFSS      TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
	GOTO       L_interrupt15
	BCF        TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
	BSF        TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
	MOVLW      60
	MOVWF      TMR1H+0
	MOVLW      176
	MOVWF      TMR1L+0
	INCF       _CNT+0, 1
	BTFSC      STATUS+0, 2
	INCF       _CNT+1, 1
	MOVLW      0
	XORWF      _CNT+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt70
	MOVLW      50
	XORWF      _CNT+0, 0
L__interrupt70:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt16
	CLRF       _CNT+0
	CLRF       _CNT+1
	MOVF       _SS+0, 0
	SUBLW      0
	BTFSS      STATUS+0, 0
	GOTO       L__interrupt56
	MOVF       _MM+0, 0
	SUBLW      0
	BTFSS      STATUS+0, 0
	GOTO       L__interrupt56
	MOVF       _HH+0, 0
	SUBLW      0
	BTFSS      STATUS+0, 0
	GOTO       L__interrupt56
	GOTO       L_interrupt19
L__interrupt56:
	MOVF       _SS+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt22
	MOVF       _MM+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt22
	MOVF       _HH+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt22
L__interrupt55:
	DECF       _HH+0, 1
	MOVLW      59
	MOVWF      _MM+0
	MOVLW      59
	MOVWF      _SS+0
	GOTO       L_interrupt23
L_interrupt22:
	MOVF       _SS+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt26
	MOVF       _MM+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt26
L__interrupt54:
	DECF       _MM+0, 1
	MOVLW      59
	MOVWF      _SS+0
	GOTO       L_interrupt27
L_interrupt26:
	DECF       _SS+0, 1
L_interrupt27:
L_interrupt23:
L_interrupt19:
	CALL       _print_time+0
L_interrupt16:
L_interrupt15:
L_end_interrupt:
L__interrupt69:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_timer_init:

	BCF        T1CON+0, 5
	BCF        T1CON+0, 4
	BSF        T1CON+0, 3
	BSF        T1CON+0, 2
	BCF        T1CON+0, 1
	BSF        T1CON+0, 0
	MOVLW      60
	MOVWF      TMR1H+0
	MOVLW      176
	MOVWF      TMR1L+0
	CLRF       INTCON+0
	BCF        INTCON+0, 5
	BCF        PIR1+0, 0
	BSF        PIE1+0, 0
	BCF        INTCON+0, 2
	BSF        INTCON+0, 7
	BSF        INTCON+0, 6
	MOVLW      9
	MOVWF      PORTB+0
	MOVLW      144
	MOVWF      PORTC+0
	CLRF       PORTD+0
L_end_timer_init:
	RETURN
; end of _timer_init

_pwm_init:

	BSF        T2CON+0, 0
	BSF        T2CON+0, 1
	MOVLW      78
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
	MOVLW      70
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
L_end_pwm_init:
	RETURN
; end of _pwm_init

_main:

	CLRF       ANSEL+0
	CLRF       ANSELH+0
	BCF        C1ON_bit+0, BitPos(C1ON_bit+0)
	BCF        C2ON_bit+0, BitPos(C2ON_bit+0)
	MOVLW      255
	MOVWF      TRISA+0
	CLRF       TRISB+0
	MOVLW      15
	MOVWF      TRISC+0
	MOVLW      15
	MOVWF      TRISD+0
	CALL       _timer_init+0
L_main28:
	MOVLW      PORTA+0
	MOVWF      FARG_Button_port+0
	MOVLW      1
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main30
	MOVLW      1
	MOVWF      _oldstatem+0
L_main30:
	MOVF       _oldstatem+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main33
	MOVLW      PORTA+0
	MOVWF      FARG_Button_port+0
	MOVLW      1
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	CLRF       FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main33
L__main60:
	MOVF       _MM+0, 0
	XORLW      59
	BTFSS      STATUS+0, 2
	GOTO       L_main34
	CLRF       _MM+0
	INCF       _HH+0, 1
	GOTO       L_main35
L_main34:
	INCF       _MM+0, 1
L_main35:
	CLRF       _oldstatem+0
	MOVLW      1
	MOVWF      _timerstart+0
	CALL       _print_time+0
L_main33:
	MOVF       _SS+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main38
	MOVF       _MM+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main38
	MOVF       _HH+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main38
	MOVF       _timerstart+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main38
L__main59:
	CALL       _pwm_init+0
	CLRF       _i+0
L_main39:
	MOVLW      10
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main40
	CLRF       _j+0
L_main41:
	MOVF       _j+0, 0
	SUBLW      5
	BTFSS      STATUS+0, 0
	GOTO       L_main42
	CALL       _PWM1_Start+0
	MOVLW      147
	MOVWF      R12+0
	MOVLW      25
	MOVWF      R13+0
L_main43:
	DECFSZ     R13+0, 1
	GOTO       L_main43
	DECFSZ     R12+0, 1
	GOTO       L_main43
	CALL       _PWM1_Stop+0
	MOVLW      114
	MOVWF      R12+0
	MOVLW      161
	MOVWF      R13+0
L_main44:
	DECFSZ     R13+0, 1
	GOTO       L_main44
	DECFSZ     R12+0, 1
	GOTO       L_main44
	NOP
	NOP
	INCF       _j+0, 1
	MOVLW      PORTA+0
	MOVWF      FARG_Button_port+0
	MOVLW      1
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main45
	MOVLW      1
	MOVWF      _oldstatem+0
L_main45:
	MOVF       _oldstatem+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main48
	MOVLW      PORTA+0
	MOVWF      FARG_Button_port+0
	MOVLW      1
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	CLRF       FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main48
L__main58:
	MOVLW      6
	MOVWF      _j+0
	MOVLW      11
	MOVWF      _i+0
	CLRF       _oldstatem+0
L_main48:
	GOTO       L_main41
L_main42:
	MOVLW      7
	MOVWF      R11+0
	MOVLW      88
	MOVWF      R12+0
	MOVLW      89
	MOVWF      R13+0
L_main49:
	DECFSZ     R13+0, 1
	GOTO       L_main49
	DECFSZ     R12+0, 1
	GOTO       L_main49
	DECFSZ     R11+0, 1
	GOTO       L_main49
	NOP
	NOP
	MOVLW      PORTA+0
	MOVWF      FARG_Button_port+0
	MOVLW      1
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main50
	MOVLW      1
	MOVWF      _oldstatem+0
L_main50:
	MOVF       _oldstatem+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main53
	MOVLW      PORTA+0
	MOVWF      FARG_Button_port+0
	MOVLW      1
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	CLRF       FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main53
L__main57:
	MOVLW      11
	MOVWF      _i+0
	CLRF       _oldstatem+0
L_main53:
	INCF       _i+0, 1
	GOTO       L_main39
L_main40:
	CLRF       _timerstart+0
	CALL       _timer_init+0
L_main38:
	GOTO       L_main28
L_end_main:
	GOTO       $+0
; end of _main
