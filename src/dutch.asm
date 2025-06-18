; ###############################################################
; #                                                             #
; #  DUTCH FOR COMAL SOURCE CODE                                #
; #  Version 1.1 (2024.02.19)                                   #
; #  Copyright (c) 2023 Claus Schlereth                         #
; #                                                             #
; #  This version of the source code is under MIT License       #
; #                                                             #
; ###############################################################

!source "c64symb.asm"

*=$9400

    !by DEFPAG          ; MEMORY MAP
    !word END          ; END OF PACKAGE
    !word .sense        ; SENSE ROUTINE

    !pet $05,"dutch"    ; NAME
    !word .noproc       ; PROCEDURE TABLE
    !word DUMMY         ; INIT ROUTINE

.sense
    CPY #$02            ; LINK
    BEQ .link
    CPY #$03            ; DISCARD
    BEQ .discard
    RTS
-----------------------------------
.discard
    JSR GOTO            ; jmp to another page.
    !by PAGE1
    !word $A686         ; set englich
-----------------------------------
.text
    !pet $0D," dutch ver. 1.1"
    !by $00

    !pet "claus schlereth in 2023"

.link
    LDY #00
-   LDA .text,Y
    BEQ .fertig
    JSR $FFD2
    INY
    BNE -
.fertig
    LDA #<errmsg_dutch
    LDX #>errmsg_dutch
    LDY #$46
    STA IERTXT          ; error message data
    STX IERTXT+1        ; the sytem will look here
    STY IERTXT+2        ; where to find the error messages
    RTS
-----------------------------------
.noproc
    !by $00
-----------------------------------
errmsg_dutch
; these are the Dutch error messages
    !word errmsg2_dutch
.msg0    !by 0
    !by .msg1-*-1
    !pet "fout in report"
.msg1    !by 1
    !by .msg2-*-1
    !pet "fout in argument"
.msg2    !by 2
    !by .msg3-*-1
    !pet "overflow"
.msg3    !by 3
    !by .msg4-*-1
    !pet "deling door nul"
.msg4    !by 4
    !by .msg5-*-1
    !pet "substring-fout"
.msg5    !by 5
    !by .msg6-*-1
    !pet "waarde buiten bereik"
.msg6    !by 6
    !by .msg7-*-1
    !pet "step = 0"
.msg7    !by 7
    !by .msg8-*-1
    !pet "niet-toegestane grenswaarde"
.msg8    !by 8
    !by .msg10-*-1
    !pet "fout in using-string"
;
.msg10    !by 10
    !by .msg11-*-1
    !pet "index buiten bereik"
.msg11    !by 11
    !by .msg13-*-1
    !pet "niet-toegestane filenaam"
;
.msg13    !by 13
    !by .msg14-*-1
    !pet "verify-fout"
.msg14    !by 14
    !by .msg15-*-1
    !pet "programma te groot"
.msg15    !by 15
    !by .msg16-*-1
    !pet "geen comal-kode"
.msg16    !by 16
    !by .msg17-*-1
    !pet "geen comal-programma"
.msg17    !by 17
    !by .msg18-*-1
    !pet "programma voor andere comal-versie"
.msg18    !by 18
    !by .msg30-*-1
    !pet "onbekend file-attribuut"
;
;
;
.msg30    !by 30
    !by .msg31-*-1
    !pet "foutief kleurnummer"
.msg31    !by 31
    !by .msg32-*-1
    !pet "foutieve grenswaarde"
.msg32    !by 32
    !by .msg33-*-1
    !pet "foutief tekeningnummer"
.msg33    !by 33
    !by .msg34-*-1
    !pet "tekening-lengte moet 64 zijn"
.msg34    !by 34
    !by .msg35-*-1
    !pet "foutief sprite-nummer"
.msg35    !by 35
    !by .msg36-*-1
    !pet "foutief stemnummer"
.msg36    !by 36
    !by .msg51-*-1
    !pet "fout in noot"
;
;
;
.msg51    !by 51
    !by .msg52-*-1
    !pet "systeem-fout"
.msg52    !by 52
    !by .msg53-*-1
    !pet "geheugenruimte te klein"
.msg53    !by 53
    !by .msg54-*-1
    !pet "foutieve dimensie in parameter"
.msg54    !by 54
    !by .msg55-*-1
    !pet "parameter moet een array zijn"
.msg55    !by 55
    !by .msg56-*-1
    !pet "te weinig indices"
.msg56    !by 56
    !by .msg57-*-1
    !pet "toekenning niet mogelijk"
.msg57    !by 57
    !by .msg58-*-1
    !pet "niet geimplementeerd"
.msg58    !by 58
    !by .msg59-*-1
    !pet "'con' niet mogelijk"
.msg59    !by 59
    !by .msg60-*-1
    !pet "programma is gewijzigd"
