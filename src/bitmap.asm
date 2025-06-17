; #######################################################################
; #                                                                     #
; #  C64 COMAL80 PACKAGE BITMAP                                         #
; #                                                                     #
; #  This source code was created based on "pkg.bitmap.seq" from CT10   #
; #                                                                     #
; #  Version 1.0 (2025.05.03)                                           #
; #  Copyright (c) 2025 Claus Schlereth                                 #
; #                                                                     #
; #  This version of the source code is under MIT License               #
; #  https://github.com/LeshanDaFo/C64-COMAL-Packages/blob/main/LICENSE #
; #                                                                     #
; #######################################################################

; Description:

; by David Stidolph
; On the 2.0 side of TODAY DISK 10 there is a package called pkg.bitmap.
; Its purpose is to copy the contents of the graphics screen into a string, and copy the string back to the screen.

; To use the package:
; link "pkg.bitmap"

; To use the commands in the package you must issue the USE command:
; use bitmap

; This package contains two commands:

; get'bitmap(string$) // screen to string
; put'bitmap(string$) // string to screen

; Both commands need the same parameter; an 8,000 byte string.
; The following short program shows how the procedures are used.
; The program will draw random lines on the graphics screen,
; save the bitmap, clear the screen, and restore the bitmap.
; One use of this package would be in a graphics editor for non-lethal FILLs and drawing.

; DIM map$ of 8000
; USE bitmap // activate package
; USE graphics
; graphicscreen(0) // draw on graphics screen
; FOR x:=l TO 99 DO
; drawto(RND(0,319),RND(0,199)
; ENDFOR x
; get'bitmap(map$) // save bitmap
; clearscreen // clear graphics screen
; put'bitmap(map$) // restore bitmap
; END "Bitmap restored!"



    !source "c64symb.asm"

*=$8009 ; load address

    !by DEFPAG -1               ; MEMORY MAP
    !word END                   ; END OF PACKAGE
    !word DUMMY                 ; SENSE ROUTINE

    !pet $06,"bitmap"           ; NAME
    !word ptBitmap              ; PROCEDURE TABLE
    !word DUMMY                 ; INIT ROUTINE

    !by $00

ptBitmap
    !pet $0A,"get'bitmap"       ; screen to string
    !word phGetbitmap
    !pet $0A,"put'bitmap"       ; string to screen
    !word phPutbitmap

    !by $00

phGetbitmap
    !by PROC
    !word Getbitmap
    !by $01
    !by REF +STR
    !by ENDPRC

phPutbitmap
    !by PROC
    !word Putbitmap
    !by $01
    !by REF + STR
    !by ENDPRC

Getbitmap 
    lda #$01
    jsr FNDPAR              ; $C896 find parameter (asm.calls) 
    ldy #$00
    lda (COPY1),Y
    cmp #$1f
    bne .error
    iny
    lda (COPY1),Y
    cmp #$40
    bne .error
    lda COPY1
    sta COPY2
    lda COPY1+1
    sta COPY2+1
    jsr label4
    ldy #$00
    lda #$1f
    sta (COPY2),Y
    iny
    lda #$40
    sta (COPY2),Y
    jsr label4
    lda #$00
    sta COPY1
    lda #$e0
    sta COPY1+1
    lda #$1f
    sta COPY3
    lda #$40
    sta COPY3+1
    jmp label6

Putbitmap
    lda #$01
    jsr FNDPAR              ; $C896 find parameter (asm.calls)
    jsr label2
    ldy #$00
    lda (COPY1),Y
    cmp #$1f
    bne .error
    iny
    lda (COPY1),Y
    cmp #$40
    bne .error
    jsr label2
    lda #$00
    sta COPY2
    lda #$e0
    sta COPY2+1
    lda #$1f
    sta COPY3
    lda #$40
    sta COPY3+1
    jmp label6

.error
    ldx #$05
    jmp RUNERR                  ; $C9FB go to comal error handler

label2
    lda COPY1
    clc
    adc #$02
    sta COPY1
    bcc +
    inc COPY1+1
+   rts

label4
    lda COPY2
    clc
    adc #$02
    sta COPY2
    bcc +
    inc COPY2+1
+   rts

label6
    ldx COPY3
    ldy #$00
-   lda (COPY1),Y
    sta (COPY2),Y
    dey
    bne -
    inc COPY1+1
    inc COPY2+1
    dex
    bmi +
    bne -
    ldy COPY3+1
-   lda (COPY1),Y
    sta (COPY2),Y
    dey
    bne -
    lda (COPY1),Y
    sta (COPY2),Y
+   rts

    !by $00
END