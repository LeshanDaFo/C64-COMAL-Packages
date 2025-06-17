; #######################################################################
; #                                                                     #
; #  C64 COMAL80 PACKAGE MLW'SORTS                                      #
; #                                                                     #
; #  This source code was created based on "pkg.mlw'sorts.seq"          #
; #  from CT16                                                          #
; #                                                                     #
; #  Version 1.04 (2023.09.20)                                          #
; #  Copyright (c) 2023 Claus Schlereth                                 #
; #                                                                     #
; #  This version of the source code is under MIT License               #
; #  https://github.com/LeshanDaFo/C64-COMAL-Packages/blob/main/LICENSE #
; #                                                                     #
; #######################################################################

; package version 1.04
; by robert ross (c)1986

; this program uses the address range at TBUFF ($02a7 - $02de), which is normaly used for storage of disc command 

!source"c64symb.asm"

*=$B690

    !by  DEFPAG                 ; 52KB RAM MEMORY MAP
    !word .end1                 ; the module end address
    !word SIGNAL                ; the address of the signal handler

; start of package table
;
    !pet 9,"mlw'sorts"          ; char amount, 'name'
    !word ptMlwsorts            ; LBD50 ; proc's name table address
    !word .init                 ; package init address (RTS)                   

    !by $00

vers_text
    !pet " 1.04 mlw'sorts  (c)1986 by robert ross."
    !pet "all rights reserved.  permission granted"
    !pet "to copy and use unchanged without fee.  "
    !by $00

    SEI
SIGNAL
LB71E
    CPY #$02
    BNE .init
    JSR Versionmlwsorts
    LDX #$14
-   LDA .stub_code,X
    STA TBUFF,X
    DEX
    BPL -
    JMP TBUFF
---------------------------------
.stub_code
    LDA #$F8
    AND $01
    ORA #$07
    STA $01
    LDA #$82
    STA $06
    STA $DE00
    JSR $8CBA
    JMP $8A5B
---------------------------------
.init
    RTS
---------------------------------
LB749
    BIT STKEY ; $91 stop key flag
    BMI +
    LDX #$09
    JMP RUNERR
---------------------------------
+   CLC
    LDA $02AA
    ADC $02AC
    STA COPY3
    LDA $02AB
    ADC $02AD
    LSR
    STA COPY3+1
    ROR COPY3
    JSR LB900
    LDA COPY1+1
    STA Q1+1
    LDX COPY1
    STX Q1
LB771
    LDA $02AF
    STA COPY3+1
    LDX $02AE
    STX COPY3
    JSR LB900
    LDA COPY1+1
    STA Q2+1
    LDX COPY1
    STX Q2
-   JSR TBUFF
    BCS ++
    CLC
    LDA $02B8
    ADC Q2
    STA Q2
    LDA $02B7
    ADC Q2+1
    STA Q2+1
    INC $02AE
    BNE +
    INC $02AF
+   BCC -
++  LDA Q1+1
    STA Q2+1
    LDX Q1
    STX Q2
    LDA $02B1
    STA COPY3+1
    LDX $02B0
    STX COPY3
    JSR LB900
    LDA COPY1+1
    STA Q1+1
    LDX COPY1
    STX Q1
-   JSR TBUFF
    BCS ++
    SEC
    LDA Q1
    SBC $02B8
    STA Q1
    LDA Q1+1
    SBC $02B7
    STA Q1+1
    SEC
    LDA $02B0
    SBC #$01
    STA $02B0
    BCS +
    LDA $02B1
    SBC #$00
    STA $02B1
+   JMP -
---------------------------------
++  LDA $02B0
    CMP $02AE
    LDA $02B1
    SBC $02AF
    SEC
    BPL +
    CLC
+   BCC ++
    LDA Q1+1
    STA COPY2+1
    LDX Q1
    STX COPY2
    LDA $02AF
    STA COPY3+1
    LDX $02AE
    STX COPY3
    JSR LB900
    JSR LB94A
    INC $02AE
    BNE +
    INC $02AF
