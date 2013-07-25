unsigned int CNT=0;
unsigned short HH=0,MM=0,SS=0,d1=0,d2=0,d3=0,d4=0;
unsigned char timerstart=0,i,j;
char oldstates=0,oldstatem=0;
const short bcd[] = {0b0000,0b0001,0b0010,0b0011,0b0100,0b0101,0b0110,0b0111,0b1000,0b1001};

void interrupt() {
/* Switched to TMR1 as TMR2 is used by PWM */
  if (TMR1IF_bit) {
    CNT++;                    // Increment counter
    TMR1IF_bit = 0;           // interrupt must be cleared by software
    TMR1IE_bit = 1;           // reenable the interrupt
    TMR1H = 60;               // preset for timer1 MSB register
    TMR1L = 176;              // preset for timer1 LSB register
  }
}

void print_time() {
     if (HH > 0) {            // showing HH:MM
        if (HH==0) {
           d1=0;
           d2=0;
        } else {
          d1 = HH / 10;
          d2 = HH % 10;
        }
        if (MM==0) {
           d3 = 0;
           d4 = 0;
        } else {
           d3 = MM / 10;
           d4 = MM % 10;
        }
      } else {                // showing MM:SS
        if (MM==0) {
           d1 = 0;
           d2 = 0;
        } else {
           d1 = MM / 10;
           d2 = MM % 10;
        }
        if (SS==0) {
           d3 = 0;
           d4 = 0;
        } else {
           d3 = SS / 10;
           d4 = SS % 10;
        }
      }

       PORTB=0xFF;
       PORTC=0xFF;
       PORTD=0xFF;
       delay_us(20);

       if (d2==9) d2=0; // bad wiring 0 and 9 are reversed
       else if (d2==0) d2=9;

       if (d4==9) d4=0; // bad wiring 0 and 9 are reversed
       else if (d4==0) d4=9;
       
       PORTC=(bcd[d4]<<4);
       PORTD=(bcd[d3]<<4);
       PORTB=(bcd[d1]<<4) | bcd[d2];

}

void timer_init() {
//Timer1 Registers Prescaler= 1 - TMR1 Preset = 15536 - Freq = 50.00 Hz - Period = 0.020000 seconds
  T1CON.T1CKPS1 = 0;   // bits 5-4  Prescaler Rate Select bits
  T1CON.T1CKPS0 = 0;   // bit 4
  T1CON.T1OSCEN = 1;   // bit 3 Timer1 Oscillator Enable Control bit 1 = on
  T1CON.T1SYNC = 1;    // bit 2 Timer1 External Clock Input Synchronization Control bit...1 = Do not synchronize external clock input
  T1CON.TMR1CS = 0;    // bit 1 Timer1 Clock Source Select bit...0 = Internal clock (FOSC/4)
  T1CON.TMR1ON = 1;    // bit 0 enables timer
  TMR1H = 60;          // preset for timer1 MSB register
  TMR1L = 176;         // preset for timer1 LSB register
// Interrupt Registers
  INTCON = 0;           // clear the interrpt control register
  INTCON.TMR0IE = 0;        // bit5 TMR0 Overflow Interrupt Enable bit...0 = Disables the TMR0 interrupt
  PIR1.TMR1IF = 0;            // clear timer1 interupt flag TMR1IF
  PIE1.TMR1IE  =   1;         // enable Timer1 interrupts
  INTCON.TMR0IF = 0;        // bit2 clear timer 0 interrupt flag
  INTCON.GIE = 1;           // bit7 global interrupt enable
  INTCON.PEIE = 1;          // bit6 Peripheral Interrupt Enable bit...1 = Enables all unmasked peripheral interrupts
// show 00:00 BAD wiring d2 and d4 have 0 and 9 reversed
  PORTB = (0b0000<<4) | 0b1001;
  PORTC = (0b1001<<4);
  PORTD = 0x00;
}

void pwm_init() {
  PWM1_Init(2000);         // Initialize PWM2 module at 5KHz  // pitch
  PWM1_Set_Duty(70);       // Set current duty for PWM2       // colume
}

void main(){
  ANSEL  = 0;              // Configure AN pins as digital I/O
  ANSELH = 0;
  C1ON_bit = 0;            // Disable comparators
  C2ON_bit = 0;
  TRISA = 0xFF;            // set PORTA to be input
  TRISB = 0x00;            // PORTB is output
  TRISC = 0b00001111;      // PORTC and PORTD are
  TRISD = 0b00001111;      // partially outputs

  timer_init();
  while(1) {                         // Endless loop
// seconds button
   if (Button(&PORTA, 0, 1, 1))                // detect logical one on RA0 pin
      oldstates = 1;
   if (oldstates && Button(&PORTA, 0, 1, 0)) {  // detect one-to-zero transition on RA0 pin
       if ((SS==59)&&(MM==59)) {
          SS=0;
          MM=0;
          HH++;
       } else if (SS==59) {
          SS=0;
          MM++;
       } else SS++;
      oldstates = 0;
      timerstart = 1;
      print_time();
   }
// minutes button
   if (Button(&PORTA, 1, 1, 1))                // detect logical one on RA1 pin
      oldstatem = 1;
   if (oldstatem && Button(&PORTA, 1, 1, 0)) {  // detect one-to-zero transition on RA1 pin
       if (MM==59) {
          MM=0;
          HH++;
       } else MM++;
      oldstatem = 0;
      timerstart = 1;
      print_time();
   }
   if (CNT>=50) { // CNT increases every 0.02s
      CNT=0;
      if ((SS==0)&&(MM==0)&&(HH==0)) {
         if (timerstart == 1) {
          // timer reached 0, sound the alarm
             pwm_init();
             i=0;
             while (i<10) {
              j=0;
              while (j<=5){
                  PWM1_Start();                       // start PWM2
                  delay_ms(45);                       // buzz length
                  PWM1_Stop();
                  delay_ms(35);                       // silence length
                  j++;
                  if (Button(&PORTA, 1, 1, 1))                // detect logical one on RA1 pin
                     oldstatem = 1;
                  if (oldstatem && Button(&PORTA, 1, 1, 0)) {
                     j=6;
                     i=11;
                     oldstatem = 0;
                  }
              }
              delay_ms(500);
              if (Button(&PORTA, 1, 1, 1))                // detect logical one on RA1 pin
                 oldstatem = 1;
              if (oldstatem && Button(&PORTA, 1, 1, 0)) {
                 i=11;
                 oldstatem = 0;
              }
              i++;
             }
             timerstart = 0;
             timer_init();
         }
      } else if ((SS==0)&&(MM==0)&&(HH>0)) {
         HH--;
         MM=59;
         SS=59;
      } else if ((SS==0)&&(MM>0)) {
         MM--;
         SS=59;
      } else SS--;
      print_time();
   }
  }
}
