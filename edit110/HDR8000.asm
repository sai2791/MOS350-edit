        TTL     Header file LO-Edit (CMOS)      > HDR8000


        ORG     &8000   ; Object destination address

        ; ------------------------------------------------------------ ;
        ; *** Assembly options

        GBLS    $vers
$vers   SETS    "1.24"  ; No more than 4 characters

phil    *       0       ; assemble with phil's version of "cursor editing"
mouse   *       0       ; assemble with MOUSE options
lerror  *       1       ; assemble with long error box
syzygy  *       1       ; 'A SYZYGY prog' displayed
stamp   *       0       ; date stamping

                        ; must always be present on non-MASTER machines
dchars  *       1       ; assemble with character definitions

shortm  *       1       ; shorter messages (to fit into ROM)
cF8key  *       1       ; ctrl-f8 toggle (cr/lf)
lfver   *       0       ; linefeed version
curtyp  *       1       ; different cursor types

lfarro  *       1       ; linefeed arrow
extgf   *       0       ; extended find/replace text


reladd  *       0       ; relocation address provided

        ; ------------------------------------------------------------ ;

        LNK     EDIT00
