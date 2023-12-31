        TTL     EDIT text editor        > EDIT00

        ;
        ; Updates started 11th December 1986 by J.G.Smith
        ;

        ; ------------------------------------------------------------ ;

        CPU     1       ; This version solely for CMOS machines

        ; ------------------------------------------------------------ ;

        ; The editor keeps a byte in the CMOS RAM.
        ; It is copied into TUTMOD on startup.
        ;
        ; Bits 0 to 2 define the current mode with the following relationship
        ;       Value   Mode
        ;        0   -   0 ( 80x31 )
        ;        1   -   1 ( 40x31 )
        ;        2   -   K ( 80x24 ) Function key display (Mode 0)
        ;        3   -   3 ( 80x24 )
        ;        4   -   4 ( 40x31 )
        ;        5   -   D ( 80x17 ) Full HELP display    (Mode 0)
        ;        6   -   6 ( 40x24 )
        ;        7   -   7 ( 40x24 )
        ;
        ; Bit 3 - indicates TABKEY mode
        ; Bit 4 - indicates Insert/Overtype
        ; Bit 5 - indicates display CR
        ; Bit 6 - has been given to the network
        ; Bit 7 - obey format controls
        ;
        ; one should be taken over for LF/CR as newline maybe

        ; ------------------------------------------------------------ ;

null    *       &00
lf      *       &0A
cr      *       &0D
tab     *       &09
down    *       lf
up      *       &0B
home    *       &1E
space   *       " "
delete  *       &7F

        [ lfver=0
termin  *       cr      ; line terminator
        |
termin  *       lf      ; a different line terminator
        ]


bit7    *       &80
bit6    *       &40
bit5    *       &20
bit4    *       &10
bit3    *       &08
bit2    *       &04
bit1    *       &02
bit0    *       &01

        ; ------------------------------------------------------------ ;

blink   *       bit6
fblink  *       bit5

fcstrt  *       &00             ; Full cursor start line
ncstrt  *       &07             ; Normal start line

        ; ------------------------------------------------------------ ;

moureg  *       &FC50
mouxlo  *       moureg + 2
mouswi  *       moureg + 6

        ; EDIT symbolic constants
osfind  *       &FFCE
osbput  *       &FFD4
osargs  *       &FFDA
osfile  *       &FFDD
osrdch  *       &FFE0
osasci  *       &FFE3
osnewl  *       &FFE7
oswrch  *       &FFEE
osword  *       &FFF1
osbyte  *       &FFF4
oscli   *       &FFF7
escflg  *       &FF
brkv    *       &0202

        ^       &01
csrtoc  #       &01
csronw  #       &01
hardup  #       &01
harddo  #       &01
fullsc  #       &01
thelot  #       &01
      
        ^       &80
multsy  #       &01
notsym  #       &01
wildsy  #       &01
alphas  #       &01
digsym  #       &01
subrsy  #       &01
setsym  #       &01
fields  #       &01
founds  #       &01
escsym  #       &01
nsensy  #       &01
buttsy  #       &01
termsy  #       &01
      
        ^       &00
string  #       &02
paje    #       &02
tmax    #       &02
temp    #       &02
addr    #       &02
argp    #       &02
varp    #       &02
TP      #       &02
GS      #       &02
GE      #       &02
MS      #       &02
xeff    *       MS
lastsp  *       MS + 1
me      #       &02
diff    *       ME
centre  *       ME + 1
smatlo  #       &02
rflush  *       smatlo
linfed  *       smatlo + 1
smathi  #       &02
len     *       smathi
indent  *       smathi + 1
umatlo  #       &02
underl  *       umatlo
pundrl  *       umatlo + 1
umathi  #       &02
bold    *       umathi
vspace  *       umathi + 1

        [ cf8key=1
clterm  #       &01     ; current line terminator
        ]
        [ extgf=1       ; Extended search/replace characters
ctptr   #       &02     ; current text pointer
        ]

hymem   #       &02
tstart  #       &02
brkact  #       &01
size    #       &02
maxsiz  #       &02
pwtflg  #       &01
prtflg  #       &01
tutmod  #       &01
modflg  #       &01
Atemp   #       &01
count   #       &01
index   #       &01
pagewi  #       &01
pagele  #       &01
realPA  #       &01
scrupY  #       &01
maxscr  #       &01
update  #       &01
scrnPY  #       &01
scrnX   #       &01
scrnY   #       &01
lnbufx  #       &01
cursed  #       &01
sstckx  #       &01
fill    *       sstckx
replin  #       &01
tinden  *       replin
chunks  #       &02
juslen  *       chunks
spaces  *       chunks + 1
nummar  #       &01
L       *       nummar
marksb  #       &01
Q       *       markSB
currle  #       &01
nextre  #       &01
nxtchr  #       &01
lineDW  #       &01
fieldI  #       &01
lineot  *       fieldI
inpind  #       &01
ctlcha  *       inpind
outind  #       &01
boldrq  *       outind
MMX     #       &01
undrrq  *       mmx
offset  #       &01               ; page offset
simpch  #       &01
pbold   *       simpch
nextX   #       &01
lastta  *       nextx
line    #       &02
doindX  *       line
indexH  #       &01
mulffl  #       &01
tabcha  *       mulffl
markX   #       &01
TSM     #       &01
BSM     #       &01
scratc  #       &12
buff    *       scratc + 10     ; (no.bffr len 15 {MMMDCCCLXXXVIII})
texpfl  *       buff
sensfl  *       buff + 1
buttfl  *       buff + 2
metafl  *       buff + 3
replfl  *       buff + 4
endp    *       buff + 8
scp     *       buff + 10
texp    *       buff + 12
mousel  *       buff + 15       ; # 10

        [ stamp=1
flexec  #       &04
flload  #       &04
        ]

        ASSERT  (@ < &8F)       ; otherwise too many definitions

        ^       &0400
frbuff  #       &64
grbuff  #       &64
nambuf  #       &34
oldsta  #       &04             ; start and end of incore text
linbuf  #       &0100
comman  *       linbuf
noregs  *       comman          ; 10 number registers
page    *       noregs          ; the page number is in 0
lineno  *       page + 2        ; the line number is in 1
pageeh  *       noregs + 10 * 2
pageoh  *       pageeh + 2
pageef  *       pageoh + 2
pageof  *       pageef + 2      ; the header and footer pointers
tablst  *       pageof + 2      ; list of tab positions, length 20
maclst  *       tablst + 20     ; list of posible macro positions
stracc  #       &0100
maxmac  *       stracc - maclst ; Number of macro posns *2

trnlst  *       stracc          ; table of translateable characters

        [ cf8key=1

        GBLS    $dhtext         ; default header text
        GBLS    $dftext         ; default footer text

$dhtext SETS    ".he .en "
$dftext SETS    ".fo .ce Page .r0 .ff.en "

dhsize  *       :LEN: "$dhtext"
dfsize  *       :LEN: "$dftext"

dhbuff  #       dhsize          ; Header buffer
dfbuff  #       dfsize          ; Footer buffer

        ]

sindex  #       &06
ssttlo  #       &06
sstthi  #       &06
scntlo  #       &06
scnthi  #       &06
fieldm  #       &0A
fieldo  #       &0A
scrim   #       &20

        ASSERT  ( @ < &07FF )

        ; ------------------------------------------------------------ ;

        LNK     EDIT01
        TTL     EDIT text editor        > EDIT01

        ; ------------------------------------------------------------ ;

origin
pasROM
        JMP     langua
        [ reladd=0
        JMP     servic
        |
        JMP     ((servic - origin) + &8000)
        ]

        [ reladd=0
        =       &C2                     ; Type flag
        |
        =       &E2                     ; relocation address provided
        ]

        =       copyri - pasROM
        =       &02
        =       "Edit"
        =       null
        =       "$vers"
copyri  
        =       null
        =       "(C)1984 Acorn"
        =       null

        [ reladd=1
        &       reladr                  ; relocation value
        &       &0000                   ; Top 2 bytes
        ]

rom1br
        ;Outputs 'brk' error message, & jumps to relevant re-entry
        ;point. Detailed action depends on value of 'brkaction' on entry -
        ; brkaction = 0 Moves cursor to editor status position,
        ; outputs error message, then prompts for space
        ; before jumping to editcont.
        ; 1    Outputs error message, and jumps to starloop.
        ; 2    resets to start of file and closes indexfile, then as 0

        LDXIM   &FF
        TXS
        STZ     cursed
        LDAIM   &7E
        JSR     osbyte
        LDA     BRKact
        CMPIM   &FF
        BNE     simBRK
unret
        LDA     addr
        BNE     unreta
        DEC     addr + 1
unretA
        DEC     addr
        LDA     argP
        BNE     unretb
        DEC     argP + 1
unretB
        DEC     argP
        LDAI    argP
        STAI    addr
        LDA     addr
        BNE     unret
        LDA     addr + 1
        CMP     string + 1
        BNE     unret
        LDAIM   cr
        STAI    tmax
        LDAIM   &00
simBRK
        CMPIM   &01
        BNE     simBK2
        JSR     supvBR
        JMP     starCN
simBK2
        BCC     norBRK
        JSR     closeX
        JSR     stFILE
norBRK
        JSR     vstrng
        =       &03,&0F,&EA
        JSR     csr0ST

        [ lerror=1
        JSR     vstrng
        =       &0B,&0B,&0B,"�",&EA
        LDXIM   "�"
        LDAIM   59-80
        JSR     BRKsub
        =       "Shift f5 D for info��",&EA
        LDXIM   " "
        LDAIM   78-80
        JSR     BRKsub
        =       "��",&EA
        LDXIM   "�"
        LDAIM   54-80
        JSR     BRKsub
        =       "Press ESCAPE to continue�",11,11,9,&EA
        JSR     BRKoy
        |
        JSR     supvBR
        JSR     curOFF
        LDA     tutmod
        ANDIM   &07
        CMPIM   &05
        BEQ     nomess
        LDAI    &FD
        CMPIM   &01
        BNE     nomess
        JSR     vstrng
        [ 1=0
        =       lf,cr,"For help type: shf-f5 D",&EA
        |
        =       lf,cr,"Shift f5 D for info",&EA ; Slightly shorter
        ]
nomess
        JSR     osnewl
        JSR     strimo
        =       "Press ESCAPE to continue",&EA
        ]

esclop
        JSR     osrdch
        CMPIM   &1B
        BNE     esclop
ESCCON
        LDAIM   &7E
        JSR     osbyte
        JSR     NORMAL
        JMP     EDITCO
SUPVBR
        JSR     OSNEWL
BRKOY
        LDYIM   &01
BRKOLP
        LDAIY   &FD
        BEQ     BRKOX
        JSR     OSASCI
        INY
        BNE     BRKOLP
BRKOX
        RTS

        ; ------------------------------------------------------------ ;

servic  ; Recognise *help and *edit

        [ mouse = 0
        CMPIM   &04
        BEQ     unknow
        CMPIM   &09
        BNE     servex

        ; *HELP response

        LDAIY   &F2
        CMPIM   cr
        BNE     helpEX  ; don't say anything unless there are no keywords

        [ reladd=0
        PHY
        |
        TYA             ; When relocated for TUBEs then non-CMOS codes
        PHA
        ]

        LDYIM   helpen - helpin - 1
helpLO
        [ reladd=0
        LDAAY   helpin          ; Must always be assembled for &8000
        |                       ; on relocated versions
        LDAAY   (helpin - reladr) + &8000
        ]
        JSR     osasci
        DEY
        BPL     helpLO

        [ reladd=0
        PLY
        |
        PLA
        TAY
        ]
helpEX
        LDAIM   &09
servex
        RTS
helpin
        = cr,"5 TIDE",cr
helpen

unknow
        ; Recognise *edit as command to enter language.

        [ reladd=0
        PHY
        PHX
        |
        TYA
        PHA
        TXA
        PHA
        ]

        LDXIM   &03
ucomLO
        LDAIY   &F2
        CMPIM   "."
        BEQ     ucommi
        ANDIM   &DF
        [ reladd=0
        CMPAX   helpen - 5      ; Must always be assembled at &8000
        |                       ; on relocated versions
        CMPAX   (helpen - reladr - 5) + &8000
        ]
        BNE     ucomEX
        INY
        DEX
        BPL     ucomLO
        LDAIY   &F2
        CMPIM   space + 1
        BCC     ucommi
ucomEX
        [ reladd=0
        PLX
        PLY
        |
        PLA
        TAX
        PLA
        TAY
        ]
        LDAIM   &04
        RTS
ucommi
        ; Command recognised - enter self as a language.
        [ reladd=0
        LDAIM   &8E
        PLX
        |
        PLA
        TAX
        LDAIM   &8E
        ]
        JMP     OSBYTE
        ]
        ; ------------------------------------------------------------ ;

langua                          ; Language entry point
        CLI
        CLD
        LDXIM   &FF
        TXS
        LDAIM   ROM1br
        STA     BRKv
        LDAIM   :MSB: ROM1BR
        STA     BRKv + 1
        CLR     oldsta + 3
        LDAIM   &F2
        STA     scratc
        CLR     scratc + 1
        JSR     readby
        TAX
        JSR     readnx
        STA     scratc + 1
        STX     scratc
        LDXIM   20
EDITol
        DEX
        BEQ     EDIToz

        JSR     readby
        JSR     readne
        CMPIM   cr
        BEQ     EDIToz

        CMPIM   " "
        BNE     EDITol
        LDXIM   &00
EDITgb
        JSR     readby
        JSR     readne
        STAAX   &01A0
        INX
        CPXIM   "@"
        BNE     EDITGB
        LDAIM   cr
        STAAX   &01A0 - 1
        STA     nambuf
        LDYIM   &00
        JSR     readhx
        BCC     EDITon
        CMPIM   ","
        BNE     EDITon
        LDAZX   &00
        STA     oldsta
        LDAZX   &01
        STA     oldsta + 1
        INY
        JSR     readHX
        BCC     EDITon
        CMPIM   cr
        BNE     EDITon
        LDAZX   &00
        STA     oldsta + 2
        LDAZX   &01
        STA     oldsta + 3
        STZ     cursed
        BRA     EDIToy
EDITon
        LDXIM   &FF
EDITn1
        INX
        LDAAX   &01A0
        CMPIM   " "
        BEQ     EDITn1
        CMPIM   cr
        BEQ     EDIToz
EDITn2
        LDAAX   &01A0
        CMPIM   cr
        BEQ     EDITn3
        CMPIM   " "
        BCC     EDIToz
        CMPIM   delete
        BCS     EDIToz

EDITn3
        STAAX   nambuf
        INX
        CMPIM   cr
        BNE     EDITn2
        LDAIM   &01
        STA     cursed
        BRA     EDIToy

EDIToz
        LDXIM   &FF
        STX     cursed
        LDAIM   cr
        STA     nambuf

        [ cf8key=1
        LDAZ    clterm          ; current line terminator
        |
        [ termin<>cr
        LDAIM   termin
        ]
        ]

        CMPI    paje
        BNE     EDIToy
        CMPI    tmax
        BNE     EDIToy
        JSR     memsta

EDIToy
        LDAIM   161             ; read CMOS RAM into 'tutmod'
        LDXIM   &08             ; our byte
        LDYIM   &10             ; ???
        JSR     osbyte
        STY     tutmod          ; returns &00 on the BBC OS 1.2

        [ mouse=1
        JSR     mouser
        ]

        LDAIM   cr
        STA     frbuff
        STA     grbuff
        [ cf8key=1
        STAZ    clterm          ; initialise 'clterm' here
        ]
        STZ     indexH
        STZ     modflg
        JSR     vstrng          ; define characters

        =       3
        =       23,"�",&00,&00,&00,&FF,&00,&00,&00,&00
        =       23,"�",&18,&18,&18,&18,&18,&18,&18,&18

        [ dchars=1      ; Character definitions for descriptive MODE
        =       23,"�",&00,&00,&00,&07,&0C,&18,&18,&18
        =       23,"�",&00,&00,&00,&E0,&30,&18,&18,&18
        =       23,"�",&18,&18,&0C,&07,&00,&00,&00,&00
        =       23,"�",&18,&18,&30,&E0,&00,&00,&00,&00
        =       23,"�",&7E,&C3,&9D,&B1,&9D,&C3,&7E,&00
        =       23,"�",&00,&18,&38,&7F,&38,&18,&00,&00
        =       23,"�",&00,&18,&1C,&FE,&1C,&18,&00,&00
        =       23,"�",&18,&18,&18,&18,&7E,&3C,&18,&00
        =       23,"�",&00,&18,&3C,&7E,&18,&18,&18,&18
        =       23,"�",&00,&00,&00,&1F,&00,&00,&00,&00
        =       23,"�",&00,&00,&00,&F8,&00,&00,&00,&00
        =       23,"�",&00,&00,&00,&FF,&18,&18,&18,&18
        =       23,"�",&18,&18,&18,&1F,&18,&18,&18,&18
        =       23,"�",&18,&18,&18,&F8,&18,&18,&18,&18
        =       23,"�",&18,&18,&18,&FF,&00,&00,&00,&00
        =       23,"�",&18,&18,&18,&FF,&18,&18,&18,&18
        ]
        [ lfarro=1
nlfarr  *       &FE
        =       23,nlfarr,&00,&18,&38,&7F,&38,&18,&00,&00
        ]

        =       &EA

        LDA     cursed
        BEQ     zippo
        DEA
        BEQ     zappo
        JMP     EDIT    ; and away we go...
zippo
        JSR     EDITmd

        [ stamp=1
        JSR      NSTAMP
        ]

        JMP     oldtex

zappo
        STZ     BRKact
        JSR     EDITmd
        JSR     EDITi2
        LDYIM   &00
        LDAIM   nambuf
        STA     temp
        LDAIM   :MSB: nambuf
        STA     temp + 1
        JSR     tload
        JMP     EDITgt

XYscra
        ; Load XY with address of scratch.
        LDXIM   :LSB: scratc
        LDYIM   :MSB: scratc
        RTS

readne
        INC     scratc
        BNE     . + 4
        INC     scratc + 1
        RTS

readhx
        LDXIM   0
        STZ     scratc + 5
tsthex
        LDAAY   &01A0
        CMPIM   "0"
        BCC     hexend
        CMPIM   "9" + 1
        BCC     OKhex
        SBCIM   &37
        CMPIM   10
        BCC     hexend
        CMPIM   16
        BCS     hexend
OKhex
        ASL     scratc + 5
        ASL     scratc + 5
        ASL     scratc + 5
        ASL     scratc + 5
        ANDIM   &0F
        TSB     scratc + 5
        INY
        INX
        BRA     tsthex
hexend
        CPXIM   &01             ; CC status for not found
        LDX     scratc + 5
        RTS

readnx
        JSR     readne

readby
        PHX
        PHY
        JSR     XYscra
        LDAIM   5
        JSR     osword
        PLY
        PLX
        LDA     scratc + 4
        RTS

paslnm
        SEC
        SBC     addr
        STA     maxsiz
        TXA
        SBC     addr + 1
        STA     maxsiz + 1

filena
        ; Entry - IY temp points to input name. Exit - scratch -> filename.
        LDAIY   temp
        CMPIM   cr
        BEQ     textna
        CMPIM   &8B
        BEQ     oldnam
        LDXIM   &00

memnam
        LDAIY   temp
        STAAX   nambuf
        INY
        INX
        CPXIM   52
        BNE     memnam

oldnam
        LDA     nambuf
        CMPIM   cr
        BEQ     nonam
        LDAIM   nambuf
        STA     scratc
        LDAIM   :MSB: nambuf
        STA     scratc + 1
        RTS

textna
        LDX     GE
        LDY     GE + 1
        PHX
        PHY
        LDX     tstart
        LDY     tstart + 1
        JSR     GPBKXY
        LDYIM   &00

MVIC
        LDAIY   GE
        STAAY   stracc
        INY
        BNE     MVIC 
        PLY
        PLX
        JSR     GPFDXY
        LDYIM   &FF
namsrc
        INY
        BMI     nonam
        LDAAY   STRACC

        [ cf8key=1
        CMPZ    clterm
        |
        CMPIM   termin
        ]

        BEQ     nonam
        CMPIM   ">"
        BNE     namsrc
        INY
        STY     scratc
namsr3
        LDAAY   stracc

        [ cf8key=1
        CMPZ    clterm
        |
        CMPIM   termin
        ]

        BEQ     namfnd
        INY
        BPL     namsr3
nonam
        TYA
        BEQ     namsrc
        BRK
        =       &01,"No name found",null

namfnd

        [ cf8key=1
        LDAIM   cr
        STAAY   stracc
        |
        [ termin<>cr
        LDAIM   cr
        STAAY   STRACC
        ]
        ]

        LDAIM   :MSB: stracc
        STA     scratc + 1
        RTS

writna
        JSR     startI
        LDYIM   &FF
wrispc
        INY
        LDAIY   scratc
        CMPIM   " "
        BEQ     wrispc
wrilop
        LDAIY   scratc
        CMPIM   " " + 1
        BCC     wriex
        JSR     oswrch
        INY
        BRA     wrilop
wriex
        JMP     stopin

tload
        LDA     tstart
        STA     addr
        LDA     tstart + 1
        STA     addr + 1
        LDA     tmax
        LDX     tmax + 1

        [ STAMP=1
        JSR     pasloa
        PHX
        PHY
        LDXIM   flload
        LDYIM   &02
        JSR     frscra
        LDXIM   flexec
        JSR     frscra
        PLY
        PLX
        RTS
        ]

