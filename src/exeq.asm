; #######################################################################
; #                                                                     #
; #  C64 COMAL80 PACKAGE EXEQ.                                          #
; #                                                                     #
; #  This source code was created based on "pkg.exeq.seq" from CT10     #
; #                                                                     #
; #  Version 1.0 (2025.05.03)                                           #
; #  Copyright (c) 2025 Claus Schlereth                                 #
; #                                                                     #
; #  This version of the source code is under MIT License               #
; #  https://github.com/LeshanDaFo/C64-COMAL-Packages/blob/main/LICENSE #
; #                                                                     #
; #######################################################################



    !source "c64symb.asm"

*=$9000 ; load address

    !by DEFPAG                  ; MEMORY MAP
    !word END                   ; END OF PACKAGE
    !word DUMMY                 ; SENSE ROUTINE

    !pet $04,"exeq"             ; NAME
    !word ptExeq                ; PROCEDURE TABLE $900F
    !word DUMMY                 ; INIT ROUTINE

    !by $00


ptExeq
    !pet $04,"call"
    !word phCall

    !by $00


phCall
    !by PROC
    !word ProcCall
    !by $01
    !by VALUE + STR
    !by ENDPRC


ProcCall  
    lda #$01
    jsr FNDPAR            ; find parameter (asm.calls) $c896
    jsr label1            ; $9022 20 2990 
    jsr label11           ; $9025 20 9090 
    rts

label1
    ldy #$02
    lda (COPY1),Y
    beq label2            ; $902D F0 03   
    jmp .error5 ; value out of range

label2
    iny

label3
    lda (COPY1),Y
    cmp #$4f
    bcc + 
    jmp .error5 ; value out of range
+   clc
    adc #$04
    sta $90de             ; $903F 8D DE90 
    lda SVARS             ; pnt to start of variable table $18
    sta TEMPF1            ; misc. fp work area (5 bytes) $57
    lda SVARS+1
    sta TEMPF1+1   
    lda #$00
    sta $90d9             ; $904C 8D D990 
    sta $90da             ; $904F 8D DA90 
--  ldy #$00
    lda (TEMPF1),Y
    bne +
    jmp .error6c    ; proc/func does not exist

+   sta $90dd             ; $905B 8D DD90 
    cmp $90de             ; $905E CD DE90 
    bne +
    ldy #$04
-   lda (COPY1),Y
    cmp (TEMPF1),Y
    bne +
    iny
    cpy $90de             ; $906C CC DE90 
    bne -
    rts

+   clc
    lda $90dd             ; $9073 AD DD90 
    adc TEMPF1
    sta TEMPF1
    bcc +
    inc TEMPF1+1
    clc
+   lda $90dd             ; $907F AD DD90 
    adc $90d9             ; $9082 6D D990 
    sta $90d9             ; $9085 8D D990 
    bcc +   
    inc $90da             ; $908A EE DA90 
    clc
+   bcc --

label11
    lda INLEN             ; length of line to be executed ;$1f
    sta $90df             ; $9092 8D DF90 
    lda PRGPNT            ; pnt to start of line ;$31
    sta $90e0             ; $9097 8D E090 
    lda PRGPNT+1
    sta $90e1             ; $909C 8D E190 
    lda CODPNT            ; pnt to code during execution ;$33
    sta $90e2             ; $90A1 8D E290 
    lda CSTAT             ; status of comal program $c845
    sta $90e3             ; $90A7 8D E390 
    ldx #$00
-   lda .buffer,X
    sta CDBUF,X           ; code buffer $c661,X
    inx                   ; $90B2 E8      
    cpx #$08
    bne -
    jsr EXCUTE            ; excute code in cdbuf $ca36
    lda $90e3             ; $90BA AD E390         load/store A
    sta CSTAT             ; status of comal program $c845
    lda $90e2             ; $90C0 AD E290         load/store A
    sta CODPNT            ; pnt to code during execution ;$33
    lda $90e1             ; $90C5 AD E190         load/store A
    sta PRGPNT+1
    lda $90e0             ; $90CA AD E090         load/store A
    sta PRGPNT            ; pnt to start of line ;$31
    lda $90df             ; $90CF AD DF90         load/store A
    sta INLEN             ; length of line to be executed ;$1f
    rts

;90d5
.buffer
    !by $00
    !by $00
    !by $08
    !by $81

;90d9
    !by $00
;90da
    !by $00
    !by $ff
;90dd
    !by $33
;90de
    !by $00

;90df
    !by $00
;90e0
    !by $00
;90e1
    !by $00
;90e2
    !by $00
;90e3
    !by $00
    !by$00

.error5
    ldx #$05 ; value out of range  
    !by $2C
.error6c
    ldx #$6c ; procedure/function does not exist
    jmp RUNERR  ; go to comal error handler ;$c9fb
END