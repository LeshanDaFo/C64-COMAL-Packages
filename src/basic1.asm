
; ------------------------
; this version of basic can be found as on 'Holland Disk 1' 'CT08'
; created the source based on these files 'pkg.basic.src'
; prepared the source, so it can be assembled with ACME
; Claus Schlereth 2025-06-18
; ------------------------
;
; description from CT08:
; The following COMAL 2.0 package was
; written in Holland. It is listed in the
; Comodore Editor/Assembler format, but
; could be converted for other assemblers.
; ...
; This package will switch the
; computer to BASIC, load a BASIC program,
; RUN the program, and when finished,
; return to COMAL. You could use this
; package in a master menu program to call
; other programs.
;
; USE basic
; go ("name")
;
; This version on disk is different to the listing.


!source "c64symb.asm"

*=$8009

    !by DEFPAG          ; MEMORY MAP
    !word .end          ; END OF PACKAGE
    !word DUMMY         ; SENSE ROUTINE

    !pet $05,"basic"    ; NAME
    !word ptBasic       ; PROCEDURE TABLE
    !word DUMMY         ; INIT ROUTINE

    !by $00

ptBasic
    !pet 2,"go"         ;PROCEDURE NAME
    !word phBasic
    !by $00

phBasic
    !by PROC
    !word procBasic
    !by $01
    !by VALUE+STR
    !by ENDPRC

procBasic
    LDA #$01
    JSR FNDPAR          ; find parameter (asm.calls)
    LDY #$02
    LDA (COPY1),Y
    BNE .error
    INY
    LDA (COPY1),Y
    BEQ .error
    CMP #$11
    BCC .ok
.error
    LDX #$01
    JMP RUNERR          ; go to comal error handler
-----------------------------------
.ok
    STA .buffer
    LDX #$00
    INY
.name
    LDA  (COPY1),Y
    STA .buffer+1,X
    INX
    INY
    CPX .buffer
    BCC .name
    SEI  
    LDA #$37
    STA $01
    LDX #$E0
    LDY #$07
    LDA #$00
.port
    STA $DF00,Y
    DEY  
    BPL .port
    STX $DE00
    STX $8008
    LDX #$FF
    TXS
    CLD
    JSR $FDA3
    JSR $FD50
    JSR $FD15
    JSR $FF5B
    CLI
    JSR $E453
    JSR $E3BF
    JSR $E422
    LDX #$FB
    TXS
    LDA #<.nmi
    LDY #>.nmi
    STA $0318
    STY $0319
    LDA #<.back
    LDY #>.back
    STA $0302
    STY $0303
    LDA #$80
    STA $9D
    LDA #$FF
    STA $3A
    LDA .buffer
    LDX #<.na
    LDY #>.na
    JSR SETNAM
    LDX #$08
    LDY #$FF
    JSR SETLFS

    LDX #$5D
-   LDA .load,X
    STA $CF00,X
    DEX
    BPL -
    LDA #$00
    LDX $2B
    LDY $2C
    JMP $CF00
-----------------------------------
.load
!pseudopc $CF00 {
    JSR LOADF       ;LOAD RAM FROM A DEVICE $ffd5
    BCC .noerr
    JMP $E0F9
-----------------------------------
.noerr
    LDA $90
    AND #$BF
    BEQ .nolerr
    JMP $E19C
-----------------------------------
;CF11
.nolerr
    STX $2D
    STY $2E
    LDA #$02
    LDX #<.com
    LDY #>.com
    JSR SETNAM
    LDA #$01
    LDX #$08
    LDY #$6F
    JSR SETLFS
    JSR OPEN        ;OPEN LOGICAL FILE $ffc0
    JSR $A533
    LDA #$00
    STA $9D
    JSR $A659
    LDA #$0D
    JSR CHROUT      ;OUTPUT CHAR TO CHANNEL $ffd2
    JMP $A7AE
-----------------------------------
;CF3C
.nmi
    LDX #$00
    LDY #$00
-   DEY
    BNE -
    DEX
    BNE -
;CF46
.back
    LDA #$37
    STA $01
    LDX #$80
    LDY #$07
    LDA #$00
-   STA $DF00,Y
    DEY
    BPL -
    STX $DE00
    JMP ($FFFC)
-----------------------------------
;CF5C
.com
    !by $55,$49
}
.buffer
    !by $00
.na
    !by $00,$00,$00,$00,$00,$00,$00
    !by $00,$00,$00,$00,$00,$00,$00,$00
    !by $00,$00
.end