pasloa
        ; Entry - IY temp -> name, addr = load address, AX = max free address
        ; Exit - File checked for size (not on slow FS's)
        ; File loaded to addr, with XY = top of file
        JSR     paslnm
        JSR     prompt
        =       "Loading ",&EA
        JSR     writna

pasGO
        LDYIM   &00
        TYA
        JSR     osargs
        CMPIM   &04
        BCC     nosize
        ; Using a random access filing system,
        ; so can quickly check size of file.
        LDAIM   &05
        JSR     XYscra
        JSR     osfile
        CMPIM   &01
        BNE     nosize          ; Let FS generate 'Directory/not found' error.
        LDA     scratc + &0C
        ORA     scratc + &0D
        BNE     paslhu
        LDA     maxsiz
        CMP     scratc + &0A
        LDA     maxsiz + 1
        SBC     scratc + &0B
        BCC     paslhu

nosize
        ; Load file to addr, & set XY --> top of loaded file.
        LDA     addr
        STA     scratc + 2
        LDA     addr + 1
        STA     scratc + 3
        CLR     scratc + 4
        CLR     scratc + 5
        CLR     scratc + 6
        LDAIM   &FF
        JSR     XYscra
        JSR     osfile
        CLR     oldsta + 3      ; make old impossible
        CLC
        LDA     addr
        ADC     scratch + &0A
        TAX
        LDA     addr + 1
        ADC     scratc + &0B
        TAY
        RTS

paslhu
        BRK
        =       &02,"File too big",null

tSAVE
        ; Save (defaulting) marked block of text.
        ; Entry - (temp),Y points to input name.
        ; GE = Start of block
        ; ENDP = End of block
        ; Exit - specified memory saved as filename.
        JSR     filena

inSAVE
        JSR     prompt
        =       "Saving to ",&EA
        JSR     writna
        LDXIM   &0F
pasacl
        STZAX   scratc + 2
        DEX
        BPL     pasacl

        [ STAMP=1
        JSR     dstamp
        LDXIM   flload
        LDYIM   &02
        JSR     toscra
        LDXIM   flexec
        JSR     toscra
        LDXIM   GE
        JSR     toscr2
        LDYIM   &0E
        LDXIM   endp
        JSR     toscr2
        |
        DEC     scratc + 6
        DEC     scratc + 7
        DEC     scratc + 8
        DEC     scratc + 9
        LDA     GE
        STA     scratc + &0A
        LDA     GE + 1
        STA     scratc + &0B
        LDA     endp
        STA     scratc + &0E
        LDA     endp + 1
        STA     scratc + &0F
        ]

        LDAIM   &00
        JSR     XYscra
        JMP     osfile

        [ STAMP=1
toscra
        JSR     toscr2
toscr2
        JSR     toscr1
toscr1
        LDAZX   &00
        STAAY   scratc
        INX
        INY
        RTS

frscra
        JSR     frscr2
frscr2
        JSR     frscr1
frscr1
        LDAAY   scratc
        STAZX   &00
        INX
        INY
dstmpX
        RTS

nstamp
        LDXIM   &07
        LDAIM   &00
nstmp1
        STAAX   flexec
        CPXIM   &04
        BNE     nstmp2
        LDAIM   &FF
nstmp2
        DEX
        BPL     nstmp1
        RTS
mstamp
        LDAIM   &FF
        STA     flload + 1
        STA     flload + 2
        STA     flload + 3
dstamp
        LDA     flload + 1
        AND     flload + 2
        AND     flload + 3
        INA
        BNE     dstmpX
        LDXIM   flexec
        LDYIM   &00
        LDAIM   &01
        JMP     osword
        ]

readns
        ; Reads line to commandline (linbuf), & strips leading &
        ; trailing spaces.
        ; Exit - temp --> 1st non-space char on line
        ; A      = 1st non-space char on line
        ; Y      = 0
        ; EQ if line was 'empty', else NE

        JSR     readLS
        TYA
        BEQ     renSCR
renSST
        LDAAY   comman - 1
        CMPIM   space
        BNE     renSCR
        DEY
        BNE     renSST
renSCR
        LDAIM   cr
        STAAY   comman
        LDYIM   &FF
renSIG
        INY
        LDAAY   comman
        CMPIM   space
        BEQ     renSIG
        CLC
readIM
        TYA
        ADCIM   :LSB: comman
        STA     temp
        LDAIM   &00
        ADCIM   :MSB: comman
        STA     temp + 1
        LDYIM   &00
        LDAI    temp
        CMPIM   cr
escCLR
        RTS

readIN
        LDYIM   &00
        BRA     readIM

readLS
        LDAIM   " "
        JSR     oswrch

        ; Read line into linbuf/commandline, testing for escape.
        ; Exit - Y = No. of chars read (excluding CR).

        LDAIM   thelot
        STA     update
        JSR     rdlnre
        BCC     escCLR
escSET
        JSR     VSTRNG
        =       &03,&0F,&0D,&EA
        LDA     BRKact
        CMPIM   &02
        BNE     escSIM
        JSR     closeX
        JSR     stFILE
escSIM
        STZ     cursed
        JMP     escCON
escTST
        BIT     &FF
        BMI     escSET
        RTS

RDLNRE
        LDYIM   0
RDLNLP
        JSR     OSRDCH
        BCS     RDLNEX
        STAAY   LINBUF
        CMPIM   &7F
        BNE     RDLN2
        CPYIM   0
        BEQ     RDLNLP
        DEY
        JSR     OSWRCH
        BRA     RDLNLP
RDLN2
        CMPIM   &15
        BNE     RDLN3
RDLNDL
        TYA
        BEQ     RDLNLP
        LDAIM   &7F
        JSR     OSWRCH
        DEY
        BRA     RDLNDL
RDLN3
        INY
        CMPIM   CR
        BEQ     RDLNEG
        JSR     PASWRCH
        BRA     RDLNLP
RDLNEG
        PHY
        JSR     CUROFF
        PLY
        DEY
        CLC
RDLNEX
        RTS
COPYBK
        ; Copy block backwards (i.e. to lower address).
        ; Entry - ARGP --> block of size XY
        ; VARP --> destination address 
        STX     SIZE
        STY     SIZE + 1
        LDA     SIZE
        ORA     SIZE + 1
        BEQ     BKEXIT
        LDX     SIZE + 1
        SEC
        LDAIM   0
        SBC     SIZE
        TAY
        BEQ     BKLOOP
        STA     TEMP
        SEC
        LDA     ARGP
        SBC     TEMP
        STA     ARGP
        BCS     CPNHI1
        DEC     ARGP + 1
        SEC
CPNHI1
        LDA     VARP
        SBC     TEMP
        STA     VARP
        BCS     CPNHI2
        DEC     VARP + 1
CPNHI2
        INX
BKLOOP
        LDAIY   ARGP
        STAIY   VARP
        INY
        BNE     BKLOOP
        INC     ARGP + 1
        INC     VARP + 1
        DEX
        BNE     BKLOOP
BKEXIT
        RTS

memsta
        LDA     tstart + 1
        JSR     chkptr
        LDA     GS + 1
        JSR     chkptr
        LDA     GE + 1
        JSR     CHKPTR
        LDA     TMAX + 1
        JSR     CHKPTR
        LDX     TMAX
        LDY     TMAX + 1
        JSR     GPFDXY
        LDA     TSTART
        STA     OLDSTA
        LDA     TSTART + 1
        STA     OLDSTA + 1
        LDA     GS
        STA     OLDSTA + 2
        LDA     GS + 1
        STA     OLDSTA + 3
        CLC
CHKPTX
        RTS
CHKPTR
        CMP     HYMEM + 1
        BCS     CHKPTX
        CMP     PAJE + 1
        BCS     CHKPTX
        PLA
        PLA
        RTS

        [ lerror=1
BRKSUB
        SEC
        ADC     PAGEWI
        TAY
        TXA
BRKSB1
        JSR     OSWRCH
        DEY
        BNE     BRKSB1
        ]

VSTRNG
        PLA
        STA     STRING
        PLA
        STA     STRING + 1
        JSR     VSTRLP
        JMI     STRING
VSTRLM
        JSR     OSWRCH
VSTRLP
        INC     STRING
        BNE     STRINOT
        INC     STRING + 1
STRINO
        LDAI    STRING          ; enter here for normal string
        CMPIM   &EA
        BNE     VSTRLM
        RTS
CRTOGG
        LDAIM   &20
        EOR     TUTMOD
DOMODE
        STA     TUTMOD
        PHX
        PHY
        TAY
        LDAIM   162
        LDXIM   8
        JSR     OSBYTE
        PLY
        PLX
        RTS
TESTIF
        LDAIM   &10
        BIT     TUTMOD
        RTS
        [ MOUSE=1
MOUSER
        LDA     MOUSEL
        STA     MOUSEL + 5
        LDAIM   &92
        LDXIM   MOUSWI
        JSR     OSBYTE
        STY     MOUSEL
        LDXIM   MOUXLO
        JSR     OSBYTE
        PHY
        INX
        JSR     OSBYTE
        PLA
        ANDIM   &F8
        PHA
        SBC     MOUSEL + 1
        STA     MOUSEL + 6
        TYA
        SBC     MOUSEL + 2
        STA     MOUSEL + 7
        STY     MOUSEL + 2
        PLA
        STA     MOUSEL + 1
        LDAIM   &92
        INX
        JSR     OSBYTE
        PHY
        INX
        JSR     OSBYTE
        PLA
        ANDIM   &F8
        PHA
        SBC     MOUSEL + 3
        STA     MOUSEL + 8
        TYA
        SBC     MOUSEL + 4
        STA     MOUSEL + 9      ; ychange
        STY     MOUSEL + 4
        PLY
        STY     MOUSEL + 3
        RTS
        ]

        LNK     EDIT02

        END
        ; -> EDIT02
        ;                                      current
        ;                                      line
        ; PAJE                                                 HYMEM
        ;  v                                   <......>          v
        ; +-+-------------+-------------------+---------------+-+
        ; |$|.............|                 |...............|$|
        ; +-+-------------+-------------------+---------------+-+
        ;    ^             ^                   ^               ^
        ; TSTART           GS                  GE            TMAX
        ; scrnXAs is X coord of cursor. (GE)creenX is char under cursor,
        ; unless $ isA0 in (GE) .. (GE),scrnX (when it is that $).
        ; scrnY is Y coord of current line on screen, and may be forced by the
        ; screen update routine.
        ; Screen update types:-
        ;  none   ; Simple cursor movements
        ;  csronw ; Character insert/delete
        ;  fullsc ; Find,replace etc
        ;  thelot ; Clears screen first. After tload etc
        ;  hardup ; Special case, for cursor movevents
        ;  harddo ; Special case, for cursor movevents
        ;  pagewi ; is max X-coord of screen, and pagelength is max Y-coord of
        ;           screen (thus Y-coord of status line is pagelength + 1).
        ;  scrim  (screen image) holds maximum cursorX position written to each
        ;         line on the screen (including the CR, if any)
EDIT
        JSR     editmd

        [ stamp = 1
        JSR     nstamp
        ]
EDITin
        LDX     tstart          ; Initialize pointers to reflect empty buffer.
        LDY     tstart + 1
EDITgt
        STZ     modflg          ; Re-entry point for Tload. XY = End of file.
EDITgs
        JSR     EDITtd          ; Re-entry from OLDSTA, newmode
EDITco
        LDXIM &FF               ; Re-entry point for brk-handler.
        TXS
        STZ     BRKact
        JSR     inited
        LDAIM   thelot
        STA     update

EDITlo                          ; Update screen to reflect previous command.

        JSR     SCRNUD
        JSR     CSRSCR
        JSR     CURON

        [ curtyp=1
        JSR     curupd          ; update the cursor to relevant state
        ]

        LDAIM   FULLSC
        STA     UPDATE
        ; Read a char, and branch depending on its value
        ;   &00 - &7F     is ASCII input to be entered as text
        ;   &80 - &8F     are softkey values       }
        ;   &90 - &9F     are shift-softkey values } Editor commands
        ;   &A0 - &AF     are ctrl-sofkkey values  }
        ;   &8A, &9A, &AA is the TAB key
        ;   &B0 - &FF     are entered into text (e.g. icelandics)
        JSR     EDRDCH
        TAX
        BPL     EDITTE
        CMPIM   &B0
        BCS     EDITTE

        [ phil = 0
        LDX     CURSED
        BNE     EDITTE
        TAX
        |
        TAX
        LDA     CURSED
        BEQ     PHIL1
        TXA
        ANDIM   &F
        CMPIM   &A
        TXA
        BCC     EDITTE
phil1
        ]

        LDA     TUTMOD
        ANDIM   7
        CMPIM   5
        BNE     GOMAN
        CPXIM   &9C
        BCS     GOMAN
        CPXIM   &90
        BCS     DEFVAL
        CPXIM   &8A
        BCS     GOMAN
DEFVAL
        TXA
        PHA
        ASLA
        TAY
        JSR     VSTRNG
        =       26,30,31,0,8,&EA
        LDAAY   TXTTAB
        STA     STRING
        LDAAY   TXTTAB + 1
        STA     STRING + 1
TUTLIN
        LDYIM   &00
        JSR     osnewl
TUTOUT
        LDAI    STRING
        INC     STRING
        BNE     TUTINC
        INC     STRING + 1
TUTINC
        CMPIM   cr
        BEQ     NEEDWP
        CMPIM   &EA
        BEQ     TUTDON
        JSR     OSWRCH
        INY
        BRA     TUTOUT
NEEDWP
        LDAIM   " "
TUTWIP
        CPYIM   54
        BCS     TUTLIN
        JSR     OSWRCH
        INY
        BRA     TUTWIP
TUTDON
        JSR     DECWIN
        JSR     CSRSCR
        PLX
GOMAN
        TXA
        ASLA
        TAX
        JSR     IADDRS
        JMP     EDITlo
IADDRS
        JMIX    EDCTBL
EDITTE
        JSR     EDTEXT
        JMP     EDITlo
EDTEXT
        ; Entry - A holds ASCII char to be treated as text input
        ; Exit  - appropraite action taken depending on current
        ;        'mode' (insert, overtype, csr-edit).
        CMPIM   DELETE
        BEQ     ECHRDE
        CLR     OLDSTA + 3
        CMPIM   cr
        BNE     ECHRCO
        JSR     TESTIF ;In insert mode put in the CR
        BNE     ECHRCR
        JSR     ENDTES
        BCS     ECHRCR
        CLR     SCRNX
        JMP     CURDWN ;in overtype mode CR is start of line
ECHRCR
        [ cf8key=1
        LDAZ    clterm
        |
        LDAIM   termin
        ]
ECHRCO
        ; Insert character into text.
        PHA
        JSR     ADDVIR
        ; Don't insert in overtype mode, unless at end of line.
        JSR     TESTIF
        BNE     ECHRMV
        LDY     SCRNX
        LDAIY   GE
        [ cf8key=1
        CMPZ    clterm
        |
        CMPIM   termin
        ]
        BNE     ECHRCH
ECHRMV
        LDXIM 1
        LDA     SCRNX
        JSR     INSRTX
ECHRCH
        PLA
        LDY     SCRNX
        STAIY   GE
        ; Write char to screen (cursor OK), wiping tail for TERMIN.
        [ cf8key=1
        CMPZ    clterm
        |
        CMPIM   termin
        ]
        BNE     ECHRNT
        JSR     PASWCR
        LDA     SCRNX
        LDY     SCRNY
        JSR     WIPETA
EHRCSU
        CLR     SCRNX
        JSR     CURDWN
ECHRUP
        LDA     UPDATE
        BEQ     ECHREL
        JSR     SCRNUD
ECHREL
        LDAIM   CSRONW
        STA     UPDATE
        JMP     MODIFY
ECHRNT
        JSR     PASWRC
        JSR     CURRT
ECHRN0
        LDA     UPDATE
        BEQ     ECHRN1
        JSR     SCRNUD
ECHRN1
        LDAIM   CSRTOC
        STA     UPDATE
        JMP     MODIFY
ECHRDE
        ; Delete virtual space implies csrleft. Can't delete start of file.
        JSR     VSCOUN
        BEQ     EDELST
        JMP     CURLT
EDELST
        LDA     SCRNX
        BNE     EDELCO
        JSR     STARTTEST
        BCS     DELABX
EDELCO
        ; Get char to be deleted under cursor. In absence of VS check,
        ; this will give TERMIN delete when past end of line.
        JSR     CURLT
        JSR     LENGTH          ; different line than current!
        CMP     SCRNX
        BCS     EDELMT
        STA     SCRNX
EDELMT
        ; Branch on text-entry mode (insert/overtype).
        LDY     SCRNX
        JSR     TESTIF
        BNE     EDELSL
        LDAIY   GE
        [ cf8key=1
        CMPZ    clterm
        |
        CMPIM   termin
        ]
        BEQ     DELABX
        LDAIM   SPACE
        STAIY   GE
        LDAIM   CSRTOC
        STA     UPDATE
        JMP     MODIFY
EDELSL
        LDAIY   GE
        [ cf8key=1
        CMPZ    clterm
        |
        CMPIM   termin
        ]
        BEQ     EDELS2
        LDA     CURRLE
        CMP     PAGEWI
        BEQ     EDELS2
        JSR     EDEL1
        BRA     ECHRN0
EDELS2
        JSR     EDEL1
        BRA     ECHRUP
DELLIX
        JSR     DELABV
DELLIN
        CLR     SCRNX
        LDAI    GE
        [ cf8key=1
        CMPZ    clterm
        |
        CMPIM   termin
        ]
        BNE     DELLIX
        JSR     LENGTH
        STA     CURRLE
        JSR     DELABV
        JMP     ECHREL
DELABV
        JSR     ENDTES
        BCC     DELABY
        LDA     SCRNX
        CMP     CURRLE
        BCC     DELABY
DELABX
        RTS
DELABY
        LDA     CURRLE
        CMP     SCRNX
        BCC     DELABX
        LDYIM   CSRTOC
        STY     UPDATE
        CMP     PAGEWI
        BEQ     EDEL0
        LDY     SCRNX
        LDAIY   GE
        [ cf8key=1
        CMPZ    clterm
        |
        CMPIM   termin
        ]
        BNE     EDEL1
EDEL0
        INC     UPDATE
EDEL1
        ; Shift up start of line 'over' deleted character.
        JSR     MODIFY
        CLC
        LDA     GE
        STA     TEMP
        ADC     SCRNX
        STA     ADDR
        LDA     GE + 1
        STA     TEMP + 1
        ADCIM   0
        STA     ADDR + 1
        INC     GE
        BNE     EDELNH
        INC     GE + 1
EDELNH
        LDY     SCRNX
        BRA     EDELDY
EDELLP
        LDAIY   TEMP
        STAIY   GE
EDELDY
        DEY
        BPL     EDELLP
        LDX     MARKX
EDELMK
        DEX
        BMI     DELABX
        LDYAX   SMATLO
        CPY     ADDR
        LDAAX   SMATHI
        SBC     ADDR + 1
        BCS     EDELMK
        INCAX   SMATLO
        BNE     EDELMK
        INCAX   SMATHI
        BRA     EDELMK

EDCTBL
        &       EDITli          ; f0
        &       EDstar          ; f1
        &       LOADfi          ; f2
        &       SAVEfi          ; f3
        &       findre          ; f4
        &       globre          ; f5
        &       setmar          ; f6
        &       mkCPY           ; f7
        &       print           ; f8
        &       oldtex          ; f9
        &       tabkey          ; f10
        &       delabv          ; copy
        &       curLT           ; left
        &       curRT           ; right
        &       curDWN          ; down
        &       curUP           ; up
        ;
        &       crtogg          ; shift-f0
        &       IOtogg          ; shift-f1
        &       insrtf          ; shift-f2
        &       scmclr          ; shift-f3
        &       retlan          ; shift-f4
        &       getmod          ; shift-f5
        &       clearm          ; shift-f6
        &       mkmve           ; shift-f7
        &       mkdel           ; shift-f8
        &       newtex          ; shift-f9
        &       tabctl          ; shift-f10
        &       allowc          ; shift-copy
        &       wordle          ; shift-left
        &       wordri          ; shift-right
        &       pagedn          ; shift-down
        &       pageup          ; shift-up
        ;
        &       EDITlo          ; ctrl-f0
        &       EDITlo          ; ctrl-f1
        &       EDITlo          ; ctrl-f2
        &       EDITlo          ; ctrl-f3
        &       EDITlo          ; ctrl-f4
        &       EDITlo          ; ctrl-f5
        &       tsmcsr          ; ctrl-f6
        &       bsmcsr          ; ctrl-f7
        [ cf8key=1
        &       cf8swt          ; ctrl-f8
        |
        &       EDITlo          ; ctrl-f8
        ]
        &       EDITlo          ; ctrl-f9
        &       EDITlo          ; ctrl-f10
        &       dellin          ; ctrl-copy
        &       curst           ; ctrl-left
        &       curend          ; ctrl-right
        &       curedf          ; ctrl-down
        &       stfile          ; ctrl-up

TXTTAB
        &       F0
        &       F1
        &       F2
        &       F3
        &       F4
        &       F5
        &       F6
        &       F7
        &       F8
        &       F9
        &       F9
        &       F9
        &       F9
        &       F9
        &       F9
        &       F9
        &       SHFF0
        &       SHFF1
        &       SHFF2
        &       SHFF3
        &       SHFF4
        &       SHFF5
        &       SHFF6
        &       SHFF7
        &       SHFF8
        &       SHFF9
        &       SHFTAB
        &       SHFCOP
BIGMES
        JSR VSTRNG
        =       "�shf-f0��shf-f1��shf-f2��shf-f3��shf-f4��shf-f5��shf-f6��shf-f7��shf-f8��shf-f9�"
        =       "�Display�Insert/�Insert �Remove �Return � Set   � Clear �Marked �Marked �Clear �"
        =       "�Returns�Over   � file  �Margins�Languag� Mode  � Marks �Move   �Delete �text  �"
        =       "���f0������f1������f2������f3������f4������f5������f6������f7������f8������f9���"
        =       "� Goto  �Command� Load  � Save  �Find   �Global � Mark  �Marked � Print � Old  �"
        =       "� line  �line   � file  � file  �String �Replace� Place �Copy   � text  � text �"
        =       "��������������������������������������������������������������������������������"
        NOP
        RTS
BIGMET
        JSR     VSTRNG
        =       "The Acorn Screen Editor � 1984 Acorn Computers Ver $vers"

        [ mouse = 1
        =       "m"
        |
        =       " "
        ]

        =       "�����Shift: screen up   "      ; EOL 1

        [ syzygy=1      ; "a SYZYGY prog"

        =       "      a"
        =       23,32,&00,&01,&01,&01,&00,&01,&01,&01,32
        =       23,32,&F4,&14,&04,&F3,&10,&10,&10,&E7,32
        =       23,32,&5F,&41,&42,&C4,&48,&50,&50,&9F,32
        =       23,32,&44,&45,&45,&3C,&04,&04,&04,&79,32
        =       23,32,&F4,&14,&14,&F3,&10,&10,&10,&E7,32
        =       23,32,&40,&40,&40,&C0,&40,&40,&40,&80,32
        =       23,32,&00,&00,&00,&00,&00,&00,&00,&00
        =       "prog "
        |
        =       "                  "
        ]

        =       "             Descriptive Mode "

        [ cf8key=1
        =       "CR/LF"
        |
        [ termin=lf
        =       "(LF) "
        |
        =       "     "
        ]
        ]

        =       "   � � �Control: text start"  ; EOL 2

        =       "TAB performs tabulation controlled by shift TAB.      ���������Shift: word l/r  "  ; EOL 3

        =       "COPY deletes the character above the cursor.          � ����� �Control:         "  ; EOL 4

        =       "shift COPY provides normal soft keys and cursor       ���������    l/r of line  "  ; EOL 5

        =       "       copying (ESCAPE to leave this mode).             � � �Shift: screen down "  ; EOL 6

        =       "control COPY deletes the current line to next new line  �����Control: text end  "  ; EOL 7
        NOP
        RTS

f0
        =       "f0",cr
        [ shortm=0
        =       "The cursor can be moved to a new line.",cr
        =       "For this operation lines are character sequences",cr
        =       "ended by RETURN (|M).",cr,&EA
        |
        =       "Move the cursor to a new line",cr
        =       "Lines are character sequences ended by RETURN (|M)",cr
        =       cr
        NOP
        ]

shff0
        =       "shf-f0",cr
        [ shortm=0
        =       "The ends of lines can be shown as a special",cr
        =       "character so that they can be seen clearly.",cr
        =       "This alters with each press of shf-f0.",cr,&EA
        |
        =       "Highlight the end of line character",cr
        =       "This is a toggled function",cr
        =       cr
        NOP
        ]

F1
        =       "f1",cr
        [ shortm=0
        =       "Commands to the computer's operating system can be",cr
        =       "given. The result is seen at once. Extra commands",cr
        =       "can be entered until RETURN by itself is typed.",cr,&EA
        |
        =       "Commands can be sent to the Command Line Interpreter",cr
        =       "The function is terminated by RETURN only",cr
        =       cr
        NOP
        ]

SHFF1
        =       "shf-f1",cr
        [ shortm=0
        =       "Changes between Insert and Over. In Insert mode the",cr
        =       "text typed is inserted causing the existing text to",cr
        =       "move. In Over mode the text is typed over old text.",cr,&EA
        |
        =       "Toggle Insert/Over mode",cr
        =       cr
        =       cr
        NOP
        ]

F2
        =       "f2",cr
        [ shortm=0
        =       "A text file will be loaded, erasing the current text.",cr
        =       "RETURN uses the name at the start of text after a '>'",cr
        =       "COPY, RETURN to use the current file name.",cr,&EA
        |
        =       "Load file, erasing the current text",cr
        =       "RETURN uses the name at the start of text after a '>'",cr
        =       "COPY RETURN to use the current file name",cr
        NOP
        ]

SHFF2
        =       "shf-f2",cr
        [ shortm=0
        =       "A text file will be loaded at the current cursor.",cr
        =       "RETURN uses the name at the start of text after a '>'",cr
        =       "COPY, RETURN to use the current file name.",cr,&EA
        |
        =       "Insert file to current cursor position",cr
        =       "RETURN uses the name at the start of text after a '>'",cr
        =       "COPY RETURN to use the current file name",cr
        NOP
        ]

F3
        =       "f3",cr
        [ shortm=0
        =       "All or 'mark to cursor' text will be saved to a file.",cr
        =       "RETURN uses the name at the start of text after a '>'",cr
        =       "COPY, RETURN to use the current file name.",cr,&EA
        |
        =       "Save text. All or 'mark to cursor' text will be saved",cr
        =       "RETURN uses the name at the start of text after a '>'",cr
        =       "COPY RETURN to use the current file name",cr
        NOP
        ]

