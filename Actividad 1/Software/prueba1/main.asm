;=======================================================
;Actividad 1
;30/09/26
;Alumno: Castañón Salazar Alejandro
;Materia: Microcontroladores
;=======================================================

.equ LED_PIN= 5  ; PB5


.org 0x0000
    rjmp start



start:

	sbi PORTD, 2  ; Activa Pull-Up en PD2
	sbi PORTD, 3  ; Activa Pull-Up en PD3
    
    sbi DDRB, LED_PIN  ; Se pone un 1 en el byte 5 de DDRB

    
    cbi DDRD, 2  ; Se pone un 0 en el bit 2 de DDRD
    cbi DDRD, 3  ; Se pone un 0 en el bit 3 de DDRD

 
loop:  ; Bucle principal
    
    in r16, PIND  ; Se le asigna al registro 16 el valor del byte de de DDRD
    ; Se mueven los bits de el registro 16 a la derecha dos veces y se agregan 0 a la izquierda por cada movimiento.
	lsr r16
    lsr r16
    andi r16, 0x03  ; Se aplica un AND lógico para tener un número entre el 0 y el 3 unicamente

    
	; Selección de frecuencia
    cpi r16, 0  ; Comparador
    breq freq_100khz  ; Bifurcador condicional en caso de que sea igual
    cpi r16, 1
    breq freq_500khz
    cpi r16, 2
    breq freq_1mhz
    rjmp freq_2mhz  ;Salto a otro bloque (similar a else)


;=======================================================
;Generador de Frecuencia 100 KHz (Retardo de 80 ciclos)
;=======================================================
freq_100khz:
    ; --- Toggle (Conmutar) el pin del LED ---
    sbi PINB, LED_PIN ; Usar PINB para conmutar el bit
    ldi r17, 26     ; Contador del bucle

delay_100:
    dec r17         
    brne delay_100  
    nop             
    nop             
    rjmp loop

;=======================================================
;Generador de Frecuencia 500 KHz (Retardo de 16 ciclos)
;=======================================================
freq_500khz:
    sbi PINB, LED_PIN
    ldi r17, 5

delay_500:
    dec r17
    brne delay_500
    nop
    rjmp loop

;=======================================================
;Generador de Frecuencia 1 MHz (Retardo de 8 ciclos)
;=======================================================
freq_1mhz:
    sbi PINB, LED_PIN
    ldi r17, 2

delay_1m:
    dec r17
    brne delay_1m
    nop
    nop
    rjmp loop

;=======================================================
;Generador de Frecuencia 2 MHz (Retardo de 4 ciclos)
;=======================================================
freq_2mhz:
    sbi PINB, LED_PIN
    ldi r17, 1

delay_2m:
    dec r17
    brne delay_2m
    nop
    rjmp loop