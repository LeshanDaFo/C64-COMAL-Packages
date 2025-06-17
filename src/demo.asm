; 
; EXAMPLE PACKAGES FOR COMAL 2.0
; 
; BY JESSE KNIGHT
; 
; ADD + STRING$ FROM UNICOMAL (WITH CHANGES)
; 
; 1/29/85
; 
; from CMAL-Disk 'Pack2'
start   =   $8009

    !source "c64symb.asm"

; .OPT LIST
; 
*= start
    !by DEFPAG                  ; MEMORY MAP
    !word END                   ; END OF PACKAGE
    !word signal                ; SENSE ROUTINE
; 
; TABLE OF PACKAGES
; 
    !pet $04,"demo"             ; NAME IS DEMO
    !word ptDemo                ; DEMO PROCEDURE TABLE
    !word init_Demo             ; DEMO INIT ROUTINE
; 
    !pet $06,"locate"           ; NAME IS LOCATE
    !word ptLocate              ; LOCATE PROCEDURE TABLE
    !word init_Locate           ; LOCATE INIT ROUTINE
; 
    !by $00                     ; END OF TABLE
; 
; SET BORDER COLOR TO FLAG
; SENT TO SENSE ROUTINE
; FOR VISIBLE EFFECT
; 
signal
    STY BORCOL
    RTS
; 
; FLASH BORDER COLOR
; IN DEMO INIT ROUTINE FOR
; VISIBLE EFFECT
; 
init_Demo
    LDX #16                     ; 16 TIMES
    LDY #0                      ; 256 TIMES
FLASH
    INC BORCOL
    DEX
    BNE FLASH
    DEY
    BNE FLASH
    RTS
; 
; PROCEDURE TABLE FOR DEMO
; 
ptDemo
    !pet $03,"add"              ; FUNCTION ADD
    !word FADD                  ; DESCRIPTOR POINTER
    !pet $06,"string"           ; FUNCTION STRING
    !word FSTRNG
    !pet $0c,"convert'case"     ; PROC CONVERT'CASE
    !word PCASE
    !pet $00                    ; END OF TABLE
; 
; FUNC ADD#(A#,B#)
; 
FADD
    !by FUNC+INT                ; INTEGER FUNC
    !word ADD                   ; POINT TO CODE
    !by $02                     ; 2 PARAMETERS
    !by PARAM+INT
    !by PARAM+INT               ; BOTH INTEGER
    !by ENDFNC                  ; END FUNC
; 
; FUNC STRING$(A$,N)
; 
FSTRNG
    !by FUNC+STR                ; STRING FUNC
    !word STRING                ; POINT TO CODE
    !by $02                     ; 2 PARAMETERS
    !by PARAM+STR               ; FIRST IS STRING
    !by PARAM+INT               ; SECOND IS INTEGER
    !by ENDFNC                  ; END FUNC
; 
; PROC CONVERT'CASE(REF A$,B)
; 
PCASE
    !by PROC                    ; PROCEDURE
    !word CVCASE                ; POINT TO CODE
    !by $02                     ; 2 PARAMETERS
    !by REF+STR                 ; FIRST IS REF STRING
    !by PARAM+INT               ; SECOND IS INTEGER
    !by ENDPRC                  ; END PROC
; 
; 
; FUNC ADD#(A#,B#)
; RETURN A#+B#
; ENDFUNC ADD#
; 
ADD
    LDA #$01
    JSR FNDPAR                  ; FIND PARAM 1
; 
    LDX COPY1                   ; MOVE COPY1 TO COPY2
    STX COPY2
    LDX COPY1+1
    STX COPY2+1
; 
    LDA #$02
    JSR FNDPAR                  ; FIND PARAM 2
; 
    LDY #$01                    ; GET READY TO ADD
    CLC
    LDA (COPY1),Y               ; ADD LO BYTES
    ADC (COPY2),Y
    TAX                         ; SAVE IN .X
    DEY
    LDA (COPY1),Y               ; ADD HI BYTES
    ADC (COPY2),Y
    BVS OVRERR                  ; OVERFLOW ERROR
; 
    JMP PSHINT                  ; INT IN .A/.X TO REAL, PUSH, AND RETURN
; 
OVRERR
    LDX #$02                    ; REPORT "OVERFLOW"
    JMP RUNERR