SHFF3
        =       "shf-f3",cr
        [ shortm=0
        =       "The top and bottom scroll margins have been removed.",cr
        =       "Set Top scroll margin to cursor line with ctrl-f6",cr
        =       "Set Bottom scroll margin to cursor line with ctrl-f7",cr,&EA
        |
        =       "Remove top and bottom scroll margins",cr
        =       "Set Top scroll margin to current line with ctrl-f6",cr
        =       "Set Bottom scroll margin to current line with ctrl-f7",cr
        NOP
        ]

F4
        =       "f4:- Interactive Find and Replace Function.",cr
        [ shortm=0
        =       "RETURN to use last f4. Special search characters are:",cr
        =       "# digit, $ RETURN, . any, [ ] set of char, a-z a to z",cr
        =       "~ not, * many, ^ many, | control, @ alpha, \ literal.",cr,&EA
        |
        =       "RETURN to use last f4. Special search characters are:",cr
        =       "# digit, $ RETURN, . any, [ ] set of char, a-z a to z",cr
        =       "~ not, * many, ^ many, | control, @ alpha, \ literal.",cr
        NOP
        ]

SHFF4
        =       "shf-f4",cr
        [ shortm=0
        =       "Return to specified language.",cr
        =       "The text in the buffer will be 'transferred' into the",cr
        =       "language.",cr,&EA
        |
        =       "Return to specified language",cr
        =       "Text is transferred to the language",cr
        =       cr
        NOP
        ]

F5
        [ shortm=0
        =       "f5:- Global replace.              All, or marked text.",cr
        =       "RETURN to use last f5. Special replace characters are:",cr
        =       "/ to begin the replace section; & is the found string",cr
        =       "%n found wild section n. See f4 for find characters.",cr,&EA
        |
        =       "f5: Global replace. All or marked text",cr
        =       "RETURN to use last f5. Special replace characters are:",cr
        =       "/ to begin the replace section; & is the found string",cr
        =       "%n found wild section n. See f4 for find characters.",cr
        NOP
        ]

SHFF5
        =       "shf-f5",cr
        [ shortm=0
        =       "The screen mode may be set to a specific mode. Also",cr
        =       "Descriptive (D), or Key legend (K) modes may be set.",cr
        =       "D and K use mode 0.",cr,&EA
        |
        =       "Set screen mode",cr
        =       "D - Descriptive",cr
        =       "K - Key legend",cr
        NOP
        ]

F6
        =       "f6",cr
        [ shortm=0
        =       "The current position of the cursor (_) is remembered.",cr
        =       "The number at the bottom indicates how many (0,1,2)",cr
        =       "marks (",255,") are being used.",cr,&EA
        |
        =       "Set a marker",cr
        =       "The number (0,1,2) of marks (",255,") set is",cr
        =       "given on the status line",cr
        NOP
        ]

SHFF6
        =       "shf-f6",cr
        [ shortm=0
        =       "All place marks are cleared.",cr
        =       "",cr
        =       "",cr,&EA
        |
        =       "Clear markers",cr
        =       cr
        =       cr
        NOP
        ]

F7
        =       "f7",cr
        [ shortm=0
        =       "The text between two marked places is copied to",cr
        =       "the current cursor position.",cr
        =       "The marks are NOT cleared.",cr,&EA
        |
        =       "Text is copied to the current position",cr
        =       "The marks are NOT cleared",cr
        =       cr
        NOP
        ]

SHFF7
        =       "shf-f7",cr
        [ shortm=0
        =       "The text between two marked places is moved to",cr
        =       "the current cursor position.",cr
        =       "The marks are then cleared.",cr,&EA
        |
        =       "Text is moved to current position",cr
        =       "The marks are cleared",cr
        =       cr
        NOP
        ]

F8
        =       "f8",cr
        [ shortm=0
        =       "The whole text is printed out to the screen or printer",cr
        =       "using the built-in formatter/paginator.",cr
        =       "",cr,&EA
        |
        =       "Print text to screen or printer",cr
        =       cr
        =       cr
        NOP
        ]

SHFF8
        =       "shf-f8",cr
        [ shortm=0
        =       "The text between the cursor and the marked place",cr
        =       "is deleted.",cr
        =       "The mark is then cleared.",cr,&EA
        |
        =       "Delete text between marker and current position",cr
        =       "The mark is then cleared",cr
        =       cr
        NOP
        ]

F9
        =       "f9",cr
        [ shortm=0
        =       "The old text in the buffer is recovered after a BREAK",cr
        =       "or immediately after a Clear Text (by shf-f9).",cr
        =       "",cr,&EA
        |
        =       "Recover old text",cr
        =       cr
        =       cr
        NOP
        ]

SHFF9
        =       "shf-f9",cr
        [ shortm=0
        =       "All text in the buffer is deleted.",cr
        =       "Use shf-f9 twice to remove the text beyond hope of a",cr
        =       "recovery by f9.",cr,&EA
        |
        =       "Delete text",cr
        [ stamp=0
        =       "shf-f9 twice will remove text beyond recovery by f9",cr
        =       cr
        |
        =       "shf-f9 Y will select time stamping",cr
        =       "shf-f9 shf-f9 selects 'EXEC' addresses",cr
        ]
        NOP
        ]

SHFTAB
        =       "shf-TAB",cr
        [ shortm=0
        =       "The TAB key may be used to move to zones of eight",cr
        =       "characters across the screen, or to position under",cr
        =       "the first character of the line immediately above.",cr,&EA
        |
        =       "TAB to columns of 8, or to the position under the",cr
        =       "first character of the previous line",cr
        =       cr
        NOP
        ]

SHFCOP
        =       "shf-COPY",cr
        [ shortm=0
        =       "Cursor editing can be used with ������ and COPY.",cr
        =       "User defined soft keys are available as normal.",cr
        =       "All characters except ESCAPE are put into text.",cr,&EA
        |
        =       "Cursor editing mode. ������ and COPY and user",cr
        =       "defined soft keys available as normal",cr
        =       "ESCAPE terminates this mode",cr
        NOP
        ]

        [ cF8key=1
ctrlF8
        =       "Ctrl-f8",cr
        =       "Toggle newline character between LF(|J) and CR(|M)",cr
        =       cr
        =       cr
        NOP
        ]

        ; ------------------------------------------------------------ ;

        LNK     EDIT03
        ; -> EDIT03
INITED
        ; Set up edit keys as softkeys, and set softkeys to have
        ; following bases -
        ; plain = &80
        ; shift = &90
        ; ctrl  = &A0
        LDAIM   4
        LDXIM   2
        JSR     OSBYTE
        LDAIM   &DB
        LDXIM   128 + 10
        LDYIM   0
        JSR     OSBYTE          ; tab key pretends to be soft key 10
        LDAIM   &E3
        LDXIM   &A0
        LDYIM   0
        JSR     OSBYTE
        LDAIM   &E2
        LDXIM   &90
        LDYIM   0
        JSR     OSBYTE
        LDXIM   &80
INITEX
        LDAIM &E1
        LDYIM   0
        JMP     OSBYTE
INITUS
        ; Return cursor-keys & softkeys to 'normal' state.
        LDAIM   &DB
        LDXIM   9
        LDYIM   0
        JSR     OSBYTE          ; tab key emits 9
        LDAIM   4
        LDXIM   0
        JSR     OSBYTE
        LDXIM   1
        BRA     INITEX
STARTT
        ; Returns CS if on 1st line (GS = TSTART), else CC.
        LDA     TSTART
        CMP     GS
        LDA     TSTART + 1
        SBC     GS + 1
        RTS
ENDTES
        ; Returns CS if on last line (GE + scrimcreenY = TMAX), else CC.
        CLC
        LDA     CURRLE
        ADC     GE
        TAX
        LDAIM   0
        ADC     GE + 1
        CPX     TMAX
        SBC     TMAX + 1
        RTS
LENGTH
        ; Find length of current line. Exit - A = length - 1
        LDYIM   0
LECCLO
        LDAIY GE
        [ cf8key=1
        CMPZ    clterm
        |
        CMPIM   termin
        ]
        BEQ     LECCRE
        INY
        CPY     PAGEWI
        BNE     LECCLO
LECCRE
        TYA
        RTS
CHECKR
        ; Check for space in edit buffer.
        ; Entry - XY = required No. of bytes
        ; Exit  - size = XY
        ;         XY = temp = GE - XY
        ;         Error if temp < GS

        STX     SIZE
        STY     SIZE + 1
        SEC
        LDA     GE
        SBC     SIZE
        TAX
        LDA     GE + 1
        SBC     SIZE + 1
        TAY
        STX     TEMP
        STY     TEMP + 1
        CPX     GS
        SBC     GS + 1
        BCS     VDU23X
        JMP     CHNRRE                  ; 'No room'

CURON
        LDYIM 1
        BRA     VDU231
CUROFF
        LDYIM 0
VDU231
        LDXIM 1
VDU23
        ; Entry - X = 1st byte, Y = 2nd byte
        ; Exit  - VDU 23,X,Y,0,0,0,0,0,0,0 Output.

        LDAIM   23
        JSR     OSWRCH
        TXA
        JSR     OSWRCH
        TYA
        JSR     OSWRCH
        JSR     VSTRNG
        =       &00,&00,&00,&00,&00,&00,&00,&EA
VDU23X
        RTS

INTPAG
        LDA     TUTMOD
        ANDIM   7
        CMPIM   2
        BEQ     KEYONL
        CMPIM   5
        BEQ     KEYONL
        BRA     NOTTUT
CLEARS
        LDA     TUTMOD
        ANDIM   7
        CMPIM   2
        BEQ     DOTUT
        CMPIM   5
        BNE     NOTTUT
DOTUT
        PHA
        JSR     VSTRNG
        =       26,HOME,&EA
        JSR     STARTI
        JSR     BIGMESS
        PLA
        CMPIM   2
        BEQ     KEYONL
        JSR     BIGMET
KEYONL
        JSR     STOPIN
        JSR     GETWIN          ; get size of total screen
        STA     REALPA          ; pagelength in A
        JSR     DECWIN
NOTTUT
        JSR     GETWIN          ; get size of working area
        TAX                     ; pagelength again in A
        INX                     ; Initialize scrim.
        LDA     PAGEWI
SCMILO
        STAAX   SCRIM
        DEX
        BPL     SCMILO
        JSR     STATUS
        CLR     SCRNPY
        RTS
GETWIN
        LDAIM   160
        LDXIM   10
        JSR     OSBYTE
        STX     PAGEWI
        STY     PAGELE
        LDXIM   8
        JSR     OSBYTE
        TYA
        CLC
        SBC     PAGELE
        STA     PAGELE
        RTS
DECWIN
        LDA     TUTMOD
        ANDIM   7
        LDYIM   14
        CMPIM   5
        BEQ     WINDOW
        LDYIM   7
        CMPIM   2
        BNE     NOWIND
WINDOW
        LDAIM   28
        JSR     OSWRCH
        LDAIM   0
        JSR     OSWRCH
        LDA     REALPA
        INA
        JSR     OSWRCH
        LDA     PAGEWI
        JSR     OSWRCH
        TYA
        JMP     OSWRCH
NOWIND
        LDAIM   26
        JMP     OSWRCH
EDRDCH
        ; Exit - A holds character read
        LDA     NEXTREADFLAG
        BEQ     EDRDOSRD
        LDA     NXTCHR
        CLR     NEXTREADFLAG
        RTS
EDRDOSRD
        [ MOUSE=1
        PHX
        PHY
MOUSLP
        LDAIM   &81
        LDXIM   0
        LDYIM   0
        JSR     OSBYTE
        TXA
        CPYIM   &FF
        BNE     NOMOUSE
        JSR     MOUSER
        LDA     MOUSEL + 8
        ORA     MOUSEL + 9
        BNE     MOUSLY
        LDA     MOUSEL + 6
        ORA     MOUSEL + 7
        BNE     MOUSLX
        LDA     MOUSEL
        CMP     MOUSEL + 5
        BEQ     MOUSLP
        ANDIM   &7
        BITIM   &1
        BNE     MOUSK1
        BITIM   &2
        BNE     MOUSK2
        BITIM   &4
        BEQ     MOUSLP
        LDAIM   &86
        BRA     NOMOUS
MOUSK1
        LDAIM   &98
        BRA     NOMOUS
MOUSK2
        LDAIM   &97
        BRA     NOMOUS
MOUSLX
        LDAIM   &8D
        LDX     MOUSEL + 7
        BPL     NOMOUS
        LDAIM   &8C
        BNE     NOMOUS
MOUSLY
        LDAIM   &8F
        LDX     MOUSEL + 9
        BPL     NOMOUSE
        LDAIM   &8E
NOMOUSE
        PLX
        PLY
        |
        JSR     OSRDCH
        ]

        JMP     ESCTST
MODIFY
        LDAIM   1
        LDX     MODFLG
        STA     MODFLG
        BEQ     STATUS
        RTS
TABCTL
        LDAIM   8
        EOR     TUTMOD
        JSR     DOMODE

CstatU
        STZ     UPDATE          ; update required
status
        JSR     CSR0ST          ; Output status on status line.
        JSR     startI          ; Start inverse
        JSR     TESTIF
        BEQ     STATSO

        JSR     VSTRNG
        =       "Insert ",&EA
        BRA     STATSI

STATSO
        JSR     VSTRNG
        =       "Over   ",&EA

STATSI
        LDX     CURSED
        BEQ     STATSC
        JSR     VSTRNG

        [ PHIL=0
        =       "    Cursor Editing",&EA
        |
        =       "    Soft Key Entry",&EA
        ]

        BRA     STATSX

STATSC
        LDA     MARKX
        BEQ     STATST
        DEA
        BNE     STATSM
        JSR     VSTRNG
        =       "One mark ",&EA
        BRA     STATSS
STATSM
        JSR     VSTRNG
        =       "Two marks",&EA
        BRA     STATSS
STATST
        LDAIM 8
        AND     TUTMOD
        BNE     STATTW
        JSR     VSTRNG
        =       "TAB cols ",&EA
        BRA     STATSS
STATTW
        JSR     VSTRNG
        =       "TAB words",&EA
STATSS
        LDA     MODFLG
        BNE     STATMO
        JSR     VSTRNG
        =       " Original",&EA
        BRA     STATSX
STATMO
        JSR     VSTRNG
        =       " Modified",&EA
STATSX
        [ cf8key=1

        LDAZ    clterm
        CMPIM   cr
        BEQ     STATcr

        JSR     vstrng
        =       " LF",&EA

        BRA     STATlf
STATcr
        JSR     vstrng
        =       " CR",&EA

STATlf
        ]

        [ STAMP=1
        LDA     FLLOAD + 1
        AND     FLLOAD + 2
        AND     FLLOAD + 3
        INA
        BNE     STATNS

        JSR     VSTRNG
        =       " Date",&EA
        BRA     STATNQ
STATNS

        JSR     VSTRNG
        =       " Exec",&EA
STATNQ
        ]

        JSR     stopIN          ; stop inverse
        LDY     pagele
        INY

prmptl  *       25              ; Prompt position

        GBLA    $prmod
$prmod  SETA    0               ; the modification to prmptl for nice printing

        [ cf8key=1
$prmod  SETA    ($prmod + 3)    ; CR/LF text
        ]

        [ stamp=1
$prmod  SETA    ($prmod + 5)    ; Date/Exec text
        ]

        LDAIM   (PRMPTL - 1 + $prmod)   ; plus any modifications

        JMP     wipeTA                  ; and clear the rest of the line


promtF
        JSR     prompt
        =       "Type filename ",&EA
        LDXIM   &01
        BRA     STRMFL

prompt
        LDY PAGELE
        INY
        JSR     WIPELI
        LDXIM   0
PRMPTX
        LDY     PAGELE
        INY
        JSR     CSRXY
        LDXIM   1
        BRA     STRMFL
STRIMO
        LDXIM 0
STRMFL
        JSR     STARTI
        PLA
        STA     STRING
        PLA
        STA     STRING + 1
        JSR     VSTRLP
        JSR     STOPIN
        TXA
        BEQ     STRMEX
        LDA     PAGEWI
        DEA
        LDY     PAGELE
        STAAY   SCRIM + 1
STRMEX
        JMI STRING
CSRSCR
        LDX SCRNX
        LDY     SCRNY
        BPL     CSRXY
CSR0ST
        LDY PAGELE
        INY
CSR0Y
        LDXIM 0
CSRXY
        LDAIM 31
        JSR     OSWRCH
        TXA
        JSR     OSWRCH
        TYA
        JMP     OSWRCH
NORMAL
        ; Entry : gap character positioned
        ; Exit : gap moved to start of current line
        LDA     GS
        STA     TEMP
        LDA     GS + 1
        STA     TEMP + 1
        JSR     FINDPO
        STA     STRING
        SEC
        LDA     GS
        SBC     STRING
        TAX
        LDA     GS + 1
        SBCIM   0
        TAY
        JMP     GPBKXY
FINDPO
        ; Entry : temp-> middle of line in 1st half of text
        ; Exit  : A[Z]  = xcoord (0..page..width) of pointer within line.
        ;         Y(=atemp) = page_width - A  
        CLC     ;-1
        LDA     TEMP
        SBC     PAGEWI 
        STA     TEMP
        BCS     FIPOND
        DEC     TEMP + 1
FIPOND
        LDY PAGEWI
FIPOLP
        LDAIY TEMP
        [ cf8key=1
        CMPZ    clterm
        |
        CMPIM   termin
        ]
        BEQ     FIPOL2
FIPOE2
        ; Entry point, when called from tempbacklines.
        DEY
        BPL     FIPOLP
        BMI     FINDPO
FIPOL2
        STY ATEMP
        SEC
        LDA     PAGEWI
        SBC     ATEMP
        RTS
TPGEFD
        ; TP := GE  +  A lines
        LDX     GE
        LDY     GE + 1
        STX     TP
        STY     TP + 1
TPFWDA
        ; Moves pointer TP forward A lines.
        ; Entry - A = No. of lines to advance TP
        ; Exit  - TP advanced (possibly by less than A lines if hit EOT)
        ;         count = No. of lines remaining from original request.
        ;         atemp = Last end of line character.
        TAX
        STX     COUNT
        BEQ     TPTPEX
TPTPLP
        LDYIM &FF
TPTPSE
        INY
        LDAIY   TP
        [ cf8key=1
        CMPZ    clterm
        |
        CMPIM   termin
        ]
        BEQ     TPTPFD
        CPY     PAGEWI
        BNE     TPTPSE
TPTPFD
        STA ATEMP
        TYA
        JSR     TPPAP1
        BCS     TPTPEX
        DEC     COUNT
        BNE     TPTPLP
TPTPEX
        RTS
TPPAP1
        ; Exit  -  CC TP = TP  +  (A + 1). CS TP + (A + 1) = HYMEM,
        ;          TP unchanged.
        SEC     ; + 1
        ADC     TP
        TAX
        LDAIM   0
        ADC     TP + 1
        TAY
        CPX     HYMEM
        SBC     HYMEM + 1
        BCS     TPPAPX
        STX     TP
        STY     TP + 1
TPPAPX
        RTS
TPGSBK
        ; TP := GS - A lines
        ; Entry - A = No. of lines to retreat XY.
        ; Exit  - TP retreated
        ;         A = No. of lines was able to go back.
        LDX     GS
        LDY     GS + 1
        STX     TP
        STY     TP + 1
        TAX
        STX     COUNT
        BEQ     TPXYEX
        LDXIM   0
TPXYLP
        LDA TSTART
        CMP     TP
        LDA     TSTART + 1
        SBC     TP + 1
        BCS     TPXYAB
        CLC     ; - 1
        LDA     TP
        SBC     PAGEWI
        STA     TP
        BCS     TPXYND
        DEC     TP + 1
TPXYND
        LDY PAGEWI
        LDAIY   TP
        [ cf8key=1
        CMPZ    clterm
        |
        CMPIM   termin
        ]
        BNE     TPXYCO
        LDA     TP
        STA     TEMP
        LDA     TP + 1
        STA     TEMP + 1
        JSR     FIPOE2
        BEQ     TPXYCO
        TYA                     ; answer from FINDPO in Y
        ADC     TP              ; + 1 from CS
        STA     TP
        BCC     TPXYCO
        INC     TP + 1
TPXYCO
        INX
        CPX     COUNT
        BCC     TPXYLP
TPXYAB
        TXA
TPXYEX
        RTS
PAGEUP
        LDA PAGELE
        INA
MVLNBK
        ; Entry - A = No. of lines to move gap back.
        ; Exit  - Gap moved back A lines. May be moved less if
        ;         hits start of file.
        JSR     TPGSBK
        LDX     TP
        LDY     TP + 1
GPBKXY
        ; Move gap back so that GS := XY
        STX     ARGP
        STY     ARGP + 1
        SEC
        LDA     GS
        SBC     ARGP
        STX     GS
        TAX
        LDA     GS + 1
        SBC     ARGP + 1
        STY     GS + 1
        TAY
        STX     SIZE
        STY     SIZE + 1
        LDA     GE
        SBC     SIZE
        STA     VARP
        STA     GE
        LDA     GE + 1
        SBC     SIZE + 1
        STA     VARP + 1
        STA     GE + 1
COPYFD
        ; Copy block forward (i.e. to higher address).
        ; Entry - ARGP --> block of size XY
        ;         VARP --> destination address 
        ; Exit  - ARGP,VARP uncorrupted.
        STX     SIZE
        STY     SIZE + 1
CPFD2
        LDA SIZE
        TAY
        ORA     SIZE + 1
        BEQ     CPFDEX
        LDX     SIZE + 1
        CLC
        TXA
        ADC     ARGP + 1
        STA     ARGP + 1
        TXA
        ADC     VARP + 1
        STA     VARP + 1
        INX
        BCC     CPFDL2
CPFDLP
        LDAIY ARGP
        STAIY   VARP
CPFDL2
        DEY
        CPYIM   &FF
        BNE     CPFDLP
        DEX
        BEQ     CPFDEX
        DEC     ARGP + 1
        DEC     VARP + 1
        BNE     CPFDLP
CPFDEX
        RTS
PAGEDN
        LDA PAGELE
        INA
MVLNFD
        JSR TPGEFD
GPFDTP
        LDX TP
        LDY     TP + 1
GPFDXY
        ; Move gap forward so that GE := XY
        LDA     GE
        STA     ARGP
        LDA     GE + 1
        STA     ARGP + 1
        LDA     GS
        STA     VARP
        LDA     GS + 1
        STA     VARP + 1
        SEC
        TXA
        SBC     GE
        TAX
        TYA
        SBC     GE + 1
        TAY
        CLC
        TXA
        ADC     GS
        STA     GS
        TYA
        ADC     GS + 1
        STA     GS + 1
        TXA
        ADC     GE
        STA     GE
        TYA
        ADC     GE + 1
        STA     GE + 1
        JMP     COPYBK
FINEPO
        ; Entry - Gap line positioned, without VS in text.
        ; Exit  - Gap character positioned, with VS added.
        JSR     ADDVIR
        CLC
        LDA     GE
        ADC     SCRNX
        TAX
        LDA     GE + 1
        ADCIM   0
        TAY
        BRA     GPFDXY
ADDVIR
        JSR     VSCOUN
        BEQ     ADVSEX
        PHA
        TAX
        LDA     CURRLE
        JSR     INSRTX
        ; Wipe possible visible TERMIN.
        LDX     CURRLE
        LDY     SCRNY
        JSR     CSRXY
        LDAIM   SPACE
        JSR     OSWRCH
        PLX     ;number spaces from VSCOUN
        LDY     SCRNX
ADVSLP
        DEY
        STAIY   GE
        DEX
        BNE     ADVSLP
ADVSEX
        JMP     CSRSCR
VSCOUN
        ; Exit - A(Z) = Number of virtual spaces.
        SEC
        LDA     SCRNX
        SBC     CURRLE
        BCS     VSCTEX
        LDAIM   0
VSCTEX
        RTS
INSRTX
        ; Entry - Require gap of XY ( > 0) opening up after GE  +  A
        ; Exit  - GE -= XY (checked against GS)
        ;         A chars moved back to new GE, to open up gap
        STA     ATEMP
        CLC
        ADC     GE
        PHA
        LDA     GE + 1
        ADCIM   0
        PHA
        PHX
        LDYIM   0
        JSR     CHECKR
        LDYIM   0
