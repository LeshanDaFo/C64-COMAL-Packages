; ###############################################################
; #                                                             #
; #  FRANCAIS FOR COMAL SOURCE CODE                             #
; #  Version 1.0 (2024.03.21)                                   #
; #  Copyright (c) 2024 Claus Schlereth                         #
; #                                                             #
; #  This version of the source code is under MIT License       #
; #                                                             #
; ###############################################################

!source "c64symb.asm"

*=$9300

    !by DEFPAG          ; MEMORY MAP
    !word END           ; END OF PACKAGE
    !word .sense        ; SENSE ROUTINE

    !pet $08,"francais" ; NAME
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
--------------
.text
    !pet $0D," francais ver. 1.0"
    !by $00

    !pet "claus schlereth in 2024"

.link
    LDY #00
-   LDA .text,Y
    BEQ .fertig
    JSR $FFD2
    INY
    BNE -
.fertig
    LDA #<errmsg_fra
    LDX #>errmsg_fra
    LDY #$46
    STA IERTXT          ; error message data
    STX IERTXT+1        ; the sytem will look here
    STY IERTXT+2        ; where to find the error messages
    RTS
-----------------------------------
.noproc
    !by $00
-----------------------------------
errmsg_fra
; these are the french error messages

!word errmsg2_fra
.msg0      !by 0
    !by .msg1-*-1
    !pet "erreur de report"
.msg1      !by 1
    !by .msg2-*-1
    !pet "erreur d'argument"
.msg2      !by 2
    !by .msg3-*-1
    !pet "depassement de capacite"
.msg3      !by 3
    !by .msg4-*-1
    !pet "division par zero"
.msg4      !by 4
    !by .msg5-*-1
    !pet "erreur de sous-chaine"
.msg5      !by 5
    !by .msg6-*-1
    !pet "valeur hors limites"
.msg6      !by 6
    !by .msg7-*-1
    !pet "step =0"
.msg7      !by 7
    !by .msg8-*-1
    !pet "domaine illegal"
.msg8      !by 8
    !by .msg10-*-1
    !pet "erreur d'utilisation de ",$22,"print using",$22
;
.msg10     !by 10
    !by .msg11-*-1
    !pet "index hors limites"
.msg11     !by 11
    !by .msg13-*-1
    !pet "nom de fichier trop long"
;
.msg13     !by 13
    !by .msg14-*-1
    !pet "erreur de verification"
.msg14     !by 14
    !by .msg15-*-1
    !pet "program trop long"
.msg15     !by 15
    !by .msg16-*-1
    !pet "code comal errone"
.msg16     !by 16
    !by .msg17-*-1
    !pet "pas un fichier-pgm comal"
.msg17     !by 17
    !by .msg18-*-1
    !pet "ce pgm est specifique a une autre version comal"
.msg18     !by 18
    !by .msg30-*-1
    !pet "attribut de fichier inconnu"
;
;
;
.msg30     !by 30
    !by .msg31-*-1
    !pet "couleur illegale"
.msg31     !by 31
    !by .msg32-*-1
    !pet "limite illegale"
.msg32     !by 32
    !by .msg33-*-1
    !pet "numero de forme illegal"
.msg33     !by 33
    !by .msg34-*-1
    !pet "la longueur de forme doit être 64"
.msg34     !by 34
    !by .msg35-*-1
    !pet "numero de sprite illegal"
.msg35     !by 35
    !by .msg36-*-1
    !pet "voix illegale"
.msg36     !by 36
    !by .msg51-*-1
    !pet "note illegale"
;
;
;
.msg51     !by 51
    !by .msg52-*-1
    !pet "erreur de systeme"
.msg52     !by 52
    !by .msg53-*-1
    !pet "depassement de memoire"
.msg53     !by 53
    !by .msg54-*-1
    !pet "dimension de parametre erronee"
.msg54     !by 54
    !by .msg55-*-1
    !pet "parametre doit etre un tableau"
.msg55     !by 55
    !by .msg56-*-1
    !pet "demande plus d'indexes"
.msg56     !by 56
    !by .msg57-*-1
    !pet "erreur d'affectation de chaines"
.msg57     !by 57
    !by .msg58-*-1
    !pet "non mis application"
.msg58     !by 58
    !by .msg59-*-1
    !pet "con n'est pas possible"
.msg59     !by 59
    !by .msg60-*-1
    !pet "programme a ete modifie"
.msg60     !by 60
    !by .msg61-*-1
    !pet "trop d'indexes"
.msg61     !by 61
    !by .msg62-*-1
    !pet "valeur de la fonction non retournee"
.msg62     !by 62
    !by .msg67-*-1
    !pet "pas une variable"
    
