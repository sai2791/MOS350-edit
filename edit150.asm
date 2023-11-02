;
;  This is a disassembly of the edit 1.50r rom from the BBC Master
;  MOS 3.50.  The label names are copied from an earlier disassembly
;  or source 
;  
;  This is for CMOS machines only, it contains 65C02 instructions
;
;
; The editor keeps a byte in the CMOS RAM.
; It is copied into TUTMOD on startup.
; TODO: Check that we are using TUTMOD not options 
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

; Some Constants

null    =       &00
lf      =       &0A
cr      =       &0D
tab     =       &09
down    =       lf
up      =       &0B
home    =       &1E
space   =       " "
delete  =       &7F

IF lfver=0
  termin = cr   ; line terminator
ELSE
  termin = lf   ; a different line terminator
ENDIF


bit7    =       &80
bit6    =       &40
bit5    =       &20
bit4    =       &10
bit3    =       &08
bit2    =       &04
bit1    =       &02
bit0    =       &01

blink   =       bit6
fblink  =       bit5

fcstrt  =       &00             ; Full cursor start line
ncstrt  =       &07             ; Normal start line
;

STRING          = $0000
OSHWM           = $0002
TMAX            = $0004
FULLSC         = $0005
TEMP            = $0006
THELOT          = $0006
ADDR            = $0008
ARGP            = $000A
VARP            = $000C
TP              = $000E
GS              = $0010
GE              = $0012
XEFF            = $0014
LASTSP          = $0015
DIFF            = $0016
CENTRE          = $0017
SMATLO          = $0018
SMATHI          = $001A
UMATLO          = $001C
UMATHI          = $001E
HYMEM           = $0020
tstart          = $0022
BRKACT          = $0024
SIZE            = $0025
maxsiz          = $0027
PWTFLG          = $0029
PRTFLG          = $002A
options         = $002B
MODFLG          = $002C
ATEMP           = $002D
COUNT           = $002E
INDEX           = $002F
PAGEWI          = $0030
PAGELE          = $0031
REALPA          = $0032
SCRUPY          = $0033
MAXSCRUPY       = $0034
UPDATE          = $0035
SCRNPY          = $0036
SCRNX           = $0037
SCRNY           = $0038
LNBUFX          = $0039
cursed          = $003A
FILL            = $003B
TINDEN          = $003C
JUSLEN          = $003D
SPACES          = $003E
NUMMAR          = $003F
MARKSB          = $0040
CURRLEN         = $0041
NEXTREADFLAG    = $0042
NXTCHR          = $0043
LINEDW          = $0044
LINEOT          = $0045
CTLCHA          = $0046
BOLDRQ          = $0047
UNDRRQ          = $0048
OFFSET          = $0049
PBOLD           = $004A
LASTTAB         = $004B
LINE            = $004C
INDEXH          = $004E
mark_count      = $004F
MARKX           = $0050
TSM             = $0051
BSM             = $0052
TEXPFLAG        = $0053
SENSFLAG        = $0054
BUTTFLAG        = $0055
METAFLAG        = $0056
REPLFLAG        = $0057
ENDP            = $005B
ENDPd          = $005C
SCP             = $005D
TEXTP           = $005F
scratc          = $0061
ANOTHSTRING     = $007B
L007D           = $007D
L007E           = $007E
L007F           = $007F
L0080           = $0080
termin          = $0081
L0083           = $0083
L0084           = $0084
L008D           = $008D
L00F2           = $00F2
L00F4           = $00F4
L00FD           = $00FD
ESCFLG          = $00FF
L019F           = $019F
L01A0           = $01A0
USERV           = $0200
BRKV            = $0202
IRQ1V           = $0204
IRQ2V           = $0206
CLIV            = $0208
BYTEV           = $020A
WORDV           = $020C
WRCHV           = $020E
RDCHV           = $0210
FILEV           = $0212
ARGSV           = $0214
BGETV           = $0216
BPUTV           = $0218
GBPBV           = $021A
FINDV           = $021C
FSCV            = $021E
EVNTV           = $0220
UPTV            = $0222
NETV            = $0224
VDUV            = $0226
KEYV            = $0228
INSV            = $022A
REMV            = $022C
CNPV            = $022E
IND1V           = $0230
IND2V           = $0232
IND3V           = $0234
FRBUFF          = $0400
GRBUFF          = $0464
nambuf          = $04C8
oldsta          = $04FC
LINBUFF         = $0500
noregs          = $0500
LINENO          = $0502
PAGEEH          = $0514
PAGEOH          = $0516
PAGEEF          = $0518
PAGEOF          = $051A
TABLST          = $051C
L052F           = $052F
MACLST          = $0530
stracc          = $0600
trnlst          = &0600
L060A           = $060A
L060D           = $060D
L06A0           = $06A0
sindexstk       = $0700
SSTTLOSTK       = $0706
SSTTHISTK       = $070C
SCNTLOSTK       = $0712
SCNTHISTK       = $0718
FIELDMMXTAB     = $071E
FIELDOFFTAB     = $0728
SCRIM           = $0732
machtype        = $0752
L0753           = $0753
PRMPTL          = $07E5
L6120           = $6120
L6373           = $6373
L638C           = $638C
L6854           = $6854
L6C41           = $6C41
L6F43           = $6F43
L6F8C           = $6F8C
L748C           = $748C
L778C           = $778C
L7F0D           = $7F0D
L7F13           = $7F13
L7FA9           = $7FA9
defvec          = $D940
OSRDRM          = $FFB9
VDUCHR          = $FFBC
OSEVEN          = $FFBF
GSINIT          = $FFC2
GSREAD          = $FFC5
NVRDCH          = $FFC8
NVWRCH          = $FFCB
OSFIND          = $FFCE
OSGBPB          = $FFD1
OSBPUT          = $FFD4
OSBGET          = $FFD7
OSARGS          = $FFDA
OSFILE          = $FFDD
OSRDCH          = $FFE0
OSASCI          = $FFE3
OSNEWL          = $FFE7
OSWRCH          = $FFEE
OSWORD          = $FFF1
OSBYTE          = $FFF4
OSCLI           = $FFF7

CPU 1
                org     $8000
.BeebDisStartAddr
.langent        JMP     language

.servent        JMP     service

                ASL     A
.L8009          EQUS    "EDIT"

                EQUB    $00

                EQUS    "1.50r"

                EQUB    $00

                EQUS    "(C)1989 Acorn"

                EQUB    $0A,$0D

.L8023          BRK
                EQUB    $00

                CLV
                PLP
                BRA     L7FA9

                LDA     L0083,X
;
; Recognise *help and *edit 
.service        PHA
                TAX
                TYA
                PHA
                CPX     #$04
                BEQ     command

                CPX     #$09
                BNE     ucomEX

                ; *Help response

                LDA     (L00F2),Y
                CMP     #$0D
                BNE     ucomEX  ; don't say anything unless there are no keywords 

                JSR     OSNEWL

                LDX     #$F6
; Print the ROM name from Header, when we get the brk, print space and 
; continue
.prnthelp       LDA     L7F13,X 
                BNE     notaspace

                LDA     " "
.notaspace      JSR     OSASCI

                INX
                BNE     prnthelp

                JSR     OSNEWL

.ucomEX         PLA
                TAY
                LDX     L00F4
                PLA
                RTS

.command        LDX     #$FC
.ucomLO         LDA     (L00F2),Y
                CMP     #$2E       ; is this a "."
                BEQ     ucommi

                AND     #$DF       ; Change to Uppercase
                CMP     L7F0D,X    ; pointer to EDIT (L8009)
                BNE     ucomEX     

                INY
                INX
                BNE     ucomLO

                LDA     (L00F2),Y
                CMP     #$21       ; is this a "!"
                BCS     ucomEX

.ucommi         LDX     L00F4      ; EDIT ROM number
                LDA     #$8E       ; Enter Languge Rom
                JMP     OSBYTE
;
;Outputs 'brk' error message, & jumps to relevant re-entry
;point. Detailed action depends on value of 'brkaction' on entry -
; brkaction = 0 Moves cursor to editor status position,
; outputs error message, then prompts for space
; before jumping to editcont.
; 1    Outputs error message, and jumps to starloop.
; 2    resets to start of file and closes indexfile, then as 0

.setbrkv        LDX     #$FF
                TXS
                STZ     cursed
                JSR     ackesc

                LDA     BRKACT
                CMP     #$FF
                BNE     simBRK

.unret          LDA     ADDR
                BNE     unretA

                DEC     ADDR+1
.unretA         DEC     ADDR
                LDA     ARGP
                BNE     unretb

                DEC     ARGP+1
.unretb         DEC     ARGP
                LDA     (ARGP)
                STA     (ADDR)
                LDA     ADDR
                BNE     unret

                LDA     ADDR+1
                CMP     STRING+1
                BNE     unret

                LDA     #$0D
                STA     (TMAX)
                LDA     #$00
.simBRK         CMP     #$01
                BNE     simBK2

                JSR     supvBR

                JMP     starCN

.simBK2         BCC     norBRK

                JSR     closeX

                JSR     STFILE

.norBRK         JSR     VSTRNG

                EQUB    $03,$0F,$EA

.L80C3          JSR     CSR0STATUSY

                JSR     L8C1A

                JSR     VSTRNG

                EQUB    $0B,$0B,$0B,$82,$EA

.L80D1          LDX     #$80
                LDA     #$EB
                JSR     BRKsub

                EQUS    "Shift f5 D for info"

                EQUB    $83,$81,$EA

.L80EE          LDX     #$20
                LDA     #$FE
                JSR     BRKsub

                STA     (L0084,X)
                NOP
                LDX     #$80
                LDA     #$E6
                JSR     BRKsub

                EQUS    "Press ESCAPE to continue"

                EQUB    $85,$0B,$0B,$09,$EA

.L811C          JSR     BRKOY

                JSR     L8C77

.esclop         JSR     OSRDCH

                CMP     #$1B
                BNE     esclop

.ESCCON         JSR     ackesc

                JSR     NORMAL

                JMP     EDITco

.ackesc         LDA     #$7E
                JMP     OSBYTE    ; Acknowledge escape condition

.supvBR         JSR     OSNEWL

.BRKOY          LDY     #$01
.BRKOLP         LDA     (L00FD),Y
                BEQ     BRKOK

                JSR     OSASCI

                INY
                BNE     BRKOLP

.BRKOK          RTS

.language       CLI
                CLD
                LDX     #$FF
                TXS
 ; On entry, X=0  - Generate error number 247 giving host and OS type
 ;           X<>0 - Return host/OS in X

 ; On exit,  OS type:
 ; 0 Electron/Communicator  
 ; 1 BBC                    
 ; 2 BBC B+                
 ; 3 Master 128
 ; 4 Master ET
 ; 5 Master Compact

                LDA     #$00
                LDX     #$01      ; Return Host type in X
                JSR     OSBYTE    ; Get machine type
                CPX     #$03
                BCC     getsettings

                TXA
.getsettings    STA     machtype

; On entry:
;   X=byte to read or 255 for to read configuration RAM/EEPROM size
; On exit:
;   X corrupted or &FF if no configuration RAM/EEPROM support
;   Y=byte read or configuration RAM/EEPROM size
;
; CMOS Byte 8
;    8 b0-b2  EDIT screen mode
;      b3     EDIT TAB to columns/words
;      b4     EDIT overwrite/insert
;      b5     EDIT display returns

                LDA     #$A1       ; Read CMOS
                LDX     #$08
                JSR     OSBYTE

                STY     options
                TYA
                LDY     #$0D
                AND     #$40
                BEQ     setCRnotLF

                LDY     #$0A
.setCRnotLF     STY     termin
                LDA     #$79
                STA     BRKV
                LDA     #$80
                STA     BRKV+1
                STZ     oldsta+3
                LDA     #$F2
                STA     scratc
                STZ     scratc+1
                JSR     readby

                TAX
                JSR     L829C

                STA     scratc+1
                STX     scratc
                LDX     #$14

.EDITol         DEX
                BEQ     EDIToz
                JSR     L829C

                CMP     cr
                BEQ     EditozOther
                CMP     " "
                BEQ     L81A1
                CMP     "."
                BNE     EDITol

.L81A1          DEX
                BEQ     EditozOther

                JSR     L829C

                CMP     #$20
                BEQ     L81A1

                LDX     #$00
.EDITGB         STA     L01A0,X
                JSR     L829C

                INX
                CPX     #$40
                BNE     EDITGB

                LDA     #$0D
                STA     L019F,X
                STA     nambuf
                LDY     #$00
                JSR     readhx

                BCC     EDITon

                CMP     #$2C
                BNE     EDITon

                LDA     STRING,X
                STA     oldsta
                LDA     STRING+1,X
                STA     oldsta+1
                INY
                JSR     readhx

                BCC     EDITon

                CMP     #$0D
                BNE     EDITon

                LDA     STRING,X
                STA     oldsta+2
                LDA     STRING+1,X
                STA     oldsta+3
                STZ     cursed
                BRA     EDIToy

.EDITon         LDX     #$00
                LDA     L01A0
                CMP     #$0D
.EDIToz         BEQ     EditozOther

.L81F6          LDA     L01A0,X
                CMP     cr
                BEQ     L8205
                CMP     " " 
                BCC     EditozOther

                CMP     #$7F
                BCS     EditozOther

.L8205          STA     nambuf,X
                INX
                CMP     cr
                BNE     L81F6

                LDA     #$01
                STA     cursed
                BRA     EDIToy

.EditozOther    LDX     #$FF
                STX     cursed
                LDA     cr
                STA     nambuf
                LDA     termin
                CMP     (PAJE)
                BNE     EDIToy
                CMP     (TMAX)
                BNE     EDIToy
                JSR     memstate

.EDIToy         LDA     #$0D
                STA     FRBUFF
                STA     GRBUFF
                STZ     INDEXH
                STZ     MODFLG
                LDA     #$03
                JSR     OSWRCH
                LDA     cursed
                BEQ     zippo
                DEC     A
                BEQ     zappo
                JMP     EDIT   ; and away we go...

.zippo          JSR     EDITmd
                JMP     OLDTEXT

.zappo          STZ     BRKACT
                JSR     EDITmd
                JSR     EDITi2

                LDY     #$00
                LDA     #$C8
                STA     TEMP
                LDA     #$04
                STA     TEMP+1
                JSR     tload

                JMP     EDITgt

.XYscra         LDX     #$61
                LDY     #$00
                RTS

.readnx         INC     scratc
                BNE     L826D
                INC     scratc+1
.L826D          RTS

.readhx         LDX     #$00
                STZ     scratc+5
.tsthex         LDA     L01A0,Y
                CMP     #$30
                BCC     hexend
                CMP     #$3A
                BCC     OKhex
                SBC     #$37
                CMP     #$0A
                BCC     hexend
                CMP     #$10
                BCS     hexend

.OKhex          ASL     scratc+5
                ASL     scratc+5
                ASL     scratc+5
                ASL     scratc+5
                AND     #$0F
                TSB     scratc+5
                INY
                INX
                BRA     tsthex

.hexend         CPX     #$01
                LDX     scratc+5
                RTS

.L829C          JSR     readnx

.readby         PHX
                PHY
                JSR     XYscra    ; osword block at &0061

; Read I/O Processor Memory 
; On entry:
;   XY!0=address to read from
; On exit:
;   XY?4=the byte read
                LDA     #$05
                JSR     OSWORD

                PLY
                PLX
                LDA     scratc+4   ; Byte at address read
                RTS

.paslnm         PHP
                SEC
                SBC     ADDR
                STA     maxsiz
                TXA
                SBC     ADDR+1
                STA     maxsiz+1
                PLP
.filena         LDA     (TEMP),Y
                CMP     #$0D
                BEQ     textna

                CMP     #$8B
                BEQ     oldnam

                BVC     L82D1

                CLC
                TYA
                ADC     TEMP
                TAX
                LDA     TEMP+1
                ADC     #$00
                BRA     L82E9

.L82D1          LDX     #$00
.L82D3          LDA     (TEMP),Y
                STA     nambuf,X
                INY
                INX
                CPX     #$34
                BNE     L82D3

.oldnam         LDA     nambuf
                CMP     cr
                BEQ     nonam

                LDX     #$C8
                LDA     #$04
.L82E9          STX     scratc
                STA     scratc+1
                RTS

.textna         LDX     GE
                LDY     GE+1
                PHX
                PHY
                LDX     tstart
                LDY     tstart+1
                JSR     GPBKXY

                LDY     #$00
.MVIC           LDA     (GE),Y
                STA     stracc,Y
                INY
                BNE     MVIC

                PLY
                PLX
                JSR     GPFDXY

                LDY     #$FF
.namsrc         INY
                BMI     nonam

                LDA     stracc,Y
                CMP     termin
                BEQ     nonam

                CMP     #$3E
                BNE     namsrc

                INY
                STY     scratc
.namesr3        LDA     stracc,Y
                CMP     termin
                BEQ     namfnd

                INY
                BPL     namesr3

.nonam          TYA
                BEQ     namsrc

                BRK
                EQUB    $01
                EQUS    "No name found"
                EQUB    $00

.namfnd         LDA     #$0D
                STA     stracc,Y
                LDA     #$06
                STA     scratc+1
                RTS

.writna         JSR     startI

                LDY     #$FF
.wrispc         INY
                LDA     (scratc),Y
                CMP     #$20
                BEQ     wrispc

.wrilop         LDA     (scratc),Y
                CMP     #$21
                BCC     wriex

                JSR     OSWRCH

                INY
                BRA     wrilop

.wriex          JMP     stopin

.tload          LDA     tstart
                STA     ADDR
                LDA     tstart+1
                STA     ADDR+1
                LDA     TMAX
                LDX     TMAX+1
                CLV
;
; Entry - IY temp -> name, addr = load address, AX = max free address
; Exit - File checked for size (not on slow FS's)
; File loaded to addr, with XY = top of file
 
.pasloa         JSR     paslnm

                JSR     prompt
                EQUS    "Loading "
                EQUB    $EA

.L837B          JSR     writna

.pasGO          LDY     #$00
                TYA
                JSR     OSARGS

                CMP     #$04
                BCC     nosize
                ; using a random access filing system,
                ; so can quickly check size of file.

                LDA     #$05     ; Read Information
                JSR     XYscra
                JSR     OSFILE
                CMP     #$01
                BNE     nosize        ; Let FS generate 'Directory/not found' error
                LDA     scratc + $0C
                ORA     scratc + $0D
                BNE     pas1hu
                LDA     maxsiz
                CMP     scratc + $0A
                LDA     maxsiz + 1
                SBC     scratc + $0B
                BCC     pas1hu

.nosize         LDA     ADDR
                ; Load file to addr, & set XY --> top of loaded file.
                STA     scratc + 2
                LDA     ADDR + 1
                STA     scratc + 3
                STZ     scratc + 4
                STZ     scratc + 5
                STZ     scratc + 6
                LDA     #$FF
                JSR     XYscra

                JSR     OSFILE

                STZ     oldsta+3
                CLC
                LDA     ADDR
                ADC     scratc+$0A
                TAX
                LDA     ADDR+1
                ADC     scratc+$0B
                TAY
                RTS

.pas1hu         BRK
                EQUB    $02

                EQUS    "File too big"

.L83D7          BRK
.tsave          
                ; Save (defaulting) marked block of text.
                ; Entry - (temp),Y points to input name.
                ; GE - Start of block
                ; ENDP - End of block
                ; Exit - specified memory saved as filename.
                EQUB    $B8
                JSR     filena

.inSAVE         JSR     prompt
                EQUS    "Saving to "
.L83E9          NOP
                JSR     writna

                LDX     #$0F
.pasac1         STZ     scratc + 2,X
                DEX
                BPL     pasac1

                DEC     scratc + 6
                DEC     scratc + 7
                DEC     scratc + 8
                DEC     scratc + 9
                LDA     GE
                STA     scratc + $0A
                LDA     GE+1
                STA     scratc + $0B
                LDA     ENDP
                STA     scratc + $0E
                LDA     ENDP + 1
                STA     scratc + $0F
                LDA     #$00      ; Save file
                JSR     XYscra

                JMP     OSFILE

.READNS         

        ; Reads line to commandline (linbuf), & strips leading &
        ; trailing spaces.
        ; Exit - temp --> 1st non-space char on line
        ; A      = 1st non-space char on line
        ; Y      = 0
        ; EQ if line was 'empty', else NE

                JSR     READLS

                TYA
                BEQ     renSCR

.renSST         LDA     oldsta+3,Y
                CMP     #$20
                BNE     renSCR

                DEY
                BNE     renSST

.renSCR         LDA     #$0D
                STA     LINBUFF,Y
                LDY     #$FF
.renSIG         INY
                LDA     LINBUFF,Y
                CMP     #$20
                BEQ     renSIG

                CLC
.readIM         TYA
                ADC     #$00
                STA     TEMP
                LDA     #$00
                ADC     #$05
                STA     TEMP+1
                LDY     #$00
                LDA     (TEMP)
                CMP     #$0D
.escCLR         RTS

.readIN         LDY     #$00
                BRA     readIM

.READLS         LDA     space  
                JSR     OSWRCH

                ; Read line into linbuf/commandline, testing for escape.
                ; Exit - Y = No. of chars read (excluding CR).

                LDA     thelot
                STA     UPDATE
                JSR     rdlnre
                BCC     escCLR

.escSET         JSR     VSTRNG

                EQUB    $03,$0F,$0D,$EA

.L845F          LDA     BRKACT
                CMP     #$02
                BNE     escSIM

                JSR     closeX

                JSR     STFILE

.escSIM         STZ     cursed
                JMP     ESCCON

.IndOSRDCH      JSR     OSRDCH

.escTST         BIT     ESCFLG
                BMI     escSET
                RTS

.rdlnre         LDY     #$00
.RDLNLP         JSR     EDRDCH

                STA     LINBUFF,Y
                CMP     #$7F
                BNE     RDNL2

                CPY     #$00
                BEQ     RDLNLP

                DEY
                JSR     OSWRCH

                BRA     RDLNLP

.RDNL2          CMP     #$15
                BNE     RDLN3

.RDLNDL         TYA
                BEQ     RDLNLP

                LDA     #$7F
                JSR     OSWRCH

                DEY
                BRA     RDLNDL

.RDLN3          INY
                CMP     #$0D
                BEQ     RDLNEG

                JSR     PASWRCH

                BRA     RDLNLP

.RDLNEG         PHY
                JSR     CUROFF

                PLY
                DEY
                CLC
                RTS

.COPYBK         
        ; Copy block backwards (i.e. to lower address).
        ; Entry - ARGP --> block of size XY
        ; VARP --> destination address 
 
                STX     SIZE
                STY     SIZE+1
                LDA     SIZE
                ORA     SIZE+1
                BEQ     BKEXIT

                LDX     SIZE+1
                SEC
                LDA     #$00
                SBC     SIZE
                TAY
                BEQ     BKLOOP

                STA     TEMP
                SEC
                LDA     ARGP
                SBC     TEMP
                STA     ARGP
                BCS     CPNHI1

                DEC     ARGP+1
                SEC
.CPNHI1         LDA     VARP
                SBC     TEMP
                STA     VARP
                BCS     CPNHI2

                DEC     VARP+1
.CPNHI2         INX
.BKLOOP         LDA     (ARGP),Y
                STA     (VARP),Y
                INY
                BNE     BKLOOP

                INC     ARGP+1
                INC     VARP+1
                DEX
                BNE     BKLOOP

.BKEXIT         RTS

.memstate       LDA     tstart+1
                JSR     chkptr

                LDA     GS+1
                JSR     chkptr

                LDA     GE+1
                JSR     chkptr

                LDA     TMAX+1
                JSR     chkptr

                LDX     TMAX
                LDY     TMAX+1
                JSR     GPFDXY

                LDA     tstart
                STA     oldsta
                LDA     tstart+1
                STA     oldsta+1
                LDA     GS
                STA     oldsta+2
                LDA     GS+1
                STA     oldsta+3
                CLC
.CHKPTX         RTS

.chkptr         CMP     HYMEM+1
                BCS     CHKPTX

                CMP     PAJE + 1
                BCS     CHKPTX

                PLA
                PLA
                RTS

.BRKsub         SEC
                ADC     PAGEWI
                TAY
                TXA
.brksb1         JSR     OSWRCH

                DEY
                BNE     brksb1

.VSTRNG         PLA
                STA     STRING
                PLA
                STA     STRING+1
                JSR     VSTRLP

                JMP     (STRING)

.VSTRLM         JSR     OSWRCH

.VSTRLP         INC     STRING
                BNE     STRINO

                INC     STRING+1

.STRINO         LDA     (STRING)      ; enter here for normal string
                CMP     #$EA
                BNE     VSTRLM

                RTS

.cf8swt         LDA     termin
                EOR     #$07
                STA     termin
                STA     (OSHWM)
                STA     (TMAX)
                LDA     #$40
                JSR     predomode

                JSR     STFILE

                JMP     STATUS

.CRTOGG         LDA     #$20
.predomode      EOR     options     ; toggle show CR/LF
.domode         STA     options
                PHX
                PHY
                TAY

 ; OSBYTE &A2 - Write CMOS
 ; On entry:
 ;  X=index of byte to write
 ;  Y=byte to write
 ; On exit:
 ;  undefined               
                LDA     #$A2
                LDX     #$08        ; Edit Byte
                JSR     OSBYTE      ; Write EDIT configuration to CMOS

                PLY
                PLX
                RTS

.TESTIF         LDA     #$10
                BIT     options
                RTS

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

.EDIT           JSR     EDITmd

.EDITin         LDX     tstart       ; Initalize pointers to reflect empty buffer.
                LDY     tstart+1
.EDITgt         STZ     MODFLG       ; Re-entry point for Tload. XY = Enf of file.
.EDITgs         JSR     EDITtd       ; Re-entry from OLDSTA, newmode

.EDITco         LDX     #$FF         ; Re-entry point for brk-handler.
                TXS
                STZ     BRKACT
                JSR     inited

.L858F          LDA     #$06
                STA     UPDATE
.EDITlo         JSR     SCRNUD        ; update screen to reflect previous command.
                JSR     CSRSCR
                JSR     CURON

                LDA     #$05          ; FULLSC 
                STA     UPDATE
                ; Read a char, and branch depending on its value
                ;   &00 - &7F     is ASCII input to be entered as text
                ;   &80 - &8F     are softkey values       }
                ;   &90 - &9F     are shift-softkey values } Editor commands
                ;   &A0 - &AF     are ctrl-sofkkey values  }
                ;   &8A, &9A, &AA is the TAB key
                ;   &B0 - &FF     are entered into text (e.g. icelandics)
                JSR     EDRDCH

                BNE     EDITTE
                TAX
                LDX     cursed
                BNE     EDITTE

                TAX
                LDA     options
                AND     #$07
                CMP     #$05
                BNE     GOMAN

                CPX     #$9C
                BCS     GOMAN

                CPX     #$90
                BCS     DEFVAL

                CPX     #$8A
                BCS     GOMAN

