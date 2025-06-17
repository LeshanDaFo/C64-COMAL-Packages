; #######################################################################
; #                                                                     #
; #  C64 COMAL80 PACKAGE META                                           #
; #                                                                     #
; #  This source code was created based on "pkg.meta.seq" from CT10     #
; #                                                                     #
; #  Version 1.0 (2025.05.05)                                           #
; #  Copyright (c) 2025 Claus Schlereth                                 #
; #                                                                     #
; #  This version of the source code is under MIT License               #
; #  https://github.com/LeshanDaFo/C64-COMAL-Packages/blob/main/LICENSE #
; #                                                                     #
; #######################################################################



    !source "c64symb.asm"

*=$800F ; load address

    !by DEFPAG + $20         ; MEMORY MAP
    !word END                   ; END OF PACKAGE
    !word DUMMY                 ; SENSE ROUTINE

    !pet $04,"meta"             ; NAME
    !word ptMeta                ; PROCEDURE TABLE $801e
    !word DUMMY                 ; INIT ROUTINE

    !by $00

ptMeta
    !pet $04,"eval"
    !word phEval ;802e
    !pet $05,"again"
    !word phAgain ;8034

    !by $00

label0
phEval
    !by PROC
    !word ProcEval
    !by $01
    !by VALUE + STR
    !by ENDPRC

phAgain
    !by PROC
    !word ProcAgain
    !by $00
    !by ENDPRC
  

ProcEval
    lda #$09
    jsr $c9e0             ; $803B 20 E0C9 
    ldy #$08              ; $803E A0 08   

label1
    lda $00f6,Y           ; $8040 B9 F600         load/store A
    sta (COPY2),Y           ; $8043 91 47   
    dey                   ; $8045 88      
    cpy #$04              ; $8046 C0 04   
    bne label1            ; $8048 D0 F6   

label2
    lda $002f,Y           ; $804A B9 2F00         load/store A
    sta (COPY2),Y           ; $804D 91 47   
    dey                   ; $804F 88      
    bne label2            ; $8050 D0 F8   
    lda $c845             ; $8052 AD 45C8         load/store A
    sta (COPY2),Y           ; $8055 91 47   
    iny                   ; $8057 C8      
    lda $1f               ; $8058 A5 1F           load/store A
    sta (COPY2),Y           ; $805A 91 47   
    lda #$ff              ; $805C A9 FF   
    jsr $c9e0             ; $805E 20 E0C9 
    ldy #$fe              ; $8061 A0 FE   

label3
    lda $c661,Y           ; $8063 B9 61C6         load/store A
    sta (COPY2),Y           ; $8066 91 47   
    dey                   ; $8068 88      

label4
    bne label3            ; $8069 D0 F8   
    lda $c661             ; $806B AD 61C6         load/store A
    sta (COPY2),Y           ; $806E 91 47   
    lda #$01              ; $8070 A9 01   
    jsr $c896             ; $8072 20 96C8 
    ldy #$02              ; $8075 A0 02   
    lda (COPY1),Y           ; $8077 B1 45           load/store A
    sta $fe               ; $8079 85 FE   
    iny                   ; $807B C8      
    lda (COPY1),Y           ; $807C B1 45           load/store A
    sta $fd               ; $807E 85 FD   
    clc                   ; $8080 18      
    lda COPY1               ; $8081 A5 45   
    adc #$03              ; $8083 69 03   
    sta $fb               ; $8085 85 FB   
    lda COPY1+1               ; $8087 A5 46   
    adc #$00              ; $8089 69 00   
    sta $fc               ; $808B 85 FC   

label5
    lda #$01              ; $808D A9 01           load/store A
    sta $89               ; $808F 85 89   

label6
    jsr label17           ; $8091 20 2D81 
    cmp #$0d              ; $8094 C9 0D   
    beq label7            ; $8096 F0 06   
    jsr label15           ; $8098 20 1981 
    jmp label6            ; $809B 4C 9180 

label7
    jsr label15           ; $809E 20 1981 
    lda #$02              ; $80A1 A9 02           load/store A
    sta $c845             ; $80A3 8D 45C8 
    jsr $c881             ; $80A6 20 81C8 
    !by $81
    !word $920D
      
    ldy $15               ; $80AC A4 15           load/store Y
    sty $c663             ; $80AE 8C 63C6 
    ldx #$00              ; $80B1 A2 00   

