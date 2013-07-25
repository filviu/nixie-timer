
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;timer_v1.c,7 :: 		void interrupt() {
;timer_v1.c,9 :: 		if (TMR1IF_bit) {
	BTFSS      TMR1IF_bit+0, 0
	GOTO       L_interrupt0
;timer_v1.c,10 :: 		CNT++;                    // Increment counter
	INCF       _CNT+0, 1
	BTFSC      STATUS+0, 2
	INCF       _CNT+1, 1
;timer_v1.c,11 :: 		TMR1IF_bit = 0;           // interrupt must be cleared by software
	BCF        TMR1IF_bit+0, 0
;timer_v1.c,12 :: 		TMR1IE_bit = 1;           // reenable the interrupt
	BSF        TMR1IE_bit+0, 0
;timer_v1.c,13 :: 		TMR1H = 60;               // preset for timer1 MSB register
	MOVLW      60
	MOVWF      TMR1H+0
;timer_v1.c,14 :: 		TMR1L = 176;               // preset for timer1 LSB register
	MOVLW      176
	MOVWF      TMR1L+0
;timer_v1.c,15 :: 		}
L_interrupt0:
;timer_v1.c,16 :: 		}
L__interrupt73:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_print_time:

;timer_v1.c,18 :: 		void print_time() {
;timer_v1.c,19 :: 		if (HH > 0) {            // showing HH:MM
	MOVF       _HH+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_print_time1
;timer_v1.c,20 :: 		if (HH==0) {
	MOVF       _HH+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_print_time2
;timer_v1.c,21 :: 		d1=0;
	CLRF       _d1+0
;timer_v1.c,22 :: 		d2=0;
	CLRF       _d2+0
;timer_v1.c,23 :: 		} else {
	GOTO       L_print_time3
L_print_time2:
;timer_v1.c,24 :: 		d1 = HH / 10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _HH+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      _d1+0
;timer_v1.c,25 :: 		d2 = HH % 10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _HH+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _d2+0
;timer_v1.c,26 :: 		}
L_print_time3:
;timer_v1.c,27 :: 		if (MM==0) {
	MOVF       _MM+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_print_time4
;timer_v1.c,28 :: 		d3 = 0;
	CLRF       _d3+0
;timer_v1.c,29 :: 		d4 = 0;
	CLRF       _d4+0
;timer_v1.c,30 :: 		} else {
	GOTO       L_print_time5
L_print_time4:
;timer_v1.c,31 :: 		d3 = MM / 10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _MM+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      _d3+0
;timer_v1.c,32 :: 		d4 = MM % 10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _MM+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _d4+0
;timer_v1.c,33 :: 		}
L_print_time5:
;timer_v1.c,34 :: 		} else {                // showing MM:SS
	GOTO       L_print_time6
L_print_time1:
;timer_v1.c,35 :: 		if (MM==0) {
	MOVF       _MM+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_print_time7
;timer_v1.c,36 :: 		d1 = 0;
	CLRF       _d1+0
;timer_v1.c,37 :: 		d2 = 0;
	CLRF       _d2+0
;timer_v1.c,38 :: 		} else {
	GOTO       L_print_time8
L_print_time7:
;timer_v1.c,39 :: 		d1 = MM / 10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _MM+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      _d1+0
;timer_v1.c,40 :: 		d2 = MM % 10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _MM+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _d2+0
;timer_v1.c,41 :: 		}
L_print_time8:
;timer_v1.c,42 :: 		if (SS==0) {
	MOVF       _SS+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_print_time9
;timer_v1.c,43 :: 		d3 = 0;
	CLRF       _d3+0
;timer_v1.c,44 :: 		d4 = 0;
	CLRF       _d4+0
;timer_v1.c,45 :: 		} else {
	GOTO       L_print_time10
L_print_time9:
;timer_v1.c,46 :: 		d3 = SS / 10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _SS+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R0+0, 0
	MOVWF      _d3+0
;timer_v1.c,47 :: 		d4 = SS % 10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _SS+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _d4+0
;timer_v1.c,48 :: 		}
L_print_time10:
;timer_v1.c,49 :: 		}
L_print_time6:
;timer_v1.c,51 :: 		PORTB=0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;timer_v1.c,52 :: 		PORTC=0xFF;
	MOVLW      255
	MOVWF      PORTC+0
;timer_v1.c,53 :: 		PORTD=0xFF;
	MOVLW      255
	MOVWF      PORTD+0
;timer_v1.c,54 :: 		delay_us(20);
	MOVLW      16
	MOVWF      R13+0
L_print_time11:
	DECFSZ     R13+0, 1
	GOTO       L_print_time11
	NOP
;timer_v1.c,56 :: 		if (d2==9) d2=0; // bad wiring 0 and 9 are reversed
	MOVF       _d2+0, 0
	XORLW      9
	BTFSS      STATUS+0, 2
	GOTO       L_print_time12
	CLRF       _d2+0
	GOTO       L_print_time13
L_print_time12:
;timer_v1.c,57 :: 		else if (d2==0) d2=9;
	MOVF       _d2+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_print_time14
	MOVLW      9
	MOVWF      _d2+0
L_print_time14:
L_print_time13:
;timer_v1.c,59 :: 		if (d4==9) d4=0; // bad wiring 0 and 9 are reversed
	MOVF       _d4+0, 0
	XORLW      9
	BTFSS      STATUS+0, 2
	GOTO       L_print_time15
	CLRF       _d4+0
	GOTO       L_print_time16
L_print_time15:
;timer_v1.c,60 :: 		else if (d4==0) d4=9;
	MOVF       _d4+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_print_time17
	MOVLW      9
	MOVWF      _d4+0
L_print_time17:
L_print_time16:
;timer_v1.c,62 :: 		PORTC=(bcd[d4]<<4);
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
L__print_time74:
	BTFSC      STATUS+0, 2
	GOTO       L__print_time75
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__print_time74
L__print_time75:
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;timer_v1.c,63 :: 		PORTD=(bcd[d3]<<4);
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
L__print_time76:
	BTFSC      STATUS+0, 2
	GOTO       L__print_time77
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__print_time76
L__print_time77:
	MOVF       R0+0, 0
	MOVWF      PORTD+0
;timer_v1.c,64 :: 		PORTB=(bcd[d1]<<4) | bcd[d2];
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
L__print_time78:
	BTFSC      STATUS+0, 2
	GOTO       L__print_time79
	RLF        R2+0, 1
	BCF        R2+0, 0
	ADDLW      255
	GOTO       L__print_time78
L__print_time79:
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
;timer_v1.c,66 :: 		}
	RETURN