.DEFVAL         TXA
                PHA
                ASL     A
                TAY
                JSR     VSTRNG

                EQUB    $1C,$00,$0C,$35,$09,$0C

                EQUB    $EA

.DEFVAL1        LDA     TXTTAB,Y
                STA     ANOTHSTRING
                LDA     L87AC,Y
                STA     ANOTHSTRING+1
                JSR     LA113

                BRA     TUTDON

.TUTLIN         LDY     #$00
                JSR     OSNEWL

.TUTOUT         LDA     (STRING)
                INC     STRING
                BNE     TUTINC

                INC     STRING+1
.TUTINC         CMP     #$0D
                BEQ     NEEDWP

                CMP     #$EA
                BEQ     TUTDON

                JSR     OSWRCH

                INY
                BRA     TUTOUT

.NEEDWP         LDA     #$20
.TITWIP         CPY     #$36
                BCS     TUTLIN

                JSR     OSWRCH

                INY
                BRA     TITWIP

.TUTDON         JSR     DECWIN

                JSR     CSRSCR

                PLX
.GOMAN          TXA
                ASL     A
                TAX
                JSR     IADDRS

                JMP     EDITlo

.IADDRS         JMP     (EDCTBL,X)
.EDITTE         JSR     EDTEXT

                JMP     EDITlo

.EDTEXT
                ; Entry - A holds ASCII char to be treated as text input
                ; Exit  - appropraite action taken depending on current
                ;        'mode' (insert, overtype, csr-edit).

                CMP     delete 
                BEQ     ECHRDE

                STZ     oldsta + 3
                CMP     cr
                BNE     ECHRCO
                JSR     TESTIF ; in insert mode put in the CR

                BNE     ECHRCR

                JSR     ENDTES

                BCS     ECHRCR

                STZ     SCRNX
                JMP     CURDWN ; in overtype mode CR is start of line

.ECHRCR         LDA     termin
.ECHRCO         PHA            ; Insert character into text.
                JSR     ADDVIR
                ; Don't insert in overtype mode, unless at the end of line

                JSR     TESTIF
                BNE     ECHRMV
                LDY     SCRNX
                LDA     (GE),Y
                CMP     termin
                BNE     ECHRCH

.ECHRMV         LDX     #$01
                LDA     SCRNX
                JSR     INSRTX

.ECHRCH         PLA
                LDY     SCRNX
                STA     (GE),Y
                ; Write char to screen (cursor OK), wiping tail for TERMIN.
                CMP     termin
                BNE     ECHRNT

                JSR     PASWCR

                LDA     SCRNX
                LDY     SCRNY
                JSR     WIPETA

.EHRCSU         STZ     SCRNX
                JSR     CURDWN

.ECHRUP         LDA     UPDATE
                BEQ     ECHREL

                JSR     SCRNUD

.ECHREL         LDA     #$02
                STA     UPDATE
                JMP     MODIFY

.ECHRNT         JSR     PASWRCH

                JSR     CURRT

.ECHRN0         LDA     UPDATE
                BEQ     ECHRN1

                JSR     SCRNUD

.ECHRN1         LDA     #$01
                STA     UPDATE
                JMP     MODIFY

.ECHRDE         
                ; Delete virtual space implies csrleft. Can't delete start of file.
                JSR     VSCOUN
                BEQ     EDELST
                JMP     CURLT

.EDELST         LDA     SCRNX
                BNE     EDELCO

                JSR     STARTTEST

                BCS     DELABX

.EDELCO
                ; Get char to be deleted under cursor. In absence of VS check 
                ; this will give TERMIN delete when past end of line.
                JSR     CURLT
                JSR     LENGTH     ; different line than current!
                CMP     SCRNX
                BCS     EDELMT
                STA     SCRNX

.EDELMT         ; Branch on text-entry mode (insert/overtype). 
                LDY     SCRNX
                JSR     TESTIF

                BNE     EDELSL

                LDA     (GE),Y
                CMP     termin
                BEQ     DELABX

                LDA     #$20
                STA     (GE),Y
                LDA     #$01
                STA     UPDATE
                JMP     MODIFY

.EDELSL         LDA     (GE),Y
                CMP     termin
                BEQ     EDELS2

                LDA     CURRLEN
                CMP     PAGEWI
                BEQ     EDELS2

                JSR     EDEL1

                BRA     ECHRN0

.EDELS2         JSR     EDEL1

                BRA     ECHRUP

.DELLIX         JSR     DELABV

.DELLIN         STZ     SCRNX
                LDA     (GE)
                CMP     termin
                BNE     DELLIX

                JSR     LENGTH

                STA     CURRLEN
                JSR     DELABV

                JMP     ECHREL

.DELABV         JSR     ENDTES

                BCC     DELABY

                LDA     SCRNX
                CMP     CURRLEN
                BCC     DELABY

.DELABX         RTS

.DELABY         LDA     CURRLEN
                CMP     SCRNX
                BCC     DELABX

                LDY     #$01
                STY     UPDATE
                CMP     PAGEWI
                BEQ     EDEL0

                LDY     SCRNX
                LDA     (GE),Y
                CMP     termin
                BNE     EDEL1

.EDEL0          INC     UPDATE
.EDEL1          ; Shift up start of line 'over' deleted character.
                JSR     MODIFY
                CLC
                LDA     GE
                STA     TEMP
                ADC     SCRNX
                STA     ADDR
                LDA     GE + 1
                STA     TEMP + 1
                ADC     #$00
                STA     ADDR + 1
                INC     GE
                BNE     EDELNH
                INC     GE + 1

.EDELNH         LDY     SCRNX
                BRA     EDELDY

.EDELLP         LDA     (TEMP),Y
                STA     (GE),Y
.EDELDY         DEY
                BPL     EDELLP

                LDX     MARKX
.EDELMK         DEX
                BMI     DELABX

                LDY     SMATLO,X
                CPY     ADDR
                LDA     SMATHI,X
                SBC     ADDR + 1
                BCS     EDELMK

                INC     SMATLO,X
                BNE     EDELMK

                INC     SMATHI,X
                BRA     EDELMK

.EDCTBL         EQUW    EDITLI            ; f0
                EQUW    edSTAR            ; f1
                EQUW    LOADfi            ; f2
                EQUW    SAVEfi            ; f3
                EQUW    FINDREPLACE       ; f4
                EQUW    GLOBALREP         ; f5
                EQUW    SETMARK           ; f6
                EQUW    MKCPY             ; f7
                EQUW    PRINT             ; f8
                EQUW    OLDTEXT           ; f9
                EQUW    TABKEY            ; f10
                EQUW    DELABV            ; copy 
                EQUW    CURLT             ; left 
                EQUW    CURRT             ; right 
                EQUW    CURDWN            ; down 
                EQUW    CURUP             ; up

                EQUW    CRTOGG            ; shift-f0
                EQUW    IOtogg            ; shift-f1
                EQUW    insrtF            ; shift-f2
                EQUW    scmclr            ; shift-f3
                EQUW    retlan            ; shift-f4
                EQUW    GETMOD            ; shift-f5
                EQUW    CLEARMARKS        ; shift-f6
                EQUW    MKMVE             ; shift-f7
                EQUW    MKDEL             ; shift-f8
                EQUW    newtex            ; shift-f9
                EQUW    tabctl            ; shift-f10
                EQUW    allowC            ; shift-copy
                EQUW    WORDLEFT          ; shift-left
                EQUW    WORDWRIGHT        ; shift-right
                EQUW    PAGEDN            ; shift-down
                EQUW    PAGEUP            ; shift-up
                
                EQUW    EDITlo            ; ctrl-f0
                EQUW    EDITlo            ; ctrl-f1
                EQUW    EDITlo            ; ctrl-f2
                EQUW    EDITlo            ; ctrl-f3
                EQUW    EDITlo            ; ctrl-f4
                EQUW    EDITlo            ; ctrl-f5
                EQUW    tsmcsr            ; ctrl-f6
                EQUW    bsmcsr            ; ctrl-f7
                EQUW    cf8swt            ; ctrl-f8
                EQUW    EDITlo            ; ctrl-f9
                EQUW    EDITlo            ; ctrl-f10
                EQUW    DELLIN            ; ctrl-copy
                EQUW    curst             ; ctrl-left
                EQUW    curend            ; ctrl-right
                EQUW    CUREDF            ; ctrl-down
                EQUW    STFILE            ; ctrl-up

.TXTTAB         EQUW    F0
                EQUW    F1
                EQUW    F2
                EQUW    F3
                EQUW    F4
                EQUW    F5
                EQUW    F6
                EQUW    F7
                EQUW    F8
                EQUW    F9
                EQUW    F9
                EQUW    F9
                EQUW    F9
                EQUW    F9
                EQUW    F9
                EQUW    F9
                EQUW    SHFF0
                EQUW    SHFF1
                EQUW    SHFF2
                EQUW    SHFF3
                EQUW    L904D    ; Can't find this in code
                EQUW    SHFF5
                EQUW    SHFF6
                EQUW    SHFF7
                EQUW    SHFF8
                EQUW    SHFF9
                EQUW    SHFTAB
                EQUW    SHFCOP

.BIGMESS        JSR VSTRNG 

                EQUB    $82

                EQUS    "shf-f0"

                EQUB    $80,$8D

                EQUS    "shf-f1"

                EQUB    $80,$8D

                EQUS    "shf-f2"

                EQUB    $80,$8D

                EQUS    "shf-f3"

                EQUB    $80,$8D

                EQUS    "shf-f4"

                EQUB    $80,$8D

                EQUS    "shf-f5"

                EQUB    $80,$8D

                EQUS    "shf-f6"

                EQUB    $80,$8D

                EQUS    "shf-f7"

                EQUB    $80,$8D

                EQUS    "shf-f8"

                EQUB    $80,$8D

                EQUS    "shf-f9"

                EQUB    $83,$81

                EQUS    "Display"

                EQUB    $81

                EQUS    "Insert/"

                EQUB    $81

                EQUS    "Insert "

                EQUB    $81

                EQUS    "Remove "

                EQUB    $81

                EQUS    "Return "

                EQUB    $81

                EQUS    " Set   "

                EQUB    $81

                EQUS    " Clear "

                EQUB    $81

                EQUS    "Marked "

                EQUB    $81

                EQUS    "Marked "

                EQUB    $81

                EQUS    "Clear "

                EQUB    $81,$81

                EQUS    "Returns"

                EQUB    $81

                EQUS    "Over   "

                EQUB    $81

                EQUS    " File  "

                EQUB    $81

                EQUS    "Margins"

                EQUB    $81

                EQUS    "Languag"

                EQUB    $81

                EQUS    " Mode  "

                EQUB    $81

                EQUS    " Marks "

                EQUB    $81

                EQUS    "Move   "

                EQUB    $81

                EQUS    "Delete "

                EQUB    $81

                EQUS    "Text  "

                EQUB    $81,$8E,$80,$80,$66,$30,$80,$80
                EQUB    $80,$91,$80,$80,$66,$31,$80,$80
                EQUB    $80,$91,$80,$80,$66,$32,$80,$80
                EQUB    $80,$91,$80,$80,$66,$33,$80,$80
                EQUB    $80,$91,$80,$80,$66,$34,$80,$80
                EQUB    $80,$91,$80,$80,$66,$35,$80,$80
                EQUB    $80,$91,$80,$80,$66,$36,$80,$80
                EQUB    $80,$91,$80,$80,$66,$37,$80,$80
                EQUB    $80,$91,$80,$80,$66,$38,$80,$80
                EQUB    $80,$91,$80,$80,$66,$39,$80,$80
                EQUB    $8F,$81

                EQUS    " Goto  "

                EQUB    $81

                EQUS    "Command"

                EQUB    $81

                EQUS    " Load  "

                EQUB    $81

                EQUS    " Save  "

                EQUB    $81

                EQUS    " Find  "

                EQUB    $81

                EQUS    "Global "

                EQUB    $81

                EQUS    " Mark  "

                EQUB    $81

                EQUS    "Marked "

                EQUB    $81

                EQUS    " Print "

                EQUB    $81

                EQUS    " Old  "

                EQUB    $81,$81

                EQUS    " Line  "

                EQUB    $81

                EQUS    "Line   "

                EQUB    $81

                EQUS    " File  "

                EQUB    $81

                EQUS    " File  "

                EQUB    $81

                EQUS    "String "

                EQUB    $81

                EQUS    "Replace"

                EQUB    $81

                EQUS    " Place "

                EQUB    $81

                EQUS    "Copy   "

                EQUB    $81

                EQUS    " Text  "

                EQUB    $81

                EQUS    " Text "

                EQUB    $81,$84,$EA,$A2,$08,$20,$32,$85
                EQUB    $80,$80,$80,$80,$80,$80,$80,$90
                EQUB    $EA,$CA,$10,$F1,$20,$32,$85,$80
                EQUB    $80,$80,$80,$80,$80,$85

.L89E3          NOP
                RTS

.BIGMET         JSR     VSTRNG

                EQUS    "The Acorn Screen Editor "

                EQUB    $86

                EQUS    " 1989 Acorn Computers Vn 1.50r "

                EQUB    $82,$80,$80,$80,$83

                EQUS    "Shift: screen up"

                EQUB    $20,$20,$20,$20,$20,$20,$20,$20
                EQUB    $20,$20,$20,$20,$20,$20,$20,$20
                EQUB    $20,$20,$20,$20,$20,$20,$20,$20
                EQUB    $20,$20,$20,$20,$20,$20,$20,$20
                EQUB    $20,$20

                EQUS    "Descriptive Mode"

                EQUB    $20,$20,$20,$20,$20,$20,$20,$20
                EQUB    $20,$81,$20,$8A,$20,$81

                EQUS    "Control: text startTAB performs tabulation controlled by shift T"
                EQUS    "AB.      "

                EQUB    $82,$80,$90,$80,$8D,$80,$90,$80
                EQUB    $83

                EQUS    "Shift: word l/r  COPY deletes the character above the cursor.   "
                EQUS    "       "

                EQUB    $81,$20,$87,$8C,$81,$8B,$88,$20
                EQUB    $81

                EQUS    "Control:         Shift COPY provides normal soft keys and cursor"
                EQUS    "       "

                EQUB    $84,$80,$8D,$80,$90,$80,$8D,$80
                EQUB    $85

                EQUS    "    l/r of line         copying (ESCAPE to leave this mode).    "
                EQUS    "         "

                EQUB    $81,$20,$89,$20,$81

                EQUS    "Shift: screen down Control COPY deletes the current line (to nex"
                EQUS    "t RETURN)  "

                EQUB    $84,$80,$80,$80,$85

                EQUS    "Control: text end  "

.L8C18          NOP
                RTS

.L8C1A          LDX     #$11
                STX     L007F
                LDX     #$DC
                LDY     #$07
                STX     L007D
                STY     L007E
.L8C26          CLC
                LDA     L007F
                ADC     #$80
                STA     (L007D)
; Read Character definition
; OSWORD &0A
; On entry:
;  XY?0=character
; On exit:
 ; XY+1..8=the character raster data.
                LDA     #$0A
                LDX     L007D
                LDY     L007E
                JSR     OSWORD

                SEC
                LDA     L007D
                SBC     #$08
                STA     L007D
                BCS     L8C41

                DEC     L007E
.L8C41          DEC     L007F
                BPL     L8C26

                LDX     #$7D
                LDY     #$8C
.L8C49          STX     L007D
                STY     L007E
                LDX     #$00
.L8C4F          LDA     #$17
                JSR     OSWRCH

                TXA
                CLC
                ADC     #$80
                JSR     OSWRCH

                LDY     #$00
.L8C5D          LDA     (L007D),Y
                JSR     OSWRCH

                INY
                CPY     #$08
                BNE     L8C5D

                LDA     L007D
                ADC     #$07
                STA     L007D
                BCC     L8C71

                INC     L007E
.L8C71          INX
                CPX     #$12
                BNE     L8C4F

                RTS

.L8C77          LDX     #$55
                LDY     #$07
                BRA     L8C49

                EQUB    $00,$00,$00,$FF,$00,$00,$00,$00
                EQUB    $18,$18,$18,$18,$18,$18,$18,$18
                EQUB    $00,$00,$00,$07,$0C,$18,$18,$18
                EQUB    $00,$00,$00,$E0,$30,$18,$18,$18
                EQUB    $18,$18,$0C,$07,$00,$00,$00,$00
                EQUB    $18,$18,$30,$E0,$00,$00,$00,$00
                EQUB    $7E,$C3,$9D,$B1,$9D,$C3

                EQUB    $7E,$00,$00,$18,$38,$7F,$38,$18
                EQUB    $00,$00,$00,$18,$1C,$FE,$1C,$18
                EQUB    $00,$00,$18,$18,$18,$18,$7E,$3C
                EQUB    $18,$00,$00,$18,$3C,$7E,$18,$18
                EQUB    $18,$18,$00,$00,$00,$1F,$00,$00
                EQUB    $00,$00,$00,$00,$00,$F8,$00,$00
                EQUB    $00,$00,$00,$00,$00,$FF,$18,$18
                EQUB    $18,$18,$18,$18,$18,$1F,$18,$18
                EQUB    $18,$18,$18,$18,$18,$F8,$18,$18
                EQUB    $18,$18,$18,$18,$18,$FF,$00,$00
                EQUB    $00,$00,$18,$18,$18,$FF,$18,$18
                EQUB    $18,$18

.F0             EQUS    "f0"

                EQUB    $0D

                EQUB    $8C

                EQUS    "cursor can be moved"

                EQUB    $92

                EQUS    "a new line."

                EQUB    $0D

                EQUS    "For this operation lines are"

                EQUB    $86

                EQUS    "sequences"

                EQUB    $0D

                EQUS    "ended by "

                EQUB    $8A,$2E,$EA

.SHFF0          EQUS    $07,"0"

                EQUB    $0D,$8C

                EQUS    "ends of lines can be shown as a special"

                EQUB    $0D

                EQUS    "character so that they can be seen clearly."

                EQUB    $0D

                EQUS    "This alters with each press of "

                EQUB    $87,$30,$2E,$EA

.F1             ROR     PAGELE
                ORA     L6F43
                EQUS    "Commands"

                EQUB    $92

                EQUS    "the computer's operating system can be"

                EQUB    $0D

                EQUS    "given. "

                EQUB    $8C

                EQUS    "result is seen at once. Extra commands"

                EQUB    $0D

                EQUS    "can be entered until "

                EQUB    $8A

                EQUS    " by itself is typed."

                EQUB    $EA

                AND     (VARP+1),Y
                EQUS    "Changes between Insert and Over. In Insert mode the"

                EQUB    $0D,$8E

                EQUS    " typed is inserted causing"

                EQUB    $93

                EQUS    "existing"

                EQUB    $88,$74,$6F,$0D

                EQUS    "move. In Over mode the"

                EQUB    $88

                EQUS    "is typed over old "

                EQUB    $8E,$2E,$EA

.F2             ROR     L008D
                EQUS    ", erasing"

                EQUB    $93

                EQUS    "current "

                EQUB    $8E,$8B,$EA

                STA     L6120
                EQUS    " at"

                EQUB    $93

                EQUS    "current cursor"

                EQUB    $8B,$EA

.F3             ROR     SCRUPY
                ORA     L6C41
                EQUS    "All or 'mark"

                EQUB    $92

                EQUS    "cursor'"

                EQUB    $88

                EQUS    "will be saved"

                EQUB    $92

                EQUS    "a file"

                EQUB    $8B,$EA

                ORA     L748C
                EQUS    "top and bottom"

                EQUB    $90

                EQUS    "have been removed."

                EQUB    $0D

                EQUS    "Set Top"

                EQUB    $91,$36,$0D

                EQUS    "Set Bottom"

                EQUB    $91,$37,$EA

.F4             EQUS    "f4:- Interactive Find and Replace Function."

                EQUB    $0D,$8A,$92

                EQUS    "use last f4. Special search characters are:"

                EQUB    $0D

                EQUS    "# digit, $ "

                EQUB    $8A

                EQUS    ", . any, [ ] set of char, a-z a"

                EQUB    $92,$7A,$0D

                EQUS    "~ not, * many, ^ many, | control, @ alpha"

                EQUS    ", \ literal."

                EQUB    $EA

                BIT     VARP+1,X
                EQUS    "Return"

                EQUB    $92

                EQUS    "specified language."

                EQUB    $0D

                EQUS    "The"

                EQUB    $88,$69,$6E,$93

                EQUS    "buffer will be 'transferred' into the"

                EQUB    $0D

                EQUS    "language."

                EQUB    $EA

