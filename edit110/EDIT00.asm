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
