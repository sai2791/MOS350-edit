cpu 65c02
load $8000 edit150.rom
symbols bbc.sym
symbols edit150.sym
save edit150.asm
hexdump edit150.hex


;pbrkv  entry $8079
entry $8000
entry $8003
string $8009 4 ; "EDIT"
string $800E 5 ; "1.50r"
string $8014 13 ; "(C)1989 Acorn"
entry $8023
entry $8079
byte $80C0 3 ; in norBRK
entry $80C3
byte $80CC 5
entry $80D1
string $80D8 19 ; "Shift f5 D for info"
entry $80EE
string $80FF 24 ; "Press ESCAPE to continue"
byte $8117 5
entry $811C
string $832C 13 ; "No name found"
string $8372 8 ; "Loading "
entry $837B
string $83CB 12 ; "File too big"
entry $83D7
string $83DF 10 ; "Saving to "
entry $83E9
byte $845B 4 ; in escSET
entry $845F
entry $854E ; CRTOGG
byte $85C6 6
entry $85CD
entry $8663
entry $86D8
wordentry $874B 48
wordentry $87AB 29 
entry $87E3 ; BIGMESS
String $87E7 6 ; "shf-f0"
string $87EF 6 ; "shf-f1"
string $87F7 6 ; "shf-f2"
string $87FF 6 ; "shf-f3"
string $8807 6 ; "shf-f4"
string $880F 6 ; "shf-f5"
string $8817 6 ; "shf-f6"
string $881F 6 ; "shf-f7"
string $8827 6 ; "shf-f8"
string $882F 6 ; "shf-f9"
string $8837 7 ; "Display"
string $883F 7 ; "Insert/"
string $8847 7 ; "Insert "
string $884F 7 ; "Remove "
string $8857 7 ; "Return "
string $885F 7 ; " Set   "
string $8867 7 ; " Clear "
string $886F 7 ; "Marked "
string $8877 7 ; "Marked "
string $887F 6 ; "Clear "
string $8887 7 ; "Returns"
string $888F 7 ; "Over   "
string $8897 7 ; " File  "
string $889F 7 ; "Margins"
string $88A7 7 ; "Languag"
string $88AF 7 ; " Mode  "
string $88B7 7 ; " Marks "
string $88BF 7 ; "Move   "
string $88C7 7 ; "Delete "
string $88CF 6 ; "Text  "
string $8927 7 ; " Goto  "
string $892F 7 ; "Command"
string $8937 7 ; " Load  "
string $893F 7 ; " Save  "
string $8947 7 ; " Find  "
string $894F 7 ; "Global "
string $8957 7 ; " Mark  "
string $895F 7 ; "Marked "
string $8967 7 ; " Print "
string $896F 6 ; " Old  "
string $8977 7 ; " Line  "
string $897F 7 ; "Line   "
string $8987 7 ; " File  "
string $898F 7 ; " File  "
string $8997 7 ; "String "
string $899F 7 ; "Replace"
string $89A7 7 ; " Place "
string $89AF 7 ; "Copy   "
string $89B7 7 ; " Text  "
string $89BF 6 ; " Text "
entry $89E3
string $89E8 24 ; "The Acorn Screen Editor "
string $8A01 31 ; " 1989 Acorn Computers Vn 1.50r "
string $8A25 16 ; "Shift: screen up"
string $8A57 16 , "Descriptive Mode"
string $8A75 73 ; "Control: text startTAB performs tabulation controlled by shift TAB.      "
string $8AC7 71 ; "Shift: word l/r  COPY deletes the character above the cursor.          "
string $8B17 71 ; "Control:         Shift COPY provides normal soft keys and cursor       "
string $8B67 73 ; "    l/r of line         copying (ESCAPE to leave this mode).             "
string $8BB5 75 ; "Shift: screen down Control COPY deletes the current line (to next RETURN)  "
string $8C05 19 ; "Control: text end  "
entry $8C18
byte $8C7D 54
entry $8D0D ; f0
string $8D0D 2
byte $8D0F
string $8D11 19 ; "cursor can be moved"
string $8D25 11 ; "a new line."
string $8D31 28 ; "For this operation lines are"
string $8D4E 9 ; "sequences"
string $8D58 9 ; "ended by "
string $8D64 2
string $8D68 39 ; "ends of lines can be shown as a special"
string $8D90 43 ; "character so that they can be seen clearly."
string $8DBC 31 ; "This alters with each press of "
string $8DE2 8 ; "Commands"
string $8DEB 38 ; "the computer's operating system can be"
string $8E12 7 ; "given. "
string $8E1A 38 ; "result is seen at once. Extra commands"
string $8E41 21 ; "can be entered until "
string $8E57 20 ; " by itself is typed."
string $8E6F 51 ; "Changes between Insert and Over. In Insert mode the"
string $8EA4 26 ; " typed is inserted causing"
string $8EBF 8 ; "existing"
string $8ECB 22 ; "move. In Over mode the"
string $8EE2 18 ; "is typed over old "
string $8EF9 9 ; ", erasing"
string $8F03 8 ; "current "
string $8F10 3 ; " at"
string $8F14 14 ; "current cursor"
string $8F27 12 ; "All or 'mark"
string $8F34 7 ; "cursor'"
string $8F3C 13 ; "will be saved"
string $8F4A 6 ; "a file"
string $8F56 14 ; "top and bottom"
string $8F65 18 ; "have been removed."
string $8F78 7 ; "Set Top"
string $8F82 10 ; "Set Bottom"
string $8F8F 43 ; "f4:- Interactive Find and Replace Function."
string $8FBD 43 ; "use last f4. Special search characters are:"
string $8FE9 11 ; "# digit, $ "
string $8FF5 31 ; ", . any, [ ] set of char, a-z a"
string $9017 53 ; "~ not, * many, ^ many, | control, @ alpha, \ literal."
string $9050 6 ; "Return"
string $9057 19 ; "specified language."
string $906B 3 ; "The"
string $9072 37 ; "buffer will be 'transferred' into the"
string $9098 9 ; "language."
string $90A2 41 ; "f5:- Global replace.              All, or"
string $90D0 45 ; "use last f5. Special replace characters are:/"
string $90FE 5 ; "begin"
string $9104 21 ; "replace section; & is"
string $911A 12 ; "found string"
string $9127 52 ; "%n found wild section n. See f4 for find characters."
string $9160 22 ; "screen mode may be set"
string $9177 21 ; "a specific mode. Also"
string $918D 52 ; "Descriptive (D), or Key legend (K) modes may be set."
string $91C2 19 ; "D and K use mode 0."
string $91DA 19 ; "current position of"
string $91EE 25 ; "cursor (_) is remembered."
string $9209 21 ; "status line will show"
string $921F 22 ; "number of marks in use"
string $9236 9 ; "(if any)."
string $9243 28 ; "All place marks are cleared."
string $9265 3 ; "The"
string $9269 11 ; "between two"
string $9275 19 ; "places is copied to"
string $9289 28 ; "the current cursor position."
string $92A7 22 ; "marks are NOT cleared."
string $92C1 3 ; "The"
string $92C5 11 ; "between two"
string $92D1 18 ; "places is moved to"
string $92E4 28 ; "the current cursor position."
string $9302 23 ; "marks are then cleared."
string $931E 5 ; "whole"
string $9324 14 ; "is printed out"
string $9333 26 ; "the screen or printerusing"
string $934E 29 ; "built-in formatter/paginator."
string $9370 3 ; "The"
string $9374 7 ; "between"
string $937C 14 ; "cursor and the"
string $938B 5 ; "place"
string $9391 11 ; "is deleted."
string $939E 21 ; "mark is then cleared."
string $93B8 3 ; "old"
string $93BF 33 ; "buffer is recovered after a BREAK"
string $93E1 38 ; "or immediately after a Clear Text (by "
string $9408 3 ; "9)."
string $940E 21 ; "9 (ESCAPE to abandon)"
string $9424 3 ; "All"
string $942B 18 ; "buffer is deleted."
string $943E 4 ; "Use "
string $9443 7 ; "9 twice"
string $944B 10 ; "remove the"
string $9456 16 ; "beyond hope of a"
string $9467 15 ; "recovery by f9."
string $9477 7 ; "shf-TAB"
string $9480 19 ; "TAB key may be used"
string $9494 4 ; "move"
string $9499 14 ; "zones of eight"
string $94A8 17 ; "characters across"
string $94BA 10 ; "screen, or"
string $94C5 14 ; "position under"
string $94D4 9 ; "the first"
string $94E1 23 ; "line immediately above."
string $94F9 8 ; "shf-COPY"
string $9502 19 ; "Cursor editing with"
string $9516 77 ; "cursor keys & COPY is enabled.User defined soft keys are available as normal."
string $9564 42 ; "All characters except ESCAPE are put into "
entry $961E
byte $964C 3 ; (Seems to be an extra byte)
entry $964F
byte $96AB 3
entry $96AE
string $9716 7 ; "Insert "
entry $971E
string $9723 7 ; "Over   "
string $9732 19 ; "     Cursor Editing"
entry $9746
string $9752 9 ; "One mark "
entry $975C
string $9761 9 ; "Two marks"
entry $976B
string $9776 9 ; "TAB cols "
entry $9780
string $9785 9 ; "TAB words"
string $9799 10 ; " Modified "
entry $97A4
string $97A9 10 ; " Discarded"
string $97B9 10 ; " Original "
string $97CD 3 ; " LF"
entry $97D1
string $97D6 3 ; " CR"
string $97ED 14 ; "Type filename "
entry $97FC
string $9A75 19 ; "Type language name:"
entry $9A89
string $9AB5 38 ; "Not enough space to return to language"
byte $9B04
byte $9B0F
entry $9B12
byte $9B26
entry $9B26 
string $9B29 34 ; "Format commands:- {initial values}"
string $9B4D 38 ; "afrn assign format n to register r {0}"
string $9B74 36 ; "anrn assign number to register r {0}"
string $9B9C 4 ; "bold"
string $9BA5 5 ; "begin"
string $9BAC 12 ; "cc c control"
string $9BB9 8 ; "is c {.}"
string $9BC5 6 ; "centre"
string $9BCD 23 ; "ch*c chain in next file"
string $9BE8 7 ; "comment"
string $9BF1 24 ; "dmcc define macro to .en"
string $9C0D 12 ; "double space"
string $9C21 4 ; "foot"
string $9C2B 4 ; "head"
string $9C33 26 ; "end of .at, .ix or .ef etc"
string $9C51 6 ; "begin "
string $9C5D 9 ; "form feed"
string $9C67 27 ; "printer, wait if paged mode"
string $9C87 13 ; " and odd foot"
string $9C99 13 ; " and odd head"
string $9CAA 15 ; "close indexfile"
string $9CBD 22 ; "ignore input until .en"
string $9CD4 36 ; "in+- indent left margin n places {0}"
string $9CF9 30 ; "io*c open indexfile for output"
string $9D1B 4 ; "send"
string $9D20 22 ; "to indexfile until .en"
string $9D3A 23 ; "justify right margin of"
string $9D52 6 ; "s {on}"
string $9D59 4 ; "ll+-"
string $9D5E 29 ; " length including indent {76}"
string $9D7C 4 ; "ls+-"
string $9D81 17 ; " spacing is n {1}"
string $9D93 18 ; "lv n leave n blank"
string $9DA6 22 ; "s (by .ne n and .sp n)"
string $9DBD 19 ; "ne n needs n output"
string $9DD1 19 ; "s, .bp if necessary"
string $9DE8 19 ; "no justification of"
string $9E01 6 ; "no new"
string $9E08 11 ; " after this"
string $9E18 3 ; "odd"
string $9E1C 4 ; "foot"
string $9E24 3 ; "odd"
string $9E28 4 ; "head"
string $9E30 9 ; "begin odd"
string $9E3B 43 ; "os*c call operating system with this string"
string $9E67 4 ; "pl+-"
string $9E6C 16 ; "area length is n"
string $9E84 4 ; "po+-"
string $9E89 15 ; "offset is n {0}"
string $9E9C 16 ; "right flush this"
string $9EAE 19 ; "sp n insert n blank"
string $9EC7 12 ; "single space"
string $9ED9 28 ; "define tabs {8,16,24,...,96}"
string $9EF6 15 ; "tcc  define tab"
string $9F06 13 ; "as c {ctrl I}"
string $9F14 23 ; "ti+- temporary indent n"
string $9F2C 30 ; "trcc translate {NBSP is space}"
string $9F4E 9 ; "underline"
string $9F5A 55 ; "n represents a decimal number, 0 is used if not present"
string $9F92 45 ; "Spaces are allowed before n. c represents any"
string $9FC1 63 ; "+- allows n, +n or -n: .in+2 sets an indent 2 more than current"
string $A001 41 ; "ti+2 is a temporary indent of 2 more than"
string $A02B 14 ; "current indent"
string $A03B 45 ; "Formatting commands which can appear anywhere"
string $A06D 10 ; "begin bold"
string $A07B 15 ; "begin underline"
string $A08E 8 ; "end bold"
string $A09A 13 ; "end underline"
string $A0AB 12 ; "counted as 1"
string $A0BC 21 ; "without being counted"
string $A0D2 34 ; "r0-9 contents of register e.g. .r0"
entry $A0F8 
byte $A145
string $A146 5 ; "title"
string $A14C 3 ; ".en"
string $A155 17 ; " n output CHR$(n)"
string $A167 8 ; "printer "
string $A173 5 ; " line"
string $A179 6 ; " page "
string $A180 11 ; " character "
string $A18C 5 ; "shf-f"
string $A192 6 ; " text "
string $A199 8 ; " marked "
string $A1A2 6 ; "RETURN"
string $A1AC 5 ; " uses"
string $A1B2 20 ; "name at the start of"
string $A1C7 11 ; "after a '>'"
string $A1D3 6 ; "COPY, "
string $A1DB 3 ; "use"
string $A1DF 18 ; "current file name."
string $A1F2 4 ; "The "
string $A1FB 19 ; "file will be loaded"
string $A20F 4 ; "text"
string $A214 4 ; "even"
string $A219 16 ; " scroll margins "
string $A22B 11 ; "with ctrl-f"
string $A237 4 ; " to "
string $A23C 5 ; " the "
entry $A242
string $A292 30 ; "Screen, Printer, As is, Help ?"
entry $A2B1
string $A2C9 19 ; "Continuous, Paged ?"
entry $A2DD
byte $A350 3
entry $A353
string $A3B9 12 ; "Print done. "
byte $A3CC 3
entry $A3CF
entry $A604
byte $AA4A 3 ; VDUDON
entry $AA4D
byte $AA5C 12
entry $AA68
string $AC08 23 ; "Press SHIFT to continue"
byte $AD1F 13
byte $AD2C 13
string $AD39 26; CHARS
string $AD53 2
word $AD55
string $AD57 2
word $AD59
string $AD5B 2
word $AD5D
string $AD5F 2
word $AD61
string $AD63 2
word $AD65
string $AD67 2
word $AD69
string $AD6B 2
word $AD6D
string $AD6F 2
word $AD71
string $AD73 2
word $AD75
string $AD77 2
word $AD79
string $AD7B 2
word $AD7D
string $AD7F 2
word $AD81
string $AD83 2
word $AD85
string $AD87 2
word $AD89
string $AD8B 2
word $AD8D
string $AD8F 2
word $AD91
string $AD93 2
word $AD95
string $AD97 2
word $AD99
string $AD9B 2
word $AD9D
string $AD9F 2
word $ADA1
string $ADA3 2
word $ADA5
string $ADA7 2
word $ADA9
string $ADAB 2
word $ADAD
string $ADAF 2
word $ADB1 
string $ADB3 2
word $ADB5 
string $ADB7 2
word $ADB9 
string $ADBB 2
word $ADBD
string $ADBF 2
word $ADC1
string $ADC3 2
word $ADC5
string $ADC7 2
word $ADC9
string $ADCB 2
word $ADCD
string $ADCF 2
word $ADD1
string $ADD3 2
word $ADD5 
string $ADD7 2
word $ADD9 
string $ADDB 2
word $ADDD
string $ADDF 2
word $ADE1
string $ADE3 2
word $ADE5
string $ADE7 2
word $ADE9
string $ADEB 2
word $ADED
string $ADEF 2
word $ADF1 
string $ADF3 2
word $ADF5 
string $ADF7 2
word $ADF9 
string $ADFB 2
word $ADFD
byte $AE93 3
entry $AE95 
entry $AE96
byte $AEDC
entry $AEE7
byte $B033
byte $B034
byte $B035
byte $B036
entry $B038
entry $B0E8
entry $B126
entry $B151
entry $B167
entry $B19F
entry $B1D8
entry $B1DE
entry $B1E4
entry $B1ED
string $B1F0 40 ; "Clear text [Y,shf-f9 (exec),D (discard)]"
entry $B218
entry $B241 ; LOADfi
string $B24A 22 ; "Overwrite text [Y,f2]:"
byte $B261
entry $B262
string $B277 22 ; "Type filename to load:"
entry $B28E
entry $B299
string $B2A3 8 ; "to save:"
entry $B2AC
string $B2C7 24 ; "for MARK TO CURSOR save:"
entry $B2E1
string $B30A 22 ; "Bad use of stored name"
entry $B321
string $B32A 10 ; "to insert:"
entry $B334
entry $B35D
string $B367 12 ; "Command line"
entry $B397
byte $B3A8
byte $B3A9
byte $B3AA
byte $B3AB
byte $B3AC
byte $B3AD
entry $B3AF
entry $B3B8
string $B3C4 23 ; "Only 0,1,3,4,6,7,D or K"
entry $B3EA
string $B3ED 9 ; "New Mode:"
entry $B3f7
string $B4A3 7 ; "No room"
string $B4AC 17 ; "No old text found"
entry $B4FD
string $B52A 8 ; "At line "
entry $B533
string $B539 11 ; ", new line:"
entry $B545
string $B54F 10 ; "Bad number"
string $B55B 14 ; "Line not found"
entry $B56A
entry $B5C9
string $B671 23 ; "Too many find multiples"
string $B6D4 24 ; "Bad replace field number"
string $B722 16 ; "Syntax incorrect"
string $B745 12 ; "Error with ~"
string $B75F 12 ; "Error with \"
entry $B76C
string $B804 12 ; "Error with |"
string $B9FA 7 ; "No room"
string $BA42 15 ; "Global replace:"
entry $BA52
string $BAB5 1;
entry $BAB7
string $BABD 6 ; " found"
entry $BAC4
string $BAC7 18 ; "No previous string"
entry $BADA
string $BADD 17 ; "Find and replace:"
entry $BAEF
string $BBB9 10 ; " Not found"
byte $BBF7 5
byte $BBFC 5
string $BC73 11 ; "Mark(s) set"
string $BCE5 11 ; "Bad marking"
entry $BCF1
entry $BD07 ; CLEARMARKS
entry $BD0D ; MKDEL
entry $BD27 ; MKCPY
entry $BD79 ; MKMVE
string $BE41 54 ; "C(ontinue), E(nd of file replace), R(eplace) or ESCAPE"
entry $BE78
string $BE7C 11 ; "Replace by:"
entry $BE88
string $BE98 3 ; ".he"
string $BE9C 3 ; ".en"
string $BEA0 3 ; ".fo"
string $BEA4 3 ; ".ce"
string $BEA8 8 ; "Page .r0"
string $BEB1 6 ; ".ff.en"
string $BEB8 3 ; ".he"
string $BEBC 3 ; ".en"
string $BEC0 3 ; ".fo"
string $BEC4 3 ; ".ce"
string $BEC8 8 ; "Page .r0"
string $BED1 6 ; ".ff.en"
word $b397 ; starCB
byte $b399 2
; NUMERL
; entry $B813
; startCB