.F5             EQUS    "f5:- Global replace.              All, or"

                EQUB    $89,$8E,$2E,$8A,$92

                EQUS    "use last f5. Special replace characters are:/"

                EQUB    $92

                EQUS    "begin"

                EQUB    $93

                EQUS    "replace section; & is"

                EQUB    $93

                EQUS    "found string"

                EQUB    $0D

                EQUS    "%n found wild section n. See f4 for find characters."

                EQUB    $EA

                AND     VARP+1,X
                STY     L6373
                EQUS    "screen mode may be set"

                EQUB    $92

                EQUS    "a specific mode. Also"

                EQUB    $0D

                EQUS    "Descriptive (D), or Key legend (K) modes may be set."

                EQUB    $0D

                EQUS    "D and K use mode 0."

                EQUB    $EA

.F6             ROR     SCRNPY
                ORA     L638C
                EQUS    "current position of"

                EQUB    $93

                EQUS    "cursor (_) is remembered."

                EQUB    $0D,$8C

                EQUS    "status line will show"

                EQUB    $93

                EQUS    "number of marks in use"

                EQUB    $0D

                EQUS    "(if any)."

                EQUB    $EA

                ROL     VARP+1,X
                EQUS    "All place marks are cleared."

                EQUB    $0D,$0D,$EA

.F7             ROR     SCRNX
                ORA     L6854
                EQUS    "The"

                EQUB    $88

                EQUS    "between two"

                EQUB    $89

                EQUS    "places is copied to"

                EQUB    $0D

                EQUS    "the current cursor position."

                EQUB    $0D,$8C

                EQUS    "marks are NOT cleared."

                EQUB    $EA

                ORA     L6854
                EQUS    "The"

                EQUB    $88

                EQUS    "between two"

                EQUB    $89

                EQUS    "places is moved to"

                EQUB    $0D

                EQUS    "the current cursor position."

                EQUB    $0D,$8C

                EQUS    "marks are then cleared."

                EQUB    $EA

.F8             ROR     SCRNY
                ORA     L778C
                EQUS    "whole"

                EQUB    $88

                EQUS    "is printed out"

                EQUB    $92

                EQUS    "the screen or printerusing"

                EQUB    $93

                EQUS    "built-in formatter/paginator."

                EQUB    $0D,$EA

                SEC
                ORA     L6854
                EQUS    "The"

                EQUB    $88

                EQUS    "between"

                EQUB    $93

                EQUS    "cursor a"

                EQUS    "nd the"

                EQUB    $89

                EQUS    "place"

                EQUB    $0D

                EQUS    "is deleted."

                EQUB    $0D,$8C

                EQUS    "mark is then cleared."

                EQUB    $EA

.F9             ROR     LNBUFX
                ORA     L6F8C
                EQUS    "old"

                EQUB    $88,$69,$6E,$93

                EQUS    "buffer is recovered after a BREAK"

                EQUB    $0D

                EQUS    "or immediately after a Clear Text (by "

                EQUB    $87

                EQUS    "9)."

                EQUB    $0D,$EA

                EQUS    "9 (ESCAPE to abandon)"

                EQUB    $0D

                EQUS    "All"

                EQUB    $88,$69,$6E,$93

                EQUS    "buffer is deleted."

                EQUB    $0D

                EQUS    "Use "

                EQUB    $87

                EQUS    "9 twice"

                EQUB    $92

                EQUS    "remove the"

                EQUB    $88

                EQUS    "beyond hope of a"

                EQUB    $0D

                EQUS    "recovery by f9."

                EQUB    $EA

.SHFTAB         EQUS    "shf-TAB"

                EQUB    $0D,$8C

                EQUS    "TAB key may be used"

                EQUB    $92

                EQUS    "move"

                EQUB    $92

                EQUS    "zones of eight"

                EQUB    $0D

                EQUS    "characters across"

                EQUB    $93

                EQUS    "screen, or"

                EQUB    $92

                EQUS    "position under"

                EQUB    $0D

                EQUS    "the first"

                EQUB    $86,$6F,$66,$93

                EQUS    "line immediately above."

                EQUB    $EA

.SHFCOP         EQUS    "shf-COPY"

                EQUB    $0D

                EQUS    "Cursor editing with"

                EQUB    $93

                EQUS    "cursor keys & COPY is enabled.User defined soft keys are availab"
                EQUS    "le as normal."

                EQUB    $0D

                EQUS    "All characters except ESCAPE are put into "

                EQUB    $8E,$2E,$EA

.inited
                ; Set up edit keys as softkeys, and set softkeys to have
                ; following bases -
                ; plain = &80
                ; shift = &90
                ; ctrl  = &A0
 
                LDA     #$04       ; Define action of cursor edit keys
                LDX     #$02       ; Set as softkeys 11-15
                JSR     OSBYTE     ; tab key pretends to be soft key 10

                LDA     #$DB       ; Read/Write ASCII code for TAB key
                LDX     #$8A
                JSR     OSBYTEwithY   ; Osbyte with Y = 0

                LDA     #$E3       ; Write Ctrl-F keys
                LDX     #$02       ; return &00,character (MOS 3.50, MOS 5 and later)
                JSR     OSBYTEwithY   ; Osbyte with Y = 0

                DEC     A          ; #$E2 - Write Shift-F keys
                LDX     #$02       ; return &00,character (MOS 3.50, MOS 5 and later)
                JSR     OSBYTEwithY   ; Osbyte with Y = 0

                LDX     #$02
.INITEX         DEC     A          ; #$E1 - Write Funtion keys
.OSBYTEwithY    LDY     #$00       ; Ignore
                JMP     OSBYTE

.initus         
                ; Return cursor-keys & softkeys to 'normal' state.
                LDA     #$DB
                LDX     #$09
                JSR     OSBYTEwithY     ; tab key emits 9

                LDA     #$04       ; Cursor Editing keys to normal
                LDX     #$00
                JSR     OSBYTE

                LDA     #$E3       ; Ctrl-F keys to normal
                LDX     #$90
                JSR     OSBYTEwithY

                DEC     A          ; #$E2 - Shift-F keys to normal
                LDX     #$80
                JSR     OSBYTEwithY

                LDX     #$01
                BRA     INITEX

.STARTTEST      
                ; Returns CS if on 1st Line (GS = TSTART), else CC.
                LDA     tstart
                CMP     GS
                LDA     tstart+1
                SBC     GS+1
                RTS

.ENDTES         
                ; Returns CS if on last line (GE + ScrimcreenY = TMAX), clse CC.
                CLC
                LDA     CURRLEN
                ADC     GE
                TAX
                LDA     #$00
                ADC     GE+1
                CPX     TMAX
                SBC     TMAX+1
                RTS

.LENGTH         
                ; find length of current line. Exit - A = length = 1
                LDY     #$00
.LECCLO         LDA     (GE),Y
                CMP     termin
                BEQ     LECCRE

                INY
                CPY     PAGEWI
                BNE     LECCLO

.LECCRE         TYA
                RTS

.CHECKR         
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
                JMP     CHNRRERR        ; 'No room'

.CURON          LDY     #$01
                BRA     VDU231

.CUROFF         LDY     #$00
.VDU231         LDX     #$01
.VDU23          
                ; Entry - X = 1st byte, Y = 2nd byte
                ; Exit  - VDU 23,X,Y,0,0,0,0,0,0,0 Output.

                LDA     #$17
                JSR     CSRXY0

                LDX     #$08
                LDA     #$00
.VDUnext        JSR     OSWRCH

                DEX
                BNE     VDUnext

.VDU23X         RTS

.intpag         LDA     options
                AND     #$07
                CMP     #$02
                BEQ     KEYONL

                CMP     #$05
                BEQ     KEYONL

                BRA     NOTTUT

.CLEARSCREEN    LDA     options
                AND     #$07
                CMP     #$02
                BEQ     DOTUT

                CMP     #$05
                BNE     NOTTUT

.DOTUT          PHA
                JSR     VSTRNG

                EQUB    $1A,$1E,$EA

.L964F          JSR     startI

                JSR     L8C1A

                JSR     BIGMESS

                PLA
                CMP     #$02
                BEQ     L9660

                JSR     BIGMET

.L9660          JSR     L8C77

.KEYONL         JSR     stopin
                JSR     GETWIN          ; get size of total scren
                STA     REALPA          ; pagelength in A
                JSR     DECWIN

.NOTTUT         JSR     GETWIN          ; get size of working area
                TAX                     ; pagelength again in A
                INX                     ; Initalize scrim.
                LDA     PAGEWI
.SCMILO         STA     SCRIM,X
                DEX
                BPL     SCMILO

                JSR     STATUS

                STZ     SCRNPY
                RTS

.GETWIN         LDA     #$A0            ; Read VDU Variable
                LDX     #$0A            ; Current Text window right hand column
                JSR     OSBYTE

                STX     PAGEWI
                STY     PAGELE
                LDX     #$08            ; Current text window left hand column
                JSR     OSBYTE

                TYA
                CLC
                SBC     PAGELE
                STA     PAGELE
                RTS

.DECWIN         LDA     options
                AND     #$07
                LDY     #$0E
                CMP     #$05
                BEQ     WINDOW

                LDY     #$07
                CMP     #$02
                BNE     NOWIND

.WINDOW         JSR     VSTRNG

                EQUB    $1C,$00,$EA

.L96AE          LDA     REALPA
                INC     A
                JSR     OSWRCH

                LDA     PAGEWI
                JMP     OSWRCHPLUSY

.NOWIND         LDA     #$1A
                JMP     OSWRCH

.EDRDCH         ; Exit - A holds character read 
                LDA     NEXTREADFLAG
                BEQ     EDRDOSRD

                LDA     NXTCHR
                STZ     NEXTREADFLAG
                BNE     L96CA

.L96C8          TSX
                RTS

.L96CA          LDX     L0080
                RTS

.EDRDOSRD       JSR     IndOSRDCH

                TAX
.L96D1          BNE     L96DC

                JSR     IndOSRDCH

                CMP     #$00
                BEQ     L96C8

                LDX     #$00
.L96DC          RTS

.newtxcont      LDA     #$81      ; Read Key within time limit
                TAX
                LDY     #$03
                JSR     OSBYTE

                TYA
                BNE     WasEscPressed     ; Key was not pressed in time

                TXA
                BRA     L96D1

.WasEscPressed  JSR     escTST    ; Was Escape pressed?

                LDA     #$00
                TAX
                RTS

.MODIFY         LDA     #$01
                LDX     MODFLG
                STA     MODFLG
                CPX     #$01
                BNE     STATUS

                RTS

.IOtogg         LDA     #$10
                BRA     L9703

.tabctl         LDA     #$08
.L9703          JSR     pre-domode

.CstatU         STZ     UPDATE              ; update required 
.STATUS         JSR     CSR0STATUSY         ; Output status on status line.
                JSR     startI              ; Start inverse
                JSR     TESTIF
                BEQ     STATSO

                JSR     VSTRNG
                EQUS    "Insert "
                EQUB    $EA
.L971E          BRA     STATSI

.STATSO         JSR     VSTRNG
                EQUS    "Over   "
                EQUB    $EA

.STATSI         LDX     cursed
STRMEX = STATSI+1
                BEQ     STATSC

                JSR     VSTRNG

                EQUS    "     Cursor Editing"

                EQUB    $EA

.L9746          BRA     STATSX

.STATSC         LDA     MARKX
                BEQ     STATST

                DEC     A
                BNE     STATSM

                JSR     VSTRNG

                EQUS    "One mark "

                EQUB    $EA

.L975C          BRA     STATSS

.STATSM         JSR     VSTRNG

                EQUS    "Two marks"

                EQUB    $EA

.L976B          BRA     STATSS

.STATST         LDA     #$08
                AND     options
                BNE     STATTW

                JSR     VSTRNG

                EQUS    "TAB cols "

                EQUB    $EA

.L9780          BRA     STATSS

.STATTW         JSR     VSTRNG

                EQUS    "TAB words"

                EQUB    $EA

.STATSS         LDA     MODFLG
                DEC     A
                BMI     Original

                BNE     STATMO

                JSR     VSTRNG

                EQUS    " Modified "

                EQUB    $EA

.L97A4          BRA     STATSX

.STATMO         JSR     VSTRNG

                EQUS    " Discarded"

                EQUB    $EA,$80,$0E

.Original       JSR     VSTRNG

                EQUS    " Original "

                EQUB    $EA

.STATSX         LDA     options
                AND     #$40
                BEQ     STATcr

                JSR     VSTRNG
                EQUS    " LF"
                EQUB    $EA

.L97D1          BRA     STATlf

.STATcr         JSR     VSTRNG
                EQUS    " CR"
                EQUB    $EA

.STATlf         LDX     #$1D
                STX     PRMPTL
                JSR     stopin  ; stop inverse

                LDY     PAGELE
                INY
                LDA     #$1C    ; (PRMPTL - 1 + $prmod) plus any modifications
                JMP     WIPETA  ; and clear the rest of the line

.promtF         JSR     prompt

                EQUS    "Type filename "

                EQUB    $EA

.L97FC          BRA     L980C

.prompt         LDY     PAGELE
                INY
                JSR     WIPELINE

                LDX     #$00
.PRMPTX         LDY     PAGELE
                INY
                JSR     CSRXY

.L980C          LDX     #$01
                BRA     STRMFL

.STRIMO         LDX     #$00
.STRMFL         JSR     startI

                PLA
                STA     STRING
                PLA
                STA     STRING+1
                JSR     VSTRLP

                JSR     stopin

                TXA
                BEQ     L982C

                LDA     PAGEWI
                DEC     A
                LDY     PAGELE
                STA     SCRIM+1,Y
.L982C          JMP     (STRING)

.CSRSCR         LDX     SCRNX
                LDY     SCRNY
                BPL     CSRXY

.CSR0STATUSY    LDY     PAGELE
                INY
.CSR0Y          LDX     #$00
.CSRXY          LDA     #$1F
.CSRXY0         JSR     OSWRCH

                TXA
.OSWRCHPLUSY    JSR     OSWRCH

                TYA
                JMP     OSWRCH

.NORMAL         
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
                SBC     #$00
                TAY
                JMP     GPBKXY

.FINDPO         
                ; Entry : temp-> middle of line in 1st half of text
                ; Exit  : A[Z]  = xcoord (0..page..width) of pointer within line.
                ;         Y(=atemp) = page_width - A  
                CLC     ; -1
                LDA     TEMP
                SBC     PAGEWI
                STA     TEMP
                BCS     FIPOND

                DEC     TEMP+1
.FIPOND         LDY     PAGEWI
.FIPOLP         LDA     (TEMP),Y
                CMP     termin
                BEQ     FIPOL2

.FIPOE2     
                ; Entry point, when called from tempbacklines.
                DEY
                BPL     FIPOLP
                BMI     FINDPO

.FIPOL2         STY     ATEMP
                SEC
                LDA     PAGEWI
                SBC     ATEMP
                RTS

.TPGEFD         
                ; TP := GE + A lines
                LDX     GE
                LDY     GE + 1
                STX     TP
                STY     TP + 1

.TPFWDA         
                ; Moves pointer TP forward A lines.
                ; Entry - A = No. of lines to advance TP
                ; Exit  - TP advanced (possibly by less than A lines if hit EOT)
                ;         count = No. of lines remaining from original request.
                ;         atemp = Last end of line character.
                TAX
                STX     COUNT
                BEQ     TPTPEX

.TPTPLP         LDY     #$FF
.TPTPSE         INY
                LDA     (TP),Y
                CMP     termin
                BEQ     TPTPFD

                CPY     PAGEWI
                BNE     TPTPSE

.TPTPFD         STA     ATEMP
                TYA
                JSR     TPPAP1

                BCS     TPTPEX

                DEC     COUNT
                BNE     TPTPLP

.TPTPEX         RTS

.TPPAP1         
                ; Exit  -  CC TP = TP  +  (A + 1). CS TP + (A + 1) = HYMEM,
                ;          TP unchanged.
                SEC
                ADC     TP
                TAX
                LDA     #$00
                ADC     TP + 1
                TAY
                CPX     HYMEM
                SBC     HYMEM + 1
                BCS     TPPAPX

                STX     TP
                STY     TP + 1
.TPPAPX         RTS

.TPGSBK         
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

                LDX     #$00
.TPXYLP         LDA     tstart
                CMP     TP
                LDA     tstart + 1
                SBC     TP + 1
                BCS     TPXYAB

                CLC     ; - 1
                LDA     TP
                SBC     PAGEWI
                STA     TP
                BCS     TPXYND

                DEC     TP + 1
.TPXYND         LDY     PAGEWI
                LDA     (TP),Y
                CMP     termin
                BNE     TPXYCO

                LDA     TP
                STA     TEMP
                LDA     TP+1
                STA     TEMP+1
                JSR     FIPOE2

                BEQ     TPXYCO

                TYA                     ; answer from FINDPO in Y
                ADC     TP              ; + 1 from CS
                STA     TP
                BCC     TPXYCO

                INC     TP+1
.TPXYCO         INX
                CPX     COUNT
                BCC     TPXYLP

.TPXYAB         TXA
.TPXYEX         RTS

.PAGEUP         LDA     PAGELE
                INC     A
.MVLNBK         
                ; Entry - A = No. of lines to move gap back.
                ; Exit  - Gap moved back A lines. May be moved less if
                ;         hits start of file.
                JSR     TPGSBK
                LDX     TP
                LDY     TP + 1
.GPBKXY         
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
.COPYFD
                ; Copy block forward (i.e. to higher address).
                ; Entry - ARGP --> block of size XY
                ;         VARP --> destination address 
                ; Exit  - ARGP,VARP uncorrupted.
                STX     SIZE
                STY     SIZE + 1
.CPFD2          LDA     SIZE
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

.CPFDLP         LDA     (ARGP),Y
                STA     (VARP),Y
.CPFDL2         DEY
                CPY     #$FF
                BNE     CPFDLP

                DEX
                BEQ     CPFDEX

                DEC     ARGP + 1
                DEC     VARP +  1
                BNE     CPFDLP

.CPFDEX         RTS

.PAGEDN         LDA     PAGELE
                INC     A
.MVLNFD         JSR     TPGEFD

.GPFDTP         LDX     TP
                LDY     TP + 1
.GPFDXY         
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
                SBC     GE+1
                TAY
                CLC
                TXA
                ADC     GS
                STA     GS
                TYA
                ADC     GS+1
                STA     GS+1
                TXA
                ADC     GE
                STA     GE
                TYA
                ADC     GE+1
                STA     GE+1
                JMP     COPYBK

.FINEPO         
        ; Entry - Gap line positioned, without VS in text.
        ; Exit  - Gap character positioned, with VS added.
                JSR     ADDVIR
                CLC
                LDA     GE
                ADC     SCRNX
                TAX
                LDA     GE + 1
                ADC     #$00
                TAY
                BRA     GPFDXY

.ADDVIR         JSR     VSCOUN

                BEQ     ADVSEX

                PHA
                TAX
                LDA     CURRLEN
                JSR     INSRTX
                ; Wipe possible visible TERMIN.
                LDX     CURRLEN
                LDY     SCRNY
                JSR     CSRXY

                LDA     #$20
                JSR     OSWRCH

                PLX     ; number spaces from VSCOUN
                LDY     SCRNX
.ADVSLP         DEY
                STA     (GE),Y
                DEX
                BNE     ADVSLP

.ADVSEX         JMP     CSRSCR

.VSCOUN         
                ; Exit A(Z) = Number of virtual spaces.
                SEC
                LDA     SCRNX
                SBC     CURRLEN
                BCS     VSCTEX

                LDA     #$00
.VSCTEX         RTS

.INSRTX         
                ; Entry - Require gap of XY ( > 0) opening up after GE  +  A
                ; Exit  - GE -= XY (checked against GS)
                ;         A chars moved back to new GE, to open up gap
                STA     ATEMP
                CLC
                ADC     GE
                PHA
                LDA     GE+1
                ADC     #$00
                PHA
                PHX
                LDY     #$00
                JSR     CHECKR

                LDY     #$00
.INSXLP         LDA     (GE),Y
                STA     (TEMP),Y
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
.INSXMK         DEY
                BMI     INSXEX

                LDX     SMATLO,Y
                CPX     TEMP
                LDA     SMATHI,Y
                SBC     TEMP+1
                BCS     INSXMK

                SEC
                TXA
                SBC     COUNT
                STA     SMATLO,Y
                LDA     SMATHI,Y
                SBC     #$00
                STA     SMATHI,Y
                BRA     INSXMK

.INSXEX         RTS

.TABKEY         LDA     #$08
                BIT     options
                BNE     TABSTR

.TABPOS         INC     SCRNX
                LDA     SCRNX
                AND     #$07
                BNE     TABPOS

                LDA     SCRNX
                CMP     PAGEWI
                BCC     TABX

                STZ     SCRNX
                BRA     TABX

.TABSTR         LDA     #$01
                JSR     TPGSBK

                CMP     #$01
                BNE     INSXEX

                LDY     SCRNX
                DEY
.TABS1          INY
                CPY     PAGEWI
                BCS     TABSSP

                LDA     (TP),Y
                CMP     termin
                BEQ     TABSSP

                CMP     #$20
                BNE     TABS1

                BRA     TABS2

.TABSSP         LDY     #$FF
.TABS2          INY
                CPY     PAGEWI
                BCS     TABSEX

                LDA     (TP),Y
                CMP     #$20
                BEQ     TABS2

.TABSEX         STY     SCRNX
.TABX           STZ     UPDATE
.RELANX         RTS

.retlan         JSR     prompt

                EQUS    "Type language name:"

                EQUB    $EA

.L9A89          JSR     READLS

                BEQ     RELANX

                LDY     #$00
.RELAPL         LDA     LINBUFF,Y
                INY
                CMP     #$0D
                BNE     RELAPL

                STA     LINBUFF+1,Y
                LDA     #$20
                STA     oldsta+3,Y
                LDA     #$40
                STA     LINBUFF,Y
                LDA     #$06
                STA     UPDATE
                JSR     STFILE

                LDA     GE+1
                DEC     A
                CMP     PAJE + 1
                BCS     RETLOK

                BRK
                EQUB    $02

                EQUS    "Not enough space to return to language"

                EQUB    $00

.RETLOK         LDA     #$FF
                STA     BRKACT          ; pretty leathal break action rqd
                LDA     PAJE + 1
                INC     A
                STA     ARGP + 1
                STZ     ARGP
                LDA     #$00
                STA     (TMAX)          ; terminating zero
                LDA     GE
                STA     ADDR
                LDA     GE + 1
                STA     ADDR + 1
.RELLOP         LDA     (ADDR)
                STA     (ARGP)
                INC     ARGP
                BNE     RELLOQ

                INC     ARGP+1
.RELLOQ         INC     ADDR
                BNE     RELLOP
                INC     ADDR + 1
                LDA     ADDR + 1
                EQUB    $09             ; Is this right??? TODO

                CMP     HYMEM + 1
                BNE     RELLOP
                JSR     CURON
                JSR     VSTRNG
                EQUB    $1A
                EQUB    $0C,$EA
.L9B12          JSR     initus
                LDA     PAJE + 1
                INC     A
                STA     STRING + 1   ; set 0 to PAGE + 256
                STZ     STRING
                LDX     #$00            ; LINBUF
                LDY     #$05            ; /LINBUF 
                JMP     OSCLI

.PRINHL         JSR     LA0FE

