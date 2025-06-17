;
;--------------------------------;
;                                ;
; TEXT - A COMAL PACKAGE         ;
;                                ;
; REV. 1.02                      ;
;                                ;
; DUTCH COMAL USERS GROUP        ;
;                                ;
; LAST CHANGE 860707             ;
;                                ;
;--------------------------------;
;
!source "c64symb.asm"

;
*= $8009
;
    !by DEFPAG                  ; MEMORY MAP
EINDE
    !word END                   ; END OF PACKAGE
    !word DUMMY                 ; SENSE ROUTINE

    !pet $04,"text"
    !word ptText
    !word .reset
    !by $00
;
ptText
    !pet $07,"rewrite"
    !word phEmpty
    !pet $07,"writeln"
    !word phPut
    !pet $06,"readln"
    !word phGet
    !pet $05,"reset"
    !word phReset
    !pet $03,"eot"
    !word phEot
    !pet $09,"bytesfree"
    !word phFree
;
    !pet  $0c,"version'text"
    !word  phVersion
    !by $00
;
phEmpty
    !by PROC
    !word Proc_EMPTY
    !by $00
    !by ENDPRC
;
phPut
    !by PROC
    !word Proc_PUT
    !by $01
    !by STR+REF
    !by ENDPRC
;
phGet
    !by PROC
    !word Proc_GET
    !by $01
    !by STR+REF
    !by ENDPRC
;
phReset
    !by PROC
    !word .reset
    !by $00
    !by ENDPRC
;
phEot
    !by FUNC+REAL
    !word Proc_EOT
    !by $00
    !by ENDFNC
;
phFree
    !by FUNC+REAL
    !word Proc_FREE
    !by $00
    !by ENDFNC
;
;--------------------------------;
; PROC REWRITE CLOSED            ;
;--------------------------------;
;
Proc_EMPTY
    LDA #<END
    LDY #>END
    STA EINDE
    STY EINDE+1
;
;--------------------------------;
; PROC RESET CLOSED              ;
;--------------------------------;
;
.reset
    LDA #<END
    LDY #>END
    STA SUBPNT
    STY SUBPNT+1
    RTS
;
;--------------------------------;
; FUNC EOT CLOSED                ;
;--------------------------------;
;
Proc_EOT
    JSR TEOF
    LDA #$00
    ROL 
    TAX
    LDA #$00
    JMP PSHINT
;
;--------------------------------;
; FUNC BYTESFREE CLOSED          ;
;--------------------------------;
;
Proc_FREE
    JSR MAX
    LDA MAXADD
    CLC
    SBC EINDE
    TAX
    LDA MAXADD+1
    SBC EINDE+1
    JMP PSHINT
;
;--------------------------------;
; PROC WRITELN(STR) CLOSED       ;
;--------------------------------;
;
Proc_PUT
    LDA #$01
    JSR FNDPAR
;
; POINTER ON CURRENT LENGTH:
;              = COPY FROM!
;
    LDA COPY1
    CLC
    ADC #<2
    STA COPY1
    LDA COPY1+1
    ADC #>2
    STA COPY1+1
;
; COPY TO = END OF PACKAGE:
;
    LDA EINDE
    LDY EINDE+1
    STA COPY2
    STY COPY2+1
;
; COPY LENGTH = CURRENT LENGTH:
;
    LDY #$01
SETUP
    LDA (COPY1),Y
    STA COPY3,Y
    DEY
    BPL SETUP
;
; COPY3:+2 (LENGTH MUST BE SAVED):
;
    JSR LEN
;
; LOOK FOR BUFFER OVERFLOW
;
    JSR MAX
;
    LDA COPY3+1
    CLC
    ADC EINDE
    TAX
    LDA COPY3
    ADC EINDE+1
    TAY
    TXA
    SEC
    SBC MAXADD
    TYA
    SBC MAXADD+1
    BCS OUT
;
; ELSE, SET NEW END:
;
    STX EINDE
    STY EINDE+1
;
; AND COPY STRING IN BUFFER
;
    JMP COPYDN
;
;--------------------------------;
; ENTRIES FOR ERROR MESSAGES:    ;
; - END OF FILE                  ;
; - OUT OF MEMORY                ;
;--------------------------------;
;
EOF
    LDX #$c9
    !by $2C
OUT
    LDX #$34
    JMP RUNERR
;
;--------------------------------;
; TEST FOR EOT, CARRY=1 IF SO    ;
;--------------------------------;
;
TEOF
    LDA SUBPNT
    SEC
    SBC EINDE
    LDA SUBPNT+1
    SBC EINDE+1
    RTS
;
;--------------------------------;
; PROC READLN(STR) CLOSED        ;
;--------------------------------;
;
; TEST FOR END OF BUFFER
;
Proc_GET
    JSR TEOF
    BCS EOF
;
    LDA #$01
    JSR FNDPAR
;
; COPY TO = COPY1 + 2:
;
    LDA COPY1
    CLC
    ADC #<2
    STA COPY2
    LDA COPY1+1
    ADC #>2
    STA COPY2+1
;
; COPY READ POINTER TO ZEROPAGE:
;
    LDA SUBPNT
    LDY SUBPNT+1
    STA FREKZP
    STY FREKZP+1