+   SEC
    LDA $02B0
    SBC #$01
    STA $02B0
    BCS +
    LDA $02B1
    SBC #$00
    STA $02B1
+   LDA $02B0
    CMP $02AE
    LDA $02B1
    SBC $02AF
    SEC
    BPL +
    CLC
+   BCC ++
    LDA Q2+1
    STA Q1+1
    LDX Q2
    STX Q1
    JMP LB771
---------------------------------
++  LDX #$FF
    LDA $02AA
    CMP $02B0
    LDA $02AB
    SBC $02B1
    SEC
    BPL +
    CLC
+   TXA
    ROL
    TAX
    LDA $02AE
    CMP $02AC
    LDA $02AF
    SBC $02AD
    SEC
    BPL +
    CLC
+   TXA
    ROL
    ADC #$00
    BEQ ++
    CMP #$FD
    BNE +
    LDA #$04
    JSR EXCGST                  ; allocate local storage
    LDY #$03
    LDA $02AE
    STA (COPY2),Y
    DEY
    LDA $02AF
    STA (COPY2),Y
    DEY
    LDA $02AC
    STA (COPY2),Y
    DEY
    LDA $02AD
    STA (COPY2),Y
    INC $02C1
-   LDA $02B1
    STA $02AD
    LDX $02B0
    STX $02AC
    LDA $02AB
    STA $02AF
    LDX $02AA
    STX $02AE
    JMP LB749
---------------------------------
+   CMP #$FF
    BEQ +++
    BNE -
++  LDA $02C1
    BNE +
    RTS
---------------------------------
+   LDA #$04
    JSR EXCREM                  ; reclaim local storage
    LDY #$03
    LDA (STOS),Y
    STA $02AE
    DEY
    LDA (STOS),Y
    STA $02AF
    DEY
    LDA (STOS),Y
    STA $02AC
    DEY
    LDA (STOS),Y
    STA $02AD
    DEC $02C1
+++ LDA $02AF
    STA $02AB
    LDX $02AE
    STX $02AA
    LDA $02AD
    STA $02B1
    LDX $02AC
    STX $02B0
    JMP LB749
---------------------------------
LB900
    LDX #$10
    LDA #$00
    STA COPY1
    STA COPY1+1
    BEQ +
-   ASL COPY1
    ROL COPY1+1
    ROL COPY3
    ROL COPY3+1
+   LDA #$80
    BIT COPY3+1
    BEQ +
    CLC
    LDA COPY1
    ADC $02B8
    STA COPY1
    LDA COPY1+1
    ADC $02B7
    STA COPY1+1
    BCC +
    LDA #$00
    ADC COPY3
    STA COPY3
    BCC +
    LDA #$00
    ADC COPY3+1
    STA COPY3+1
+   DEX
    BNE -
    CLC
    LDA COPY1
    ADC $02B3
    STA COPY1
    LDA COPY1+1
    ADC $02B4
    STA COPY1+1
    RTS
---------------------------------
LB94A
    LDA Q2
    CMP COPY1
    BNE +
    LDA Q2+1
    CMP COPY1+1
    BNE +
    LDA COPY2
    STA Q2
    LDA COPY2+1
    STA Q2+1
    BNE ++
+   LDA Q2
    CMP COPY2
    BNE ++
    LDA Q2+1
    CMP COPY2+1
    BNE ++
    LDA COPY1
    STA Q2
    LDA COPY1+1
    STA Q2+1
++  LDA $02B6
    STA COPY3+1
    LDX $02B5
    STX COPY3
    LDY #$00
    BEQ +
-   LDA (COPY1),Y
    TAX
    LDA (COPY2),Y
    STA (COPY1),Y
    TXA
    STA (COPY2),Y
    INY
    BNE +
    INC COPY1+1
    INC COPY2+1
+   SEC
    LDA COPY3+1
    SBC #$01
    STA COPY3+1
    BCS +
    LDA COPY3
    SBC #$00
    STA COPY3
