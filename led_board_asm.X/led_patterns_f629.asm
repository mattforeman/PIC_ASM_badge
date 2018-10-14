;************************************************************************
;
;   Filename:      led_patterns_f629.asm
;   Date:          30 November 2017
;   Revised:       9 December 2017 
;   File Version:  0.2
;
;   Author:       Matt Foreman
;   Company:      _FM - Foreman Machines
;
;************************************************************************
;
;   Processor:     12F629
;
;   Dependencies: none
;
;************************************************************************
;
;   Description:    led sequencing for pic1f629 led card project
;
;   CHANGELOG
;   
;   0.2 - 9 DEC 2017
;	Added basic sequencing
;	TODO: 
;		Button to move through sequences
;		Sequences through tables?
;
;************************************************************************
;
;   Pin assignments:
;       GP0 = CONTROL (led common)
;       GP1 = RED
;       GP2 = GREEN
;       GP4 = BLUE
;       GP5 = YELLLOW
;
;************************************************************************

    list        p=12F629      
    #include    <p12f629.inc>
    
    errorlevel  -302            ; no warnings about registers not in bank 0


;***** CONFIGURATION
                ; ext reset, no code or data protect, no brownout detect,
                ; no watchdog, power-up timer, 4 Mhz int clock
    __CONFIG    _MCLRE_ON & _CP_OFF & _CPD_OFF & _BODEN_OFF & _WDT_OFF & _PWRTE_ON & _INTRC_OSC_NOCLKOUT

;variables
;	W_temp		res 1
;	STATUS_temp	res 1
	d1		equ 20h
	d2		equ 21h
	dl1		equ 22h
 
;	current_step	res 1 ;current step in sequance
	;b'12345678'
 
 
 
;***** RESET VECTOR *****************************************************
RESET   CODE    0x0000          ; processor reset vector
        ; calibrate internal RC oscillator
        call    0x03FF          ; retrieve factory calibration value 
        banksel OSCCAL          ;   (stored at 0x3FF as a retlw k)
        movwf   OSCCAL          ;   then update OSCCAL

	 goto start	
	
	
; ISR VECTOR
;ISR	CODE	0x0004
	;save w and status
;	movwf	W_temp
;	movf STATUS,w
;	movwf STATUS_temp
	
	;ISR CODE HERE
	
	
	
	;restore w and status
;isr_end
;	movf  STATUS_temp,w
;	movwf STATUS
;	swapf W_temp,f
;	swapf W_temp,w
;	retfie ;return

;subroutines
 
random_noise
 
led1    movlw   b'00111100' ; LED1
	banksel TRISIO
        movwf   TRISIO
	movlw   b'00000001'
	banksel GPIO
	movwf   GPIO
	
	
	movlw	.1
	movwf	dl1
led1_d
	decfsz	dl1, f
	goto	led1_d
	clrf	GPIO
	return
	
led2	movlw   b'00111100' ; LED2
	banksel TRISIO
        movwf   TRISIO
	movlw   b'00000010'
	banksel GPIO
	movwf   GPIO
	
	movlw	.1
	movwf	dl1
led2_d
	decfsz	dl1, f
	goto	led2_d
	clrf	GPIO
	return
	
led3	movlw   b'00111010' ; LED3
	banksel TRISIO
        movwf   TRISIO
	movlw   b'00000001'
	banksel GPIO
	movwf   GPIO
	
	movlw	.1
	movwf	dl1
led3_d
	decfsz	dl1, f
	goto	led3_d
	clrf	GPIO
	return
	
led4	movlw   b'00111010' ; LED4
	banksel TRISIO
        movwf   TRISIO
	movlw   b'00000100'
	banksel GPIO
	movwf   GPIO
	
	movlw	.1
	movwf	dl1
led4_d
	decfsz	dl1, f
	goto	led4_d
	clrf	GPIO
	return
	
led5	movlw   b'00101110' ; LED5
	banksel TRISIO
        movwf   TRISIO
	movlw   b'00000001'
	banksel GPIO
	movwf   GPIO
	
	movlw	.1
	movwf	dl1
led5_d
	decfsz	dl1, f
	goto	led5_d
	clrf	GPIO
	return
	
led6	movlw   b'00101110' ; LED6
	banksel TRISIO
        movwf   TRISIO
	movlw   b'00010000'
	banksel GPIO
	movwf   GPIO
	
	movlw	.1
	movwf	dl1
led6_d
	decfsz	dl1, f
	goto	led6_d
	clrf	GPIO
	return
	
led7	movlw   b'00011110' ; LED7
	banksel TRISIO
        movwf   TRISIO
	movlw   b'00000001'
	banksel GPIO
	movwf   GPIO
	
	movlw	.1
	movwf	dl1
led7_d
	decfsz	dl1, f
	goto	led7_d
	clrf	GPIO
	return
	
