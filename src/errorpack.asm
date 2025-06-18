;
;ERROR MESSAGE PACKAGE
;
;BY JESSE KNIGHT
;
;WRITTEN: 12/30/84
;
;LAST UPDATE:  1/28/85
;
; ------------------------
; from Disk "2.0 Packages"
; add c64symb.asm, and removed label part
; adjust the source, so it can be assembled with ACME
; Claus Schlereth 2025-06-18
; ------------------------


!source "c64symb.asm"


IERTXT=$C7E4 ;ERROR MESSAGES ADDR/PAGE
OWNPAGE = DEFPAG+ROMMED;
;PACKAGE CODE
;
 *=$B000
    !by OWNPAGE ;GIVE PAGE
    !word .end ;END OF PACKAGE
    !word .psense ;SENSE ROUTINE
;
;PACHAGE TABLE
;
    !pet 8,"myerrors" ;PACKAGE NAME
    !word .zero ;NO PROCS
    !word .pkinit ;PACK INIT ROUTINE
.zero
    !by 0 ;END OF TABLE

.pkinit
    LDX #<.nmsgs ;SET EMPNTR
    LDA #>.nmsgs ;TO NEW ERROR
    LDY #OWNPAGE ;MESSAGES
    STX IERTXT
    STA IERTXT+1
    STY IERTXT+2

.psense
    RTS ;RETURN
;
.nmsgs ;NEW ERROR MESSAGES
;
    !word mg1 ;point to set 2
;
.msg0    !by 0
    !by .msg1-*-1
    !pet "report error"
.msg1    !by 1
    !by .msg2-*-1
    !pet "argument error"
.msg2    !by 2
    !by .msg3-*-1
    !pet "overflow"
.msg3    !by 3
    !by .msg4-*-1
    !pet "division by zero"
.msg4    !by 4
    !by .msg5-*-1
    !pet "substring error"
.msg5    !by 5
    !by .msg6-*-1
    !pet "value out of range"
.msg6    !by 6
    !by .msg7-*-1
    !pet "step = 0"
.msg7    !by 7
    !by .msg8-*-1
    !pet "illegal bound"
.msg8    !by 8
    !by .msg10-*-1
    !pet "error in print using"
.msg10    !by 10
    !by .msg11-*-1
    !pet "index out of range"
.msg11    !by 11
    !by .msg13-*-1
    !pet "invalid file name"
;
.msg13    !by 13
    !by .msg14-*-1
    !pet "verify error"
.msg14    !by 14
    !by .msg15-*-1
    !pet "program too big"
.msg15    !by 15
    !by .msg16-*-1
    !pet "bad comal code"
.msg16    !by 16
    !by .msg17-*-1
    !pet "not comal program file"
.msg17    !by 17
    !by .msg18-*-1
    !pet "program for other comal version"
.msg18    !by 18
    !by .msg30-*-1
    !pet "unknown file attribute"
;
;
;
.msg30    !by 30
    !by .msg31-*-1
    !pet "illegal color"
.msg31    !by 31
    !by .msg32-*-1
    !pet "illegal boundary"
.msg32    !by 32
    !by .msg33-*-1
    !pet "illegal shape number"
.msg33    !by 33
    !by .msg34-*-1
    !pet "shape length must be 64"
.msg34    !by 34
    !by .msg35-*-1
    !pet "illegal sprite number"
.msg35    !by 35
    !by .msg36-*-1
    !pet "illegal voice"
.msg36    !by 36
    !by .msg51-*-1
    !pet "illegal note"
;
;
;
.msg51    !by 51
    !by .msg52-*-1
    !pet "system error"
.msg52    !by 52
    !by .msg53-*-1
    !pet "out of memory"
.msg53    !by 53
    !by .msg54-*-1
    !pet "wrong dimension in parameter"
.msg54    !by 54
    !by .msg55-*-1
    !pet "parameter must be an array"
.msg55    !by 55
    !by .msg56-*-1
    !pet "too few indices"
.msg56    !by 56
    !by .msg57-*-1
    !pet "string assignment error"
.msg57    !by 57
    !by .msg58-*-1
    !pet "not implemented"
.msg58    !by 58
    !by .msg59-*-1
    !pet "con not possible"
