; ###############################################################
; #                                                             #
; #  DEUTSCH FOR COMAL SOURCE CODE                              #
; #  Version 1.1 (2023.08.25)                                   #
; #  Copyright (c) 2023 Claus Schlereth                         #
; #                                                             #
; #  This version of the source code is under MIT License       #
; #                                                             #
; ###############################################################

!source "c64symb.asm"

*=$9400

    !by DEFPAG          ; MEMORY MAP
    !word END           ; END OF PACKAGE
    !word .sense        ; SENSE ROUTINE

    !pet $07,"deutsch"  ; NAME
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
    !pet $0D," deutsch ver. 1.1"
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
    LDA #<errmsg_deutsch
    LDX #>errmsg_deutsch
    LDY #$46
    STA IERTXT          ; error message data
    STX IERTXT+1        ; the sytem will look here
    STY IERTXT+2        ; where to find the error messages
    RTS
-----------------------------------
.noproc
    !by $00
-----------------------------------
errmsg_deutsch
; these are the German error messages
    !word errmsg2_deutsch
.msg0    !by 0
    !by .msg1-*-1
    !pet "report-fehler"
.msg1    !by 1
    !by .msg2-*-1
    !pet "argument falsch"
.msg2    !by 2
    !by .msg3-*-1
    !pet "ueberlauf"
.msg3    !by 3
    !by .msg4-*-1
    !pet "division durch null"
.msg4    !by 4
    !by .msg5-*-1
    !pet "teiltext-fehler"
.msg5    !by 5
    !by .msg6-*-1
    !pet "unerlaubter wert"
.msg6    !by 6
    !by .msg7-*-1
    !pet "step = 0"
.msg7    !by 7
    !by .msg8-*-1
    !pet "unerlaubte grenze"
.msg8    !by 8
    !by .msg10-*-1
    !pet "fehler bei 'print using'"

.msg10    !by 10
    !by .msg11-*-1
    !pet "unerlaubter index-wert"
.msg11    !by 11
    !by .msg13-*-1
    !pet "ungueltiger dateiname"
;
.msg13    !by 13
    !by .msg14-*-1
    !pet "fehler bei 'verify'"
.msg14    !by 14
    !by .msg15-*-1
    !pet "programm zu gross"
.msg15    !by 15
    !by .msg16-*-1
    !pet "schlechter comal-code"
.msg16    !by 16
    !by .msg17-*-1
    !pet "kein comal-programm"
.msg17    !by 17
    !by .msg18-*-1
    !pet "programm fuer andere comal-version"
.msg18    !by 18
    !by .msg30-*-1
    !pet "unbekanntes datei-attribut"
;
;
;
.msg30    !by 30
    !by .msg31-*-1
    !pet "unmoegliche farbe"
.msg31    !by 31
    !by .msg32-*-1
    !pet "unerlaubte bildgrenzen"
.msg32    !by 32
    !by .msg33-*-1
    !pet "unerlaubte muster-nummer"
.msg33    !by 33
    !by .msg34-*-1
    !pet "muster-laenge muss 64 sein"
.msg34    !by 34
    !by .msg35-*-1
    !pet "unerlaubte sprite-nummer"
.msg35    !by 35
    !by .msg36-*-1
    !pet "unmoegliche stimm-nummer"
.msg36    !by 36
    !by .msg51-*-1
    !pet "falsche note"
;
;
;
.msg51    !by 51
    !by .msg52-*-1
    !pet "system-fehler"
.msg52    !by 52
    !by .msg53-*-1
    !pet "speicher voll"
.msg53    !by 53
    !by .msg54-*-1
    !pet "falsche dimension bei parameter"
.msg54    !by 54
    !by .msg55-*-1
    !pet "parameter muss eine tabelle sein"
.msg55    !by 55
    !by .msg56-*-1
    !pet "zu wenig indizes"
.msg56    !by 56
    !by .msg57-*-1
    !pet "kann variable nicht zuweisen"
.msg57    !by 57
    !by .msg58-*-1
    !pet "nicht eingebaut"
.msg58    !by 58
    !by .msg59-*-1
    !pet "'con' nicht moeglich"
.msg59    !by 59
    !by .msg60-*-1
    !pet "programm wurde geaendert"
.msg60    !by 60
    !by .msg61-*-1
    !pet "zu viele indizes"
.msg61    !by 61
    !by .msg62-*-1
    !pet "funktionswert nicht uebergeben"
.msg62    !by 62
    !by .msg67-*-1
    !pet "keine variable"
