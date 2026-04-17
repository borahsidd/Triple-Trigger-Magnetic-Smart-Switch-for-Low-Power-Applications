ORG 0000H

; -----------------------------
; Bit Definitions
; -----------------------------
HALL    BIT P1.7
CKT     BIT P3.7

; -----------------------------
; RAM Variables
; -----------------------------
COUNT       DATA 30H
CONDITION   DATA 31H
STATE       DATA 32H     ; 0 = ready, 1 = waiting for release

; -----------------------------
; Initialization
; -----------------------------
START:
    MOV P1, #0FFH
    CLR CKT

    MOV COUNT, #00H
    MOV CONDITION, #00H
    MOV STATE, #00H

; -----------------------------
; Main Loop
; -----------------------------
MAIN:

    ; -------- Detect Falling Edge --------
    JB HALL, CHECK_RELEASE     ; If HIGH ? skip

    ; HALL = LOW
    MOV A, STATE
    JNZ MAIN                   ; Already counted (still LOW)

    ; Valid falling edge
    INC COUNT
    MOV STATE, #01H            ; Mark as pressed

    ACALL DELAY10

    ; -------- Check if 3 pulses --------
    MOV A, COUNT
    CJNE A, #03H, MAIN

    ; ===== Toggle Logic =====
    MOV COUNT, #00H

    MOV A, CONDITION
    JNZ TURN_OFF

TURN_ON:
    SETB CKT
    MOV CONDITION, #01H
    SJMP MAIN

TURN_OFF:
    CLR CKT
    MOV CONDITION, #00H
    SJMP MAIN

; -------- Wait for Release --------
CHECK_RELEASE:
    MOV A, STATE
    JZ MAIN                    ; Already released

    ; Wait until HIGH confirmed
    ACALL DELAY10
    JB HALL, RELEASE_OK
    SJMP MAIN

RELEASE_OK:
    MOV STATE, #00H
    SJMP MAIN

; -----------------------------
; Delay ~10 ms
; -----------------------------
DELAY10:
    MOV R6, #10
D10_LOOP:
    ACALL DELAY1MS
    DJNZ R6, D10_LOOP
    RET

; -----------------------------
; ~1 ms delay (11.0592 MHz)
; -----------------------------
DELAY1MS:
    MOV TMOD, #01H
    MOV TH0, #0FCH
    MOV TL0, #067H
    SETB TR0

WAIT_T0:
    JNB TF0, WAIT_T0
    CLR TR0
    CLR TF0
    RET

END