;
.msg67     !by 67
    !by .msg68-*-1
    !pet "liste des parametres differe ou n'est pas comprise"
.msg68     !by 68
    !by .msg69-*-1
    !pet "aucune procedure/fonction dans le fichier"
.msg69     !by 69
    !by .msg70-*-1
    !pet "parametres insufisantes"
.msg70     !by 70
    !by .msg71-*-1
    !pet "mauvais type d'index"
.msg71     !by 71
    !by .msg72-*-1
    !pet "parametre doit etre une variable"
.msg72     !by 72
    !by .msg73-*-1
    !pet "mauvais type de parametre"
.msg73     !by 73
    !by .msg74-*-1
    !pet "chargement non ram"
.msg74     !by 74
    !by .msg75-*-1
    !pet "erreur de total de controle du fichier d'execution"
.msg75     !by 75
    !by .msg76-*-1
    !pet "espace memoire protege"
.msg76     !by 76
    !by .msg77-*-1
    !pet "trop de bibliotheques"
.msg77     !by 77
    !by .msg78-*-1
    !pet "n'est pas un fichier"
.msg78     !by 78
    !by .msg79-*-1
    !pet "aucun ",$22,"when",$22," correspondant"
.msg79     !by 79
    !by .msg101-*-1
    !pet "trop de parametres"
;
;
;
.msg101    !by 101
    !by .msg102-*-1
    !pet "erreur de syntaxe"
.msg102    !by 102
    !by .msg103-*-1
    !pet "mauvais type"
.msg103    !by 103
    !by .msg104-*-1
    !pet "instruction trop longue ou trop complexe"
.msg104    !by 104
    !by .msg106-*-1
    !pet "instruction seulement, aucune commande"
;
.msg106    !by 106
    !by .msg108-*-1
    !pet "limite de numerotation de lignes: 1 a 9999"
;
.msg108    !by 108
    !by .msg109-*-1
    !pet "procedure/fonction n'existe pas"
.msg109    !by 109
    !by .msg110-*-1
    !pet "instruction structuree non permise ici"
.msg110    !by 110
    !by .msg111-*-1
    !pet "n'est pas une instruction"
.msg111    !by 111
    !by .msg112-*-1
    !pet "numero de ligne excedera 9999"
.msg112    !by 112
    !by .msg113-*-1
    !pet "source protegee !!!"
.msg113    !by 113
    !by .msg114-*-1
    !pet "caractere illegal"
.msg114    !by 114
    !by .msg115-*-1
    !pet "erreur de constante"
.msg115    !by 115
    !by .msg200-*-1
    !pet "erreur d'exposant"
;
;
;
.msg200    !by 200
    !by .msg201-*-1
    !pet "fin de donnees"
.msg201    !by 201
    !by .msg202-*-1
    !pet "fin de fichier"
.msg202    !by 202
    !by .msg203-*-1
    !pet "fichier deja ouvert"
.msg203    !by 203
    !by .msg204-*-1
    !pet "fichier non ouvert"
.msg204    !by 204
    !by .msg205-*-1
    !pet "n'est pas un fichier d'entree"
.msg205    !by 205
    !by .msg206-*-1
    !pet "n'est pas un fichier de sortie"
.msg206    !by 206
    !by .msg207-*-1
    !pet "constante numerique prevue"
.msg207    !by 207
    !by .msg208-*-1
    !pet "n'est pas un fichier d'acces direct"
.msg208    !by 208
    !by .msg209-*-1
    !pet "peripherique non present"
.msg209    !by 209
    !by .msg210-*-1
    !pet "trop de fichier ouverts"
.msg210    !by 210
    !by .msg211-*-1
    !pet "erreur de lecture"
.msg211    !by 211
    !by .msg212-*-1
    !pet "erreur d'ecriture"
.msg212    !by 212
    !by .msg213-*-1
    !pet "bloc tres court sur la bande"
.msg213    !by 213
    !by .msg214-*-1
    !pet "bloc tres long sur la bande"
.msg214    !by 214
    !by .msg215-*-1
    !pet "erreur de total de controle sur la bande"
.msg215    !by 215
    !by .msg216-*-1
    !pet "fin de bande"
.msg216    !by 216
    !by .msg217-*-1
    !pet "fichier non trouve"
.msg217    !by 217
    !by .msg218-*-1
    !pet "peripherique inconnu"
.msg218    !by 218
    !by .msg219-*-1
    !pet "operation illegal"
.msg219    !by 219
    !by .msg230-*-1
    !pet "arret e/s"
;
;
;
.msg230    !by 230
    !by .msg231-*-1
    !pet 13,"fin a "