INSXLP
        LDAIY GE
        STAIY   TEMP
        INY
        CPY     ATEMP
        BCC     INSXLP
        STX     GE
        LDA     TEMP + 1
        STA     GE + 1
        PLX
        STX     COUNT
        PLA
        STA     TEMP + 1
        PLA
        STA     TEMP
        LDY     MARKX
INSXMK
        DEY
        BMI     INSXEX
        LDXAY   SMATLO
        CPX     TEMP
        LDAAY   SMATHI
        SBC     TEMP + 1
        BCS     INSXMK
        SEC
        TXA
        SBC     COUNT
        STAAY   SMATLO
        LDAAY   SMATHI
        SBCIM   0
        STAAY   SMATHI
        BRA     INSXMK
INSXEX
        RTS
TABKEY
        LDAIM 8
        BIT     TUTMOD
        BNE     TABSTR
TABPOS
        INC SCRNX
        LDA     SCRNX
        ANDIM   7
        BNE     TABPOS
        LDA     SCRNX
        CMP     PAGEWI
        BCC     TABX
        CLR     SCRNX
        BRA     TABX
TABSTR
        LDAIM 1
        JSR     TPGSBK
        CMPIM   1
        BNE     INSXEX
        LDY     SCRNX
        DEY
TABS1
        INY
        CPY     PAGEWI
        BCS     TABSSP
        LDAIY   TP
        [ cf8key=1
        CMPZ    clterm
        |
        CMPIM   termin
        ]
        BEQ     TABSSP
        CMPIM   " "
        BNE     TABS1
        BRA     TABS2
TABSSP
        LDYIM &FF
TABS2
        INY
        CPY     PAGEWI
        BCS     TABSEX
        LDAIY   TP
        CMPIM   " "
        BEQ     TABS2
TABSEX
        STY     SCRNX
TABX
        CLR     UPDATE
RELANX
        RTS
RETLAN
        JSR     PROMPT
        =       "Type language name:",&EA
        JSR     READLS
        BEQ     RELANX
        LDYIM   0
RELAPL
        LDAAY   LINBUF
        INY
        CMPIM   CR
        BNE     RELAPL
        STAAY   LINBUF + 1
        LDAIM   " "
        STAAY   LINBUF - 1
        LDAIM   "@"
        STAAY   LINBUF
        LDAIM   THELOT
        STA     UPDATE
        JSR     STFILE
        LDA     GE + 1
        DEA
        CMP     PAJE + 1
        BCS     RETLOK
        BRK
        =       &02,"Not enough space to return to language",null
RETLOK
        LDAIM   &FF
        STA     BRKACT          ; pretty lethal break action rqd
        LDA     PAJE + 1
        INA
        STA     ARGP + 1
        CLR     ARGP
        LDAIM   0
        STAI    TMAX            ; terminating zero
        LDA     GE
        STA     ADDR
        LDA     GE + 1
        STA     ADDR + 1
RELLOP
        LDAI    ADDR
        STAI    ARGP
        INC     ARGP
        BNE     RELLOQ
        INC     ARGP + 1
RELLOQ
        INC     ADDR
        BNE     RELLOP
        INC     ADDR + 1
        LDA     ADDR + 1
        CMP     HYMEM + 1
        BNE     RELLOP
        JSR     CURON
        JSR     VSTRNG
        =       26,12,&EA
        JSR     INITUS
        LDA     PAJE + 1
        INA
        STA     STRING + 1  ; set 0 to PAGE + 256
        CLR     STRING
        LDXIM   LINBUF
        LDYIM   /LINBUF
        JMP     OSCLI

prHELP
        = 14,cr,cr,"Format commands:- {initial values}",cr
        = cr
        = ".afrn assign format n to register r {0}",cr
        = ".anrn assign number to register r {0}",cr
        = ".bl   bold line",cr
        = ".bp   begin page",cr
        = ".cc c control character is c {.}",cr
        = ".ce   centre line",cr
        = ".ch*c chain in next file",cr
        = ".co   comment line",cr
        = ".dmcc define macro to .en",cr
        = ".ds   double space lines",cr
        = ".ef   even page foot title to .en",cr
        = ".eh   even page head title to .en",cr
        = ".en   end of .at, .ix or .ef etc",cr
        = ".ep   begin even page",cr
        = ".ff   form feed the printer, wait if paged mode",cr
        = ".fo   even and odd foot title to .en",cr
        = ".he   even and odd head title to .en",cr
        = ".ic   close indexfile",cr
        = ".ig   ignore input until .en",cr
        = ".in+- indent left margin n places {0}",cr
        = ".io*c open indexfile for output",cr
        = ".ix   send text to indexfile until .en",cr
        = ".ju   justify right margin of lines {on}",cr
        = ".ll+- line length including indent {76}",cr
        = ".ls+- line spacing is n {1}",cr
        = ".lv n leave n blank lines (by .ne n and .sp n)",cr
        = ".ne n needs n output lines, .bp if necessary",cr
        = ".nj   no justification of lines",cr
        = ".nn   no new line after this line",cr
        = ".of   odd page foot title to .en",cr
        = ".oh   odd page head title to .en",cr
        = ".op   begin odd page",cr
        = ".os*c call operating system with this string",cr
        = ".pl+- text area length is n lines {58}",cr
        = ".po+- page offset is n {0}",cr
        = ".rf   right flush this line",cr
        = ".sp n insert n blank lines",cr
        = ".ss   single space lines",cr
        = ".ta   define tabs {8,16,24,...,96}",cr
        = ".tcc  define tab character as c {ctrl I}",cr
        = ".ti+- temporary indent n",cr
        = ".trcc translate {ctrl J is space}",cr
        = ".ul   underline line",cr
        = cr
        = "n represents a decimal number, 0 is used if not present",cr
        = "Spaces are allowed before n. c represents any character",cr
        = "+- allows n, +n or -n: .in+2 sets an indent 2 more than current",cr
        = ".ti+2 is a temporary indent of 2 more than the current indent",cr
        = cr,"Formatting commands which can appear anywhere",cr,cr
        = ".bb   begin bold",cr
        = ".bu   begin underline",cr
        = ".eb   end bold",cr
        = ".eu   end underline",cr
        = ".oc n output CHR$(n) to printer counted as 1 char",cr
        = ".on n output CHR$(n) to printer without being counted",cr
        = ".r0-9 contents of register e.g. .r0",15,cr,cr
        = &EA

prinHL
        LDAIM   prHELP
        STA     string
        LDAIM   :MSB: prHELP
        STA     string + 1
        LDAI    string
prinHK
        JSR     osasci
        INC     string
        BNE     prinHM
        INC     string + 1
prinHM
        LDAI    string
        BPL     prinHK
        JSR     inkeys
        JMP     EDITco

        ; ------------------------------------------------------------ ;

        LNK     EDIT04
                ; the formatter -> EDIT04
PRINTH
        JMP         PRINHL        ; help on print
PRINT
        JSR     MKREFUSE
        LDXIM   &FF
        STX     PWTFLG
        STX     PRTFLG        ; bit 7 printer, bit 6 pay attention to bold/underlining
        STX     LINEOT        ; set needs header flag
        TXS
        JSR     PROMPT
        =       "Screen, Printer, Help ?",&EA
PRINTL
        JSR     GETRESP
        CMPIM   "h"
        BEQ     PRINTH
        CMPIM   "s"
        BEQ     PRINTS
        CMPIM   "p"
        BNE     PRINTL
        CLR     PRTFLG        ; 0 for printer
PRINTS
        JSR     PROMPT
        =       "Continuous, Paged ?",&EA
PRINTM
        JSR     GETRESP
        CMPIM   "c"
        BEQ     PRINTC
        CMPIM   "p"
        BNE     PRINTM
        CLR     PWTFLG        ; 0 for paged output
PRINTC
        JSR     MEMSTATE
        LDA     TSTART
        STA     ADDR
        LDA     TSTART+1
        STA     ADDR+1
        LDAIM   "."
        STA     CTLCHA
        LDXIM   0
CLRREG
        CLRAX   noregs        ; clears noregs, tablst, maclst
        INX
        TXA
        STAAX   trnlst        ; init translation
        BNE     clrreg

        [ cf8key=1
        PHX                     ; set X to correct offset
        SEC
        LDAIM   cr
        SBCZ    clterm
        CLC
        ADCIM   lf
        TAX
        ]

        LDAIM   " "

        [ cf8key=1
        STAAX   trnlst
        PLX
        |
        STA     trnlst + lf + (cr - termin) 
        ]

        LDAIM   &09
        STA     TABCHA
        DEA                   ; to 8
        CLC
DEFTAB
        STAAX   TABLST
        INX
        ADCIM   8        ; carry clear
        CMPIM   100
        BCC     DEFTAB
        LDAIM   2
        STA     BRKACTION
        DEA
        STA     PAGE        ; A=1
        STA     VSPACE        ; single spacing
        STA     LINENO
        CLR     DOINDX        ; no indexing
        CLR     INDEXH        ; index file handle
        CLR     PUNDRL        ; persistent underline off
        CLR     PBOLD        ; persistent bold off
        CLR     INDENT        ; turn off indent
        CLR     FILL        ; enable justification
        CLR     OFFSET        ; no page offset
        CLR     LINFED        ; no overprinting
        LDAIM   58
        STA     LINEDW        ; lines per page
        LDAIM   76
        STA     LEN        ; characters per line
        JSR     VSTRNG
        =       26,12,&EA
        BIT     PRTFLG
        BMI     PATCHA
        LDXIM   0        ; just for jes's code, set and reset printer type
        LDAIM   5
        JSR     OSBYTE
        JSR     OSBYTE
        LDAIM   2
        JSR     OSWRCH
PATCHA
        BIT     PWTFLG
        BMI     CHAINB
        BIT     PRTFLG
        BPL     CHAINB
        LDAIM   14
        JSR     OSWRCH        ; page mode if screen and page wait
CHAINB
        [ cf8key=1
        LDAZ    clterm
        |
        LDAIM   termin
        ]
        STAI    GS

        [ cf8key=1
                                ; Copy initial header and footer texts
                                ; into their respective buffers, changing
                                ; any nulls into the 'clterm' value

                                ; AX can be corrupted since X is loaded
                                ; with an immediate value straight after

        LDXIM   (dhsize - 1)    ; size of header
mhlp        
        LDAAX   defhdr          ; default header
        BNE     nhchan

        LDAZ    clterm
nhchan
        STAAX   dhbuff          ; and into the buffer

        DEX
        BPL     mhlp            ; move header loop

        LDXIM   (dfsize - 1)    ; size of footer
mflp        
        LDAAX   defftr          ; default footer
        BNE     nfchan

        LDAZ    clterm
nfchan
        STAAX   dfbuff          ; and into the buffer

        DEX
        BPL     mflp            ; move footer loop


        LDAIM   :LSB: dhbuff
        STA     pageeh
        STA     pageoh
        LDAIM   :MSB: dhbuff
        STA     pageeh + 1
        STA     pageoh + 1

        LDAIM   :LSB: dfbuff
        STA     pageef
        STA     pageof
        LDAIM   :MSB: dfbuff
        STA     pageef + 1
        STA     pageof + 1
        |
        LDAIM   DEFHDR
        STA     PAGEEH
        STA     PAGEOH
        LDAIM   :MSB: DEFHDR
        STA     PAGEEH+1
        STA     PAGEOH+1
        LDAIM   DEFFTR
        STA     PAGEEF
        STA     PAGEOF
        LDAIM   :MSB: DEFFTR
        STA     PAGEEF+1
        STA     PAGEOF+1        ; initial header and footer info
        ]

        LDXIM   maxMAC
CHAINC
        CLRAX   MACLST-1
        DEX
        BNE     CHAINC
FINE
        CLR     CENTRE        ; turn centre off
        CLR     RFLUSH        ; turn right-flush off
        LDAIM   &FF
        STA     TINDEN        ; no temp indent
        LDA     PUNDRL
        STA     UNDERL
        STA     UNDRRQ        ; underline required?
        LDA     PBOLD
        STA     BOLD
        STA     BOLDRQ        ; bold required?
        BRA     CTLIN
LASLEN
        JSR     ROUTBP
        BIT     PRTFLG        ; print exit
        BPL     DODWN
        JSR     STRIMO
        =       "Print done. ",&EA
        JSR     INKEYS
DODWN
        JSR     VSTRNG
        =       3,15,&EA
        JSR     CLOSEX
        LDX     GS
        LDY     GS+1
        JMP     EDITGS
CTLLMT
        LDYIM   3        ; found built in cmd
        JSR     CTLLDO
CTLLMX
        JSR     SPACEY
        DEY
        CLC
        JSR     YADP
        LDAI    ADDR
        CMP     CTLCHA
        BEQ     CTLIN1
        LDYIM   0
CLCTLI
        JSR     ROUTCO
        SEC
        JSR     YADP
CTLIN
        LDA     ADDR+1
        STA     XEFF        ; set nojust(local) by <>
        CMPIM   /CTLIN
        BCS     CTLIN1
        LDX     ADDR
        CPX     GS
        SBC     GS+1
        BCS     LASLEN
CTLIN1
        LDAI    ADDR
        CMP     CTLCHA
        BNE     LINLYX
        LDXIM   0        ; main control scan
        LDYIM   2
        LDAIY   ADDR
        STA     TEMP+1
        DEY
        LDAIY   ADDR
CTLLLP
        CMPAX   CMDS
        BNE     CTLLLL
        LDYAX   CMDS+1
        CPY     TEMP+1
        BEQ     CTLLMT
CTLLLL
        INX
        INX
        INX
        INX
        CPXIM   NOCMDS
        BNE     CTLLLP
        JSR     MACCHK
        BCC     LINLYX
        LDA     ADDR
        PHA
        LDA     ADDR+1
        PHA
        LDA     CTLCHA
        PHA
        LDAI    BUFF
        STA     CTLCHA
        LDA     BUFF
        STA     ADDR
        LDA     BUFF+1
        STA     ADDR+1
        LDYIM   2
        JSR     CLCTLI
        PLA
        STA     CTLCHA
        PLA
        STA     ADDR+1
        PLA
        STA     ADDR
        LDYIM   3
        BRA     CTLLMX
LINLYX
        LDA     LINEOT
        INA
        BNE     NOHDR
        JSR     DOHDR
NOHDR
        LDA     LEN
        LDY     TINDEN
        INY
        SEC
        BEQ     SBCLEN
        SBC     TINDEN        ; take off temp indent
        BRA     GOTLEN
SBCLEN
        SBC     INDENT        ; so take off indent
GOTLEN
        STA     JUSLEN
        LDYIM   0
        LDXIM   0
        CLR     SPACES        ; initialize spaces encountered
        CLR     LASTTAB        ; initialize start of spacing out
LINLEN
        CPYIM   250
        BCS     LENFNE
        JSR     IGNCTL        ; main char count
        [ cf8key=1
        CMPZ    clterm
        |
        CMPIM   termin
        ]
        BEQ     LENFNE
        CMP     TABCHA
        BNE     NOTTAB
        TXA
        LDXIM   &FF
LOKTAB
        INX
        PHA
        LDAAX   TABLST
        BEQ     NOTAB
        PLA
        CMPAX   TABLST
        BCS     LOKTAB
        PHA
        LDAAX   TABLST
        PLX
        INY
        CMP     JUSLEN
        BCS     NOTAB2
        TAX
        STX     LASTSP
        STX     LASTTAB
        CLR     SPACES
        BRA     NOSP2
NOTAB
        PLX
        LDAIM   " "
NOTTAB
        CMPIM   " "
        BNE     NOSP
        STX     LASTSP
        INC     SPACES
NOSP
        INX
        INY
NOSP2
        CPX     JUSLEN
        BCC     LINLEN
NOTAB2
        JSR     IGNCTL
        CMPIM   " "
        BEQ     LENFNA
        CMP     TABCHA
        BEQ     LENFNA
        [ cf8key=1
        CMPZ    clterm
        |
        CMPIM   termin
        ]
        BEQ     LENFNA
        LDA     SPACES
        BEQ     LENFNA
        LDX     LASTSP
        DEC     SPACES
LENFNA
        DEX
        CLR     XEFF
LENFNE
        INX
        STX     COUNT        ; X, Y free
        BIT     PRTFLG
        BPL     DODW
        JSR     DOSCRE
        BRA     LINCTL
DODW
        LDAIM   &40
        TSB     PRTFLG        ; no underline first time
        LDA     UNDERL
        PHA
        JSR     WRITE
        PLA
        STA     UNDERL
        BIT     UNDRRQ
        BPL     LINCTL
        LDAIM   &40        ; now do underline
        TRB     PRTFLG
        JSR     DOSCRE
        CLR     UNDERL
LINCTL
        BIT     LINFED
        BMI     FINSEN
        LDX     VSPACE
LINSCT
        JSR     LFWRCH        ; ready for next line
        LDA     LINEOT
        INA
        BEQ     FINSEN
        DEX
        BNE     LINSCT
FINSEN
        CLR     LINFED        ; back on, for next line
        JSR     SPACEY
        [ cf8key=1
        CMPZ    clterm
        |
        CMPIM   termin
        ]
        BEQ     NICEDL
        DEY
NICEDL
        CLC
        JSR     YADP
        JMP     FINE
SPACEY
        LDAIY   ADDR
        INY
        BEQ     SPACER
        CMPIM   " "
        BEQ     SPACEY
SPACER
        RTS
IGNCTL
        LDAIY   ADDR        ; count routine
        CMP     CTLCHA
        BNE     NOCTRL
        INY
        LDAIY   ADDR
        CMPIM   "b"
        BEQ     WSCTRB
        CMPIM   "o"
        BEQ     WSCTRO
        CMPIM   "r"
        BEQ     WSCTRR
        CMPIM   "e"
        BNE     NORECG
WSCTRB
        INY
        LDAIY   ADDR
        CMPIM   "b"
        BEQ     WSCTRL
        CMPIM   "u"
        BNE     NORECF
WSCTRL
        INY
        BRA     IGNCTL
WSCTRO
        INY
        LDAIY   ADDR
        CMPIM   "n"
        BEQ     WSCTON
        CMPIM   "c"
        BNE     NORECF
        INX
WSCTON
        PHX
        INY
        JSR     GETNO
        PLX
        BRA     IGNCTL
WSCTRR
        INY
        LDAIY   ADDR
        CMPIM   "0"
        BCC     NORECF
        CMPIM   &3A
        BCS     NORECF
        JSR     DECCON
        BRA     WSCTRL
NORECF
        DEY
NORECG
        DEY
        LDAIY   ADDR
NOCTRL
        RTS
WASCTL
        INY
CHKCTL
        LDAIY   ADDR        ; print routine
        CMP     CTLCHA
        BNE     NOCTRL
        INY
        LDAIY   ADDR
        CMPIM   "b"
        BEQ     WASCTB
        CMPIM   "o"
        BEQ     WASCTO
        CMPIM   "r"
        BEQ     WASCTR
        CMPIM   "e"
        BNE     NORECG
        INY
        LDAIY   ADDR
        CMPIM   "b"
        BEQ     WASCTEB
        CMPIM   "u"
        BNE     NORECF
        CLR     PUNDRL
        CLR     UNDERL
        BRA     WASCTL
WASCTEB
        CLR     PBOLD
        CLR     BOLD
        BRA     WASCTL
WASCTB
        INY
        LDAIY   ADDR
        CMPIM   "b"
        BEQ     WASCTA
        CMPIM   "u"
        BNE     NORECF
        LDAIM   &FF
        STA     UNDERL
        STA     PUNDRL
        STA     UNDRRQ
        BRA     WASCTL
WASCTA
        LDAIM   &FF
        STA     PBOLD
        STA     BOLDRQ
        STA     BOLD
        BRA     WASCTL
WASCTO
        INY
        LDAIY   ADDR
        CMPIM   "n"
        BEQ     WASCON
        CMPIM   "c"
        BNE     NORECF
        INX
WASCON
        PHX
        INY
        JSR     GETNO
        LDAIM   1
        JSR     OSWRCH
        TXA
        JSR     OSWRCH
        PLX
        BRA     CHKCTL
WASCTR
        INY
        LDAIY   ADDR
        CMPIM   "0"
        BCC     NORECF
        CMPIM   &3A
        BCS     NORECF
        JSR     DECCON
        PHX
        LDX     TEMP
OUTCON
        LDAAX   BUFF
        JSR     FMWRCH        ; ul!!
        DEX
        BPL     OUTCON
        PLX
        JMP     WASCTL
CTLLDO
        LDAIM   &FF
        JMIX    CMDS+2
ROUTAF
        JSR     GETNO
        ANDIM   15
        ASLA
        TAX
        LDAAX   NOREGS+1
        ANDIM   15
        STAAX   NOREGS+1
        INY            ; skip some delimter
        PHX
        JSR     GETNO
        PLX
        ASLA
        ASLA
        ASLA
        ASLA
        ORAAX   NOREGS+1
        STAAX   NOREGS+1
        RTS
ROUTAN
        JSR     GETNO
        ANDIM   15
        ASLA
        PHA
        LDAIY   ADDR
        INY            ; skip delimter
        PHA
        JSR     GETNO
        PLA
        CMPIM   "+"
        BEQ     ADDREG
        CMPIM   "-"
        BEQ     SUBREG
        CMPIM   "="
        BEQ     MOVREG
        TXA
        PLX
        STAAX   NOREGS
        LDAAX   NOREGS+1
        ANDIM   &F0
        STAAX   NOREGS+1
        RTS
ADDREG
        CLC
        STX     BUFF
        PLX
        LDAAX   NOREGS
        ADC     BUFF
        STAAX   NOREGS
        LDAAX   NOREGS+1
        ADCIM   0
        STAAX   NOREGS+1
        RTS
SUBREG
        STX     BUFF
        PLX
        LDAAX   NOREGS
        SBC     BUFF
        STAAX   NOREGS
        LDAAX   NOREGS+1
        SBCIM   0
        STAAX   NOREGS+1
        RTS
MOVREG
        TXA
        ANDIM   15
        ASLA
        TAX
        LDAAX   NOREGS+1
        ANDIM   15
        STA     BUFF
        LDAAX   NOREGS
        PLX     
        STAAX   NOREGS
        LDAAX   NOREGS+1
        ANDIM   &F0
        ORA     BUFF
        STAAX   NOREGS+1
        RTS
ROUTBL
        STA     BOLD
        STA     BOLDRQ
        RTS
ROUTCC
        LDAIY   ADDR
        STA     CTLCHA
        INY
        RTS
ROUTCE
        STA     CENTRE
        CLR     RFLUSH        ; can't have both
        RTS
ROUTCH
        LDA     ADDR
        STA     TEMP
        LDA     ADDR+1
        STA     TEMP+1        ; move filename pointer
        LDA     TSTART
        STA     ADDR
        LDA     TSTART+1
        STA     ADDR+1
        LDA     TMAX
        LDX     TMAX+1
        JSR     PASLNM
        JSR     PASGO
        STX     GS
        STY     GS+1
        LDXIM   &FF
        TXS
        JMP     CHAINB
MACCHK
        STA     TEMP        ; check for macro: A=lo, TEMP+1=hi
        LDXIM   -2
MACCHL
        INX
        INX
        CPXIM   MAXMAC
        BCS     MACCHX
        LDAAX   MACLST
        STA     BUFF
        LDAAX   MACLST+1
        STA     BUFF+1
        BEQ     MACCHZ
        PHY
        LDYIM   3
MACSPC
        LDAIY   BUFF
        INY
        CMPIM   " "
        BEQ     MACSPC
        STA     BUFF+2
        LDAIY   BUFF
        PLY
        CMP     TEMP+1
        BNE     MACCHL
        LDA     BUFF+2
        CMP     TEMP
        BNE     MACCHL
        RTS            ; found CS,EQ
MACCHX
        CLC            ; not found, no space CC,NE
        TXA
MACCHZ
        RTS            ; not found, at space CC,EQ
DMEXIT
        DEY
        RTS
