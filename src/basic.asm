
; src.basic.seq
; found as file on 'Holland Disk 1' and as printout in 'CT08'
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
; The version on CT08 disk is different to the listing.
; There is a second version, called basic1.asm

; ------------------------
; adjust the source, so it can be assembled with ACME
; Claus Schlereth 2025-06-18
; ------------------------
;
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
    !pet 2,"go"         ; PROCEDURE NAME
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
    BNE .argerr
    INY
    LDA (COPY1),Y
    BEQ .argerr
    CMP #$11
    BCC .ok
.argerr
    LDX #$01
    JMP RUNERR          ; go to comal error handler
.ok
    STA .eind
    LDX #$00
    INY
.name
    LDA (COPY1),Y
    STA .eind+1,X
    INX
    INY
    CPX .eind
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
    LDA .eind
    LDX #<.na
    LDY #>.na
    JSR SETNAM
    LDX #$08
    LDY #$FF
    JSR SETLFS
    LDA #$00
    LDX $2B
    LDY $2C
    JSR LOADF           ; LOAD RAM FROM A DEVICE $ffd5
    BCC .noerr
    JMP $E0F9
.noerr
    LDA $90
    AND #$BF
    BEQ .nolerr
    JMP $E19C
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
    JSR OPEN            ; OPEN LOGICAL FILE $ffc0
    JSR $A533
    LDA #$00
    STA $9D
    JSR $A659
    LDA #$0D
    JSR CHROUT          ; OUTPUT CHAR TO CHANNEL $ffd2
    JMP $A7AE
.nmi
    LDX #$80
    LDY #$00
.wait
    DEY
    BNE .wait
    DEX
    BNE .wait
.back
    LDA #$37
    STA $01
    LDX #$80
    LDY #$07
    LDA #$00
.labe
    STA $DF00,Y
    DEY
    BPL .labe
    LDA #$8E
    STA $033C
    LDA #$00
    STA $033D
    LDA #$DE
    STA $033E
    LDA #$6C
    STA $033F
    LDA #$FC
    STA $0340
    LDA #$FF
    STA $0341
    JMP $033C
.com
    !by $55,$49
.eind
    !by $00
.na
    !by $00,$00,$00,$00,$00,$00,$00
.end
    !by $00,$00,$00,$00,$00,$00,$00,$00