led8	movlw   b'00011110' ; LED8
	banksel TRISIO
        movwf   TRISIO
	movlw   b'00100000'
	banksel GPIO
	movwf   GPIO
	
	movlw	.1
	movwf	dl1
led8_d
	decfsz	dl1, f
	goto	led8_d
	clrf	GPIO
	return
 
d_250ms	movlw	.79
	movwf	d1
	movlw	.196
	movwf	d2
	return

d_100ms	movlw	.31
	movwf	d1
	movlw	.79
	movwf	d2
	return

d_25ms	movlw	.87
	movwf	d1
	movlw	.14
	movwf	d2
	return
	
d_10ms	movlw	.207
	movwf	d1
	movlw	.8
	movwf	d2
	return

d_1ms	movlw	.199
	movwf	d1
	movlw	.1
	movwf	d2
	return
	
d_start	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	d_start
	return

	
;sequences

SEQ1
	

	call d_10ms	
seq1_1	
	call led1
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq1_1
	
	call d_10ms	
seq1_2	
	call led2
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq1_2
	
	call d_10ms	
seq1_3	
	call led3
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq1_3
	
	call d_10ms	
seq1_4	
	call led4
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq1_4

	call d_10ms
seq1_5	
	call led5
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq1_5
    
	call d_10ms
seq1_6	
	call led6
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq1_6
	
	call d_10ms
seq1_7	
	call led7
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq1_7
	
	
	call d_10ms
seq1_8	
	call led8
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq1_8
	
	return
	
SEQ2
	

	call d_10ms	
seq2_1	
	call led8
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq2_1
	
	call d_10ms	
seq2_2	
	call led7
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq2_2
	
	call d_10ms	
seq2_3	
	call led6
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq2_3
	
	call d_10ms	
seq2_4	
	call led5
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq2_4

	call d_10ms
seq2_5	
	call led4
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq2_5
    
	call d_10ms
seq2_6	
	call led3
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq2_6
	
	call d_10ms
seq2_7	
	call led2
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq2_7
	
	
	call d_10ms
seq2_8	
	call led1
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq2_8
	
	return
	
	
SEQ3
	
    ;4,5
	call d_25ms	
seq3_1	
	call led4
	call led5
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq3_1
	
    ;3,6
	call d_25ms	
seq3_2	
	call led3
	call led6
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq3_2
	
    ;2,7
	call d_25ms	
seq3_3	
	call led2
	call led7
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq3_3
	
    ;1,8
	call d_25ms	
seq3_4	
	call led1
	call led8
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq3_4
    
    ;2,7
	call d_25ms
seq3_5	
	call led2
	call led7
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq3_5
    
    ;3,6
	call d_25ms
seq3_6	
	call led3
	call led6
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq3_6
	
    ;4,5
	call d_25ms
seq3_7	
	call led4
	call led5
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq3_7
	
	return
	
SEQ4
	

	call d_10ms	
seq4_1	
	call led1
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq4_1
	
	call d_10ms	
seq4_2	
	call led1
	call led2
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq4_2
	
	call d_10ms	
seq4_3	
	call led1
	call led2
	call led3
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq4_3
	
	call d_10ms	
seq4_4	
	call led1
	call led2
	call led3
	call led4
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq4_4

	call d_10ms
seq4_5	
	call led1
	call led2
	call led3
	call led4
	call led5
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq4_5
    
	call d_10ms
seq4_6	
	call led1
	call led2
	call led3
	call led4
	call led5
	call led6
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq4_6
	
	call d_10ms
seq4_7	
	call led1
	call led2
	call led3
	call led4
	call led5
	call led6
	call led7
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq4_7
	
	
	call d_10ms
seq4_8	
	call led1
	call led2
	call led3
	call led4
	call led5
	call led6
	call led7
	call led8
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq4_8
	
	return
	
SEQ5
	

	call d_10ms	
seq5_1	
	call led1
	call led2
	call led3
	call led4
	call led5
	call led6
	call led7
	call led8
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq5_1
	
	call d_10ms	
seq5_2	
	call led1
	call led2
	call led3
	call led4
	call led5
	call led6
	call led7
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq5_2
	
	call d_10ms	
seq5_3	
	call led1
	call led2
	call led3
	call led4
	call led5
	call led6	
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq5_3
	
	call d_10ms	
seq5_4	
	call led1
	call led2
	call led3
	call led4
	call led5	
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq5_4

	call d_10ms
seq5_5	
	call led1
	call led2
	call led3
	call led4
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq5_5
    
	call d_10ms
seq5_6	
	call led1
	call led2
	call led3
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq5_6
	
	call d_10ms
seq5_7	
	call led1
	call led2
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq5_7
	
	
	call d_10ms
seq5_8	
	call led1
	
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	seq5_8
	
	return	
	
;***** MAIN PROGRAM *****************************************************

;***** Initialisation
start
        
	call SEQ1
	call d_100ms
	call d_start
	call SEQ2
	call d_100ms
	call d_start
	
	
        ; loop forever		
        goto    start               


        END