.L9B26          EQUB    $0E
                EQUB    $0D,$0D
                EQUS    "Format commands:- {initial values}"
                EQUB    $0D,$83
                EQUS    "afrn assign format n to register r {0}"
                EQUB    $83
                EQUS    "anrn assign number to register r {0}"
                EQUB    $83,$62,$6C,$81
                EQUS    "bold"
                EQUB    $84,$83,$62,$70,$81
                EQUS    "begin"
                EQUB    $85,$83
                EQUS    "cc c control"
                EQUB    $86
                EQUS    "is c {.}"
                EQUB    $83,$63,$65,$81
                EQUS    "centre"
                EQUB    $84,$83
                EQUS    "ch*c chain in next file"
                EQUB    $83,$63,$6F,$81
                EQUS    "comment"

                EQUB    $84,$83

                EQUS    "dmcc define macro to .en"

                EQUB    $83,$64,$73,$81

                EQUS    "double space"

                EQUB    $84,$73,$83,$65,$66,$81,$8F,$85

                EQUS    "foot"

                EQUB    $80,$65,$68,$81,$8F,$85

                EQUS    "head"

                EQUB    $80,$65,$6E,$81

                EQUS    "end of .at, .ix or .ef etc"

                EQUB    $83,$65,$70,$81

                EQUS    "begin "

                EQUB    $8F,$85,$83,$66,$66,$81

                EQUS    "form feed"

                EQUB    $93

                EQUS    "printer, wait if paged mode"

                EQUB    $83,$66,$6F,$81,$8F

                EQUS    " and odd foot"

                EQUB    $80,$68,$65,$81,$8F

                EQUS    " and odd head"

                EQUB    $80,$69,$63,$81

                EQUS    "close indexfile"

                EQUB    $83,$69,$67,$81

                EQUS    "ignore input until .en"

                EQUB    $83

                EQUS    "in+- indent left margin n places {0}"

                EQUB    $83

                EQUS    "io*c open indexfile for output"

                EQUB    $83,$69,$78,$81

                EQUS    "send"

                EQUB    $88

                EQUS    "to indexfile until .en"

                EQUB    $83,$6A,$75,$81

                EQUS    "justify right margin of"

                EQUB    $84

                EQUS    "s {on}"

                EQUB    $83

                EQUS    "ll+-"

                EQUB    $84

                EQUS    " length including indent {76}"

                EQUB    $83

                EQUS    "ls+-"

                EQUB    $84

                EQUS    " spacing is n {1}"

                EQUB    $83

                EQUS    "lv n leave n blank"

                EQUB    $84

                EQUS    "s (by .ne n and .sp n)"

                EQUB    $83

                EQUS    "ne n needs n output"

                EQUB    $84

                EQUS    "s, .bp if necessary"

                EQUB    $83,$6E,$6A,$81

                EQUS    "no justification of"

                EQUB    $84,$73,$83,$6E,$6E,$81

                EQUS    "no new"

                EQUB    $84

                EQUS    " after this"

                EQUB    $84,$83,$6F,$66,$81

                EQUS    "odd"

                EQUB    $85

                EQUS    "foot"

                EQUB    $80,$6F,$68,$81

                EQUS    "odd"

                EQUB    $85

                EQUS    "head"

                EQUB    $80,$6F,$70,$81

                EQUS    "begin odd"

                EQUB    $85,$83

                EQUS    "os*c call operating system with this string"

                EQUB    $83

                EQUS    "pl+-"

                EQUB    $88

                EQUS    "area length is n"

                EQUB    $84,$73,$20,$7B,$35,$38,$7D,$83

                EQUS    "po+-"

                EQUB    $85

                EQUS    "offset is n {0}"

                EQUB    $83,$72,$66,$81

                EQUS    "right flush this"

                EQUB    $84,$83

                EQUS    "sp n insert n blank"

                EQUB    $84,$73,$83,$73,$73,$81

                EQUS    "single space"

                EQUB    $84,$73,$83,$74,$61,$81

                EQUS    "define tabs {8,16,24,...,96}"

                EQUB    $83

                EQUS    "tcc  define tab"

                EQUB    $86

                EQUS    "as c {ctrl I}"

                EQUB    $83

                EQUS    "ti+- temporary indent n"

                EQUB    $83

                EQUS    "trcc translate {NBSP is space}"

                EQUB    $83,$75,$6C,$81

                EQUS    "underline"

                EQUB    $84,$0D,$0D

                EQUS    "n represents a decimal number, 0 is used if not present"

                EQUB    $0D

                EQUS    "Spaces are allowed before n. c represents any"

                EQUB    $86,$0D

                EQUS    "+- allows n, +n or -n: .in+2 sets an indent 2 more than current"

                EQUB    $83

                EQUS    "ti+2 is a temporary indent of 2 more than"

                EQUB    $93

                EQUS    "current indent"

                EQUB    $0D,$0D

                EQUS    "Formatting commands which can appear anywhere"

                EQUB    $0D,$83,$62,$62,$81

                EQUS    "begin bold"

                EQUB    $83,$62,$75,$81

                EQUS    "begin underline"

                EQUB    $83,$65,$62,$81

                EQUS    "end bold"

                EQUB    $83,$65,$75,$81

                EQUS    "end underline"

                EQUB    $83,$6F,$63,$82

                EQUS    "counted as 1"

                EQUB    $86,$83,$6F,$6E,$82

                EQUS    "without being counted"

                EQUB    $83

                EQUS    "r0-9 contents of register e.g. .r0"

                EQUB    $0F,$0D,$0D,$EA

.LA0F8          JSR     INKEYS
                JMP     EDITco

.LA0FE          PLA
                STA     ANOTHSTRING
                PLA
                STA     ANOTHSTRING+1
                JSR     LA10D
                JMP     (ANOTHSTRING)

.LA10A          JSR     LA11A

.LA10D          INC     ANOTHSTRING
                BNE     LA113

                INC     ANOTHSTRING+1
.LA113          LDA     (ANOTHSTRING)
                CMP     #$EA
                BNE     LA10A

                RTS

.LA11A          CMP     #$A0
                BCS     LA122

                CMP     #$80
                BCS     LA125

.LA122          JMP     OSASCI

.LA125          PHY
                PHX
                LDY     #$FF
                EOR     #$80
                TAX
                BEQ     LA137

.LA12E          INY
                LDA     LA145,Y
                BNE     LA12E

                DEX
                BNE     LA12E

.LA137          INY
                LDA     LA145,Y
                BEQ     LA142

                JSR     LA11A

                BRA     LA137

.LA142          PLX
                PLY
                RTS

.LA145          EQUB    $20

                EQUS    "title"

                EQUB    $92

                EQUS    ".en"

                EQUB    $83,$00,$20,$20,$20,$00

                EQUS    " n output CHR$(n)"

                EQUB    $92

                EQUS    "printer "

                EQUB    $00,$0D,$2E,$00

                EQUS    " line"

                EQUB    $00

                EQUS    " page "

                EQUB    $00

                EQUS    " character "

                EQUB    $00

                EQUS    "shf-f"

                EQUB    $00

                EQUS    " text "

                EQUB    $00

                EQUS    " marked "

                EQUB    $00

                EQUS    "RETURN"

                EQUB    $00,$2E,$0D,$8A

                EQUS    " uses"

                EQUB    $93

                EQUS    "name at the start of"

                EQUB    $88

                EQUS    "after a '>'"

                EQUB    $0D

                EQUS    "COPY, "

                EQUB    $8A,$92

                EQUS    "use"

                EQUB    $93

                EQUS    "current file name."

                EQUB    $00

                EQUS    "The "

                EQUB    $00,$32,$0D,$41,$88

                EQUS    "file will be loaded"

                EQUB    $00

                EQUS    "text"

                EQUB    $00

                EQUS    "even"

                EQUB    $00

                EQUS    " scroll margins "

                EQUB    $00,$90

                EQUS    "with ctrl-f"

                EQUB    $00

                EQUS    " to "

                EQUB    $00

                EQUS    " the "

                EQUB    $00

.LA242          PHA
                LSR     A
                LSR     A
                LSR     A
                LSR     A
                JSR     LA24B

                PLA
.LA24B          AND     #$0F
                SED
                CMP     #$0A
                ADC     #$30
                CLD
                JMP     OSWRCH

.PRINASIS       JSR     STFILE

                JSR     MovWrdGEtoTP

                JSR     rstPrtDes

                LDA     #$02
                STA     BRKACT
.LA263          JSR     escTST

                LDA     (TP)
                CMP     termin
                BNE     LA26E

                LDA     #$0D
.LA26E          JSR     OSASCI

                LDA     #$00
                JSR     TPPAP1

                BCC     LA263

                LDA     #$03
                JSR     OSWRCH

                JMP     EDITco

.PRINTH         JMP     PRINHL          ; help on print 

.PRINT          JSR     MKREFUSE

                LDX     #$FF
                STX     PWTFLG
                STX     PRTFLG          ; bit 7 printer, bit 6 pay attention to bold/underlining 
                STX     LINEOT          ; set needs header flag
                TXS
                JSR     prompt

                EQUS    "Screen, Printer, As is, Help ?"
                EQUB    $EA

.PRINTL         JSR     GETRESP
                CMP     "a"
                BEQ     PRINASIS

                CMP     "h"
                BEQ     PRINTH

                CMP     "s"
                BEQ     PRINTS

                CMP     "p"
                BNE     PRINTL      
                STZ     PRTFLG          ; 0 for printer
.PRINTS         JSR     prompt
                EQUS    "Continuous, Paged ?"
                EQUB    $EA

.PRINTM         JSR     GETRESP

                CMP     "c"
                BEQ     PRINTC

                CMP     "p"
                BNE     PRINTM

                STZ     PWTFLG          ; 0 for paged output
.PRINTC         JSR     memstate

                LDA     tstart
                STA     ADDR
                LDA     tstart+1
                STA     ADDR+1
                LDA     #$2E
                STA     CTLCHA
                LDX     #$00
.CLRREG         STZ     noregs,X   ; noregs(linbuff)  : clears noregs, tablst, maclst
                INX
                TXA
                STA     trnlst,X   ; trnlst(stracc) : init translation
                BNE     CLRREG

                LDA     space
                STA     L06A0       
                LDY     termin
                CPY     #$0D
                BNE     LA315

                STA     L060A
                BRA     LA318

.LA315          STA     L060D
.LA318          LDA     #$09
                STA     mark_count ; tabcha(mark_count)
                DEC     A          ; to 8
                CLC
.DEFTAB         STA     TABLST,X
                INX
                ADC     #$08    ; carry clear
                CMP     #$64
                BCC     DEFTAB
                LDA     #$02
                STA     BRKACT
                DEC     A
                STA     LINBUFF   ; LINBUFF(PAGE) : A = 1
                STA     UMATHI+1  ; single spacing
                STA     LINENO   
                STZ     LINE      ; no indexing LINE(DOINDX)
                STZ     INDEXH    ; index file handle
                STZ     UMATLO+1  ; persistent underline off UMATLO+1(PUNDRL)
                STZ     PBOLD     ; persistent bold off
                STZ     SMATHI+1  ; turn off indent : SMATHI+1(INDENT)
                STZ     FILL      ; enable justification
                STZ     OFFSET    ; no page offset
                STZ     SMATLO+1  ; no overprinting : SMATHLO+1(LINFED)
                LDA     #$3A      ; 58
                STA     LINEDW    ; lines per page
                LDA     #$4C      ; 76
                STA     SMATHI    ; characters per line : SMATHI(LEN)
                JSR     VSTRNG
                EQUB    $1A,$0C,$EA

.LA353          BIT     PRTFLG
                BMI     PATCHA
                JSR     rstPrtDes

.PATCHA         BIT     PWTFLG
                BMI     CHAINB

                BIT     PRTFLG
                BPL     CHAINB

                LDA     #$0E
                JSR     OSWRCH    ; page mode if screen and wait

.CHAINB         LDA     termin
                STA     (GS)
                LDX     #$98
                LDY     #$A0
                CMP     #$0D
                BEQ     LA377

                LDX     #$B8
                LDY     #$C0
.LA377          STX     PAGEEH
                STX     PAGEOH
                STY     PAGEEF
                STY     PAGEOF
                LDY     #$BE
                STY     PAGEEH+1
                STY     PAGEOH+1
                STY     PAGEEF+1
                STY     PAGEOF+1
                LDX     #$D0
.CHAINC         STZ     L052F,X    ; L052F(MACLST-1)
                DEX
                BNE     CHAINC

.FINE           STZ     CENTRE     ; turn centre off
                STZ     SMATLO     ; turn right-flush off
                LDA     #$FF
                STA     TINDEN     ; no temp indent
                LDA     UMATLO+1   ; UMATHLO+1 (PUNDRL)
                STA     UMATLO     ; UMATHLO (UNDERL)
                STA     UNDRRQ     ; underline required?
                LDA     PBOLD
                STA     UMATHI     ; UMATHI (BOLD)
                STA     BOLDRQ
                BRA     CTLIN

.LASLEN         JSR     ROUTEBP
                BIT     PRTFLG     ; print exit
                BPL     DODWN

                JSR     STRIMO
                EQUS    "Print done. "
                EQUB    $EA,$20,$05,$AC

.DODWN          JSR     VSTRNG
                EQUB    $03,$0F,$EA

.LA3CF          JSR     closeX
                LDX     GS
                LDY     GS+1
                JMP     EDITgs

.CTLLMT         LDY     #$03       ; found built in cmd
                JSR     CTLLDO

.CTLLMX         JSR     SPACEY
                DEY
                CLC
                JSR     YADP
                LDA     (ADDR)
                CMP     CTLCHA
                BEQ     CTLIN1

                LDY     #$00
.CLCTLI         JSR     ROUTCO

                SEC
                JSR     YADP

.CTLIN          LDA     ADDR+1
                STA     XEFF       ; set nojust(local) by <>
                CMP     #$A3       ; / CTLIN
                BCS     CTLIN1
                LDX     ADDR
                CPX     GS
                SBC     GS+1
                BCS     LASLEN

.CTLIN1         LDA     (ADDR)
                CMP     CTLCHA
                BNE     LINLYX
                LDX     #$00       ; main control scan
                LDY     #$02
                LDA     (ADDR),Y
                STA     TEMP+1
                DEY
                LDA     (ADDR),Y
.CTLLLP         CMP     CMDS,X    ; CMDS
                BNE     CTLLLL
                LDY     CMDS+1,X
                CPY     TEMP+1
                BEQ     CTLLMT

.CTLLLL         INX
                INX
                INX
                INX
                CPX     #$AC
                BNE     CTLLLP

                JSR     MACCHK

                BCC     LINLYX

                LDA     ADDR
                PHA
                LDA     ADDR+1
                PHA
                LDA     CTLCHA
                PHA
                LDA     (scratc+$0A)
                STA     CTLCHA
                LDA     scratc+$0A
                STA     ADDR
                LDA     scratc+$0B
                STA     ADDR+1
                LDY     #$02
                JSR     CLCTLI

                PLA
                STA     CTLCHA
                PLA
                STA     ADDR+1
                PLA
                STA     ADDR
                LDY     #$03
                BRA     CTLLMX

.LINLYX         LDA     LINEOT
                INC     A
                BNE     NOHDR
                JSR     DOHDR

.NOHDR          LDA     SMATHI     ; SMATHI (LEN)
                LDY     TINDEN
                INY
                SEC
                BEQ     SBCLEN
                SBC     TINDEN     ; take off temp indent
                BRA     GOTLEN

.SBCLEN         SBC     SMATHI+1   ; SMATHI+1(INDENT)
.GOTLEN         STA     JUSLEN
                LDY     #$00
                LDX     #$00
                STZ     SPACES     ; initalise spaces encountered
                STZ     LASTTAB    ; initalise start of spacing out
.LINLEN         CPY     #$FA
                BCS     LENFNE
                JSR     IGNCTL     ; main char count

                CMP     termin
                BEQ     LENFNE

                CMP     mark_count ; mark_count(TABCHA)
                BNE     NOTTAB

                TXA
                LDX     #$FF
.LOKTAB         INX
                PHA
                LDA     TABLST,X
                BEQ     NOTAB

                PLA
                CMP     TABLST,X
                BCS     LOKTAB

                PHA
                LDA     TABLST,X
                PLX
                INY
                CMP     JUSLEN
                BCS     NOTAB2

                TAX
                STX     LASTSP
                STX     LASTTAB
                STZ     SPACES
                BRA     NOSP2

.NOTAB          PLX
                LDA     " "
.NOTTAB         CMP     " " 
                BNE     NOSP
                STX     LASTSP
                INC     SPACES
.NOSP           INX
                INY
.NOSP2          CPX     JUSLEN
                BCC     LINLEN

.NOTAB2         JSR     IGNCTL

                CMP     " " 
                BEQ     LENFNA

                CMP     mark_count ; mark_count(TABCHA)
                BEQ     LENFNA
                CMP     termin
                BEQ     LENFNA
                LDA     SPACES
                BEQ     LENFNA
                LDX     LASTSP
                DEC     SPACES
.LENFNA         DEX
                STZ     XEFF
.LENFNE         INX
                STX     COUNT     ; X, Y free
                BIT     PRTFLG
                BPL     DODW
                JSR     DOSCRE
                BRA     LINCTL

.DODW           LDA     #$40
                TSB     PRTFLG    ; no underline first time
                LDA     UMATLO    ; UMATLO(UNDERL)
                PHA
                JSR     WRITE
                PLA
                STA     UMATLO    ; UMATLO(UNDERL)
                BIT     UNDRRQ
                BPL     LINCTL
                LDA     #$40      ; no do underline
                TRB     PRTFLG
                JSR     DOSCRE
                STZ     UMATLO    ; UMATLO(UNDERL)
.LINCTL         BIT     SMATLO+1  ; SMATLO+1(LINFED)
                BMI     FINSEN
                LDX     UMATHI+1  ; UMATHI+1(VSPACE)
.LINSCT         JSR     LFWRCH    ; ready for next line
                LDA     LINEOT
                INC     A
                BEQ     FINSEN
                DEX
                BNE     LINSCT

.FINSEN         STZ     SMATLO+1  ; back on, for next line : SMATLO+1(LINFED)
                JSR     SPACEY
                CMP     termin
                BEQ     NICEDL
                DEY
.NICEDL         CLC
                JSR     YADP

                JMP     FINE

.SPACEY         LDA     (ADDR),Y
                INY
                BEQ     SPACER
                CMP     " "
                BEQ     SPACEY

.SPACER         RTS

.IGNCTL         LDA     (ADDR),Y   ; count routine
                CMP     CTLCHA
                BNE     NOCTRL
                INY
                LDA     (ADDR),Y
                CMP     "b"
                BEQ     WSCTRB
                CMP     "o"
                BEQ     WSCTRO
                CMP     "r"
                BEQ     WSCTRR
                CMP     "e"
                BNE     NORECG

.WSCTRB         INY
                LDA     (ADDR),Y
                CMP     "b"
                BEQ     WSCTRL
                CMP     "u"
                BNE     NORECF

.WSCTRL         INY
                BRA     IGNCTL

.WSCTRO         INY
                LDA     (ADDR),Y
                CMP     "n"
                BEQ     WSCTON
                CMP     "c"
                BNE     NORECF
                INX
.WSCTON         PHX
                INY
                JSR     GETNO

                PLX
                BRA     IGNCTL

.WSCTRR         INY
                LDA     (ADDR),Y
                CMP     " "
                BCC     NORECF
                CMP     #$3A
                BCS     NORECF
                JSR     DECCON
                BRA     WSCTRL

.NORECF         DEY
.NORECG         DEY
                LDA     (ADDR),Y
.NOCTRL         RTS

.WASCTL         INY
.CHKCTL         LDA     (ADDR),Y   ; print routine
                CMP     CTLCHA
                BNE     NOCTRL
                INY
                LDA     (ADDR),Y
                CMP     "b"
                BEQ     WASCTB
                CMP     "o"
                BEQ     WASCTO
                CMP     "r"
                BEQ     WASCTR
                CMP     "e"
                BNE     NORECG
                INY
                LDA     (ADDR),Y
                CMP     "b"
                BEQ     WASCTEB
                CMP     "u"
                BNE     NORECF
                STZ     UMATLO+1    ; UMATLO+1(PUNDRL)
                STZ     UMATLO      ; UMATLO(UNDERL)
                BRA     WASCTL

.WASCTEB        STZ     PBOLD
                STZ     UMATHI
                BRA     WASCTL

.WASCTB         INY
                LDA     (ADDR),Y
                CMP     "b"
                BEQ     WASCTA
                CMP     "u"
                BNE     NORECF

                LDA     #$FF
                STA     UMATLO     ; UMATLO(UNDERL)
                STA     UMATLO+1   ; UMATLO+1(PUNDRL)
                STA     UNDRRQ
                BRA     WASCTL

.WASCTA         LDA     #$FF
                STA     PBOLD
                STA     BOLDRQ
                STA     UMATHI
                BRA     WASCTL

.WASCTO         INY
                LDA     (ADDR),Y
                CMP     "n"
                BEQ     WASCON
                CMP     "c"
                BNE     NORECF
                INX
.WASCON         PHX
                INY
                JSR     GETNO
                LDA     #$01
                JSR     OSWRCH
                TXA
                JSR     OSWRCH
                PLX
                BRA     CHKCTL

.WASCTR         INY
                LDA     (ADDR),Y
                CMP     "0"
                BCC     NORECF
                CMP     #$3A
                BCS     NORECF
                JSR     DECCON
                PHX
                LDX     TEMP
.OUTCON         LDA     scratc+$0A,X  ; scratc+$0A(BUFF)
                JSR     FMWRCH     ; ul!!
                DEX
                BPL     OUTCON
                PLX
                JMP     WASCTL

.CTLLDO         LDA     #$FF
                JMP     (LAD55,X)  ; LAD55(CMDS+2)
.ROUTAF         JSR     GETNO
                AND     #$0F
                ASL     A
                TAX
                LDA     LINBUFF+1,X  ; LINBUFF+1(NOREGS+1)
                AND     #$0F
                STA     LINBUFF+1,X  ; LINBUFF+1(NOREGS+1)
                INY                  ; skip some delimiter
                PHX
                JSR     GETNO
                PLX
                ASL     A
                ASL     A
                ASL     A
                ASL     A
                ORA     LINBUFF+1,X  ; LINBUFF+1(NOREGS+1)
                STA     LINBUFF+1,X  ; LINBUFF+1(NOREGS+1)
                RTS

.ROTAN          JSR     GETNO
                AND     #$0F
                ASL     A
                PHA
                LDA     (ADDR),Y
                INY                  ; skip delimiter
                PHA
                JSR     GETNO

                PLA
                CMP     "+"
                BEQ     ADDREG
                CMP     "-"
                BEQ     SUBREG
                CMP     "="
                BEQ     MOVREG

                TXA
                PLX
                STA     LINBUFF,X    ; LINBUFF(NOREGS)
                LDA     LINBUFF+1,X  ; LINBUFF+1(NOREGS+1)
                AND     #$F0
                STA     LINBUFF+1,X  ; LINBUFF+1(NOREGS+1)
                RTS

.ADDREG         CLC
                STX     scratc+$0A    ; scratc+$0A(BUFF)
                PLX
                LDA     LINBUFF,X     ; LINBUFF(NOREGS)
                ADC     scratc+$0A    ; scatc+$0A(BUFF)
                STA     LINBUFF,X     ; LINBUFF(NOREGS)
                LDA     LINBUFF+1,X   ; LINBUFF+1(NOREGS+1)
                ADC     #$00
                STA     LINBUFF+1,X   ; LINBUFF+1(NOREGS+1)
                RTS

