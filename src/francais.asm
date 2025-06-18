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
    !pet $00,$10,"erreur de report"
    !pet $01,$11,"erreur d'argument"
    !pet $02,$17,"depassement de capacite"
    !pet $03,$11,"division par zero"
    !pet $04,$15,"erreur de sous-chaine"
    !pet $05,$13,"valeur hors limites"
    !pet $06,$07,"step =0"
    !pet $07,$0f,"domaine illegal"
    !pet $08,$25,"erreur d'utilisation de ",$22,"print using",$22

    !pet $0a,$12,"index hors limites"
    !pet $0b,$18,"nom de fichier trop long"
    
    !pet $0d,$16,"erreur de verification"
    !pet $0e,$11,"program trop long"
    !pet $0f,$11,"code comal errone"
    !pet $10,$18,"pas un fichier-pgm comal"
    !pet $11,$2f,"ce pgm est specifique a une autre version comal"
    !pet $12,$1b,"attribut de fichier inconnu"

    !pet $25,$0f,"matrix zu gross"
    !pet $26,$19,"unpassende matrixgroessen"
    !pet $27,$1c,"matrix muss quadratisch sein"
    
    !pet $33,$11,"erreur de systeme"
    !pet $34,$16,"depassement de memoire"
    !pet $35,$1e,"dimension de parametre erronee"
    !pet $36,$1e,"parametre doit etre un tableau"
    !pet $37,$16,"demande plus d'indexes"
    !pet $38,$1f,"erreur d'affectation de chaines"
    !pet $39,$13,"non mis application"
    !pet $3a,$16,"con n'est pas possible"
    !pet $3b,$17,"programme a ete modifie"
    !pet $3c,$0e,"trop d'indexes"
    !pet $3d,$23,"valeur de la fonction non retournee"

    !pet $43,$32,"liste des parametres differe ou n'est pas comprise"
    !pet $44,$29,"aucune procedure/fonction dans le fichier"
    !pet $45,$17,"parametres insufisantes"
    !pet $46,$14,"mauvais type d'index"
    !pet $47,$20,"parametre doit etre une variable"
    !pet $48,$19,"mauvais type de parametre"
    !pet $49,$12,"chargement non ram"
    !pet $4a,$32,"erreur de total de controle du fichier d'execution"
    !pet $4b,$16,"espace memoire protege"
    !pet $4c,$15,"trop de bibliotheques"
    !pet $4d,$14,"n'est pas un fichier"
    !pet $4e,$1a,"aucun ",$22,"when",$22," correspondant"
    !pet $4f,$12,"trop de parametres"

    !pet $65,$11,"erreur de syntaxe"
    !pet $66,$0c,"mauvais type"
    !pet $67,$28,"instruction trop longue ou trop complexe"
    !pet $68,$26,"instruction seulement, aucune commande"

    !pet $6a,$2a,"limite de numerotation de lignes: 1 a 9999"

    !pet $6c,$1f,"procedure/fonction n'existe pas"
    !pet $6d,$26,"instruction structuree non permise ici"
    !pet $6e,$19,"n'est pas une instruction"
    !pet $6f,$1d,"numero de ligne excedera 9999"
    !pet $70,$13,"source protegee !!!"
    !pet $71,$11,"caractere illegal"
    !pet $72,$13,"erreur de constante"
    !pet $73,$11,"erreur d'exposant"

    !pet $c8,$0e,"fin de donnees"
    !pet $c9,$0e,"fin de fichier"
    !pet $ca,$13,"fichier deja ouvert"
    !pet $cb,$12,"fichier non ouvert"
    !pet $cc,$1d,"n'est pas un fichier d'entree"
    !pet $cd,$1e,"n'est pas un fichier de sortie"
    !pet $ce,$1a,"constante numerique prevue"
    !pet $cf,$23,"n'est pas un fichier d'acces direct"
    !pet $d0,$18,"peripherique non present"
    !pet $d1,$17,"trop de fichier ouverts"
    !pet $d2,$11,"erreur de lecture"
    !pet $d3,$11,"erreur d'ecriture"
    !pet $d4,$1c,"bloc tres court sur la bande"
    !pet $d5,$1b,"bloc tres long sur la bande"
    !pet $d6,$28,"erreur de total de controle sur la bande"
    !pet $d7,$0c,"fin de bande"
    !pet $d8,$12,"fichier non trouve"
    !pet $d9,$14,"peripherique inconnu"
    !pet $da,$11,"operation illegal"
    !pet $db,$09,"arret e/s"
    !pet $e6,$07,$0d,"fin a "
    !pet $e7,$09,$0d,"arret a "
    !pet $e8,$0e," octets libres"
    !pet $e9,$06,"erreur"

    !pet $f2,$02,"a "
    !pet $f3,$13,"prog  var   libres",$0d

    !by $ff

errmsg2_fra
    !by $01,$f9,$01,$fa
    !pet $15,"tableau redimensionne"
    !pet $0d,"label inconnu"
    !pet $0f,"nom deja defini"
    !pet $12,"n'est pas un label"
    !pet $25,"chaine de caracteres non dimensionnee"
    !pet $13,"n'est pas un module"
    !pet $0a,"expression"
    !pet $08,"variable"
    !pet $08,"operande"
    !pet $0f,"nom de variable"
    !pet $19,"num de variable numerique"
    !pet $14,"expression numerique"
    !pet $21,"expression de chaine de caracters"
    !pet $06,$c6," ou ",$60
    !pet $06,$61," ou ",$ca
    !pet $06,$c6," ou ",$c7
    !pet $06,$cb," ou ",$cd
    !pet $04,"mode"
    !pet $09,"constante"
    !pet $0f,"numero de ligne"
    !pet $11,"constante binaire"
    !pet $05,"label"
    
    !by $05,$71,$2f,$72,$2f,$75
    !by $01,$75
    !by $01,$76
    !by $01,$f0
    !by $01,$f5
    !by $01,$b0
    !by $01,$77
    !by $05,$b2,$2f,$93,$2f,$74
    !by $05,$b2,$2f,$93,$2f,$74
    !by $01,$74

    !pet $0a," non prevu"
    !pet $07," absent"
    !pet $0f," prevu, et non "
    !pet $1a,"constante d'un nombre reel"
    !pet $1c,"constante d'un nombre entier"
    !pet $24,"constante d'une chaine de caracteres"
    !pet $03,"nom"
    !pet $16,"nom d'un nombre entier"
    !pet $1e,"nom d'une chaine de caracteres"
    !pet $2b," non permis dans les structures de controle"
    !pet $06," sans "

    !by $01,$f4
    !by $01,$b2
    
    !pet $2b,$e2," permis dans les fn/proc fermess seulement"
    !pet $10,"mauvais type de "
    !pet $11,"mauvais nom dans "
    !pet $06,$68," ou ",$ce
    !pet $16,"constante hexadecimale"
    !pet $09,$80," illegal"
    !pet $21,"instruction ou procedure inconnue"
    !pet $17,"n'est pas une procedure"
    !pet $11,"variable inconnue"
    !pet $0c,"mauvais type"
    !pet $18,"mauvais type de fonction"
    !pet $23,"n'est ni un tableau ni une fonction"
    !pet $16,"n'est pas une variable"
    !pet $1b,"tableau ou fonction inconnu"
    !pet $17,"mauvais type de tableau"
    !pet $13,"erreur de transfert"
    !pet $0e,"module inconnu"
END