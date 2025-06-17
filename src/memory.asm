; by Richard Bain
; CT18
; ------------------------
; add c64symb.asm, and removed label part
; adjust macro, so it can be assembled with ACME
; Claus Schlereth
; ------------------------

!source "c64symb.asm"

;
;PACKAGE CODE
;
 *=$8009
    !by DEFPAG+ROMMED
    !word END
    !word SENSEM
;
;PACHAGE TABLE
;
    !pet $05,"multi"
    !word MEMP
    !word INITM
    !by $00
;
MEMP ;PROCEDURE NAMES
    !pet $0b,"program'top"
    !word TOPH
    !pet $0c,"program'base"
    !word BASEH
    !pet $03,"bye"
    !word BYEH
    !pet $06,"ewitch"
    !word SWTCHH
    !pet $07,"get'mem"
    !word GETMMH
    !pet $07,"set'mem"
    !word SETMMH
    !pet $0e,"version'memory"
    !word VERH
    !pet $00
;
;PROCEDURE HEADERS
;
TOPH
    !by PROC
    !word TOPC
    !by $01
    !by VALUE+INT
    !by ENDPRC
;
BASEH
    !by PROC
    !word BASEC
    !by $01
    !by VALUE+INT
    !by ENDPRC
;
BYEH
    !by PROC
    !word BYEC
    !by $00
    !by ENDPRC
;
SWTCHH
    !by PROC
    !word SWTCHC
    !by $00
    !by ENDPRC
;
GETMMH
    !by PROC
    !word GETMMC
    !by $01
    !by REF+STR
    !by ENDPRC
;
SETMMH
    !by PROC
    !word SETMMC
    !by $01
    !by REF+STR
    !by ENDPRC
;
VERH
    !by FUNC+STR
    !word VERC
    !by $00
    !by ENDFNC
;
;INTERNAL VARIABLES
;
SPROG2 *=*+2
ENDAD2 *=*+2
MSAVE *=*+144
MSAVE2 *=*+6
MBUFF *=*+255
MSTAT *=*+1
;
;MACRO
;
!macro mv16ab .wort,.mem {
lda .wort
sta .mem
lda .wort+1
sta .mem+1
}
; .MAC MOVWOR ;MOVE WORD ?1 TO ?2
;    LDA ?1
;    STA ?2
;    LDA ?1+1
;    STA ?2+1
; .MND
;
;SENSE ROUTINE
;AND INIT ROUTINE
;
SENSEM
    CPY #LINK
    BEQ SENSED
    CPY #WARM1
    BEQ INITM
    RTS
SENSED
+mv16ab SPROG,SPROG2
+mv16ab ENDADR,ENDAD2

;    MOVWOR SPROG,SPROG2
;    MOVWOR ENDADR,ENDAD2
INITM
    LDA #DEFPAG
    STA $CA2C
    LDA #<NEW2
    STA $CA2D
    LDA #>NEW2
    STA $CA2E
    RTS
;
;PROC BYE
;
; THIS PROC SAVES THE PROGRAM POINTERS
; AND THEN DOES A NEW (FOR A DIFFERENT
; MEMORY SEGMENT).
;
BYEC
    LDA CSTAT
    CMP #$04
    BEQ BYE2
    LDX #$15 ;IMMEDIATE MODE ONLY
    JMP RUNERR
BYE2
    LDY #$8F
MLP1
    LDA $00,Y
    STA MSAVE,Y
    DEY
    CPY #$FF
    BNE MLP1
    LDY #$05
MLP2
    LDA $0250,Y
    STA MSAVE2,Y
    DEY
    BPL MLP2
    LDY #$FE
MLP3
    LDA CDBUF,Y
    STA MBUFF,Y
    DEY
    CPY #$FF
    BNE MLP3
    LDA CSTAT
    STA MSTAT
;
;UPDATED NEW CODE
;
NEW2
+mv16ab SPROG2,SPROG
;    MOVWOR SPROG2,SPROG

    CLC
    LDA SPROG
    ADC #$04
    STA SVARS
    LDA SPROG+1
    ADC #$00
    STA SVARS+1
    CLC
    LDA SPROG
    ADC #$05
    STA SSTACK
    STA STOS
    LDA SPROG+1
    ADC #$00
    STA SSTACK+1
    STA STOS+1
    LDA ENDAD2
    STA SMAX
    STA SFREE
    STA ENDADR
    LDA ENDAD2+1
    STA SMAX+1
    STA SFREE+1
    STA ENDADR+1
    LDA #<CDBUF
    STA PRGPNT
    STA CONPNT
    LDA #>CDBUF
    STA PRGPNT+1
    STA CONPNT+1
    LDA #$00
    TAY
    TAX
    STA (SPROG),Y
    INY
    STA (SPROG),Y
    INY
    STA (SPROG),Y
    INY
    INY
    STA (SPROG),Y
    DEY
    LDA #$9F
    STA (SPROG),Y
    JSR GOTO
    !by PAGE2
    !word $A1E4