ROUTDM
        JSR     SPACEY
        [ cf8key=1
        CMPZ    clterm
        |
        CMPIM   termin
        ]
        BEQ     DMEXIT
        CMP     CTLCHA
        BEQ     DMEXIT
        STA     TEMP+1
        LDAIY   ADDR
        [ cf8key=1
        CMPZ    clterm
        |
        CMPIM   termin
        ]
        BEQ     DMEXIT
        JSR     MACCHK
        BNE     DMEXIT
        LDA     ADDR
        STAAX   MACLST
        LDA     ADDR+1
        STAAX   MACLST+1
        BRA     SKIPEN
ROUTDS
        LDAIM   2
        STA     VSPACE
        RTS
ROUTOF
        LDA     ADDR
        STA     PAGEOF
        LDA     ADDR+1
        STA     PAGEOF+1
        BRA     SKIPEN
ROUTOH
        LDA     ADDR
        STA     PAGEOH
        LDA     ADDR+1
        STA     PAGEOH+1
        BRA     SKIPEN
ROUTFO
        LDA     ADDR
        STA     PAGEOF
        LDA     ADDR+1
        STA     PAGEOF+1
ROUTEF
        LDA     ADDR
        STA     PAGEEF
        LDA     ADDR+1 
        STA     PAGEEF+1
ROUTIG
        BRA     SKIPEN
ROUTHE
        LDA     ADDR
        STA     PAGEOH
        LDA     ADDR+1
        STA     PAGEOH+1
ROUTEH
        LDA     ADDR
        STA     PAGEEH
        LDA     ADDR+1
        STA     PAGEEH+1
SKIPEN
        CLC
        JSR     YADP
SKIPEM
        LDAI    ADDR
        INC     ADDR
        BNE     SKIPEK
        PHA
        INC     ADDR+1
        LDA     ADDR
        CMP     GS
        LDA     ADDR+1
        SBC     GS+1
        BCS     SKIPEX
        PLA
SKIPEK
        CMP     CTLCHA
        BNE     SKIPEM
        LDAI    ADDR
        CMPIM   "e"
        BNE     SKIPEM
        LDYIM   1
        LDAIY   ADDR
        CMPIM   "n"
        BNE     SKIPEM
        INY
SKIPEX
        RTS
ROUTEN
        TSX
        CPXIM   &FD
        BCS     SKIPEX        ; check for possible to do it
        PLA
        PLA
        RTS            ; return a macro level
ROUTEP
        JSR     ROUTBP
        LDA     PAGE
        LSRA
        BCS     ROUTEP
        RTS
ROUTFF
        LDA     PWTFLG
        BMI     NOWAIT
        LDA     PRTFLG
        BPL     PRTWAT
        JSR     INKEY
NOWAIT
        LDAIM   12
        JMP     OSWRCH
PRTWAT
        JSR     NOWAIT
        JMP     INKEY
ROUTIC
        PHY
        JSR     CLOSEX
        PLY
        RTS
ROUTIN
        LDX     INDENT
        JSR     MODNO
        STX     INDENT
        RTS
ROUTIO
        CLC
        JSR     YADP
        JSR     CLOSEX
        LDX     ADDR
        LDY     ADDR+1
        LDAIM   &80
        JSR     OSFIND
        STA     INDEXH
        LDYIM   0
ROUTCO
        [ cf8key=1
        LDAZ    clterm
        |
        LDAIM   termin
        ]
        BRA     SKIPL1
SKIPLP
        INY
        BNE     SKIPL1
        INC     ADDR+1
SKIPL1
        CMPIY   ADDR
        BNE     SKIPLP
        RTS
ROUTIX
        STA     DOINDX
        CLC
        JSR     YADP
        LDA     LINEOT
        PHA
        LDAIM   &FD
        STA     LINEOT
        JSR     CTLIN
        PLA
        STA     LINEOT
        CLR     DOINDX
        RTS
ROUTJU
        CLR     FILL
        RTS
ROUTLL
        LDX     LEN
        JSR     MODNO
        STA     LEN
        RTS
ROUTLS
        LDX     VSPACE
        JSR     MODNO
        STX     VSPACE
        RTS
ROUTLV
        JSR     GETNO
        CMP     LINEOT
        BEQ     OKAYLV
        BCC     OKAYLV
        PHA
        JSR     ROUTBP
        PLA
OKAYLV
        JMP     ALINES

        LNK     EDIT05
        TTL                             > EDIT05
ROUTNE
        JSR     GETNO
        CMP     LINEOT
        BEQ     OKAY
        BCC     OKAY
ROUTBP
        LDA     LINEOT
        BRA     ALINES
ROUTNJ
        STA     FILL
OKAY
        RTS
ROUTNN
        STA     LINFED
        RTS
ROUTOP
        JSR     ROUTBP
        LDA     PAGE
        LSRA
        BCC     ROUTOP
        RTS
ROUTOS
        CLC
        JSR     YADP
        LDX     ADDR
        LDY     ADDR+1
        JSR     OSCLI
        LDYIM   0
        JMP     ROUTCO
ROUTPL
        LDX     LINEDW
        JSR     MODNO
        TXA
        BEQ     WZERO
        STA     LINEDW
        LDX     LINEOT
        INX
        BEQ     WZERO
        STA     LINEOT
WZERO
        RTS
ROUTPO
        LDX     OFFSET
        JSR     MODNO
        STA     OFFSET
        RTS
ROUTRF
        STA     RFLUSH
        CLR     CENTRE        ; can't have both
        RTS
ROUTSP
        JSR     GETNO
ALINES
        TAX
        BEQ     ALINEX
        PHY
        CMPIM   &FF
        BNE     ALINEL
        JSR     DOHDR
        LDX     LINEOT
ALINEL
        LDA     LINEOT
        INA
        BNE     ALINET
        PHX
        JSR     DOHDR
        PLX
ALINET

        LDAIM   cr              ; ++++
        JSR     oswrch
        JSR     lfwrch

        DEX
        BNE     ALINEL
        PLY
ALINEX
        RTS
ROUTSS
        LDAIM   1
        STA     VSPACE
        RTS
ROUTTA
        CLR     LASTTAB
SETTAB
        JSR     GETNO
        LDX     LASTTAB
        STAAX   TABLST
        CLRAX   TABLST+1
        INC     LASTTAB
        JSR     SPACEY
        CMPIM   ","
        BEQ     SETTAB
        DEY
        RTS
ROUTTC
        LDAIY   ADDR
        STA     TABCHA
        INY
        RTS
ROUTTI
        LDX     TINDEN
        CPXIM   &FF
        BNE     ROUSTI
        LDX     INDENT        ; if no temp indent then use INDENT as base
ROUSTI
        JSR     MODNO
        STX     TINDEN
        RTS
ROUTTR
        LDAIY   ADDR
        [ cf8key=1
        CMPZ    clterm
        |
        CMPIM   termin
        ]
        BEQ     SETTRX
        TAX
        INY
        LDAIY   ADDR
        DEY
        [ cf8key=1
        CMPZ    clterm
        |
        CMPIM   termin
        ]
        BEQ     SETTRX
        INY
        INY
        STAAX   TRNLST
SETTRX
        RTS
ROUTUL
        STA     UNDERL
        STA     UNDRRQ
        RTS
YADP
        TYA
        ADC     ADDR
        STA     ADDR
        BCC     ENDADD
        INC     ADDR+1
ENDADD
        RTS
MODNO
        JSR     SPACEY
        CMPIM   "-"
        BEQ     SUBNO
        CMPIM   "+"
        BEQ     ADDNO
        DEY
        LDXIM   0
ADDNO
        PHX
        JSR     GETNO
        PLX
        CLC
        STX     TEMP
        ADC     TEMP
        BCC     ADDNOX
        LDAIM   0
ADDNOX
        TAX
        RTS
SUBNO
        PHX
        JSR     GETNO
        STA     TEMP
        PLA
        SEC
        SBC     TEMP
        BCS     ADDNOX
        LDAIM   0
        TAX
        RTS
GETNO
        LDXIM   0
        JSR     SPACEY
        DEY
NUMLOP
        LDAIY   ADDR
        CMPIM   "0"
        BCC     ENDNO
        CMPIM   &3A
        BCS     ENDNUM        ; not a decimal digit
        ANDIM   &0F
        PHA
        TXA
        ASLA
        ASLA
        STA     TEMP
        TXA
        CLC
        ADC     TEMP
        ASLA
        STA     TEMP
        PLA
        CLC
        ADC     TEMP
        TAX
        INY
        BRA     NUMLOP
ENDNUM
        CLC
ENDNO
        TXA
        RTS
DOHDR
        LDX     PAGEEH
        LDY     PAGEEH+1
        LDA     PAGE
        LSRA
        BCC     DOHDR1
        LDX     PAGEOH
        LDY     PAGEOH+1
DOHDR1
        DEC     LINEOT
        JSR     MACRO
        LDA     LINEDW
        STA     LINEOT
        LDAIM   1
        STA     LINENO
        LDAIM   15
        TRB     LINENO+1; leave format alone!
        RTS
MACRO
        LDA     ADDR
        PHA
        LDA     ADDR+1
        PHA
        LDA     CTLCHA
        PHA
        LDA     LEN
        PHA
        LDA     INDENT
        PHA
        LDA     TINDEN
        PHA
        LDA     BOLD
        PHA
        LDA     PBOLD
        PHA
        LDA     BOLDRQ
        PHA
        LDA     UNDERL
        PHA
        LDA     PUNDRL
        PHA
        LDA     UNDRRQ
        PHA
        LDA     FILL
        PHA
        LDA     VSPACE
        PHA
        LDA     CENTRE
        PHA
        LDA     RFLUSH
        PHA
        LDA     LINFED
        PHA
        CLR     LINFED
        CLR     FILL
        CLR     PBOLD
        CLR     PUNDRL
        CLR     INDENT
        LDAIM   1
        STA     VSPACE
        STX     ADDR
        STY     ADDR+1
        LDAI    ADDR
        STA     CTLCHA
        LDYIM   3
        CLC
        JSR     YADP; skip definition
        JSR     FINE
        PLA
        STA     LINFED
        PLA
        STA     RFLUSH
        PLA
        STA     CENTRE
        PLA
        STA     VSPACE
        PLA
        STA     FILL
        PLA
        STA     UNDRRQ
        PLA
        STA     PUNDRL
        PLA
        STA     UNDERL
        PLA
        STA     BOLDRQ
        PLA
        STA     PBOLD
        PLA
        STA     BOLD
        PLA
        STA     TINDEN
        PLA
        STA     INDENT
        PLA
        STA     LEN
        PLA
        STA     CTLCHA
        PLA
        STA     ADDR+1
        PLA
        STA     ADDR
        RTS
VDUBIT
        TAY
        LDAAY   TRNLST
        STA     SCRATCH
        JSR     XYSCRATCH
        LDAIM   10
        JMP     OSWORD
DOVDU
        BIT     BOLD
        BPL     VDUNBL
; bold character
        PHY
        PHX
        JSR     VDUBIT
        LDXIM   7
VDUBLD
        LDAAX   SCRATCH+1
        LSRA
        ORAAX   SCRATCH+1
        STAAX   SCRATCH+1
        DEX
        BPL     VDUBLD
        BIT     UNDERL
        BPL     VDUDON
; both bold and underline
        BRA     VDUUND
VDUNBL
        BIT     UNDERL
        BPL     WRCHA
; underline character
        PHY
        PHX
        JSR     VDUBIT
VDUUND
        LDA     SCRATCH+8
        LSRA
        RORA
        ORA     SCRATCH+8
        ROLA
        EORIM   &FF
        TSB     SCRATCH+8
VDUDON
        LDAIM   23
        JSR     OSWRCH
        LDAIM   32
        JSR     OSWRCH
        LDXIM   1
VDUPRG
        LDAAX   SCRATCH
        JSR     OSWRCH
        INX
        CPXIM   9
        BNE     VDUPRG
        JSR     VSTRNG
        =       32,23,32,0,0,0,0,0,0,0,0,&EA
        PLX
        PLY
        RTS
ESCAP
        LDAIM   &7E
        JSR     OSBYTE
        JMP     DODWN

fmwrch
        BIT     ESCFLG
        BMI     ESCAP        ; must not go via SENTRY,
                             ; because of marked mode (SWOPCH)
        BIT     DOINDX
        BMI     DOINDE

        [ cf8key=1
        CMPZ    clterm
        |
        CMPIM   termin        ; changed from CMPIM " "; BCC WRCHA
        ]
        BEQ     wrchen

        BIT     PRTFLG
        BMI     DOVDU
        BVS     NOULA

        LDAIM   " "
        BIT     UNDERL
        BPL     NOULA
        LDAIM   "_"
NOULA
        PHA

        LDAIM   &20
        BIT     PRTFLG
        BNE     NOBBLE
        BIT     BOLD
        BMI     NOBBLE

        LDAIM   " "
        JSR     OSWRCH
        PLA
        RTS

NOBBLE
        PLA
WRCHA
        PHY
        TAY
        LDAAY   TRNLST
        PLY
        [ cf8key=1
wrch
        JMI     &020E
wrchen
        LDAIM   cr
        BRA     wrch
        |
        [ termin=cr
wrchen
wrch
        JMI     &20E
        |
wrch
        JMI     &20E
wrchen
        LDAIM   cr
        BRA     wrch
        ]
        ]
DOINDE
        PHY
        TAY
        LDAAY   TRNLST
        LDY     INDEXH
        BEQ     DOINDF
        JSR     OSBPUT
DOINDF
        PLY
        RTS

lfwrch
        BIT     doindX
        BMI     writeX
        LDAIM   lf        ; write a real line feed
        INC     lineno
        BNE     fmwrca
        INC     lineno + 1
fmwrca
        DEC     lineot
        BNE     wrch
        JSR     oswrch
        PHX
        PHY
        LDX     pageef
        LDY     pageef + 1
        LDA     page
        LSRA
        BCC     doftr1
        LDX     pageof
        LDY     pageof + 1
doftr1
        DEC     lineot
        DEC     lineot
        JSR     macro
        LDAIM   &FF
        STA     lineot        ; set needs header
        INC     page
        BNE     HI
        INC     page + 1
HI
        PLY
        PLX
writeX
        RTS
write
        LDAIM   &20
        TSB     prtflg
        LDA     bold
        PHA
        JSR     DOSCRE
        PLA
        STA     BOLD
        BIT     BOLDRQ
        BPL     WRITEX
        LDAIM   &20
        TRB     PRTFLG
        JSR     DOSCRE 
        LDAIM   &20
        TSB     PRTFLG
        RTS
DOSCRE
        LDA     OFFSET
        JSR     SCMVTO
        CLR     DIFF
        LDA     XEFF
        BNE     SCREEA
        SEC
        LDA     JUSLEN
        SBC     COUNT
        STA     DIFF
SCREEA
        LDA     TINDEN
        CMPIM   &FF
        BNE     SCREEB
        LDA     INDENT
SCREEB
        JSR     SCMVTO
        LDA     CENTRE
        BPL     SCREED
        SEC
        LDA     JUSLEN
        INA
        SBC     COUNT
        JSR     MOVE
SCREED
        BIT     RFLUSH
        BPL     SCREEQ
        SEC
        LDA     JUSLEN
        ADCIM   1
        SBC     COUNT
        JSR     SCMVTO
SCREEQ
        LDYIM   0
        LDXIM   0
        LDA     SPACES
        BEQ     SCREEE
        LSRA
        STA     L
        LDAIM   0
        BIT     FILL
        BMI     SENA
        LDA     DIFF
SENA
        LDXIM   1
DODIV
        CMP     SPACES
        BCC     DONDIV
        INX
        SBC     SPACES 
        BCS     DODIV
DONDIV
        STX     Q
        STA     DIFF
        LDXIM   0
SCREEE
        JSR     CHKCTL

        CMPIM   cr              ; ++++
        BEQ     SCREEG

        CMP     TABCHA
        BNE     SCREES
        TXA
        LDXIM   &FF
SCRTAB
        INX
        PHA
        LDAAX   TABLST
        BEQ     SCRNTB
        PLA
        CMPAX   TABLST
        BCS     SCRTAB
        SEC
        SBCAX   TABLST
        EORIM   &FF
        INA
        PHX
        JSR     SCMVTO
        PLX
        LDAAX   TABLST
        TAX
        DEX
        BRA     NOUL
SCRNTB
        PLX
        LDAIM   " "
SCREES
        CMPIM   " "
        BNE     SCREEF
        CPX     LASTTAB
        BCC     SCREEF
        PHX
        LDX     Q
SCRJUS
        DEX
        BEQ     NOMOV
        LDAIM   " "
        JSR     FMWRCH
        BRA     SCRJUS
NOMOV
        PLX
        SEC
        LDA     L
        SBC     DIFF
        STA     L
        BCS     ENDJUS
        ADC     SPACES
        STA     L
        LDAIM   " "
        JSR     FMWRCH
ENDJUS
        LDAIM   " "
SCREEF
        JSR     FMWRCH
NOUL
        INY
        INX
        CPX     COUNT
        BCC     SCREEE

        LDAIM   cr              ; ++++
screeG
        JMP     fmwrch

closeX
        LDY     INDEXH
        BEQ     CLOSEE
        CLR     INDEXH
        LDAIM   &00
        JSR     OSFIND        ; close index file
closee
        RTS

SCMVTO
        ASLA
MOVE
        LSRA
        BEQ     MOVEX
        TAX
        LDAIM   9
        BIT     PRTFLG
        BMI     MLOOP
        LDAIM   " "
MLOOP
        BIT     DOINDX
        BPL     MLOOPA
        LDAIM   " "
        JSR     DOINDE
        BRA     MLOOPB
MLOOPA
        JSR     OSWRCH
MLOOPB
        DEX
        BNE     MLOOP
MOVEX
        RTS
INKEYS
        JSR     STRIMO
        =       "Press SHIFT to continue",&EA
INKEY
        PHX
        PHY
INKEYL
        JSR     ESCTST
        LDXIM   &FF
        LDYIM   &FF
        LDAIM   &81
        JSR     OSBYTE
        CPXIM   &FF
        BNE     INKEYL
        LDAIM   15
        LDXIM   &FF
        JSR     OSBYTE
        PLY
        PLX
        RTS
DECCON
        PHX            ; reg in A to print buff. INX by # chars
        PHY
        ANDIM   15
        ASLA
        TAX
        LDAAX   NOREGS
        STA     TEMP
        LDAAX   NOREGS+1
        TAX
        ANDIM   15
        STA     TEMP+1
        ORA     TEMP
        PHP
        TXA
        LSRA
        LSRA
        LSRA
        LSRA
        PLP
        BNE     NMLTST
        CMPIM   8
        BCC     DECANY
        LDAIM   0
        BRA     DECANY
NMLTST
        CMPIM   8
        BCS     ROMAN
DECANY
        PHA
        LDXIM   4
        LDAIM   "0"
        STA     BUFF+5
        STA     BUFF+6
        STA     BUFF+7
NUMLAP
        LDAIM   "0"
        STAAX   BUFF
        SEC
NUMLP
        LDA     TEMP
        SBCAX   WOPTBL
        TAY
        LDA     TEMP+1
        SBCAX   WOPTBH
        BCC     OUTNUM
        STY     TEMP
        STA     TEMP+1
        INCAX   BUFF
        BNE     NUMLP
OUTNUM
        DEX
        BPL     NUMLAP
        PLA
        STA     TEMP
        LDXIM   8
LZB
        DEX
        CPX     TEMP
        BEQ     LASTZ
        LDAAX   BUFF
        ANDIM   15
        BEQ     LZB
LASTZ
        STX     TEMP
        PLY
        PLA
        SEC
        ADC     TEMP
        TAX
        RTS
ROMAN
        PHA
        CMPIM   10
        BCS     AAA
        LDAIM   &FF
        PHA
        LDXIM   12
ROMANL
        SEC
        LDA     TEMP
        SBCAX   NUMERL
        TAY
        LDA     TEMP+1
        SBCAX   NUMERH
        BCC     ROMANO
        STY     TEMP
        STA     TEMP+1
        TXA
        ASLA
        TAY
        LDAAY   CHARS
        PHA
        LDAAY   CHARS+1
        CMPIM   " "
        BEQ     ROMANL
        PHA
        BRA     ROMANL
ROMANO
        DEX
        BPL     ROMANL
ROMANG
        PLA
        INX
        STAAX   BUFF
        CMPIM   &FF
        BNE     ROMANG
        DEX
CASECH
        PLA
        ANDIM   1
        BEQ     LASTZ
        STX     TEMP
CASELP
        LDAAX   BUFF
        ORAIM   &20
        STAAX   BUFF
        DEX
        BPL     CASELP
        LDX     TEMP
        BRA     LASTZ
AAA
        LDA     TEMP
        BNE     AAADEC
        DEC     TEMP+1
AAADEC
        DEC     TEMP
        LDYIM   0
AAALOP
        LDA     TEMP
        SEC
AAALOQ
        INY
        SBCIM   26
        BCS     AAALOQ
        STA     TEMP
        LDA     TEMP+1
        BEQ     AAAGOT
        DEC     TEMP+1
        BRA     AAALOP
AAAGOT
        LDA     TEMP
        ADCIM   26+"A"
        LDXIM   0
AAALON
        STAAX   BUFF
        INX
        DEY
        BNE     AAALON
        DEX
        BRA     CASECH
NUMERL
        =       1,4,5,9,10,40,50,90,100,400,500,900,1000
NUMERH
        =       /1,/4,/5,/9,/10,/40,/50,/90,/100,/400,/500,/900,/1000
CHARS
        =       "I IVV IXX XLL XCC CDD DMM "
CMDS
        =       "af"
        &       ROUTAF
        =       "an"
        &       ROUTAN
        =       "bl"
        &       ROUTBL
        =       "bp"
        &       ROUTBP
        =       "cc"
        &       ROUTCC
        =       "ce"
        &       ROUTCE
        =       "ch"
        &       ROUTCH
        =       "co"
        &       ROUTCO
        =       "dm"
        &       ROUTDM
        =       "ds"
        &       ROUTDS
        =       "ef"
        &       ROUTEF
        =       "eh"
        &       ROUTEH
        =       "en"
        &       ROUTEN
        =       "ep"
        &       ROUTEP
        =       "ff"
        &       ROUTFF
        =       "fo"
        &       ROUTFO
        =       "he"
        &       ROUTHE
        =       "ic"
        &       ROUTIC
        =       "ig"
        &       ROUTIG
        =       "in"
        &       ROUTIN
        =       "io"
        &       ROUTIO
        =       "ix"
        &       ROUTIX
        =       "ju"
        &       ROUTJU
        =       "ll"
        &       ROUTLL
        =       "ls"
        &       ROUTLS
        =       "lv"
        &       ROUTLV
        =       "ne"
        &       ROUTNE
        =       "nj"
        &       ROUTNJ
        =       "nn"
        &       ROUTNN
        =       "of"
        &       ROUTOF
        =       "oh"
        &       ROUTOH
        =       "op"
        &       ROUTOP
        =       "os"
        &       ROUTOS
        =       "pl"
        &       ROUTPL
        =       "po"
        &       ROUTPO
        =       "rf"
        &       ROUTRF
        =       "sp"
        &       ROUTSP
        =       "ss"
        &       ROUTSS
        =       "ta"
        &       ROUTTA
        =       "tc"
        &       ROUTTC
        =       "ti"
        &       ROUTTI
        =       "tr"
        &       ROUTTR
        =       "ul"
        &       ROUTUL
NOCMDS  *       ( . - CMDS )


        [ cf8key=1
                                ; before printing, defaults are copied
                                ; into private workspace buffer
                                ; and nulls replaced with 'clterm'

defhdr
        =       "$dhtext"

defftr
        =       "$dftext"

        |
DEFHDR
        =       ".he",termin
        =       ".en",termin
DEFFTR
        =       ".fo",termin
        =       ".ce",termin
        =       "Page .r0",termin
        =       ".ff.en",termin
        ]

        LNK         EDIT06
        ; -> EDIT06
        ; Entry - scrnY = desired screen Y coord of current line
        ;         (scrnX,scrnY) = final cursor position
        ; Exit  - screen & scrim updated
        ;         scrnY forced if necessary
        ;         update possibly aborted by incoming char.
        ;         currlength valid
SCRNUD
        JSR     LENGTHCALC
        STA     CURRLENGTH
        TAY
        BEQ     SCRNU0
        CMP     PAGEWIDTH
        BNE     SCRNU1