; end of _print_time

_timer_init:

;timer_v1.c,68 :: 		void timer_init() {
;timer_v1.c,70 :: 		T1CON.T1CKPS1 = 0;   // bits 5-4  Prescaler Rate Select bits
	BCF        T1CON+0, 5
;timer_v1.c,71 :: 		T1CON.T1CKPS0 = 0;   // bit 4
	BCF        T1CON+0, 4
;timer_v1.c,72 :: 		T1CON.T1OSCEN = 1;   // bit 3 Timer1 Oscillator Enable Control bit 1 = on
	BSF        T1CON+0, 3
;timer_v1.c,73 :: 		T1CON.T1SYNC = 1;    // bit 2 Timer1 External Clock Input Synchronization Control bit...1 = Do not synchronize external clock input
	BSF        T1CON+0, 2
;timer_v1.c,74 :: 		T1CON.TMR1CS = 0;    // bit 1 Timer1 Clock Source Select bit...0 = Internal clock (FOSC/4)
	BCF        T1CON+0, 1
;timer_v1.c,75 :: 		T1CON.TMR1ON = 1;    // bit 0 enables timer
	BSF        T1CON+0, 0
;timer_v1.c,76 :: 		TMR1H = 60;          // preset for timer1 MSB register
	MOVLW      60
	MOVWF      TMR1H+0
;timer_v1.c,77 :: 		TMR1L = 176;         // preset for timer1 LSB register
	MOVLW      176
	MOVWF      TMR1L+0
;timer_v1.c,79 :: 		INTCON = 0;           // clear the interrpt control register
	CLRF       INTCON+0
;timer_v1.c,80 :: 		INTCON.TMR0IE = 0;        // bit5 TMR0 Overflow Interrupt Enable bit...0 = Disables the TMR0 interrupt
	BCF        INTCON+0, 5
;timer_v1.c,81 :: 		PIR1.TMR1IF = 0;            // clear timer1 interupt flag TMR1IF
	BCF        PIR1+0, 0
;timer_v1.c,82 :: 		PIE1.TMR1IE  =   1;         // enable Timer1 interrupts
	BSF        PIE1+0, 0
;timer_v1.c,83 :: 		INTCON.TMR0IF = 0;        // bit2 clear timer 0 interrupt flag
	BCF        INTCON+0, 2
;timer_v1.c,84 :: 		INTCON.GIE = 1;           // bit7 global interrupt enable
	BSF        INTCON+0, 7
;timer_v1.c,85 :: 		INTCON.PEIE = 1;          // bit6 Peripheral Interrupt Enable bit...1 = Enables all unmasked peripheral interrupts
	BSF        INTCON+0, 6
;timer_v1.c,87 :: 		PORTB = (0b0000<<4) | 0b1001;
	MOVLW      9
	MOVWF      PORTB+0
;timer_v1.c,88 :: 		PORTC = (0b1001<<4);
	MOVLW      144
	MOVWF      PORTC+0
;timer_v1.c,89 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;timer_v1.c,90 :: 		}
	RETURN