.SUBREG         STX     scratc+$0A    ; scratc+$0A(BUFF)
                PLX
                LDA     LINBUFF,X     ; LINBUFF(NOREGS)
                SBC     scratc+$0A    ; scratc+$0A(BUFF)
                STA     LINBUFF,X     ; LINBUFF(NOREGS)
                LDA     LINBUFF+1,X   ; LINBUFF+1(NOREGS+1)
                SBC     #$00
                STA     LINBUFF+1,X   ; LINBUFF+1(NOREGS+1)
                RTS

.MOVREG         TXA
                AND     #$0F
                ASL     A
                TAX
                LDA     LINBUFF+1,X   ; LINBUFF+1(NOREGS+1)
                AND     #$0F
                STA     scratc+$0A    ; scratc+$0A(BUFF)
                LDA     LINBUFF,X     ; LINBUFF(NOREGS)
                PLX
                STA     LINBUFF,X     ; LINBUFF(NOREGS)
                LDA     LINBUFF+1,X   ; LINBUFF+1(NOREGS+1)
                AND     #$F0
                ORA     scratc+$0A    ; scratc+$0A(BUFF)
                STA     LINBUFF+1,X   ; LINBUFF+1(NOREGS+1)
                RTS

.ROUTBL         STA     UMATHI        ; UMATHI(BOLD)
                STA     BOLDRQ        
                RTS

                LDA     (ADDR),Y
                STA     CTLCHA
                INY
                RTS

                STA     CENTRE
                STZ     SMATLO        ; can't have both : SMATLO(RFLUSH)
                RTS

.ROUTCH         LDA     ADDR
                STA     TEMP
                LDA     ADDR+1
                STA     TEMP+1      ; move filename pointer
                LDA     tstart
                STA     ADDR
                LDA     tstart+1
                STA     ADDR+1
                LDA     TMAX
                LDX     TMAX+1
                JSR     paslnm
                JSR     pasGO
                STX     GS
                STY     GS+1
                LDX     #$FF
                TXS
                JMP     CHAINB

.MACCHK         STA     TEMP        ; check for macro: A-lo, TEMP+1-hi
                LDX     #$FE        ; -2
.MACCHL         INX
                INX
                CPX     #$D0        ; (MAXMAC)
                BCS     MACCHX
                LDA     MACLST,X
                STA     scratc+$0A  ; scratc+$0A(BUFF)
                LDA     MACLST+1,X
                STA     scratc+$0B  ; scratc+$0B(BUFF+1)
                BEQ     MACCHZ
                PHY
                LDY     #$03
.MACSPC         LDA     (scratc+$0A),Y  ; scratc+$0A(BUFF)
                INY
                CMP     " "
                BEQ     MACSPC
                STA     scratc+$0C    ; scratc+$0C(BUFF+2)
                LDA     (scratc+$0A),Y  ; scratc+$0A(BUFF)
                PLY
                CMP     TEMP+1
                BNE     MACCHL
                LDA     scratc+$0C    ; scratc+$0C(BUFF+2)
                CMP     TEMP
                BNE     MACCHL
                RTS                   ; found CS,EQ

.MACCHX         CLC                   ; not found, no space CC,NE
                TXA
.MACCHZ         RTS                   ; not found, at space CC,EQ

.DMEXIT         DEY
                RTS

.ROUTDM         JSR     SPACEY
                CMP     termin
                BEQ     DMEXIT
                CMP     CTLCHA
                BEQ     DMEXIT
                STA     TEMP+1
                LDA     (ADDR),Y
                CMP     termin
                BEQ     DMEXIT
                JSR     MACCHK
                BNE     DMEXIT
                LDA     ADDR
                STA     MACLST,X
                LDA     ADDR+1
                STA     MACLST+1,X
                BRA     SKIPEN

.ROUTDS         LDA     #$02
                STA     UMATHI+1    ; UMATHI+1(VSPACE)
                RTS

.ROUTOF         LDA     ADDR
                STA     PAGEOF
                LDA     ADDR+1
                STA     PAGEOF+1
                BRA     SKIPEN

.ROUTOH         LDA     ADDR
                STA     PAGEOH
                LDA     ADDR+1
                STA     PAGEOH+1
                BRA     SKIPEN

.ROUTFO         LDA     ADDR
                STA     PAGEOF
                LDA     ADDR+1
                STA     PAGEOF+1

.ROUTEF         LDA     ADDR
                STA     PAGEEF
                LDA     ADDR+1
                STA     PAGEEF+1

.ROUTIG         BRA     SKIPEN

.ROUTHE         LDA     ADDR
                STA     PAGEOH
                LDA     ADDR+1
                STA     PAGEOH+1

.ROUTEH         LDA     ADDR
                STA     PAGEEH
                LDA     ADDR+1
                STA     PAGEEH+1

.SKIPEN         CLC
                JSR     YADP

.SKIPEM         LDA     (ADDR)
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

.SKIPEK         CMP     CTLCHA
                BNE     SKIPEM
                LDA     (ADDR)
                CMP     "e"
                BNE     SKIPEM
                LDY     #$01
                LDA     (ADDR),Y
                CMP     "n"
                BNE     SKIPEM
                INY

.SKIPEX         RTS

.ROUTEN         TSX
                CPX     #$FD
                BCS     SKIPEX     ; check for possible to do it
                PLA
                PLA
                RTS                ; return a macro level

.ROUTEP         JSR     ROUTEBP
                LDA     LINBUFF    ; LINEBUFF (PAGE)
                LSR     A
                BCS     ROUTEP
                RTS

.ROUTFF         LDA     PWTFLG
                BMI     NOWAIT
                LDA     PRTFLG
                BPL     PRTWAT
                JSR     INKEY

.NOWAIT         LDA     #$0C
                JMP     OSWRCH

.PRTWAT         JSR     NOWAIT
                JMP     INKEY

.ROUTIC         PHY
                JSR     closeX
                PLY
                RTS

.ROUTIN         LDX     SMATHI+1    ; SMATHI+1(INDENT)
                JSR     MODNO
                STX     SMATHI+1    ; SMATHI+1(INDENT)
                RTS

.ROUTIO         CLC
                JSR     YADP
                JSR     closeX
                LDX     ADDR
                LDY     ADDR+1
                LDA     #$80
                JSR     OSFIND
                STA     INDEXH
                LDY     #$00

.ROUTCO         LDA     termin
                BRA     SKIPL1

.SKIPLP         INY
                BNE     SKIPL1
                INC     ADDR+1
.SKIPL1         CMP     (ADDR),Y
                BNE     SKIPLP
                RTS

.ROUTIX         STA     LINE      ; LINE(DOINDX)
                CLC
                JSR     YADP
                LDA     LINEOT
                PHA
                LDA     #$FD
                STA     LINEOT
                JSR     CTLIN
                PLA
                STA     LINEOT
                STZ     LINE       ; LINE(DOINDX)
                RTS

.ROUTJU         STZ     FILL
                RTS

.ROUTLL         LDX     SMATHI
                JSR     MODNO
                STA     SMATHI     ; SMATHI(LEN)
                RTS

.ROUTLS         LDX     UMATHI+1   ; UMATHI+1(VSPACE)
                JSR     MODNO
                STX     UMATHI+1   ; UMATHI+1(CVSPACE)
                RTS

.ROUTLV         JSR     GETNO
                CMP     LINEOT
                BEQ     OKAYLV
                BCC     OKAYLV
                PHA
                JSR     ROUTEBP
                PLA

.OKAYLV         JMP     ALINES
.ROUTNE         JSR     GETNO
                CMP     LINEOT
                BEQ     OKAY
                BCC     OKAY

.ROUTEBP        LDA     LINEOT
                BRA     ALINES
                
.ROUTNJ         STA     FILL

.OKAY           RTS

.ROUTNN         STA     SMATLO+1    ; SMATLO+1(LINFED)
                RTS

.ROUTOP         JSR     ROUTEBP
                LDA     LINBUFF     ; LINBUFF(PAGE)
                LSR     A
                BCC     ROUTOP
                RTS

.ROUTOS         CLC
                JSR     YADP
                LDX     ADDR
                LDY     ADDR+1
                JSR     OSCLI
                LDY     #$00
                JMP     ROUTCO

.ROUTPL         LDX     LINEDW
                JSR     MODNO
                TXA
                BEQ     WZERO
                STA     LINEDW
                LDX     LINEOT
                INX
                BEQ     WZERO
                STA     LINEOT
.WZERO          RTS

.ROUTPO         LDX     OFFSET
                JSR     MODNO
                STA     OFFSET
                RTS

.ROUTRF         STA     SMATLO     ; SMATLO(RFLUSH)
                STZ     CENTRE     ; can't have both
                RTS

.ROUTSP         JSR     GETNO

.ALINES         TAX
                BEQ     ALINEX
                PHY
                CMP     #$FF
                BNE     ALINEA
                JSR     DOHDR
                LDX     LINEOT
                
.ALINEA         LDA     LINEOT     ; TODO original has this as ALINEL
                INC     A
                BNE     ALINET
                PHX
                JSR     DOHDR
                PLX
                
.ALINET         LDA     cr         ; ++++
                JSR     OSWRCH
                JSR     LFWRCH
                DEX
                BNE     ALINEA
                PLY
                
.ALINEX         RTS

.ROUTSS         LDA     #$01
                STA     UMATHI+1   ; UMATHI+1(VSPACE)
                RTS

.ROUTTA         STZ     LASTTAB

.SETTAB         JSR     GETNO
                LDX     LASTTAB
                STA     TABLST,X
                STZ     TABLST+1,X
                INC     LASTTAB
                JSR     SPACEY
                CMP     ","
                BEQ     SETTAB
                DEY
                RTS

.ROUTTC         LDA     (ADDR),Y
                STA     mark_count   ; mark_count(TABCHA)
                INY
                RTS

.ROUTTI         LDX     TINDEN
                CPX     #$FF
                BNE     ROUSTI
                LDX     SMATHI+1     ; if no temp indent then use INDENT as base.
                                     ; SMATHI+1(INDENT)
.ROUSTI         JSR     MODNO
                STX     TINDEN
                RTS

.ROUTTR         LDA     (ADDR),Y
                CMP     termin
                BEQ     SETTRX
                TAX
                INY
                LDA     (ADDR),Y
                DEY
                CMP     termin
                BEQ     SETTRX
                INY
                INY
                STA     stracc,X    ; stracc(TRNLST)

.SETTRX         RTS

.ROUTUL         STA     UMATLO
                STA     UNDRRQ
                RTS

.YADP           TYA
                ADC     ADDR
                STA     ADDR
                BCC     ENDADD
                INC     ADDR+1
.ENDADD         RTS

.MODNO          JSR     SPACEY
                CMP     " "
                BEQ     SUBNO
                CMP     "+"
                BEQ     ADDNO
                DEY
                LDX     #$00
                
.ADDNO          PHX
                JSR     GETNO
                PLX
                CLC
                STX     TEMP
                ADC     TEMP
                BCC     ADDNOX
                LDA     #$00

.ADDNOX         TAX
                RTS

.SUBNO          PHX
                JSR     GETNO
                STA     TEMP
                PLA
                SEC
                SBC     TEMP
                BCS     ADDNOX
                LDA     #$00
                TAX
                RTS

.GETNO          LDX     #$00
                JSR     SPACEY
                DEY
.NUMLOP         LDA     (ADDR),Y
                CMP     "9"
                BCC     ENDNO
                CMP     #$3A
                BCS     ENDNUM     ; not a decimal digit
                AND     #$0F
                PHA
                TXA
                ASL     A
                ASL     A
                STA     TEMP
                TXA
                CLC
                ADC     TEMP
                ASL     A
                STA     TEMP
                PLA
                CLC
                ADC     TEMP
                TAX
                INY
                BRA     NUMLOP

.ENDNUM         CLC
.ENDNO          TXA
                RTS

.DOHDR          LDX     PAGEEH
                LDY     PAGEEH+1
                LDA     LINBUFF    ; LINBUFF(PAGE)
                LSR     A
                BCC     DOHDR1
                LDX     PAGEOH
                LDY     PAGEOH+1
.DOHDR1         DEC     LINEOT
                JSR     MACRO
                LDA     LINEDW
                STA     LINEOT
                LDA     #$01
                STA     LINENO
                LDA     #$0F
                TRB     LINENO+1   ; leave format alone!
                RTS

.MovWrdGEtoTP   LDA     GE
                STA     TP
                LDA     GE+1
                STA     TP+1
                RTS

.rstPrtDes      LDA     #$05      ; Set printer destination to printer sink
                LDX     #$00      ; just for jes's code, set and reset printer type
                JSR     OSBYTE    ; On Exit X contains previous printer destination

                JSR     OSBYTE    ; Reset printer destination to what it was before

                LDA     #$02
                JMP     OSWRCH    ; Enable Printer

.MACRO          LDA     ADDR
                PHA
                LDA     ADDR+1
                PHA
                LDA     CTLCHA
                PHA
                LDA     SMATHI       ; SMATHI(LEN)
                PHA
                LDA     SMATHI+1     ; SMATHI+1(INDENT)
                PHA
                LDA     TINDEN
                PHA
                LDA     UMATHI       ; UMATHI(BOLD)
                PHA
                LDA     PBOLD
                PHA
                LDA     BOLDRQ
                PHA
                LDA     UMATLO       ; UMATLO(UNDERL)
                PHA
                LDA     UMATLO+1     ; UMATLO+1(PUNDRL)
                PHA
                LDA     UNDRRQ
                PHA
                LDA     FILL
                PHA
                LDA     UMATHI+1     ; UMATHI+1(VSPACE)
                PHA
                LDA     CENTRE
                PHA
                LDA     SMATLO       ; SMATLO(RFLUSH)
                PHA
                LDA     SMATLO+1     ; SMATLO+1(LINFED)
                PHA
                STZ     SMATLO+1     ; SMATLO+1(LINFED)
                STZ     FILL
                STZ     PBOLD
                STZ     UMATLO+1     ; UMATLO+1(PUNDRL)
                STZ     SMATHI+1     ; SMATHI+1(INDENT)
                LDA     #$01
                STA     UMATHI+1     ; UMATHI+1(VSPACE)
                STX     ADDR
                STY     ADDR+1
                LDA     (ADDR)
                STA     CTLCHA
                LDY     #$03
                CLC
                JSR     YADP         ; skip definition
                JSR     FINE
                PLA
                STA     SMATLO+1     ; SMATLO+1(LINFED)
                PLA
                STA     SMATLO       ; SMATLO(RFLUSH)
                PLA
                STA     CENTRE
                PLA
                STA     UMATHI+1     ; UMATHI+1(VSPACE)
                PLA
                STA     FILL
                PLA
                STA     UNDRRQ
                PLA
                STA     UMATLO+1     ; UMATLO+1(PUNDRL)
                PLA
                STA     UMATLO       ; UMATLO(UNDERL)
                PLA
                STA     BOLDRQ
                PLA
                STA     PBOLD
                PLA
                STA     UMATHI       ; UMATHI(BOLD)
                PLA
                STA     TINDEN
                PLA
                STA     SMATHI+1     ; SMATHI+1(INDENT)
                PLA
                STA     SMATHI       ; SMATHI(LEN)
                PLA
                STA     CTLCHA
                PLA
                STA     ADDR+1
                PLA
                STA     ADDR
                RTS

.VDUBIT         TAY
                LDA     stracc,Y     ; stracc(TRNLST)
                STA     scratc
                JSR     XYscra
                LDA     #$0A         ; Read Character Definition
                JMP     OSWORD

.DOVDU          BIT     UMATHI       ; UMATHI(BOLD)
                BPL     VDUNBL
                                     ; bold character
                PHY
                PHX
                JSR     VDUBIT
                LDX     #$07

.VDUBLD         LDA     scratc+1,X
                LSR     A
                ORA     scratc+1,X
                STA     scratc+1,X
                DEX
                BPL     VDUBLD
                BIT     UMATLO       ; UMATLO(UNDERL)
                BPL     VDUDON
                                     ; both bold and underline
                BRA     VDUUND

.VDUNBL         BIT     UMATLO      ; UMATLO(UNDERL)
                BPL     WRCHA
                                    ; underline character
                PHY
                PHX
                JSR     VDUBIT

.VDUUND         LDA     scratc+8
                LSR     A
                ROR     A
                ORA     scratc+8
                ROL     A
                EOR     #$FF
                TSB     scratc+8
.VDUDON         JSR     VSTRNG

                EQUB    $17,$20,$EA

.LAA4D          LDX     #$01

.VDUPRG         LDA     scratc,X
                JSR     OSWRCH
                INX
                CPX     #$09
                BNE     VDUPRG
                JSR     VSTRNG
                EQUB    $20,$17,$20,$00,$00,$00,$00,$00
                EQUB    $00,$00,$00,$EA

.VDUPRG1        PLX
                PLY
                RTS

.ESCAP          JSR     ackesc
                JMP     DODWN

.FMWRCH         BIT     ESCFLG
                BMI     ESCAP     ; must not go via SENTRY,
                                  ; because of marked mode (SWOPCH)
                BIT     LINE      ; LINE(DOINDX)
                BMI     DOINDE

                CMP     termin
                BEQ     wrchen

                BIT     PRTFLG
                BMI     DOVDU
                BVS     NOULA

                LDA     " "
                BIT     UMATLO
                BPL     NOULA
                LDA     "_"

.NOULA          PHA
                LDA     #$20
                BIT     PRTFLG
                BNE     NOBBLE

                BIT     UMATHI
                BMI     NOBBLE

                LDA     " "
                JSR     OSWRCH
                PLA
                RTS

.NOBBLE         PLA
.WRCHA          PHY
                TAY
                LDA     stracc,Y    ; stracc(TRNLST)
                PLY
.wrch           JMP     (WRCHV)

.wrchen         LDA     #$0D
                BRA     wrch

.DOINDE         PHY
                TAY
                LDA     stracc,Y    ; stracc(TRNLST)
                LDY     INDEXH
                BEQ     DOINDF
                JSR     OSBPUT

.DOINDF         PLY
                RTS

.LFWRCH         BIT     LINE        ; LINE(doindX)
                BMI     writeX

                LDA     lf          ; write a real line feed
                INC     LINENO
                BNE     fmwrca
                INC     LINENO+1
                j
.fmwrca         DEC     LINEOT
                BNE     wrch
                JSR     OSWRCH
                PHX
                PHY
                LDX     PAGEEF
                LDY     PAGEEF+1
                LDA     LINBUFF     ; LINBUFF (page)
                LSR     A
                BCC     doftr1
                LDX     PAGEOF
                LDY     PAGEOF+1

.doftr1         DEC     LINEOT
                DEC     LINEOT
                JSR     MACRO
                LDA     #$FF
                STA     LINEOT
                INC     LINBUFF     ; LINBUFF(PAGE)
                BNE     HI
                INC     LINBUFF+1   ; LINBUFF+1(PAGE+1)
.HI             PLY
                PLX
.writeX         RTS

.WRITE          LDA     #$20
                TSB     PRTFLG
                LDA     UMATHI
                PHA
                JSR     DOSCRE
                PLA
                STA     UMATHI
                BIT     BOLDRQ
                BPL     writeX
                LDA     #$20
                TRB     PRTFLG
                JSR     DOSCRE
                LDA     #$20
                TSB     PRTFLG
                RTS

.DOSCRE         LDA     OFFSET
                JSR     SCMVTO
                STZ     DIFF
                LDA     XEFF
                BNE     SCREEA
                SEC
                LDA     JUSLEN
                SBC     COUNT
                STA     DIFF
.SCREEA         LDA     TINDEN
                CMP     #$FF
                BNE     SCREEB
                LDA     SMATHI+1   ; SMATHI+1(INDENT)
.SCREEB         JSR     SCMVTO
                LDA     CENTRE
                BPL     SCREED
                SEC
                LDA     JUSLEN
                INC     A
                SBC     COUNT
                JSR     MOVE

.SCREED         BIT     SMATLO     ; SMATLO(RFLUSH)
                BPL     SCREEQ
                SEC
                LDA     JUSLEN
                ADC     #$01
                SBC     COUNT
                JSR     SCMVTO

.SCREEQ         LDY     #$00
                LDX     #$00
                LDA     SPACES
                BEQ     SCREEE
                LSR     A
                STA     NUMMAR       ; NUMMAR(L)
                LDA     #$00
                BIT     FILL
                BMI     SENA
                LDA     DIFF
.SENA           LDX     #$01
.DODIV          CMP     SPACES
                BCC     DONDIV
                INX
                SBC     SPACES
                BCS     DODIV

.DONDIV         STX     MARKSB       ; MARKSB(Q)
                STA     DIFF
                LDX     #$00
.SCREEE         JSR     CHKCTL

                CMP     termin       ; ++++
                BEQ     SCREEG

                CMP     mark_count   ; mark_count(TABCHA)
                BNE     SCREES
                TXA
                LDX     #$FF
.SCRTAB         INX
                PHA
                LDA     TABLST,X
                BEQ     SCRNTB
                PLA
                CMP     TABLST,X
                BCS     SCRTAB
                SEC
                SBC     TABLST,X
                EOR     #$FF
                INC     A
                PHX
                JSR     SCMVTO
                PLX
                LDA     TABLST,X
                TAX
                DEX
                BRA     NOUL

.SCRNTB         PLX
                LDA     " "
.SCREES         CMP     " "
                BNE     SCREEF
                CPX     LASTTAB
                BCC     SCREEF
                PHX
                LDX     MARKSB     ; MARKSB(Q)
.SCRJUS         DEX
                BEQ     NOMOV
                LDA     " "
                JSR     FMWRCH
                BRA     SCRJUS

.NOMOV          PLX
                SEC
                LDA     NUMMAR     ; NUMMAR(L)
                SBC     DIFF
                STA     NUMMAR     ; NUMMAR(L)
                BCS     ENDJUS
                ADC     SPACES
                STA     NUMMAR     ; NUMMAR(L)
                LDA     " "
                JSR     FMWRCH

.ENDJUS         LDA     " "
.SCREEF         JSR     FMWRCH

.NOUL           INY
                INX
                CPX     COUNT
                BCC     SCREEE

                LDA     termin     ; ++++
.SCREEG         JMP     FMWRCH

.closeX         LDY     INDEXH
                BEQ     closexrts
                STZ     INDEXH
                LDA     #$00
                JSR     OSFIND     ; close index file

.closexrts      RTS

.SCMVTO         ASL     A
.MOVE           LSR     A
                BEQ     MOVEX
                TAX
                LDA     #$09
                BIT     PRTFLG
                BMI     MLOOP
                LDA     " "
.MLOOP          BIT     LINE       ; LINE(DOINDX)
                BPL     MLOOPA
                LDA     " "
                JSR     DOINDE
                BRA     MLOOPB

.MLOOPA         JSR     OSWRCH

.MLOOPB         DEX
                BNE     MLOOP

.MOVEX          RTS

.INKEYS         JSR     STRIMO
                EQUS    "Press SHIFT to continue"
                EQUB    $EA

.INKEY          PHX
                PHY

.INKEYL         JSR     escTST
                LDX     #$FF         ; Scan for key &FF  - INKEY(-128)
                LDY     #$FF
                LDA     #$81
                JSR     OSBYTE       ; Read Key within time limit
                CPX     #$FF
                BNE     INKEYL       ; Key was not pressed
                LDA     #$0F
                LDX     #$FF
                JSR     OSBYTE       ; Flush all input buffers
                PLY
                PLX
                RTS