label8
    lda $818c,X           ; $80B3 BD 8C81         load/store A
    sta $c661,Y           ; $80B6 99 61C6 
    iny                   ; $80B9 C8      
    inx                   ; $80BA E8      
    cpx #$05              ; $80BB E0 05   
    bne label8            ; $80BD D0 F4   
    lda $8191             ; $80BF AD 9181 
    bne label10           ; $80C2 D0 0C   
    sty $8192             ; $80C4 8C 9281 

label9
    lda $c660,Y           ; $80C7 B9 60C6         load/store A
    sta $8192,Y           ; $80CA 99 9281 
    dey                   ; $80CD 88      
    bne label9            ; $80CE D0 F7   

label10
    inc $8191             ; $80D0 EE 9181 
    jsr $ca36             ; $80D3 20 36CA 
    dec $8191             ; $80D6 CE 9181 
    lda $fd               ; $80D9 A5 FD   
    ora $fe               ; $80DB 05 FE   
    bne label5            ; $80DD D0 AE   

label11
    lda #$ff              ; $80DF A9 FF   
    jsr $c9e9             ; $80E1 20 E9C9 
    ldy #$fe              ; $80E4 A0 FE   

label12
    lda ($2d),Y           ; $80E6 B1 2D           load/store A
    sta $c661,Y           ; $80E8 99 61C6 
    dey                   ; $80EB 88      
    bne label12           ; $80EC D0 F8   
    lda ($2d),Y           ; $80EE B1 2D           load/store A
    sta $c661             ; $80F0 8D 61C6 
    lda #$09              ; $80F3 A9 09   
    jsr $c9e9             ; $80F5 20 E9C9 
    ldy #$08              ; $80F8 A0 08   

label13
    lda ($2d),Y           ; $80FA B1 2D           load/store A
    sta $00f6,Y           ; $80FC 99 F600 
    dey                   ; $80FF 88      
    cpy #$04              ; $8100 C0 04   
    bne label13           ; $8102 D0 F6   

label14
    lda ($2d),Y           ; $8104 B1 2D           load/store A
    sta $002f,Y           ; $8106 99 2F00 
    dey                   ; $8109 88      
    cpy #$01              ; $810A C0 01   
    bne label14           ; $810C D0 F6   
    lda ($2d),Y           ; $810E B1 2D           load/store A
    sta $1f               ; $8110 85 1F   
    dey                   ; $8112 88      
    lda ($2d),Y           ; $8113 B1 2D           load/store A
    sta $c845             ; $8115 8D 45C8 
    rts                   ; $8118 60              return

label15
    ldy $89               ; $8119 A4 89   
    cpy #$79              ; $811B C0 79   
    bcs label16           ; $811D B0 06   
    sta $c5e7,Y           ; $811F 99 E7C5 
    inc $89               ; $8122 E6 89   
    rts                   ; $8124 60              return

label16
    jsr label11           ; $8125 20 DF80 
    ldx #$67              ; $8128 A2 67   
    jmp $c9fb             ; $812A 4C FBC9 

label17
    lda $fd               ; $812D A5 FD   
    ora $fe               ; $812F 05 FE   
    bne label18           ; $8131 D0 03   
    lda #$0d              ; $8133 A9 0D   
    rts                   ; $8135 60              return

label18
    lda $fd               ; $8136 A5 FD   
    bne label19           ; $8138 D0 02   
    dec $fe               ; $813A C6 FE   

label19
    dec $fd               ; $813C C6 FD   
    inc $fb               ; $813E E6 FB   
    bne label20           ; $8140 D0 02   
    inc $fc               ; $8142 E6 FC   

label20
    ldy #$00              ; $8144 A0 00   
    lda ($fb),Y           ; $8146 B1 FB   
    rts                   ; $8148 60              return

;
ProcAgain ;8149
    lda $c845             ; $8149 AD 45C8 
    cmp #$05              ; $814C C9 05   
    beq label21           ; $814E F0 05   
    ldx #$68              ; $8150 A2 68   
    jmp $c9fb             ; $8152 4C FBC9 

