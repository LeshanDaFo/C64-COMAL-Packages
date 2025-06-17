; #######################################################################
; #                                                                     #
; #  C64 COMAL80 PACKAGE QUAKE                                          #   
; #                                                                     #
; #  This source code was created based on "pkg.quake.seq"              #
; #  from CT13                                                          #
; #                                                                     #
; #  Version 1.0 (2025.05.03)                                           #
; #  Copyright (c) 2025 Claus Schlereth                                 #
; #                                                                     #
; #  This version of the source code is under MIT License               #
; #  https://github.com/LeshanDaFo/C64-COMAL-Packages/blob/main/LICENSE #
; #                                                                     #
; #######################################################################



    !source "c64symb.asm"
    sysirq = $c3bf
*=$7ec0 ; load address (32448)

    !by DEFPAG                  ; MEMORY MAP
    !word END                   ; END OF PACKAGE
    !word signal                ; SENSE ROUTINE

    !pet $05,"quake"            ; NAME IS QUAKE
    !word ptQuake               ; QUAKE PROCEDURE TABLE
    !word DUMMY                 ; INIT ROUTINE

    !by $00                     ; END OF TABLE

signal
    cpy #$09
    beq QOFF
    cpy #$0a
    beq QOFF
    cpy #$03
    beq QOFF
    cpy #$04
    beq QOFF
    rts

ptQuake
    !pet $03,"qon"              ; FUNCTION QON
    !word phQon                 ; DESCRIPTOR POINTER
    !pet $04,"qoff"             ; FUNCTION QOFF
    !word phQoff                ; DESCRIPTOR POINTER
  
.buffer0 !byte $00

phQon
    !by PROC                    ; FUNC
    !word QON                   ; POINT TO CODE
    !by $00                     ; 0 PARAMETERS
    !by ENDPRC                  ; END FUNC

phQoff
    !by PROC                    ; FUNC
    !word QOFF                  ; POINT TO CODE
    !by $00                     ; 0 PARAMETERS
    !by ENDPRC                  ; END FUNC

; the next 7 bytes are not used
.buffer1 !byte $00,$00,$00,$00,$00,$00,$00

QON
    jmp .setnewirq

QOFF
    jmp .restoreirq

; 43 bytes
.l7f06
    !by $10
.l7f07
    !by $00,$01,$02,$03,$04,$05,$06,$07
    !by $07,$07,$07,$07,$06,$05,$04,$03
    !by $02,$01,$00,$00,$00
.l7f1c
    !by $04,$05,$06,$07,$07,$07,$07,$06
    !by $05,$04,$03,$02,$01,$00,$00,$00
    !by $00,$01,$02,$03,$04

.setnewirq
    sei
    lda #<NIRQ
    sta $0314
    lda #>NIRQ
    sta $0315
    lda #$01
    sta $d01a
    lda #$00
    sta $d012
    lda $d011
    and #$77
    sta $d011
    lda $d016
    and #$f7
    sta $d016
    cli
    rts

NIRQ
    lda $d019
    and #$01
    beq +
    lda #$01
    sta $d019
    jsr .shake
    jmp sysirq ; IRQ
+   pla
    tay
    pla
    tax
    pla
    rti

.restoreirq
    sei
    lda #$80
    sta $d01a
    lda #<sysirq
    sta $0314
    lda #>sysirq
    sta $0315
    lda $d016
    and #$f0
    ora #$08
    sta $d016
    lda $d011
    and #$f0
    ora #$0b
    sta $d011
    cli
    rts

.shake
    ldx .l7f06
    lda $d016
    and #$f8
    ora .l7f07,X
    sta $d016
    lda $d011
    and #$f8
    ora .l7f1c,X
    sta $d011
    inc .l7f06
    lda .l7f06
    cmp #$15
    bcc +
    lda #$00
    sta .l7f06
+   rts
END