.msg231    !by 231
    !by .msg232-*-1
    !pet 13,"arret a "
.msg232    !by 232
    !by .msg233-*-1
    !pet " octets libres"
.msg233    !by 233
    !by .msg242-*-1
    !pet "erreur"
;
;
;
.msg242    !by 242
    !by .msg243-*-1
    !pet "a "
.msg243    !by 243
    !by .msg244-*-1
    !pet "prog  var   libres",13
.msg244    !by 244 
    !by .msg245-*-1 
    !pet "le programme s'est arrete a"
.msg245    !by 245 
    !by .msg246-*-1 
    !pet "qui est appelle a la"
.msg246    !by 246 
    !by .msg255-*-1 
    !pet "dans"
;
;
.msg255    !by 255 ;marker for set 1 end ???
errmsg2_fra
;
;
mg1     !by mg2-*-1
    !by 249
mg2     !by mg3-*-1
    !by 250
;
mg3     !by mg4-*-1
    !pet "tableau redimensionne"
mg4     !by mg5-*-1
    !pet "label inconnu"
mg5     !by mg6-*-1
    !pet "nom deja defini"
mg6     !by mg7-*-1
    !pet "n'est pas un label"
mg7     !by mg8-*-1
    !pet "chaine de caracteres non dimensionnee"
mg8     !by mg9-*-1
    !pet "n'est pas un module"
mg9     !by mg10-*-1
    !pet "expression"
mg10    !by mg11-*-1
    !pet "variable"
mg11    !by mg12-*-1
    !pet "operande"
mg12    !by mg13-*-1
    !pet "nom de variable"
mg13    !by mg14-*-1
    !pet "num de variable numerique"
mg14    !by mg15-*-1
    !pet "expression numerique"
mg15    !by mg16-*-1
    !pet "expression de chaine de caracters"
mg16    !by mg17-*-1
    !pet 198," ou ",96
mg17    !by mg18-*-1
    !pet 97," ou ",202
mg18    !by mg19-*-1
    !pet 198," ou ",199
mg19    !by mg20-*-1
    !pet 203," ou ",205
mg20    !by mg21-*-1
    !pet "mode"
mg21    !by mg22-*-1
    !pet "constante"
mg22    !by mg23-*-1
    !pet "numero de ligne"
mg23    !by mg24-*-1
    !pet "constante binaire"
mg24    !by mg25-*-1
    !pet "label"
mg25    !by mg26-*-1
    !by 113,"/",114,"/",117
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
    !pet " non prevu"
mg36    !by mg37-*-1
    !pet " absent"
mg37    !by mg38-*-1
    !pet " prevu, et non "
mg38    !by mg39-*-1
    !pet "constante d'un nombre reel"
mg39    !by mg40-*-1
    !pet "constante d'un nombre entier"
mg40    !by mg41-*-1
    !pet "constante d'une chaine de caracteres"
mg41    !by mg42-*-1
    !pet "nom"
mg42    !by mg43-*-1
    !pet "nom d'un nombre entier"
mg43    !by mg44-*-1
    !pet "nom d'une chaine de caracteres"
mg44    !by mg45-*-1
    !pet " non permis dans les structures de controle"
mg45    !by mg46-*-1
    !pet " sans "
mg46    !by mg47-*-1
    !by 244
mg47    !by mg48-*-1
    !by 178
mg48    !by mg49-*-1
    !pet 226," permis dans les fn/proc fermess seulement"
mg49    !by mg50-*-1
    !pet "mauvais type de "
mg50    !by mg51-*-1
    !pet "mauvais nom dans "
mg51    !by mg52-*-1
    !pet 104," ou ",206
mg52    !by mg53-*-1
    !pet "constante hexadecimale"
mg53    !by mg54-*-1
    !pet 128," illegal"
mg54    !by mg55-*-1
    !pet "instruction ou procedure inconnue"
mg55    !by mg56-*-1
    !pet "n'est pas une procedure"
mg56    !by mg57-*-1
    !pet "variable inconnue"
mg57    !by mg58-*-1
    !pet "mauvais type"
mg58    !by mg59-*-1
    !pet "mauvais type de fonction"
mg59    !by mg60-*-1
    !pet "n'est ni un tableau ni une fonction"
mg60    !by mg61-*-1
    !pet "n'est pas une variable"
mg61    !by mg62-*-1
    !pet "tableau ou fonction inconnu"
mg62    !by mg63-*-1
    !pet "mauvais type de tableau"
mg63    !by mg64-*-1
    !pet "erreur de transfert"
mg64    !by mg65-*-1
    !pet "module inconnu"
mg65

END