;
.msg67    !by 67
    !by .msg68-*-1
    !pet "verschiedene parameter-listen oder nicht geschlossen"
.msg68    !by 68
    !by .msg69-*-1
    !pet "keine geschlossene proc/func in datei"
.msg69    !by 69
    !by .msg70-*-1
    !pet "zu wenig parameter"
.msg70    !by 70
    !by .msg71-*-1
    !pet "falscher indextyp"
.msg71    !by 71
    !by .msg72-*-1
    !pet "parameter muss variable sein"
.msg72    !by 72
    !by .msg73-*-1
    !pet "falscher parameter-typ"
.msg73    !by 73
    !by .msg74-*-1
    !pet "nicht-ram ladeversuch"
.msg74    !by 74
    !by .msg75-*-1
    !pet "falsche quersumme in .obj-datei"
.msg75    !by 75
    !by .msg76-*-1
    !pet "speicherbereich ist geschuetzt"
.msg76    !by 76
    !by .msg77-*-1
    !pet "zu viele bibliotheken"
.msg77    !by 77
    !by .msg78-*-1
    !pet "keine .obj-datei"
.msg78    !by 78
    !by .msg79-*-1
    !pet "kein passendes when"
.msg79    !by 79
    !by .msg101-*-1
    !pet "zu viele parameter"
;
;
;
.msg101    !by 101
    !by .msg102-*-1
    !pet "syntax-fehler"
.msg102    !by 102
    !by .msg103-*-1
    !pet "falscher typ"
.msg103    !by 103
    !by .msg104-*-1
    !pet "anweisung zu lang oder zu kompliziert"
.msg104    !by 104
    !by .msg106-*-1
    !pet "kein kommando, nur anweisung"
;
.msg106    !by 106
    !by .msg108-*-1
    !pet "zeilennummern: von 1 bis 9999"
;
.msg108    !by 108
    !by .msg109-*-1
    !pet "prozedur/funktion existiert nicht"
.msg109    !by 109
    !by .msg110-*-1
    !pet "strukturierte anweisung hier nicht erlaubt"
.msg110    !by 110
    !by .msg111-*-1
    !pet "keine anweisung"
.msg111    !by 111
    !by .msg112-*-1
    !pet "zeilennummern werden groesser als 9999"
.msg112    !by 112
    !by .msg113-*-1
    !pet "geheim!!!"
.msg113    !by 113
    !by .msg114-*-1
    !pet "unerlaubtes zeichen"
.msg114    !by 114
    !by .msg115-*-1
    !pet "fehler in konstante"
.msg115    !by 115
    !by .msg200-*-1
    !pet "fehler im exponenten"
;
;
;
.msg200    !by 200
    !by .msg201-*-1
    !pet "keine daten mehr"
.msg201    !by 201
    !by .msg202-*-1
    !pet "dateiende"
.msg202    !by 202
    !by .msg203-*-1
    !pet "datei schon geoeffnet"
.msg203    !by 203
    !by .msg204-*-1
    !pet "datei nicht geoeffnet"
.msg204    !by 204
    !by .msg205-*-1
    !pet "keine eingabe-datei"
.msg205    !by 205
    !by .msg206-*-1
    !pet "keine ausgabe-datei"
.msg206    !by 206
    !by .msg207-*-1
    !pet "zahlkonstante erwartet"
.msg207    !by 207
    !by .msg208-*-1
    !pet "keine rel-datei"
.msg208    !by 208
    !by .msg209-*-1
    !pet "geraet nicht bereit"
.msg209    !by 209
    !by .msg210-*-1
    !pet "zu viele dateien offen"
.msg210    !by 210
    !by .msg211-*-1
    !pet "lesefehler"
.msg211    !by 211
    !by .msg212-*-1
    !pet "schreibfehler"
.msg212    !by 212
    !by .msg213-*-1
    !pet "kurzer block auf band"
.msg213    !by 213
    !by .msg214-*-1
    !pet "langer block auf band"
.msg214    !by 214
    !by .msg215-*-1
    !pet "falsche quersumme auf band"
.msg215    !by 215
    !by .msg216-*-1
    !pet "bandende"
.msg216    !by 216
    !by .msg217-*-1
    !pet "datei nicht gefunden"
.msg217    !by 217
    !by .msg218-*-1
    !pet "unbekanntes geraet"
.msg218    !by 218
    !by .msg219-*-1
    !pet "das ist verboten"
.msg219    !by 219
    !by .msg230-*-1
    !pet "e/a stopp"
;
;
;
.msg230    !by 230
    !by .msg231-*-1
    !pet 13,"ende in "