;
;PROCEDURE CODE
;
TOPC ;PROC PROGRAM"TOP(TOP#)
;
    LDA #$01
    JSR FNDPAR
    LDY #$00
    LDA (COPY1),Y
    STA ENDAD2+1
    INY
    LDA (COPY1),Y
    STA ENDAD2
    RTS
;
BASEC ;PROC PROGRAM"BASE(BASE#)
;
    LDA #$01
    JSR FNDPAR
    LDY #$00
    LDA (COPY1),Y
    STA SPROG2+1
    INY
    LDA (COPY1),Y
    STA SPROG2
    RTS
;
;PROC SWITCH
SWTCHC
    LDY #$8F
MLP4
    LDA $00,Y
    TAX
    LDA MSAVE,Y
    STA $00,Y
    TXA
    STA MSAVE,Y
    DEY
    CPY #$FF
    BNE MLP4
    LDY #$05
MLP5
    LDA $0250,Y
    TAX
    LDA MSAVE2,Y
    STA $0250,Y
    TXA
    STA MSAVE2,Y
    DEY
    BPL MLP5
    LDY #$FE
MLP6
    LDA CDBUF,Y
    TAX
    LDA MBUFF,Y
    STA CDBUF,Y
    TXA
    STA MBUFF,Y
    DEY
    CPY #$FF
    BNE MLP6
    LDA CSTAT
    LDX MSTAT
    STA MSTAT
    STX CSTAT
+mv16ab SPROG,SPROG2
+mv16ab SMAX,ENDAD2
;    MOVWOR SPROG,SPROG2
;    MOVWOR SMAX,ENDAD2
    RTS
;
;PROC GET"MEM(REF M$)//M$ GETS MEM INFO
GETMMC
    LDA #$01
    JSR FNDPAR
    SEC
    LDY #$01
    LDA (COPY1),Y
    SBC #<406
    DEY
    LDA (COPY1),Y
    SBC #>406
    BCS GETOK
    LDX #$04
    JMP RUNERR
GETOK
    LDY #$02
    LDA #>406
    STA (COPY1),Y
    INY
    LDA #<406
    STA (COPY1),Y
    CLC
    LDA COPY1
    ADC #$04
    STA COPY1
    LDA COPY1+1
    ADC #$00
    STA COPY1+1
    LDA #<MSAVE
    STA COPY2
    LDA #>MSAVE
    STA COPY2+1
    LDY #$00
GETLP1
    LDA (COPY2),Y
    STA (COPY1),Y
    INY
    BNE GETLP1
    INC COPY1+1
    INC COPY2+1
GETLP2
    LDA (COPY2),Y
    STA (COPY1),Y
    INY
    CPY #<410
    BNE GETLP2
    RTS
;
;PROC SET"MEM(REF M$)//M$ SETS MEM INFO
SETMMC
    LDA #$01
    JSR FNDPAR
    SEC
    LDY #$03
    LDA (COPY1),Y
    SBC #<406
    STA COPY2
    DEY
    LDA (COPY1),Y
    SBC #>406
    ORA COPY2
    BEQ SETOK
    LDX #$04
    JMP RUNERR
SETOK
    CLC
    LDA COPY1
    ADC #$04
    STA COPY1
    LDA COPY1+1
    ADC #$00
    STA COPY1+1
    LDA #<MSAVE
    STA COPY2
    LDA #>MSAVE
    STA COPY2+1
    LDY #$00
SETLP1
    LDA (COPY1),Y
    STA (COPY2),Y
    INY
    BNE SETLP1
    INC COPY1+1
    INC COPY2+1
SETLP2
    LDA (COPY1),Y
    STA (COPY2),Y
    INY
    CPY #<410
    BNE SETLP2
    RTS
;
VERC
    LDA #END-VER2+2
    JSR EXCGST
    LDY #$00
VER1
    LDA VER2,Y
    STA (COPY2),Y
    INY
    CPY #END-VER2
    BNE VER1
    LDA #$00
    STA (COPY2),Y
    LDA #END-VER2
    INY
    STA (COPY2),Y
    RTS
VER2
    !pet " 1.00 memory package"
    !pet " by Richard Baim",$0d
;
END