+   BCS -
    RTS
---------------------------------
LB9A5
    LDA #$00
    STA FREKZP+4
    BIT $55
    BVC +
    LDA Q1
    PHA
    LDA Q1+1
    PHA
    LDA Q2
    LDX Q2+1
    BVS ++
+   LDA Q2
    PHA
    LDA Q2+1
    PHA
    LDA Q1
    LDX Q1+1
++  JSR LBA8C
    STX FREKZP
    STA FREKZP+1
    SEC
    ROR $02C2
    LDA Q4+1
    STA Q3+1
    LDX Q4
    STX Q3
    LDA $02BC
    STA $02BA
    LDX $02BB
    STX $02B9
    PLA
    TAX
    PLA
    JSR LBA8C
    CMP FREKZP+1
    BCC +
    BNE ++
    CPX FREKZP
    BCC +
    BNE ++
    CLC
    BCC ++
+   STX FREKZP
    STA FREKZP+1
    LDA #$00
    STA $02C2
    SEC
++  ROR $02C2
    LDA FREKZP+4
    EOR #$C0
    BEQ +
    ROL
    ROL
    PLA
    PLA
    RTS
---------------------------------
+   LDA $02C2
    AND $56
    BPL +
    ROL $02C2
    ROL $02C2
    PLA
    PLA
    RTS
---------------------------------
+   LDY #$00
    BIT Q5+1
    BPL +
    LDA $02BC
    STA Q4+1
    LDX $02BB
    STX Q4
    LDA $02BA
    STA Q3+1
    LDX $02B9
    STX Q3
+   RTS
---------------------------------
LBA3A
    JSR LB9A5
-   LDA (Q4),Y
    CMP (Q3),Y
    BEQ ++
    PHP
    BIT $55
    BMI +
    PLP
    RTS
---------------------------------
+   PLP
    STY FREKZP+4
    TAY
    LDA (FREKZP+2),Y
    PHA
    LDY FREKZP+4
    LDA (Q3),Y
    TAY
    LDA (FREKZP+2),Y
    LDY FREKZP+4
    STA FREKZP+4
    PLA
    CMP FREKZP+4
    BEQ ++
    RTS
---------------------------------
++  LDA FREKZP
    BNE +
    DEC FREKZP+1
    BPL +
    ROL $02C2
    ROL $02C2
    RTS
---------------------------------
+   DEC FREKZP
    TYA
    CLC
    ADC Q5
    TAY
    EOR Q5+1
    BNE -
    CLC
    LDA Q3+1
    ADC Q5
    STA Q3+1
    CLC
    LDA Q4+1
    ADC Q5
    STA Q4+1
    BNE -
LBA8C
    STA Q4
    STX Q4+1
    LDY #$01
    LDA (Q4),Y
    CMP $02BD
    DEY
    LDA (Q4),Y
    SBC $02BE
    ROR FREKZP+4
    BMI +
    STY $02C3
    RTS
---------------------------------
+   INY
    LDA (Q4),Y
    STA $02BB
    CMP $02BF
    DEY
    LDA (Q4),Y
    STA $02BC
    SBC $02C0
    BCS +
    LDA #$00
    STA $02C3
    BEQ ++
+   LDA $02C0
    STA $02BC
    LDX $02BF
    STX $02BB
++  INC Q4
    BNE +
    INC Q4+1
+   CLC
    LDA Q4
    ADC $02BB
    STA $02BB
    LDA Q4+1
    ADC $02BC
    STA $02BC
    CLC
    LDA Q4
    ADC $02BD
    STA Q4
    LDA Q4+1
    ADC $02BE
    STA Q4+1
    SEC
    LDA $02BB
    SBC Q4
    TAX
    LDA $02BC
    SBC Q4+1
    RTS
---------------------------------
LBAFF
    BIT $55
    BVC +
    LDA Q1
    PHA
    LDA Q1+1
    PHA
    LDA Q2
    LDX Q2+1
    BNE ++