SCRNU0
        LDA     UPDATE
        CMPIM   CSRTOCR
        BNE     SCRNU1
        INC     UPDATE
        ; Update marks set, if any, to locate them for superimposition.
SCRNU1
        JSR     MARKUPDATE
        JSR     CUROFF
        ; If screen messier than would be fixed up by intended update,
        ; then do something about it.
        LDA     SCRNPY
        CMP     UPDATE
        BCC     SCUDCO
        STA     UPDATEREQD
SCUDCO
        CLR     SCRNPY
        LDA     UPDATEREQD
        CMPIM   THELOT
        BNE     SCUDTI
        JSR     CLEARSCREEN
        ; If fullscreen update is required, then find internal start
        ; of screen, possibly forcing scrnY, and update top half.
SCUDTI
        LDA     UPDATEREQD
        BEQ     SCUDEX ; 'none'
        CMPIM   FULLSCREEN
        BCC     SCUDBO
SCUDFS
        LDA     SCRNY
        JSR     TPGSBK
        STA     SCRNY
        DEA
        STA     MAXSCRUPY
        BMI     SCUDBO
        LDAIM   0
        LDX     TP
        LDY     TP+1
        JSR     UPDTLN
        BCS     SCUDAB
SCUDBO
        ; Output bottom half of screen, branching for hardscrolls.
        LDX     UPDATEREQD
        CPXIM   HARDUP
        BEQ     SCUDHU
        CPXIM   HARDDOWN
        BEQ     SCUDHD
        LDY     PAGELENGTH
        STY     MAXSCRUPY
        ; Set up A,X,Y for bottom half update.
        LDA     SCRNY
        LDX     GE
        LDY     GE+1
        JSR     UPDTLN
        BCC     SCUDEX
SCUDAB
        ; Record the fact that screen isn't totally up-to-date.
        LDAIM   CSRONW
        CMP     UPDATEREQD
        BCS     SCUDAS
        LDAIM   FULLSCREEN
SCUDAS
        STA     SCRNPY
SCUDEX
        CLR     UPDATEREQD
        RTS
SCUDHU
        ; Push against bottom to scroll up.
        JSR     CSR0STATUSY
        LDAIM   DOWN
        JSR     OSWRCH
        ; Scroll scrim up.
        LDXIM   &FF
SCHULP
        INX
        LDAAX   SCRIM+1
        STAAX   SCRIM
        CPX     PAGELENGTH
        BNE     SCHULP
        CLRAX   SCRIM+1
        JSR     STATUS
        LDA     PAGELENGTH
        BRA     SCHUDC
SCUDHD
        ; Rewrite status, then push against top to scroll down.
        JSR     VSTRNG
        = HOME,UP,&EA
        ; Scroll scrim down.
        LDY     PAGELENGTH
SCHDLP
        LDAAY   SCRIM
        STAAY   SCRIM+1
        DEY
        BPL     SCHDLP
        CLR     SCRIM
        JSR     STATUS
        LDAIM   0
SCHUDC
        STA     MAXSCRUPY
        LDX     SCP
        LDY     SCP+1
        BNE     UPDTLN
        TAY
WIPELINE
        ; Clear a line, assigning new scrim value. Y is line to clear.
        PHY
        JSR     CSR0Y
        LDAIM   " "
        JSR     OSWRCH
        LDAIM   0
        PLY
WIPETAIL
        ; Assign scrim entry for a line, clearing old tail of line.
        ; Entry - A = New scrim entry
        ;        Y = screen Y-coord
        ; Exit  - Tail of line wiped.
        ;        scrim updated
        ;        A,Y preserved.
        STA     ATEMP
        LDAAY   SCRIM
        CMP     ATEMP
        BCC     WTSCRM
        BEQ     WTSCRM
        LDAIM   28
        JSR     OSWRCH
        LDA     ATEMP
        INA
        JSR     OSWRCH
        PHX
        LDA     TUTMODE
        ANDIM   7
        TAX
        TYA
        CLC
        ADCAX   VERTTB
        PLX
        PHA
        JSR     OSWRCH
        LDAAY   SCRIM
        JSR     OSWRCH
        PLA
        JSR     OSWRCH
        LDAIM   12
        JSR     OSWRCH
        PHY
        JSR     DECWIN
        PLY
WTSCRM
        LDA     ATEMP
        STAAY   SCRIM
        RTS
UPDTLN
        ; Entry - A = Y-coord of 1st line to be output.
        ;        XY --> 1st line to be output.
        ;        maxscrupY = last line to be updated.
        ; Exit  - line output, with rest of line wiped if necessary
        ;        scrim,scrupY assigned (top bit set if no <CR> on line)
        ;        If was last line (temp = hymem after update), then
        ;        loop clearing lines until scrupY = pagelength.
        ;        CC - Normal termination
        ;        CS - Update aborted due to incoming character.
        STA     SCRUPY
        STX     TP
        STY     TP+1
        LDXIM   0
        LDA     UPDATEREQD
        CMPIM   CSRTOCR
        BEQ     UPDLC0
        ; If updatereqd = csronwards then start screen update from char under cursor.
        CMPIM   CSRONWARDS
        BNE     UPDLCO
UPDLC0
        LDX     SCRNX
        CPX     CURRLENGTH
        BCC     UPDLCO
        LDX     CURRLENGTH
UPDLCO
        PHX
        LDY     SCRUPY
        JSR     CSRXY
        PLY
        DEY
UPDLLP
        INY
UPDLL2
        LDAIY   TP
        [ cf8key=1
        CMPZ    clterm
        |
        CMPIM   termin
        ]
        BEQ     UPDLCR
        JSR     PASWRCH
        CPY     PAGEWIDTH
        BNE     UPDLLP
        BRA     UPDLEN
UPDLCR
        JSR     PASWCR
UPDLEN
        STY     COUNT ; Max csrX on this line.
        ; Superimpose marks, if any, onto this line.
        LDY     MARKX
MOUTLP
        DEY
        BMI     MOUTEX
        STY     INDEX
        ; If 0 <= (Mark - TP) <= count, then this is csrX within line.
        SEC
        LDAAY   UMATLO
        SBC     TP
        TAX
        LDAAY   UMATHI
        SBC     TP+1
        BCC     MOUTLP
        BNE     MOUTLP
        CPX     COUNT
        BEQ     MOUTMO
        BCS     MOUTLP
MOUTMO
        LDY     SCRUPY
        JSR     CSRXY
        LDA     INDEX
        CLC
        ADCIM   "1"
        JSR     INVWRCH
        LDX     COUNT
        INX
        JSR     CSRXY
        LDY     INDEX
        BRA     MOUTLP
MOUTEX
        ; Update TP, and see if have hit end of file.
        LDA     COUNT
        LDY     SCRUPY
        JSR     WIPETAIL
        JSR     TPPAP1 ; A = count
        BCS     UPDLNE
        LDA     UPDATE
        CMPIM   CSRTOCR
        BEQ     UPDLFI
        LDY     SCRUPY
        CPY     MAXSCRUPY
        BCS     UPDLFI
        ; Test if any characters/commands are being queued in buffer.
        LDA     UPDATER
        CMPIM   THELOT
        BEQ     QUEUEX
        LDA     NEXTREADFLAG
        BNE     QUEUCS
        LDAIM   &81
        LDXIM   0
        LDYIM   0
        JSR     OSBYTE
        CPYIM   &FF
        BEQ     QUEUEX
        JSR     ESCTST
        INC     NEXTREADFLAG
        STX     NXTCHR
QUEUCS
        SEC
        RTS
QUEUEX
        INC     SCRUPY
        LDXIM   0
        JMP     UPDLCO
        ; Overwrite sentinal EOT TERMIN with EOT character.
UPDLNE
        LDX     COUNT
        LDY     SCRUPY
        JSR     CSRXY
        LDAIM   "*"
        JSR     INVWRCH
        BRA     UDLET1
UDLEOT
        LDY     SCRUPY
        JSR     WIPELINE
UDLET1
        INC     SCRUPY
        CPY     PAGELENGTH
        BCC     UDLEOT
UPDLFI
        CLC
        RTS
PASWRCH
        ; Entry - A = char to output.
        ; Exit  - Y preserved
        ;        ctrl ch     --> inverted or chr(255) depending on mode
        ;        delete      --> inv ?
        ;        other chars --> echoed
        CMPIM   SPACE
        BCC     PASWNC
        CMPIM   DELETE
        BNE     PASWOS
        LDAIM   "?"
        BRA     INVWRCH
PASWOS
        JMP     OSWRCH
PASWCR
        LDAIM   &20
        BIT     TUTMODE
        BEQ     PASWOS
        [ lfarro=1
        LDAIM   nlfarr
        |
        LDAIM   "$"       ; **
        ]
        BRA     INVWRCH   ; **
PASWNC
        ORAIM   &40 ; Output control character as inverted keytop.
INVWRCH
        ; Output character in inverse video (blob in mode 7).
        ; Entry - A = character
        ;        mode IN [0..7]
        PHA
        LDA     TUTMODE
        ANDIM   7
        CMPIM   7
        BNE     INVWN7
        PLA
        LDAIM   255
        BRA     PASWOS
INVWN7
        JSR     STARTINV
        PLA
        JSR     OSWRCH
STOPINV
        LDAIM   17
        JSR     OSWRCH
        LDAIM   128
        JSR     OSWRCH
        LDAIM   17
        JSR     OSWRCH
        LDAIM   7
        JMP     OSWRCH
STARTINV
        JSR     VSTRNG
        = 17,135,17,0,&EA
        RTS
CURLT
        JSR     STARTTEST
        BCC     CLCONT
        LDA     SCRNX
        BEQ     CSREXI
CLCONT
        DEC     SCRNX
        BPL     CSREXI
        LDA     PAGEWIDTH
        STA     SCRNX
        ; C set if at start of text
CURUP
        JSR     STARTTEST
        BCS     CSREXI
        LDAIM   1
        JSR     MVLNBK
        LDA     TSM
        CMP     SCRNY
        BCS     CUUPSC
CUUPNS
        DEC     SCRNY
        BPL     CSREXI
CUUPSC
        LDA     SCRNY ; In Top Scroll Margin. If more than Top Scroll Margin Width
        JSR     TPGSBK ; from top of file, then assign Scroll Pointer, else move cursor up.
        CMP     SCRNY
        CLC
        BNE     CUUPNS
        LDA     TP
        STA     SCP
        LDA     TP+1
        STA     SCP+1
        LDAIM   HARDDOWN
        STA     UPDATEREQD
        RTS
WORDRT
        LDY     SCRNX
        LDAIY   GE
        [ cf8key=1
        CMPZ    clterm
        |
        CMPIM   termin
        ]
        BNE     EASYRT
        JSR     CURDWN
        BCS     WORDXX
        JSR     SCRNUD
CURST
        CLR     SCRNX
        BRA     CSREXI
WORDXX
        PLA
        PLA
        RTS
EASYRT
        JSR     CURRT
        JSR     SCRNUD
        BRA     CSREXI
WORDLT
        LDA     SCRNX
        BNE     CURLT
        JSR     CURUP
        BCS     WORDXX
        JSR     SCRNUD
CUREND
        LDA     CURRLENGTH
        STA     SCRNX
CSREXI
        CLR     UPDATEREQD
        RTS
CURRT
        LDA     SCRNX
        CMP     PAGEWIDTH
        BEQ     CURRCO
        INC     SCRNX
        BRA     CSREXI
CURRCO
        JSR     ENDTEST
        BCS     CSREXI
        CLR     SCRNX
        ; C set if at text end
CURDWN
        JSR     ENDTEST
        BCS     CSREXI
        LDAIM   1
        JSR     MVLNFD
        LDA     SCRNY
        CMP     BSM
        BCS     CUDOSC
        INC     SCRNY
        BRA     CSREXI
CUDOSC
        ; In Bottom Scroll Margin.
        ; If more than (Pagelength-Bottom Scroll Margin)
        ; from bottom of file, then assign Scroll Pointer, else set SCP+1 to
        ; 0 to indicate wipeline required.

        STZ     SCP+1         ; Initialize SCP+1 to 0 implies
                              ; blank line required for scroll.
        SEC
        LDA     PAGELENGTH
        SBC     BSM
        JSR     TPGEFD
        LDA     COUNT
        BNE     CUDOWS
        LDA     TP
        STA     SCP
        LDA     TP+1
        STA     SCP+1
CUDOWS
        LDAIM   HARDUP
        STA     UPDATE
        CLC
WORDRX
        RTS
WORDRIGHT
        LDA     CURRLE
        CMP     SCRNX
        BCS     WORDR3
        STA     SCRNX
        BRA     WORDR3
WORDR1
        JSR     WORDRT
WORDR3
        LDY     SCRNX
        LDAIY   GE
        JSR     WORDC
        BCC     WORDR1
WORDR2
        LDY     SCRNX
        LDAIY   GE
        JSR     WORDC
        BCC     WORDRX
        JSR     WORDRT
        BRA     WORDR2
WORDL1
        JSR     WORDLT
        LDY     SCRNX
        LDAIY   GE
        JSR     WORDC
        BCC     WORDL1
WORDL2
        LDY     SCRNX
        LDAIY   GE
        JSR     WORDC
        BCC     CURRT
        JSR     WORDLT
        BRA     WORDL2
WORDLEFT
        LDA     CURRLE
        CMP     SCRNX
        BCS     WORDL1
        STA     SCRNX
WORDCX
        SEC
        RTS
        ; C set if not wordc
WORDC
        CMPIM   "0"
        BCC     WORDCX
        CMPIM   "9" + 1
        BCC     WORDCR
        ANDIM   &DF
        CMPIM   "A"
        BCC     WORDCX
        CMPIM   "Z" + 1
WORDCR
        RTS

EDITi2
        LDX     TSTART
        LDY     TSTART + 1

EDITtd
        STX     GS
        STY     GS + 1
        LDA     TMAX
        STA     GE
        LDA     TMAX + 1
        STA     GE + 1
EDITxx
        STZ     CURSED
        STZ     NEXTRE
        STZ     MARKX
        [ cf8key=1
        LDAZ    clterm
        |
        LDAIM   termin
        ]
        STAI    PAJE
        STAI    TMAX
STFILE
        LDX     tstart
        LDY     tstart + 1
        JSR     GPBKXY
        CLR     SCRNX   ; CLR scrnY will be forced by scrnud
STFILX
        RTS

CUREDF
        LDA     BSM     ; Try to glue bottom of file to BSM.
        STA     SCRNY
        LDX     TMAX
        LDY     TMAX + 1
        JSR     GPFDXY
        JMP     NORMAX

IOtogg                  ; Insert/Over toggle
        LDA     tutMOD
        EORIM   bit4    ; the correct bit
        JSR     doMODE
        JMP     CstatU

CHKSCR
        LDAIM   &87     ; select mode if tutmode and screen mode NOT the same
        JSR     OSBYTE
        LDA     TUTMOD
        ANDIM   &07
        TAX
        LDAAX   MODETB
        STY     STRING
        EOR     STRING
        ANDIM   &07
        BEQ     STFILX  ; same ok
SELSCR
        LDAIM   22      ; select the right screen mode
        JSR     OSWRCH
        LDA     TUTMODE
        ANDIM   &07
        TAY
        LDAAY   MODETB
        ORAIM   &80     ; select any shadow around
        JMP     OSWRCH


EDITMD                  ; Set up 'EDIT'
        JSR     selscr
EDITMA
        LDAIM   &83
        JSR     osbyte          ; Read PAJE
        STX     paje
        STY     paje + 1
        LDAIM   &84
        JSR     osbyte          ; Read HIMEM
        STX     hymem
        STY     hymem + 1

        ; Set up edit (text) buffer delimiting pointers.
        CLC
        LDA     paje
        ADCIM   1
        STA     tstart
        LDA     paje + 1
        ADCIM   0
        STA     tstart + 1
        LDA     hymem
        SBCIM   0               ; CC gives -1
        STA     tmax
        LDA     hymem + 1
        SBCIM   0
        STA     tmax + 1
        JSR     intpag          ; initialise pagelength and width
        LDA     pagele
        SEC
        SBCIM   4
        STA     BSM
        LDAIM   4
        STA     TSM
        RTS

tsmcsr
        ; Set Top Scroll Margin to current cursor line.
        LDA     scrnY
        STA     TSM
        BRA     noupda

bsmcsr
        ; Set Bottom Scroll Margin to current cursor line.
        LDA     scrnY
        STA     BSM
        BRA     noupda

scmclr
        ; Clear Scroll Margins.
        CLR     TSM
        LDA     pagele
        STA     BSM

noupda
        STZ     update
        RTS

newtex                          ; Clear text
        JSR     prompt
        [ stamp=1
        =       "Clear text [Y (dated),shf-f9 (exec)]",&EA
        LDAIM   &81
        TAX
        LDYIM   &03
        JSR     osbyte
        JSR     esctst
        TYA
        BEQ     doneW1
newtn
        JMP     status
doneW1
        PHX
        JSR     nstamp
        PLA
        ORAIM   &20
        CMPIM   "y"
        BNE     doneW2
        JSR     mstamp
doneW2
        JSR     memsta
        JMP     editin
        |
        =       "Text will be cleared if a key is hit",&EA
        LDAIM   &81
        TAX
        LDYIM   3
        JSR     osbyte
        JSR     esctst
        CPYIM   0
        BEQ     donew
newtn
        JMP     status
donew
        JSR     memsta
        JMP     editin
        ]

LOADfi
        ; Doesn't zap buffer until new file is correctly loaded.

        [ curtyp=1
        JSR     lsf
        ]

        LDA     MODFLG
        BEQ     LOADF2
        JSR     PROMPT
        =       "Overwrite text [Y,f2]:",&EA
        JSR     OSRDCH
        CMPIM   128+2
        BEQ     LOADF2
        ANDIM   &DF
        CMPIM   "Y"
        BNE     NEWTN
LOADF2
        JSR     PROMPT
        =       "Type filename to load:",&EA
        JSR     READNS
        LDYIM   0
        JSR     TLOAD
        JMP     EDITGT

SAVEfi                          ; Save file
        [ curtyp=1
        JSR     lsf
        ]

        JSR     dfinit
        CMPIM   &01          
        BEQ     marksa

        JSR     promtF
        =       "to save:",&07,&EA

        JSR     readns
        JSR     dfblok
        LDYIM   &00
        JSR     tsave

        STZ     modflg

        LDX     texp
        LDY     texp + 1
        JSR     gpfdXY
        JMP     normax

marksa
        JSR     promtF
        =       "for MARK TO CURSOR save:",&07,&EA
        JSR     readns
        JSR     dfblok
        LDYIM   &00
        LDAI    temp
        [ cf8key=1
        CMPZ    clterm
        |
        CMPIM   termin
        ]
        BEQ     msbad
        CMPIM   &8B
        BEQ     msbad
        LDA     temp
        STA     scratc
        LDA     temp + 1
        STA     scratc + 1
        JSR     inSAVE
        LDX     texp
        LDY     texp + 1
        JSR     gpfdXY
        JMP     normax
msbad
        BRK
        =       &01,"Bad use of stored name",null

insrtF
        [ curtyp=1
        JSR     lsf
        ]

        JSR     mkrefu
        JSR     finepo
        JSR     promtF
        =       "to insert:",&EA
        JSR     readns
        LDA     GS              
        STA     addr
        LDA     GS + 1
        STA     addr + 1
        LDA     GE
        LDX     GE + 1
        LDYIM   0
        JSR     PASLOAD
        STX     GS
        STY     GS+1
        JSR     MODIFY
        LDX     ADDR ; Move to start of inserted file.
        LDY     ADDR+1
        JSR     GPBKXY
        JMP     NORMAL

edSTAR                          ; OSCLI processing
        LDAIM   &01
        STA     BRKact
        JSR     initus
        JSR     prompt
        =       "Command line",&EA

        [ curtyp = 1
        JSR     lsf             ; slow line flash
        ]
starcn
        JSR     osnewl
starlo
        LDAIM   "*"
        JSR     oswrch
        LDAIM   &00
        LDYIM   :MSB: starCB
        LDXIM   starCB
        JSR     osword
        BCS     stares
        LDA     comman
        CMPIM   cr
        BEQ     starex
        LDXIM   :LSB: comman
        LDYIM   :MSB: comman
        JSR     oscli
        BRA     starlo
starCB
        &       comman
        =       238
        =       " "
        =       &FF
stares
        LDAIM   &7E
        JSR     osbyte
starex
        JSR     vstrng
        =       0,0,0,0,0,0,0,0,0,0,4,3,15,13,26,&EA
        JSR     chkscr
        JSR     inited
        JMP     editco

allowC
        ; Allow cursor editing & softkey use. Terminated by CR.
        LDAIM   &01
        STA     cursED

        [ PHIL=0
        JSR     INITUS
        ]

        JMP     CstatU

BADMODE
        BRK
        =       1,"Only 0,1,3,4,6,7,D or K"     ; followed by 0

verttb
        =       0,0,7,0,0,14,0                  ; plus another 0 in modetb

MODEtb
        =       0,1,0,3,4,0,6,7                 ; and the screen modes

GETMOD
        JSR     PROMPT
        =       "New Mode:",&EA
        JSR     OSRDCH
        JSR     OSWRCH
        JSR     ESCTST
        CMPIM   "7" + 1
        BCS     SETKEY
        SBCIM   "0" - 1
        BCC     BADMOD
        CMPIM   2
        BEQ     BADMOD
        CMPIM   5
        BEQ     BADMOD
        BRA     SETMOD
SETKEY
        ANDIM   &DF
        CMPIM   "D"
        BEQ     SETTUT
        CMPIM   "K"
        BNE     BADMODE
        LDAIM   &02
        BRA     SETMODE
SETTUT
        LDAIM   &05
SETMODE
        PHA

        [ origin=&8000
        TAY
        LDAAY   modetb
        PHA
        JSR     memsta
        LDAIM   &82
        JSR     osbyte
        INX
        BNE     inTUBE
        INY
        BNE     inTUBE
        PLA
        PHA
        ORAIM   &80
        TAX
        LDAIM   &85
        JSR     osbyte
        CPX     GS
        TYA
        SBC     GS + 1
        BCC     MODEsp
inTUBE
        PLX
        ]

        LDAIM   &7
        TRB     tutmod
        PLA
        ORA     tutmod
        JSR     domode

        [ origin=&8000
        JSR     EDITMD
        |
        JSR     CHKSCR
        LDAIM   26
        JSR     OSWRCH
        JSR     EDITMA
        LDA     BSM
        STA     SCRNY
        CLR     SCRNX
        JMP     EDITCO
        ]

OLDTEXT
        LDA     OLDSTA + 3
        CMP     PAJE + 1
        BCC     NOOLD
        CMP     HYMEM + 1
        BCS     NOOLD
        CMP     OLDSTA + 1
        BCC     NOOLD
        LDA     OLDSTA + 1
        CMP     PAJE + 1
        BCC     NOOLD
        LDA     OLDSTA
        STA     ARGP
        LDA     OLDSTA + 1
        STA     ARGP + 1
        SEC
        LDA     OLDSTA + 2
        SBC     ARGP
        TAX
        LDA     OLDSTA + 3
        SBC     ARGP + 1
        TAY           
        BCC     NOOLD
        LDA     TSTART
        STA     VARP
        LDA     TSTART + 1
        STA     VARP + 1
        PHY
        PHX
        JSR     COPYBK
        PLA
        CLC
        ADC     TSTART
        TAX
        PLA
        ADC     TSTART + 1
        TAY
        CLR     OLDSTA + 3
        JMP     EDITGS

MODESP
        JSR     STFILE
        BRK
        =       2,"No room"

NOOLD
        BRK
        =       2,"No old text found",0

GETNUM
        STZ     INDEX
        STZ     LINE
        STZ     LINE + 1
EDLIRE
        LDY     INDEX
        LDAIY   TEMP
        CMPIM   CR
        BEQ     EDLIMV
        CMPIM   "9" + 1
        BCS     EDLIBN
        SBCIM   "0" - 1
        BCC     EDLIBN
        STA     ATEMP
        LDAIM   10 ; line = line * 10 + atemp
        LDXIM   0
        LDYIM   0
        CLC

