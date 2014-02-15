#line 1 "E:/nixie-timer/code/timer_v1.c"
unsigned int CNT=0;
unsigned short HH=0,MM=0,SS=0,d1=0,d2=0,d3=0,d4=0;
unsigned char timerstart=0,i,j;
char oldstates=0,oldstatem=0;
const short bcd[] = {0b0000,0b0001,0b0010,0b0011,0b0100,0b0101,0b0110,0b0111,0b1000,0b1001};

void print_time() {
 if (HH > 0) {
 d1 = HH / 10;
 d2 = HH % 10;
 if (MM==0) {
 d3 = 0;
 d4 = 0;
 } else {
 d3 = MM / 10;
 d4 = MM % 10;
 }
 } else {
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
 Delay_us(20);

 if (d2==9) d2=0;
 else if (d2==0) d2=9;
 if (d4==9) d4=0;
 else if (d4==0) d4=9;

 PORTC=(bcd[d4]<<4);
 PORTD=(bcd[d3]<<4);
 PORTB=(bcd[d1]<<4) | bcd[d2];
}


void interrupt() {

 if (TMR1IF_bit) {
 TMR1IF_bit = 0;
 TMR1IE_bit = 1;
 TMR1H = 60;
 TMR1L = 176;
 CNT++;
 if (CNT==50) {
 CNT=0;
 if ((SS>0)||(MM>0)||(HH>0)) {
 if ((SS==0)&&(MM==0)&&(HH>0)) {
 HH--;
 MM=59;
 SS=59;
 } else if ((SS==0)&&(MM>0)) {
 MM--;
 SS=59;
 } else SS--;
 }
 print_time();
 }
 }
}


void timer_init() {

 T1CON.T1CKPS1 = 0;
 T1CON.T1CKPS0 = 0;
 T1CON.T1OSCEN = 1;
 T1CON.T1SYNC = 1;
 T1CON.TMR1CS = 0;
 T1CON.TMR1ON = 1;
 TMR1H = 60;
 TMR1L = 176;

 INTCON = 0;
 INTCON.TMR0IE = 0;
 PIR1.TMR1IF = 0;
 PIE1.TMR1IE = 1;
 INTCON.TMR0IF = 0;
 INTCON.GIE = 1;
 INTCON.PEIE = 1;

 PORTB = (0b0000<<4) | 0b1001;
 PORTC = (0b1001<<4);
 PORTD = 0x00;
}

void pwm_init() {
 PWM1_Init(2000);
 PWM1_Set_Duty(70);
}

void main(){
 ANSEL = 0;
 ANSELH = 0;
 C1ON_bit = 0;
 C2ON_bit = 0;
 TRISA = 0xFF;
 TRISB = 0x00;
 TRISC = 0b00001111;
 TRISD = 0b00001111;

 timer_init();
 while(1) {
#line 136 "E:/nixie-timer/code/timer_v1.c"
 if (Button(&PORTA, 1, 1, 1))
 oldstatem = 1;
 if (oldstatem && Button(&PORTA, 1, 1, 0)) {
 if (MM==59) {
 MM=0;
 HH++;
 } else MM++;
 oldstatem = 0;
 timerstart = 1;
 print_time();
 }
 if ((SS==0)&&(MM==0)&&(HH==0)&&(timerstart == 1)) {

 pwm_init();
 i=0;

 while (i<10) {
 j=0;
 while (j<=5){
 PWM1_Start();
 Delay_ms(45);
 PWM1_Stop();
 Delay_ms(35);
 j++;
 if (Button(&PORTA, 1, 1, 1))
 oldstatem = 1;
 if (oldstatem && Button(&PORTA, 1, 1, 0)) {
 j=6;
 i=11;
 oldstatem = 0;
 }
 }
 Delay_ms(500);

 if (Button(&PORTA, 1, 1, 1))
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



 }
}