.DECCON         PHX                   ; reg in A to print buff. INX by # chars
                PHY
                AND     #$0F
                ASL     A
                TAX
                LDA     LINBUFF,X     ; LINBUFF(NOREGS)
                STA     TEMP
                LDA     LINBUFF+1,X   ; LINBUFF+1(NOREGS+1)
                TAX
                AND     #$0F
                STA     TEMP+1
                ORA     TEMP
                PHP
                TXA
                LSR     A
                LSR     A
                LSR     A
                LSR     A
                PLP
                BNE     MMLTST
                CMP     #$08
                BCC     DECANY
                LDA     #$00
                BRA     DECANY

.MMLTST         CMP     #$08
                BCS     ROMAN

.DECANY         PHA
                LDX     #$04
                LDA     "0"
                STA     BUFF+5
                STA     BUFF+6
                STA     BUFF+7
.NUMLAP         LDA     "0"
                STA     BUFF,X
                SEC
.NUMLP          LDA     TEMP         
                SBC     WOPTBL,X
                TAY
                LDA     TEMP+1
                SBC     WOPTBH,X
                BCC     OUTNUM
                STY     TEMP
                STA     TEMP+1
                INC     BUFF,X    ; scratc+$0A
                BNE     NUMLP

.OUTNUM         DEX
                BPL     NUMLAP
                PLA
                STA     TEMP
                LDX     #$08
.LZB            DEX
                CPX     TEMP
                BEQ     LASTZ
                LDA     BUFF,X    ; scratc+$0A
                AND     #$0F
                BEQ     LZB

.LASTZ          STX     TEMP
                PLY
                PLA
                SEC
                ADC     TEMP
                TAX
                RTS

.ROMAN          PHA
                CMP     #$0A
                BCS     AAA
                LDA     #$FF
                PHA
                LDX     #$0C
                
.ROMANL         SEC
                LDA     TEMP
                SBC     NUMERL,X
                TAY
                LDA     TEMP+1
                SBC     NUMERH,X
                BCC     ROMANO

                STY     TEMP
                STA     TEMP+1
                TXA
                ASL     A
                TAY
                LDA     CHARS,Y
                PHA
                LDA     CHARS+1,Y
                CMP     " "
                BEQ     ROMANL

                PHA
                BRA     ROMANL

.ROMANO         DEX
                BPL     ROMANL

.ROMANG         PLA
                INX
                STA     BUFF,X    ; scratc+$0A
                CMP     #$FF
                BNE     ROMANG

                DEX
.CASECH         PLA
                AND     #$01
                BEQ     LASTZ

                STX     TEMP
.CASELP         LDA     BUFF,X    ; scratc+$0A
                ORA     #$20
                STA     BUFF,X    ; scratc+$0A
                DEX
                BPL     CASELP

                LDX     TEMP
                BRA     LASTZ

.AAA            LDA     TEMP
                BNE     AAADEC

                DEC     TEMP+1
.AAADEC         DEC     TEMP
                LDY     #$00
.AAALOP         LDA     TEMP
                SEC
.AAALOQ         INY
                SBC     #$1A
                BCS     AAALOQ

                STA     TEMP
                LDA     TEMP+1
                BEQ     AAAGOT

                DEC     TEMP+1
                BRA     AAALOP

.AAAGOT         LDA     TEMP
                ADC     #$5B     ; 26+"A"
                LDX     #$00
.AAALON         STA     BUFF,X  ; scratc+$0A
                INX
                DEY
                BNE     AAALON

                DEX
                BRA     CASECH

.NUMERL         EQUB    $01,$04,$05,$09,$0A,$28,$32,$5A
                EQUB    $64,$90,$F4,$84,$E8

.NUMERH         EQUB    $00,$00,$00,$00,$00,$00,$00,$00
                EQUB    $00,$01,$01,$03,$03

.CHARS          EQUS    "I IVV IXX XLL XCC CDD DMM a"

.CMDS           EQUS    "af"    

.LAD55          EQUW    ROUTAF

                EQUS    "an"

                EQUW    ROUTAN

                EQUS    "bl"

                EQUW    ROUTBL

                EQUS    "bp"

                EQUW    ROUTBP

                EQUS    "cc"

                EQUW    ROUTCC

                EQUS    "ce"

                EQUW    ROUTCE

                EQUS    "ch"

                EQUW    ROUTCH

                EQUS    "co"

                EQUW    ROUTCO

                EQUS    "dm"

                EQUW    ROUTDM

                EQUS    "ds"

                EQUW    ROUTDS

                EQUS    "ef"

                EQUW    ROUTEF

                EQUS    "eh"

                EQUW    ROUTEH

                EQUS    "en"

                EQUW    ROUTEN

                EQUS    "ep"

                EQUW    ROUTEP

                EQUS    "ff"

                EQUW    ROUTFF

                EQUS    "fo"

                EQUW    ROUTFO

                EQUS    "he"

                EQUW    ROUTHE

                EQUS    "ic"

                EQUW    ROUTIC

                EQUS    "ig"

                EQUW    ROUTIG

                EQUS    "in"

                EQUW    ROUTIN

                EQUS    "io"

                EQUW    ROUTIO

                EQUS    "ix"

                EQUW    ROUTIX

                EQUS    "ju"

                EQUW    ROUTJU

                EQUS    "ll"

                EQUW    ROUTLL

                EQUS    "ls"

                EQUW    ROUTLS

                EQUS    "lv"

                EQUW    ROUTLV

                EQUS    "ne"

                EQUW    ROUTNE

                EQUS    "nj"

                EQUW    ROUTNJ

                EQUS    "nn"

                EQUW    ROUTNN

                EQUS    "of"

                EQUW    ROUTOF

                EQUS    "oh"

                EQUW    ROUTOH

                EQUS    "op"

                EQUW    ROUTOP

                EQUS    "os"

                EQUW    ROUTOS

                EQUS    "pl"

                EQUW    ROUTPL

                EQUS    "po"

                EQUW    ROUTPO

                EQUS    "rf"

                EQUW    ROUTRF

                EQUS    "sp"

                EQUW    ROUTSP

                EQUS    "ss"

                EQUW    ROUTSS

                EQUS    "ta"

                EQUW    ROUTTA

                EQUS    "tc"

                EQUW    ROUTTC

                EQUS    "ti"

                EQUW    ROUTTI

                EQUS    "tr"

                EQUW    ROUTTR

                EQUS    "ul"

                EQUW    ROUTUL
;; NOCMDS      * ( . - CMDS )

.SCRNUD         JSR     LENGTH

                STA     CURRLEN
                TAY
                BEQ     SCRNU0

                CMP     PAGEWI
                BNE     SCRNU1

.SCRNU0         LDA     UPDATE
                CMP     #$01
                BNE     SCRNU1

                INC     UPDATE
                ; Update marks set, if any, to locate them for superimposition.
.SCRNU1         JSR     MARKUPDATE

                JSR     CUROFF
                ; if screen messier than would be fixed up by intended update,
                ; then do something about it.
                LDA     SCRNPY
                CMP     UPDATE
                BCC     SCUDCO

                STA     UPDATE
.SCUDCO         STZ     SCRNPY
                LDA     UPDATE
                CMP     THELOT      ; #$06 (THELOT)
                BNE     SCUDTI

                JSR     CLEARSCREEN
                ; if fullscreen updaate is required, then find internal start
                ; of screen, possibly forcing scrnY, and update top half.

.SCUDTI         LDA     UPDATE
                BEQ     SCUDEX      ; 'none'
                CMP     FULLSCREEN  ; #$05 (FULLSCREEN)
                BCC     SCUDBO

.SCUDFS         LDA     SCRNY
                JSR     TPGSBK
                STA     SCRNY
                DEC     A
                STA     MAXSCRUPY
                BMI     SCUDBO
                LDA     #$00
                LDX     TP
                LDY     TP+1
                JSR     UPDTLN
                BCS     SCUDAB

.SCUDBO     
                ; Output bottom half of screen, branching for hardscrolls.
                LDX     UPDATE
                CPX     HARDUP     ; #$03 (HARDUP)
                BEQ     SCUDHU
                CPX     HARDDOWN   ; #$04 (HARDDOWN)
                BEQ     SCUDHD

                LDY     PAGELE
                STY     MAXSCRUPY
                ; Set up A,X,Y for bottom half update
                LDA     SCRNY
                LDX     GE
                LDY     GE+1
                JSR     UPDTLN
                BCC     SCUDEX

.SCUDAB         
                ; Record the fact that screen isn't totally up-to-date.
                LDA     CSRONW    ; #$02 (CSRONW)
                CMP     UPDATE
                BCS     SCUDAS
                LDA     FULLSCREEN ; #$05
.SCUDAS         STA     SCRNPY
.SCUDEX         STZ     UPDATE
                RTS

.SCUDHU         
                ; Push against bottom to scroll up
                JSR     CSR0STATUSY

                LDA     DOWN    ; #$0A (DOWN)
                JSR     OSWRCH
                ; Scroll scrim up.
                LDX     #$FF

.SCHULP         INX
                LDA     SCRIM+1,X
                STA     SCRIM,X
                CPX     PAGELE
                BNE     SCHULP

                STZ     SCRIM+1,X
                JSR     STATUS
                LDA     PAGELE
                BRA     SCHUDC

.SCUDHD         
                ; Rewrite status, then push against top to scroll down 
                JSR     VSTRNG
                EQUB    HOME,UP   ; $1E,$0B
.LAE95          EQUB    $EA
                ; Scroll scrim down.

.LAE96          LDY     PAGELE

.SCHDLP         LDA     SCRIM,Y
                STA     SCRIM+1,Y
                DEY
                BPL     SCHDLP
                STZ     SCRIM
                JSR     STATUS
                LDA     #$00
.SCHUDC         STA     MAXSCRUPY
                LDX     SCP
                LDY     SCP+1
                BNE     UPDTLN
                TAY

.WIPELINE       
                ; Clear a line, assigning new scrim value. Y is line to clear.
                PHY
                JSR     CSR0Y
                LDA     " "
                JSR     OSWRCH
                LDA     #$00
                PLY
.WIPETA         
                ; Assign scrim entry for a line, clearing old tail of line.
                ; Entry - A = New scrim entry
                ;        Y = screen Y-coord
                ; Exit  - Tail of line wiped.
                ;        scrim updated
                ;        A,Y preserved.
                STA     ATEMP
                CMP     SCRIM,Y
                BCS     WTSCRM
                LDA     machtype
                BEQ     WIPEDETEXT

                LDA     #$1F
                JSR     OSWRCH

                LDA     ATEMP
                INC     A
                JSR     OSWRCH

                TYA
                JSR     OSWRCH

                JSR     VSTRNG
                EQUB    $17

                EQUB    $08,$05,$06,$00,$00,$00,$00,$00
                EQUB    $00,$EA

.LAEE7          JMP     WTSCRM

.WIPEDETEXT     LDA     #$1C
                JSR     OSWRCH

                LDA     ATEMP
                INC     A
                JSR     OSWRCH

                PHX
                LDA     options
                AND     #$07
                TAX
                TYA
                CLC
                ADC     VERTTB,X
                PLX
                PHA
                JSR     OSWRCH

                LDA     SCRIM,Y
                JSR     OSWRCH

                PLA
                JSR     OSWRCH

                LDA     #$0C
                JSR     OSWRCH

                PHY
                JSR     DECWIN

                PLY
.WTSCRM         LDA     ATEMP
                STA     SCRIM,Y
                RTS

.UPDTLN         
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
                LDX     #$00
                LDA     UPDATE
                CMP     CSRTOCR  ; #$01 (CSRTOCR)
                BEQ     UPDLC0
                ; if updatedread = csronwards then start screen update from char under cursor.
                CMP     CSRONWARDS  ; #$02 (CRSONWARDS)
                BNE     UPDLCO

.UPDLC0         LDX     SCRNX
                CPX     CURRLEN
                BCC     UPDLCO

                LDX     CURRLEN
.UPDLCO         PHX
                LDY     SCRUPY
                JSR     CSRXY
                PLY
                DEY

.UPDLLP         INY
.UPDLL2         LDA     (TP),Y
                CMP     termin
                BEQ     UPDLCR

                JSR     PASWRCH
                CPY     PAGEWI
                BNE     UPDLLP
                BRA     UPDLEN

.UPDLCR         JSR     PASWCR

.UPDLEN         STY     COUNT  ; Max csrX on this line.
                ; Superimpose marks, if any, onto this line
                LDY     MARKX
.MOUTLP         DEY
                BMI     MOUTEX
                STY     INDEX
                ; if 0 <= (Mark - TP) <= count, then this is csrX within line.
                SEC
                LDA     UMATLO,Y
                SBC     TP
                TAX
                LDA     UMATHI,Y
                SBC     TP+1
                BCC     MOUTLP
                BNE     MOUTLP
                CPX     COUNT
                BEQ     MOUTMO
                BCS     MOUTLP

.MOUTMO         LDY     SCRUPY
                JSR     CSRXY
                LDA     INDEX
                CLC
                ADC     "1"
                JSR     INVWRCH
                LDX     COUNT
                INX
                JSR     CSRXY
                LDY     INDEX
                BRA     MOUTLP

.MOUTEX         
                ; Update TP, and see if have hit end of file.
                LDA     COUNT
                LDY     SCRUPY
                JSR     WIPETA
                JSR     TPPAP1  ; A = count
                BCS     UPDLNE
                LDA     UPDATE
                CMP     CSRTOCR ; #$01 (CSRTOCR)
                BEQ     UPDLFI
                LDY     SCRUPY
                CPY     MAXSCRUPY
                BCS     UPDLFI
                ; Test if any characters/commands are being queued in buffer.
                LDA     UPDATE
                CMP     THELOT  ; #$06 (THELOT)
                BEQ     QUEUEX
                LDA     NEXTREADFLAG
                BNE     QUEUCS

                LDA     #$81    ; Read a key press within time limit
                LDX     #$00
                JSR     OSBYTEwithY

                CPY     #$FF    ; Key was pressed
                BEQ     QUEUEX

                JSR     escTST
                INC     NEXTREADFLAG
                STX     NXTCHR
                STX     L0080   ; TODO is there a name for this?

                TXA
                BNE     QUEUCS

                JSR     IndOSRDCH

                STA     NXTCHR
.QUEUCS         SEC
                RTS

.QUEUEX         INC     SCRUPY
                LDX     #$00
                JMP     UPDLCO
                ; Overwrite sentinal EOT TERMIN with EOT character.

.UPDLNE         LDX     COUNT
                LDY     SCRUPY
                JSR     CSRXY
                LDA     "*"
                JSR     INVWRCH
                BRA     UDELT1

.UDLEOT         LDY     SCRUPY
                JSR     WIPELINE

.UDELT1         INC     SCRUPY
                CPY     PAGELE
                BCC     UDLEOT

.UPDLFI         CLC
                RTS

.PASWRCH        
                ; Entry - A = char to output.
                ; Exit  - Y preserved
                ;        ctrl ch     --> inverted or chr(255) depending on mode
                ;        delete      --> inv ?
                ;        other chars --> echoed
                CMP     SPACE    ; #$20
                BCC     PASWNC

                CMP     DELETE   ; #$7F
                BNE     PASWOS

                LDA     "?"
                BRA     INVWRCH

.PASWOS         JMP     OSWRCH

.PASWCR         LDA     #$20
                BIT     options
                BEQ     PASWOS

                LDA     "$"       ; **
                BRA     INVWRCH   ; **

.PASWNC         ORA     #$40 ; Output control character as inverted keytop.
.INVWRCH        
                ; Output character in inverse video (blob in mode 7).
                ; Entry - A = character
                ;        mode IN [0..7]
                PHA
                LDA     options
                AND     #$07
                CMP     #$07
                BNE     INVWN7
                PLA
                LDA     #$FF
                BRA     PASWOS

.INVWN7         JSR     startI
                PLA
                JSR     OSWRCH

.stopin         LDA     #$11
                JSR     OSWRCH
                LDA     #$80
                JSR     OSWRCH
                LDA     #$11
                JSR     OSWRCH
                LDA     #$07
                JMP     OSWRCH

.startI         JSR     VSTRNG
                EQUB    $11
                EQUB    $87
                EQUB    $11
                EQUB    $00

                EQUB    $EA

.LB038          RTS

.CURLT          JSR     STARTTEST
                BCC     CLCONT
                LDA     SCRNX
                BEQ     CSREXI

.CLCONT         DEC     SCRNX
                BPL     CSREXI
                LDA     PAGEWI
                STA     SCRNX
                ; C set if at start of text

.CURUP          JSR     STARTTEST
                BCS     CSREXI
                LDA     #$01
                JSR     MVLNBK
                LDA     TSM
                CMP     SCRNY
                BCS     CUUPSC

.CUUPNS         DEC     SCRNY
                BPL     CSREXI

.CUUPSC         LDA     SCRNY ; In Top Scroll Margin. If more tehn TOP scroll Margin Width
                JSR     TPGSBK ; from top of file, then assign Scroll Pointer, else move cursor up.

                CMP     SCRNY
                CLC
                BNE     CUUPNS

                LDA     TP
                STA     SCP
                LDA     TP+1
                STA     SCP+1
                LDA     HARDDOWN  ; #$04 (HARDDOWN)
                STA     UPDATE
                RTS

.WORDRT         LDY     SCRNX
                LDA     (GE),Y
                CMP     termin
                BNE     EASYRT
                JSR     CURDWN
                BCS     WORDXX
                JSR     SCRNUD

.curst          STZ     SCRNX
                BRA     CSREXI

.WORDXX         PLA
                PLA
                RTS

.EASYRT         JSR     CURRT
                JSR     SCRNUD
                BRA     CSREXI

.WORDLT         LDA     SCRNX
                BNE     CURLT
                JSR     CURUP
                BCS     WORDXX
                JSR     SCRNUD

.curend         LDA     CURRLEN
                STA     SCRNX
.CSREXI         STZ     UPDATE
                RTS

.CURRT          LDA     SCRNX
                CMP     PAGEWI
                BEQ     CURRCO
                INC     SCRNX
                BRA     CSREXI

.CURRCO         JSR     ENDTES
                BCS     CSREXI
                STZ     SCRNX
                ; C set if at text end
.CURDWN         JSR     ENDTES
                BCS     CSREXI
                LDA     #$01
                JSR     MVLNFD
                LDA     SCRNY
                CMP     BSM
                BCS     CUDOSC

                INC     SCRNY
                BRA     CSREXI

.CUDOSC         
                ; In Bottom Scroll Margin.
                ; If more than (Pagelength-Bottom Scroll Margin)
                ; from bottom of file, then assign Scroll Pointer, else set SCP+1 to
                ; 0 to indicate wipeline required.
 
                STZ     SCP+1     ; Initalize SCP+1 to 0 implies
                                  ; blank line required for scroll.
                SEC
                LDA     PAGELE
                SBC     BSM
                JSR     TPGEFD

                LDA     COUNT
                BNE     CUDOWS

                LDA     TP
                STA     SCP
                LDA     TP+1
                STA     SCP+1
.CUDOWS         LDA     HARDUP   ; #$03 (HARDUP)
                STA     UPDATE
                CLC
.WORDRX         RTS

.WORDWRIGHT     LDA     CURRLEN
                CMP     SCRNX
                BCS     WORDR3

                STA     SCRNX
                BRA     WORDR3

.WORDR1         JSR     WORDRT

.WORDR3         LDY     SCRNX
                LDA     (GE),Y
                JSR     WORDC

                BCC     WORDR1

.WORDR2         LDY     SCRNX
                LDA     (GE),Y
                JSR     WORDC
                BCC     WORDRX
                JSR     WORDRT
                BRA     WORDR2

.WORDL1         JSR     WORDLT
                LDY     SCRNX
                LDA     (GE),Y
                JSR     WORDC
                BCC     WORDL1

.WORDL2         LDY     SCRNX
                LDA     (GE),Y
                JSR     WORDC
                BCC     CURRT
                JSR     WORDLT
                BRA     WORDL2

.WORDLEFT       LDA     CURRLEN
                CMP     SCRNX
                BCS     WORDL1
                STA     SCRNX

.WORDCX         SEC
                RTS
                ; C set if not wordc

.WORDC          CMP     "0"
                BCC     WORDCX

                CMP     #$3A    ; "9" + 1
                BCC     WORDCR
                AND     #$DF
                CMP     "A"
                BCC     WORDCX
                CMP     #$5B    ; "Z" + 1
.WORDCR         RTS

.EDITi2         LDX     tstart
                LDY     tstart+1

.EDITtd         STX     GS
                STY     GS+1
                LDA     TMAX
                STA     GE
                LDA     TMAX+1
                STA     GE+1

.EDITxx         STZ     cursed
                STZ     NEXTREADFLAG
                STZ     MARKX
                LDA     termin
                STA     (PAJE)  ; OSHWM (PAJE)
                STA     (TMAX)
                
.STFILE         LDX     tstart
                LDY     tstart+1
                JSR     GPBKXY
                STZ     SCRNX   ; CLR scrnY will be forced by scrnud
.STFILX         RTS

.CUREDF         LDA     BSM     ; Try to glue bottom of file to BSM.
                STA     SCRNY
                LDX     TMAX
                LDY     TMAX+1
                JSR     GPFDXY
                JMP     NORMAX

.CHKSCR         LDA     #$87
                JSR     OSBYTE   ; select mode if options and screen mode NOT the same 

                LDA     options
                AND     #$07
                TAX
                LDA     MODETB,X
                STY     STRING
                EOR     STRING
                AND     #$07
                BEQ     STFILX ; same ok

.SELSCR         LDA     #$16   ; select the right screen mode
                JSR     OSWRCH

                LDA     options
                AND     #$07
                TAY
                LDA     MODETB,Y
                ORA     #$80   ; select any shadow around
                JMP     OSWRCH

.EDITmd         JSR     SELSCR     ; Set up 'EDIT'

.EDITMA         LDA     #$83       ; Read top of user RAM for mode
                JSR     OSBYTE     ; Read PAJE

                STX     PAJE       ;  OSHWM (PAJE)
                STY     PAJE+1
                INC     A          ; &84 
                JSR     OSBYTE     ; Read HIMEM

                STX     HYMEM
                STY     HYMEM+1

                ; Set up edit (text) buffer delimiting pointers.
                CLC
                LDA     PAJE        ; OSHWM (PAJE)
                ADC     #$01
                STA     tstart
                LDA     PAJE + 1
                ADC     #$00
                STA     tstart+1
                LDA     HIMEM
                SBC     #$00        ; CC Give -1
                STA     TMAX
                LDA     HYMEM+1
                SBC     #$00
                STA     TMAX+1
                JSR     intpag      ; initalize pagelength and width
                LDA     PAGELE
                SEC
                SBC     #$04
                STA     BSM
                LDA     #$04
                STA     TSM
                RTS

.tsmcsr         
                ; Set Top Scroll Margin to current cursor line.
                LDA     SCRNY
                STA     TSM
                BRA     noupda

.bsmcsr         
                ; Set Bottom Scroll Margin to current cursor line.
                LDA     SCRNY
                STA     BSM
                BRA     noupda

.scmclr         
                ; Clear Scroll Margins.
                STZ     TSM
                LDA     PAGELE
                STA     BSM

.noupda         STZ     UPDATE
                RTS

.newtex         ; Clear text 

                JSR     prompt
                EQUS    "Clear text [Y,shf-f9 (exec),D (discard)]"

.LB218          NOP
                JSR     newtxcont

                BNE     LB22D

                TAX
                BNE     LB22D

.NEWTN          JSR     STATUS

                JMP     L858F

.LB227          LDA     #$02
                STA     MODFLG
                BRA     NEWTN

.LB22D          CMP     #$99
                BEQ     donew

                ORA     #$20
                CMP     "y"
                BEQ     LB227

                CMP     #$79
                BNE     NEWTN