EDLI10
        PHA
        TXA
        ADC     LINE
        TAX
        TYA
        ADC     LINE + 1
        TAY
        BCS     EDLIBN
        PLA
        DEA
        BNE     EDLI10
        TXA
        ADC     ATEMP
        STA     LINE
        BCC     EDLNHI
        INY
        BEQ     EDLIBN
EDLNHI
        STY     LINE + 1
        INC     INDEX
        BNE     EDLIRE
EDLIMV
        RTS

EDITLI
        LDAIM   1               ; Move to specified line number.
        STA     LINE
        CLR     LINE + 1
        LDA     TSTART
        STA     STRING
        LDA     TSTART + 1
        STA     STRING + 1
LOKLINE
        LDAI    STRING
        [ cf8key=1
        CMPZ    clterm
        |
        CMPIM   termin
        ]
        BNE     LOKLI2
        INC     LINE
        BNE     LOKLI2
        INC     LINE + 1
LOKLI2
        INC     STRING
        BNE     LOKLI3
        INC     STRING + 1
LOKLI3
        LDA     STRING
        CMP     GS
        LDA     STRING + 1
        SBC     GS+1
        BCC     LOKLINE
        JSR     PROMPT
        =       "At line ",&EA
        JSR     WRITLINE
        JSR     VSTRNG
        =       ", new line:",&EA
        JSR     STOPINV
        JSR     readns
        BNE     LOLI4

EDLIBN
        BRK
        =       1,"Bad number"

EDLIBL
        BRK
        =       2,"Line not found",0

LOLI4
        JSR     GETNUM
        ; Number is held in line. Numbers start at 1 ...
        SEC
        LDA     LINE
        SBCIM   1
        STA     LINE
        LDA     LINE + 1
        SBCIM   0
        STA     LINE+1
        BCC     EDLIBN
        JSR     STFILE
        LDA     GE
        STA     TP
        LDA     GE + 1
        STA     TP + 1

EDLIFW
        LDA     LINE
        ORA     LINE + 1
        BEQ     EDLIGO

EDLICR
        LDAIM   1
        JSR     TPFWDA
        BCS     EDLIBL
        LDA     ATEMP
        [ cf8key=1
        CMPZ    clterm
        |
        CMPIM   termin
        ]
        BNE     EDLICR
        LDA     LINE
        BNE     EDLNHD
        DEC     LINE+1

EDLNHD
        DEC     LINE
        BRA     EDLIFW

EDLIGO
        ; Move to BSM.
        LDA     TSM
        BNE     EDLIGJ
        LDAIM   4

EDLIGJ
        STA     SCRNY
        JMP     GPFDTP

        [ cf8key=1
        ; ------------------------------------------------------------ ;

cf8swt                          ; CR/LF switch
        LDAZ    clterm
        CMPIM   cr
        BEQ     setLF
        LDAIM   cr
        STAZ    clterm
        BRA     cont99
setLF
        LDAIM   lf
        STAZ    clterm
cont99
        STZ     cursed
        STZ     nextre
        STZ     markX

        LDAZ    clterm
        STAI    paje
        STAI    tmax

        STZ     SCRNX           ; CLR scrnY will be forced by scrnud

        JSR     stFILE          ; move the cursor to the top
                                ; of the text
        JMP     EDITco          ; and continue editing

        ; ------------------------------------------------------------ ;
        ]

        LNK     EDIT07
        ; Find replace section -> EDIT07
        ; Use recursive descent to check syntax ; 
        ; F_str ::= find_part CR
        ; find_part ::= { ['*'] (simple_item | set_item) }
        ; set_item  ::= ['~'] ( '[' simple_item { simple_item } ']' )
        ; simple_item ::= ['~'] ( character_specifier | subrange_specifier |
        ;                         wildcard_specifier )
        ; character_specifier ::= ['|!'] (non_meta | '\' non_eoln
        ;                                               | '$' | '|' non_eoln)
        ; subrange_specifier ::= character_specifier '-' character_specifier
        ; wildcard_specifier ::= '.' | '@' | '#'
        ; R_str ::= find_part '/' repl_part CR
        ; repl_part ::= { ( field_item | character_specifier ) }
        ; field_item ::= '&' | '%' digit
        ; non_meta ::= NOT < ~ * [ ] , \ $ | - . @ # & % / eoln >
        ; Subranges should translate into subrange_sym <ch> <ch>
        ; Set constructs should translate into :
        ; set_sym <nextX> ... <next item>
        ;                     ^
        ;                     nextX
        ; Matching of subranges & sets should be internal to compmobj. nextX is
        ; used to step on to the next find item after successfully matching one
        ; of the set alternatives (set match fails when hit tes_sym).

FRSTRINIT
        ; Exit  -  Y = 0
        CLR     OUTINDEX
        CLR     REPLFLAG
        CLR     FIELDINDEX
        CLR     MMX
        CLR     OFFSET
        CLR     SENSFLAG
MININIT
        CLR     INPINDEX
        BRA     NEXTCH
GENNEXTCH
        JSR     GENBYTE
NEXTCH
        ; A,atemp = linbuf,inpindex +  + . Exit - Z = (A = CR)
        LDY     INPINDEX
        LDAAY   LINBUF
        STA     ATEMP
        INC     INPINDEX
        CMPIM   CR
        RTS
        ; Translate & store FR string into stracc.
        ; Exit  - Find part translated into stracc, replindex holds start of
        ;        replace string (when translated) in stracc. 
        ;      - fieldindex = No. of fields (max 10) in find string.
        ;      - For each field n (n> 0) -
        ;        'mulf' (* ..)  -  fieldmmxtab,n = (mmx :OR: &80)
        ;        'conf' (?)     -  fieldmmxtab,n = mmx of previous mulf
        ;                          fieldofftab,n = offset from above
        ;      - replindex = stracc index of replace part (when translated)
        ;      - replflag = 0  No replace part supplied
        ;                   1  Replace part supplied
FINDTRANS
        JSR     FRSTRINIT
FINDPART
        CLR     MULFFLAG ; Don't yet know whether next object is either a
        CLR     METAFLAG ; star or wildcard field.
        CLR     BUTTFLAG ; or ^
        LDA     ATEMP
        CMPIM   CR
        BEQ     FIPAEXIT
        CMPIM   "/"
        BEQ     FIPAEND
        CMPIM   "^"
        BNE     FIPANHA
        INC     BUTTFLAG
        BRA     FIPAMUL
FIPANHA
        CMPIM   "*"
        BNE     FIPANMUL
FIPAMUL
        INC     MULFFLAG
        LDXIM   MULTSYM
        JSR     GENNEXTCH
FIPANMUL
        CMPIM   "~"
        BNE     FIPANNOT
        LDXIM   NOTSYM
        JSR     GENNEXTCH
FIPANNOT
        CMPIM   "["
        BNE     FIPASIMP
        INC     SENSFLAG
        LDXIM   SETSYM
        JSR     GENBYTE
        JSR     GENBYTE ; Leave room for nextX, and remember position.
        STY     NEXTX
        JSR     NEXTCH
FIPASELT
        JSR     SIMPLEITEM
        LDA     ATEMP
        CMPIM   "]"
        BNE     FIPASELT
        DEC     SENSFLAG
        LDA     OUTINDEX ; End of set construct. Store nextX
        LDY     NEXTX
        STAAY   STRACC
        JSR     NEXTCH
        BRA     FIFIFEEL
FIPAEND
        INC     REPLFLAG
FIPAEXIT
        JSR     TERMGEN
        JSR     NEXTCH
        LDA     OUTINDEX
        STA     REPLINDEX
        LDA     REPLFLAG
        BNE     REPLPART
        RTS
FIPASIMP
        JSR     SIMPLEITEM
FIFIFEEL
        ; If last object was a field of some sort, then store the
        ; relevant info, and update indeces as required.
        LDA     BUTTFLAG
        BEQ     FIFICO
        LDXIM   BUTTSYM
        JSR     GENBYTE
FIFICO
        LDA     METAFLAG
        BEQ     FIFIOFFI ; No meta-chars => not a field
        LDX     FIELDINDEX
        CPXIM   10
        BCS     FINDPART ; That's enough fields.
        INC     FIELDINDEX
        LDA     OFFSET
        STAAX   FIELDOFFTAB
        LDA     MULFFLAG
        BNE     FIFIMULF
        LDA     MMX
        STAAX   FIELDMMXTAB
FIFIOFFI
        INC     OFFSET
FINDPCH
        JMP     FINDPART
FIFIMULF
        INC     MMX
        LDA     MMX
        CMPIM   5
        BCS     FRSTERR
        ORAIM   &80
        STAAX   FIELDMMXTAB
        CLR     OFFSET
        BRA     FINDPCH
FRSTERR
        BRK
        = 1,"Too many find multiples",0
REPANXCH
        JSR     NEXTCH
REPAGENB
        JSR     GENBYTE
REPLPART
        LDAIM   &FF
        STA     SENSFLAG
        LDA     ATEMP ; Translate replace part of FR string.
        CMPIM   CR
        BEQ     TERMGEN
        LDXIM   FOUNDSYM
        CMPIM   "&"
        BEQ     REPANXCH
        CMPIM   "\"
        BNE     REPANS
        JSR     NEXTCH
        TAX
        BRA     REPANXCH
REPANS
        LDXIM   FIELDSYM
        CMPIM   "%"
        BNE     RPNFLD
        JSR     GENBYTE
        JSR     NEXTCH
        SEC
        SBCIM   "0"
        BCC     FIELDERR
        CMP     FIELDINDEX
        BCS     FIELDERR
        TAX
        BPL     REPANXCH
RPNFLD
        JSR     CHARACTERSPECIFIER
        STX     SIMPCHAR
        TXA
        BPL     REPAGENBYTE
        LDXIM   ESCSYM
        JSR     GENBYTE
        LDX     SIMPCHAR
        BRA     REPAGENB
FIELDERR
        BRK
        = 1,"Bad replace field number",0
TERMGEN
        LDXIM   TERMSYM ; Generate termsym.
GENBYTE
        ; stracc,outindex +  +  = X
        ; Exit - metaflag set (incremented) if meta-character (field) generated.
        LDY     OUTINDEX
        LDA     SENSFLAG
        BNE     GENBSNS
        CPXIM   "A"
        BCC     GENBSNS
        CPXIM   "z" + 1
        BCS     GENBSNS
        CPXIM   "Z" + 1
        BCC     GENBNSN
        CPXIM   "a"
        BCC     GENBSNS
GENBNSN
        TXA
        ORAIM   &20
        TAX
        LDAIM   NSENSYM
        STAAY   STRACC
        INY
        INC     OUTINDEX
        BEQ     GENBERR
GENBSNS
        TXA
        STAAY   STRACC
        BPL     GENBNMET
        INC     METAFLAG
GENBNMET
        INC     OUTINDEX
        BEQ     GENBERR
        RTS
GENBERR
        BRK
        = 1,"Syntax incorrect",0
SIMPLEITEM
        LDA     ATEMP
        CMPIM   "~"
        BNE     SIITNNOT
        LDXIM   NOTSYM
        JSR     GENBYTE
        JSR     NEXTCH
        BNE     SIITNNOT
        BRK
        = 1,"Error with ~",0
SIITNNOT
        CMPIM   "\"
        BNE     SIITNS
        INC     SENSFLAG
        JSR     NEXTCH
        BNE     SIITNM
        BRK
        = 1,"Error with \",0
SIITNM
        TAX
        JSR     NEXTCH
        JSR     GENBYTE
        DEC     SENSFLAG
        RTS
SIITNS
        LDXIM   WILDSYM
        CMPIM   "."
        BEQ     SIITWILD
        LDXIM   ALPHASYM
        CMPIM   "@"
        BEQ     SIITWILD
        LDXIM   DIGSYM
        CMPIM   "#"
        BNE     SIITNWIL
SIITWILD
        JSR     NEXTCH ; Preserves X
        JMP     GENBYTE
SIITNWIL
        JSR     CHARACTERSPECIFIER
        STX     SIMPCHAR
        LDA     ATEMP
        CMPIM   "-"
        BNE     SIITCGEN
        INC     SENSFLAG
        LDXIM   SUBRSYM
        JSR     GENBYTE
        JSR     NEXTCH
        LDX     SIMPCHAR
        JSR     GENBYTE
        JSR     CHARACTERSPECIFIER
        JSR     GENBYTE
        DEC     SENSFLAG
        RTS
SIITCGEN
        ; Output character as escsym ch if >= &80
        TXA
        BPL     GENBYJ
        LDXIM   ESCSYM
        JSR     GENBYTE
        LDX     SIMPCHAR
GENBYJ
        JMP     GENBYTE
CHARACTERSPECIFIER
        ; Exit  -  X = Character
        CLR     COUNT ; Add 128 count
        LDA     ATEMP
        BMI     CHSPBY
        CMPIM   "|"
        BNE     CHRSCO
        JSR     NEXTCH
        BEQ     CHRSER
        CMPIM   "!"
        BNE     CHRSSO
        INC     COUNT
        JSR     NEXTCH
CHRSCO
        CMPIM   "$"
        BEQ     CHSPCR
        CMPIM   "|"
        BNE     CHSPBY
        JSR     NEXTCH
        BEQ     CHRSER
CHRSSO
        CMPIM   "?"
        BNE     NOTQUE
        LDAIM   &7F
        BRA     CHSPBY
NOTQUE
        BCC     CHSPBY
        ANDIM   &DF
        SBCIM   "@"
        BRA     CHSPBY
CHSPCR
        [ cf8key=1
        LDAZ    clterm
        |
        LDAIM   termin
        ]
CHSPBY
        PHA
        JSR     NEXTCH
        PLA
        LDY     COUNT
        BEQ     CHRSEX
        ORAIM   &80
CHRSEX
        TAX
        RTS
CHRSER
        BRK
        = 1,"Error with |",0
        ; Search subroutine , called by find & replace routines.
        ; 'Multiple occurence' matching is achieved by a general backtracking
        ; algorithm, using a stack of records, one for each '*-match', holding
        ; the following data -
        ;  + - + 
        ; |0| linbufX of multsym concerned
        ;  + - + 
        ; |1| lo }
        ;  + - +     } Text address of match start
        ; |2| hi }
        ;  + - + 
        ; |3| lo }
        ;  + - +     } Number of object accepted by match
        ; |4| hi }
        ;  + - + 
        ; The first record is reserved (by chknrep) for match-start pointer.
        ; Entry - MS   --> Search start position
        ;        EOSP    --> Top bit set charcater at required end of search.
        ;        Search-string in stracc, terminated by termch.
        ; Exit  - CC  Occurence of findstring found.
        ;            MS  --> match
        ;            ME  --> matchend  +  1
        ;        CS  Search failed.
SEARCH
        LDYIM   0
        CLR     SSTCKX
        ; Start of attempted match. See if have reached TEXP - either old
        ; cursor position, or end of search block.
        LDA     MS
        STA     ME
        CMP     TEXP
        LDA     MS + 1
        STA     ME + 1
        SBC     TEXP + 1
        BCC     SRCHCT
        LDA     TEXPFLAG
        BNE     SRCHFL
        JSR     MOVETOFOUNDPOSITION
        LDA     GS
        STA     STRING
        LDA     GS + 1
        STA     STRING + 1
        INC     TEXPFLAG
        LDA     ENDP
        STA     TEXP
        LDA     ENDP + 1
        STA     TEXP + 1
        LDYIM   0
        BRA     SRCHCT
SRCHFL
        SEC
        RTS
SRCHL1
        INC     ME
        BNE     SRCHCT
        INC     ME + 1
SRCHCT
        ; Expects Y (= linbufX), ME --> next char valid.
        JSR     ESCTST
        LDAAY   STRACC
        CMPIM   TERMSYM
        BEQ     SRCHFD
        CMPIM   MULTSYM
        BEQ     SRCHMI
        JSR     COMPMOBJ
        BEQ     SRCHL1
SRCHIN
        ; Increment current multiple match, or advance MS if there
        ; isn't one. Search fails when MS reaches EOT.
        LDX     SSTCKX
        BNE     SRCHFM
        INC     MS
        BNE     SEARCH
        INC     MS + 1
        BRA     SEARCH
SRCHFD
        LDA     MS ; Match found. Set sstk[0] = MS, (ME-MS).
        STA     SSTTLOSTK
        LDA     MS + 1
        STA     SSTTHISTK
        SEC
        LDA     ME
        SBC     MS
        STA     SCNTLOSTK
        LDA     ME + 1
        SBC     MS + 1
        STA     SCNTHISTK
        CLC
        RTS
SRCHFM
        ; Let most recent multiple match accept another occurence of
        ; find-object, if one exists.
        STY     BUTTFLAG
        CLC
        LDAAX   SSTTLOSTK
        ADCAX   SCNTLOSTK
        STA     ME
        LDAAX   SSTTHISTK
        ADCAX   SCNTHISTK
        STA     ME + 1
        LDAAX   SINDEXSTK
        TAY
        JSR     COMPMOBJ
        BNE     SRCHBK
        LDX     SSTCKX
        INCAX   SCNTLOSTK
        BNE     SRCHL1
        INCAX   SCNTHISTK
        BRA     SRCHL1
SRCHBK
        ; Can't increment this multiple-match, so backtrack to the previous one.
        ; unless its hit a ^ with count>0 in which case it continues
        LDX     BUTTFLAG
        LDAAX   STRACC-1
        CMPIM   BUTTSYM
        BNE     SRCHBC
        INY
        LDX     SSTCKX
        LDAAX   SCNTLOSTK
        ORAAX   SCNTHISTK
        BNE     SRCHCT
SRCHBC
        DEC     SSTCKX
        BRA     SRCHIN
SRCHMI
        ; 'Push' a new record onto backtrack-stack. Initially accept
        ; 0 characters into multiple match.
        INC     SSTCKX
        LDX     SSTCKX
        INY
        TYA
        STAAX   SINDEXSTK
        LDA     ME
        STAAX   SSTTLOSTK
        LDA     ME + 1
        STAAX   SSTTHISTK
        CLRAX   SCNTLOSTK
        CLRAX   SCNTHISTK
        JSR     COMPMOBJ ; Cheap way to advance Y to next find-object.
        JMP     SRCHCT
COMOFS
        PLP
COMOFL
        ; Have hit end of search text, so fail match.
        LDAIM   1
        RTS
COMPMOBJ
        ; Compares stracc,Y & (ME).
        ; Exit  - Y indexes next ssobj
        ;        EQ  Objects match.
        ;        NE  Objects don't match.
        ; Match fails if have hit end of seach text.
        LDA     ME
        CMP     ENDP
        BNE     COMOCO
        LDA     ME + 1
        CMP     ENDP + 1
        BEQ     COMOFL
COMOCO
        ; Check for & store absence/presence of notsym, then branch depending
        ; whether trying to match constant, wildcard, subrange or set item.
        LDAAY   STRACC
        CMPIM   NOTSYM
        PHP
        BNE     COMONN
        INY
COMONN
        INY
        LDAAY   STRACC-1
        BMI     COMOME
        CMPI    ME
        BNE     CMOPRN
        BRA     CMOPRY
COMOME
        CMPIM   WILDSYM
        BEQ     CMOPRY
        CMPIM   NSENSYM
        BEQ     CMONSEN
        CMPIM   ALPHASYM
        BEQ     COMOAL
        CMPIM   BUTTSYM
        BEQ     COMOFS
        CMPIM   DIGSYM
        BEQ     CMODG1
        CMPIM   SUBRSYM
        BEQ     CMOSUB
        CMPIM   SETSYM
        BEQ     CMOSET
        ; 
        ; Must be escsym ch
        ; 
        INY
        LDAAY   STRACC-1
        CMPI    ME
        BNE     CMOPRN
        BEQ     CMOPRY
CMOSUB
        INY
        INY
        LDAI    ME
        CMPAY   STRACC-2
        BCC     CMOPRN
        CMPAY   STRACC-1
        BCC     CMOPRY
        BNE     CMOPRN
        BRA     CMOPRY
CMONSEN
        INY
        LDAI    ME
        ORAIM   &20
        CMPAY   STRACC-1
        BNE     CMOPRN
        BRA     CMOPRY
COMOAL
        LDAI    ME
        CMPIM   "_"
        BEQ     CMOPRY
        CMPIM   "A"
        BCC     CMODG2
        CMPIM   "z" + 1
        BCS     CMOPRN
        CMPIM   "Z" + 1
        BCC     CMOPRY
        CMPIM   "a"
        BCC     CMOPRN
        BRA     CMOPRY
CMODG1
        LDAI    ME
CMODG2
        CMPIM   "0"
        BCC     CMOPRN
        CMPIM   "9" + 1
        BCS     CMOPRN
        BRA     CMOPRY
CMOSET
        LDAAY   STRACC
        STA     NEXTX
        INY
CMOSEL
        JSR     COMPMOBJ
        BEQ     CMOSEY
        CPY     NEXTX
        BNE     CMOSEL
CMOPRN
        PLP
        RTS
CMOSEY
        LDY     NEXTX
CMOPRY
        PLA
        ANDIM   2
        RTS
CHKNREP
        ; Check for size, then replace found string with replace string.
        ; Entry - Match just found; s*****stk[0] set up for %0 ('&')
        ;        replindex = start index of replace part in stracc
        ; Exit  - Found string replaced.
        JSR     MOVETOFOUNDPOSITION
        LDAIM   1
        STA     MODFLG
        LDA     ME
        STA     GE
        LDA     ME + 1
        STA     GE + 1
        LDA     REPLINDEX
        STA     LNBUFX
CHNRLP
        LDA     GS
        CMP     MS
        LDA     GS + 1
        SBC     MS + 1
        BCS     CHNRRERR
        LDY     LNBUFX
        INC     LNBUFX
        LDAAY   STRACC
        BPL     CHNRSI
        CMPIM   TERMSYM
        BEQ     CHNREX
        CMPIM   FIELDSYM
        BEQ     CHNRFI
        CMPIM   FOUNDSYM
        BEQ     CHNRFO
        ; Must be escsym ch
        INC     LNBUFX
        LDAAY   STRACC + 1
        BRA     CHNRSI
CHNRFO
        ; '&' has been frigged to look like MM 0
        LDYIM   0
        BRA     CHNRAM
CHNRFI
        INC     LNBUFX
        LDAAY   STRACC + 1
        TAX
        LDAAX   FIELDMMXTAB
        BMI     CHNRMF
        TAY
        BEQ     CHNRMS
        CLC       
        LDAAY   SSTTLOSTK
        ADCAY   SCNTLOSTK
        STA     TEMP
        LDAAY   SSTTHISTK
        ADCAY   SCNTHISTK
        BNE     CHNRTM
CHNRMS
        LDA     MS
        STA     TEMP
        LDA     MS + 1
CHNRTM
        STA     TEMP + 1
        LDYAX   FIELDOFFTAB
        LDAIY   TEMP
CHNRSI
        STAI    GS
        INC     GS
        BNE     CHNRLP
        INC     GS + 1
        BRA     CHNRLP
CHNRRERR
        BRK
        = 2,"No room",0
CHNRMF
        ANDIM   &7F
        TAY
CHNRAM
        LDAAY   SSTTLOSTK
        STA     ARGP
        LDAAY   SSTTHISTK
        STA     ARGP + 1
        LDA     GS
        STA     VARP
        LDA     GS + 1
        STA     VARP + 1
        CLC
        LDAAY   SCNTLOSTK
        TAX
        ADC     GS
        STA     GS
        LDAAY   SCNTHISTK
        TAY
        ADC     GS + 1
        STA     GS + 1
        JSR     COPYBK
        JMP     CHNRLP
CHNREX
        RTS

        LNK     EDIT08
        ; -> EDIT08
        ; Find-Replace & Global-Replace should have their own seperate command
        ; keys, with the first delimeter 'built in' (i.e. not required), and CR
        ; sufficing as terminator -
        ; FR/ ....... [/.......] <CR>
        ; GR/ .......  /.......  <CR>
GETRESP
        ;Exit - A holds char - forced to lower case - read from keyboard
        JSR     EDRDCH
        ORAIM   &20
        RTS
MOVETOFOUNDPOSN
        LDX     MS
        LDY     MS+1
        JMP     GPFDXY