+   LDA Q2
    PHA
    LDA Q2+1
    PHA
    LDA Q1
    LDX Q1+1
++  STX Q3+1
    STA Q3
    PLA
    STA Q4+1
    PLA
    STA Q4
LBB23
    LDY #$01
    LDA (Q4),Y
    CMP (Q3),Y
    DEY
    LDA (Q4),Y
    SBC (Q3),Y
    BVS +
    EOR #$80
+   ROL
    RTS
---------------------------------
LBB34
    BIT $55
    BVC +
    LDA Q1
    STA Q4
    LDA Q1+1
    STA Q4+1
    LDA Q2
    LDY Q2+1
    BNE ++
+   LDA Q2
    STA Q4
    LDA Q2+1
    STA Q4+1
    LDA Q1
    LDY Q1+1
++  STA Q3
    STY Q3+1
LBB56
    LDY #$00
    LDA (Q3),Y
    ORA (Q4),Y
    BNE +
    SEC
    RTS
---------------------------------
+   INY
    LDA (Q3),Y
    EOR (Q4),Y
    BPL +
    LDA (Q3),Y
    ROL
    RTS
---------------------------------
+   DEY
    LDA (Q4),Y
    CMP (Q3),Y
    BEQ +
--  INY
    ROR
    EOR (Q3),Y
    ROL
    RTS
---------------------------------
+   INY
    LDA (Q3),Y
    EOR #$80
    ROL
    LDY #$04
-   LDA (Q4),Y
    SBC (Q3),Y
    DEY
    BNE -
    BEQ --
LBB89
    PHA
    SEC
    SBC #$01
    JSR FNDPAR                  ; Find parameter
    LDY #$00
    LDA (COPY1),Y
    STA $02BE
    INY
    LDA (COPY1),Y
    STA $02BD
    PLA
    JSR FNDPAR                  ; Find parameter
    LDY #$00
    LDA (COPY1),Y
    STA $02C0
    INY
    LDA (COPY1),Y
    STA $02BF
    SEC
    SBC $02BD
    TAX
    LDA $02C0
    SBC $02BE
    PHP
    BVC +
    EOR #$80
+   BPL +
    JSR ++
+   PLP
    RTS
---------------------------------
++  LDA $02BE
    LDY $02C0
    STY $02BE
    STA $02C0
    LDA $02BD
    LDY $02BF
    STY $02BD
    STA $02BF
    SEC
    SBC $02BD
    TAX
    LDA $02C0
    SBC $02BE
    RTS
---------------------------------
LBBE9
    LDA #$4C
    STA TBUFF
    CLD
    LDY #$00
    STY $55
    STY $02AA
    STY $02AB
    STY $02AE
    STY $02AF
    LDA #$03
    JSR LBB89
    BPL +
    LDY #$40
    STY $55
+   STX $02AC
    STX $02B0
    STA $02AD
    STA $02B1
    LDA #$01
    JSR FNDPAR                  ; Find parameter
    LDY #$00
    LDA (COPY1),Y
    STA $02B3
    INY
    LDA (COPY1),Y
    STA $02B4
    JSR LBC39
    JSR LB900
    LDA COPY1+1
    STA $02B4
    LDX COPY1
    STX $02B3
    RTS
---------------------------------
LBC39
    LDY #$06
    LDA (COPY1),Y
    CMP $02BF
    DEY
    LDA (COPY1),Y
    SBC $02C0
    BVC +
    EOR #$80
+   BPL +
.error5
    LDX #$05
    JMP RUNERR
---------------------------------
+   SEC
    DEY
    LDA $02BD
    SBC (COPY1),Y
    STA COPY3
    LDA $02BE
    DEY
    SBC (COPY1),Y
    STA COPY3+1
    BVC +
    EOR #$80
+   BMI .error5
    RTS
---------------------------------
LBC69
    LDA #$05
    JSR LBB89
    BPL +
    LDY #$FF
    STY Q5
    STY Q5+1