.donew          JSR     memstate
                JMP     EDITin

.LOADfi         
                ; Doesn't zap buffer until new file is correctly loaded.
                LDA     MODFLG
                CMP     #$01
                BNE     LOADF2

                JSR     prompt
                EQUS    "Overwrite text [Y,f2]:"
                EQUB    $07
                EQUB    $EA

.LB262          JSR     newtxcont
                BNE     LB26A

                TAX
                BEQ     NEWTN

.LB26A          CMP     #$82
                BEQ     LOADF2
                AND     #$DF
                CMP     #$59
                BNE     NEWTN

.LOADF2         JSR     prompt

                EQUS    "Type filename to load:"
                EQUB    $EA

.LB28E          JSR     READNS
                LDY     #$00
                JSR     tload
                JMP     EDITgt

.SAVEfi         
                ; Save File 
                JSR     DFINIT
                CMP     #$01
                BEQ     marksa
                JSR     promtF

                EQUS    "to save:"
                EQUB    $07

.LB2AC          NOP
                JSR     READNS
                JSR     dfblok
                LDY     #$00
                JSR     tsave

                STZ     MODFLG

                LDX     TEXTP
                LDY     TEXTP+1
                JSR     GPFDXY
                JMP     NORMAX

.marksa         JSR     promtF
                EQUS    "for MARK TO CURSOR save:"
                EQUB    $07,$EA
.LB2E1          JSR     READNS
                JSR     dfblok
                LDY     #$00
                LDA     (TEMP)
                CMP     termin
                BEQ     msbad
                CMP     #$8B
                BEQ     msbad
                LDA     TEMP
                STA     scratc
                LDA     TEMP+1
                STA     scratc+1
                JSR     inSAVE
                LDX     TEXTP
                LDY     TEXTP+1
                JSR     GPFDXY
                JMP     NORMAX

.msbad          BRK
                EQUB    $01
                EQUS    "Bad use of stored name"
                EQUB    $00

.insrtF         JSR     MKREFUSE
                JSR     FINEPO
                JSR     promtF

                EQUS    "to insert:"
.LB334          NOP
                JSR     READNS
                LDA     GS
                STA     ADDR
                LDA     GS+1
                STA     ADDR+1
                LDA     GE
                LDX     GE+1
                LDY     #$00
                BIT     L807A
                JSR     pasloa

                STX     GS
                STY     GS+1
                JSR     MODIFY
                LDX     ADDR     ; Move to start of inserted file.
                LDY     ADDR+1
                JSR     GPBKXY
                JMP     NORMAL

.edSTAR         
                ; OSCLI processing
                LDA     #$01
                STA     BRKACT
                JSR     initus

                JSR     prompt
                EQUS    "Command line"
                EQUB    $EA

.starCN         JSR     OSNEWL

.starlo         LDA     "*"
                JSR     OSWRCH

; Input line of text
; OSWORD &00
; On entry:
; XY?0..1=>string buffer
; XY?2   =maximum line length (buffer size minus 1)
; XY?3   =minimum acceptable ASCII value
; XY?4   =maximum acceptable ASCII value
; On exit:
;  Cy=0 if not terminated by Escape
;  Y is the line length excluding the CR, so buffer+Y will point to the CR
;  A,X undefined
                LDA     #$00
                LDY     #$B3   ; :MSB: starCB
                LDX     #$97   ; starCB
                JSR     OSWORD
                BCS     stares
                LDA     comman ; LINBUFF (comman)
                CMP     cr
                BEQ     starex

                LDX     #$00   ; :LSB: comman
                LDY     #$05   ; :MSB: comman
                JSR     OSCLI
                BRA     starlo

.comma          EQUW    $0500
                EQUB    $EE,$20
                EQUB    $FF

.stares         JSR     ackesc

.starex         LDA     #$DA
                LDX     #$00
                JSR     OSBYTEwithY   ; Abandon VDU Queue

                JSR     VSTRNG
                EQUB    $85
                EQUB    $04
                EQUB    $03
                EQUB    $0F
                EQUB    $0D
                EQUB    $1A
                EQUB    $EA

.LB3AF          JSR     CHKSCR
                JSR     inited
                JMP     EDITco

.allowC         
                ; Allow cursor editing & softkey use. Terminated by CR.
                LDA     #$01
                STA     cursed
                JSR     initus

                JMP     CstatU

.BADMOD         BRK
                EQUB    $01

                EQUS    "Only 0,1,3,4,6,7,D or K"    ; followed by 0

.VERTTB         EQUB    $00,$00,$07,$00,$00,$0E,$00  ; plus another 0 in modelb 

.MODETB         EQUB    $00,$01,$00,$03,$04,$00,$06,$07  ; and the screen modes

.GETMOD         JSR     prompt

                EQUS    "New Mode:"
                EQUB    $EA

.LB3F7          JSR     IndOSRDCH
                JSR     OSWRCH
                CMP     #$38        ; "7" + 1
                BCS     SETKEY
                SBC     #$2F        ; "0" - 1
                BCC     BADMOD
                CMP     #$02
                BEQ     BADMOD
                CMP     #$05
                BEQ     BADMOD
                BRA     SETMOD

.SETKEY         AND     #$DF
                CMP     "D"
                BEQ     SETTUT
                CMP     "K"
                BNE     BADMOD
                LDA     #$02
                BRA     SETMOD

.SETTUT         LDA     #$05
.SETMOD         PHA
                TAY
                LDA     MODETB,Y
                PHA
                JSR     memstate
                LDA     #$82 
                JSR     OSBYTE     ; Read High Order Address
                INX
                BNE     inTUBE
                INY
                BNE     inTUBE
                PLA
                PHA
                ORA     #$80
                TAX
                LDA     #$85
                JSR     OSBYTE     ; Read base of display RAM for mode 
                                   ; entry x = mode
                                   ; exit x,y point to first byte of screen memory for mode

                CPX     GS
                TYA
                SBC     GS+1
                BCC     MODEsp

.inTUBE         PLX
                LDA     #$07
                TRB     options
                PLA
                ORA     options
                JSR     domode
                JSR     EDITmd

.OLDTEXT        LDA     oldsta+3
                CMP     PAJE + 1
                BCC     NOOLD
                CMP     HYMEM+1
                BCS     NOOLD
                CMP     oldsta+1
                BCC     NOOLD
                LDA     oldsta+1
                CMP     PAJE + 1
                BCC     NOOLD
                LDA     oldsta
                STA     ARGP
                LDA     oldsta+1
                STA     ARGP+1
                SEC
                LDA     oldsta+2
                SBC     ARGP
                TAX
                LDA     oldsta+3
                SBC     ARGP+1
                TAY
                BCC     NOOLD
                LDA     tstart
                STA     VARP
                LDA     tstart+1
                STA     VARP+1
                PHY
                PHX
                JSR     COPYBK

                PLA
                CLC
                ADC     tstart
                TAX
                PLA
                ADC     tstart+1
                TAY
                STZ     oldsta+3
                JMP     EDITgs

.MODEsp         JSR     STFILE

                BRK
                EQUB    $02
                EQUS    "No room"

.NOOLD          BRK
                EQUB    $02
                EQUS    "No old text found"
                EQUB    $00

.GETNUB         STZ     INDEX
                STZ     LINE
                STZ     LINE+1

.EDLIRE         LDY     INDEX
                LDA     (TEMP),Y
                CMP     cr
                BEQ     EDLIMV
                CMP     #$3A         ; "9" + 1
                BCS     EDLIBN
                SBC     #$2F         ; "0" - 1 
                BCC     EDLIBN
                STA     ATEMP
                LDA     #$0A         ; line = line * 10 + atemp
                LDX     #$00
                LDY     #$00
                CLC

.EDLI10         PHA
                TXA
                ADC     LINE
                TAX
                TYA
                ADC     LINE+1
                TAY
                BCS     EDLIBN
                PLA
                DEC     A
                BNE     EDLI10
                TXA
                ADC     ATEMP
                STA     LINE
                BCC     EDLNHI
                INY
                BEQ     EDLIBN

.EDLNHI         STY     LINE+1
                INC     INDEX
                BNE     EDLIRE

.EDLIMV         RTS

.EDITLI         LDA     #$01        ; Move to specified line number.
                STA     LINE
                STZ     LINE+1
                LDA     tstart
                STA     STRING
                LDA     tstart+1
                STA     STRING+1
.LOKLINE        LDA     (STRING)
                CMP     termin
                BNE     LOKLI2
                INC     LINE
                BNE     LOKLI2
                INC     LINE+1

.LOKLI2         INC     STRING
                BNE     LOKLI3
                INC     STRING+1

.LOKLI3         LDA     STRING
                CMP     GS
                LDA     STRING+1
                SBC     GS+1
                BCC     LOKLINE
                JSR     prompt
                EQUS    "At line "
                EQUB    $EA
                
.LB533          JSR     WRITELINE
                JSR     VSTRNG
                EQUS    ", new line:"
                EQUB    $EA

.LB545          JSR     stopin
                JSR     READNS
                BNE     LOLI4

.EDLIBN         BRK
                EQUB    $01
                EQUS    "Bad number"

.EDLIBL         BRK
                EQUB    $02
                EQUS    "Line not found"
                EQUB    $00

.LOLI4          JSR     GETNUB
                ; Number is held in line. Numbers start at 1 ...
                SEC
                LDA     LINE
                SBC     #$01
                STA     LINE
                LDA     LINE+1
                SBC     #$00
                STA     LINE+1
                BCC     EDLIBN
                JSR     STFILE
                JSR     MovWrdGEtoTP

.EDLIFW         LDA     LINE
                ORA     LINE+1
                BEQ     EDLIGO

.EDLICR         LDA     #$01
                JSR     TPFWDA
                BCS     EDLIBL
                LDA     ATEMP
                CMP     termin
                BNE     EDLICR
                LDA     LINE
                BNE     EDLNHD
                DEC     LINE+1

.EDLNHD         DEC     LINE
                BRA     EDLIFW

.EDLIGO         
                ; Move to BSM.
                LDA     TSM
                BNE     EDLIGJ
                LDA     #$04

.EDLIGJ         STA     SCRNY
                JMP     GPFDTP


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

.FRSTRINIT      
                ; Exit  -  Y = 0
                STZ     OUTINDEX    ; OutINDEX (BOLDRQ)
                STZ     REPLFLAG
                STZ     FIELDINDEX  ; FIELDINDEX(LINEOT)
                STZ     MMX         ; MMX (UNDRRQ);
                STZ     OFFSET
                STZ     SENSFLAG

.MININIT        STZ     INPINDEX     ; INPINDEX (CTLCHA);
                BRA     NEXTCH

.GENNEXTCH      JSR     GENBYTE

.NEXTCH         
                ; A,atemp = linbuf, inpindex +  + . Exit = Z = (A = CR)
                LDY     INPINDEX  ; INPINDEX (CTLCHA)
                LDA     LINBUFF,Y
                STA     ATEMP
                INC     INPUINDEX ; INPINDEX (CTLCHA)
                CMP     cr
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

.FINDTRANS      JSR     FRSTRINIT

.FINDPART       STZ     MULFFLAG  ; MULFFLAG (mark_count);
                                  ; Don't you know whether next object is either a 
                STZ     METAFLAG  ; star or wildcard field.
                STZ     BUTTFLAG  ; or ^
                LDA     ATEMP
                CMP     cr
                BEQ     FIPAEXIT
                CMP     "/"
                BEQ     FIPAEND
                CMP     "^"
                BNE     FIPANHA
                INC     BUTTFLAG
                BRA     FIPAMUL

.FIPANHA        CMP     "*"
                BNE     FIPANMUL

