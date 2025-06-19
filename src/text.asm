; by Dick Klingens (CT11)
; When we created a large monitor program
; with a lot strings in which we stored a
; help menu, we were not able to extend
; that program with more disk operations,
; because all memory was occupied.
;
; Two possibilities were left; leaving out
; the help menu or storing the help
; strings in another part of the memory.
;
; We did the latter. We created a RAM disk
; (a text buffer) as a package and we
; called that package TEXT.
;
; The new package has 4 procedures and one
; functIon. You will notice that the
; commands are similar to the file
; commands of Pascal and work in much the
; same way.
; PROC readln(REF x$)
; PROC writeln(REF x$)
; PROC reset
; PROC rewrite
; FUNC eot

; ------------------------
; from Halland Disk 2
; add c64symb.asm, and removed label part
; replace 'point' with 'FREKZP'
; adjust the source, so it can be assembled with ACME
; Claus Schlereth 2025-06-19
; ------------------------

;:::::::::::::::::::::::::::::::::
; SRC.TEXT (COMAL MODULE)        :
;                                :
; BY M.BOKHORST, NOV85           :
; REVISED BY D.KLINGENS          :
;                                :
; DUTCH COMAL USERS GROUP        :
;:::::::::::::::::::::::::::::::::
;
!source "c64symb.asm"
;
;-- MODULE --
;
*=$8009
;
    !by DEFPAG
einde
    !word end
    !word DUMMY

    !pet 4,"text"
    !word procs
    !word reset
    !by 0
;
;-- PROCEDURES & FUNCTIONS --
;
procs
    !pet 7,"rewrite"
    !word hempty
    !pet 7,"writeln"
    !word hput
    !pet 6,"readln"
    !word hget
    !pet 5,"reset"
    !word hres
    !pet 3,"eot"
    !word heot
    !by 0
;
;-- HEADERS --
;
hempty
    !by PROC
    !word empty
    !by 0
    !by ENDPRC
;
hput
    !by PROC
    !word put
    !by 1
    !by STR+REF
    !by ENDPRC
;
hget
    !by PROC
    !word get
    !by 1
    !by STR+REF
    !by ENDPRC
;
hres
    !by PROC
    !word reset
    !by 0
    !by ENDPRC
;
heot
    !by FUNC
    !word eot
    !by 0
    !by ENDFNC
;
;-- CODE --
;
empty
    lda #<end
    ldy #>end
    sta einde
    sty einde+1
;
reset
    lda #<end
    ldy #>end
    sta FREKZP
    sty FREKZP+1
    rts
;
eot
    jsr teof
    lda #0
    rol
    tax
    lda #0
    jmp PSHINT
;
put
    lda #1
    jsr FNDPAR
    lda COPY1
    clc
    adc #<2
    sta COPY1
    lda COPY1+1
    adc #>2
    sta COPY1+1
    lda einde
    ldy einde+1
    sta COPY2
    sty COPY2+1
    ldy #1
setup
    lda (COPY1),y
    sta COPY3,y
    dey
    bpl setup
;
    jsr len
    lda COPY3+1
    clc
    adc einde
    tax
    lda COPY3
    adc einde+1
    cmp #$c0 
    bcs out
    stx einde
    sta einde+1
    jmp COPYDN
;
eof
    ldx #201 ;END-OF-FIL
    !by $2c ;SKIP 2
out
    ldx #52 ;OUT OF MEM
    jmp RUNERR
;
teof
    lda FREKZP
    sec
    sbc einde
    lda FREKZP+1
    sbc einde+1
    rts
;
get
    jsr teof
    bcs eof
    lda #1
    jsr FNDPAR
    lda COPY1
    clc 
    adc #<2
    sta COPY2
    lda COPY1+1
    adc #>2
    sta COPY2+1
    ldy #1
    lda (COPY1),y
    sec
    sbc (FREKZP),y
    dey
    lda (COPY1),y
    sbc (FREKZP),y
    bcc noroom
    lda FREKZP
    ldy FREKZP+1
    sta COPY1
    sty COPY1+1
    ldy #1
setup1
    lda (FREKZP),y
    sta COPY3,y
    dey
    bpl setup1
    jsr len
    lda FREKZP
    clc
    adc COPY3+1
    sta FREKZP
    lda FREKZP+1
    adc COPY3
    sta FREKZP+1
    jmp copy
;
noroom
    lda (COPY1),y
    sta COPY3
    pha
    iny
    lda (COPY1),y
    sta COPY3+1
    pha
    lda FREKZP
    ldy FREKZP+1
    sta COPY1
    sty COPY1+1
    jsr len
    ldy #1
    lda (FREKZP),y
    clc
    adc FREKZP
    tax
    dey
    lda (FREKZP),y
    adc FREKZP+1
    tay
    txa
    clc
    adc #<2
    sta FREKZP
    tya
    adc #>2
    sta FREKZP+1
    ldy #1
    pla
    sta (COPY1),y
    dey
    pla
    sta (COPY1),y
;
copy
    ldx COPY3
    lda COPY3+1
    tay
    beq l001
    eor #255
    tay
    iny
    clc
    lda COPY1
    adc COPY3+1
    sta COPY1
    bcs l002
    dec COPY1+1
l002
    clc
    lda COPY2
    adc COPY3+1
    sta COPY2
    bcs l003
    dec COPY2+1
l003
    lda (COPY1),y
    sta(COPY2),y
    iny
    bne l003
    inc COPY1+1
    inc COPY2+1
l001
    dex
    bpl l003
    rts
;
len
    lda COPY3+1
    clc
    adc #<2
    sta COPY3+1
    lda COPY3
    adc #>2
    sta COPY3
    rts
;
end