LBC76
+   LDA #$38
    STA COPY1
    LDA #$00
    STA COPY1+1
    JMP LBC39
---------------------------------
LBC81
    LDA #$06
    JSR FNDPAR                  ; Find parameter
    LDY #$02
    LDA (COPY1),Y
    INY
    ORA (COPY1),Y
    BNE +
    LDA #$00
    STA $02C3
    RTS
---------------------------------
+   CLC
    LDA COPY1
    ADC #$04
    STA FREKZP+2
    LDA COPY1+1
    ADC #$00
    STA FREKZP+3
    LDA $55
    ORA #$80
    STA $55
    RTS
---------------------------------
LBCA9
    STA $56
    LDA #$01
    STA Q5
    STA $02C3
    STA Q1+1
    JSR FNDPAR                  ; Find parameter
    LDY #$00
    LDA (COPY1),Y
    TAX
    INY
    LDA (COPY1),Y
    STA COPY1+1
    STX COPY1
    LDA (COPY1),Y
    TAX
    STA Q2+1
    ADC #$02
    STA $02B6
    DEY
    STY Q5+1
    STY Q1
    LDA (COPY1),Y
    STA Q2
    TYA
    ADC (COPY1),Y
    STA $02B5
    TXA
    ADC #$04
    STA $02B8
    TYA
    ADC (COPY1),Y
    STA $02B7
    JSR LBBE9
    LDY #$00
    STY $02BE
    LDA (COPY1),Y
    STA $02C0
    INY
    STY $02BD
    LDA (COPY1),Y
    STA $02BF
    LDA #<LBA3A
    STA $02A8
    LDA #>LBA3A
    STA $02A9
    CLC
    LDA #$02
    ADC COPY1
    STA $02B3
    LDA #$00
    ADC COPY1+1
    STA $02B4
    RTS
---------------------------------
;
;
;
Fpsort
    LDX #<LBB34
    LDY #>LBB34
    LDA #$05
    BNE + ; jmp

;
;
;
Intsort
    LDX #<LBAFF
    LDY #>LBAFF
    LDA #$02
+   STX $02A8
    STY $02A9
    STA $02B6
    STA $02B8
    LDA #$00
    STA $02B5
    STA $02B7
    JSR LBBE9
    JMP LB749
---------------------------------
;
;
;
Dimlen
    LDA #$01
    JSR FNDPAR                  ; Find parameter
    LDY #$00
    LDA (COPY1),Y
    TAX
    INY
    LDA (COPY1),Y
    JMP INTFPA                  ; float and push integer (0 .. 65535)
---------------------------------
ptMlwsorts
LBD50
    !pet 7,"fp'sort"
    !word phFpsort              ; proc header
    !pet 8,"int'sort"
    !word phIntsort             ; proc header
    !pet 8,"str'sort"
    !word phStrsort             ; proc header
    !pet 9,"str'lsort"
    !word phStrlsort            ; proc header
    !pet 7,"xl'sort"
    !word phXlsort              ; proc header
    !pet 8,"xl'lsort"
    !word phXllsort             ; proc header
    !pet 6,"dimlen"
    !word phDimlen              ; proc header
    !pet 7,"lj'sort"
    !word phLjsort              ; proc header
    !pet 7,"rj'sort"
    !word phRjsort              ; proc header
    !pet 8,"lj'lsort"
    !word phLjlsort             ; proc header
    !pet 8,"rj'lsort"
    !word phRjlsort             ; proc header
    !pet 11,"str'sort'fp"
    !word phStrsortfp           ; proc header
    !pet 12,"str'sort'int"
    !word phStrsortint          ; proc header
    !pet 17,"version'mlw'sorts"
    !word phVersionmlwsorts     ; proc header
    !pet 6,"str'fp"
    !word phStrfp               ; proc header
    !pet 6,"fp'str"
    !word phFpstr               ; proc header
    !pet 7,"str'int"
    !word phStrint              ; proc header
    !pet 7,"int'str"
    !word phIntstr              ; proc header

    !by $00

