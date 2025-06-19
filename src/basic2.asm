; ------------------------
; this version of basic can be found as on 'Holland Disk 4',
; and is different from the 2 versions berfore
; prepared the source, so it can be assembled with ACME
; Claus Schlereth 2025-06-18
; ------------------------

;-------------------------------;
; PACKAGE 'BASIC'               ;
;                               ;
; RUNNING A BASIC PROGRAM FROM  ;
; CBM COMAL-80 VS 2.01          ;
;                               ;
; BY M.BOKHORST, 30-08-1985     ;
;                               ;
; DUTCH COMAL80 USERS GROUP     ;
; LAST REVISION: 120386         ;
;-------------------------------;
;
PC =$9E00
;
SETNAM =$FFBD
SETLFS =$FFBA
LOAD =$FFD5
OPEN =$FFC0
CHROUT =$FFD2
PROC =112
ENDPR =126
VALUE =114
INT =1
STR =2
RUNERR =$C9FB
DUMMY =$CA2F
DEFPAG =%01000110
FNDPAR =$C896
COPY1 =$45
BANK =1
OVRLAY =$DE00
SWITCH =$DF00
NMINV =$0318
IMAIN =$0302
CBM80 =$8008
MSGFLG =$9D
TXTTAB =$2B
CR =13
INTERP =$A7AE
VARTAB =$2D
SPACE =$033C
INJUMP =$6C
RESET =$FFFC
STOREX =$8E
STATUS =$90
REPORT =$E0F9
IOINIT =$FF84
RAMTAS =$FF87
RESTOR =$FF8A
CINT =$FF81
BASVEC =$E453
BSINIT =$E3BF
INTRO =$E422
LDERR =$E19C
BIND =$A533
RUN =$A659
BCKFLG =$07FE
RESERV =$07FF
PRINT =$AB1E
GETIN =$FFE4
DIRECT =$3A
TXTCOL =$0286
BORDER =$D020
BACKGR =$D021
MEMSIZ =$37
TOPOS =$0283
;
;- START MODULE ----------------;
;
*=PC
;
;- PACKAGE DEFINITION ----------;
;
    !by DEFPAG
    !word END
    !word DUMMY

    !pet 5,"basic"
    !word PROCS
    !word DUMMY
    !by 0
;
;- PROCS & FUNCS ---------------;
;
PROCS
    !pet 2,"go"
    !word HEAD
    !by 0
;
;- HEADERS ---------------------;
;
HEAD
    !by PROC
    !word START
    !by 3
    !by VALUE+STR
    !by VALUE+INT
    !by VALUE+INT
    !by ENDPR
;
;- CODE ------------------------;
;
START
    LDA #1
    JSR FNDPAR
    LDY #2
    LDA (COPY1),Y
    BNE ARGERR
    INY
    LDA (COPY1),Y
    BEQ ARGERR
    CMP #17
    BCC OK
ARGERR LDX #1
    JMP RUNERR
OK
    STA EIND
    LDX #0
    INY
NAME
    LDA (COPY1),Y
    STA EIND+1,X
    INX
    INY
    CPX EIND
    BCC NAME
    LDA #2
    JSR FNDPAR
    LDY #0
    LDA (COPY1),Y
    INY
    ORA (COPY1),Y
    STA BCKFLG
    LDA #3
    JSR FNDPAR
    LDY #0
    LDA (COPY1),Y
    INY
    ORA (COPY1),Y
    STA RESERV
;
    SEI
    LDA #$37
    STA BANK
    LDX #$E0
    LDY #7
    LDA #0
PORT
    STA SWITCH,Y
    DEY
    BPL PORT
    STX OVRLAY
    STX CBM80
    LDX #$FF
    TXS
    CLD
    JSR IOINIT
    JSR RAMTAS
    JSR RESTOR
    JSR CINT
    LDA #2
    STA BORDER
    LDA #0
    STA BACKGR
    LDA #1
    STA TXTCOL
    CLI
;
    LDA RESERV
    BEQ NORES
    LDA #<PC
    LDY #>PC
    STA MEMSIZ
    STY MEMSIZ+1
    STA TOPOS
    STY TOPOS+1
NORES
    JSR BASVEC
    JSR BSINIT
    JSR INTRO
    LDX #$FB
    TXS
    LDA BCKFLG
    BEQ NOBACK
    LDA #<NMI
    LDY #>NMI
    STA NMINV
    STY NMINV+1
    LDA #<BACK
    LDY #>BACK
    STA IMAIN
    STY IMAIN+1
NOBACK
    LDA #$80
    STA MSGFLG
    LDA #$FF
    STA DIRECT
;
    LDA EIND
    LDX #<NA
    LDY #>NA
    JSR SETNAM
    LDX #8
    LDY #$FF
    JSR SETLFS
    LDA #$00
    LDX TXTTAB
    LDY TXTTAB+1
    JSR LOAD
    BCS BACK
NOLERR
    STX VARTAB
    STY VARTAB+1
    JSR BIND
    LDA #0
    STA MSGFLG
    JSR RUN
    LDA #CR
    JSR CHROUT
    JMP INTERP
;
NMI
    LDX #$80
    LDY #$00
WAIT
    DEY
    BNE WAIT
    DEX
    BNE WAIT
BACK
    LDX #0
NEXT
    LDA TEXT,X
    BEQ LAST
    JSR CHROUT
    INX
    BNE NEXT
LAST
    JSR GETIN
    CMP #CR
    BNE LAST
    SEI
    LDA #$37
    STA BANK
    LDX #$80
    LDY #7
    LDA #0
LABEL
    STA SWITCH,Y
    DEY
    BPL LABEL
    LDA #STOREX
    STA SPACE
    LDA #<OVRLAY
    STA SPACE+1
    LDA #>OVRLAY
    STA SPACE+2
    LDA #INJUMP
    STA SPACE+3
    LDA #<RESET
    STA SPACE+4
    LDA #>RESET
    STA SPACE+5
    JMP SPACE
;
EIND
NA =EIND+1
;
    !by 0,0,0,0,0,0,0,0
    !by 0,0,0,0,0,0,0,0,0
;
TEXT
    !by CR
    !pet "press <return> for comal"
    !by 0
END
;