.msg231    !by 231
    !by .msg232-*-1
    !pet 13,"stop in "
.msg232    !by 232
    !by .msg233-*-1
    !pet " bytes frei."
.msg233    !by 233
    !by .msg242-*-1
    !pet "fehler"
;
;
;
.msg242    !by 242
    !by .msg243-*-1
    !pet "in "
.msg243    !by 243
    !by .msg244-*-1
    !pet "prgrm daten frei",13
.msg244    !by 244
    !by .msg245-*-1
    !pet "das programm hielt in"
.msg245    !by 245
    !by .msg246-*-1
    !pet "was aufgerufen wird von"
.msg246    !by 246
    !by .msg255-*-1
    !pet "innerhalb"
;
;
.msg255
    !by 255 ;marker for set 1 end ???
errmsg2_deutsch
;
;
mg1    !by mg2-*-1
    !by 249
mg2    !by mg3-*-1
    !by 250
;
mg3    !by mg4-*-1
    !pet 97," oder ",95
mg4    !by mg5-*-1
    !pet "unbekannte marke"
mg5    !by mg6-*-1
    !pet "name schon definiert"
mg6    !by mg7-*-1
    !pet "keine marke"
mg7    !by mg8-*-1
    !pet "textvariable nicht dimensioniert"
mg8    !by mg9-*-1
    !pet "kein paket"
mg9    !by mg10-*-1
    !pet "ausdruck"
mg10    !by mg11-*-1
    !pet "variable"
mg11    !by mg12-*-1
    !pet "operand"
mg12    !by mg13-*-1
    !pet "variablen-name"
mg13    !by mg14-*-1
    !pet "name einer zahlvariable"
mg14    !by mg15-*-1
    !pet "numerischer ausdruck"
mg15    !by mg16-*-1
    !pet "text-ausdruck"
mg16    !by mg17-*-1
    !pet 198," oder ",96
mg17    !by mg18-*-1
    !pet 97," oder ",202
mg18    !by mg19-*-1
    !pet 198," oder ",199
mg19    !by mg20-*-1
    !pet 203," oder ",205
mg20    !by mg21-*-1
    !pet "modus"
mg21    !by mg22-*-1
    !pet "konstante"
mg22    !by mg23-*-1
    !pet "zeilennummer"
mg23    !by mg24-*-1
    !pet "binaerkonstante"
mg24    !by mg25-*-1
    !pet "marke"
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
    !pet " nicht erwartet"
mg36    !by mg37-*-1
    !pet " fehlt"
mg37    !by mg38-*-1
    !pet " erwartet statt "
mg38    !by mg39-*-1
    !pet "reelle konstante"
mg39    !by mg40-*-1
    !pet "ganzzahl-konstante"
mg40    !by mg41-*-1
    !pet "text-konstante"
mg41    !by mg42-*-1
    !pet "name"
mg42    !by mg43-*-1
    !pet "ganzzahl-name"
mg43    !by mg44-*-1
    !pet "textvariablen-name"
mg44    !by mg45-*-1
    !pet " nicht erlaubt in kontrollstrukturen"
mg45    !by mg46-*-1
    !pet " ohne "
mg46    !by mg47-*-1
    !by 244
mg47    !by mg48-*-1
    !by 178
mg48    !by mg49-*-1
    !pet 226," nur in geschlossener proc/func erlaubt"
mg49    !by mg50-*-1
    !pet "falscher typ bei "
mg50    !by mg51-*-1
    !pet "falscher name bei "
mg51    !by mg52-*-1
    !pet 104," oder ",206
mg52    !by mg53-*-1
    !pet "hex-konstante"
mg53    !by mg54-*-1
    !pet "unerlaubtes ",128
mg54    !by mg55-*-1
    !pet "unbekannte anweisung oder prozedur"
mg55    !by mg56-*-1
    !pet "keine prozedur"
mg56    !by mg57-*-1
    !pet "unbekannte variable"
mg57    !by mg58-*-1
    !pet "falscher typ"
mg58    !by mg59-*-1
    !pet "falscher funktionstyp"
mg59    !by mg60-*-1
    !pet "weder tabelle noch funktion"
mg60    !by mg61-*-1
    !pet "keine einfache variable"
mg61    !by mg62-*-1
    !pet "unbekannte tabelle oder funktion"
mg62    !by mg63-*-1
    !pet "falscher tabellen-typ"
mg63    !by mg64-*-1
    !pet "import-fehler"
mg64    !by mg65-*-1
    !pet "unbekanntes paket"
mg65
;
END