phStrfp
!by FUNC
    !word Strfp
    !by 1
    !by VALUE + STR
    !by ENDFNC

phFpstr
    !by FUNC + STR
    !word Fpstr
    !by 1
    !by VALUE + REAL
    !by ENDFNC

phStrint
    !by FUNC + INT
    !word Strint
    !by 1
    !by VALUE + STR
    !by ENDFNC

    !by $00

phIntstr
    !by FUNC + STR
    !word Intstr
    !by 1
    !by VALUE + INT
    !by ENDFNC


;
;
;
Strfp
    LDA #$05
    JMP LBE50

;
;
;
Fpstr
    LDA #$05
-   PHA
    LDA #$02
    JSR EXCGST                  ; allocate local storage
    LDA #$00
    TAY
    STA (COPY2),Y
    INY
    PLA
    STA (COPY2),Y
    RTS
;
;
;
Intstr
    LDA #$02
    BNE - ; jmp
LBE50
    PHA
    LDA #$01
    JSR FNDPAR                  ; Find parameter
    LDY #$02
    LDA (COPY1),Y
    BNE .error4
    INY
    PLA
    CMP (COPY1),Y
    BNE .error4
    RTS
---------------------------------
.error4
    LDX #$04
    JMP RUNERR
---------------------------------
;
;
;
Strint
    LDA #$02
    JSR LBE50
    LDY #$05
    LDA (COPY1),Y
    TAX
    DEY
    LDA (COPY1),Y
    JMP PSHINT                  ; float & push integer (-32768 32767)
---------------------------------
;
; phFpsort
;
phFpsort
    !by PROC
    !word Fpsort
    !by 3
    !by REF + ARRAY + REAL, 1
    !by VALUE + INT
    !by VALUE + INT
    !by ENDPRC

phIntsort
    !by PROC
    !word Intsort
    !by 3
    !by REF + ARRAY + INT, 1
    !by VALUE + INT
    !by VALUE + INT
    !by ENDPRC

phStrsort
    !by FUNC
    !word Strsort
    !by 5
    !by REF + ARRAY + STR, 1
    !by VALUE + INT
    !by VALUE + INT
    !by VALUE + INT
    !by VALUE + INT
    !by ENDFNC

phStrlsort
    !by FUNC
    !word Strlsort
    !by 5
    !by REF + ARRAY + STR, 1
    !by VALUE + INT
    !by VALUE + INT
    !by VALUE + INT
    !by VALUE + INT
    !by ENDFNC

phXlsort
    !by FUNC
    !word Xlsort
    !by 6
    !by REF + ARRAY + STR, 1
    !by VALUE + INT
    !by VALUE + INT
    !by VALUE + INT
    !by VALUE + INT
    !by REF + STR
    !by ENDFNC

phXllsort
    !by FUNC
    !word Xllsort
    !by 6
    !by REF + ARRAY + STR, 1
    !by VALUE + INT
    !by VALUE + INT
    !by VALUE + INT
    !by VALUE + INT
    !by REF + STR
    !by ENDFNC

phDimlen
    !by FUNC
    !word Dimlen
    !by 1
    !by REF + STR
    !by ENDFNC

phLjsort
    !by PROC
    !word Ljsort
    !by 3
    !by REF + ARRAY + STR, 1
    !by VALUE + INT
    !by VALUE + INT
    !by ENDPRC

phRjsort
    !by PROC
    !word Rjsort
    !by 3
    !by REF + ARRAY + STR, 1
    !by VALUE + INT
    !by VALUE + INT
    !by ENDPRC

phLjlsort
    !by PROC
    !word Ljlsort
    !by 3
    !by REF + ARRAY + STR, 1
    !by VALUE + INT
    !by VALUE + INT
    !by ENDPRC

phRjlsort
    !by PROC
    !word Rjlsort
    !by 3
    !by REF + ARRAY + STR, 1
    !by VALUE + INT
    !by VALUE + INT
    !by ENDPRC