.msg60    !by 60
    !by .msg61-*-1
    !pet "te veel indices"
.msg61    !by 61
    !by .msg62-*-1
    !pet "return-statement ontbreekt"
.msg62    !by 62
    !by .msg67-*-1
    !pet "geen variabele"
;
.msg67    !by 67
    !by .msg68-*-1
    !pet "par-lijst verschilt cq niet 'closed'"
.msg68    !by 68
    !by .msg69-*-1
    !pet "geen closed proc/func in file"
.msg69    !by 69
    !by .msg70-*-1
    !pet "te weinig parameters"
.msg70    !by 70
    !by .msg71-*-1
    !pet "foutief index-type"
.msg71    !by 71
    !by .msg72-*-1
    !pet "parameter moet een variabele zijn"
.msg72    !by 72
    !by .msg73-*-1
    !pet "foutief parameter-type"
.msg73    !by 73
    !by .msg74-*-1
    !pet "non-ram load"
.msg74    !by 74
    !by .msg75-*-1
    !pet "checksum-fout in object-file"
.msg75    !by 75
    !by .msg76-*-1
    !pet "geheugendeel niet toegankelijk"
.msg76    !by 76
    !by .msg77-*-1
    !pet "te veel libraries"
.msg77    !by 77
    !by .msg78-*-1
    !pet "geen object-file"
.msg78    !by 78
    !by .msg79-*-1
    !pet "geen passende when-waarde gevonden"
.msg79    !by 79
    !by .msg101-*-1
    !pet "te veel parameters"
;
;
;
.msg101    !by 101
    !by .msg102-*-1
    !pet "syntax-fout"
.msg102    !by 102
    !by .msg103-*-1
    !pet "verkeerd type"
.msg103    !by 103
    !by .msg104-*-1
    !pet "statement te lang of te ingewikkeld"
.msg104    !by 104
    !by .msg106-*-1
    !pet "alleen als statement, niet als commando"
;
.msg106    !by 106
    !by .msg108-*-1
    !pet "regelnummers uit 1-9999"
;
.msg108    !by 108
    !by .msg109-*-1
    !pet "proc/func bestaat niet"
.msg109    !by 109
    !by .msg110-*-1
    !pet "hier geen structuur-statement"
.msg110    !by 110
    !by .msg111-*-1
    !pet "geen statement"
.msg111    !by 111
    !by .msg112-*-1
    !pet "regelnummers buiten bereik"
.msg112    !by 112
    !by .msg113-*-1
    !pet "programma beveiligd"
.msg113    !by 113
    !by .msg114-*-1
    !pet "onjuist teken"
.msg114    !by 114
    !by .msg115-*-1
    !pet "fout in konstante"
.msg115    !by 115
    !by .msg200-*-1
    !pet "fout in exponent-waarde"
;
;
;
.msg200    !by 200
    !by .msg201-*-1
    !pet "eod gelezen"
.msg201    !by 201
    !by .msg202-*-1
    !pet "eof gelezen"
.msg202    !by 202
    !by .msg203-*-1
    !pet "file is al open"
.msg203    !by 203
    !by .msg204-*-1
    !pet "file niet open"
.msg204    !by 204
    !by .msg205-*-1
    !pet "geen invoer-file"
.msg205    !by 205
    !by .msg206-*-1
    !pet "geen uitvoer-file"
.msg206    !by 206
    !by .msg207-*-1
    !pet "numerieke konstante verwacht"
.msg207    !by 207
    !by .msg208-*-1
    !pet "geen random-file"
.msg208    !by 208
    !by .msg209-*-1
    !pet "eenheid niet toegankelijk"
.msg209    !by 209
    !by .msg210-*-1
    !pet "maximum aantal files open"
.msg210    !by 210
    !by .msg211-*-1
    !pet "read-fout"
.msg211    !by 211
    !by .msg212-*-1
    !pet "write-fout"
.msg212    !by 212
    !by .msg213-*-1
    !pet "te kort blok"
.msg213    !by 213
    !by .msg214-*-1
    !pet "te lang blok"
.msg214    !by 214
    !by .msg215-*-1
    !pet "checksum-fout"
.msg215    !by 215
    !by .msg216-*-1
    !pet "logisch einde van de tape"
.msg216    !by 216
    !by .msg217-*-1
    !pet "file bestaat niet"
.msg217    !by 217
    !by .msg218-*-1
    !pet "onbekende eenheid"
.msg218    !by 218
    !by .msg219-*-1
    !pet "operatie niet toegestaan"
.msg219    !by 219
    !by .msg230-*-1
    !pet "i/o afgebroken"
;
;
;
.msg230    !by 230
    !by .msg231-*-1
    !pet 13,"end op "
.msg231    !by 231
    !by .msg232-*-1
    !pet 13,"stop in "
.msg232    !by 232
    !by .msg233-*-1
    !pet " bytes vrij ",13,13
