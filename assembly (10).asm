; IODemo.asm
; Produces a "bouncing" animation on the LEDs.
; The LED pattern is initialized with the switch state.
; Only process when at most two switches are turned on at the sametime.
; WenKai Chen
; ECE 2031
; 07/03/2025

ORG 0

; Increasing brightness from 0 to 100%
Wave1:
	load Brightness
    addi -10
    JZERO Wave2
    load Brightness
    addi 1
    Store Brightness
    
    
    in Switches
    store Pattern
    load Brightness
    shift 10
    add Pattern
    out LEDs
    
    call Delay
    
    Jump Wave1
    
; Decreasing brightness from 100 to 0%
Wave2:
	
	load Brightness
    JZERO Wave1
    addi -1
    store Brightness
    
    in Switches
    store Pattern
    load Brightness
    shift 10
    add Pattern
    out LEDs
    
    call Delay
    
    jump Wave2


; Delay
Delay:
	OUT    Timer
	WaitingLoop:
	IN     Timer
	ADDI   -10
	JNEG   WaitingLoop
	RETURN
    
    

; Useful values
Pattern:	   DW &B0000000000
Brightness:   DW &B0000
Bit0:      DW &B0000000001
Bit9:      DW &B1000000000

; IO address constants
Switches:  EQU 000
LEDs:      EQU 001
Timer:     EQU 002
Hex0:      EQU 004
Hex1:      EQU 005