phStrsortfp
    !by PROC
    !word Strsortfp
    !by 4
    !by REF + ARRAY + STR, 1
    !by VALUE + INT
    !by VALUE + INT
    !by VALUE + INT
    !by ENDPRC

phStrsortint
    !by PROC
    !word Strsortint
    !by 4
    !by REF + ARRAY + STR, 1
    !by VALUE + INT
    !by VALUE + INT
    !by VALUE + INT
    !by ENDPRC

phVersionmlwsorts
    !by FUNC + STR
    !word Versionmlwsorts
    !by 0
    !by ENDFNC


---------------------------------
;
;
;
Xllsort
    LDA #$80
    BNE + ; jmp

;
;
;
Xlsort
    LDA #$00
+   JSR LBCA9
    JSR LBC69
    JSR LBC81
LBF0A
    JSR LB749
    LDA #$05
    JSR EXCGST                  ; allocate local storage
    LDA $02C3
    BEQ +
    LDA #$01
+   TAX
    LDA #$00
    JMP PSHINT                  ; float & push integer (-32768 32767)

;
;
;
Strlsort
    LDA #$80
    BNE + ; jmp

;
;
;
Strsort
    LDA #$00
+   JSR LBCA9
    JSR LBC69
    JMP LBF0A
---------------------------------

;
;
;
Ljlsort
    LDA #$80
    BNE + ; jmp
;
;
;
Ljsort
    LDA #$00
+   JSR LBCA9
    JMP LB749
---------------------------------

;
;
;
Rjlsort
    LDA #$80
    BNE + ; jmp

;
;
;
Rjsort
    LDA #$00
+   JSR LBCA9
    LDA #$FF
    STA Q5
    STA Q5+1
    JMP LB749
---------------------------------

;
;
;
Strsortfp
    LDX #$04
    LDA #<LBF9A
    LDY #>LBF9A
    BNE +

;
;
;
Strsortint
    LDX #$01
    LDA #<LBFA0
    LDY #>LBFA0
+   STX $02B2
    PHA
    TYA
    PHA
    LDA #$00
    JSR LBCA9
    PLA
    STA $02A9
    PLA
    STA $02A8
    LDA #$04
    JSR FNDPAR                  ; Find parameter
    CLC
    LDY #$01
    LDA (COPY1),Y
    STA $02BD
    ADC $02B2
    STA $02BF
    DEY
    LDA (COPY1),Y
    STA $02BE
    ADC #$00
    STA $02C0
    JSR LBC76
    JSR LB749
    LDA $02C3
    BNE +
    JMP .error4
---------------------------------
+   RTS
---------------------------------
LBF9A
    JSR LB9A5
    JMP LBB56
---------------------------------
LBFA0
    JSR LB9A5
    JMP LBB23
---------------------------------

;
;
;
Versionmlwsorts
LBFA6
    LDA STOS
    STA COPY2
    CLC
    ADC #$7A
    TAX
    LDA STOS+1
    STA COPY2+1
    ADC #$00
    CMP SFREE+1
    BMI ++
    BEQ +
LBFBA
    LDX #$34
    JMP RUNERR
---------------------------------
+   CPX SFREE
    BPL LBFBA
++  STX STOS
    STA STOS+1
    LDY #$00
    LDA #<vers_text
    STA COPY1
    LDA #>vers_text
    STA COPY1+1
-   LDA (COPY1),Y
    STA (COPY2),Y
    INC COPY1
    BNE +
    INC COPY1+1
+   INC COPY2
    BNE +
    INC COPY2+1
+   LDA STOS
    CMP COPY2
    BNE -
    LDA STOS+1
    CMP COPY2+1
    BNE -
    RTS
---------------------------------

LBFEE 
    !by $0E,$1A,$1D,$11,$09,$34,$18,$3C
    !by $02,$0B,$1E,$21,$1B,$25,$2B,$24

.end1