;
; LOOK IF THE STRING IN BUFFER
; WILL FIT IN THE STRING:
;
    LDY #$01
    LDA (COPY1),Y
    SEC
    SBC (FREKZP),Y
    DEY
    LDA (COPY1),Y
    SBC (FREKZP),Y
    BCC NOROOM
;
;-COPY WHOLE STRING--------------;
;
; COPY FROM = READ POINTER
;
    LDA FREKZP
    LDY FREKZP+1
    STA COPY1
    STY COPY1+1
;
; COPY LENGTH = BUF. STRING LENGTH
;
    LDY #$01
SETUP1
    LDA (FREKZP),Y
    STA COPY3,Y
    DEY
    BPL SETUP1
;
; COPY3:+2 (2 BYTES FOR LENGTH):
;
    JSR LEN
;
; MOVE READ POINTER OVER STRING:
;
    LDA FREKZP
    CLC
    ADC COPY3+1
    STA SUBPNT
    LDA FREKZP+1
    ADC COPY3
    STA SUBPNT+1
;
; AND COPY STRING FROM BUFFER
;
    JMP Proc_COPY
;
;-COPY FIRST PART OF STRING------;
;
; COPY LENGTH = STRING LENGTH:
;
NOROOM
    LDA (COPY1),Y
    STA COPY3
    PHA
    INY
    LDA (COPY1),Y
    STA COPY3+1
    PHA
;
; COPY TO = READ POINTER
;
    LDA FREKZP
    LDY FREKZP+1
    STA COPY1
    STY COPY1+1
;
; COPY3:+2 (2 BYTES FOR LENGTH)
;
    JSR LEN
;
; MOVE READ POINTER OVER STRING
;
    LDY #$01
    LDA (FREKZP),Y
    CLC
    ADC FREKZP
    TAX
    DEY
    LDA (FREKZP),Y
    ADC FREKZP+1
    TAY
    TXA
    CLC
    ADC #<2
    STA SUBPNT
    TYA
    ADC #>2
    STA SUBPNT+1
;
; SET CURRENT STRING LENGTH
;
    LDY #$01
    PLA
    STA (COPY1),Y
    DEY
    PLA
    STA (COPY1),Y
;
; AND COPY STRING
;
;--------------------------------;
; SUBROUTINE COPY FROM BENEATH   ;
; ROM. COMAL SUBROUTINES DOESN'T ;
;--------------------------------;
;
Proc_COPY
    LDX COPY3
    LDA COPY3+1
    TAY
    BEQ ++
    EOR #$ff
    TAY
    INY
    CLC
    LDA COPY1
    ADC COPY3+1
    STA COPY1
    BCS +
    DEC COPY1+1
+   CLC
    LDA COPY2
    ADC COPY3+1
    STA COPY2
    BCS .l03
    DEC COPY2+1
.l03
    LDA (COPY1),Y
    STA (COPY2),Y
    INY
    BNE .l03
    INC COPY1+1
    INC COPY2+1
++  DEX
    BPL .l03
    RTS
;
;--------------------------------;
; SUBROUTINE ADD 2 TO COPY3      ;
;--------------------------------;
;
LEN
    LDA COPY3+1
    CLC
    ADC #<2
    STA COPY3+1
    LDA COPY3
    ADC #>2
    STA COPY3
    RTS
;
;--------------------------------;
; SUBROUTINE CALCULATE MAX'ADD   ;
;--------------------------------;
;
MAX
    LDA #<$C000
    LDY #>$C000
    STA MAXADD
    STY MAXADD+1
;
    LDX LIBPT
MAXLP
    DEX
    BPL MXSRCH
    RTS
;
MXSRCH
    LDA LIBPAG,X
    AND #%11000111
    CMP #%01000100
    BEQ MAXOK
    CMP #%01000101
    BEQ MAXOK
    CMP #%01000110
    BNE MAXLP
;
MAXOK
    LDA LIBLO,X
    SEC
    SBC MAXADD
    LDA LIBHI,X
    SBC MAXADD+1
    BCS MAXLP
;
    LDA LIBLO,X
    SEC
    SBC #<END
    LDA LIBHI,X
    SBC #>END
    BCC MAXLP
;
    LDA LIBLO,X
    LDY LIBHI,X
    STA MAXADD
    STY MAXADD+1
    BNE MAXLP
;
;--------------------------------;
; VERSION NUMBER                 ;
;--------------------------------;
;
phVersion
    !by FUNC+STR
    !word VERSTR
    !by $00
    !by ENDFNC
;
VERSTR
    LDA #VERST3-VERST2+2
    JSR EXCGST
    LDY #$00
VERST1
    LDA VERST2,Y
    STA (COPY2),Y
    INY
    CPY #VERST3-VERST2
    BNE VERST1
    LDA #$00
    STA (COPY2),Y
    LDA #VERST3-VERST2
    INY
    STA (COPY2),Y
    RTS
;
VERST2
    !pet " 1.02 text package"
    !pet " by marcel bokhorst"
VERST3
;
;--------------------------------;
; SOME VARIABLES                 ;
;--------------------------------;
;
SUBPNT
    !word 0
MAXADD
    !word 0
;
; AND FINALLY THE
;
END