.msg59    !by 59
    !by .msg60-*-1
    !pet "program has been modified"
.msg60    !by 60
    !by .msg61-*-1
    !pet "too many indices"
.msg61    !by 61
    !by .msg62-*-1
    !pet "function value not returned"
.msg62    !by 62
    !by .msg67-*-1
    !pet "not a variable"
;
.msg67    !by 67
    !by .msg68-*-1
    !pet "parameter lists differ or not closed"
.msg68    !by 68
    !by .msg69-*-1
    !pet "no closed proc/func in file"
.msg69    !by 69
    !by .msg70-*-1
    !pet "too few parameters"
.msg70    !by 70
    !by .msg71-*-1
    !pet "wrong index type"
.msg71    !by 71
    !by .msg72-*-1
    !pet "parameter must be a variable"
.msg72    !by 72
    !by .msg73-*-1
    !pet "wrong parameter type"
.msg73    !by 73
    !by .msg74-*-1
    !pet "non-ram load"
.msg74    !by 74
    !by .msg75-*-1
    !pet "checksum error in object file"
.msg75    !by 75
    !by .msg76-*-1
    !pet "memory area is protected"
.msg76    !by 76
    !by .msg77-*-1
    !pet "too many libraries"
.msg77    !by 77
    !by .msg78-*-1
    !pet "not an object file"
.msg78    !by 78
    !by .msg79-*-1
    !pet "no matching when"
.msg79    !by 79
    !by .msg101-*-1
    !pet "too many parameters"
;
;
;
.msg101    !by 101
    !by .msg102-*-1
    !pet "syntax error"
.msg102    !by 102
    !by .msg103-*-1
    !pet "wrong type"
.msg103    !by 103
    !by .msg104-*-1
    !pet "statement too long or too complicated"
.msg104    !by 104
    !by .msg106-*-1
    !pet "statement only, not command"
;
.msg106    !by 106
    !by .msg108-*-1
    !pet "line number range: 1 to 9999"
;
.msg108    !by 108
    !by .msg109-*-1
    !pet "procedure/function does not exist"
.msg109    !by 109
    !by .msg110-*-1
    !pet "structured statement not allowed here"
.msg110    !by 110
    !by .msg111-*-1
    !pet "not a statement"
.msg111    !by 111
    !by .msg112-*-1
    !pet "line numbers will exceed 9999"
.msg112    !by 112
    !by .msg113-*-1
    !pet "source protected!!!"
.msg113    !by 113
    !by .msg114-*-1
    !pet "illegal character"
.msg114    !by 114
    !by .msg115-*-1
    !pet "error in constant"
.msg115    !by 115
    !by .msg200-*-1
    !pet "error in exponent"
;
;
;
.msg200    !by 200
    !by .msg201-*-1
    !pet "end of data"
.msg201    !by 201
    !by .msg202-*-1
    !pet "end of file"
.msg202    !by 202
    !by .msg203-*-1
    !pet "file already open"
.msg203    !by 203
    !by .msg204-*-1
    !pet "file not open"
.msg204    !by 204
    !by .msg205-*-1
    !pet "not input file"
.msg205    !by 205
    !by .msg206-*-1
    !pet "not output file"
.msg206    !by 206
    !by .msg207-*-1
    !pet "numeric constant expected"
.msg207    !by 207
    !by .msg208-*-1
    !pet "not random access file"
.msg208    !by 208
    !by .msg209-*-1
    !pet "device not present"
.msg209    !by 209
    !by .msg210-*-1
    !pet "too many files open"
.msg210    !by 210
    !by .msg211-*-1
    !pet "read error"
.msg211    !by 211
    !by .msg212-*-1
    !pet "write error"
.msg212    !by 212
    !by .msg213-*-1
    !pet "short block on tape"
.msg213    !by 213
    !by .msg214-*-1
    !pet "long block on tape"
.msg214    !by 214
    !by .msg215-*-1
    !pet "checksum error on tape"
.msg215    !by 215
    !by .msg216-*-1
    !pet "end of tape"
.msg216    !by 216
    !by .msg217-*-1
    !pet "file not found"
.msg217    !by 217
    !by .msg218-*-1
    !pet "unknown device"
.msg218    !by 218
    !by .msg219-*-1
    !pet "illegal operation"
