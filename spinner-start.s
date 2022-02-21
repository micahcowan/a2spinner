.import _Input, _End, _Size

Mon_ZP_KSWL = $38
Mon_ZP_KSWH = $39

.segment "STARTUP"

_Setup:
	; copy $900- to $300-
        ; (because we'll be overwritten by
        ; any basic program created)
        ldy #0
@Loop:	lda $900,y
	sta $300,y
        cpy #.lobyte(_End - _Input)
        beq @Install
        iny
        jmp @Loop
        
@Install:
	; install our spinner KSW
	lda #<$300
        sta Mon_ZP_KSWL
        lda #>$300
        sta Mon_ZP_KSWH
        jmp $E000
