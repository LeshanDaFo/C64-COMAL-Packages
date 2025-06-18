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
    !pet $00,$0E,"fout in report"
    !pet $01,$10,"fout in argument"
    !pet $02,$08,"overflow"
    !pet $03,$0F,"deling door nul"
    !pet $04,$0E,"substring-fout"
    !pet $05,$14,"waarde buiten bereik"
    !pet $06,$08,"step = 0"
    !pet $07,$1B,"niet-toegestane grenswaarde"
    !pet $08,$14,"fout in using-string"

    !pet $0A,$13,"index buiten bereik"
    !pet $0B,$18,"niet-toegestane filenaam"

    !pet $0D,$0B,"verify-fout"
    !pet $0E,$12,"programma te groot"
    !pet $0F,$0F,"geen comal-kode"
    !pet $10,$14,"geen comal-programma"
    !pet $11,$22,"programma voor andere comal-versie"
    !pet $12,$17,"onbekend file-attribuut"

    !pet $1E,$13,"foutief kleurnummer"
    !pet $1F,$14,"foutieve grenswaarde"
    !pet $20,$16,"foutief tekeningnummer"
    !pet $21,$1C,"tekening-lengte moet 64 zijn"
    !pet $22,$15,"foutief sprite-nummer"
    !pet $23,$12,"foutief stemnummer"
    !pet $24,$0C,"fout in noot"

    !pet $33,$0C,"systeem-fout"
    !pet $34,$17,"geheugenruimte te klein"
    !pet $35,$1E,"foutieve dimensie in parameter"
    !pet $36,$1D,"parameter moet een array zijn"
    !pet $37,$11,"te weinig indices"
    !pet $38,$18,"toekenning niet mogelijk"
    !pet $39,$14,"niet geimplementeerd"
    !pet $3A,$13,"'con' niet mogelijk"
    !pet $3B,$16,"programma is gewijzigd"
    !pet $3C,$0F,"te veel indices"
    !pet $3D,$1A,"return-statement ontbreekt"
    !pet $3E,$0E,"geen variabele"

    !pet $43,$24,"par-lijst verschilt cq niet 'closed'"
    !pet $44,$1D,"geen closed proc/func in file"
    !pet $45,$14,"te weinig parameters"
    !pet $46,$12,"foutief index-type"
    !pet $47,$21,"parameter moet een variabele zijn"
    !pet $48,$16,"foutief parameter-type"
    !pet $49,$0C,"non-ram load"
    !pet $4A,$1C,"checksum-fout in object-file"
    !pet $4B,$1E,"geheugendeel niet toegankelijk"
    !pet $4C,$11,"te veel libraries"
    !pet $4D,$10,"geen object-file"
    !pet $4E,$22,"geen passende when-waarde gevonden"
    !pet $4F,$12,"te veel parameters"

    !pet $65,$0B,"syntax-fout"
    !pet $66,$0D,"verkeerd type"
    !pet $67,$23,"statement te lang of te ingewikkeld"
    !pet $68,$27,"alleen als statement, niet als commando"

    !pet $6A,$17,"regelnummers uit 1-9999"

    !pet $6C,$16,"proc/func bestaat niet"
    !pet $6D,$1D,"hier geen structuur-statement"
    !pet $6E,$0E,"geen statement"
    !pet $6F,$1A,"regelnummers buiten bereik"
    !pet $70,$13,"programma beveiligd"
    !pet $71,$0D,"onjuist teken"
    !pet $72,$11,"fout in konstante"
    !pet $73,$17,"fout in exponent-waarde"

    !pet $C8,$0B,"eod gelezen"
    !pet $C9,$0B,"eof gelezen"
    !pet $CA,$0F,"file is al open"
    !pet $CB,$0E,"file niet open"
    !pet $CC,$10,"geen invoer-file"
    !pet $CD,$11,"geen uitvoer-file"
    !pet $CE,$1C,"numerieke konstante verwacht"
    !pet $CF,$10,"geen random-file"
    !pet $D0,$19,"eenheid niet toegankelijk"
    !pet $D1,$19,"maximum aantal files open"
    !pet $D2,$09,"read-fout"
    !pet $D3,$0A,"write-fout"
    !pet $D4,$0C,"te kort blok"
    !pet $D5,$0C,"te lang blok"
    !pet $D6,$0D,"checksum-fout"
    !pet $D7,$19,"logisch einde van de tape"
    !pet $D8,$11,"file bestaat niet"
    !pet $D9,$11,"onbekende eenheid"
    !pet $DA,$18,"operatie niet toegestaan"
    !pet $DB,$0E,"i/o afgebroken"

    !pet $E6,$08,$0D,"end op "
    !pet $E7,$09,$0D,"stop in "
    !pet $E8,$0E," bytes vrij ",$0D,$0D
    !pet $E9,$04,"fout"

    !pet $F2,$03,"in " 
    !pet $F3,$11,"prog  data  vrij",$0D
    !pet $F4,$11,"programma-stop in"
    !pet $F5,$0E,"aangeroepen in"
    !pet $F6,$06,"binnen"

    !by $FF

errmsg2_dutch
    !by $01,$F9,$01,$FA
    !pet $06,$61," of ",$5F
    !pet $0E,"label onbekend"
    !pet $17,"naam reeds gedefinieerd"
    !pet $0A,"geen label"
    !pet $1B,"string niet gedimensioneerd"
    !pet $0C,"geen package"
    !pet $0B,"uitdrukking"
    !pet $09,"variabele"
    !pet $07,"operand"
    !pet $0E,"variabele-naam"
    !pet $18,"numerieke variabele-naam"
    !pet $15,"numerieke uitdrukking"
    !pet $12,"string-uitdrukking"
    !pet $06,$C6," of ",$60
    !pet $06,$61," of ",$CA
    !pet $06,$C6," of ",$C7
    !pet $06,$CB," of ",$CD
    !pet $04,"mode"
    !pet $09,"konstante"
    !pet $0B,"regelnummer"
    !pet $11,"binaire konstante"
    !pet $05,"label"

    !by $05,$71,$2F,$72,$2F,$75
    !by $01,$75
    !by $01,$76
    !by $01,$F0
    !by $01,$F5
    !by $01,$B0
    !by $01,$77
    !by $05,$B2,$2F,$93,$2F,$74
    !by $05,$B2,$2F,$93,$2F,$74
    !by $01,$74

    !pet $0E," niet verwacht"
    !pet $0A," ontbreekt"
    !pet $10," verwacht, geen "
    !pet $0E,"real-konstante"
    !pet $11,"integer-konstante"
    !pet $10,"string-konstante"
    !pet $04,"naam"
    !pet $0C,"integer-naam"
    !pet $0B,"string-naam"
    !pet $26," niet toegestaan in controle-structuur"
    !pet $08," zonder "

    !by $01,$F4
    !by $01,$B2 

    !pet $1C,$E2," alleen in closed proc/func"
    !pet $12,"verkeerd type van "
    !pet $12,"verkeerde naam in "
    !pet $06,$68," of ",$CE
    !pet $0D,"hex-konstante"
    !pet $09,"foutief ",$80
    !pet $1C,"statement/procedure onbekend"
    !pet $0E,"geen procedure"
    !pet $16,"variabele bestaat niet"
    !pet $0D,"verkeerd type"
    !pet $14,"onjuist functie-type"
    !pet $15,"geen array of functie"
    !pet $19,"geen eenvoudige variabele"
    !pet $1D,"array cq functie bestaat niet"
    !pet $12,"foutief array-type"
    !pet $0B,"import-fout"
    !pet $10,"onbekend package"
END