.msg233    !by 233
    !by .msg242-*-1
    !pet "fout"
;
;
;
.msg242    !by 242
    !by .msg243-*-1
    !pet "in "
.msg243    !by 243
    !by .msg244-*-1
    !pet "prog  data  vrij",13
.msg244    !by 244
    !by .msg245-*-1
    !pet "programma-stop in"
.msg245    !by 245
    !by .msg246-*-1
    !pet "aangeroepen in"
.msg246    !by 246
    !by .msg255-*-1
    !pet "binnen"
;
;
.msg255    !by 255 ;marker for set 1 end ???
;
;
errmsg2_dutch
mg1    !by mg2-*-1
    !by 249
mg2    !by mg3-*-1
    !by 250
;
mg3    !by mg4-*-1
    !pet 97," of ",95
mg4    !by mg5-*-1
    !pet "label onbekend"
mg5    !by mg6-*-1
    !pet "naam reeds gedefinieerd"
mg6    !by mg7-*-1
    !pet "geen label"
mg7    !by mg8-*-1
    !pet "string niet gedimensioneerd"
mg8    !by mg9-*-1
    !pet "geen package"
mg9    !by mg10-*-1
    !pet "uitdrukking"
mg10    !by mg11-*-1
    !pet "variabele"
mg11    !by mg12-*-1
    !pet "operand"
mg12    !by mg13-*-1
    !pet "variabele-naam"
mg13    !by mg14-*-1
    !pet "numerieke variabele-naam"
mg14    !by mg15-*-1
    !pet "numerieke uitdrukking"
mg15    !by mg16-*-1
    !pet "string-uitdrukking"
mg16    !by mg17-*-1
    !pet 198," of ",96
mg17    !by mg18-*-1
    !pet 97," of ",202
mg18    !by mg19-*-1
    !pet 198," of ",199
mg19    !by mg20-*-1
    !pet 203," of ",205
mg20    !by mg21-*-1
    !pet "mode"
mg21    !by mg22-*-1
    !pet "konstante"
mg22    !by mg23-*-1
    !pet "regelnummer"
mg23    !by mg24-*-1
    !pet "binaire konstante"
mg24    !by mg25-*-1
    !pet "label"
mg25    !by mg26-*-1
    !pet 113,"/",114,"/",117
mg26    !by mg27-*-1
    !by 117
mg27    !by mg28-*-1
    !by 118
mg28    !by mg29-*-1
    !by 240
mg29    !by mg30-*-1
    !by 245
mg30    !by mg31-*-1
    !by 176
mg31    !by mg32-*-1
    !by 119
mg32    !by mg33-*-1
    !pet 178,"/",147,"/",116
mg33    !by mg34-*-1
    !pet 178,"/",147,"/",116
mg34    !by mg35-*-1
    !by 116
mg35    !by mg36-*-1
    !pet " niet verwacht"
mg36    !by mg37-*-1
    !pet " ontbreekt"
mg37    !by mg38-*-1
    !pet " verwacht, geen "
mg38    !by mg39-*-1
    !pet "real-konstante"
mg39    !by mg40-*-1
    !pet "integer-konstante"
mg40    !by mg41-*-1
    !pet "string-konstante"
mg41    !by mg42-*-1
    !pet "naam"
mg42    !by mg43-*-1
    !pet "integer-naam"
mg43    !by mg44-*-1
    !pet "string-naam"
mg44    !by mg45-*-1
    !pet " niet toegestaan in controle-structuur"
mg45    !by mg46-*-1
    !pet " zonder "
mg46    !by mg47-*-1
    !by 244
mg47    !by mg48-*-1
    !by 178
mg48    !by mg49-*-1
    !pet 226," alleen in closed proc/func"
mg49    !by mg50-*-1
    !pet "verkeerd type van "
mg50    !by mg51-*-1
    !pet "verkeerde naam in "
mg51    !by mg52-*-1
    !pet 104," of ",206
mg52    !by mg53-*-1
    !pet "hex-konstante"
mg53    !by mg54-*-1
    !pet "foutief ",128
mg54    !by mg55-*-1
    !pet "statement/procedure onbekend"
mg55    !by mg56-*-1
    !pet "geen procedure"
mg56    !by mg57-*-1
    !pet "variabele bestaat niet"
mg57    !by mg58-*-1
    !pet "verkeerd type"
mg58    !by mg59-*-1
    !pet "onjuist functie-type"
mg59    !by mg60-*-1
    !pet "geen array of functie"
mg60    !by mg61-*-1
    !pet "geen eenvoudige variabele"
mg61    !by mg62-*-1
    !pet "array cq functie bestaat niet"
mg62    !by mg63-*-1
    !pet "foutief array-type"
mg63    !by mg64-*-1
    !pet "import-fout"
mg64    !by mg65-*-1
    !pet "onbekend package"
mg65
;
END