; end of _timer_init

_pwm_init:

;timer_v1.c,92 :: 		void pwm_init() {
;timer_v1.c,93 :: 		PWM1_Init(2000);         // Initialize PWM2 module at 5KHz  // pitch
	BSF        T2CON+0, 0
	BSF        T2CON+0, 1
	MOVLW      78
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;timer_v1.c,94 :: 		PWM1_Set_Duty(70);       // Set current duty for PWM2       // colume
	MOVLW      70
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;timer_v1.c,95 :: 		}
	RETURN
; end of _pwm_init

_main:

;timer_v1.c,97 :: 		void main(){
;timer_v1.c,98 :: 		ANSEL  = 0;              // Configure AN pins as digital I/O
	CLRF       ANSEL+0
;timer_v1.c,99 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;timer_v1.c,100 :: 		C1ON_bit = 0;            // Disable comparators
	BCF        C1ON_bit+0, 7
;timer_v1.c,101 :: 		C2ON_bit = 0;
	BCF        C2ON_bit+0, 7
;timer_v1.c,102 :: 		TRISA = 0xFF;            // set PORTA to be input
	MOVLW      255
	MOVWF      TRISA+0
;timer_v1.c,103 :: 		TRISB = 0x00;            // PORTB is output
	CLRF       TRISB+0
;timer_v1.c,104 :: 		TRISC = 0b00001111;      // PORTC and PORTD are
	MOVLW      15
	MOVWF      TRISC+0
;timer_v1.c,105 :: 		TRISD = 0b00001111;      // partially outputs
	MOVLW      15
	MOVWF      TRISD+0
;timer_v1.c,107 :: 		timer_init();
	CALL       _timer_init+0
;timer_v1.c,108 :: 		while(1) {                         // Endless loop
L_main18:
;timer_v1.c,110 :: 		if (Button(&PORTA, 0, 1, 1))                // detect logical one on RA0 pin
	MOVLW      PORTA+0
	MOVWF      FARG_Button_port+0
	CLRF       FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main20
;timer_v1.c,111 :: 		oldstates = 1;
	MOVLW      1
	MOVWF      _oldstates+0
L_main20:
;timer_v1.c,112 :: 		if (oldstates && Button(&PORTA, 0, 1, 0)) {  // detect one-to-zero transition on RA0 pin
	MOVF       _oldstates+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main23
	MOVLW      PORTA+0
	MOVWF      FARG_Button_port+0
	CLRF       FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	CLRF       FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main23
L__main72:
;timer_v1.c,113 :: 		if ((SS==59)&&(MM==59)) {
	MOVF       _SS+0, 0
	XORLW      59
	BTFSS      STATUS+0, 2
	GOTO       L_main26
	MOVF       _MM+0, 0
	XORLW      59
	BTFSS      STATUS+0, 2
	GOTO       L_main26
L__main71:
;timer_v1.c,114 :: 		SS=0;
	CLRF       _SS+0
;timer_v1.c,115 :: 		MM=0;
	CLRF       _MM+0
;timer_v1.c,116 :: 		HH++;
	INCF       _HH+0, 1
;timer_v1.c,117 :: 		} else if (SS==59) {
	GOTO       L_main27
L_main26:
	MOVF       _SS+0, 0
	XORLW      59
	BTFSS      STATUS+0, 2
	GOTO       L_main28
;timer_v1.c,118 :: 		SS=0;
	CLRF       _SS+0
;timer_v1.c,119 :: 		MM++;
	INCF       _MM+0, 1
;timer_v1.c,120 :: 		} else SS++;
	GOTO       L_main29
L_main28:
	INCF       _SS+0, 1
L_main29:
L_main27:
;timer_v1.c,121 :: 		oldstates = 0;
	CLRF       _oldstates+0
;timer_v1.c,122 :: 		timerstart = 1;
	MOVLW      1
	MOVWF      _timerstart+0
;timer_v1.c,123 :: 		print_time();
	CALL       _print_time+0
;timer_v1.c,124 :: 		}
L_main23:
;timer_v1.c,126 :: 		if (Button(&PORTA, 1, 1, 1))                // detect logical one on RA1 pin
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
;timer_v1.c,127 :: 		oldstatem = 1;
	MOVLW      1
	MOVWF      _oldstatem+0
L_main30:
;timer_v1.c,128 :: 		if (oldstatem && Button(&PORTA, 1, 1, 0)) {  // detect one-to-zero transition on RA1 pin
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
L__main70:
;timer_v1.c,129 :: 		if (MM==59) {
	MOVF       _MM+0, 0
	XORLW      59
	BTFSS      STATUS+0, 2
	GOTO       L_main34
;timer_v1.c,130 :: 		MM=0;
	CLRF       _MM+0
;timer_v1.c,131 :: 		HH++;
	INCF       _HH+0, 1
;timer_v1.c,132 :: 		} else MM++;
	GOTO       L_main35
L_main34:
	INCF       _MM+0, 1
L_main35:
;timer_v1.c,133 :: 		oldstatem = 0;
	CLRF       _oldstatem+0
;timer_v1.c,134 :: 		timerstart = 1;
	MOVLW      1
	MOVWF      _timerstart+0
;timer_v1.c,135 :: 		print_time();
	CALL       _print_time+0
;timer_v1.c,136 :: 		}
L_main33:
;timer_v1.c,137 :: 		if (CNT>=50) { // CNT increases every 0.02s
	MOVLW      0
	SUBWF      _CNT+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main80
	MOVLW      50
	SUBWF      _CNT+0, 0
L__main80:
	BTFSS      STATUS+0, 0
	GOTO       L_main36
;timer_v1.c,138 :: 		CNT=0;
	CLRF       _CNT+0
	CLRF       _CNT+1
;timer_v1.c,139 :: 		if ((SS==0)&&(MM==0)&&(HH==0)) {
	MOVF       _SS+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main39
	MOVF       _MM+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main39
	MOVF       _HH+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main39
L__main69:
;timer_v1.c,140 :: 		if (timerstart == 1) {
	MOVF       _timerstart+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main40
;timer_v1.c,142 :: 		pwm_init();
	CALL       _pwm_init+0
;timer_v1.c,143 :: 		i=0;
	CLRF       _i+0
;timer_v1.c,144 :: 		while (i<10) {
L_main41:
	MOVLW      10
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main42
;timer_v1.c,145 :: 		j=0;
	CLRF       _j+0
;timer_v1.c,146 :: 		while (j<=5){
L_main43:
	MOVF       _j+0, 0
	SUBLW      5
	BTFSS      STATUS+0, 0
	GOTO       L_main44
;timer_v1.c,147 :: 		PWM1_Start();                       // start PWM2
	CALL       _PWM1_Start+0
;timer_v1.c,148 :: 		delay_ms(45);                       // buzz length
	MOVLW      147
	MOVWF      R12+0
	MOVLW      25
	MOVWF      R13+0
L_main45:
	DECFSZ     R13+0, 1
	GOTO       L_main45
	DECFSZ     R12+0, 1
	GOTO       L_main45
;timer_v1.c,149 :: 		PWM1_Stop();
	CALL       _PWM1_Stop+0
;timer_v1.c,150 :: 		delay_ms(35);                       // silence length
	MOVLW      114
	MOVWF      R12+0
	MOVLW      161
	MOVWF      R13+0
L_main46:
	DECFSZ     R13+0, 1
	GOTO       L_main46
	DECFSZ     R12+0, 1
	GOTO       L_main46
	NOP
	NOP
;timer_v1.c,151 :: 		j++;
	INCF       _j+0, 1
;timer_v1.c,152 :: 		if (Button(&PORTA, 1, 1, 1))                // detect logical one on RA1 pin
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
	GOTO       L_main47
;timer_v1.c,153 :: 		oldstatem = 1;
	MOVLW      1
	MOVWF      _oldstatem+0
L_main47:
;timer_v1.c,154 :: 		if (oldstatem && Button(&PORTA, 1, 1, 0)) {
	MOVF       _oldstatem+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main50
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
	GOTO       L_main50
L__main68:
;timer_v1.c,155 :: 		j=6;
	MOVLW      6
	MOVWF      _j+0
;timer_v1.c,156 :: 		i=11;
	MOVLW      11
	MOVWF      _i+0
;timer_v1.c,157 :: 		oldstatem = 0;
	CLRF       _oldstatem+0
;timer_v1.c,158 :: 		}
L_main50:
;timer_v1.c,159 :: 		}
	GOTO       L_main43
L_main44:
;timer_v1.c,160 :: 		delay_ms(500);
	MOVLW      7
	MOVWF      R11+0
	MOVLW      88
	MOVWF      R12+0
	MOVLW      89
	MOVWF      R13+0
L_main51:
	DECFSZ     R13+0, 1
	GOTO       L_main51
	DECFSZ     R12+0, 1
	GOTO       L_main51
	DECFSZ     R11+0, 1
	GOTO       L_main51
	NOP
	NOP
;timer_v1.c,161 :: 		if (Button(&PORTA, 1, 1, 1))                // detect logical one on RA1 pin
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
	GOTO       L_main52
;timer_v1.c,162 :: 		oldstatem = 1;
	MOVLW      1
	MOVWF      _oldstatem+0
L_main52:
;timer_v1.c,163 :: 		if (oldstatem && Button(&PORTA, 1, 1, 0)) {
	MOVF       _oldstatem+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main55
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
	GOTO       L_main55
L__main67:
;timer_v1.c,164 :: 		i=11;
	MOVLW      11
	MOVWF      _i+0
;timer_v1.c,165 :: 		oldstatem = 0;
	CLRF       _oldstatem+0
;timer_v1.c,166 :: 		}
L_main55:
;timer_v1.c,167 :: 		i++;
	INCF       _i+0, 1
;timer_v1.c,168 :: 		}
	GOTO       L_main41
L_main42:
;timer_v1.c,169 :: 		timerstart = 0;
	CLRF       _timerstart+0
;timer_v1.c,170 :: 		timer_init();
	CALL       _timer_init+0
;timer_v1.c,171 :: 		}
L_main40:
;timer_v1.c,172 :: 		} else if ((SS==0)&&(MM==0)&&(HH>0)) {
	GOTO       L_main56
L_main39:
	MOVF       _SS+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main59
	MOVF       _MM+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main59
	MOVF       _HH+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_main59
L__main66:
;timer_v1.c,173 :: 		HH--;
	DECF       _HH+0, 1
;timer_v1.c,174 :: 		MM=59;
	MOVLW      59
	MOVWF      _MM+0
;timer_v1.c,175 :: 		SS=59;
	MOVLW      59
	MOVWF      _SS+0
;timer_v1.c,176 :: 		} else if ((SS==0)&&(MM>0)) {
	GOTO       L_main60
L_main59:
	MOVF       _SS+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main63
	MOVF       _MM+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_main63
L__main65:
;timer_v1.c,177 :: 		MM--;
	DECF       _MM+0, 1
;timer_v1.c,178 :: 		SS=59;
	MOVLW      59
	MOVWF      _SS+0
;timer_v1.c,179 :: 		} else SS--;
	GOTO       L_main64
L_main63:
	DECF       _SS+0, 1
L_main64:
L_main60:
L_main56:
;timer_v1.c,180 :: 		print_time();
	CALL       _print_time+0
;timer_v1.c,181 :: 		}
L_main36:
;timer_v1.c,182 :: 		}
	GOTO       L_main18
;timer_v1.c,183 :: 		}
	GOTO       $+0
; end of _main