GLOBREPLACE
        JSR     DFINIT
        JSR     PROMPT
        =       "Global replace:",&EA
        [ extgf=1
        JSR     readlf
        |
        JSR     readLS
        ]
        JSR     READINIT
        BNE     NEWGR
        CMP     GRBUFF
        BEQ     NOBUFF
OLDGR
        LDAAY   GRBUFF
        STAIY   TEMP
        INY
        BPL     OLDGR
        LDYIM   0
NEWGR
        LDAIY   TEMP
        STAAY   GRBUFF
        INY
        CPYIM   100
        BNE     NEWGR
        JSR     FINDTRANS
        JSR     DFBLOK
        CLR     LINE
        CLR     LINE+1
        CLR     TEXPFLAG
GREPLP
        LDX     GE
        LDY     GE+1
GREPNX
        STX     MS
        STY     MS+1
        JSR     SEARCH
        BCS     GREPEX
        INC     LINE
        BNE     GREPNH
        INC     LINE+1
GREPNH
        LDA     REPLFLAG
        BNE     GREPRP
        LDX     ME
        LDY     ME+1
        BRA     GREPNX
GREPRP
        JSR     CHKNREP
        BRA     GREPLP
GREPEX
        ;Move cursor (as near as possible) to the place it started at, then
        ;output match count.
        LDX     STRING
        LDY     STRING+1
        JSR     GPBKXY
        JSR     NORMALIZE
        JSR     SCRNUD
        LDXIM   PRMPTL
        JSR     PRMPTX
        =       " ",&EA
        JSR     WRITLINE
        JSR     PRMPTX
        =       " found",&EA
        RTS
NOBUFF
        BRK
        =       1,"No previous string",0
FINDREPLACE
        JSR     PROMPT
        =       "Find and replace:",&EA
        [ extgf=1
        JSR     readlf
        |
        JSR     READLS
        ]
        JSR     READINIT
        BNE     NEWFR
        CMP     FRBUFF
        BEQ     NOBUFF
OLDFR
        LDAAY   FRBUFF
        STAIY   TEMP
        INY
        BPL     OLDFR
        LDYIM   0
NEWFR
        LDAIY   TEMP
        STAAY   FRBUFF
        INY
        CPYIM   100
        BNE     NEWFR
        JSR     FINDTRANS
        JSR     TEMPSX
        JSR     FINEPOSITIONGAP
        LDA     LINE
        STA     SCRNX
        ;Set up search termination pointer & flag.
        LDA     TMAX
        STA     TEXP
        LDA     TMAX+1
        STA     TEXP+1
        STA     TEXPFLAG
IMRPRL
        LDX     GE
        LDY     GE+1
IMRPCL
        STX     MS
        STY     MS+1
        JSR     SEARCH
        BCS     IMRPNF
        JSR     MOVETOFOUNDPSN
        JSR     NORMAX; get position of X back
        LDA     BSM ;Move to BSM
        STA     SCRNY
        JSR     SCRNUD
        LDAIM   FULLSCREEN
        STA     UPDATEREQD
        JSR     PROMPT
        =       "R(eplace), C(ontinue) or ESCAPE",&EA

        JSR     CSRSCREENXY
        JSR     CURON
IMRPPR
        JSR     GETRESP
        CMPIM   "c"
        BNE     IMRPNC
        LDX     ME
        LDY     ME+1
        BRA     IMRPCL
IMRPNC
        CMPIM   "r"
        BNE     IMRPPR
        JSR     MKREFUSE
        ;Either use supplied replace part, or prompt for one.
        LDA     REPLFLAG
        BNE     IMRPRP
        JSR     PROMPT
        =       "Replace by:",&EA

        [ extgf=1
        JSR     readlf
        |
        JSR     READLS
        ]
        JSR     READINIT
        JSR     MININIT
        LDA     REPLINDEX
        STA     OUTINDEX
        JSR     REPLPART
IMRPRP
        JSR     CHKNREP
        JMP     IMRPRL  
IMRPNF
        JSR     NORMALIZE
        LDAIM   THELOT
        STA     UPDATER
        JSR     SCRNUD
        JSR     STATUS
        LDXIM   PRMPTL
        JSR     PRMPTX
        =       " Not found",&EA
        RTS

WRITLINE
        JSR     STARTINV
        LDXIM   4 ;Outputs LINE in decimal, suppressing leading zeros.
        STX     STRING
WOPRNEXT
        CLR     STRING+1
WOPRLOOP
        SEC
        LDA     LINE
        SBCAX   WOPTBL
        TAY
        LDA     LINE+1
        SBCAX   WOPTBH
        BCC     WOPRDIGI
        STY     LINE
        STA     LINE+1
        INC     STRING+1
        BRA     WOPRLOOP
WOPRDIGI
        LDA     STRING+1
        BNE     WOPRGEN
        DEC     STRING
        BPL     WOPRCONT
WOPRGEN
        ORAIM   "0"
        JSR     OSWRCH
        CLR     STRING
WOPRCONT
        DEX
        BPL     WOPRNEXT
        RTS
WOPTBL
        =       :LSB: 1
        =       :LSB: 10
        =       :LSB: 100
        =       :LSB: 1000
        =       :LSB: 10000
WOPTBH
        =       :MSB: 1
        =       :MSB: 10
        =       :MSB: 100
        =       :MSB: 1000
        =       :MSB: 10000

        ;Marks are stored in SMATlo,hi (Set Mark Address Table), where the
        ;addresses refer to positions in the 2nd half of text; when updated
        ;(any number of times), this address is translated into a value in
        ;UMATlo,hi (Used Mark Address Table), where the addresses refer to
        ;positions in the text as it is currently partitioned.
MARKUP
        ;Update marks for current position of gap.
        ;Exit  -  marksbeforecsr =       No. of marks before GE.
        JSR     MKUDCH
MKUDKN
        CLR     MARKSB
        LDX     MARKX
MKUDLP
        DEX
        BMI     MKUDEX
        LDYZX   SMATLO
        STYZX   UMATLO
        CPY     GE
        LDAZX   SMATHI
        STAZX   UMATHI
        SBC     GE+1
        BCS     MKUDLP
        INC     MARKSB
        SEC
        TYA
        SBC     CHUNKS
        STAZX   UMATLO
        LDAZX   UMATHI
        SBC     CHUNKS + 1
        STAZX   UMATHI
        BCS     MKUDLP
MKUDEX
        RTS
MKUDCH
        ;chunksize :=       size of gap to correct for.
        SEC
        LDA     GE
        SBC     GS
        STA     CHUNKS
        LDA     GE+1
        SBC     GS+1
        STA     CHUNKS + 1
        RTS
CLRMARKS
        ;Clear, count update & order mark(s), ready for use.
        ;Entry - Mark1 (markstk) and/or Mark2 (markstk+2) possibly set.
        ;Exit  - Gap finepositioned
        ;        Marks ordered so that Mark1 <=       Mark2
        ;        Marks cleared & status updated
        ;        A[Z] =       nummarks =       No. of marks
        ;Save (GE - GS) for updating marks, then finepositiongap
        JSR     FINEPO
        JSR     MKUDCH
        JSR     MKUDKN

        ;If Mark2 (exists) < Mark1, then swap.
        LDX     MARKX
        CPXIM   2
        BNE     CLRMCO
        LDA     UMATLO+1
        CMP     UMATLO
        LDA     UMATHI+1
        SBC     UMATHI
        BCS     CLRMCO
        LDA     UMATLO
        LDY     UMATLO+1
        STA     UMATLO+1
        STY     UMATLO
        LDA     UMATHI
        LDY     UMATHI+1
        STA     UMATHI+1
        STY     UMATHI
CLRMCO
        LDA     MARKX
        STA     NUMMAR
        CLR     MARKX
        JSR     STATUS
        LDA     NUMMAR
MKRFEX
        RTS
MKREFUSE
        ;Complain if any marks are set.
        LDA     MARKX
        BEQ     MKRFEX
        BRK
        =       1,"Mark(s) set",0
NMBLOK
        ;Normalizes a marked block of text, to ease use.
        ;Entry  -  Marks updated (gap fine positioned). TEXP =       GE
        ;Exit   -  'Bad marking' error if 2 marks were set.
        ;       -  EQ - 0 marks were set.
        ;          NE - 1 mark was set (csr-mark or mark-csr):
        ;               Gap moved to start of block,
        ;               XY =       end of block.
        LDA     GE
        STA     TEXP
        LDA     GE+1
        STA     TEXP+1
        LDA     NUMMAR
        BEQ     NBLKEX
        CMPIM   1
        BNE     BADMAR
        LDX     UMATLO
        LDY     UMATHI
        DEC     MARKSB
        BNE     NBLKEX
        JSR     GPBKXY
        LDX     TEXP
        LDY     TEXP+1
NBLKEX
        RTS
DFINIT
        ;Seperated this way to avoid grotty command-line escape.
        JSR     TEMPSX
        JSR     CLRMAR
        CMPIM   2
        BEQ     BADMAR
        PHA
        LDA     LINE
        STA     SCRNX
        PLA
        RTS
DFBLOK
        ;Normalize a 'marked' block (defaulting to whole) of text.
        ;Exit  -  TEXP =       Old cursor position (in end of text).
        ;         ENDP =       End of 'marked' block.
        JSR     NMBLOK
        BNE     DBLKEP
        JSR     STFILE
        LDX     TMAX
        LDY     TMAX + 1
DBLKEP
        STX     ENDP
        STY     ENDP + 1
        RTS
MVBLOK
        ;Ensure good marking (m-m-c or c-m-m) for a block 'move-op'
        ;Exit  -  CC: marks are after cursor
        ;         CS: marks are before cursor
        JSR     CLRMAR
        CMPIM   2
        BNE     BADMAR
        ;if 2nd mark on cursor then shift it to GS
        LDA     UMATLO + 1
        CMP     GE
        BNE     MVBLOJ
        LDA     UMATHI + 1
        CMP     GE+1
        BNE     MVBLOJ
        LDA     GS
        STA     UMATLO + 1
        LDA     GS+1
        STA     UMATHI + 1
        INC     MARKSB
MVBLOJ
        LDA     MARKSB
        DEA     ;cmp#1
        BEQ     BADMAR
        RTS
BADMARKING
        BRK
        =       1,"Bad marking",0
SETMARK
        JSR     FINEPO
        LDX     MARKX
        CPXIM   2
        BEQ     BADMAR
        ;Save mark address.
        LDA     GE   
        STAZX   SMATLO
        LDA     GE+1
        STAZX   SMATHI
        JSR     NORMAL
        INC     MARKX
        JMP     STATUS
CLEARMARKS
        JSR     CLRMAR
        JMP     NORMAL
MKDEL
        JSR     CLRMAR
        JSR     NMBLOK
        BEQ     BADMAR ;Stop delete from defaulting to 'NEW' !
        STX     GE
        STY     GE+1
        JSR     MODIFY
NORMAX
        JSR     NORMAL
        LDA     STRING
        STA     SCRNX
        RTS
MKCPY
        ;Marked copy. Either m-m-c or c-m-m.
        JSR     MVBLOK
        ;XY =       (Mark2-Mark1) - size of block to be copied.
        SEC
        LDA     UMATLO + 1
        SBC     UMATLO
        TAX
        LDA     UMATHI + 1
        SBC     UMATHI
        TAY
        LDA     MARKSB
        BEQ     MKCPYO
        STX     STRING
        STY     STRING + 1
        SEC
        LDA     SMATLO
        SBC     STRING
        STA     SMATLO
        LDA     SMATHI
        SBC     STRING + 1
        STA     SMATHI
        LDA     SMATLO + 1
        SBC     STRING
        STA     SMATLO + 1
        LDA     SMATHI + 1
        SBC     STRING + 1
        STA     SMATHI + 1
MKCPYO
        JSR     CHECKR
        ;Copy the block, then normalize text.
        LDA     UMATLO
        STA     ARGP
        LDA     UMATHI
        STA     ARGP + 1
        STX     GE
        STX     VARP
        STY     GE + 1
        STY     VARP + 1
        JSR     CPFD2
        LDXIM   1
        STX     MODFLG
        INX
        STX     MARKX
        JSR     STATUS
        JMP     NORMAL
MKMVE
        ;If marks are before cursor, then do a bit of tweaking to
        ;change it into case where thay are after it.
        JSR     MVBLOK
        ;Initialize pointers for iterative swap block routine.
        LDX     UMATLO
        LDY     UMATHI
        LDA     MARKSB
        BEQ     MVBEFC
        STX     ARGP
        STY     ARGP + 1
        LDA     UMATLO + 1
        STA     VARP
        LDA     UMATHI + 1
        STA     VARP + 1
        LDX     GS
        LDY     GS + 1
        BRA     MVSTP3
MVBEFC
        STX     VARP
        STY     VARP + 1
        LDA     GE
        STA     ARGP
        LDA     GE + 1
        STA     ARGP + 1
        LDX     UMATLO + 1
        LDY     UMATHI + 1
MVSTP3
        STX     ENDP
        STY     ENDP + 1
MVLOOP
        SEC
        LDA     VARP
        SBC     ARGP
        STA     SIZE
        LDA     VARP + 1
        SBC     ARGP + 1
        STA     SIZE + 1
        LDA     ENDP
        SBC     VARP
        TAX
        LDA     ENDP + 1
        SBC     VARP + 1
        TAY
        CPX     SIZE
        SBC     SIZE + 1
        BCS     MV2GE
        STX     SIZE
        STY     SIZE + 1
MV2GE
        LDA     SIZE
        ORA     SIZE + 1
        BEQ     MVNORM
        BCS     MV2GE1
        LDX     VARP
        LDY     VARP + 1
        JSR     MVSWAP
        CLC
        TYA
        ADC     TEMP
        STA     ARGP
        LDAIM   null
        ADC     TEMP + 1
        STA     ARGP + 1
        BCC     MVLOOP
MV2GE1
        SEC
        LDA     ENDP
        SBC     SIZE
        STA     ENDP
        TAX
        LDA     ENDP + 1
        SBC     SIZE + 1
        STA     ENDP + 1
        TAY
        JSR     MVSWAP
        BRA     MVLOOP
MVNORM
        LDAIM   FULLSC
        STA     UPDATE
        JSR     NORMAL
        JMP     MODIFY
MVSWAPBYTES
        ;Swap size bytes ARGP <-> XY
        LDA     ARGP
        STA     TEMP
        LDA     ARGP + 1
        STA     TEMP + 1
        STX     ADDR
        STY     ADDR + 1
        INC     SIZE + 1 ;To allow dec to zero below.
        LDYIM   null
MVNINC
        CPY     SIZE
        BNE     MVSWLP
        DEC     SIZE + 1
        BEQ     TEMPSE
MVSWLP
        LDAIY   TEMP
        TAX
        LDAIY   ADDR
        STAIY   TEMP
        TXA
        STAIY   ADDR
        INY
        BNE     MVNINC
        INC     TEMP + 1
        INC     ADDR + 1
        BRA     MVNINC
TEMPSX
        LDA     SCRNX
        STA     LINE
        LDA     CURRLEN
        CMP     SCRNX
        BCS     TEMPSE
        STA     SCRNX
TEMPSE
        RTS

        [ curtyp=1
                                ; different types of display cursor
                                ;
                                ; block/slow flash INSERT
                                ; line/slow flash  OVER
                                ; block/fast flash FOUND search items (f4)
                                ; line/fast flash  CURSOR EDITING
                                ; line/slow flash  COMMAND LINE entry
                                ;

                                ; blink         ; blink
                                ; fblink        ; Fast blink
                                ; fcstrt        ; Full cursor start line
                                ; ncstrt        ; Normal start line

                                ; VDU 23,0,10,value,0,0,0,0,0,0

curupd                          ; cursor update
                                ; 'tutmod' holds editing state
        PHA
                                ; bit4 = Insert/Over mode
        LDAZ    tutmod
        ANDIM   bit4
        BEQ     ovrcur
           
        LDAZ    cursed
        BEQ     slowc1

        JSR     bff
        BRA     curex
slowc1
        JSR     bsf
        BRA     curex
ovrcur
        LDAZ    cursed
        BEQ     slowc2

        JSR     lff
        BRA     curex
slowc2
        JSR     lsf
curex
        PLA
        RTS

bsf                             ; block slow flash
        PHA
        PHX

        LDAIM   fcstrt
        BRA     sf
bff                             ; block fast flash
        PHA
        PHX

        LDAIM   fcstrt
        BRA     ff
lff                             ; line slow flash
        PHA
        PHX

        LDAIM   ncstrt
        BRA     ff
lsf                             ; line fast flash
        PHA
        PHX

        LDAIM   ncstrt
sf
        ORAIM   fblink          ; add the fast flash
ff                              ; slow flash
        ORAIM   blink           ; and add the blink
                                ; at this point A holds value
        TAX

        LDAIM   23
        JSR     oswrch
        LDAIM   &00
        JSR     oswrch
        LDAIM   &0A             ; cursor control register
        JSR     oswrch
        TXA
        JSR     oswrch

        LDXIM   &05
        LDAIM   &00
bloop
        JSR     oswrch
        DEX
        BPL     bloop

        PLX
        PLA

        RTS                     ; and away..
        ]

        [ extgf=1               ; extended search and replace texts

                                ; we will use the function and <Shift> function
                                ; keys to insert the match characters

                                ; when these keys are pressed the relevant
                                ; text will be displayed and the correct
                                ; (existing) match character inserted into
                                ; the text - if a normal existing character
                                ; is entered it will be translated to "\c"
                                ; and the existing routines called

        ; KEYS       TWIN                 EDIT
        ;
        ;       f0 - newline            - "$"
        ;       f1 - found section      - "%"
        ;       f2 - found string       - "&"
        ;       f3 - most items         - "^"
        ;       f4 - many items         - "*"
        ;       f5 - replace by         - "/"
        ;       f6 - NOT item           - "~"
        ;       f7 - any character      - "."
        ;       f8 - alpha-numeric      - "@"
        ;       f9 - digit              - "#"
        ;
        ; Shift f0 - start set          - "["
        ;       f1 - end set            - "]"
        ;       f2 - sub range          - "-"
        ;       f3 - control character  - "|"
        ;       f4 - set top bit        - "|!|"
        ;       f5 - exactly            - "\"
        ;       f6 - toggle case        - not supported
        ;       f7 -                    -
        ;       f8 -                    -
        ;       f9 -                    -
        ;

        ^       128
nlnc    #       &01
fsnc    #       &01
fstc    #       &01
mstc    #       &01
manc    #       &01
rbyc    #       &01
notc    #       &01
anyc    #       &01
alpc    #       &01
digc    #       &01

        ^       144
setc    #       &01
stcc    #       &01
subc    #       &01
ctrc    #       &01
stbc    #       &01
exac    #       &01
ntc1    #       &01
ntc2    #       &01
ntc3    #       &01
ntc4    #       &01

kttab   ; key translation table

        =       nlnc,"newline",null           ; f0
        =       fsnc,"section",null           ; f1
        =       fstc,"match",null             ; f2
        =       mstc,"most",null              ; f3
        =       manc,"many",null              ; f4
        =       rbyc,"replace by",null        ; f5
        =       notc,"NOT",null               ; f6
        =       anyc,"any",null               ; f7
        =       alpc,"alpha",null             ; f8
        =       digc,"digit",null             ; f9

        =       setc,"[",null                 ; s+f0
        =       stcc,"]",null                 ; s+f1
        =       subc,"-",null                 ; s+f2
        =       ctrc,"control",null           ; s+f3
        =       stbc,"set top bit",null       ; s+f4
        =       exac,"exactly",null           ; s+f5
        =       ntc1,"",null                  ; s+f6
        =       ntc2,"",null                  ; s+f7
        =       ntc3,"",null                  ; s+f8
        =       ntc4,"",null                  ; s+f9

kttabe  ; end of table

nktent  *       ( kttabe - kttab )


readlf                          ; read line for find and replace
                                ; convert special keys to text when displaying

                                ; text into 'linbuf'
                                ; Y = number of chars excluding cr
        LDAIM   space
        JSR     oswrch

        LDAIM   thelot
        STA     update

        JSR     rdline
        BCC     noESC

        JSR     vstrng
        =       &03,&0F,&0D,&EA

        LDA     BRKact
        CMPIM   &02
        BNE     ESCso

        JSR     closeX
        JSR     stFILE
ESCso
        STZ     cursed
        JMP     ESCcon

rdline
        LDYIM   &00             ; index into 'linbuf'
rdloop
        LDAIM   "r"
        JSR     oswrch

        JSR     osrdch
        BCS     rdexit

        STAAY   linbuf          ; store the relevant value

        CMPIM   &7F
        BNE     rdlin2

        CPYIM   &00
        BEQ     rdloop

        DEY

        PHY

        LDAAY   linbuf

        JSR     sttadt          ; delete the character(s)
        PLY

        BCC     rdloop

        LDAIM   &7F             ; then let us delete it ourselfs
        JSR     oswrch

        BRA     rdloop

rdlin2
        CMPIM   &15
        BNE     rdlin3
rdlind
        TYA
        BEQ     rdloop

        PHY

        LDAAY   linbuf - 1

        JSR     sttadt          ; delete the character(s)
        PLY

        BCC     decY

        LDAIM   &7F             ; then let us delete it ourselfs
        JSR     oswrch
decY
        DEY
        BRA     rdlind

rdlin3
        INY
        CMPIM   cr
        BEQ     rdlicr

        JSR     sttapt

        BCC     rdloop

        JSR     paswrc          ; write character after parsing
                                ; ctrl chars - inverse
                                ; delete     - inverse "?"
                                ; any other character just echoed
        BRA     rdloop

rdlicr
        PHY
        JSR     curOFF
        PLY
        DEY
        CLC
rdexit
noESC
        RTS


sttapt                          ; search through the table and print the text
                                ; Entry..  A - character value
                                ; Exit...  A - character value        
                                ;         CC - found - text printed
                                ;         CS - not found
        LDXIM   :LSB: kttab
        LDYIM   :MSB: kttab
        STXZ    ctptr
        STYZ    ctptr + 1

nctest
        PHA

        CMPI    ctptr
        BEQ     gotit1

        JSR     nxtstr          ; no match so onto the next
        BCC     nctest

        PLA
        RTS                     ; well it wasn't one of ours

gotit1
        JSR     startI

        LDYIM   &01             ; the index to the text
ncoutl        
        LDAIY   ctptr
        BEQ     tdone

        JSR     oswrch

        INY
        BRA     ncoutl
tdone
        JSR     stopIN

        PLA
        CLC
        RTS



sttadt                          ; search through table and delete text
                                ; if it is one of our expanded characters
                                ; then delete the relevant number of chars
                                ;
                                ; Entry.. A - character value
                                ; Exit..  relevant number of &7F's printed
        LDXIM   :LSB: kttab
        LDYIM   :MSB: kttab
        STXZ    ctptr
        STYZ    ctptr + 1
nctst2
        LDAI    ctptr
        BEQ     gotit2

        JSR     nxtstr
        BCC     nctst2

        RTS                     ; not matched - so delete manually

gotit2
                                ; it is one of ours
        LDYIM   &FF
gndspc
        INY

        LDAIY   ctptr
        BNE     gndspc

        LDAIM   &7F
dndspc
        JSR     oswrch          ; and delete the relevant number of characters
        DEY
        BPL     dndspc

        CLC
        RTS


nxtstr                          ; pass onto the next string, checking
                                ; to see if we have reached the end of the
                                ; table
                                ; step to character after 'null'
                                ; update 'ctptr' until = kttabe
        LDAI    ctptr
        BEQ     outup

        INCZ    ctptr
        BNE     nxtstr
        INCZ    ctptr + 1
        BRA     nxtstr

outup
        INCZ    ctptr
        BNE     nihii2
        INCZ    ctptr + 1
nihii2
        SEC
        LDAZ    ctptr + 1
        CMPIM   :MSB: kttabe
        BNE     maybe1
        LDAZ    ctptr
        CMPIM   :LSB: kttabe
        BCS     outdwn          ; and around for the next
maybe1
        PLA
        CLC
        RTS
outdwn
        PLA
        SEC
        RTS
        ]

        ; ------------------------------------------------------------ ;

        [ origin=&8000
theend
        |
        =       "Roger Wilson",null
theend
        ]

romlen  *       (theend - origin)

        END
