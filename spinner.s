;#resource "spinner-8bws.cfg"
;#define CFGFILE spinner-8bws.cfg
;#link "spinner-start.s"

.macpack apple2

Mon_ZP_RNDL	= $4E
Mon_ZP_RNDH	= $4F
Mon_KEYIN2	= $FD21
Mon_ZP_CH	= $24
Mon_ZP_BASL	= $28
KBD		= $C000
KBDSTRB		= $C010


.org $300
.export _Input
_Input:
	; Check for keypresses, and
        ;   animate the cursor!
        jsr Tick
@KEYIN:	inc Mon_ZP_RNDL
	bne @KEYIN2
	inc Mon_ZP_RNDH
        jsr Tick ; every 256 key-checks!
@KEYIN2:bit KBD
	bpl @KEYIN
	sta (Mon_ZP_BASL),y
	lda KBD
	bit KBDSTRB
	rts
        
pCountDownVal = $16
pvCounter:
	.byte $00
pvIter:
	.byte $00
pvChars:
	scrcode "I/-\"
pvCharsEnd:
Tick:
	pha
        tya
        pha
        
	; draw the spinner character
        ldy pvIter
        lda pvChars,y
        ldy Mon_ZP_CH
        sta (Mon_ZP_BASL),y
        ; count down to next frame of "spinner"
        ; (even though we're only called every
        ; 256 key-checks, that's still way too
        ; fast for the animation, so we count off
        ; how many times 256 key-checks have been
        ; done until we're satisfied it's
        ; long enough).
        ldy pvCounter
        dey
        sty pvCounter
        bpl @NoTrigger ; countdown triggered? no, skip
        ldy #pCountDownVal	; yes, reset counter and
        sty pvCounter		; advance the spinner for next frame

	ldy pvIter
        iny
        cpy #pvCharsEnd - pvChars
        bne @StY
        ldy #$00
@StY:   sty pvIter
@NoTrigger:
        
        pla
        tay
        pla
        
	rts
.export _End
_End:
.export _Size
_Size = _End - _Input