label21
    ldy #$02              ; $8155 A0 02   

label22
    lda $0031,Y           ; $8157 B9 3100         load/store A
    sta $8292,Y           ; $815A 99 9282 
    dey                   ; $815D 88      
    bpl label22           ; $815E 10 F7   
    ldy $8192             ; $8160 AC 9281 

label23
    lda $8192,Y           ; $8163 B9 9281         load/store A
    sta $c660,Y           ; $8166 99 60C6 
    dey                   ; $8169 88      
    bne label23           ; $816A D0 F7   
    inc $8191             ; $816C EE 9181 
    jsr $ca36             ; $816F 20 36CA 
    dec $8191             ; $8172 CE 9181 
    ldy #$02              ; $8175 A0 02   

label24
    lda $8292,Y           ; $8177 B9 92 82         load/store A
    sta $0031,Y           ; $817A 99 31 00 
    dey                   ; $817D 88      
    bpl label24           ; $817E 10 F7   
    ldy #$02              ; $8180 A0 02   
    lda ($31),Y           ; $8182 B1 31           load/store A
    sta $1f               ; $8184 85 1F   
    lda #$05              ; $8186 A9 05           load/store A
    sta $c845             ; $8188 8D 45 C8 
    rts                   ; $818B 60              return

;$818c
    !by $00,$00,$05,$FF,$33
;8191
    !by $00
;8192
    !by $05,$00,$00,$05,$FF,$33

    !by $F3,$C5,$FB,$FB,$FF,$FB,$FF
    !by $EB,$81,$04,$FF,$FF,$C3,$FF
    !by $FF,$FD,$F5,$E6,$FF,$C1,$DF
    !by $00,$FB,$00,$FF,$FF,$04,$FF
    !by $FB,$F1,$CC,$FF,$F7,$FF,$FF
    !by $F1,$FB,$04,$FB,$FF,$F7,$FF
    !by $FB,$4C,$C1,$F1,$CF,$C1,$F5
    !by $E6,$27,$7C,$F7,$F7,$E3,$FF
    !by $F7,$FF,$FF,$F7,$FF,$FE,$CD
    !by $FE,$00,$F1,$F1,$36,$FF,$FF
    !by $D1,$E0,$C3,$F7,$00,$E1,$89
    !by $FB,$FB,$4E,$FF,$FF,$F0,$FF
    !by $FF,$F7,$C2,$F6,$FB,$00,$FF
    !by $FF,$E7,$F3,$F5,$70,$F7,$E3
    !by $77,$D9,$1A,$7F,$FA,$C9,$CA
    !by $B0,$BE,$4D,$AC,$EE,$FE,$0A
    !by $0E,$DC,$FF,$1E,$84,$04,$8D
    !by $1D,$8C,$F6,$04,$1E,$04,$00
    !by $00,$FE,$04,$0C,$00,$FF,$00
    !by $FE,$1E,$EE,$04,$FF,$00,$FF
    !by $2D,$FF,$00,$EE,$FC,$3C,$04
    !by $5E,$1A,$FD,$AD,$00,$00,$FF
    !by $2E,$1E,$10,$BE,$00,$0D,$7E
    !by $5C,$00,$1E,$00,$00,$00,$FF
    !by $9E,$1E,$00,$FE,$EF,$3D,$9E
    !by $BF,$8D,$BC,$AE,$EE,$BE,$FE
    !by $3C,$0E,$00,$FB,$0C,$DF,$00
    !by $FE,$08,$FE,$AE,$3C,$3E,$FF
    !by $FF,$00,$2E,$EF,$0D,$00,$00
    !by $FE,$FE,$FE,$1E,$BC,$1E,$0E
    !by $0C,$FF,$FE,$FF,$BD,$00,$AF
    !by $0C,$00,$00,$00,$00,$00,$0E
    !by $0D,$FF,$00,$FE,$22,$0C,$00
    !by $00,$B1,$F7,$C9,$B4,$F9,$BB
    !by $FF,$11,$B3,$FF,$F7,$01,$E6
    !by $DB,$81,$F5,$8A,$FF
;$8292
    !by $FB,$00,$F1
END