.msg219    !by 219
    !by .msg230-*-1
    !pet "i/o break"
;
;
;
.msg230    !by 230
    !by .msg231-*-1
    !pet 13,"end at "
.msg231    !by 231
    !by .msg232-*-1
    !pet 13,"stop at "
.msg232    !by 232
    !by .msg233-*-1
    !pet " bytes free.",13,13
.msg233    !by 233
    !by .msg242-*-1
    !pet "error"
;
;
;
.msg242    !by 242
    !by .msg243-*-1
    !pet "at "
.msg243    !by 243
    !by .msg244-*-1
    !pet "prog  data  free",13
.msg244    !by 244
    !by .msg245-*-1
    !pet "the program stopped at"
.msg245    !by 245
    !by .msg246-*-1
    !pet "which is called at"
.msg246    !by 246
    !by .msg255-*-1
    !pet "within"
;
;
.msg255    !by 255 ;marker for set 1 end ???
;
;
mg1    !by mg2-*-1
    !by 249
mg2    !by mg3-*-1
    !by 250
;
mg3    !by mg4-*-1
    !pet 97," or ",95
mg4    !by mg5-*-1
    !pet "unknown label"
mg5    !by mg6-*-1
    !pet "name already defined"
mg6    !by mg7-*-1
    !pet "not a label"
mg7    !by mg8-*-1
    !pet "string not dimensioned"
mg8    !by mg9-*-1
    !pet "not a package"
mg9    !by mg10-*-1
    !pet "expression"
mg10    !by mg11-*-1
    !pet "variable"
mg11    !by mg12-*-1
    !pet "operand"
mg12    !by mg13-*-1
    !pet "variable name"
mg13    !by mg14-*-1
    !pet "num. variable name"
mg14    !by mg15-*-1
    !pet "numeric expression"
mg15    !by mg16-*-1
    !pet "string expression"
mg16    !by mg17-*-1
    !pet 198," or ",96
mg17    !by mg18-*-1
    !pet 97," or ",202
mg18    !by mg19-*-1
    !pet 198," or ",199
mg19    !by mg20-*-1
    !pet 203," or ",205
mg20    !by mg21-*-1
    !pet "mode"
mg21    !by mg22-*-1
    !pet "constant"
mg22    !by mg23-*-1
    !pet "line number"
mg23    !by mg24-*-1
    !pet "binary constant"
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
    !pet " not expected"
mg36    !by mg37-*-1
    !pet " missing"
mg37    !by mg38-*-1
    !pet " expected, not "
mg38    !by mg39-*-1
    !pet "real constant"
mg39    !by mg40-*-1
    !pet "integer constant"
mg40    !by mg41-*-1
    !pet "string constant"
mg41    !by mg42-*-1
    !pet "name"
mg42    !by mg43-*-1
    !pet "integer name"
mg43    !by mg44-*-1
    !pet "string name"
mg44    !by mg45-*-1
    !pet " not allowed in control structures"
mg45    !by mg46-*-1
    !pet " without "
mg46    !by mg47-*-1
    !by 244
mg47    !by mg48-*-1
    !by 178
mg48    !by mg49-*-1
    !pet 226," allowed in closed proc/func only"
mg49    !by mg50-*-1
    !pet "wrong type of "
mg50    !by mg51-*-1
    !pet "wrong name in "
mg51    !by mg52-*-1
    !pet 104," or ",206
mg52    !by mg53-*-1
    !pet "hex constant"
mg53    !by mg54-*-1
    !pet "illegal ",128
mg54    !by mg55-*-1
    !pet "unknown statement or procedure"
mg55    !by mg56-*-1
    !pet "not a procedure"
mg56    !by mg57-*-1
    !pet "unknown variable"
mg57    !by mg58-*-1
    !pet "wrong type"
mg58    !by mg59-*-1
    !pet "wrong function type"
mg59    !by mg60-*-1
    !pet "not an array nor a function"
mg60    !by mg61-*-1
    !pet "not a simple variable"
mg61    !by mg62-*-1
    !pet "unknown array or function"
mg62    !by mg63-*-1
    !pet "wrong array type"
mg63    !by mg64-*-1
    !pet "import error"
mg64    !by mg65-*-1
    !pet "unknown package"
mg65
;
.end
