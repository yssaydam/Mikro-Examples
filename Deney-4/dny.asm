list p=16F877A
INCLUDE<P16F877.INC>
__config H'3F31'

	ORG		0X000
	GOTO	SETUP
	ORG		0X004
	GOTO 	INTERRUPT

COUNTER		EQU	0X22
COUNTER2	EQU	0X23

INTERRUPT

	BCF		PIR1,ADIF
	RLF		ADRESH
	RLF		ADRESH,W
;	MOVF	ADRESH,W
	MOVWF	PORTB
;	CALL	DELAY
	BSF		ADCON0,2 ;GO/DONE
RETFIE	

SETUP

	BANKSEL	INTCON
	BSF		INTCON,GIE
	BSF		INTCON,PEIE
;	BCF		PIR1,ADIF

	BANKSEL	PIE1
	BSF		PIE1,ADIE

	BANKSEL	ADCON0
	MOVLW	B'11000101'
	MOVWF	ADCON0

	BANKSEL	ADCON1
	MOVLW	B'01000000'
	MOVWF	ADCON1

	BANKSEL	TRISE
	BSF		TRISE,0
	CLRF	TRISB

	BANKSEL	PORTE
	CLRF	PORTB
;	CLRF	PORTE

LOOP
	
	GOTO	LOOP

DELAY

	MOVLW	0XF0
	MOVWF	COUNTER

D1

	MOVLW	0XF0
	MOVWF	COUNTER2

D2
	
	DECFSZ	COUNTER2
	GOTO	D2
	DECFSZ	COUNTER
	GOTO	D1
RETURN

END