.FIPAMUL        INC     MULFFLAG   ; MULFFLAG (mark_count);
                LDX     MULTSYM    ; MULTSYM (#$80)
                JSR     GENNEXTCH

.FIPANMUL       CMP     "~"
                BNE     FIPANNOT

                LDX     NOTSYM     ; NOTSYM (#$81)
                JSR     GENNEXTCH

.FIPANNOT       CMP     "["
                BNE     FIPASIMP
                INC     SENSFLAG
                LDX     SETSYM    ; SETSYM (#$86)
                JSR     GENBYTE
                JSR     GENBYTE   ; Leave room for nextX, and remember position.
                STY     NEXTX     ; NEXTX (LASTTAB)
                JSR     NEXTCH

.FIPASELT       JSR     SIMPLEITEM
                LDA     ATEMP
                CMP     "]"
                BNE     FIPASELT
                DEC     SENSFLAG
                LDA     OUTINDEX ; OUTINDEX (BOLDRQ)
                                 ; End of set construct. Store nextx
                LDY     NEXTX    ; NEXTX (LASTTAB)
                STA     stracc,Y
                JSR     NEXTCH
                BRA     FIFIFEEL

.FIPAEND        INC     REPLFLAG
.FIPAEXIT       JSR     TERMGEN
                JSR     NEXTCH
                LDA     OUTINDEX ; OUTINDEX (BOLDRQ)
                STA     REPLINDEX ; REPLINDEX (TINDEN)
                LDA     REPLFLAG
                BNE     REPLPART
                RTS

.FIPASIMP       JSR     SIMPLEITEM

.FIFIFEEL       
                ; If last object was a field of some sort, then store the 
                ; relevant info, and update indeces as required.
                LDA     BUTTFLAG
                BEQ     FIFICO
                LDX     BUTTSYM   ; BUTTSYM (#$8B)
                JSR     GENBYTE

.FIFICO         LDA     METAFLAG
                BEQ     FIFIOFFI ; No meta-chars => not a field
                LDX     FIELDINDEX ; FIELDINDEX (LINEOT)
                CPX     #$0A
                BCS     FINDPART   ; That's enough fields.
                INC     FIELDINDEX ; FIELDINDEX (LINEOT)
                LDA     OFFSET
                STA     FIELDOFFTAB,X
                LDA     MULFFLAG   ; MULFFLAG (mark_count)
                BNE     FIFIMULF
                LDA     MMX        ; MMX (UNDRRQ)
                STA     FIELDMMXTAB,X
.FIFIOFFI       INC     OFFSET
.FINDPCH        JMP     FINDPART

.FIFIMULF       INC     MMX         ; MMX (UNDRRQ)
                LDA     MMX         ; MMX (UNDRRQ)
                CMP     #$05
                BCS     FRSTERR
                ORA     #$80
                STA     FIELDMMXTAB,X
                STZ     OFFSET
                BRA     FINDPCH

.FRSTERR        BRK
                EQUB    $01
                EQUS    "Too many find multiples"
                EQUB    $00

.REPANXCH       JSR     NEXTCH

.REPAGENB       JSR     GENBYTE

.REPLPART       LDA     #$FF
                STA     SENSFLAG
                LDA     ATEMP  ; Translate replace part of FR string.
                CMP     cr
                BEQ     TERMGEN
                LDX     FOUNDSYM  ; FOUNDSYM (#$88)
                CMP     "&"
                BEQ     REPANXCH
                CMP     "\"
                BNE     REPANS
                JSR     NEXTCH
                TAX
                BRA     REPANXCH

.REPANS         LDX     FIELDSYM   ; FIELDSYM (#$87)
                CMP     "%"
                BNE     RPNFLD
                JSR     GENBYTE
                JSR     NEXTCH
                SEC
                SBC     "0"
                BCC     FIELDERR
                CMP     FIELDINDEX  ; FIELDINDEX (LINEOT)
                BCS     FIELDERR
                TAX
                BPL     REPANXCH

.RPNFLD         JSR     CHARACTERSPECI
                STX     SIMPCHAR    ; SIMPCHAR (PBOLD)
                TXA
                BPL     REPAGENB
                LDX     ESCSYM      ; ESCSYM (#$89)
                JSR     GENBYTE
                LDX     SIMPCHAR    ; SIMPCHAR (PBOLD)
                BRA     REPAGENB

.FIELDERR       BRK
                EQUB    $01
                EQUS    "Bad replace field number"
                EQUB    $00

.TERMGEN        LDX     TERMSYM  ; Generate termsym.  TERMSYM (#$8C)
.GENBYTE        
                ; stracc, outindes + + = X
                ; Exit - metaflag set (incremented) if meta-character (field) generated.
                
                LDY     OUTINDEX     ; OUTINDEX (BOLDRQ)
                LDA     SENSFLAG
                BNE     GENBSNS
                CPX     "A"
                BCC     GENBSNS
                CPX     #$7B         ; "z" + 1
                BCS     GENBSNS
                CPX     #$5B         ; "Z" + 1
                BCC     GENBNSN
                CPX     "a"
                BCC     GENBSNS

.GENBNSN        TXA
                ORA     #$20
                TAX
                LDA     NSENSYM      ; NSENSYM (#$8A)
                STA     stracc,Y
                INY
                INC     OUTINDEX     ; OUTINDEX (BOLDRQ)
                BEQ     GENBERR

.GENBSNS        TXA
                STA     stracc,Y
                BPL     GENBNMET
                INC     METAFLAG

.GENBNMET       INC     OUTINDEX       ; OUTINDEX (BOLDRQ)
                BEQ     GENBERR
                RTS

.GENBERR        BRK
                EQUB    $01
                EQUS    "Syntax incorrect"
                EQUB    $00

.SIMPLEITEM     LDA     ATEMP
                CMP     "~"
                BNE     SIITNNOT
                LDX     NOTSYM         ; NOTSYM (#$81)
                JSR     GENBYTE
                JSR     NEXTCH
                BNE     SIITNNOT

                BRK
                EQUB    $01
                EQUS    "Error with ~"
                EQUB    $00

.SIITNNOT       CMP     "\"
                BNE     SIITNS
                INC     SENSFLAG
                JSR     NEXTCH
                BNE     SIITNM

                BRK
                EQUB    $01
                EQUS    "Error with \"
                EQUB    $00

.SIITNM         TAX
                JSR     NEXTCH
                JSR     GENBYTE
                DEC     SENSFLAG
                RTS

.SIITNS         LDX     WILDSYM         ; WILDSYM (#$82)
                CMP     "."
                BEQ     SIITWILD
                LDX     ALPHASYM        ; ALPHASYM (#$83) 
                CMP     "@"
                BEQ     SIITWILD
                LDX     DIGSYM          ; DIGSYM (#$84)
                CMP     "#"
                BNE     SIITNWIL

.SIITWILD       JSR     NEXTCH          ; Preserves X
                JMP     GENBYTE

.SIITNWIL       JSR     CHARACTERSPECI
                STX     SIMPCHAR        ; SIMPCHAR (PBOLD)
                LDA     ATEMP
                CMP     "-"
                BNE     SIITCGEN
                INC     SENSFLAG
                LDX     SUBRSYM         ; SUMRSYM (#$85)
                JSR     GENBYTE
                JSR     NEXTCH
                LDX     SIMPCHAR        ; SIMPCHAR (PBOLD)
                JSR     GENBYTE
                JSR     CHARACTERSPECI
                JSR     GENBYTE
                DEC     SENSFLAG
                RTS

.SIITCGEN       
                ; Output character as escsym ch if >= &80
                TXA
                BPL     GENBYJ
                LDX     escsym
                JSR     GENBYTE
                LDX     SIMPCHAR       ; SIMPCHAR PBOLD
.GENBYJ         JMP     GENBYTE

.CHARACTERSPECI 
                ; Exit - X = Character
                STZ     COUNT ; Add 128 count
                LDA     ATEMP
                BMI     CHSPBY
                CMP     "|"
                BNE     CHRSCO
                JSR     NEXTCH
                BEQ     CHRSER
                CMP     "!"
                BNE     CHRSSO
                INC     COUNT
                JSR     NEXTCH

.CHRSCO         CMP     "$"
                BEQ     CHSPCR
                CMP     "|"
                BNE     CHSPBY
                JSR     NEXTCH
                BEQ     CHRSER

.CHRSSO         CMP     "?"
                BNE     NOTQUE
                LDA     #$7F
                BRA     CHSPBY

.NOTQUE         BCC     CHSPBY
                AND     #$DF
                SBC     "@"
                BRA     CHSPBY

.CHSPCR         LDA     termin
.CHSPBY         PHA
                JSR     NEXTCH
                PLA
                LDY     COUNT
                BEQ     CHRSEX
                ORA     #$80
.CHRSEX         TAX
                RTS

.CHRSER         BRK
                EQUB    $01
                EQUS    "Error with |"
                EQUB    $00
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

.SEARCH         LDY     #$00
                STZ     SSTCKX             ; SSTCKX (FILL)
                LDA     MS                 ; MS (XEFF)
                STA     ME                 ; ME (DIFF)
                CMP     TEXTP
                LDA     MS + 1             ; MS + 1 (LASTSP)
                STA     ME + 1             ; ME + 1 (CENTRE)
                SBC     TEXTP+1
                BCC     SRCHCT
                LDA     TEXPFLAG
                BNE     SRCHFL
                JSR     MvetoFoundPos
                LDA     GS
                STA     STRING
                LDA     GS+1
                STA     STRING+1
                INC     TEXPFLAG
                LDA     ENDP
                STA     TEXTP
                LDA     ENDP+1
                STA     TEXTP+1
                LDY     #$00
                BRA     SRCHCT

.SRCHFL         SEC
                RTS

.SRCHL1         INC     ME              ; ME (DIFF)
                BNE     SRCHCT
                INC     ME + 1          ; ME + 1 (CENTRE)

.SRCHCT         
                ; Expects Y (= linbufX), ME --> Next char valid.
                JSR     escTST
                LDA     stracc,Y
                CMP     TERMSYM    ; TERMSYM (#$8C)
                BEQ     SRCHFD
                CMP     MULTSYM    ; MULTSYM (#$80)
                BEQ     SRCHMI
                JSR     COMPMOBJ
                BEQ     SRCHL1

.SRCHIM         
                ; Increment current multiple match, or advance MS if there
                ; isn't one. Search fales when MS reaches EOT.
                LDX     SSTCKX     ; SSTCKX (FILL)
                BNE     SRCHFM
                INC     MS         ; MS (XEFF)
                BNE     SEARCH
                INC     MS + 1     ; MS + 1 (LASTSP)
                BRA     SEARCH

.SRCHFD         LDA     MS         ; Match found. Set sstk[0] = MS. (ME - MS) ; MS (XEFF)
                STA     SSTTLOSTK
                LDA     MS + 1     ; MS + 1 (LASTSP);
                STA     SSTTHISTK
                SEC
                LDA     ME         ; ME (DIFF)
                SBC     MS         ; MS (XEFF)
                STA     SCNTLOSTK
                LDA     ME + 1     ; ME + 1 (CENTRE)
                SBC     MS + 1     ; MS + 1 (LASTSP)
                STA     SCNTHISTK
                CLC
                RTS

.SRCHFM         
                ; Let most recent multiple match accept another occurence of 
                ; find-object if one exists.
                STY     BUTTFLAG
                CLC
                LDA     SSTTLOSTK,X
                ADC     SCNTLOSTK,X
                STA     ME           ; ME (DIFF)
                LDA     SSTTHISTK,X
                ADC     SCNTHISTK,X
                STA     ME + 1       ; ME + 1 (CENTRE)
                LDA     sindexstk,X
                TAY
                JSR     COMPMOBJ
                BNE     SRCHBK
                LDX     SSTCKX       ; SSTCKX (FILL)
                INC     SCNTLOSTK,X
                BNE     SRCHL1
                INC     SCNTHISTK,X
                BRA     SRCHL1

.SRCHBK         
                ; Can't increment this mutiple-match, so backtrack to the previous one.
                ; unless its hit a ^ with count>0 in which case it continues
                LDX     BUTTFLAG
                LDA     STRACC-1,X
                CMP     BUTTSYM      ; BUTTSYM (#$8B)
                BNE     SRCHBC
                INY
                LDX     SSTCKX       ; SSTCKX (FILL)
                LDA     SCNTLOSTK,X
                ORA     SCNTHISTK,X
                BNE     SRCHCT

.SRCHBC         DEC     FILL
                BRA     SRCHIM

.SRCHMI         
                ; 'Push' a new record onto backtrack-stack. Initially accept
                ; 0 characters into multiple match.
                INC     SSTCKX       ; SSTCKX (FILL)
                LDX     SSTCKX       ; SSTCKX (FILL)
                INY
                TYA
                STA     sindexstk,X
                LDA     ME           ; ME (DIFF)
                STA     SSTTLOSTK,X
                LDA     ME + 1       ; ME + 1 (CENTRE)
                STA     SSTTHISTK,X
                STZ     SCNTLOSTK,X
                STZ     SCNTHISTK,X
                JSR     COMPMOBJ  ; Cheap way to advance Y to next find-object.
                JMP     SRCHCT

.COMDFS         PLP
.COMDFL         
                ; Have hit end of search text, so fail match.
                LDA     #$01
                RTS

.COMPMOBJ       
                ; Compares stracc,Y & (ME).
                ; Exit  - Y indexes next ssobj
                ;        EQ  Objects match.
                ;        NE  Objects don't match.
                ; Match fails if have hit end of seach text.
                LDA     ME          ; ME (DIFF)
                CMP     ENDP
                BNE     COMOCO
                LDA     ME + 1      ; ME + 1 (CENTRE)
                CMP     ENDP+1
                BEQ     COMDFL

.COMOCO         

                ; Check for & store absence/presence of notsym, then branch depending
                ; whether trying to match constant, wildcard, subrange or set item.
                LDA     stracc,Y
                CMP     NOTSYM      ; NOTSYM (#$81)
                PHP
                BNE     COMONN
                INY

.COMONN         INY
                LDA     STRACC-1,Y
                BMI     COMOME
                CMP     (ME)        ; DIFF (ME)
                BNE     CMOPRN
                BRA     CMOPRY

.COMOME         CMP     WILDSYM     ; WILDSYM (#$82)
                BEQ     CMOPRY
                CMP     NSENSYM     ; NSENSYM (#$8A)
                BEQ     CMONSEN
                CMP     ALPHASYM    ; ALPHASYM (#$83)
                BEQ     COMOAL
                CMP     BUTTSYM     ; BUTTSYM (#$8B)
                BEQ     COMDFS
                CMP     DIGSYM      ; DIGSYM (#$84)
                BEQ     CMODG1
                CMP     SUBRSYM     ; SUBRSYM (#$85)
                BEQ     CMOSUB
                ;
                ; Must be escsym ch
                ;
                CMP     #$86
                BEQ     CMOSET

                INY
                LDA     STRACC-1,Y
                CMP     (ME)        ; DIFF (ME)
                BNE     CMOPRN
                BEQ     CMOPRY

.CMOSUB         INY
                INY
                LDA     (ME)       ; DIFF (ME)
                CMP     STRACC-2,Y
                BCC     CMOPRN
                CMP     STRACC-1,Y
                BCC     CMOPRY
                BNE     CMOPRN
                BRA     CMOPRY

.CMONSEN        INY
                LDA     (ME)
                ORA     #$20
                CMP     STRACC-1,Y
                BNE     CMOPRN
                BRA     CMOPRY

.COMOAL         LDA     (ME)
                CMP     "_"
                BEQ     CMOPRY
                CMP     "A"
                BCC     CMODG2
                CMP     "z" + 1
                BCS     CMOPRN
                CMP     "Z" + 1
                BCC     CMOPRY
                CMP     "a"
                BCC     CMOPRN
                BRA     CMOPRY

.CMODG1         LDA     (ME)
.CMODG2         CMP     "0"
                BCC     CMOPRN
                CMP     #$3A          ; "9" + 1
                BCS     CMOPRN
                BRA     CMOPRY

.CMOSET         LDA     stracc,Y
                STA     NEXTX          ; NEXTX (LASTTAB)
                INY
.CMOSEL         JSR     COMPMOBJ
                BEQ     CMOSEY
                CPY     NEXTX
                BNE     CMOSEL

.CMOPRN         PLP
                RTS

.CMOSEY         LDY     NEXTX
.CMOPRY         PLA
                AND     #$02
                RTS

.CHKNREP        
                ; Check for size, then replace found string with replace string.
                ; Entry - Match just found; s*****stk[0] set up for %0 ('&')
                ;        replindex = start index of replace part in stracc
                ; Exit  - Found string replaced.
                JSR     MvetoFoundPos
                LDA     #$01
                STA     MODFLG
                LDA     ME
                STA     GE
                LDA     ME + 1
                STA     GE + 1
                LDA     REPLINDEX   ; REPLINDEX (TINDEN)
                STA     LNBUFX

.CHNRLP         LDA     GS
                CMP     MS
                LDA     GS + 1
                SBC     MS + 1
                BCS     CHNRRERR
                LDY     LNBUFX
                INC     LNBUFX
                LDA     stracc,Y
                BPL     CHNRSI
                CMP     TERMSYM      ; TERMSYM (#$8C)
                BEQ     CHNREX
                CMP     FIELDSYM     ; FIELDSYM (#$87)
                BEQ     CHNRFI
                CMP     FOUNDSYM     ; FOUNDSYM (#$88)
                BEQ     CHNRFO
                ; Must be escsym ch
                INC     LNBUFX
                LDA     STRACC+1,Y
                BRA     CHNRSI

.CHNRFO         
                ; '&' has been frigged to look like MM 0
                LDY     #$00
                BRA     CHNRAM

.CHNRFI         INC     LNBUFX
                LDA     STRACC+1,Y
                TAX
                LDA     FIELDMMXTAB,X
                BMI     CHNRMF
                TAY
                BEQ     CHNRMS
                CLC
                LDA     SSTTLOSTK,Y
                ADC     SCNTLOSTK,Y
                STA     TEMP
                LDA     SSTTHISTK,Y
                ADC     SCNTHISTK,Y
                BNE     CHNRTM

.CHNRMS         LDA     MS
                STA     TEMP
                LDA     MS + 1

.CHNRTM         STA     TEMP+1
                LDY     FIELDOFFTAB,X
                LDA     (TEMP),Y
.CHNRSI         STA     (GS)
                INC     GS
                BNE     CHNRLP
                INC     GS + 1
                BRA     CHNRLP

.CHNRRERR       BRK
                EQUB    $02
                EQUS    "No room"
                EQUB    $00

.CHNRMF         AND     #$7F
                TAY
.CHNRAM         LDA     SSTTLOSTK,Y
                STA     ARGP
                LDA     SSTTHISTK,Y
                STA     ARGP+1
                LDA     GS
                STA     VARP
                LDA     GS+1
                STA     VARP+1
                CLC
                LDA     SCNTLOSTK,Y
                TAX
                ADC     GS
                STA     GS
                LDA     SCNTHISTK,Y
                TAY
                ADC     GS+1
                STA     GS+1
                JSR     COPYBK
                JMP     CHNRLP

.CHNREX         RTS

                ; Find-Replace & Global-Replace should have their own seperate command
                ; keys, with the first delimeter 'built in' (i.e. not required), and CR
                ; sufficing as terminator -
                ; FR/ ....... [/.......] <CR>
                ; GR/ .......  /.......  <CR>

.GETRESP 
                ; Exit - A holds char - forced to lower case - read from keyboard
                JSR     EDRDCH
                ORA     #$20
                RTS

.MvetoFoundPos  LDX     MS
                LDY     MS + 1
                JMP     GPFDXY

.GLOBALREP      JSR     DFINIT
                JSR     prompt
                EQUS    "Global replace:"
                EQUB    $EA

.LBA52          JSR     READLS
                JSR     readIN
                BNE     NEWGR
                CMP     GRBUFF
                BEQ     NOBUFF

.OLDGR          LDA     GRBUFF,Y
                STA     (TEMP),Y
                INY
                BPL     OLDGR
                LDY     #$00

.NEWGR          LDA     (TEMP),Y
                STA     GRBUFF,Y
                INY
                CPY     #$64
                BNE     NEWGR
                JSR     FINDTRANS
                JSR     dfblok
                STZ     LINE
                STZ     LINE+1
                STZ     TEXPFLAG

.GREPLP         LDX     GE
                LDY     GE+1
                
.GREPNX         STX     MS
                STY     MS + 1
                JSR     SEARCH
                BCS     GREPEX
                INC     LINE
                BNE     GREPNH
                INC     LINE+1

.GREPNH         LDA     REPLFLAG
                BNE     GREPRP
                LDX     ME
                LDY     ME + 1
                BRA     GREPNX

.GREPRP         JSR     CHKNREP
                BRA     GREPLP

.GREPEX         
                ;Move cursor (as near as possible) to the place it started at, then
                ;output match count.
                LDX     STRING
                LDY     STRING+1
                JSR     GPBKXY
                JSR     NORMAL
                JSR     SCRNUD
.LBAAE          LDX     PRMPTL
                INX
                JSR     PRMPTX
                EQUS    " "
                EQUB    $EA

.LBAB7          JSR     WRITELINE
                JSR     PRMPTX
                EQUS    " found"
                EQUB    $EA
.LBAC4          RTS

.NOBUFF         BRK
                EQUB    $01
                EQUS    "No previous string"
                EQUB    $00

.FINDREPLACE    JSR     prompt
                EQUS    "Find and replace:"
                EQUB    $EA

.LBAEF          STZ     L0753    ; TODO find if there is a name for this
                JSR     READLS

                JSR     readIN
                BNE     NEWFR
                CMP     FRBUFF
                BEQ     NOBUFF

.OLDFR          LDA     FRBUFF,Y
                STA     (TEMP),Y
                INY
                BPL     OLDFR
                LDY     #$00

.NEWFR          LDA     (TEMP),Y
                STA     FRBUFF,Y
                INY
                CPY     #$64
                BNE     NEWFR
                JSR     FINDTRANS
                JSR     TEMPSX
                JSR     FINEPO
                LDA     LINE
                STA     SCRNX
                ;Set up search termination pointer & flag. 
                LDA     TMAX
                STA     TEXTP
                STA     ENDP
                LDA     TMAX+1
                STA     TEXTP+1
                STA     ENDP+1
                STA     TEXPFLAG

.IMRPRL         LDX     GE
                LDY     GE+1

.IMRPCL         STX     MS
                STY     MS + 1
                JSR     SEARCH
                BCS     IMRPNF
                JSR     MvetoFoundPos
                INC     LINE
                BNE     LBB44

                INC     LINE+1
.LBB44          LDA     L0753
                BNE     IMRPRP
                JSR     NORMAX ; get position of X back
                LDA     BSM    ; Move to BSM
                STA     SCRNY
                JSR     SCRNUD

                LDA     FULLSCREEN   ; FULLSCREEN (#$05)
                STA     UPDATE
                JSR     RepContPrompt

                JSR     CSRSCR
                JSR     CURON

.IMRPPR         JSR     GETRESP
                CMP     "c"
                BNE     IMRPNC
                STA     L0753
                LDA     #$01
                STA     LINE
                STZ     LINE+1
                JSR     MKREFUSE

                LDA     REPLFLAG
                BNE     LBB7C

                JSR     ReplPrompt

                INC     REPLFLAG
.LBB7C          JMP     IMRPRP

.IMRPNC         CMP     "r"
                BNE     LBB89
                LDX     ME
                LDY     ME + 1
                BRA     IMRPCL

.LBB89          CMP     #$72
                BNE     IMRPPR
                JSR     MKREFUSE
                ; Either use supplied replace part, or prompt for one.

                LDA     REPLFLAG
                BNE     IMRPRP
                JSR     ReplPrompt

.IMRPRP         JSR     CHKNREP
                JMP     IMRPRL

.IMRPNF         JSR     NORMAL
                LDA     THELOT       ; THELOT (#$06)
                STA     UPDATE
                JSR     SCRNUD
                JSR     STATUS
                LDA     L0753
                BEQ     NotFoundPrompt
                JMP     LBAAE

.NotFoundPrompt LDX     PRMPTL
                INX
                JSR     PRMPTX
                EQUS    " Not found"
                EQUB    $EA,$60

.WRITELINE      JSR     startI
                LDX     #$04
                STX     STRING
.WOPRNEXT       STZ     STRING+1
.WOPRLOOP       SEC
                LDA     LINE
                SBC     WOPTBL,X
                TAY
                LDA     LINE+1
                SBC     WOPTBH,X
                BCC     WOPRDIGI
                STY     LINE
                STA     LINE+1
                INC     STRING+1
                BRA     WOPRLOOP

.WOPRDIGI       LDA     STRING+1
                BNE     WOPRGEN

                DEC     STRING
                BPL     WOPRCONT

.WOPRGEN        ORA     #$30
                JSR     OSWRCH

                STZ     STRING
.WOPRCONT       DEX
                BPL     WOPRNEXT

                RTS

.WOPTBL         EQUB    $01,$0A,$64,$E8,$10
;               = :LSB: 1
;               = :LSB: 10
;               = :LSB: 100
;               = :LSB: 1000
;               = :LSB: 10000

.WOPTBH         EQUB    $00,$00,$00,$03,$27
;               = :MSB: 1
;               = :MSB: 10
;               = :MSB: 100
;               = :MSB: 1000
;               = :MSB: 10000

                ;Marks are stored in SMATlo,hi (Set Mark Address Table), where the
                ;addresses refer to positions in the 2nd half of text; when updated
                ;(any number of times), this address is translated into a value in
                ;UMATlo,hi (Used Mark Address Table), where the addresses refer to
                ;positions in the text as it is currently partitioned.

.MARKUPDATE         
                ;Update marks for current position of gap. 
                ;Exit - marksbeforecst =    No. of marks before GE.
                JSR     MKUDCH

.MKUDKN         STZ     MARKSB
                LDX     MARKX

.MKUDLP         DEX
                BMI     MKUDEX
                LDY     SMATLO,X
                STY     UMATLO,X
                CPY     GE
                LDA     SMATHI,X
                STA     UMATHI,X
                SBC     GE+1
                BCS     MKUDLP
                INC     MARKSB
                SEC
                TYA
                SBC     CHUNKS      ; CHUNKS (JUSLEN)
                STA     UMATLO,X
                LDA     UMATHI,X
                SBC     CHUNKS + 1
                STA     UMATHI,X
                BCS     MKUDLP

.MKUDEX         RTS

.MKUDCH         
                ;chunksize :=  size of gap to correct for.
                SEC
                LDA     GE
                SBC     GS
                STA     CHUNKS
                LDA     GE+1
                SBC     GS+1
                STA     CHUNKS + 1
                RTS

.CLRMAK         
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
                CPX     #$02
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

.CLRMCO         LDA     MARKX
                STA     NUMMAR
                STZ     MARKX
                JSR     STATUS
                LDA     NUMMAR
.MKRFEX         RTS

.MKREFUSE       
                ;Complain if any marks are set.
                LDA     MARKX
                BEQ     MKRFEX
                BRK
                EQUB    $01
                EQUS    "Mark(s) set"
                EQUB    $00

.NMBLOK         
                ;Normalizes a marked block of text, to ease use.
                ;Entry  -  Marks updated (gap fine positioned). TEXP =       GE
                ;Exit   -  'Bad marking' error if 2 marks were set.
                ;       -  EQ - 0 marks were set.
                ;          NE - 1 mark was set (csr-mark or mark-csr):
                ;               Gap moved to start of block,
                ;               XY =       end of block.
                LDA     GE
                STA     TEXTP
                LDA     GE+1
                STA     TEXTP+1
                LDA     NUMMAR
                BEQ     NBLKEX
                CMP     #$01
                BNE     BADMARK
                LDX     UMATLO
                LDY     UMATHI
                DEC     MARKSB
                BNE     NBLKEX
                JSR     GPBKXY
                LDX     TEXTP
                LDY     TEXTP+1
.NBLKEX         RTS

.DFINIT         
                ;Seperated this way to avoid grotty comand-line escape. 
                JSR     TEMPSX
                JSR     CLRMAK
                CMP     #$02
                BEQ     BADMARK
                PHA
                LDA     LINE
                STA     SCRNX
                PLA
                RTS

.dfblok         
                ;Normalize a 'marked' block (defaulting to whole) of text.
                ;Exit  -  TEXP =       Old cursor position (in end of text).
                ;         ENDP =       End of 'marked' block.
                JSR     NMBLOK
                BNE     DBLKEP
                JSR     STFILE
                LDX     TMAX
                LDY     TMAX+1

.DBLKEP         STX     ENDP
                STY     ENDP+1
.DBLKEPX        RTS

.MVBLOK         
                ;Ensure good marking (m-m-c or c-m-m) for a block 'move-op'
                ;Exit  -  CC: marks are after cursor
                ;         CS: marks are before cursor
                JSR     CLRMAK
                CMP     #$02
                BNE     BADMARK
                ;if 2nd mark on cursor then shift it to GS
                LDA     UMATLO+1
                CMP     GE
                BNE     MVBLOJ
                LDA     UMATHI+1
                CMP     GE+1
                BNE     MVBLOJ
                LDA     GS
                STA     UMATLO+1
                LDA     GS+1
                STA     UMATHI+1
                INC     MARKSB
                
.MVBLOJ         LDA     MARKSB
                DEC     A         ; cmp#1
                BNE     DBLKEPX

.BADMARK        BRK
                EQUB    $01
                EQUS    "Bad marking"
                EQUB    $00

.SETMARK        JSR     FINEPO
                LDX     MARKX
                CPX     #$02
                BEQ     BADMARK
                ;Save mark address.
                LDA     GE
                STA     SMATLO,X
                LDA     GE+1
                STA     SMATHI,X
                JSR     NORMAL
                INC     MARKX
                JMP     STATUS

.CLEARMARKS     JSR     CLRMAK
                JMP     NORMAL

.MKDEL          JSR     CLRMAK
                JSR     NMBLOK
                BEQ     BADMARK ;Stop delete from defaulting to 'NEW' !
                STX     GE
                STY     GE+1
                JSR     MODIFY

.NORMAX         JSR     NORMAL
                LDA     STRING
                STA     SCRNX
                RTS

.MKCPY          
                ;Marked copy. Either m-m-c or c-m-m
                JSR     MVBLOK
                ;XY =    (Mark2 - Mark1) - size of block to be copied.
                SEC
                LDA     UMATLO+1
                SBC     UMATLO
                TAX
                LDA     UMATHI+1
                SBC     UMATHI
                TAY
                LDA     MARKSB
                BEQ     MKCPYO
                STX     STRING
                STY     STRING+1
                SEC
                LDA     SMATLO
                SBC     STRING
                STA     SMATLO
                LDA     SMATHI
                SBC     STRING+1
                STA     SMATHI
                LDA     SMATLO+1
                SBC     STRING
                STA     SMATLO+1
                LDA     SMATHI+1
                SBC     STRING+1
                STA     SMATHI+1

.MKCPYO         JSR     CHECKR
                ;Copy the block, then normalize text.
                LDA     UMATLO
                STA     ARGP
                LDA     UMATHI
                STA     ARGP+1
                STX     GE
                STX     VARP
                STY     GE+1
                STY     VARP+1
                JSR     CPFD2
                LDX     #$01
                STX     MODFLG
                INX
                STX     MARKX
                JSR     STATUS
                JMP     NORMAL

.MKMVE          
                ;If marks are before cursor, then do a bit of tweaking to
                ;change it into case where they are after it.
                JSR     MVBLOK
                ;Initialize pointers for iterative swap block routine.
                LDX     UMATLO
                LDY     UMATHI
                LDA     MARKSB
                BEQ     MVBEFC
                STX     ARGP
                STY     ARGP+1
                LDA     UMATLO+1
                STA     VARP
                LDA     UMATHI+1
                STA     VARP+1
                LDX     GS
                LDY     GS+1
                BRA     MVSTP3

.MVBEFC         STX     VARP
                STY     VARP+1
                LDA     GE
                STA     ARGP
                LDA     GE+1
                STA     ARGP+1
                LDX     UMATLO+1
                LDY     UMATHI+1

.MVSTP3         STX     ENDP
                STY     ENDP+1
                
.MVLOOP         SEC
                LDA     VARP
                SBC     ARGP
                STA     SIZE
                LDA     VARP+1
                SBC     ARGP+1
                STA     SIZE+1
                LDA     ENDP
                SBC     VARP
                TAX
                LDA     ENDP+1
                SBC     VARP+1
                TAY
                CPX     SIZE
                SBC     SIZE+1
                BCS     MV2GE
                STX     SIZE
                STY     SIZE+1
                
.MV2GE          LDA     SIZE
                ORA     SIZE+1
                BEQ     MVNORM
                BCS     MV2GE1
                LDX     VARP
                LDY     VARP+1
                JSR     MVSWAP
                CLC
                TYA
                ADC     TEMP
                STA     ARGP
                LDA     null
                ADC     TEMP+1
                STA     ARGP+1
                BCC     MVLOOP

.MV2GE1         SEC
                LDA     ENDP
                SBC     SIZE
                STA     ENDP
                TAX
                LDA     ENDP+1
                SBC     SIZE+1
                STA     ENDP+1
                TAY
                JSR     MVSWAP
                BRA     MVLOOP

.MVNORM         LDA     FULLSCREEN   ; FULLSCREEN (#$05)
                STA     UPDATE
                JSR     NORMAL
                JMP     MODIFY

.MVSWAP         
                ;Swap size bytes ARGP <-> XY 
                LDA     ARGP
                STA     TEMP
                LDA     ARGP+1
                STA     TEMP+1
                STX     ADDR
                STY     ADDR+1
                INC     SIZE+1    ;TO allow dec to zero below.
                LDY     null
                
.MVNINC         CPY     SIZE
                BNE     MVSWLP
                DEC     SIZE+1
                BEQ     TEMPSE

.MVSWLP         LDA     (TEMP),Y
                TAX
                LDA     (ADDR),Y
                STA     (TEMP),Y
                TXA
                STA     (ADDR),Y
                INY
                BNE     MVNINC
                INC     TEMP+1
                INC     ADDR+1
                BRA     MVNINC

.TEMPSX         LDA     SCRNX
                STA     LINE
                LDA     CURRLEN
                CMP     SCRNX
                BCS     TEMPSE
                STA     SCRNX
.TEMPSE         RTS

.RepContPrompt  JSR     prompt
                EQUS    "C(ontinue), E(nd of file replace), R(eplace) or ESCAPE"
                EQUB    $EA

.LBE78          RTS

.ReplPrompt     JSR     prompt
                EQUS    "Replace by:"
                EQUB    $EA

.LBE88          JSR     READLS
                JSR     readIN
                JSR     MININIT
                LDA     TINDEN
                STA     BOLDRQ
                JMP     REPLPART

                EQUS    ".he"

                EQUB    $0D

                EQUS    ".en"

                EQUB    $0D

                EQUS    ".fo"

                EQUB    $0D

                EQUS    ".ce"

                EQUB    $0D

                EQUS    "Page .r0"

                EQUB    $0D

                EQUS    ".ff.en"

                EQUB    $0D

                EQUS    ".he"

                EQUB    $0A

                EQUS    ".en"

                EQUB    $0A

                EQUS    ".fo"

                EQUB    $0A

                EQUS    ".ce"

                EQUB    $0A

                EQUS    "Page .r0"

                EQUB    $0A

                EQUS    ".ff.en"

                EQUB    $0A,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
                EQUB    $FF

.BeebDisEndAddr
SAVE "edit150.bin",BeebDisStartAddr,BeebDisEndAddr