; 
; FUNC STRING$(A$,N#)
;  IF N#<0 THEN REPORT 1 //ARGUMENT ERROR
;  IF LEN(A$)<>1 THEN REPORT 1,"STRING LENGTH ..."
;  DIM R$ OF N#
;  FOR X#=1 TO N# DO
;   R$:+A$
;  ENDFOR X#
;  RETURN R$
; ENDFUNC STRING$
; 
STRING
    LDA #$02
    JSR FNDPAR                  ; FIND PARAM 2
    LDY #$00
    LDA (COPY1),Y               ; HI BYTE
    BMI ARGERR                  ; NEGATIVE
    STA NUMBER+1                ; SAVE IT
    INY
    LDA (COPY1),Y               ; LO BYTE
    STA NUMBER                  ; SAVE IT
; 
; MAKE ROOM FOR RESULT ON EVALUATION STACK
; REPORT "CANNOT ASSIGN VARIABLE" IF NO ROOM
; 
    CLC
    ADC STOS                    ; TOP OF STACK
    TAX                         ; SAVE IN .X
    LDA NUMBER+1                ; HI BYTE
    ADC STOS+1
    BCS STERR                   ; OUT OF MEMORY ERROR
    TAY                         ; SAVE IN .X
    TXA
    ADC #$02                    ; 2 BYTES FOR LENGTH
    TAX
    TYA
    ADC #$00                    ; ADD CARRY
    BCS STERR                   ; ERROR
; 
    CPX SFREE                   ; TEST IF ROOM
    SBC SFREE+1
    BCS STERR                   ; NOT ENOUGH ROOM
; 
; TEST A$
; 
    LDA #$01
    JSR FNDPAR                  ; FIND IT
    LDY #$02                    ; TEST CURRENT LENGTH
    LDA (COPY1),Y               ; HI BYTE
    BNE LNGERR                  ; >=256 - LONG STRING ERROR
    INY
    LDA (COPY1),Y               ; LO BYTE
    CMP #$01
    BNE LNGERR                  ; NOT =1 -LONG STRING ERROR
; 
    INY                         ; .Y=4
    LDA (COPY1),Y               ; CONTENTS OF A$
    LDY #$00
    STY Q1                      ; Q1=0
    STY Q1+1
; 
STR1
    LDX NUMBER+1                ; TEST FOR END OF LOOP
    CPX Q1+1
    BNE STR2                    ; NOT YET
    LDX NUMBER
    CPX Q1
    BEQ STR4                    ; END OF LOOP
; 
STR2
    STA (STOS),Y                ; PUT ON STACK
    INC STOS                    ; INC POINTER
    BNE STR3
    INC STOS+1
; 
STR3
    INC Q1
    BNE STR1                    ; MORE TO DO
    INC Q1+1
    BNE STR1                    ; (JMP)
; 
STR4
    LDA NUMBER+1                ; PUT LENGTH ON STACK
    STA (STOS),Y                ; HI BYTE
    INY
    LDA NUMBER
    STA (STOS),Y
; 
    CLC                         ; STOS:+2 FOR LENGTH
    LDA STOS
    ADC #$02
    STA STOS
    BCC STR5
    INC STOS+1
STR5
    RTS                         ; IT'S DONE
; 
ARGERR
    LDX #$01                    ; ARGUMENT ERROR
    !by $2C                     ; SKIP 2
STERR
    LDX #$38                    ; CANNOT ASSIGN VARIABLE #56
    JMP RUNERR
; 
; SPECIAL ERROR REPORTER FOR STRING$
; 
; REPORTS ERROR NUMBER 1 FOR ARGUMENT ERROR
; BUT GIVES MORE SPECIFIC MESSAGE
; "STRING LENGTH OF 1 EXPECTED"
; 
; ERRFILE IS SET TO 0 SINCE ERROR NOT FROM FILE
; 
; ERROR NUMBER MUST BE IN RANGE 0 .. 65535
; 
; TEXT FOR ERROR MUST BE <80 CHARACTERS
; 
LNGERR
    LDY #TXTLEN                 ; LENGTH OF TEXT
    STY ERTLEN                  ; SET LENGTH FOR SYSTEM
XFRTXT
    LDA ERRMSG-1,Y              ; MOVE TEXT TO ERTEXT
    STA ERTEXT-1,Y
    DEY
    BNE XFRTXT
; 
    LDA #$6C                    ; STORE JMP (TRAPVC) IN AC1
    LDX #<TRAPVC
    LDY #>TRAPVC
    STA AC1
    STX AC1+1
    STY AC1+2
; 
    LDY #$00                    ; ERRFILE = 0
    LDX #$01                    ; LO BYTE OF ERR #
    LDA #$00                    ; HI BYTE OF ERR #
; 
; NOW EXECUTE JMP (TRAPCV) IN PAGE B
; 
    JSR GOTO                    ; USING GOTO
    !by PAGEB                   ; PAGE B
    !word AC1                   ; JMP (TRAPVC) AT AC1
; 
; TEXT FOR ERROR MESSAGE
; 
ERRMSG
    !pet "STRING LENGTH OF 1 EXPECTED"
TXTLEN =*-ERRMSG
; 
; 
; PROC CONVERT'CASE (REF A$,B)
;  IF B<0 OR B>1 THEN REPORT 2 //ARGUMENT ERROR
;  IF LEN(A$)>0 THEN  // NOT NULL STRING
;   IF B=0 THEN  //LOWER TO UPPER
;    C=65 //LOWER BOUND
;    D=91 //UPPER BOUND
;   ENDIF
; 
;   IF B=1 THEN  //UPPER TO LOWER
;    C=193 //LOWER BOUND
;    D=219 //UPPER BOUND
;   ENDIF
; 
;   FOR X=1 TO LEN(A$)
;    IF ORD(A$(X))>=C AND ORD(A$(X))<D  THEN //WRAP LINE
;    A$(X)=CHR$(ORD(A$(X))BITXOR($80)) //FLIP CASE
;   ENDFOR X
;  ENDIF
; 
; ENDPROC CONVERT'CASE
; 
CVCASE
    LDA #$02                    ; FIND B
    JSR FNDPAR
    LDY #$00                    ; TEST B
    LDA (COPY1),Y               ; HI BYTE
    BMI ARGERR                  ; <0
    INY
    LDA (COPY1),Y               ; LO BYTE
    CMP #$02
    BCS ARGERR                  ; >1
; 
    CMP #$01                    ; WHICH WAY ?
    BEQ LWER                    ; UPPER TO LOWER
; 
    LDA #$41                    ; SET BOUNDS FOR LOWER TO UPPER #65
    STA LOWBND
    LDA #$5b                    ; #91
    STA UPRBND
    BNE CVC                     ; (JMP)
; 
LWER
    LDA #$c1                    ; SET BOUNDS FOR UPPER TO LOWER #193
    STA LOWBND
    LDA #$db                    ; #219
    STA UPRBND
; 
; 
CVC
    LDA #$01                    ; FIND A$
    JSR FNDPAR
    LDY #$02                    ; GET LENGTH
    LDA (COPY1),Y               ; HI BYTE
    TAX                         ; SAVE IN .X
    INY
    LDA (COPY1),Y               ; LO BYTE
    STA INF1                    ; SAVE IN INF1
; 
    BNE NTNULL                  ;  LO>0
    TXA
    BNE NTNULL                  ;  LO AND HI =0
    RTS                         ; NULL STRING NO ACTION
; 
NTNULL
    INY
CVC1
    LDA (COPY1),Y               ; BYTE OF STRING
    CMP LOWBND                  ; TEST LOWER BOUND
    BCC OUTBND                  ; < BOUND
    CMP UPRBND                  ; TEST UPPER BOUND
    BCS OUTBND                  ; >= BOUND
; 
    EOR #$80                    ; TOGGLE CASE        
    STA (COPY1),Y               ; STORE NEW VALUE
; 
OUTBND
    DEC INF1                    ; DEC LO COUNTER
    BNE NTDNE                   ; NOT DONE YET
    DEX                         ; DEC HI COUNTER
    BPL NTDNE                   ; NOT DONE YET
    RTS                         ; FINISHED
; 
NTDNE
    INY                         ; NEXT CHAR
    BNE CVC1                    ; MORE TO DO
    INC COPY1+1                 ; BUMP HI
    JMP CVC1
; 
LOWBND
    !by $00                     ; LOWER BOUND STORAGE
UPRBND
    !by $00                     ; UPPER BOUND STORAGE
; 
; PACKAGE: LOCATE
; 
init_Locate
    RTS                         ; NO INIT NEEDED FOR LOCATE
; 
; PROCEDURE TABLE FOR LOCATE
; 
ptLocate
    !pet $0b,"locate'real"      ; FUNCTION LOCATE'REAL
    !word FLOCRL                ; DESCRIPTOR POINTER
    !pet $0a,"locate'int"       ; FUNCTION LOCATE'INT
    !word FLOCIN
    !pet $0a,"locate'str"       ; FUNC LOCATE'STR
    !word FLOCST
    !by $00                     ; END OF TABLE
; 
; FUNC LOCATE'REAL (REF A)
; 
FLOCRL
    !by FUNC+REAL               ; REAL FUNC
    !word LOCCOD                ; POINT TO CODE
    !by $01                     ; 1 PARAMETER
    !by REF+REAL                ; REFERENCE REAL
    !by ENDFNC
; 
; FUNC LOCATE'INT (REF A#)
; 
FLOCIN
    !by FUNC+REAL               ; REAL FUNC
    !word LOCCOD                ; POINT TO CODE
    !by $01                     ; 1 PARAMETER
    !by REF+INT                 ; REFERENCE INTEGER
    !by ENDFNC
; 
; FUNC LOCATE'STR (REF A$)
; 
FLOCST
    !by FUNC+REAL               ; REAL FUNC
    !word LOCCOD                ; POINT TO CODE
    !by $01                     ; 1 PARAMETER
    !by REF+STR                 ; REFERENCE STRING
    !by ENDFNC
; 
; ALL FUNCTIONS IN LOCATE ARE
; TO RETURN THE ADDRESS OF THE VARIABLE
; PASSED AS THE PARAMETER.
; 
; DIFFERENT FUNCTIONS ARE NEEDED
; FOR EACH VARIABLE TYPE BECAUSE
; OF THE PARAMETER TYPE TESTS
; PERFORMED BY COMAL.
; 
; SEPERATE CODE IS NOT NEEDED TO
; RETURN THE ADDRESS SINCE FINDING
; THE PARAMETER AND RETURNING ITS
; ADDRESS IS THE SAME FOR ALL TYPES.
; 
LOCCOD
    LDA #$01                    ; FIRST PARAM
    JSR FNDPAR                  ; FIND IT
    LDX COPY1+1                 ; HI BYTE IN .X
    LDA COPY1                   ; LO BYTE IN .A
    JMP INTFPA                  ; FLOAT AND PUSH UNSIGNED INTEGER
; 
; 
END
