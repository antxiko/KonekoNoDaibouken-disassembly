; ==========================================================================
; KONEKO NO DAIBOUKEN - ROM de 32 KB en 0x4000
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x04000


; ----------------------------------------------------------------------
; DATOS cabecera: La cabecera del cartucho: "AB" e INIT 0x4010
;   0x4000..0x4010  (16 bytes)
DATA_cabecera:
	defb 041h,042h,010h,040h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 4000  AB.@............

; ======================================================================
; CODIGO 0x4010..0x4038  (40 bytes)
; ======================================================================


init:		; INIT: pone el cartucho tambien en la pagina 2 (RSLREG, la tabla de slots expandidos y ENASLT con H = 0x80) y salta a 0x8000
	di			;4010   ; sin interrupciones
	call 00041h		;4011   ; DISSCR
	call 00138h		;4014   ; RSLREG: el slot de la pagina 1...
	rrca			;4017   ; el de la pagina 1 (bits 2-3)...
	rrca			;4018
	and 003h		;4019   ; ...sus dos bits
	ld c,a			;401b
	ld b,000h		;401c
	ld hl,0fcc1h		;401e   ; EXPTBL: expandido?
	add hl,bc			;4021
	ld c,a			;4022
	ld a,(hl)			;4023
	and 080h		;4024   ; el bit de expandido
	or c			;4026
	ld c,a			;4027
	inc hl			;4028
	inc hl			;4029
	inc hl			;402a
	inc hl			;402b
	ld a,(hl)			;402c   ; el subslot
	and 00ch		;402d
	or c			;402f
	ld h,080h		;4030   ; la pagina 2
	call 00024h		;4032   ; ENASLT
	jp arranque		;4035   ; al codigo

; ----------------------------------------------------------------------
; DATOS mapas: Los mapas: las pantallas de cada fase (0x4038: 18 punteros a
;   listas, 0x405C-0x4113, con la pantalla de cada posicion 0xE03E), la tabla
;   de las 104 pantallas (0x4114) y las pantallas (0x41E4-0x56BF; las demas,
;   en 0xA840): el fondo, el suelo, las tiras de casillas, los rectangulos y
;   los dibujos
;   0x4038..0x56c0  (5768 bytes)
DATA_mapas:
	defb 05ch,040h,066h,040h,070h,040h,07ah,040h,084h,040h,08eh,040h,098h,040h,0a2h,040h	; 4038  \@f@p@z@.@.@.@.@
	defb 0aeh,040h,0b8h,040h,0c2h,040h,0cch,040h,0d6h,040h,0e0h,040h,0eah,040h,0f6h,040h	; 4048  .@.@.@.@.@.@.@.@
	defb 000h,041h,00ah,041h,000h,001h,002h,003h,004h,005h,006h,007h,060h,000h,010h,011h	; 4058  .A.A........`...
	defb 012h,013h,014h,015h,016h,017h,061h,000h,020h,021h,022h,023h,024h,025h,026h,027h	; 4068  ......a. !"#$%&'
	defb 062h,000h,030h,031h,032h,033h,034h,035h,036h,037h,063h,000h,050h,051h,052h,053h	; 4078  b.01234567c.PQRS
	defb 054h,055h,056h,057h,065h,000h,040h,041h,042h,043h,044h,045h,046h,047h,064h,000h	; 4088  TUVWe.@ABCDEFGd.
	defb 004h,005h,006h,007h,008h,009h,00ah,00bh,060h,000h,014h,015h,016h,017h,018h,019h	; 4098  ........`.......
	defb 01ah,01bh,061h,066h,061h,000h,024h,025h,026h,027h,028h,029h,02ah,02bh,062h,000h	; 40a8  ..afa.$%&'()*+b.
	defb 030h,031h,032h,033h,034h,035h,036h,037h,063h,000h,054h,055h,056h,057h,058h,059h	; 40b8  01234567c.TUVWXY
	defb 05ah,05bh,065h,000h,044h,045h,046h,047h,048h,049h,04ah,04bh,064h,000h,008h,009h	; 40c8  Z[e.DEFGHIJKd...
	defb 00ah,00bh,00ch,00dh,00eh,00fh,060h,000h,018h,019h,01ah,01bh,01ch,01dh,01eh,01fh	; 40d8  ......`.........
	defb 061h,0ffh,028h,029h,02ah,02bh,02ch,02dh,02eh,02fh,062h,067h,062h,0ffh,030h,031h	; 40e8  a.()*+,-./bgb.01
	defb 032h,033h,034h,035h,036h,037h,063h,000h,058h,059h,05ah,05bh,05ch,05dh,05eh,05fh	; 40f8  234567c.XYZ[\]^_
	defb 065h,000h,048h,049h,04ah,04bh,04ch,04dh,04eh,04fh,064h,0ffh,022h,042h,04ch,042h	; 4108  e.HIJKLMNOd."BLB
	defb 06dh,042h,0b5h,042h,0e3h,042h,00dh,043h,05eh,043h,0d9h,043h,007h,044h,0b5h,042h	; 4118  mB.B.B.C^C.C.D.B
	defb 047h,044h,085h,044h,0d1h,044h,025h,045h,05eh,043h,00dh,043h,07fh,045h,023h,046h	; 4128  GD.D.D%E^C.C.E#F
	defb 0c8h,046h,082h,047h,0c7h,047h,067h,048h,00ch,049h,0bah,049h,00fh,04ah,067h,048h	; 4138  .F.G.GgH.I.I.JgH
	defb 0abh,04ah,0bah,049h,07fh,045h,079h,04bh,00ch,049h,026h,04ch,0bch,04ch,0eeh,04ch	; 4148  .J.I.EyK.I&L.L.L
	defb 043h,04dh,085h,04dh,0c6h,04dh,015h,04eh,059h,04eh,08eh,04eh,0c2h,04eh,0efh,04eh	; 4158  CM.M.M.NYN.N.N.N
	defb 012h,04fh,029h,04fh,06ah,04fh,09fh,04fh,0e0h,04fh,0fdh,04fh,06ah,050h,098h,050h	; 4168  .O)OjO.O.O.OjP.P
	defb 0cah,050h,004h,051h,02eh,051h,060h,051h,004h,051h,09eh,051h,06ah,050h,098h,050h	; 4178  .P.Q.Q`Q.Q.QjP.P
	defb 0cah,050h,004h,051h,02eh,051h,060h,051h,004h,051h,09eh,051h,02ch,052h,08fh,052h	; 4188  .P.Q.Q`Q.Q.Q,R.R
	defb 0f8h,052h,06dh,053h,01fh,054h,08dh,054h,00ch,055h,072h,055h,06dh,053h,06dh,053h	; 4198  .RmS.T.T.UrUmSmS
	defb 01fh,054h,0fbh,055h,05bh,056h,040h,0a8h,040h,0a8h,0fbh,055h,0eeh,0a8h,021h,0a9h	; 41a8  .T.U[V@.@..U..!.
	defb 04ah,0a9h,08ch,0a9h,0e2h,0a9h,02eh,0aah,084h,0aah,0d5h,0aah,017h,0abh,04ah,0abh	; 41b8  J.............J.
	defb 0a5h,0abh,0e2h,0abh,03dh,0ach,06bh,0ach,0e9h,0ach,017h,0adh,0e4h,041h,005h,042h	; 41c8  ....=.k......A.B
	defb 041h,050h,0d4h,051h,0b0h,0a8h,05eh,0adh,093h,04ch,080h,0bfh,0b2h,000h,00fh,000h	; 41d8  AP.Q..^..L......
	defb 020h,005h,011h,000h,020h,004h,0ffh,0ffh,00bh,00dh,09ah,0afh,00ch,00eh,0a6h,0afh	; 41e8   ... ...........
	defb 004h,005h,060h,050h,009h,008h,077h,045h,006h,018h,060h,050h,0ffh,0b2h,000h,00eh	; 41f8  ..`P..wE..`P....
	defb 000h,020h,005h,011h,000h,020h,004h,0ffh,0ffh,00bh,00dh,09ah,0afh,00ch,00eh,0a6h	; 4208  . ... ..........
	defb 0afh,003h,006h,060h,050h,006h,016h,060h,050h,0ffh,0b2h,000h,00fh,000h,020h,005h	; 4218  ...`P..`P..... .
	defb 011h,000h,020h,004h,0ffh,00ch,015h,001h,005h,053h,0ffh,009h,014h,068h,045h,00dh	; 4228  .. ......S...hE.
	defb 013h,073h,045h,00dh,016h,073h,045h,005h,007h,077h,045h,007h,00fh,060h,050h,006h	; 4238  .sE..sE..wE..`P.
	defb 01ah,060h,050h,0ffh,0b2h,000h,00fh,000h,020h,005h,011h,000h,020h,004h,0ffh,0ffh	; 4248  .`P..... ... ...
	defb 00ah,006h,094h,0aeh,009h,00dh,09fh,0aeh,007h,015h,099h,0aeh,00ah,01ch,099h,0aeh	; 4258  ................
	defb 003h,008h,060h,050h,0ffh,0b2h,000h,00fh,000h,020h,005h,011h,000h,020h,004h,0ffh	; 4268  ..`P..... ... ..
	defb 007h,008h,001h,00ah,053h,009h,011h,001h,008h,053h,00bh,019h,001h,006h,053h,0ffh	; 4278  ....S....S....S.
	defb 004h,007h,068h,045h,006h,010h,068h,045h,008h,018h,068h,045h,00ah,006h,073h,045h	; 4288  ..hE..hE..hE..sE
	defb 00dh,006h,073h,045h,009h,009h,073h,045h,00ch,009h,073h,045h,00bh,00fh,073h,045h	; 4298  ..sE..sE..sE..sE
	defb 00bh,012h,073h,045h,00dh,017h,073h,045h,00dh,01ah,073h,045h,0ffh,0b2h,000h,00fh	; 42a8  ..sE..sE..sE....
	defb 000h,020h,005h,011h,000h,020h,004h,0ffh,008h,009h,001h,009h,053h,0ffh,005h,008h	; 42b8  . ... ......S...
	defb 068h,045h,00bh,007h,073h,045h,00ah,00ah,073h,045h,00ah,00fh,094h,0aeh,00ah,012h	; 42c8  hE..sE..sE......
	defb 094h,0aeh,006h,016h,099h,0aeh,003h,01bh,09fh,0aeh,0ffh,0b2h,000h,00fh,000h,020h	; 42d8  ............... 
	defb 005h,011h,000h,020h,004h,0ffh,008h,009h,001h,009h,053h,0ffh,005h,008h,068h,045h	; 42e8  ... ......S...hE
	defb 00bh,007h,073h,045h,00ch,00ah,073h,045h,003h,000h,09fh,0aeh,008h,010h,099h,0aeh	; 42f8  ..sE..sE........
	defb 005h,019h,099h,0aeh,0ffh,0b2h,000h,00fh,000h,020h,005h,011h,000h,020h,004h,0ffh	; 4308  ......... ... ..
	defb 00ch,006h,001h,005h,053h,009h,00ch,001h,008h,053h,005h,013h,001h,00ch,053h,008h	; 4318  ....S....S....S.
	defb 01ah,001h,009h,053h,0ffh,009h,005h,068h,045h,006h,00bh,068h,045h,002h,012h,068h	; 4328  ...S...hE..hE..h
	defb 045h,005h,019h,068h,045h,00dh,004h,073h,045h,00eh,007h,073h,045h,00ch,00ah,073h	; 4338  E..hE..sE..sE..s
	defb 045h,00ch,00dh,073h,045h,009h,011h,073h,045h,00ah,014h,073h,045h,00ch,018h,073h	; 4348  E..sE..sE..sE..s
	defb 045h,00bh,01bh,073h,045h,0ffh,0b2h,000h,00fh,000h,020h,005h,011h,000h,020h,004h	; 4358  E..sE..... ... .
	defb 0ffh,005h,003h,001h,00ch,053h,00dh,007h,001h,004h,053h,009h,00bh,001h,008h,053h	; 4368  .....S....S....S
	defb 006h,010h,001h,00bh,053h,008h,016h,001h,009h,053h,00ah,01bh,001h,008h,053h,0ffh	; 4378  ....S....S....S.
	defb 002h,002h,068h,045h,00ah,006h,068h,045h,006h,00ah,068h,045h,003h,00fh,068h,045h	; 4388  ..hE..hE..hE..hE
	defb 005h,015h,068h,045h,007h,01ah,068h,045h,00ch,001h,073h,045h,008h,001h,073h,045h	; 4398  ..hE..hE..sE..sE
	defb 007h,004h,073h,045h,00eh,005h,073h,045h,00eh,008h,073h,045h,00ah,009h,073h,045h	; 43a8  ..sE..sE..sE..sE
	defb 00ah,00ch,073h,045h,008h,00eh,073h,045h,00ch,00eh,073h,045h,00ah,011h,073h,045h	; 43b8  ..sE..sE..sE..sE
	defb 00ch,014h,073h,045h,00bh,017h,073h,045h,00eh,019h,073h,045h,00ch,01ch,073h,045h	; 43c8  ..sE..sE..sE..sE
	defb 0ffh,0b2h,000h,00fh,000h,020h,005h,011h,000h,020h,004h,0ffh,008h,014h,001h,009h	; 43d8  ..... ... ......
	defb 053h,0ffh,003h,005h,060h,050h,005h,013h,068h,045h,00dh,012h,073h,045h,00bh,015h	; 43e8  S...`P..hE..sE..
	defb 073h,045h,00ch,005h,099h,0aeh,009h,00ch,094h,0aeh,008h,01ah,099h,0aeh,0ffh,0b2h	; 43f8  sE..............
	defb 000h,00fh,000h,020h,005h,011h,000h,020h,004h,0ffh,00ch,007h,001h,005h,053h,009h	; 4408  ... ... ......S.
	defb 00dh,001h,008h,053h,009h,018h,001h,008h,053h,0ffh,009h,006h,068h,045h,006h,00ch	; 4418  ...S....S...hE..
	defb 068h,045h,006h,017h,068h,045h,00dh,005h,073h,045h,00dh,008h,073h,045h,00bh,00bh	; 4428  hE..hE..sE..sE..
	defb 073h,045h,00bh,00eh,073h,045h,00ch,016h,073h,045h,00ah,019h,073h,045h,0ffh,0b2h	; 4438  sE..sE..sE..sE..
	defb 000h,00fh,000h,020h,005h,011h,000h,020h,004h,0ffh,00eh,00bh,001h,003h,053h,0ffh	; 4448  ... ... ......S.
	defb 00bh,00ah,068h,045h,00eh,009h,073h,045h,00eh,00ch,073h,045h,00bh,000h,099h,0aeh	; 4458  ..hE..sE..sE....
	defb 009h,005h,099h,0aeh,007h,00ah,099h,0aeh,00bh,011h,099h,0aeh,00ah,01ah,099h,0aeh	; 4468  ................
	defb 003h,004h,077h,045h,003h,010h,060h,050h,007h,015h,060h,050h,0ffh,0b2h,000h,00fh	; 4478  ..wE..`P..`P....
	defb 000h,020h,005h,011h,000h,020h,004h,0ffh,005h,009h,001h,00ch,053h,005h,011h,001h	; 4488  . ... ......S...
	defb 00ch,053h,005h,019h,001h,00ch,053h,0ffh,002h,008h,068h,045h,002h,010h,068h,045h	; 4498  .S....S...hE..hE
	defb 002h,018h,068h,045h,007h,007h,073h,045h,00ch,007h,073h,045h,007h,00ah,073h,045h	; 44a8  ..hE..sE..sE..sE
	defb 00ch,00ah,073h,045h,009h,00fh,073h,045h,007h,012h,073h,045h,00ah,017h,073h,045h	; 44b8  ..sE..sE..sE..sE
	defb 006h,01ah,073h,045h,00ah,01ah,073h,045h,0ffh,0b2h,000h,00fh,000h,020h,005h,011h	; 44c8  ..sE..sE..... ..
	defb 000h,020h,004h,0ffh,00dh,007h,001h,004h,053h,00dh,00eh,001h,004h,053h,00dh,015h	; 44d8  . ......S....S..
	defb 001h,004h,053h,0ffh,00ah,006h,068h,045h,00ah,00dh,068h,045h,00ah,014h,068h,045h	; 44e8  ..S...hE..hE..hE
	defb 00eh,005h,073h,045h,00eh,008h,073h,045h,00eh,00ch,073h,045h,00eh,00fh,073h,045h	; 44f8  ..sE..sE..sE..sE
	defb 00eh,013h,073h,045h,00eh,016h,073h,045h,008h,002h,094h,0aeh,00bh,01bh,094h,0aeh	; 4508  ..sE..sE........
	defb 005h,009h,060h,050h,005h,010h,060h,050h,005h,018h,060h,050h,0ffh,0b2h,000h,00fh	; 4518  ..`P..`P..`P....
	defb 000h,020h,005h,011h,000h,020h,004h,0ffh,006h,00dh,001h,00bh,053h,005h,014h,001h	; 4528  . ... ......S...
	defb 00ch,053h,0ffh,003h,00ch,068h,045h,002h,013h,068h,045h,00ch,00bh,073h,045h,00ah	; 4538  .S...hE..hE..sE.
	defb 00eh,073h,045h,007h,012h,073h,045h,006h,015h,073h,045h,00ch,015h,073h,045h,00bh	; 4548  .sE..sE..sE..sE.
	defb 003h,094h,0aeh,009h,007h,094h,0aeh,003h,003h,060h,050h,007h,01ah,060h,050h,0ffh	; 4558  .........`P..`P.
	defb 003h,003h,050h,051h,052h,054h,055h,056h,058h,059h,057h,002h,001h,039h,03ah,003h	; 4568  ..PQRTUVXYW..9:.
	defb 002h,090h,091h,092h,093h,094h,095h,0b2h,000h,00eh,000h,020h,005h,011h,000h,020h	; 4578  ........... ... 
	defb 004h,0ffh,000h,000h,020h,009h,0dbh,009h,002h,010h,002h,0dbh,009h,015h,00bh,002h	; 4588  .... ...........
	defb 0dbh,0ffh,006h,000h,0a6h,0aeh,009h,001h,0abh,0aeh,00ah,002h,0afh,0aeh,00ah,006h	; 4598  ................
	defb 0b9h,0aeh,009h,00ah,0c3h,0aeh,009h,00bh,0afh,0aeh,009h,00fh,0b9h,0aeh,008h,013h	; 45a8  ................
	defb 0c3h,0aeh,008h,014h,0abh,0aeh,009h,015h,0afh,0aeh,009h,019h,0b9h,0aeh,009h,01dh	; 45b8  ................
	defb 0d8h,0aeh,000h,008h,0e7h,0aeh,007h,00ah,0f9h,0aeh,005h,014h,0fdh,0aeh,007h,01dh	; 45c8  ................
	defb 002h,0afh,005h,01eh,0fdh,0aeh,000h,01fh,006h,0afh,008h,004h,032h,0afh,007h,004h	; 45d8  ............2...
	defb 032h,0afh,00fh,003h,060h,0afh,008h,00fh,032h,0afh,005h,00fh,049h,0afh,00fh,00eh	; 45e8  2...`...2...I...
	defb 060h,0afh,008h,018h,032h,0afh,007h,018h,032h,0afh,00fh,017h,060h,0afh,009h,002h	; 45f8  `...2...2...`...
	defb 06fh,0afh,00ch,006h,06ah,0afh,006h,00dh,0c4h,0bfh,007h,012h,0c0h,0bfh,00dh,00dh	; 4608  o...j...........
	defb 06fh,0afh,009h,016h,06fh,0afh,00ch,01ah,06ah,0afh,0ffh,0b2h,000h,00eh,000h,020h	; 4618  o...o...j...... 
	defb 005h,011h,000h,020h,004h,0ffh,000h,000h,020h,008h,0dbh,008h,000h,012h,003h,0dbh	; 4628  ... .... .......
	defb 00bh,00ah,003h,001h,0dbh,008h,017h,009h,002h,0dbh,0ffh,00ah,000h,0e0h,0aeh,00ah	; 4638  ................
	defb 004h,0c7h,0aeh,00ah,006h,0afh,0aeh,00ah,00dh,0b9h,0aeh,009h,011h,0c3h,0aeh,006h	; 4648  ................
	defb 012h,0cbh,0aeh,006h,013h,0abh,0aeh,007h,014h,0d8h,0aeh,009h,017h,0abh,0aeh,00ah	; 4658  ................
	defb 018h,0afh,0aeh,00ah,01bh,0b9h,0aeh,00ah,01fh,0e3h,0aeh,000h,012h,00dh,0afh,001h	; 4668  ................
	defb 013h,006h,0afh,001h,003h,0e7h,0aeh,008h,005h,0f9h,0aeh,008h,01fh,002h,0afh,008h	; 4678  ................
	defb 001h,032h,0afh,00fh,000h,060h,0afh,008h,009h,032h,0afh,006h,009h,032h,0afh,00fh	; 4688  .2...`...2...2..
	defb 008h,060h,0afh,00ah,012h,049h,0afh,00fh,011h,060h,0afh,008h,01ah,032h,0afh,004h	; 4698  .`...I...`...2..
	defb 01ah,049h,0afh,00fh,019h,060h,0afh,008h,007h,06fh,0afh,00dh,007h,06fh,0afh,009h	; 46a8  .I...`...o...o..
	defb 00bh,06ah,0afh,00ch,010h,0c4h,0bfh,00dh,018h,06fh,0afh,007h,01ch,06ah,0afh,0ffh	; 46b8  .j.......o...j..
	defb 0b2h,000h,00eh,000h,020h,005h,011h,000h,020h,004h,0ffh,000h,000h,020h,008h,0dbh	; 46c8  .... ... .... ..
	defb 008h,000h,008h,003h,0dbh,008h,00ah,015h,003h,0dbh,00bh,00fh,003h,002h,0dbh,00bh	; 46d8  ................
	defb 019h,001h,001h,0dbh,0ffh,00bh,000h,0d0h,0aeh,00ah,003h,0b9h,0aeh,009h,007h,0c3h	; 46e8  ................
	defb 0aeh,008h,008h,0d5h,0aeh,007h,009h,0a6h,0aeh,00ah,00ah,0abh,0aeh,00bh,00bh,0afh	; 46f8  ................
	defb 0aeh,00bh,012h,0b9h,0aeh,00bh,016h,0d0h,0aeh,00ah,01ah,0b9h,0aeh,009h,01eh,0c3h	; 4708  ................
	defb 0aeh,006h,01fh,0cbh,0aeh,000h,008h,011h,0afh,006h,000h,0fdh,0aeh,001h,001h,006h	; 4718  ................
	defb 0afh,009h,016h,002h,0afh,007h,017h,0fdh,0aeh,002h,018h,006h,0afh,000h,017h,023h	; 4728  ...............#
	defb 0afh,004h,01ah,02dh,0afh,008h,002h,032h,0afh,006h,002h,032h,0afh,00fh,001h,060h	; 4738  ...-...2...2...`
	defb 0afh,008h,00fh,032h,0afh,004h,00fh,049h,0afh,00fh,00eh,060h,0afh,009h,019h,049h	; 4748  ...2...I...`...I
	defb 0afh,00fh,018h,060h,0afh,008h,000h,06fh,0afh,00ch,004h,06ah,0afh,008h,00dh,06fh	; 4758  ...`...o...j...o
	defb 0afh,00bh,011h,06ah,0afh,006h,012h,0c0h,0bfh,00dh,017h,06fh,0afh,00ch,01bh,06ah	; 4768  ...j.......o...j
	defb 0afh,00eh,008h,074h,0afh,010h,007h,07fh,0afh,0ffh,0b2h,000h,00eh,000h,020h,005h	; 4778  ...t.......... .
	defb 011h,000h,020h,004h,0ffh,0ffh,00dh,006h,074h,0afh,00ch,006h,074h,0afh,010h,005h	; 4788  .. .....t...t...
	defb 07fh,0afh,009h,00eh,074h,0afh,00ch,00eh,089h,0afh,010h,00dh,07fh,0afh,006h,01ah	; 4798  ....t...........
	defb 074h,0afh,009h,01ah,089h,0afh,00ch,01ah,089h,0afh,010h,019h,07fh,0afh,00eh,014h	; 47a8  t...............
	defb 074h,0afh,010h,013h,07fh,0afh,005h,003h,060h,050h,003h,011h,060h,050h,0ffh,0b2h	; 47b8  t.......`P..`P..
	defb 000h,00eh,000h,020h,005h,011h,000h,020h,004h,0ffh,000h,000h,020h,009h,0dbh,009h	; 47c8  ... ... .... ...
	defb 002h,010h,002h,0dbh,009h,015h,00bh,002h,0dbh,0ffh,006h,000h,0a6h,0aeh,009h,001h	; 47d8  ................
	defb 0abh,0aeh,00ah,002h,0afh,0aeh,00ah,006h,0b9h,0aeh,009h,00ah,0c3h,0aeh,009h,00bh	; 47e8  ................
	defb 0afh,0aeh,009h,00fh,0b9h,0aeh,008h,013h,0c3h,0aeh,008h,014h,0abh,0aeh,009h,015h	; 47f8  ................
	defb 0afh,0aeh,009h,019h,0b9h,0aeh,009h,01dh,0d8h,0aeh,000h,008h,0e7h,0aeh,007h,00ah	; 4808  ................
	defb 0f9h,0aeh,005h,014h,0fdh,0aeh,007h,01dh,002h,0afh,005h,01eh,0fdh,0aeh,000h,01fh	; 4818  ................
	defb 006h,0afh,008h,004h,032h,0afh,003h,004h,032h,0afh,00fh,003h,060h,0afh,009h,00eh	; 4828  ....2...2...`...
	defb 049h,0afh,00fh,00dh,060h,0afh,008h,018h,032h,0afh,004h,018h,049h,0afh,00fh,017h	; 4838  I...`...2...I...
	defb 060h,0afh,009h,006h,06ah,0afh,005h,01bh,0c0h,0bfh,006h,002h,06fh,0afh,00eh,009h	; 4848  `...j.......o...
	defb 074h,0afh,010h,008h,07fh,0afh,00dh,013h,074h,0afh,010h,012h,07fh,0afh,0ffh,0b2h	; 4858  t.......t.......
	defb 000h,00eh,000h,020h,005h,011h,000h,020h,004h,0ffh,000h,000h,020h,008h,0dbh,008h	; 4868  ... ... .... ...
	defb 000h,012h,003h,0dbh,00bh,00ah,003h,001h,0dbh,008h,017h,009h,002h,0dbh,0ffh,00ah	; 4878  ................
	defb 000h,0e0h,0aeh,00ah,004h,0c7h,0aeh,00ah,006h,0afh,0aeh,00ah,00dh,0b9h,0aeh,009h	; 4888  ................
	defb 011h,0c3h,0aeh,006h,012h,0cbh,0aeh,006h,013h,0abh,0aeh,007h,014h,0d8h,0aeh,009h	; 4898  ................
	defb 017h,0abh,0aeh,00ah,018h,0afh,0aeh,00ah,01bh,0b9h,0aeh,00ah,01fh,0e3h,0aeh,000h	; 48a8  ................
	defb 012h,00dh,0afh,001h,013h,006h,0afh,001h,003h,0e7h,0aeh,008h,005h,0f9h,0aeh,008h	; 48b8  ................
	defb 01fh,002h,0afh,009h,001h,049h,0afh,00fh,000h,060h,0afh,008h,009h,032h,0afh,003h	; 48c8  .....I...`...2..
	defb 009h,049h,0afh,00fh,008h,060h,0afh,008h,019h,032h,0afh,006h,019h,049h,0afh,00fh	; 48d8  .I...`...2...I..
	defb 018h,060h,0afh,00ch,011h,089h,0afh,00ch,011h,074h,0afh,010h,010h,07fh,0afh,00dh	; 48e8  .`.......t......
	defb 003h,06ah,0afh,007h,007h,06fh,0afh,009h,00bh,06ah,0afh,008h,017h,0c4h,0bfh,00ch	; 48f8  .j...o...j......
	defb 01bh,06ah,0afh,0ffh,0b2h,000h,00eh,000h,020h,005h,011h,000h,020h,004h,0ffh,000h	; 4908  .j...... ... ...
	defb 000h,020h,008h,0dbh,008h,000h,008h,003h,0dbh,008h,00ah,015h,003h,0dbh,00bh,00fh	; 4918  . ..............
	defb 003h,002h,0dbh,00bh,019h,001h,001h,0dbh,0ffh,00bh,000h,0d0h,0aeh,00ah,003h,0b9h	; 4928  ................
	defb 0aeh,009h,007h,0c3h,0aeh,008h,008h,0d5h,0aeh,007h,009h,0a6h,0aeh,00ah,00ah,0abh	; 4938  ................
	defb 0aeh,00bh,00bh,0afh,0aeh,00bh,012h,0b9h,0aeh,00bh,016h,0d0h,0aeh,00ah,01ah,0b9h	; 4948  ................
	defb 0aeh,009h,01eh,0c3h,0aeh,006h,01fh,0cbh,0aeh,000h,008h,011h,0afh,006h,000h,0fdh	; 4958  ................
	defb 0aeh,001h,001h,006h,0afh,009h,016h,002h,0afh,007h,017h,0fdh,0aeh,002h,018h,006h	; 4968  ................
	defb 0afh,000h,017h,023h,0afh,004h,01ah,02dh,0afh,008h,002h,032h,0afh,005h,002h,049h	; 4978  ...#...-...2...I
	defb 0afh,00fh,001h,060h,0afh,00ah,007h,049h,0afh,00fh,006h,060h,0afh,00ah,00fh,049h	; 4988  ...`...I...`...I
	defb 0afh,00fh,00eh,060h,0afh,008h,019h,032h,0afh,006h,019h,049h,0afh,00fh,018h,060h	; 4998  ...`...2...I...`
	defb 0afh,007h,005h,0c0h,0bfh,00dh,00dh,06fh,0afh,00dh,011h,06ah,0afh,008h,01ch,0c0h	; 49a8  .......o...j....
	defb 0bfh,0ffh,0b2h,000h,00eh,000h,020h,005h,011h,000h,020h,004h,0ffh,0ffh,00dh,004h	; 49b8  ...... ... .....
	defb 074h,0afh,010h,003h,07fh,0afh,00bh,008h,089h,0afh,008h,008h,074h,0afh,010h,007h	; 49c8  t...........t...
	defb 07fh,0afh,00bh,010h,089h,0afh,00bh,010h,074h,0afh,010h,00fh,07fh,0afh,00bh,016h	; 49d8  ........t.......
	defb 089h,0afh,006h,016h,089h,0afh,004h,016h,074h,0afh,010h,015h,07fh,0afh,00ch,01dh	; 49e8  ........t.......
	defb 089h,0afh,00bh,01dh,074h,0afh,010h,01ch,07fh,0afh,004h,003h,060h,050h,002h,00ch	; 49f8  ....t.......`P..
	defb 060h,050h,005h,01ch,060h,050h,0ffh,0b2h,000h,00eh,000h,020h,005h,011h,000h,020h	; 4a08  `P..`P..... ... 
	defb 004h,0ffh,000h,000h,020h,009h,0dbh,009h,002h,010h,002h,0dbh,009h,015h,00bh,002h	; 4a18  .... ...........
	defb 0dbh,0ffh,006h,000h,0a6h,0aeh,009h,001h,0abh,0aeh,00ah,002h,0afh,0aeh,00ah,006h	; 4a28  ................
	defb 0b9h,0aeh,009h,00ah,0c3h,0aeh,009h,00bh,0afh,0aeh,009h,00fh,0b9h,0aeh,008h,013h	; 4a38  ................
	defb 0c3h,0aeh,008h,014h,0abh,0aeh,009h,015h,0afh,0aeh,009h,019h,0b9h,0aeh,009h,01dh	; 4a48  ................
	defb 0d8h,0aeh,000h,008h,0e7h,0aeh,007h,00ah,0f9h,0aeh,005h,014h,0fdh,0aeh,007h,01dh	; 4a58  ................
	defb 002h,0afh,005h,01eh,0fdh,0aeh,000h,01fh,006h,0afh,008h,004h,049h,0afh,00fh,003h	; 4a68  ............I...
	defb 060h,0afh,008h,013h,032h,0afh,003h,013h,032h,0afh,00fh,012h,060h,0afh,00eh,00ch	; 4a78  `...2...2...`...
	defb 074h,0afh,010h,00bh,07fh,0afh,00ch,01bh,089h,0afh,00ch,01bh,074h,0afh,010h,01ah	; 4a88  t...........t...
	defb 07fh,0afh,009h,002h,0c4h,0bfh,00ch,006h,06ah,0afh,007h,011h,06fh,0afh,005h,015h	; 4a98  ........j...o...
	defb 06ah,0afh,0ffh,0b2h,000h,00eh,000h,020h,005h,011h,000h,020h,004h,0ffh,000h,000h	; 4aa8  j...... ... ....
	defb 020h,008h,0dbh,008h,000h,008h,003h,0dbh,008h,00ah,015h,003h,0dbh,00bh,00fh,003h	; 4ab8   ...............
	defb 002h,0dbh,00bh,019h,001h,001h,0dbh,0ffh,00bh,000h,0d0h,0aeh,00ah,003h,0b9h,0aeh	; 4ac8  ................
	defb 009h,007h,0c3h,0aeh,008h,008h,0d5h,0aeh,007h,009h,0a6h,0aeh,00ah,00ah,0abh,0aeh	; 4ad8  ................
	defb 00bh,00bh,0afh,0aeh,00bh,012h,0b9h,0aeh,00bh,016h,0d0h,0aeh,00ah,01ah,0b9h,0aeh	; 4ae8  ................
	defb 009h,01eh,0c3h,0aeh,006h,01fh,0cbh,0aeh,000h,008h,011h,0afh,006h,000h,0fdh,0aeh	; 4af8  ................
	defb 001h,001h,006h,0afh,009h,016h,002h,0afh,007h,017h,0fdh,0aeh,002h,018h,006h,0afh	; 4b08  ................
	defb 000h,017h,023h,0afh,004h,01ah,02dh,0afh,008h,002h,032h,0afh,002h,002h,032h,0afh	; 4b18  ..#...-...2...2.
	defb 001h,002h,032h,0afh,00fh,001h,060h,0afh,008h,008h,032h,0afh,002h,008h,032h,0afh	; 4b28  ..2...`...2...2.
	defb 00fh,007h,060h,0afh,008h,00fh,032h,0afh,002h,00fh,032h,0afh,00fh,00eh,060h,0afh	; 4b38  ..`...2...2...`.
	defb 008h,018h,049h,0afh,00fh,017h,060h,0afh,006h,000h,06fh,0afh,003h,004h,06ah,0afh	; 4b48  ..I...`...o...j.
	defb 007h,006h,06fh,0afh,009h,00ah,06ah,0afh,00dh,004h,06ah,0afh,00bh,00dh,06fh,0afh	; 4b58  ..o...j...j...o.
	defb 005h,00dh,06fh,0afh,007h,011h,06ah,0afh,00dh,016h,06fh,0afh,009h,01bh,0c0h,0bfh	; 4b68  ..o...j...o.....
	defb 0ffh,0b2h,000h,00eh,000h,020h,005h,011h,000h,020h,004h,0ffh,000h,000h,020h,008h	; 4b78  ..... ... .... .
	defb 0dbh,008h,000h,012h,003h,0dbh,00bh,00ah,003h,001h,0dbh,008h,017h,009h,002h,0dbh	; 4b88  ................
	defb 0ffh,00ah,000h,0e0h,0aeh,00ah,004h,0c7h,0aeh,00ah,006h,0afh,0aeh,00ah,00dh,0b9h	; 4b98  ................
	defb 0aeh,009h,011h,0c3h,0aeh,006h,012h,0cbh,0aeh,006h,013h,0abh,0aeh,007h,014h,0d8h	; 4ba8  ................
	defb 0aeh,009h,017h,0abh,0aeh,00ah,018h,0afh,0aeh,00ah,01bh,0b9h,0aeh,00ah,01fh,0e3h	; 4bb8  ................
	defb 0aeh,000h,012h,00dh,0afh,001h,013h,006h,0afh,001h,003h,0e7h,0aeh,008h,005h,0f9h	; 4bc8  ................
	defb 0aeh,008h,01fh,002h,0afh,00ah,002h,049h,0afh,00fh,001h,060h,0afh,008h,009h,032h	; 4bd8  .......I...`...2
	defb 0afh,002h,009h,049h,0afh,00fh,008h,060h,0afh,009h,01ah,049h,0afh,00fh,019h,060h	; 4be8  ...I...`...I...`
	defb 0afh,00dh,010h,074h,0afh,010h,00fh,07fh,0afh,00ch,015h,089h,0afh,00bh,015h,074h	; 4bf8  ...t...........t
	defb 0afh,010h,014h,07fh,0afh,00ch,005h,0c0h,0bfh,00ah,00bh,06ah,0afh,00dh,00bh,06ah	; 4c08  ...........j...j
	defb 0afh,00dh,01ch,06ah,0afh,007h,00bh,06ah,0afh,004h,00ch,0c0h,0bfh,0ffh,0b2h,000h	; 4c18  ...j...j........
	defb 00eh,000h,020h,005h,011h,000h,020h,004h,0ffh,0ffh,00ch,003h,089h,0afh,00ch,003h	; 4c28  .. ... .........
	defb 074h,0afh,010h,002h,07fh,0afh,00bh,008h,089h,0afh,00ah,008h,074h,0afh,010h,007h	; 4c38  t...........t...
	defb 07fh,0afh,00bh,00dh,089h,0afh,008h,00dh,074h,0afh,010h,00ch,07fh,0afh,00bh,012h	; 4c48  ........t.......
	defb 089h,0afh,006h,012h,089h,0afh,006h,012h,074h,0afh,010h,011h,07fh,0afh,00bh,017h	; 4c58  ........t.......
	defb 089h,0afh,006h,017h,089h,0afh,004h,017h,074h,0afh,010h,016h,07fh,0afh,00bh,01ch	; 4c68  ........t.......
	defb 089h,0afh,006h,01ch,089h,0afh,002h,01ch,089h,0afh,002h,01ch,074h,0afh,010h,01bh	; 4c78  ............t...
	defb 07fh,0afh,003h,005h,060h,050h,001h,00fh,060h,050h,0ffh,0b2h,000h,00eh,000h,020h	; 4c88  ....`P..`P..... 
	defb 005h,011h,000h,020h,004h,0ffh,0ffh,00bh,00dh,089h,0afh,00ah,00dh,074h,0afh,010h	; 4c98  ... .........t..
	defb 00ch,07fh,0afh,004h,006h,06ah,0afh,004h,009h,06ah,0afh,005h,012h,06fh,0afh,005h	; 4ca8  .....j...j...o..
	defb 015h,06fh,0afh,0ffh,0b2h,001h,005h,015h,004h,007h,0feh,011h,000h,015h,005h,05ch	; 4cb8  .o.............\
	defb 00dh,006h,00fh,004h,05ch,009h,008h,00dh,004h,05ch,005h,00ah,00bh,004h,05ch,005h	; 4cc8  ....\....\....\.
	defb 019h,007h,011h,05ch,0ffh,006h,015h,004h,010h,0f3h,006h,00ch,005h,010h,0f3h,005h	; 4cd8  ...\............
	defb 00ch,005h,001h,0f0h,0ffh,0ffh,0b2h,001h,012h,00eh,003h,007h,012h,015h,002h,007h	; 4ce8  ................
	defb 012h,01bh,002h,007h,0feh,005h,000h,004h,011h,05ch,00fh,004h,005h,007h,05ch,00fh	; 4cf8  .........\....\.
	defb 004h,005h,007h,05ch,011h,009h,003h,005h,05ch,012h,00ch,002h,004h,05ch,012h,011h	; 4d08  ...\....\....\..
	defb 004h,004h,05ch,00ah,017h,004h,00ch,05ch,012h,01dh,003h,004h,05ch,0ffh,013h,00eh	; 4d18  ..\....\....\...
	defb 003h,003h,0f3h,013h,015h,002h,003h,0f3h,013h,01bh,002h,003h,0f3h,0ffh,009h,00bh	; 4d28  ................
	defb 060h,050h,006h,012h,060h,050h,003h,019h,060h,050h,0ffh,0b2h,001h,012h,004h,003h	; 4d38  `P..`P..`P......
	defb 007h,012h,00ch,003h,007h,0feh,012h,000h,004h,004h,05ch,012h,007h,005h,004h,05ch	; 4d48  ..........\....\
	defb 00eh,00fh,011h,008h,05ch,00ch,011h,00ah,002h,05ch,00ah,013h,006h,002h,05ch,008h	; 4d58  ....\....\....\.
	defb 015h,002h,002h,05ch,0ffh,013h,004h,003h,003h,0f3h,013h,00ch,003h,003h,0f3h,0ffh	; 4d68  ...\............
	defb 008h,004h,060h,050h,005h,00ah,060h,050h,004h,01bh,060h,050h,0ffh,0b2h,001h,00eh	; 4d78  ..`P..`P..`P....
	defb 005h,003h,007h,00eh,00dh,006h,007h,011h,018h,002h,007h,0feh,00eh,000h,005h,008h	; 4d88  ................
	defb 05ch,00eh,008h,005h,008h,05ch,00eh,013h,005h,008h,05ch,011h,01ah,006h,005h,05ch	; 4d98  \....\....\....\
	defb 0ffh,00fh,005h,003h,007h,0f3h,00fh,00dh,006h,007h,0f3h,012h,018h,002h,004h,0f3h	; 4da8  ................
	defb 0ffh,008h,009h,060h,050h,005h,00fh,060h,050h,003h,016h,060h,050h,0ffh,0b2h,001h	; 4db8  ...`P..`P..`P...
	defb 013h,007h,004h,007h,010h,00fh,004h,007h,00eh,017h,005h,007h,0feh,011h,000h,004h	; 4dc8  ................
	defb 005h,05ch,013h,004h,003h,003h,05ch,013h,00bh,004h,003h,05ch,010h,00dh,002h,003h	; 4dd8  .\....\....\....
	defb 05ch,00eh,013h,004h,008h,05ch,00eh,01ch,004h,008h,05ch,0ffh,014h,007h,004h,002h	; 4de8  \....\....\.....
	defb 0f3h,011h,00fh,004h,005h,0f3h,00fh,017h,005h,007h,0f3h,0ffh,00ch,007h,060h,050h	; 4df8  ..............`P
	defb 006h,00dh,060h,050h,002h,013h,060h,050h,007h,018h,060h,050h,0ffh,0b2h,001h,013h	; 4e08  ..`P..`P..`P....
	defb 004h,009h,007h,013h,012h,00ah,007h,00eh,004h,00ah,006h,00eh,010h,00ch,006h,0feh	; 4e18  ................
	defb 00eh,000h,004h,008h,05ch,013h,00dh,005h,003h,05ch,00eh,01ch,004h,008h,05ch,006h	; 4e28  ....\....\....\.
	defb 01eh,002h,008h,05ch,0ffh,014h,004h,009h,002h,0f3h,014h,012h,00ah,002h,0f3h,0ffh	; 4e38  ...\............
	defb 005h,003h,060h,050h,009h,00ah,060h,050h,004h,013h,060h,050h,009h,018h,060h,050h	; 4e48  ..`P..`P..`P..`P
	defb 0ffh,0b2h,001h,011h,009h,005h,006h,011h,010h,004h,006h,011h,016h,004h,006h,012h	; 4e58  ................
	defb 01ch,002h,006h,0feh,007h,000h,004h,00fh,05ch,011h,004h,005h,005h,05ch,012h,01eh	; 4e68  ........\....\..
	defb 002h,004h,05ch,0ffh,0ffh,00ah,007h,060h,050h,006h,00dh,060h,050h,008h,016h,060h	; 4e78  ..\....`P..`P..`
	defb 050h,00ch,01ch,060h,050h,0ffh,0b2h,001h,011h,014h,007h,007h,0feh,012h,000h,006h	; 4e88  P..`P...........
	defb 004h,05ch,012h,008h,00ch,004h,05ch,007h,00dh,007h,00bh,05ch,011h,01bh,005h,005h	; 4e98  .\....\....\....
	defb 05ch,00bh,01eh,002h,002h,05ch,0ffh,012h,014h,007h,004h,0f3h,0ffh,00ch,000h,060h	; 4ea8  \....\.........`
	defb 050h,007h,007h,060h,050h,00ah,019h,060h,050h,0ffh,0b2h,001h,006h,009h,003h,006h	; 4eb8  P..`P..`P.......
	defb 008h,00dh,003h,006h,009h,015h,003h,006h,00ch,01ah,002h,006h,008h,01eh,002h,006h	; 4ec8  ................
	defb 0feh,00bh,000h,003h,002h,05ch,011h,000h,009h,005h,05ch,006h,005h,004h,00bh,05ch	; 4ed8  .....\....\....\
	defb 0ffh,0ffh,00bh,011h,060h,050h,0ffh,0b2h,001h,008h,000h,005h,006h,008h,00ah,004h	; 4ee8  ....`P..........
	defb 006h,00eh,012h,004h,006h,0feh,00bh,019h,007h,00bh,05ch,0ffh,0ffh,010h,006h,060h	; 4ef8  ..........\....`
	defb 050h,003h,010h,060h,050h,003h,014h,060h,050h,0ffh,0b2h,001h,0feh,00bh,000h,004h	; 4f08  P..`P..`P.......
	defb 00bh,05ch,0ffh,0ffh,00bh,009h,060h,050h,008h,012h,060h,050h,004h,01bh,060h,050h	; 4f18  .\....`P..`P..`P
	defb 0ffh,0b2h,001h,011h,014h,002h,007h,011h,019h,003h,007h,0feh,004h,00eh,004h,006h	; 4f28  ................
	defb 05ch,00ah,00dh,008h,002h,05ch,00ch,00eh,006h,00ah,05ch,011h,016h,003h,005h,05ch	; 4f38  \....\....\....\
	defb 011h,01ch,004h,005h,05ch,0ffh,012h,014h,002h,004h,0f3h,012h,019h,003h,004h,0f3h	; 4f48  ....\...........
	defb 0ffh,011h,000h,060h,050h,00dh,007h,060h,050h,005h,007h,060h,050h,009h,01bh,060h	; 4f58  ...`P..`P..`P..`
	defb 050h,0ffh,0b2h,001h,011h,00dh,009h,007h,0feh,011h,000h,00dh,005h,05ch,011h,016h	; 4f68  P............\..
	defb 00ah,005h,05ch,0ffh,012h,00dh,009h,004h,0f3h,0ffh,004h,004h,060h,050h,008h,007h	; 4f78  ..\.........`P..
	defb 060h,050h,004h,00bh,060h,050h,00bh,00fh,060h,050h,004h,013h,060h,050h,008h,017h	; 4f88  `P..`P..`P..`P..
	defb 060h,050h,004h,01ah,060h,050h,0ffh,0b2h,001h,011h,003h,005h,007h,010h,00eh,005h	; 4f98  `P..`P..........
	defb 007h,010h,019h,004h,007h,0feh,011h,000h,003h,005h,05ch,00eh,008h,006h,008h,05ch	; 4fa8  ..........\....\
	defb 010h,013h,006h,006h,05ch,00ah,01dh,003h,00ch,05ch,0ffh,012h,003h,005h,004h,0f3h	; 4fb8  ....\....\......
	defb 011h,00eh,005h,005h,0f3h,011h,019h,004h,005h,0f3h,0ffh,005h,005h,060h,050h,003h	; 4fc8  .............`P.
	defb 00fh,060h,050h,006h,018h,060h,050h,0ffh,0b2h,001h,0feh,00ah,000h,006h,00ch,05ch	; 4fd8  .`P..`P........\
	defb 00bh,012h,00eh,00bh,05ch,00fh,011h,001h,002h,05ch,0ffh,0ffh,004h,008h,060h,050h	; 4fe8  ....\....\....`P
	defb 012h,00ah,060h,050h,0ffh,0b2h,001h,004h,008h,004h,007h,004h,00eh,005h,007h,00bh	; 4ff8  ..`P............
	defb 015h,003h,007h,0feh,00bh,000h,008h,00bh,05ch,004h,006h,002h,007h,05ch,004h,00ch	; 5008  ........\....\..
	defb 002h,012h,05ch,004h,013h,002h,012h,05ch,00ah,018h,002h,00ch,05ch,011h,01ah,006h	; 5018  ..\....\....\...
	defb 005h,05ch,009h,004h,002h,002h,05ch,0ffh,005h,008h,004h,011h,0f3h,005h,00eh,005h	; 5028  .\....\.........
	defb 011h,0f3h,00ch,015h,003h,00ah,0f3h,0ffh,0ffh,0b2h,001h,0feh,011h,000h,020h,005h	; 5038  .............. .
	defb 05ch,0ffh,0ffh,003h,004h,060h,050h,006h,009h,060h,050h,004h,016h,060h,050h,00bh	; 5048  \....`P..`P..`P.
	defb 00dh,09ah,0afh,00ch,00eh,0a6h,0afh,0ffh,004h,002h,060h,061h,062h,063h,064h,065h	; 5058  ..........`abcde
	defb 066h,067h,0b2h,001h,00eh,000h,020h,005h,00fh,000h,020h,000h,010h,000h,020h,008h	; 5068  fg.... ... ... .
	defb 0ffh,011h,000h,020h,005h,088h,0ffh,011h,000h,01dh,052h,011h,00ch,01dh,052h,011h	; 5078  ... ......R...R.
	defb 01bh,01dh,052h,00ah,007h,060h,050h,005h,00eh,060h,050h,00bh,014h,060h,050h,0ffh	; 5088  ..R..`P..`P..`P.
	defb 0b2h,001h,00eh,000h,020h,005h,00fh,000h,020h,000h,010h,000h,020h,008h,0ffh,011h	; 5098  .... ... ... ...
	defb 000h,020h,005h,088h,0ffh,011h,000h,017h,052h,011h,015h,012h,052h,011h,01ch,017h	; 50a8  . ......R...R...
	defb 052h,007h,007h,060h,050h,00ah,00dh,060h,050h,006h,016h,060h,050h,00ch,005h,060h	; 50b8  R..`P..`P..`P..`
	defb 050h,0ffh,0b2h,001h,00eh,000h,020h,005h,00fh,000h,020h,000h,010h,000h,020h,008h	; 50c8  P..... ... ... .
	defb 0ffh,011h,000h,020h,005h,088h,0ffh,011h,000h,01dh,052h,011h,009h,012h,052h,011h	; 50d8  ... ......R...R.
	defb 00fh,012h,052h,011h,015h,012h,052h,011h,01bh,01dh,052h,008h,005h,060h,050h,003h	; 50e8  ..R...R...R..`P.
	defb 00bh,060h,050h,00bh,00ch,060h,050h,006h,014h,060h,050h,0ffh,0b2h,001h,00eh,000h	; 50f8  .`P..`P..`P.....
	defb 020h,005h,00fh,000h,020h,000h,010h,000h,020h,008h,0ffh,011h,000h,020h,005h,088h	; 5108   ... ... .... ..
	defb 0ffh,011h,000h,01dh,052h,00bh,009h,060h,050h,007h,010h,060h,050h,003h,017h,060h	; 5118  ....R..`P..`P..`
	defb 050h,008h,01ch,060h,050h,0ffh,0b2h,001h,00eh,000h,020h,005h,00fh,000h,020h,000h	; 5128  P..`P..... ... .
	defb 010h,000h,020h,008h,0ffh,011h,000h,020h,005h,088h,0ffh,011h,000h,01dh,052h,011h	; 5138  .. .... ......R.
	defb 005h,024h,052h,011h,019h,017h,052h,00ch,005h,060h,050h,005h,008h,060h,050h,002h	; 5148  .$R...R..`P..`P.
	defb 012h,060h,050h,00ah,00fh,060h,050h,0ffh,0b2h,001h,00eh,000h,020h,005h,00fh,000h	; 5158  .`P..`P..... ...
	defb 020h,000h,010h,000h,020h,008h,0ffh,011h,000h,020h,005h,088h,0ffh,011h,000h,01dh	; 5168   ... .... ......
	defb 052h,011h,00ah,017h,052h,011h,014h,017h,052h,011h,01ch,017h,052h,00bh,006h,060h	; 5178  R...R...R...R..`
	defb 050h,006h,00ah,060h,050h,00ah,00fh,060h,050h,002h,00fh,060h,050h,005h,014h,060h	; 5188  P..`P..`P..`P..`
	defb 050h,00ah,018h,060h,050h,0ffh,0b2h,001h,00eh,000h,020h,005h,00fh,000h,020h,000h	; 5198  P..`P..... ... .
	defb 010h,000h,020h,008h,0ffh,011h,000h,020h,005h,088h,0ffh,011h,003h,017h,052h,011h	; 51a8  .. .... ......R.
	defb 00ah,012h,052h,011h,013h,012h,052h,011h,01dh,012h,052h,00bh,007h,060h,050h,007h	; 51b8  ..R...R...R..`P.
	defb 00ch,060h,050h,004h,012h,060h,050h,00ah,016h,060h,050h,0ffh,0b2h,001h,00eh,000h	; 51c8  .`P..`P..`P.....
	defb 020h,005h,00fh,000h,020h,000h,010h,000h,020h,008h,0ffh,011h,000h,020h,005h,088h	; 51d8   ... ... .... ..
	defb 0ffh,011h,000h,017h,052h,011h,00ah,024h,052h,011h,010h,024h,052h,011h,016h,017h	; 51e8  ....R..$R..$R...
	defb 052h,004h,003h,060h,050h,00bh,005h,060h,050h,004h,01ah,060h,050h,00ah,01ch,060h	; 51f8  R..`P..`P..`P..`
	defb 050h,00bh,00dh,09ah,0afh,00ch,00eh,0a6h,0afh,0ffh,003h,001h,054h,035h,058h,004h	; 5208  P...........T5X.
	defb 001h,054h,035h,03ch,058h,005h,001h,054h,035h,03ch,035h,058h,006h,001h,054h,035h	; 5218  .T5<X..T5<5X..T5
	defb 03ch,035h,03ch,058h,080h,001h,0feh,012h,000h,020h,004h,050h,0ffh,002h,003h,012h	; 5228  <5<X..... .P....
	defb 001h,03eh,003h,003h,012h,00eh,090h,011h,000h,020h,001h,054h,005h,01bh,001h,009h	; 5238  .>....... .T....
	defb 060h,00eh,01bh,001h,003h,064h,0ffh,005h,005h,0d0h,0a8h,005h,009h,0d0h,0a8h,005h	; 5248  `....d..........
	defb 00dh,0d0h,0a8h,005h,011h,0d0h,0a8h,009h,005h,0d0h,0a8h,009h,009h,0d0h,0a8h,009h	; 5258  ................
	defb 00dh,0d0h,0a8h,009h,011h,0d0h,0a8h,00dh,005h,0d0h,0a8h,00dh,009h,0d0h,0a8h,00dh	; 5268  ................
	defb 00dh,0d0h,0a8h,00dh,011h,0d0h,0a8h,00eh,017h,0deh,0a8h,009h,019h,0e6h,0a8h,005h	; 5278  ................
	defb 01ch,0eah,0a8h,0ffh,080h,001h,0feh,080h,001h,0feh,012h,000h,007h,004h,050h,012h	; 5288  ..............P.
	defb 00ah,016h,004h,050h,005h,00ch,00eh,00ch,094h,0ffh,011h,000h,007h,001h,054h,011h	; 5298  ...P..........T.
	defb 00ah,016h,001h,054h,003h,00bh,010h,001h,03ch,004h,00bh,010h,001h,09ah,0ffh,00eh	; 52a8  ...T....<.......
	defb 004h,0deh,0a8h,00eh,01ch,0deh,0a8h,007h,00eh,0d0h,0a8h,007h,010h,0d0h,0a8h,007h	; 52b8  ................
	defb 012h,0d0h,0a8h,007h,014h,0d0h,0a8h,00ch,00eh,0d0h,0a8h,00ch,010h,0d0h,0a8h,00ch	; 52c8  ................
	defb 012h,0d0h,0a8h,00ch,014h,0d0h,0a8h,007h,016h,0d0h,0a8h,00ch,016h,0d0h,0a8h,009h	; 52d8  ................
	defb 00eh,0d6h,0a8h,009h,016h,0d6h,0a8h,00eh,00eh,0d6h,0a8h,00eh,016h,0d6h,0a8h,0ffh	; 52e8  ................
	defb 080h,001h,0feh,012h,000h,008h,004h,050h,012h,00ch,014h,004h,050h,0ffh,011h,000h	; 52f8  .......P....P...
	defb 008h,001h,054h,011h,00ch,014h,001h,054h,008h,00dh,001h,006h,060h,00eh,00dh,001h	; 5308  ..T....T....`...
	defb 003h,064h,000h,014h,00ch,011h,090h,0ffh,00eh,005h,0deh,0a8h,00eh,010h,0deh,0a8h	; 5318  .d..............
	defb 008h,00bh,0e6h,0a8h,008h,00eh,0eah,0a8h,000h,016h,0d0h,0a8h,000h,01ah,0d0h,0a8h	; 5328  ................
	defb 000h,01eh,0d0h,0a8h,004h,016h,0d0h,0a8h,004h,01ah,0d0h,0a8h,004h,01eh,0d0h,0a8h	; 5338  ................
	defb 008h,016h,0d0h,0a8h,008h,01ah,0d0h,0a8h,008h,01eh,0d0h,0a8h,00ch,016h,0d0h,0a8h	; 5348  ................
	defb 00ch,01ah,0d0h,0a8h,00ch,01eh,0d0h,0a8h,00eh,016h,0dah,0a8h,00ah,01eh,0dah,0a8h	; 5358  ................
	defb 006h,016h,0dah,0a8h,0ffh,080h,001h,0feh,012h,000h,012h,004h,050h,012h,014h,006h	; 5368  ............P...
	defb 004h,050h,012h,01ch,004h,004h,050h,0ffh,011h,000h,012h,001h,054h,011h,014h,006h	; 5378  .P....P.....T...
	defb 001h,054h,011h,01ch,004h,001h,054h,000h,000h,00ah,011h,090h,000h,010h,010h,011h	; 5388  .T....T.........
	defb 090h,0ffh,000h,002h,0d0h,0a8h,000h,006h,0d0h,0a8h,004h,002h,0d0h,0a8h,004h,006h	; 5398  ................
	defb 0d0h,0a8h,008h,002h,0d0h,0a8h,008h,006h,0d0h,0a8h,00ch,002h,0d0h,0a8h,00ch,006h	; 53a8  ................
	defb 0d0h,0a8h,000h,012h,0d0h,0a8h,000h,016h,0d0h,0a8h,000h,01ah,0d0h,0a8h,000h,01eh	; 53b8  ................
	defb 0d0h,0a8h,004h,012h,0d0h,0a8h,004h,016h,0d0h,0a8h,004h,01ah,0d0h,0a8h,004h,01eh	; 53c8  ................
	defb 0d0h,0a8h,008h,012h,0d0h,0a8h,008h,016h,0d0h,0a8h,008h,01ah,0d0h,0a8h,008h,01eh	; 53d8  ................
	defb 0d0h,0a8h,00ch,012h,0d0h,0a8h,00ch,016h,0d0h,0a8h,00ch,01ah,0d0h,0a8h,00ch,01eh	; 53e8  ................
	defb 0d0h,0a8h,00eh,002h,0dah,0a8h,00eh,006h,0dah,0a8h,006h,006h,0dah,0a8h,00ah,012h	; 53f8  ................
	defb 0dah,0a8h,002h,012h,0dah,0a8h,006h,016h,0dah,0a8h,00eh,016h,0dah,0a8h,002h,01ah	; 5408  ................
	defb 0dah,0a8h,00ah,01ah,0dah,0a8h,0ffh,080h,001h,0feh,012h,000h,008h,004h,050h,012h	; 5418  ..............P.
	defb 00eh,012h,004h,050h,007h,018h,008h,00ah,0a0h,0ffh,011h,000h,008h,001h,054h,011h	; 5428  ...P..........T.
	defb 00eh,012h,001h,054h,000h,000h,006h,011h,090h,004h,017h,009h,001h,03dh,005h,017h	; 5438  ...T.........=..
	defb 009h,002h,09bh,0ffh,000h,002h,0d0h,0a8h,004h,002h,0d0h,0a8h,008h,002h,0d0h,0a8h	; 5448  ................
	defb 00ch,002h,0d0h,0a8h,006h,002h,0dah,0a8h,00eh,002h,0dah,0a8h,00eh,00fh,0deh,0a8h	; 5458  ................
	defb 00eh,013h,0deh,0a8h,00bh,013h,0deh,0a8h,008h,013h,0deh,0a8h,009h,01ah,0d0h,0a8h	; 5468  ................
	defb 009h,01ch,0d0h,0a8h,00dh,01ah,0d0h,0a8h,00dh,01ch,0d0h,0a8h,00bh,01ah,0d6h,0a8h	; 5478  ................
	defb 00bh,01ch,0d6h,0a8h,0ffh,080h,001h,0feh,012h,000h,009h,004h,050h,012h,00dh,006h	; 5488  ............P...
	defb 004h,050h,012h,017h,009h,004h,050h,007h,000h,008h,00ah,0a0h,005h,019h,007h,00ch	; 5498  .P....P.........
	defb 094h,0ffh,011h,000h,009h,001h,054h,011h,00dh,006h,001h,054h,011h,017h,009h,001h	; 54a8  ......T....T....
	defb 054h,004h,000h,009h,001h,03dh,005h,000h,009h,002h,09bh,004h,018h,008h,001h,03ch	; 54b8  T....=.........<
	defb 008h,00fh,001h,006h,060h,00eh,00fh,001h,003h,064h,0ffh,009h,002h,0d0h,0a8h,009h	; 54c8  ....`....d......
	defb 004h,0d0h,0a8h,00dh,002h,0d0h,0a8h,00dh,004h,0d0h,0a8h,00bh,002h,0d6h,0a8h,00bh	; 54d8  ................
	defb 004h,0d6h,0a8h,008h,00dh,0e6h,0a8h,008h,010h,0eah,0a8h,00dh,00dh,0e6h,0a8h,00dh	; 54e8  ................
	defb 010h,0eah,0a8h,007h,01ch,0d0h,0a8h,00ch,01ch,0d0h,0a8h,009h,01ch,0d6h,0a8h,00eh	; 54f8  ................
	defb 01ch,0d6h,0a8h,0ffh,080h,001h,0feh,012h,000h,00ch,004h,050h,012h,00eh,00ah,004h	; 5508  ...........P....
	defb 050h,012h,01ah,006h,004h,050h,005h,000h,007h,00ch,094h,0ffh,004h,000h,009h,001h	; 5518  P....P..........
	defb 03ch,011h,000h,00ch,001h,054h,011h,00eh,00ah,001h,054h,011h,01ah,006h,001h,054h	; 5528  <....T....T....T
	defb 0ffh,007h,003h,0d0h,0a8h,00ch,003h,0d0h,0a8h,009h,003h,0d6h,0a8h,00eh,003h,0d6h	; 5538  ................
	defb 0a8h,00eh,00ah,0deh,0a8h,00bh,00eh,0deh,0a8h,00eh,00eh,0deh,0a8h,005h,012h,0deh	; 5548  ................
	defb 0a8h,008h,012h,0deh,0a8h,00bh,012h,0deh,0a8h,00eh,012h,0deh,0a8h,00bh,016h,0deh	; 5558  ................
	defb 0a8h,00eh,016h,0deh,0a8h,00eh,01ah,0deh,0a8h,0ffh,080h,001h,0feh,012h,000h,010h	; 5568  ................
	defb 004h,050h,012h,013h,00dh,004h,050h,003h,002h,00ch,00eh,0a0h,0ffh,011h,000h,010h	; 5578  .P....P.........
	defb 001h,054h,011h,013h,00dh,001h,054h,001h,001h,00eh,001h,03dh,002h,001h,00eh,001h	; 5588  .T....T....=....
	defb 09bh,007h,015h,001h,007h,060h,00eh,015h,001h,003h,064h,004h,01ch,001h,00ah,060h	; 5598  .....`....d....`
	defb 00eh,01ch,001h,003h,064h,0ffh,005h,004h,0d0h,0a8h,005h,006h,0d0h,0a8h,005h,008h	; 55a8  ....d...........
	defb 0d0h,0a8h,005h,00ah,0d0h,0a8h,009h,004h,0d0h,0a8h,009h,006h,0d0h,0a8h,009h,008h	; 55b8  ................
	defb 0d0h,0a8h,009h,00ah,0d0h,0a8h,00dh,004h,0d0h,0a8h,00dh,006h,0d0h,0a8h,00dh,008h	; 55c8  ................
	defb 0d0h,0a8h,00dh,00ah,0d0h,0a8h,00bh,00ah,0d6h,0a8h,007h,006h,0d6h,0a8h,00bh,013h	; 55d8  ................
	defb 0e6h,0a8h,007h,016h,0eah,0a8h,009h,01ah,0e6h,0a8h,004h,01ah,0e6h,0a8h,00eh,018h	; 55e8  ................
	defb 0deh,0a8h,0ffh,080h,001h,0feh,012h,000h,00eh,004h,050h,012h,010h,010h,004h,050h	; 55f8  ..........P....P
	defb 0ffh,011h,000h,00eh,001h,054h,011h,010h,010h,001h,054h,006h,00ah,001h,008h,060h	; 5608  .....T....T....`
	defb 00eh,00ah,001h,003h,064h,00ah,011h,001h,004h,060h,00eh,011h,001h,003h,064h,00ch	; 5618  ....d....`....d.
	defb 01ah,006h,001h,03eh,00dh,01ah,006h,004h,090h,0ffh,00eh,005h,0deh,0a8h,00bh,008h	; 5628  ...>............
	defb 0e6h,0a8h,006h,00bh,0eah,0a8h,00ah,00fh,0e6h,0a8h,00eh,015h,0deh,0a8h,00bh,015h	; 5638  ................
	defb 0deh,0a8h,008h,015h,0deh,0a8h,005h,015h,0deh,0a8h,00eh,01bh,0d0h,0a8h,00eh,01dh	; 5648  ................
	defb 0d0h,0a8h,0ffh,080h,001h,0feh,012h,000h,020h,004h,050h,009h,012h,00eh,008h,094h	; 5658  ........ .P.....
	defb 0ffh,011h,000h,020h,001h,054h,00ch,000h,006h,001h,03eh,00dh,000h,006h,004h,090h	; 5668  ... .T....>.....
	defb 007h,012h,00eh,001h,03ch,008h,012h,00eh,001h,09ah,0ffh,00eh,002h,0d0h,0a8h,00eh	; 5678  ....<...........
	defb 009h,0deh,0a8h,00eh,00bh,0deh,0a8h,00eh,00dh,0deh,0a8h,00dh,014h,0d0h,0a8h,00dh	; 5688  ................
	defb 016h,0d0h,0a8h,00dh,018h,0d0h,0a8h,00dh,01ah,0d0h,0a8h,00dh,01ch,0d0h,0a8h,00ah	; 5698  ................
	defb 014h,0d6h,0a8h,00ah,016h,0d6h,0a8h,00ah,018h,0d6h,0a8h,00ah,01ah,0d6h,0a8h,00ah	; 56a8  ................
	defb 01ch,0d6h,0a8h,0ffh,0ffh,0ffh,0ffh,0ffh	; 56b8  ........

; ----------------------------------------------------------------------
; DATOS dibujos_casillas: Los dibujos: los de los sprites que cambian segun la
;   escena (0x56C0, 0x57A0) y los de la pausa (0x5700), los de siempre
;   (0x5800, 0x800); las casillas del titulo (0x6000, 0x6800) y sus colores
;   (0x7000, 0x7800); las de la escena 0 (0x60C0, 0x70C0); las de las fases
;   (0x6180, 0x7180) y las de las escenas 4 y 5 (0x6980, 0x7980); las que se
;   animan (0x6440, 0x6780, 0x6798) y los sprites de la escena 4 (0x6F30,
;   0x6F70); la lista de mandos de la demostracion (0x7F00); CASIO de la
;   presentacion (0x7F81, 0x7F8A, 0x7F93), el nombre del titulo (0x7F9D, 12 x
;   2), el del gatito (0x7FB5) y COPYRIGHT 1986 (c) CASIO (0x7FBF)
;   0x56c0..0x8000  (10560 bytes)
DATA_dibujos_casillas:
	defb 002h,00fh,01fh,03fh,037h,0f7h,0ffh,0bfh,03eh,01fh,01eh,01eh,00fh,007h,001h,000h	; 56c0  ...?7...>.......
	defb 003h,005h,09bh,0a5h,0cbh,096h,02ah,056h,0aah,054h,0ach,058h,0bfh,0ffh,0feh,030h	; 56d0  ......*V.T.X...0
	defb 003h,007h,00fh,00dh,03dh,03fh,02ch,00bh,005h,00ah,015h,02ah,055h,0abh,0deh,030h	; 56e0  ....=?,....*U..0
	defb 0c0h,0e0h,0e0h,0e0h,0f0h,0f0h,070h,098h,068h,0ach,04ch,0afh,05fh,03eh,07ch,030h	; 56f0  ......p.h.L._>|0
	defb 000h,000h,000h,000h,000h,000h,031h,07bh,05fh,0ffh,03fh,0ffh,02eh,0fbh,03fh,000h	; 5700  ......1{_.?...?.
	defb 000h,000h,001h,001h,00ah,012h,092h,0c9h,044h,0e8h,080h,0c0h,09fh,0d1h,09fh,00eh	; 5710  ........D.......
	defb 000h,000h,000h,000h,000h,000h,031h,07bh,05fh,0ffh,03fh,0ffh,02eh,0fbh,03fh,000h	; 5720  ......1{_.?...?.
	defb 000h,008h,010h,010h,008h,005h,08ah,0c2h,041h,0e1h,082h,0c0h,09fh,0d1h,09fh,00eh	; 5730  ........A.......
	defb 000h,000h,000h,000h,003h,070h,0dfh,0ffh,05fh,03eh,06fh,05fh,037h,02eh,001h,00fh	; 5740  .....p.._>o_7...
	defb 000h,000h,000h,000h,000h,000h,080h,0c0h,0e4h,0eah,0d7h,0c3h,0b2h,070h,0e2h,0c6h	; 5750  .............p..
	defb 007h,000h,00fh,00fh,008h,01fh,01ch,011h,007h,07fh,0feh,0f0h,000h,000h,000h,000h	; 5760  ................
	defb 0ffh,000h,0bfh,0b8h,077h,0f7h,078h,00fh,0e0h,0ffh,07fh,00fh,000h,000h,000h,000h	; 5770  ....w.x.........
	defb 0ffh,000h,0fbh,03bh,0dch,0dfh,03ch,0e1h,00fh,0ffh,0fch,0e0h,000h,000h,000h,000h	; 5780  ...;..<.........
	defb 0c0h,000h,0e0h,0e0h,020h,0f0h,070h,010h,0c0h,0fch,0feh,01eh,000h,000h,000h,000h	; 5790  .... .p.........
	defb 0c0h,0a0h,0d9h,0a5h,0d3h,069h,054h,06ah,055h,02ah,035h,01ah,0fdh,0ffh,07fh,00ch	; 57a0  .....iTjU*5.....
	defb 040h,0f0h,0f8h,0fch,0ech,0efh,0ffh,0fdh,07ch,0f8h,078h,078h,0f0h,0e0h,080h,000h	; 57b0  @.......|.xx....
	defb 003h,007h,007h,007h,00fh,00fh,00eh,019h,016h,035h,032h,0f5h,0fah,07ch,03eh,00ch	; 57c0  .........52..|>.
	defb 0c0h,0e0h,0f0h,0b0h,0bch,0fch,034h,0d0h,0a0h,050h,0a8h,054h,0aah,0d5h,07bh,00ch	; 57d0  ......4..P.T..{.
	defb 002h,00fh,01fh,03fh,037h,0f7h,0ffh,0bfh,03eh,01fh,01eh,01eh,00fh,007h,001h,000h	; 57e0  ...?7...>.......
	defb 003h,005h,09bh,0a5h,0cbh,096h,02ah,056h,0aah,054h,0ach,058h,0bfh,0ffh,0feh,030h	; 57f0  ......*V.T.X...0
	defb 000h,00ch,012h,03fh,007h,03fh,007h,01fh,000h,030h,070h,000h,000h,060h,070h,038h	; 5800  ...?.?...0p..`p8
	defb 000h,0c0h,0e0h,0e0h,0e0h,070h,0e0h,0c0h,000h,0f8h,0f0h,000h,000h,00ch,01ch,038h	; 5810  .....p.........8
	defb 000h,00fh,00fh,00fh,01fh,01fh,00eh,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 5820  ................
	defb 000h,000h,000h,0c0h,0c0h,0b0h,060h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 5830  ......`.........
	defb 00ch,012h,03fh,007h,03fh,007h,01fh,000h,007h,007h,007h,003h,001h,000h,000h,00fh	; 5840  ..?.?...........
	defb 0c0h,0e0h,0e0h,0e0h,070h,0e0h,0c0h,000h,000h,000h,000h,000h,000h,000h,000h,0c0h	; 5850  ....p...........
	defb 008h,008h,00ch,00eh,007h,007h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 5860  ................
	defb 080h,0c0h,0c0h,0c0h,080h,080h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 5870  ................
	defb 01ch,016h,03fh,00bh,031h,00bh,01eh,04fh,063h,03bh,010h,000h,040h,070h,030h,000h	; 5880  ..?.1..Oc;..@p0.
	defb 070h,0d0h,0f8h,0a0h,018h,0a0h,0f0h,0e4h,08ch,09ch,008h,000h,002h,006h,004h,000h	; 5890  p...............
	defb 000h,004h,00fh,007h,007h,00fh,00fh,002h,000h,000h,000h,000h,000h,000h,000h,000h	; 58a0  ................
	defb 000h,060h,0f0h,0e0h,0e0h,0f8h,0f8h,040h,000h,000h,000h,000h,000h,000h,000h,000h	; 58b0  .`.....@........
	defb 006h,009h,01fh,003h,01fh,003h,00fh,003h,000h,03eh,01ch,000h,0c0h,0c0h,080h,000h	; 58c0  .........>......
	defb 060h,070h,0f0h,0f0h,0b8h,0f0h,0e0h,080h,000h,018h,010h,001h,003h,003h,000h,000h	; 58d0  `p..............
	defb 000h,001h,003h,003h,03fh,03fh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 58e0  ....??..........
	defb 000h,0e0h,0e0h,0e0h,0fch,0fch,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 58f0  ................
	defb 000h,000h,018h,030h,060h,060h,043h,042h,003h,007h,001h,007h,081h,0e3h,0e0h,078h	; 5900  ...0``CB.......x
	defb 000h,000h,000h,000h,000h,000h,08eh,0dah,0feh,0ffh,0fch,077h,0fch,0deh,0f9h,003h	; 5910  ...........w....
	defb 070h,0f8h,0f8h,0f8h,07ch,01ch,01fh,007h,000h,000h,000h,000h,000h,000h,000h,000h	; 5920  p...|...........
	defb 000h,000h,000h,000h,000h,000h,006h,0fch,000h,000h,000h,000h,000h,000h,000h,000h	; 5930  ................
	defb 000h,000h,000h,000h,00ch,012h,021h,03fh,07fh,003h,07fh,007h,07fh,007h,03fh,00fh	; 5940  ......!?......?.
	defb 000h,000h,000h,000h,0c0h,020h,0e0h,0f0h,0f0h,0f8h,0b8h,0bch,0f8h,0f8h,0f0h,0e0h	; 5950  ..... ..........
	defb 007h,000h,007h,007h,007h,007h,007h,007h,003h,001h,001h,000h,000h,007h,007h,007h	; 5960  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0c0h,0e0h,0e0h	; 5970  ................
	defb 000h,00fh,018h,018h,018h,018h,018h,018h,00ch,00eh,006h,007h,007h,000h,000h,000h	; 5980  ................
	defb 000h,080h,0c0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0c0h,0c0h,0c0h,000h,000h,000h	; 5990  ................
	defb 000h,000h,000h,000h,000h,000h,00ch,012h,021h,03fh,07fh,007h,07fh,00fh,07fh,00fh	; 59a0  ........!?......
	defb 000h,000h,000h,000h,000h,000h,0c0h,020h,0e0h,0f0h,0f0h,0f8h,0b8h,0bch,0f8h,0f8h	; 59b0  ....... ........
	defb 03fh,00fh,007h,000h,000h,031h,071h,0f1h,0c0h,000h,000h,000h,0c0h,0e0h,0e0h,0c0h	; 59c0  ?....1q.........
	defb 0f0h,0e0h,000h,000h,000h,0ffh,0feh,0fch,000h,000h,000h,003h,007h,00fh,01eh,00ch	; 59d0  ................
	defb 000h,000h,000h,007h,00fh,00eh,00eh,00eh,00fh,00fh,017h,03bh,03dh,01ch,018h,000h	; 59e0  ...........;=...
	defb 000h,000h,000h,080h,0c0h,000h,000h,000h,0c0h,0e0h,0f0h,0f8h,0f8h,070h,020h,000h	; 59f0  .............p .
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,003h,004h,008h,00fh,01fh,000h	; 5a00  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,030h,088h,078h,0fch,0fch,0feh	; 5a10  ..........0.x...
	defb 01fh,001h,01fh,001h,00fh,003h,001h,008h,018h,01ch,00ch,00fh,087h,082h,0c0h,060h	; 5a20  ...............`
	defb 0eeh,0efh,0feh,0feh,0fch,0f8h,0e0h,000h,000h,000h,000h,080h,030h,030h,03eh,01eh	; 5a30  ............00>.
	defb 000h,000h,000h,000h,000h,000h,00eh,017h,027h,023h,073h,070h,078h,03dh,01fh,000h	; 5a40  ........'#spx=..
	defb 000h,000h,000h,000h,000h,000h,000h,0c0h,0c0h,0c0h,0c0h,060h,0c0h,0c0h,080h,000h	; 5a50  ...........`....
	defb 000h,00fh,01fh,020h,03fh,000h,03fh,03fh,01fh,000h,01bh,030h,003h,007h,013h,008h	; 5a60  ... ?.??...0....
	defb 000h,0c8h,0f4h,014h,0e8h,000h,0f0h,078h,0f0h,000h,0e8h,00ch,0e0h,0e8h,0dch,038h	; 5a70  .......x.......8
	defb 00fh,01fh,020h,03fh,000h,03fh,03fh,01fh,000h,00bh,003h,01dh,01eh,00fh,000h,00fh	; 5a80  .. ?.??.........
	defb 0c8h,0f4h,014h,0e8h,000h,0f0h,078h,0f0h,000h,040h,000h,060h,060h,0c0h,000h,0e0h	; 5a90  ......x..@.``...
	defb 00eh,009h,00fh,063h,013h,013h,009h,008h,011h,013h,023h,043h,043h,025h,019h,001h	; 5aa0  ...c......#CC%..
	defb 038h,0e8h,0f0h,0b8h,0b8h,0fch,0f0h,0c0h,0e0h,0e0h,0f0h,0f0h,0e0h,0c0h,0f0h,0f0h	; 5ab0  8...............
	defb 080h,08eh,0c9h,06fh,023h,023h,023h,061h,040h,047h,04fh,029h,01dh,002h,00fh,00ch	; 5ac0  ...o###a@GO)....
	defb 000h,038h,0e8h,0f0h,0b8h,0b8h,0fch,0f0h,0c0h,0f0h,0feh,0ech,0e0h,0f0h,07eh,01ch	; 5ad0  .8............~.
	defb 000h,000h,010h,020h,02eh,039h,07dh,07dh,07dh,07dh,07eh,03fh,03fh,018h,00eh,003h	; 5ae0  ... .9}}}}~??...
	defb 000h,064h,04ch,0f0h,0f8h,0fch,0ffh,0cfh,0ffh,0feh,0fch,078h,080h,030h,060h,040h	; 5af0  .dL........x.0`@
	defb 000h,000h,000h,000h,001h,08dh,07dh,03dh,03dh,07eh,07fh,0bfh,0dfh,0f7h,040h,000h	; 5b00  ......}==~....@.
	defb 064h,04ch,0f0h,0f8h,0fch,0ffh,0cfh,0ffh,0feh,0fch,07ah,086h,0f7h,0f1h,078h,008h	; 5b10  dL........z...x.
	defb 000h,000h,008h,005h,017h,04fh,03fh,01dh,03dh,01fh,03fh,04fh,017h,005h,008h,000h	; 5b20  .....O?.=.?O....
	defb 000h,000h,020h,040h,0d0h,0e4h,0f8h,070h,078h,0f0h,0f8h,0e4h,0d0h,040h,020h,000h	; 5b30  .. @...px....@ .
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,03dh,07bh,0fbh,0fbh	; 5b40  ............={..
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,00ah,004h,0eeh,0deh,0dbh,0deh	; 5b50  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,001h,003h,003h,007h,003h,00ah,018h,01ch	; 5b60  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,040h,060h,065h,072h,06eh,02eh,02bh,01eh	; 5b70  ........@`ern.+.
	defb 000h,000h,014h,002h,000h,010h,000h,004h,011h,009h,020h,004h,000h,008h,000h,000h	; 5b80  .......... .....
	defb 000h,040h,000h,008h,040h,000h,080h,014h,000h,010h,040h,004h,048h,020h,080h,000h	; 5b90  .@..@.....@.H ..
	defb 000h,008h,000h,004h,000h,04ah,002h,008h,001h,022h,000h,009h,004h,021h,000h,000h	; 5ba0  .....J..."...!..
	defb 000h,040h,092h,000h,010h,044h,090h,044h,000h,0a8h,044h,000h,008h,022h,080h,008h	; 5bb0  .@...D.D..D.."..
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,001h,003h,003h,001h,000h,000h	; 5bc0  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,080h,0c0h,0c0h,080h,000h,000h	; 5bd0  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,003h,006h,004h,004h,006h,003h,000h	; 5be0  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,0c0h,060h,020h,020h,060h,0c0h,000h	; 5bf0  ..........`  `..
	defb 000h,003h,007h,007h,007h,00eh,007h,003h,000h,01fh,00fh,000h,000h,030h,038h,01ch	; 5c00  .............08.
	defb 000h,030h,048h,0fch,0e0h,0fch,0e0h,0f8h,000h,00ch,00eh,000h,000h,006h,00eh,01ch	; 5c10  .0H.............
	defb 000h,000h,000h,003h,003h,00dh,006h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 5c20  ................
	defb 000h,0f0h,0f0h,0f0h,0f8h,0f8h,070h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 5c30  ......p.........
	defb 003h,007h,007h,007h,00eh,007h,003h,000h,000h,000h,000h,000h,000h,000h,000h,003h	; 5c40  ................
	defb 030h,048h,0fch,0e0h,0fch,0e0h,0f8h,000h,0e0h,0e0h,0e0h,0c0h,080h,000h,000h,0f0h	; 5c50  0H..............
	defb 001h,003h,003h,003h,003h,001h,001h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 5c60  ................
	defb 010h,010h,010h,030h,070h,0e0h,0e0h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 5c70  ...0p...........
	defb 000h,000h,000h,000h,003h,00fh,019h,037h,03fh,01fh,00fh,003h,000h,000h,000h,000h	; 5c80  .......7?.......
	defb 000h,000h,000h,000h,0e0h,0f0h,0f0h,0f8h,0f8h,0f0h,0f0h,0e0h,000h,000h,000h,000h	; 5c90  ................
	defb 000h,000h,001h,003h,007h,005h,00dh,00bh,00fh,00fh,00fh,007h,001h,000h,000h,000h	; 5ca0  ................
	defb 000h,000h,080h,0c0h,0e0h,0e0h,0f0h,0f0h,0f0h,0f0h,0f0h,0e0h,080h,000h,000h,000h	; 5cb0  ................
	defb 006h,00eh,00fh,00fh,01dh,00fh,007h,001h,000h,018h,008h,080h,0c0h,0c0h,000h,000h	; 5cc0  ................
	defb 060h,090h,0f8h,0c0h,0f8h,0c0h,0f0h,0c0h,000h,07ch,038h,000h,003h,003h,001h,000h	; 5cd0  `........|8.....
	defb 000h,007h,007h,007h,03fh,03fh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 5ce0  ....??..........
	defb 000h,080h,0c0h,0c0h,0fch,0fch,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 5cf0  ................
	defb 000h,000h,000h,000h,000h,000h,071h,05bh,07fh,0ffh,03fh,0eeh,03fh,07bh,09fh,0c0h	; 5d00  ......q[..?.?{..
	defb 000h,000h,018h,00ch,006h,006h,0c2h,042h,0c0h,0e0h,080h,0e0h,081h,0c7h,007h,01eh	; 5d10  .......B........
	defb 000h,000h,000h,000h,000h,000h,060h,03fh,000h,000h,000h,000h,000h,000h,000h,000h	; 5d20  ......`?........
	defb 00eh,01fh,01fh,01fh,03eh,038h,0f8h,0e0h,000h,000h,000h,000h,000h,000h,000h,000h	; 5d30  ....>8..........
	defb 000h,000h,000h,000h,003h,004h,007h,00fh,00fh,01fh,01dh,03dh,01fh,01fh,00fh,007h	; 5d40  ...........=....
	defb 000h,000h,000h,000h,030h,048h,084h,0fch,0feh,0c0h,0feh,0e0h,0feh,0e0h,0fch,0f0h	; 5d50  ....0H..........
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,003h,007h,007h	; 5d60  ................
	defb 0e0h,000h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0c0h,080h,080h,000h,000h,0e0h,0e0h,0e0h	; 5d70  ................
	defb 000h,001h,003h,007h,007h,007h,007h,007h,007h,007h,003h,003h,003h,000h,000h,000h	; 5d80  ................
	defb 000h,0f0h,018h,018h,018h,018h,018h,018h,030h,070h,060h,0e0h,0e0h,000h,000h,000h	; 5d90  ........0p`.....
	defb 000h,000h,000h,000h,000h,000h,003h,004h,007h,00fh,00fh,01fh,01dh,03dh,01fh,01fh	; 5da0  .............=..
	defb 000h,000h,000h,000h,000h,000h,030h,048h,084h,0fch,0feh,0e0h,0feh,0f0h,0feh,0f0h	; 5db0  ......0H........
	defb 00fh,007h,000h,000h,000h,0ffh,07fh,03fh,000h,000h,000h,0c0h,0e0h,0f0h,078h,030h	; 5dc0  .......?......x0
	defb 0fch,0f0h,0e0h,000h,000h,08ch,08eh,08fh,003h,000h,000h,000h,003h,007h,007h,003h	; 5dd0  ................
	defb 000h,000h,000h,001h,003h,001h,001h,003h,007h,007h,00fh,03fh,01fh,00eh,000h,000h	; 5de0  ...........?....
	defb 000h,000h,000h,0e0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0e8h,0dch,0bch,038h,018h,000h	; 5df0  .............8..
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,00ch,011h,01eh,03fh,03fh,07fh	; 5e00  .............??.
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0c0h,020h,010h,0f0h,0f8h,000h	; 5e10  ........... ....
	defb 077h,0f7h,07fh,07fh,03fh,01fh,003h,000h,000h,000h,000h,001h,00ch,00ch,07ch,078h	; 5e20  w...?.........|x
	defb 0f8h,080h,0f8h,080h,0f0h,0c0h,080h,010h,018h,038h,030h,0f0h,0e1h,041h,003h,006h	; 5e30  .........80..A..
	defb 000h,000h,000h,000h,000h,000h,000h,003h,003h,003h,003h,006h,003h,003h,001h,000h	; 5e40  ................
	defb 000h,000h,000h,000h,000h,000h,070h,0e8h,0e4h,0c4h,0c6h,00eh,01eh,0bch,0f8h,000h	; 5e50  ......p.........
	defb 000h,013h,02fh,028h,017h,000h,00fh,01eh,00fh,000h,017h,030h,007h,017h,03bh,01ch	; 5e60  ../(.......0..;.
	defb 000h,0f0h,0f8h,004h,0fch,000h,0fch,0fch,0f8h,000h,0d8h,00ch,0c0h,0e0h,0c8h,010h	; 5e70  ................
	defb 013h,02fh,028h,017h,000h,00fh,01eh,00fh,000h,002h,000h,006h,006h,003h,000h,007h	; 5e80  ./(.............
	defb 0f0h,0f8h,004h,0fch,000h,0fch,0fch,0f8h,000h,0d0h,0c0h,0b8h,078h,0f0h,000h,0f0h	; 5e90  ............x...
	defb 01ch,017h,00fh,01dh,01dh,03fh,00fh,003h,007h,007h,00fh,00fh,007h,003h,00fh,00fh	; 5ea0  .....?..........
	defb 070h,090h,0f0h,0c6h,0c8h,0c8h,090h,010h,088h,0c8h,0c4h,0c2h,0c2h,0a4h,098h,080h	; 5eb0  p...............
	defb 000h,01ch,017h,00fh,01dh,01dh,03fh,00fh,003h,00fh,07fh,037h,007h,00fh,07eh,038h	; 5ec0  ......?....7..~8
	defb 001h,071h,093h,0f6h,0c4h,0c4h,0c4h,086h,002h,0e2h,0f2h,094h,0b8h,040h,0f0h,030h	; 5ed0  .q...........@.0
	defb 000h,026h,032h,00fh,01fh,03fh,0ffh,0f3h,0ffh,07fh,03fh,01eh,001h,00ch,006h,002h	; 5ee0  .&2..?....?.....
	defb 000h,000h,008h,004h,074h,09ch,0beh,0beh,0beh,0beh,07eh,0fch,0fch,018h,070h,0c0h	; 5ef0  ....t.....~...p.
	defb 026h,032h,00fh,01fh,03fh,0ffh,0f3h,0ffh,07fh,03fh,05eh,061h,0efh,08fh,01eh,010h	; 5f00  &2..?....?^a....
	defb 000h,000h,000h,000h,080h,0b1h,0beh,0bch,0bch,07eh,0feh,0fdh,0fbh,0efh,002h,000h	; 5f10  .........~......
	defb 00eh,00bh,00fh,01fh,007h,01ch,007h,00fh,003h,001h,003h,007h,00fh,06bh,07fh,07eh	; 5f20  .............k.~
	defb 038h,068h,0f8h,0fch,0d0h,0dch,070h,0f8h,0e0h,0c0h,0e0h,0f0h,0f8h,06bh,0ffh,03fh	; 5f30  8h....p......k.?
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,050h,020h,077h,07bh,0dbh,07bh	; 5f40  ..........P w{.{
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,0bch,0deh,0dfh,0dfh	; 5f50  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,002h,006h,0a6h,04eh,076h,074h,0d4h,078h	; 5f60  ...........Nvt.x
	defb 000h,000h,000h,000h,000h,000h,000h,000h,080h,0c0h,0c0h,0e0h,0c0h,050h,018h,038h	; 5f70  .............P.8
	defb 000h,000h,008h,005h,017h,04fh,03fh,01dh,03dh,01fh,03fh,04fh,017h,005h,008h,000h	; 5f80  .....O?.=.?O....
	defb 000h,000h,020h,040h,0d0h,0e4h,0f8h,070h,078h,0f0h,0f8h,0e4h,0d0h,040h,020h,000h	; 5f90  .. @...px....@ .
	defb 000h,000h,001h,025h,017h,00fh,03fh,01bh,07bh,01fh,03fh,00fh,017h,025h,001h,000h	; 5fa0  ...%..?.{.?..%..
	defb 000h,000h,000h,048h,0d0h,0e0h,0f8h,0b0h,0bch,0f0h,0f8h,0e0h,0d0h,048h,000h,000h	; 5fb0  ...H.........H..
	defb 000h,000h,000h,010h,008h,000h,000h,000h,030h,000h,000h,000h,008h,010h,000h,000h	; 5fc0  ........0.......
	defb 000h,000h,080h,084h,008h,000h,000h,000h,006h,000h,000h,000h,008h,084h,080h,000h	; 5fd0  ................
	defb 000h,000h,000h,000h,000h,000h,002h,000h,004h,000h,002h,000h,000h,000h,000h,000h	; 5fe0  ................
	defb 000h,000h,000h,000h,000h,080h,020h,000h,010h,000h,020h,080h,000h,000h,000h,000h	; 5ff0  ...... ... .....
	defb 000h,000h,03fh,07fh,0ffh,0f0h,0e0h,0e0h,0e0h,0e0h,0e0h,0f0h,0ffh,07fh,03fh,000h	; 6000  ..?...........?.
	defb 000h,000h,0e0h,0f0h,0f8h,078h,000h,000h,000h,000h,039h,079h,0f9h,0f3h,0e3h,000h	; 6010  .....x....9y....
	defb 000h,000h,03eh,03eh,07fh,077h,077h,0e3h,0e3h,0e3h,0ffh,0ffh,0c1h,080h,080h,000h	; 6020  ..>>.ww.........
	defb 000h,000h,003h,007h,00fh,00fh,00fh,08fh,087h,083h,0c0h,0cfh,0cfh,0e7h,0e3h,000h	; 6030  ................
	defb 000h,000h,0feh,0ffh,0ffh,007h,000h,0feh,0ffh,0ffh,007h,007h,0ffh,0ffh,0feh,000h	; 6040  ................
	defb 000h,000h,038h,039h,0bbh,0bbh,03bh,03bh,03bh,0bbh,0bbh,0bbh,0bbh,039h,038h,000h	; 6050  ..89..;;;....98.
	defb 000h,000h,0ffh,0ffh,0ffh,0c1h,080h,080h,080h,080h,080h,0c1h,0ffh,0ffh,0ffh,000h	; 6060  ................
	defb 000h,000h,080h,0c0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0c0h,080h,000h	; 6070  ................
	defb 004h,008h,014h,004h,03fh,004h,004h,008h,005h,045h,040h,05ch,070h,040h,040h,03eh	; 6080  ....?....E@\p@@>
	defb 010h,010h,07eh,010h,01eh,001h,001h,01eh,000h,000h,028h,028h,07ch,024h,02ch,020h	; 6090  ..~.......((|$, 
	defb 020h,020h,020h,040h,058h,068h,049h,046h,025h,025h,070h,02eh,02ah,029h,049h,010h	; 60a0     @XhIF%%p.*)I.
	defb 000h,042h,041h,041h,040h,040h,028h,010h,004h,004h,008h,010h,020h,030h,018h,00eh	; 60b0  .BAA@@(..... 0..
	defb 0e8h,0f7h,0ffh,09fh,004h,0ffh,0ffh,087h,08dh,0bfh,0ffh,06eh,0ffh,0ffh,0ffh,080h	; 60c0  ...........n....
	defb 092h,0f7h,0bfh,035h,010h,0ffh,0ffh,007h,020h,06ch,0feh,07fh,01fh,00fh,007h,05eh	; 60d0  ...5.... l.....^
	defb 010h,038h,07fh,0fch,0f0h,0f0h,0e0h,07ch,0f8h,0e0h,080h,0cfh,0f9h,080h,0c0h,0f0h	; 60e0  .8.....|........
	defb 01fh,007h,001h,0fbh,00fh,001h,003h,00fh,000h,000h,000h,000h,000h,000h,000h,000h	; 60f0  ................
	defb 0ffh,0ffh,01eh,00fh,00fh,00fh,007h,002h,018h,03ch,07eh,07eh,03ch,081h,054h,0aah	; 6100  .........<~~<.T.
	defb 0ffh,0ffh,078h,0f0h,0f0h,0f0h,0e0h,040h,076h,07ch,07ah,07eh,07ch,076h,07ch,07ah	; 6110  ..x....@v|z~|v|z
	defb 011h,038h,07dh,0fch,07dh,038h,011h,002h,055h,0aah,055h,0aah,055h,0aah,055h,0aah	; 6120  .8}.}8..U.U.U.U.
	defb 0ffh,088h,01ch,0beh,03fh,0beh,01ch,008h,040h,0e0h,0f0h,0f0h,0f8h,070h,0ffh,0ffh	; 6130  ....?...@....p..
	defb 006h,00fh,00fh,00fh,01eh,0ffh,0ffh,0ffh,055h,028h,081h,0c2h,07eh,07eh,0c3h,0e7h	; 6140  ........U(..~~..
	defb 0ffh,003h,006h,00eh,00ch,00dh,007h,00fh,0f0h,0fch,03ch,07ch,0feh,0feh,0fdh,0ffh	; 6150  ..........<|....
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0e0h,0f8h,03ch,03fh,077h,06fh,07fh,07fh,07fh,03fh,00fh	; 6160  .......<?wo...?.
	defb 0feh,0feh,0ffh,0ffh,0ffh,0f7h,0f1h,0c0h,07eh,0feh,0feh,0feh,0fch,0fch,0f0h,0ffh	; 6170  ........~.......
	defb 0bfh,0b7h,0cfh,0bfh,0fbh,0feh,0bfh,0ffh,0f9h,0bfh,0feh,0dfh,0ffh,0ffh,0dfh,0ffh	; 6180  ................
	defb 0ffh,0dfh,0ffh,0ffh,0ffh,0bfh,0fbh,0ffh,0ffh,0fbh,0dfh,0ffh,0ffh,0ffh,0ffh,0ffh	; 6190  ................
	defb 0ffh,0ffh,0dfh,0ffh,0ffh,0efh,0ffh,0ffh,084h,0ceh,0dfh,0ffh,0fbh,090h,0ffh,022h	; 61a0  ..............."
	defb 000h,02fh,077h,07bh,07bh,077h,02fh,000h,000h,0fch,0feh,0feh,0feh,0feh,0fch,001h	; 61b0  ./w{{w/.........
	defb 000h,0ffh,0ffh,0dbh,07eh,024h,0ffh,000h,000h,03fh,07fh,07fh,07fh,07fh,03fh,080h	; 61c0  ....~$...?....?.
	defb 000h,0f4h,0eeh,0deh,0deh,0eeh,0f4h,000h,03ch,066h,024h,052h,04ah,024h,066h,03ch	; 61d0  ........<f$RJ$f<
	defb 022h,0aeh,0ffh,0ffh,0efh,083h,0ffh,024h,000h,05fh,037h,07fh,05fh,03dh,06fh,03fh	; 61e0  "......$._7._=o?
	defb 000h,01dh,02fh,057h,02eh,03fh,055h,07bh,000h,0feh,0feh,0feh,0feh,0feh,0feh,0feh	; 61f0  ../W.?U{........
	defb 03fh,07fh,07fh,0ffh,0ffh,07fh,07fh,03fh,0f8h,0fch,0fch,0feh,0feh,0fch,0fch,0f8h	; 6200  ?......?........
	defb 0ffh,0e3h,0d7h,0f7h,081h,0f7h,0e7h,0ffh,0ffh,06bh,07fh,00fh,07fh,07fh,007h,0ffh	; 6210  .........k......
	defb 010h,010h,018h,008h,008h,004h,004h,003h,000h,000h,000h,000h,000h,000h,000h,000h	; 6220  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 6230  ................
	defb 000h,000h,000h,000h,003h,007h,00fh,00fh,000h,000h,000h,0feh,0ffh,0ffh,0ffh,0ffh	; 6240  ................
	defb 000h,000h,000h,000h,080h,0c0h,0e0h,0e0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 6250  ................
	defb 01eh,01eh,01eh,01eh,01eh,01eh,01eh,01eh,00fh,00fh,007h,007h,003h,001h,000h,000h	; 6260  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0feh,038h,0e0h,0e0h,0c0h,0c0h,080h,000h,000h,000h	; 6270  .......8........
	defb 080h,000h,080h,080h,0c0h,0f0h,0feh,0ffh,07fh,05fh,037h,07fh,05fh,03dh,06fh,03fh	; 6280  ........._7._=o?
	defb 0c8h,0e2h,0d0h,0a8h,0d1h,0c0h,0aah,084h,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh	; 6290  ................
	defb 052h,037h,03bh,07fh,0ffh,0ddh,080h,004h,03dh,00fh,001h,000h,000h,000h,000h,0e0h	; 62a0  R7;.....=.......
	defb 0d1h,078h,0ffh,03eh,000h,000h,000h,07fh,0fch,0f8h,0c0h,001h,003h,00fh,0ffh,0ffh	; 62b0  .x.>............
	defb 048h,0dah,0feh,0ffh,0f7h,043h,001h,020h,04eh,071h,03eh,05fh,03fh,057h,07fh,03dh	; 62c0  H....C. Nq>_?W.=
	defb 000h,0ffh,000h,0ffh,0c4h,080h,0cah,0e0h,032h,0c6h,03eh,0feh,0feh,0feh,0feh,0feh	; 62d0  ........2.>.....
	defb 03fh,07fh,0eeh,0deh,0bch,0bdh,0fdh,0bdh,07ch,07eh,07fh,0ffh,0feh,0feh,0ech,0d8h	; 62e0  ?.......|~......
	defb 0fdh,0d6h,0dah,0deh,0ffh,0efh,07fh,03fh,0fch,0f8h,0f4h,0ech,06ch,07eh,07fh,07eh	; 62f0  .......?....l~.~
	defb 0ffh,003h,00fh,03eh,070h,0f7h,0ffh,0ffh,030h,0feh,0ffh,03fh,0ffh,0ffh,0ffh,0ffh	; 6300  ...>p...0..?....
	defb 00eh,03fh,07fh,0ffh,0bfh,0ffh,0ffh,0ffh,0ffh,0c0h,0f8h,0fch,0feh,0f6h,0f2h,0f3h	; 6310  .?..............
	defb 0ffh,0efh,073h,07ch,03fh,007h,0ffh,0ffh,0ffh,0ffh,0ffh,07fh,0ffh,0ffh,0ffh,002h	; 6320  ..s|?...........
	defb 0ffh,0ffh,0ffh,0f7h,0f3h,0e0h,0c0h,0ffh,0e3h,0e7h,08eh,0feh,0f8h,0f0h,0ffh,0ffh	; 6330  ................
	defb 012h,07fh,07bh,0f8h,078h,071h,0f1h,070h,048h,0feh,0feh,0ffh,07eh,0feh,0ffh,07eh	; 6340  ..{.xq.pH...~..~
	defb 060h,0e0h,060h,060h,0f0h,078h,07fh,012h,01eh,00fh,006h,006h,00fh,01eh,0feh,040h	; 6350  `.``.x.........@
	defb 012h,07fh,07fh,0e0h,067h,067h,0e3h,071h,048h,0feh,0feh,007h,0e6h,0e6h,0c7h,08eh	; 6360  ....gg.qH.......
	defb 078h,0fch,07eh,07eh,0feh,07eh,07fh,012h,01eh,03fh,07eh,07eh,07fh,07eh,0feh,048h	; 6370  x.~~.~...?~~.~.H
	defb 060h,0f1h,0f1h,0f3h,073h,01ah,004h,00bh,0c0h,0e0h,0e0h,0e0h,0c0h,0ffh,0ffh,0ffh	; 6380  `...s...........
	defb 079h,079h,0f1h,0f1h,060h,0ffh,0ffh,0ffh,0c0h,0ech,0e4h,0e6h,0c3h,003h,003h,003h	; 6390  yy..`...........
	defb 070h,006h,0f9h,006h,0f9h,086h,006h,004h,0e0h,00fh,0f0h,00fh,0f0h,01fh,0ffh,0ffh	; 63a0  p...............
	defb 00eh,0e0h,01fh,0e0h,01fh,0f1h,0ffh,0ffh,060h,010h,018h,00ch,00ch,00eh,006h,006h	; 63b0  ........`.......
	defb 0ffh,0ffh,0ffh,0feh,0fch,0f8h,0f8h,0f8h,0ffh,0ffh,0ffh,07fh,03fh,01fh,01fh,01fh	; 63c0  ............?...
	defb 0f8h,0f8h,0f8h,0fch,0feh,0ffh,0ffh,0ffh,01fh,01fh,01fh,03fh,07fh,0ffh,0ffh,0ffh	; 63d0  ...........?....
	defb 0fch,0f8h,0f0h,0f0h,0e0h,0e0h,0e0h,0e0h,03fh,01fh,00fh,00fh,007h,007h,007h,007h	; 63e0  ........?.......
	defb 0e0h,0e0h,0e0h,0e0h,0f0h,0f0h,0f8h,0fch,007h,007h,007h,007h,00fh,00fh,01fh,03fh	; 63f0  ...............?
	defb 000h,000h,000h,000h,000h,000h,000h,000h,0ffh,0ffh,0fbh,07fh,0ffh,0ffh,0efh,0ffh	; 6400  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,000h,000h,000h,000h,000h,000h,000h,000h	; 6410  ................
	defb 0ffh,0ffh,002h,0efh,0efh,087h,003h,010h,0ffh,020h,0ffh,0f7h,0e7h,0c1h,0c0h,020h	; 6420  ......... ..... 
	defb 040h,008h,0ffh,0dfh,0cfh,0e3h,0c1h,012h,0ffh,0ffh,0ffh,07eh,07eh,038h,0ffh,041h	; 6430  @..........~~8.A
	defb 000h,002h,040h,000h,000h,021h,000h,000h,000h,080h,010h,000h,000h,008h,000h,020h	; 6440  ..@..!......... 
	defb 000h,020h,004h,000h,000h,002h,000h,000h,000h,008h,001h,000h,000h,080h,000h,002h	; 6450  . ..............
	defb 000h,07fh,07fh,07fh,000h,0f7h,0f7h,0f7h,077h,077h,077h,070h,077h,077h,077h,007h	; 6460  ........wwwpwww.
	defb 02ah,03eh,03eh,01ch,04ah,0b5h,091h,0c3h,000h,000h,000h,000h,000h,000h,000h,000h	; 6470  *>>.J...........
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0f8h,0c0h,0ffh,0ffh,0fch,0e0h,007h,03ch,063h,05eh	; 6480  .............<c^
	defb 0ffh,0ffh,000h,0ffh,081h,07eh,081h,03fh,0ffh,0ffh,03fh,007h,0e0h,03ch,086h,0fah	; 6490  .....~.?..?..<..
	defb 080h,000h,080h,080h,0c0h,0f0h,0feh,0ffh,0ffh,0ffh,0ffh,0ffh,0fch,0f0h,003h,07fh	; 64a0  ................
	defb 0ffh,0e7h,081h,018h,07eh,02fh,03bh,06fh,0ffh,0ffh,0ffh,07fh,03fh,007h,0e0h,0feh	; 64b0  ....~/;o....?...
	defb 000h,000h,000h,000h,000h,000h,000h,000h,07fh,05fh,037h,07fh,05fh,03dh,06fh,03fh	; 64c0  ........._7._=o?
	defb 037h,01dh,02fh,057h,02eh,03fh,055h,07bh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh	; 64d0  7./W.?U{........
	defb 000h,000h,000h,000h,000h,000h,000h,000h,03dh,00fh,001h,000h,000h,000h,000h,0e0h	; 64e0  ........=.......
	defb 02eh,087h,0ffh,03eh,000h,000h,000h,07fh,0fch,0f8h,0c0h,001h,003h,00fh,0ffh,0ffh	; 64f0  ...>............
	defb 060h,0f1h,0f1h,0f3h,073h,01ah,004h,00bh,0c0h,0e0h,0e0h,0e0h,0c0h,0ffh,0ffh,0ffh	; 6500  `...s...........
	defb 079h,0f9h,0f1h,0f1h,060h,0ffh,0ffh,0ffh,0c0h,0ech,0e4h,0e6h,0c3h,003h,003h,003h	; 6510  y...`...........
	defb 070h,0f1h,0f9h,0f9h,0f9h,079h,006h,004h,0e0h,0f0h,0f0h,0f0h,0f0h,0e0h,0ffh,0ffh	; 6520  p....y..........
	defb 00eh,01fh,01fh,01fh,01fh,00eh,0ffh,0ffh,060h,010h,018h,00ch,00ch,00eh,006h,006h	; 6530  ........`.......
	defb 0ffh,0ffh,0ffh,001h,0fch,007h,0f8h,007h,0ffh,0ffh,0ffh,080h,03fh,0e0h,01fh,0e0h	; 6540  ............?...
	defb 0f8h,007h,0f8h,003h,0feh,0ffh,0ffh,0ffh,01fh,0e0h,01fh,0c0h,07fh,0ffh,0ffh,0ffh	; 6550  ................
	defb 0fch,007h,0f0h,00fh,0e0h,01fh,0e0h,01fh,03fh,0e0h,00fh,0f0h,007h,0f8h,007h,0f8h	; 6560  ........?.......
	defb 0e0h,01fh,0e0h,01fh,0f0h,00fh,0f8h,003h,007h,0f8h,007h,0f8h,00fh,0f0h,01fh,0c0h	; 6570  ................
	defb 0ffh,0ffh,0c0h,00fh,03fh,07fh,008h,019h,0feh,0f8h,003h,087h,0cfh,001h,083h,08fh	; 6580  ....?...........
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 6590  ................
	defb 001h,0f8h,0fch,0feh,0feh,0ffh,060h,0f0h,0ffh,0ffh,081h,018h,03ch,07eh,010h,07ch	; 65a0  ......`.....<~.|
	defb 0fbh,0fbh,0fbh,0f9h,0f9h,0fdh,0fdh,0fdh,0fdh,0fch,0fch,0feh,0feh,0feh,0feh,0feh	; 65b0  ................
	defb 0feh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,07fh	; 65c0  ................
	defb 07fh,07fh,07fh,07fh,07fh,07fh,07fh,03fh,03fh,0bfh,0bfh,0bfh,0bfh,0bfh,0bfh,0bfh	; 65d0  .......??.......
	defb 0bfh,09fh,09fh,0dfh,0dfh,0dfh,0dfh,0dfh,0dfh,0dfh,0dfh,0dfh,0dfh,0dfh,0dfh,0dfh	; 65e0  ................
	defb 09fh,09fh,0bfh,0bfh,0bfh,0bfh,0bfh,0bfh,03fh,03fh,07fh,07fh,07fh,07fh,07fh,07fh	; 65f0  ........??......
	defb 0feh,0feh,0feh,0feh,0fch,0fdh,0fdh,0fdh,0f9h,0fbh,0fbh,0fbh,0f3h,0f7h,0e7h,0efh	; 6600  ................
	defb 0cfh,0dfh,0dfh,09fh,0bfh,0bfh,03fh,07fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0feh	; 6610  ......?.........
	defb 0feh,0fch,0fdh,0f9h,0f3h,0f7h,0e7h,0cfh,09fh,03fh,07fh,0ffh,0ffh,0ffh,0ffh,0ffh	; 6620  .........?......
	defb 0dfh,0dfh,0dfh,09fh,09fh,0bfh,0bfh,0bfh,0bfh,03fh,03fh,07fh,07fh,07fh,07fh,07fh	; 6630  .........??.....
	defb 07fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0feh	; 6640  ................
	defb 0feh,0feh,0feh,0feh,0feh,0feh,0feh,0fch,0fch,0fdh,0fdh,0fdh,0fdh,0fdh,0fdh,0fdh	; 6650  ................
	defb 0fdh,0f9h,0f9h,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh	; 6660  ................
	defb 0f9h,0f9h,0fdh,0fdh,0fdh,0fdh,0fdh,0fdh,0fch,0fch,0feh,0feh,0feh,0feh,0feh,0feh	; 6670  ................
	defb 07fh,07fh,07fh,07fh,03fh,0bfh,0bfh,0bfh,09fh,0dfh,0dfh,0dfh,0cfh,0efh,0e7h,0f7h	; 6680  ....?...........
	defb 0f3h,0fbh,0fbh,0f9h,0fdh,0fdh,0fch,0feh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,07fh	; 6690  ................
	defb 07fh,03fh,0bfh,09fh,0cfh,0efh,0e7h,0f3h,0f9h,0fch,0feh,0ffh,0ffh,0ffh,0ffh,0ffh	; 66a0  .?..............
	defb 0bfh,0b7h,0cfh,0bfh,0fbh,0feh,0bfh,0ffh,0f9h,0bfh,0feh,0dfh,0ffh,0ffh,0dfh,0ffh	; 66b0  ................
	defb 0ffh,0dfh,0ffh,0ffh,0ffh,0bfh,0fbh,0ffh,0ffh,0fbh,0dfh,0ffh,0ffh,0ffh,0ffh,0ffh	; 66c0  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,0ffh,0ffh,0f7h,0ffh,0bfh,0ffh,0fdh,0ffh	; 66d0  ................
	defb 0ffh,0ffh,0feh,0feh,0fch,0fch,0fch,0fch,0fch,0f8h,0f8h,0f8h,0f8h,0f0h,0f0h,0e0h	; 66e0  ................
	defb 0e0h,0c0h,0c0h,0c0h,080h,080h,080h,0ffh,0ffh,0feh,0fch,0fch,0f8h,0f0h,0e0h,0e0h	; 66f0  ................
	defb 0c0h,080h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0feh,0fch,0f8h,0f0h,0e0h	; 6700  ................
	defb 080h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0feh,0fch,0e0h,080h,0ffh,0ffh,0ffh	; 6710  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0fch,080h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0e0h	; 6720  ................
	defb 0ffh,0ffh,07fh,07fh,03fh,03fh,03fh,03fh,03fh,01fh,01fh,01fh,01fh,00fh,00fh,007h	; 6730  ....?????.......
	defb 007h,003h,003h,003h,001h,001h,001h,0ffh,0ffh,07fh,03fh,03fh,01fh,00fh,007h,007h	; 6740  ..........??....
	defb 003h,001h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,07fh,03fh,01fh,00fh,007h	; 6750  ............?...
	defb 001h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,07fh,03fh,007h,001h,0ffh,0ffh,0ffh	; 6760  ..........?.....
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,03fh,001h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,007h	; 6770  .....?..........
	defb 001h,000h,040h,09ch,008h,024h,020h,000h,004h,020h,001h,0c1h,000h,000h,040h,024h	; 6780  ..@..$ .. ....@$
	defb 020h,004h,081h,071h,0fbh,020h,020h,0ffh,000h,020h,020h,024h,004h,004h,001h,000h	; 6790   ..q.  ..  $....
	defb 000h,002h,000h,020h,020h,024h,004h,004h,004h,044h,000h,000h,000h,020h,020h,024h	; 67a0  ...  $...D...  $
	defb 020h,024h,004h,004h,040h,000h,000h,020h,000h,000h,000h,000h,000h,000h,000h,000h	; 67b0   $..@.. ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 67c0  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 67d0  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 67e0  ................
	defb 000h,000h,000h,0f8h,000h,000h,000h,000h,044h,06ch,0d6h,054h,0feh,028h,07ch,07ch	; 67f0  ........Dl.T.(||
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 6800  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 6810  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 6820  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 6830  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 6840  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 6850  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 6860  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 6870  ................
	defb 0ffh,0ffh,0fah,0f3h,0f7h,0e7h,0cfh,09fh,0ffh,0ffh,003h,0fbh,0f7h,0efh,09fh,0dfh	; 6880  ................
	defb 0ffh,0fbh,0f3h,0d7h,0e6h,0ebh,0cdh,0ddh,0ffh,0bbh,0bbh,0bbh,001h,0bbh,0ffh,001h	; 6890  ................
	defb 02fh,0ech,0efh,0efh,0efh,0efh,0ffh,0ffh,0e7h,001h,0f7h,0f7h,077h,027h,08fh,0ffh	; 68a0  /...........w'..
	defb 0b9h,079h,0f5h,0edh,0ddh,0fbh,0f7h,0ffh,06dh,06dh,001h,06dh,06dh,001h,07dh,0ffh	; 68b0  .y......mm.mm.}.
	defb 000h,000h,000h,000h,03fh,03fh,038h,032h,000h,000h,000h,000h,0fch,0fch,01ch,0cch	; 68c0  ....??82........
	defb 0ffh,0ffh,0feh,0feh,0feh,0e0h,0feh,0feh,0ffh,0ffh,0ffh,0ffh,0ffh,003h,0ffh,0ffh	; 68d0  ................
	defb 036h,02eh,02dh,02dh,02bh,023h,037h,03fh,0ech,0e4h,0f4h,0f4h,0e4h,0ech,0dch,0fch	; 68e0  6.--+#7?........
	defb 0feh,0feh,0fdh,0fdh,0fbh,0f7h,0cfh,0ffh,07fh,07fh,03fh,09fh,0cfh,0e3h,0f1h,0ffh	; 68f0  ..........?.....
	defb 0ffh,0c0h,0dfh,0c0h,0dfh,0c0h,0ffh,0f0h,0ffh,003h,0fbh,003h,0fbh,003h,0ffh,00fh	; 6900  ................
	defb 0ffh,007h,0b7h,0aeh,0ach,09eh,0a7h,0b6h,0dfh,08fh,027h,073h,0f9h,003h,0dfh,003h	; 6910  ..........'s....
	defb 0f7h,0f0h,0f7h,0f0h,0f7h,0f0h,0f7h,0ffh,0efh,00fh,0efh,00fh,0efh,00fh,0efh,0ffh	; 6920  ................
	defb 0bah,092h,0a6h,0bfh,0bfh,0bfh,0beh,0ffh,0dbh,0dbh,003h,0dfh,00fh,0a7h,071h,0ffh	; 6930  ..............q.
	defb 000h,000h,000h,000h,000h,000h,000h,000h,07eh,081h,0bdh,0a1h,0a1h,0bdh,081h,07eh	; 6940  ........~......~
	defb 07fh,080h,080h,080h,080h,080h,080h,07fh,003h,004h,008h,008h,00fh,008h,008h,008h	; 6950  ................
	defb 0c0h,020h,010h,010h,0f0h,010h,010h,010h,07fh,080h,080h,07eh,001h,001h,001h,0feh	; 6960  . .........~....
	defb 010h,010h,010h,010h,010h,010h,010h,010h,07eh,081h,081h,081h,081h,081h,081h,07eh	; 6970  ........~......~
	defb 002h,006h,007h,00fh,00bh,01fh,017h,017h,01fh,01fh,01fh,01fh,00fh,007h,0ffh,03eh	; 6980  ...............>
	defb 000h,080h,060h,0b8h,0dch,0dch,0ceh,0eeh,0eeh,0eeh,0eeh,0eeh,0ech,0d8h,0b0h,07eh	; 6990  ..`............~
	defb 000h,000h,001h,001h,001h,006h,00eh,01bh,03ch,03fh,03fh,03fh,03fh,01fh,01fh,007h	; 69a0  ........<????...
	defb 07ch,0feh,087h,0feh,078h,0c0h,0f0h,0b8h,078h,0fch,0fch,0fch,0f8h,0f8h,0f0h,0c0h	; 69b0  |...x...x.......
	defb 0efh,0efh,0efh,000h,03eh,07eh,0ffh,0ffh,077h,077h,077h,000h,07ch,0fdh,0ffh,0ffh	; 69c0  ....>~..www.|...
	defb 0efh,0efh,0efh,000h,03eh,07eh,0ffh,0ffh,077h,077h,077h,000h,07ch,0fdh,0ffh,0ffh	; 69d0  ....>~..www.|...
	defb 0f7h,0fbh,0ffh,07fh,0bfh,0fbh,0fdh,0ffh,0ffh,0bfh,0bdh,0bdh,0f5h,0f7h,0f7h,0ffh	; 69e0  ................
	defb 0ffh,0c3h,0a5h,099h,099h,0a5h,0c3h,0ffh,000h,000h,000h,000h,000h,000h,000h,000h	; 69f0  ................
	defb 03fh,07fh,07fh,0ffh,0ffh,07fh,07fh,03fh,0f8h,0fch,0fch,0feh,0feh,0fch,0fch,0f8h	; 6a00  ?......?........
	defb 0ffh,0e3h,0d7h,0f7h,081h,0f7h,0e7h,0ffh,0ffh,06bh,07fh,00fh,07fh,07fh,007h,0ffh	; 6a10  .........k......
	defb 010h,010h,018h,008h,008h,004h,004h,003h,000h,000h,000h,000h,000h,000h,000h,000h	; 6a20  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 6a30  ................
	defb 000h,000h,000h,000h,003h,007h,00fh,00fh,000h,000h,000h,0feh,0ffh,0ffh,0ffh,0ffh	; 6a40  ................
	defb 000h,000h,000h,000h,080h,0c0h,0e0h,0e0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 6a50  ................
	defb 01eh,01eh,01eh,01eh,01eh,01eh,01eh,01eh,00fh,00fh,007h,007h,003h,001h,000h,000h	; 6a60  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0feh,038h,0e0h,0e0h,0c0h,0c0h,080h,000h,000h,000h	; 6a70  .......8........
	defb 0deh,080h,03ch,0beh,07eh,07ch,081h,07bh,0c5h,039h,07dh,07eh,03dh,0c3h,0efh,0f4h	; 6a80  ..<.~|.{.9}~=...
	defb 0b9h,0ddh,0c0h,0b9h,03ch,0deh,020h,0bdh,0f3h,0efh,01fh,08fh,067h,070h,0fdh,0fdh	; 6a90  ....<. .....gp..
	defb 0feh,0feh,0feh,000h,0efh,0efh,0efh,000h,0feh,0feh,0feh,000h,0efh,0efh,0efh,000h	; 6aa0  ................
	defb 0feh,0feh,0feh,000h,0efh,0efh,0efh,000h,0feh,0feh,0feh,000h,0efh,0efh,0efh,000h	; 6ab0  ................
	defb 00fh,00ch,03fh,030h,040h,000h,077h,077h,0f0h,030h,0fch,0ffh,0ffh,000h,076h,056h	; 6ac0  ..?0@.ww.0....vV
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 6ad0  ................
	defb 075h,055h,055h,055h,055h,055h,055h,055h,056h,056h,056h,056h,052h,054h,052h,054h	; 6ae0  uUUUUUUUVVVVRTRT
	defb 035h,035h,035h,035h,035h,035h,035h,03eh,058h,044h,054h,054h,050h,014h,050h,0ech	; 6af0  5555555>XDTTP.P.
	defb 07eh,07ch,07eh,07ah,07ch,07eh,074h,07eh,07ch,0ffh,0e0h,0fch,07fh,01fh,007h,000h	; 6b00  ~|~z|~t~|.......
	defb 000h,0c0h,0f8h,0feh,080h,0f0h,0fch,0f8h,000h,000h,000h,000h,000h,000h,000h,000h	; 6b10  ................
	defb 0ffh,0feh,0fbh,0feh,0fbh,0feh,0f5h,0ffh,000h,003h,01fh,07fh,001h,00fh,03fh,01fh	; 6b20  ..............?.
	defb 03eh,0ffh,007h,03fh,0feh,0f8h,0e0h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 6b30  >..?............
	defb 012h,07fh,07bh,0f8h,078h,071h,0f1h,070h,048h,0feh,0feh,0ffh,07eh,0feh,0ffh,07eh	; 6b40  ..{.xq.pH...~..~
	defb 060h,0e0h,060h,060h,0f0h,078h,07fh,012h,01eh,00fh,006h,006h,00fh,01eh,0feh,040h	; 6b50  `.``.x.........@
	defb 012h,07fh,07fh,0e0h,067h,067h,0e3h,071h,048h,0feh,0feh,007h,0e6h,0e6h,0c7h,08eh	; 6b60  ....gg.qH.......
	defb 078h,0fch,07eh,07eh,0feh,07eh,07fh,012h,01eh,03fh,07eh,07eh,07fh,07eh,0feh,048h	; 6b70  x.~~.~...?~~.~.H
	defb 060h,0f1h,0f1h,0f3h,073h,01ah,004h,00bh,0c0h,0e0h,0e0h,0e0h,0c0h,000h,000h,000h	; 6b80  `...s...........
	defb 079h,0f9h,0f1h,0f1h,060h,000h,000h,000h,0c0h,0ech,0e4h,0e6h,0c3h,003h,003h,003h	; 6b90  y...`...........
	defb 070h,0f1h,0f9h,0f9h,0f9h,079h,006h,004h,0e0h,0f0h,0f0h,0f0h,0f0h,0e0h,000h,000h	; 6ba0  p....y..........
	defb 00eh,01fh,01fh,01fh,01fh,00eh,000h,000h,060h,010h,018h,00ch,00ch,00eh,006h,006h	; 6bb0  ........`.......
	defb 000h,000h,000h,001h,002h,007h,004h,007h,000h,000h,000h,080h,000h,0e0h,000h,0e0h	; 6bc0  ................
	defb 004h,007h,004h,003h,001h,000h,000h,000h,000h,0e0h,000h,0c0h,000h,000h,000h,000h	; 6bd0  ................
	defb 002h,007h,008h,00dh,010h,01bh,010h,01fh,000h,0e0h,000h,0f0h,000h,0f8h,000h,0f8h	; 6be0  ................
	defb 010h,01fh,010h,01fh,008h,00fh,004h,003h,000h,0f8h,000h,0f8h,000h,0f0h,000h,0c0h	; 6bf0  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 6c00  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 6c10  ................
	defb 000h,000h,000h,003h,006h,00dh,00fh,01fh,01fh,01fh,01fh,01fh,03fh,03fh,018h,000h	; 6c20  ............??..
	defb 000h,00ch,0fah,0beh,07ch,0fch,0fch,0fch,0fch,0f8h,0f8h,0f0h,0f0h,0c0h,000h,000h	; 6c30  ....|...........
	defb 010h,010h,07eh,010h,01eh,001h,001h,01eh,005h,0e5h,020h,026h,045h,044h,044h,038h	; 6c40  ..~....... &EDD8
	defb 000h,022h,077h,07fh,07fh,03eh,01ch,008h,044h,066h,066h,044h,044h,000h,0cch,088h	; 6c50  ."w..>..DffDD...
	defb 000h,07fh,07fh,07fh,000h,0f7h,0f7h,0f7h,0eeh,0eeh,0eeh,0e0h,0eeh,0eeh,0eeh,00eh	; 6c60  ................
	defb 02ah,03ah,03eh,01ch,04ah,0b5h,091h,0c3h,0feh,0feh,0feh,000h,0efh,0efh,0efh,000h	; 6c70  *:>.J...........
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0c3h,0a5h,099h,099h,0a5h,0c3h,0ffh	; 6c80  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 6c90  ................
	defb 0ffh,070h,040h,07fh,07fh,07fh,07fh,0ffh,0ffh,070h,040h,07fh,07fh,07fh,07fh,0ffh	; 6ca0  .p@......p@.....
	defb 0ffh,007h,004h,0f7h,0f7h,0f7h,0f7h,0ffh,0ffh,007h,004h,0f7h,0f7h,0f7h,0f7h,0ffh	; 6cb0  ................
	defb 0ffh,0c0h,0c0h,0d0h,0d0h,0c8h,0c0h,0ffh,0ffh,083h,083h,0a3h,0a3h,093h,083h,0ffh	; 6cc0  ................
	defb 0f7h,0fbh,0ffh,07fh,0bfh,0fbh,0fdh,0ffh,0ffh,0bfh,0bdh,0bdh,0f5h,0f7h,0f7h,0ffh	; 6cd0  ................
	defb 0c0h,0c0h,0d0h,0d0h,0c8h,0c0h,0ffh,000h,083h,083h,0a3h,0a3h,093h,083h,0ffh,000h	; 6ce0  ................
	defb 0bbh,0bbh,0bbh,0bbh,0bbh,0bbh,0bbh,0bbh,000h,000h,000h,000h,000h,000h,000h,000h	; 6cf0  ................
	defb 000h,0ffh,0feh,0ffh,0ffh,0ffh,0feh,0ffh,000h,0bfh,0afh,0bfh,0bfh,0bfh,0afh,0bfh	; 6d00  ................
	defb 000h,0dfh,057h,0dfh,0dfh,0dfh,057h,0dfh,000h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 6d10  ..W...W.........
	defb 020h,040h,004h,028h,0a0h,004h,088h,048h,006h,088h,0b0h,006h,0ech,000h,007h,0ffh	; 6d20   @.(...H........
	defb 040h,040h,003h,083h,038h,0a0h,003h,083h,050h,0b0h,003h,081h,060h,0b0h,003h,081h	; 6d30  @@..8...P...`...
	defb 070h,0b0h,003h,081h,050h,0c0h,003h,081h,060h,0c0h,003h,081h,070h,0c0h,003h,081h	; 6d40  p...P...`...p...
	defb 050h,0d0h,003h,081h,060h,0d0h,003h,081h,070h,0d0h,003h,081h,0ffh,028h,0d8h,001h	; 6d50  P...`...p....(..
	defb 088h,0e4h,001h,0ffh,038h,0b8h,002h,000h,0ffh,0ech,000h,007h,018h,088h,001h,088h	; 6d60  ....8...........
	defb 080h,005h,0ffh,040h,020h,003h,000h,0ffh,0ech,000h,003h,040h,068h,001h,088h,0c0h	; 6d70  ...@ ......@h...
	defb 004h,0ech,000h,007h,0ffh,018h,080h,001h,000h,028h,020h,003h,000h,028h,030h,003h	; 6d80  .........( ..(0.
	defb 000h,028h,040h,003h,000h,028h,050h,003h,000h,0ffh,0ech,000h,007h,088h,040h,004h	; 6d90  .(@..(P.......@.
	defb 030h,0b0h,001h,010h,090h,001h,050h,090h,001h,0ffh,030h,058h,003h,001h,030h,068h	; 6da0  0.....P...0X..0h
	defb 003h,001h,040h,058h,003h,001h,040h,068h,003h,001h,088h,060h,004h,000h,0ffh,0ech	; 6db0  ..@X..@h...`....
	defb 000h,007h,030h,010h,001h,020h,0d0h,001h,0ech,000h,003h,0ffh,050h,050h,003h,001h	; 6dc0  ..0.. ......PP..
	defb 030h,090h,003h,003h,088h,0b0h,002h,000h,020h,0c8h,003h,000h,020h,0d8h,003h,000h	; 6dd0  0....... ... ...
	defb 0ffh,0ech,000h,007h,020h,038h,001h,040h,070h,001h,088h,0c8h,004h,0ffh,088h,068h	; 6de0  .... 8.@p......h
	defb 003h,001h,088h,080h,003h,001h,020h,070h,003h,003h,020h,0b0h,003h,001h,0ffh,0ech	; 6df0  ...... p.. .....
	defb 000h,007h,020h,028h,001h,028h,090h,001h,0ffh,088h,040h,004h,000h,088h,0e0h,004h	; 6e00  .. (.(....@.....
	defb 000h,048h,058h,003h,003h,040h,0d0h,003h,003h,028h,048h,003h,001h,028h,058h,003h	; 6e10  .HX..@...(H..(X.
	defb 001h,028h,068h,003h,001h,028h,0d0h,003h,000h,0ffh,0ech,000h,003h,088h,048h,004h	; 6e20  .(h..(........H.
	defb 038h,030h,001h,038h,0b0h,001h,0ech,000h,007h,0ffh,070h,0c0h,001h,000h,038h,090h	; 6e30  80.8......p...8.
	defb 003h,001h,020h,0d8h,003h,001h,0ffh,0ech,000h,007h,030h,050h,001h,050h,080h,001h	; 6e40  .. .......0P.P..
	defb 060h,0d8h,001h,0ffh,028h,020h,003h,001h,028h,030h,003h,001h,028h,040h,003h,001h	; 6e50  `...( ..(0..(@..
	defb 058h,068h,003h,001h,028h,0a8h,003h,003h,040h,0d8h,003h,000h,040h,0e8h,003h,000h	; 6e60  Xh..(...@...@...
	defb 0ffh,0ech,000h,007h,0ech,000h,003h,070h,068h,001h,038h,0a8h,001h,050h,0d8h,001h	; 6e70  .......ph.8..P..
	defb 0ffh,070h,058h,004h,001h,030h,030h,003h,000h,030h,040h,003h,000h,050h,058h,003h	; 6e80  .pX..00..0@..PX.
	defb 003h,088h,078h,004h,000h,038h,0c8h,002h,000h,020h,0a8h,003h,001h,0ffh,0ech,000h	; 6e90  ..x..8... ......
	defb 007h,030h,060h,001h,060h,090h,001h,070h,020h,001h,050h,0c0h,001h,0ffh,058h,040h	; 6ea0  .0`.`..p .P...X@
	defb 003h,003h,028h,018h,003h,001h,028h,028h,003h,001h,088h,068h,003h,001h,030h,090h	; 6eb0  ..(...((...h..0.
	defb 003h,001h,030h,0a0h,003h,001h,030h,0b0h,003h,001h,088h,0b0h,003h,001h,0ffh,040h	; 6ec0  ..0...0........@
	defb 078h,006h,0ech,000h,007h,0ffh,028h,0e0h,003h,081h,038h,0e0h,003h,081h,048h,0e0h	; 6ed0  x.....(...8...H.
	defb 003h,081h,058h,0e0h,003h,081h,068h,0e0h,003h,081h,078h,0e0h,003h,081h,088h,0e0h	; 6ee0  ..X...h...x.....
	defb 003h,081h,0ffh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 6ef0  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 6f00  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 6f10  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 6f20  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,01fh,03fh,07eh,0ffh,07eh,032h,002h	; 6f30  ..........?~.~2.
	defb 000h,003h,01ch,03eh,03dh,03fh,06fh,0e7h,0f0h,0c8h,0a4h,094h,008h,008h,008h,008h	; 6f40  ...>=?o.........
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,00ch,03fh,07fh,0feh,07ch,019h,001h	; 6f50  ..........?..|..
	defb 000h,000h,000h,003h,01ch,03eh,03dh,02fh,067h,0e0h,0f8h,0c4h,0a3h,0a0h,020h,040h	; 6f60  .....>=/g..... @
	defb 000h,0c0h,038h,07ch,0bch,0fch,0f6h,0e7h,00fh,013h,025h,029h,010h,010h,010h,010h	; 6f70  ..8|......%)....
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,0f8h,0fch,07eh,0ffh,07eh,04ch,040h	; 6f80  ...........~.~L@
	defb 000h,000h,000h,0c0h,038h,07ch,0bch,0f4h,0e6h,007h,01fh,023h,0c5h,005h,004h,002h	; 6f90  ....8|.....#....
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,030h,0fch,0feh,07fh,03eh,098h,080h	; 6fa0  .........0...>..
	defb 018h,010h,030h,060h,040h,000h,000h,000h,01eh,01eh,03eh,03ch,07ch,078h,078h,0f0h	; 6fb0  ..0`@.....><|xx.
	defb 00eh,00eh,00eh,00fh,00fh,007h,007h,007h,0ffh,0f8h,007h,0ffh,0ffh,0ffh,0ffh,0ffh	; 6fc0  ................
	defb 000h,000h,001h,001h,003h,003h,007h,007h,0f0h,0e0h,0e0h,0c5h,0cfh,0ffh,0ffh,0ffh	; 6fd0  ................
	defb 007h,007h,007h,007h,007h,007h,007h,007h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,007h	; 6fe0  ................
	defb 000h,000h,000h,0f8h,000h,000h,000h,000h,044h,06ch,0d6h,054h,0feh,028h,07ch,07ch	; 6ff0  ........Dl.T.(||
	defb 0f0h,0f0h,0f0h,0f0h,0ffh,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0ffh,0f0h,0f0h,0f0h	; 7000  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7010  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0ffh,0ffh,0f0h,0f0h,0f0h,0f0h	; 7020  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7030  ................
	defb 0f0h,0f0h,0f0h,0ffh,0ffh,0f0h,0f0h,0f0h,0ffh,0ffh,0f0h,0f0h,0ffh,0ffh,0f0h,0f0h	; 7040  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7050  ................
	defb 0f0h,0f0h,0ffh,0ffh,0ffh,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0ffh,0ffh,0ffh,0f0h	; 7060  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7070  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7080  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7090  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 70a0  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 70b0  ................
	defb 0c4h,0c4h,0cfh,0c6h,0c6h,06fh,06fh,064h,0c4h,0c4h,0cfh,0c6h,06fh,06fh,06fh,064h	; 70c0  .....ood....oood
	defb 0c4h,0c4h,0c6h,0c6h,0c6h,06fh,06fh,064h,0c4h,0c4h,0c4h,0c6h,0c6h,0c6h,0c6h,0c4h	; 70d0  .....ood........
	defb 0c4h,0c4h,0c4h,0c6h,0c6h,0c6h,0c6h,0c4h,042h,042h,042h,020h,020h,042h,042h,042h	; 70e0  ........BBB  BBB
	defb 042h,042h,042h,020h,020h,042h,042h,042h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 70f0  BBB  BBB........
	defb 04fh,04fh,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,0b0h	; 7100  OO..............
	defb 04fh,04fh,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h	; 7110  OO..............
	defb 0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h	; 7120  ................
	defb 04fh,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,04fh,04fh	; 7130  O.............OO
	defb 0b4h,0b4h,0b4h,0b4h,0b4h,04fh,04fh,04fh,0b0h,0b4h,0b4h,0cbh,0b4h,0b4h,0cbh,0cbh	; 7140  .....OOO........
	defb 04fh,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0ffh	; 7150  O...............
	defb 04fh,04fh,04fh,04fh,04fh,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h	; 7160  OOOOO...........
	defb 0f4h,0f4h,0ffh,0ffh,0ffh,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,04fh	; 7170  ...............O
	defb 0c2h,0c0h,0c0h,0c2h,0c3h,0c0h,0c3h,0cfh,0c3h,0c2h,0c2h,0c3h,0cfh,0cfh,0c2h,0cfh	; 7180  ................
	defb 0cfh,0c3h,0cfh,0cfh,0cfh,0c3h,0c3h,0cfh,0cfh,0c3h,0c3h,0cfh,0cfh,0cfh,0cfh,0cfh	; 7190  ................
	defb 0cfh,0cfh,0c3h,0cfh,0cfh,0c3h,0cfh,0cfh,0c7h,0c7h,0c7h,0cfh,0c6h,0c6h,06fh,076h	; 71a0  ..............ov
	defb 0f0h,0a0h,090h,090h,090h,060h,060h,0f0h,0f0h,0a0h,090h,090h,090h,060h,060h,060h	; 71b0  .....``......```
	defb 0f0h,0afh,09fh,096h,096h,096h,06fh,0f0h,0f0h,0a0h,090h,090h,090h,060h,060h,060h	; 71c0  ......o......```
	defb 0f0h,0a0h,090h,090h,090h,060h,060h,0f0h,060h,060h,0a6h,0a6h,0a6h,0a6h,060h,060h	; 71d0  .....``.``....``
	defb 0c7h,0c7h,0cfh,0cfh,0c6h,0c6h,06fh,076h,0f0h,060h,060h,060h,060h,060h,060h,060h	; 71e0  ......ov.```````
	defb 0f0h,096h,096h,096h,096h,096h,096h,096h,0f0h,090h,090h,090h,090h,090h,090h,090h	; 71f0  ................
	defb 0e0h,0e0h,0e0h,0efh,0efh,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h	; 7200  ................
	defb 0ffh,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0ffh,0ffh,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0ffh	; 7210  ................
	defb 0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7220  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7230  ................
	defb 0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h	; 7240  ................
	defb 0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h	; 7250  ................
	defb 0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h	; 7260  ................
	defb 0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h,0d4h	; 7270  ................
	defb 0c0h,0f0h,0c0h,0c0h,0c0h,0c0h,0c0h,0cfh,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h	; 7280  ................
	defb 0ebh,0ebh,0ebh,0ebh,0ebh,0ebh,0ebh,0ebh,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h	; 7290  ................
	defb 0c7h,0c7h,0c7h,0c7h,0cfh,0c6h,0c6h,076h,0e0h,0e0h,0e0h,0f0h,0f0h,0f0h,0f0h,0c0h	; 72a0  .......v........
	defb 0ebh,0ebh,0efh,0e0h,0f0h,0f0h,0f0h,0c0h,0b0h,0b0h,0b0h,0c0h,0c0h,0c0h,0cfh,0cfh	; 72b0  ................
	defb 0c7h,0c7h,0c7h,0cfh,0c6h,0c6h,0c6h,076h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h	; 72c0  .......v........
	defb 0f0h,0bfh,0f0h,0bfh,0ebh,0ebh,0ebh,0ebh,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h	; 72d0  ................
	defb 0e4h,094h,090h,090h,090h,090h,090h,090h,060h,060h,060h,06fh,060h,060h,060h,060h	; 72e0  ........```o````
	defb 090h,090h,090h,090h,09fh,090h,090h,090h,060h,060h,060h,060h,060h,060h,060h,060h	; 72f0  ........````````
	defb 04fh,0f4h,0f4h,0f4h,0f4h,0f4h,0ffh,0ffh,0f4h,0f4h,0ffh,0f4h,0ffh,0ffh,0ffh,0ffh	; 7300  O...............
	defb 0f4h,0f4h,0f4h,0ffh,0f4h,0ffh,0ffh,0ffh,04fh,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h	; 7310  ........O.......
	defb 0ffh,0f4h,0f4h,0f4h,0f4h,0f4h,04fh,04fh,0ffh,0ffh,0ffh,0f4h,0ffh,0ffh,0ffh,0f4h	; 7320  ......OO........
	defb 0ffh,0ffh,0ffh,0f4h,0f4h,0f4h,0f4h,04fh,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,04fh,04fh	; 7330  .......O......OO
	defb 0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0f4h,0f6h,0f6h,0f6h,0f6h,0ffh,0f6h,0f6h,0ffh,0f6h	; 7340  ................
	defb 0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h	; 7350  ................
	defb 0f4h,0f4h,0f4h,0f8h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f8h,0f4h,0f4h,0f4h,0f4h	; 7360  ................
	defb 0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h	; 7370  ................
	defb 0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0cfh,0cfh,0cfh	; 7380  ................
	defb 0fch,0fch,0fch,0fch,0fch,0cfh,0cfh,0cfh,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch	; 7390  ................
	defb 0fch,0c8h,0fch,0c8h,0fch,0c8h,0fch,0fch,0fch,0c8h,0fch,0c8h,0fch,0c8h,0cfh,0cfh	; 73a0  ................
	defb 0fch,0c8h,0fch,0c8h,0fch,0c8h,0cfh,0cfh,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch	; 73b0  ................
	defb 0cfh,0cfh,0cfh,0cbh,0c0h,0cbh,0c0h,0cbh,0cfh,0cfh,0cfh,0cbh,0c0h,0cbh,0c0h,0cbh	; 73c0  ................
	defb 0c0h,0cbh,0c0h,0cbh,0c0h,0cfh,0cfh,0cfh,0c0h,0cbh,0c0h,0cbh,0c0h,0cfh,0cfh,0cfh	; 73d0  ................
	defb 0c0h,0cbh,0c0h,0cbh,0c0h,0cbh,0c0h,0cbh,0c0h,0cbh,0c0h,0cbh,0c0h,0cbh,0c0h,0cbh	; 73e0  ................
	defb 0c0h,0cbh,0c0h,0cbh,0c0h,0cbh,0c0h,0cbh,0c0h,0cbh,0c0h,0cbh,0c0h,0cbh,0c0h,0cbh	; 73f0  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0cfh,0cfh,0c3h,0c3h,0cfh,0cfh,0c3h,0cfh	; 7400  ................
	defb 04fh,04fh,04fh,04fh,04fh,04fh,04fh,04fh,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7410  OOOOOOOO........
	defb 0cfh,0cfh,0fch,0c7h,0c7h,0c7h,0c7h,0f7h,0cfh,0fch,0cfh,0c7h,0c7h,0c7h,0c7h,0f7h	; 7420  ................
	defb 0fch,0fch,0cfh,0c7h,0c7h,0c7h,0c7h,0f7h,0cfh,0cfh,0cfh,0c7h,0c7h,0c7h,07fh,0f7h	; 7430  ................
	defb 0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h	; 7440  ................
	defb 0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h	; 7450  ................
	defb 0f0h,060h,060h,060h,0f0h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h	; 7460  .```.```````````
	defb 0b0h,0b6h,0b6h,0b6h,030h,063h,063h,063h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7470  ....0ccc........
	defb 0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,0c0h,0c0h,04fh,04fh,040h,040h,0b0h,0b0h,0e0h,0e0h	; 7480  ........OO@@....
	defb 04fh,04fh,0f0h,0bfh,0b0h,0b0h,0b0h,0b0h,04fh,04fh,040h,040h,0b0h,0b0h,0b0h,0b0h	; 7490  OO......OO@@....
	defb 0c0h,0f0h,0c0h,0c0h,0c0h,0c0h,0c0h,0cfh,0cfh,0cfh,0cfh,0cfh,0c0h,0c0h,060h,060h	; 74a0  ..............``
	defb 0cfh,0c0h,0c0h,090h,090h,096h,096h,096h,0cfh,0cfh,0cfh,0c0h,0c0h,0c0h,090h,090h	; 74b0  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,060h,060h,060h,060h,060h,060h,060h,060h	; 74c0  ........````````
	defb 096h,096h,096h,096h,096h,096h,096h,096h,090h,090h,090h,090h,090h,090h,090h,090h	; 74d0  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,060h,060h,060h,0f0h,0f0h,0f0h,0f0h,0c0h	; 74e0  ........```.....
	defb 096h,096h,06fh,060h,0f0h,0f0h,0f0h,0c0h,090h,090h,090h,0c0h,0c0h,0c0h,0cfh,0cfh	; 74f0  ..o`............
	defb 0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,04fh,04fh,04fh	; 7500  .............OOO
	defb 0f4h,0f4h,0f4h,0f4h,0f4h,04fh,04fh,04fh,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h	; 7510  .....OOO........
	defb 0f4h,084h,0f4h,084h,0f4h,084h,0f4h,0f4h,0f4h,084h,0f4h,084h,0f4h,084h,04fh,04fh	; 7520  ..............OO
	defb 0f4h,084h,0f4h,084h,0f4h,084h,04fh,04fh,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h	; 7530  ......OO........
	defb 04fh,04fh,04fh,0b4h,040h,0b4h,040h,0b4h,04fh,04fh,04fh,0b4h,040h,0b4h,040h,0b4h	; 7540  OOO.@.@.OOO.@.@.
	defb 040h,0b4h,040h,0b4h,040h,04fh,04fh,04fh,040h,0b4h,040h,0b4h,040h,04fh,04fh,04fh	; 7550  @.@.@OOO@.@.@OOO
	defb 040h,0b4h,040h,0b4h,040h,0b4h,040h,0b4h,040h,0b4h,040h,0b4h,040h,0b4h,040h,0b4h	; 7560  @.@.@.@.@.@.@.@.
	defb 040h,0b4h,040h,0b4h,040h,0b4h,040h,0b4h,040h,0b4h,040h,0b4h,040h,0b4h,040h,0b4h	; 7570  @.@.@.@.@.@.@.@.
	defb 04fh,04fh,040h,020h,020h,020h,0c2h,0c2h,040h,040h,020h,020h,020h,0c2h,0c2h,0c2h	; 7580  OO@   ..@@   ...
	defb 04fh,04fh,04fh,04fh,04fh,04fh,04fh,04fh,06fh,06fh,06fh,06fh,06fh,06fh,06fh,06fh	; 7590  OOOOOOOOoooooooo
	defb 040h,020h,020h,020h,020h,02fh,0c2h,0c2h,04fh,04fh,040h,020h,020h,020h,0c2h,0c2h	; 75a0  @    /..OO@   ..
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h	; 75b0  ................
	defb 0c0h,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,0c0h	; 75c0  ................
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h	; 75d0  ................
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h	; 75e0  ................
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h	; 75f0  ................
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h	; 7600  ................
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,0c0h	; 7610  ................
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0cfh,0cfh,0cfh,0cfh,0cfh	; 7620  ................
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h	; 7630  ................
	defb 0c0h,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,0c0h	; 7640  ................
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h	; 7650  ................
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h	; 7660  ................
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h	; 7670  ................
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h	; 7680  ................
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,0c0h	; 7690  ................
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0cfh,0cfh,0cfh,0cfh,0cfh	; 76a0  ................
	defb 0c2h,0c0h,0c0h,0c2h,0c3h,0c0h,0c3h,0cfh,0c3h,0c2h,0c2h,0c3h,0cfh,0cfh,0c2h,0cfh	; 76b0  ................
	defb 0cfh,0c3h,0cfh,0cfh,0cfh,0c3h,0c3h,0cfh,0cfh,0c3h,0c3h,0cfh,0cfh,0cfh,0cfh,0cfh	; 76c0  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0cfh,0cfh,0c3h,0cfh,0c3h,0cfh,0c3h,0cfh	; 76d0  ................
	defb 0cfh,0cfh,0c4h,0c4h,0c4h,0c4h,0c4h,0c4h,0c4h,0c4h,0c4h,0c4h,0c4h,0c4h,0c4h,0c4h	; 76e0  ................
	defb 0c4h,0c4h,0c4h,0c4h,0c4h,0c4h,0c4h,04fh,0cfh,0c4h,0c4h,0c4h,0c4h,0c4h,0c4h,0c4h	; 76f0  .......O........
	defb 0c4h,0c4h,04fh,04fh,04fh,04fh,04fh,04fh,0cfh,0cfh,0cfh,0c4h,0c4h,0c4h,0c4h,0c4h	; 7700  ..OOOOOO........
	defb 0c4h,04fh,04fh,04fh,04fh,04fh,04fh,04fh,0cfh,0c4h,0c4h,0c4h,0c4h,04fh,04fh,04fh	; 7710  .OOOOOOO.....OOO
	defb 0cfh,0cfh,0cfh,0cfh,0cfh,0c4h,0c4h,04fh,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,0c4h	; 7720  .......O........
	defb 0cfh,0cfh,0c4h,0c4h,0c4h,0c4h,0c4h,0c4h,0c4h,0c4h,0c4h,0c4h,0c4h,0c4h,0c4h,0c4h	; 7730  ................
	defb 0c4h,0c4h,0c4h,0c4h,0c4h,0c4h,0c4h,04fh,0cfh,0c4h,0c4h,0c4h,0c4h,0c4h,0c4h,0c4h	; 7740  .......O........
	defb 0c4h,0c4h,04fh,04fh,04fh,04fh,04fh,04fh,0cfh,0cfh,0cfh,0c4h,0c4h,0c4h,0c4h,0c4h	; 7750  ..OOOOOO........
	defb 0c4h,04fh,04fh,04fh,04fh,04fh,04fh,04fh,0cfh,0c4h,0c4h,0c4h,0c4h,04fh,04fh,04fh	; 7760  .OOOOOOO.....OOO
	defb 0cfh,0cfh,0cfh,0cfh,0cfh,0c4h,0c4h,04fh,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,0c4h	; 7770  .......O........
	defb 0f4h,0f4h,0f4h,047h,047h,0f7h,0f7h,0f7h,0f4h,0f4h,0f4h,047h,0f7h,0f7h,0f7h,0f7h	; 7780  ...GG......G....
	defb 0f4h,0f4h,0f4h,074h,074h,0f7h,0f7h,07fh,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h	; 7790  ...tt...........
	defb 0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h	; 77a0  ................
	defb 0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f7h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 77b0  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 77c0  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 77d0  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 77e0  ................
	defb 0f0h,0b0h,0f0h,0f0h,0f0h,0b0h,0f0h,0b0h,0f0h,0f0h,0f0h,0f0h,0f0h,0d0h,0d0h,0d0h	; 77f0  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7800  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7810  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7820  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7830  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7840  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7850  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7860  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7870  ................
	defb 08fh,08fh,080h,080h,080h,080h,080h,080h,08fh,08fh,080h,080h,080h,080h,080h,080h	; 7880  ................
	defb 0bfh,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0bfh,0b0h,0b0h,0b0h,0b0h,0b0h,0bfh,0b0h	; 7890  ................
	defb 080h,080h,080h,080h,080h,080h,08fh,08fh,080h,080h,080h,080h,080h,080h,080h,08fh	; 78a0  ................
	defb 0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0bfh,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0bfh	; 78b0  ................
	defb 0f0h,0f0h,0f0h,0f0h,030h,030h,030h,030h,0f0h,0f0h,0f0h,0f0h,030h,030h,030h,030h	; 78c0  ....0000....0000
	defb 07fh,07fh,070h,070h,070h,070h,070h,070h,07fh,07fh,07fh,07fh,07fh,070h,07fh,07fh	; 78d0  ..pppppp.....p..
	defb 030h,030h,030h,030h,030h,030h,030h,030h,030h,030h,030h,030h,030h,030h,030h,030h	; 78e0  0000000000000000
	defb 070h,070h,070h,070h,070h,070h,070h,07fh,070h,070h,070h,070h,070h,070h,070h,07fh	; 78f0  ppppppp.ppppppp.
	defb 0dfh,0d0h,0d0h,0d0h,0d0h,0d0h,0dfh,0d0h,0dfh,0d0h,0d0h,0d0h,0d0h,0d0h,0dfh,0d0h	; 7900  ................
	defb 09fh,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h	; 7910  ................
	defb 0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0dfh,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0dfh	; 7920  ................
	defb 090h,090h,090h,090h,090h,090h,090h,09fh,090h,090h,090h,090h,090h,090h,090h,09fh	; 7930  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7940  ................
	defb 080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h	; 7950  ................
	defb 080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h	; 7960  ................
	defb 080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h	; 7970  ................
	defb 0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0dch,0cfh,0c0h	; 7980  ................
	defb 0f0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0dch,0c0h	; 7990  ................
	defb 0f0h,0f0h,0c0h,0c0h,0c0h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h	; 79a0  ................
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h,080h	; 79b0  ................
	defb 040h,040h,040h,0f0h,094h,094h,09fh,06fh,040h,040h,040h,0f0h,094h,094h,09fh,06fh	; 79c0  @@@....o@@@....o
	defb 040h,040h,040h,0f0h,0e4h,0e4h,0efh,0efh,040h,040h,040h,0f0h,0e4h,0e4h,0efh,0efh	; 79d0  @@@.....@@@.....
	defb 040h,040h,04fh,040h,040h,040h,040h,04fh,0afh,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0afh	; 79e0  @@O@@@@O........
	defb 0ffh,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0ffh,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 79f0  ................
	defb 0e0h,0e0h,0e0h,0efh,0efh,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h	; 7a00  ................
	defb 0ffh,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0ffh,0ffh,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0ffh	; 7a10  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7a20  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7a30  ................
	defb 0f0h,0f0h,0f0h,0f0h,0d0h,0d0h,0d0h,0d0h,0f0h,0f0h,0f0h,0d0h,0dfh,0dfh,0dfh,0dfh	; 7a40  ................
	defb 0f0h,0f0h,0f0h,0f0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h	; 7a50  ................
	defb 0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0f0h,0f0h	; 7a60  ................
	defb 0dfh,0dfh,0dfh,0dfh,0dfh,0dfh,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0f0h,0f0h,0f0h	; 7a70  ................
	defb 0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h	; 7a80  ................
	defb 0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h	; 7a90  ................
	defb 0e0h,0e0h,0e0h,0f0h,0e0h,0e0h,0e0h,0f0h,0e0h,0e0h,0e0h,0f0h,0e0h,0e0h,0e0h,0f0h	; 7aa0  ................
	defb 0e0h,0e0h,0e0h,0f0h,0e0h,0e0h,0e0h,0f0h,0e0h,0e0h,0e0h,0f0h,0e0h,0e0h,0e0h,0f0h	; 7ab0  ................
	defb 030h,030h,030h,0f3h,0f3h,0f0h,030h,030h,0c0h,0c0h,0c0h,0cfh,0cfh,0f0h,0c0h,0c0h	; 7ac0  000...00........
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7ad0  ................
	defb 030h,030h,030h,030h,030h,030h,030h,030h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h	; 7ae0  00000000........
	defb 030h,030h,030h,030h,030h,030h,030h,030h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h	; 7af0  00000000........
	defb 050h,050h,050h,050h,050h,050h,050h,050h,050h,05fh,0b5h,0b5h,0b0h,0b0h,0b0h,0f0h	; 7b00  PPPPPPPPP_......
	defb 0f0h,050h,050h,050h,0b5h,0b5h,0b5h,0b0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7b10  .PPP............
	defb 05fh,050h,050h,050h,050h,050h,050h,05fh,0f0h,050h,050h,050h,0b5h,0b5h,0b5h,0b0h	; 7b20  _PPPPPP_.PPP....
	defb 050h,05fh,0b5h,0b5h,0b0h,0b0h,0b0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7b30  P_..............
	defb 0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0f4h,0f6h,0f6h,0f6h,0f6h,0ffh,0f6h,0f6h,0ffh,0f6h	; 7b40  ................
	defb 0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h	; 7b50  ................
	defb 0f4h,0f4h,0f4h,0f8h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f8h,0f4h,0f4h,0f4h,0f4h	; 7b60  ................
	defb 0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h	; 7b70  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7b80  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7b90  ................
	defb 0f0h,080h,0f0h,080h,0f0h,080h,0f0h,0f0h,0f0h,080h,0f0h,080h,0f0h,080h,0f0h,0f0h	; 7ba0  ................
	defb 0f0h,080h,0f0h,080h,0f0h,080h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7bb0  ................
	defb 0f0h,0f0h,0f0h,0b0h,0a0h,0b0h,0a0h,0b0h,0f0h,0f0h,0f0h,0b0h,0f0h,0b0h,0f0h,0b0h	; 7bc0  ................
	defb 0a0h,0b0h,0a0h,0b0h,0a0h,0f0h,0f0h,0f0h,0f0h,0b0h,0f0h,0b0h,0f0h,0f0h,0f0h,0f0h	; 7bd0  ................
	defb 0a0h,0b0h,0a0h,0b0h,0a0h,0b0h,0a0h,0b0h,0f0h,0b0h,0f0h,0b0h,0f0h,0b0h,0f0h,0b0h	; 7be0  ................
	defb 0a0h,0b0h,0a0h,0b0h,0a0h,0b0h,0a0h,0b0h,0f0h,0b0h,0f0h,0b0h,0f0h,0b0h,0f0h,0b0h	; 7bf0  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7c00  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7c10  ................
	defb 0f0h,0f0h,0f0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0f0h	; 7c20  ................
	defb 0f0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0f0h,0f0h	; 7c30  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7c40  ................
	defb 0f0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0d0h,0b0h,0b0h,0b0h,0b0h,0b0h,0f0h,0b0h,0b0h	; 7c50  ................
	defb 0f0h,060h,060h,060h,0f0h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h	; 7c60  .```.```````````
	defb 0b0h,0b6h,0b6h,0b6h,030h,063h,063h,063h,0e0h,0e0h,0e0h,0f0h,0e0h,0e0h,0e0h,0f0h	; 7c70  ....0ccc........
	defb 0efh,0efh,0efh,0efh,0efh,0efh,0efh,0efh,0ffh,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0ffh	; 7c80  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7c90  ................
	defb 06fh,0f9h,0f9h,096h,096h,096h,096h,06fh,06fh,0f9h,0f9h,096h,096h,096h,096h,06fh	; 7ca0  o......oo......o
	defb 06fh,0f9h,0f9h,096h,096h,096h,096h,06fh,06fh,0f9h,0f9h,096h,096h,096h,096h,06fh	; 7cb0  o......oo......o
	defb 0afh,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0afh,0afh,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0afh	; 7cc0  ................
	defb 040h,040h,04fh,040h,040h,040h,040h,04fh,0afh,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0afh	; 7cd0  @@O@@@@O........
	defb 0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0afh,0f0h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0afh,0f0h	; 7ce0  ................
	defb 060h,060h,060h,060h,060h,060h,060h,060h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7cf0  ````````........
	defb 0f0h,06fh,060h,06fh,06fh,06fh,060h,06fh,0f0h,060h,060h,060h,060h,060h,060h,060h	; 7d00  .o`ooo`o.```````
	defb 0f0h,060h,060h,060h,060h,060h,060h,060h,0f0h,06fh,06fh,06fh,06fh,06fh,06fh,06fh	; 7d10  .```````.ooooooo
	defb 040h,0a0h,006h,070h,0b0h,001h,0ffh,070h,098h,002h,000h,098h,088h,003h,000h,048h	; 7d20  @..p...p.......H
	defb 038h,003h,003h,0ffh,0ffh,058h,0b0h,006h,098h,048h,001h,088h,0c0h,006h,0ffh,058h	; 7d30  8....X...H.....X
	defb 088h,003h,000h,058h,0c8h,003h,000h,0ffh,038h,038h,001h,058h,0e0h,001h,0ffh,058h	; 7d40  ...X....88.X...X
	defb 058h,003h,000h,058h,078h,003h,001h,058h,098h,003h,001h,058h,0b8h,003h,000h,098h	; 7d50  X..Xx..X...X....
	defb 078h,004h,001h,098h,0c8h,004h,000h,0ffh,058h,058h,006h,058h,0d0h,001h,020h,0e4h	; 7d60  x.......XX.X.. .
	defb 001h,0ffh,080h,078h,003h,001h,080h,0c0h,003h,003h,0ffh,078h,078h,001h,078h,0c8h	; 7d70  ...x.......xx.x.
	defb 006h,048h,040h,001h,0ech,000h,003h,0ffh,048h,080h,003h,001h,048h,0c0h,003h,001h	; 7d80  .H@.....H...H...
	defb 0a8h,0c8h,003h,001h,0ffh,068h,050h,001h,028h,048h,001h,028h,0d0h,006h,0ffh,028h	; 7d90  .....hP.(H.(...(
	defb 038h,003h,001h,078h,088h,004h,000h,058h,098h,003h,000h,038h,0b8h,003h,000h,0ffh	; 7da0  8..x...X...8....
	defb 028h,040h,001h,038h,070h,006h,060h,0c8h,001h,080h,048h,006h,0ffh,060h,020h,003h	; 7db0  (@.8p.`...H..` .
	defb 003h,090h,070h,003h,000h,0a0h,090h,003h,000h,048h,0a0h,003h,003h,0ffh,090h,038h	; 7dc0  ..p......H.....8
	defb 001h,048h,080h,006h,010h,0d0h,001h,0ffh,0a0h,090h,003h,001h,090h,0d0h,004h,000h	; 7dd0  .H..............
	defb 0ffh,040h,020h,001h,040h,060h,006h,068h,0c8h,001h,0ffh,078h,040h,003h,001h,038h	; 7de0  .@ .@`.h...x@..8
	defb 0a8h,003h,000h,038h,0c8h,003h,000h,0ffh,028h,040h,001h,020h,050h,006h,038h,0b0h	; 7df0  ...8....(@. P.8.
	defb 001h,068h,0c0h,006h,0ffh,078h,060h,003h,003h,058h,080h,003h,001h,0ffh,058h,028h	; 7e00  .h...x`..X....X(
	defb 001h,038h,080h,001h,038h,0d8h,006h,0ffh,058h,048h,003h,000h,068h,058h,003h,000h	; 7e10  .8..8...XH..hX..
	defb 078h,068h,003h,000h,068h,0a8h,004h,000h,030h,0b0h,003h,001h,0ffh,020h,040h,001h	; 7e20  xh..h...0.... @.
	defb 050h,078h,001h,0ffh,080h,030h,004h,000h,0a0h,0e0h,003h,001h,0ffh,088h,068h,006h	; 7e30  Px...0........h.
	defb 058h,0b8h,006h,0ffh,048h,070h,003h,000h,048h,080h,003h,000h,048h,090h,003h,000h	; 7e40  X...Hp..H...H...
	defb 048h,0a0h,003h,001h,048h,0b0h,003h,000h,048h,0c0h,003h,000h,048h,0d0h,003h,000h	; 7e50  H...H...H...H...
	defb 058h,0a0h,004h,000h,0ffh,020h,048h,001h,088h,0b0h,001h,050h,0d8h,001h,0ffh,058h	; 7e60  X.... H....P...X
	defb 050h,003h,001h,088h,068h,003h,004h,0ffh,060h,070h,006h,060h,0d0h,001h,0ffh,040h	; 7e70  P...h...`p.`...@
	defb 030h,003h,001h,040h,040h,003h,001h,040h,050h,003h,001h,050h,090h,004h,001h,0ffh	; 7e80  0..@@..@P..P....
	defb 060h,080h,006h,030h,058h,001h,030h,0b8h,001h,0ffh,030h,030h,003h,001h,030h,058h	; 7e90  `..0X.0...00..0X
	defb 003h,001h,030h,078h,003h,001h,030h,098h,003h,001h,030h,0b8h,003h,001h,088h,040h	; 7ea0  ..0x..0...0....@
	defb 004h,000h,080h,0a0h,003h,001h,060h,0b0h,003h,001h,080h,0c0h,003h,001h,060h,0d0h	; 7eb0  ......`.......`.
	defb 003h,001h,030h,0e0h,003h,001h,0ffh,0ffh,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7ec0  ..0.............
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7ed0  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7ee0  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7ef0  ................
	defb 003h,003h,003h,013h,003h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 7f00  ................
	defb 000h,000h,023h,000h,000h,000h,023h,000h,000h,000h,023h,000h,000h,000h,023h,023h	; 7f10  ..#...#...#...##
	defb 003h,003h,000h,027h,003h,003h,003h,003h,000h,003h,003h,003h,003h,003h,023h,023h	; 7f20  ...'..........##
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,023h,023h,023h,023h,023h,023h,023h,013h,017h	; 7f30  .......#######..
	defb 023h,001h,020h,023h,010h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,013h	; 7f40  #. #............
	defb 023h,007h,013h,013h,013h,023h,013h,023h,023h,013h,013h,013h,023h,023h,017h,023h	; 7f50  #....#.##...##.#
	defb 023h,003h,010h,020h,030h,036h,033h,023h,021h,013h,013h,013h,033h,031h,037h,036h	; 7f60  #.. 063#!...3176
	defb 023h,003h,033h,033h,033h,037h,036h,003h,033h,033h,033h,039h,038h,037h,036h,038h	; 7f70  #.33376.33398768
	defb 010h,030h,032h,034h,036h,038h,03ah,03ch,03eh,010h,031h,033h,035h,037h,039h,03bh	; 7f80  .02468:<>.13579;
	defb 03dh,03fh,010h,010h,010h,010h,010h,010h,010h,010h,010h,010h,010h,070h,071h,072h	; 7f90  =?...........pqr
	defb 073h,078h,079h,07ah,07bh,080h,081h,082h,083h,074h,075h,076h,077h,07ch,07dh,07eh	; 7fa0  sxyz{....tuvw|}~
	defb 07fh,084h,085h,086h,087h,010h,040h,041h,042h,043h,044h,045h,046h,047h,010h,013h	; 7fb0  ......@ABCDEFG..
	defb 01fh,020h,029h,022h,019h,017h,018h,024h,010h,001h,009h,008h,006h,010h,089h,010h	; 7fc0  . )"...$........
	defb 013h,011h,023h,019h,01fh,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7fd0  ..#.............
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7fe0  ................
	defb 0f0h,0b0h,0f0h,0f0h,0f0h,0b0h,0f0h,0b0h,0f0h,0f0h,0f0h,0f0h,0f0h,0d0h,0d0h,0d0h	; 7ff0  ................

; ======================================================================
; CODIGO 0x8000..0x840d  (1037 bytes)
; ======================================================================


arranque:		; 16 "nop" y el arranque: la RAM a cero, la interrupcion en H.TIMI (0x8E75), SCREEN 2 en negro, las letras (0x5000), la pantalla y los sprites
	nop			;8000
	nop			;8001
	nop			;8002
	nop			;8003
	nop			;8004
	nop			;8005
	nop			;8006
	nop			;8007
	nop			;8008
	nop			;8009
	nop			;800a
	nop			;800b
	nop			;800c
	nop			;800d
	nop			;800e
	nop			;800f
	ld hl,0e000h		;8010   ; 0xE000-0xF0FF...
	ld bc,01100h		;8013   ; ...0x1100 bytes...
init_borra:		; ...a cero
	ld (hl),000h		;8016   ; un byte a 0
	inc hl			;8018
	dec c			;8019   ; 256 bytes...
	jr nz,init_borra		;801a
	djnz init_borra		;801c   ; ...17 veces
	ld sp,0f200h		;801e   ; la pila
	ld hl,08e75h		;8021
	ld (0fda0h),hl		;8024   ; ...en H.TIMI...
	ld a,0c3h		;8027   ; ...con su "jp"
	ld (0fd9fh),a		;8029   ; ...0xFD9F
	call 0007eh		;802c   ; SETGRP: SCREEN 2
	xor a			;802f   ; fondo y borde negros...
	ld (0f3eah),a		;8030   ; BAKCLR = 0
	ld (0f3ebh),a		;8033   ; BDRCLR = 0
	dec a			;8036   ; ...letras blancas (0xFF)
	ld (0f3e9h),a		;8037   ; FORCLR = 0xFF
	call 00062h		;803a   ; CHGCLR
	ld de,00000h		;803d   ; las letras de la BIOS (0x1D3F) en los tres tercios
	ld b,003h		;8040   ; tres tercios
init_letras:
	call letras_pon		;8042   ; las letras
	djnz init_letras		;8045
	xor a			;8047   ; los colores de 0x80 casillas a 0...
	ld hl,00080h		;8048
	ld b,003h		;804b   ; ...en los tres tercios
L_804D:
	call colores_ocho		;804d
	djnz L_804D		;8050
	ld hl,02000h		;8052   ; los colores de las casillas 0x400-0x1BFF...
	ld bc,01800h		;8055
	ld a,0f0h		;8058   ; ...blanco sobre negro
	call 00056h		;805a
	call sprites_dibujos		;805d   ; los dibujos de los sprites
	ld a,0a2h		;8060   ; el registro 1 a 0xA2: la pantalla apagada, sprites de 16 x 16
	ld b,a			;8062
	ld c,001h		;8063
	call 00047h		;8065   ; WRTVDP
	ld a,005h		;8068   ; 0xE030 = 5
	ld (0e030h),a		;806a
	ld a,050h		;806d   ; 0xE035 = 0x50: el record, 0x005000 (en pantalla, 0050000)
	ld (0e035h),a		;806f
	ei			;8072   ; con interrupciones
titulo:		; El titulo: la presentacion de CASIO; las teclas SELECT (0xE023 = 1) y ESC (0xE039 = 2); el nombre en casillas (0x7F9D), CASIO, PUSH TRIG:1 OR SPACE y COPYRIGHT; el gatito cruza la pantalla de izquierda a derecha y, desde la X 0x50, cada 8 cuadros aparece una letra mas de su nombre (0x7FB5); con el boton, la partida; al llegar a la X 0xF0, la demostracion
	call sonido_reinicia		;8073   ; el sonido a cero
	call pantalla_limpia		;8076   ; la pantalla a cero
	call casillas_titulo		;8079   ; las casillas del titulo
	call 00044h		;807c   ; ENASCR
	call presentacion		;807f   ; la presentacion de CASIO
	ld a,007h		;8082   ; la fila 7...
	call 00141h		;8084   ; SNSMAT
	bit 6,a		;8087   ; SELECT (bit 6)?
	jr nz,L_8090		;8089
	ld a,001h		;808b   ; pulsada: 0xE023 = 1
	ld (0e023h),a		;808d
L_8090:
	ld a,007h		;8090   ; la fila 7 otra vez
	call 00141h		;8092
	bit 2,a		;8095   ; ESC (bit 2)?
	jr nz,L_809E		;8097
	ld a,002h		;8099   ; pulsada: 0xE039 = 2
	ld (0e039h),a		;809b
L_809E:
	ld hl,07f9dh		;809e   ; el nombre (0x7F9D): una fila de 12 en la fila 7...
	ld de,018e9h		;80a1
	ld bc,0000ch		;80a4
	call 0005ch		;80a7
	ex de,hl			;80aa
	ld de,01909h		;80ab   ; ...y otra en la 8
	ld bc,0000ch		;80ae
	call 0005ch		;80b1
	ld hl,090f5h		;80b4   ; CASIO en casillas (0x90F5) en la fila 16
	ld de,01a0dh		;80b7
	ld bc,00006h		;80ba
	call 0005ch		;80bd
	ld hl,090fbh		;80c0   ; PUSH TRIG:1 OR SPACE (0x90FB) en la fila 18
	ld de,01a46h		;80c3
	ld bc,00014h		;80c6
	call 0005ch		;80c9
	ld hl,07fbfh		;80cc   ; COPYRIGHT 1986 (c) CASIO (0x7FBF) en la fila 20
	ld de,01a85h		;80cf
	ld bc,00016h		;80d2
	call 0005ch		;80d5
	call 00044h		;80d8   ; ENASCR
	ld ix,0e300h		;80db   ; el gatito: Y 0x48, X 0...
	ld (ix+000h),048h		;80df
	ld (ix+001h),000h		;80e3
	ld (ix+002h),000h		;80e7
	ld (ix+003h),00fh		;80eb   ; ...color 15; el segundo sprite, 13
	ld (ix+013h),00dh		;80ef
	ld (ix+01ch),000h		;80f3
	call gatito_dibujo		;80f7   ; sus sprites
	xor a			;80fa   ; la cuenta a 0
	ld (0e018h),a		;80fb
titulo_bucle:
	ld a,(0e019h)		;80fe   ; un cuadro
	cp 001h		;8101   ; un cuadro?
	jr c,titulo_bucle		;8103
	xor a			;8105   ; la cuenta a 0
	ld (0e019h),a		;8106
	inc (ix+001h)		;8109   ; un punto a la derecha
	ld a,(ix+001h)		;810c   ; su paso, cada 4 cuadros
	and 004h		;810f   ; su paso...
	rlca			;8111
	ld (ix+01ch),a		;8112   ; ...0 u 8
	call gatito_dibujo		;8115   ; sus sprites
	ld a,(ix+001h)		;8118   ; la X 0x50?
	cp 050h		;811b   ; la X 0x50?
	jr c,titulo_cuadro		;811d
	cp 0f0h		;811f   ; la X 0xF0: la demostracion
	jr nc,demo_empieza		;8121
	inc (ix+005h)		;8123   ; cada 8 cuadros...
	ld a,(ix+005h)		;8126   ; la cuenta...
	cp 008h		;8129   ; ...8?
	jr c,titulo_cuadro		;812b
	ld (ix+005h),000h		;812d   ; a 0
	inc (ix+006h)		;8131   ; ...una letra mas...
	ld a,(ix+006h)		;8134   ; cuantas
	cp 00bh		;8137   ; ...hasta 10
	jr nc,titulo_cuadro		;8139   ; 10 o mas: nada
	ld c,(ix+006h)		;813b   ; el nombre del gatito (0x7FB5) en la fila 10, columna 10, tantas letras
	ld b,000h		;813e
	ld de,0194ah		;8140   ; la fila 10, columna 10
	ld hl,07fb5h		;8143
	call 0005ch		;8146   ; LDIRVM
titulo_cuadro:
	call sprites_ram		;8149   ; el sonido de fondo
	call sprites_vram_tabla		;814c   ; los sprites
	ld a,(0e026h)		;814f   ; el boton?
	and a			;8152
	jr z,titulo_bucle		;8153   ; no
	xor a			;8155
	ld (0e026h),a		;8156   ; gastado
	jr partida_empieza		;8159   ; la partida
demo_empieza:		; La demostracion: tres por turno (0xE028): la fase 5 con la lista de mandos de 0x7F00; la 1 y la 2 con la de 0x7FA0, que esta dentro de las casillas del nombre del titulo; sin trucos, sin vidas, la ronda 1
	ld a,(0e028h)		;815b   ; la siguiente...
	inc a			;815e
	ld (0e028h),a		;815f   ; apuntada
	cp 003h		;8162   ; ...de tres
	jr c,L_816A		;8164   ; menos de 3
	xor a			;8166   ; la 0
	ld (0e028h),a		;8167
L_816A:
	and a			;816a
	jr z,demo_0		;816b   ; la 0?
	cp 001h		;816d   ; la 1?
	jr z,demo_1		;816f   ; la 1?
	ld (0e00ah),a		;8171   ; la 2: la fase 2...
	ld a,004h		;8174   ; ...0xE03E = 4...
	ld hl,07fa0h		;8176   ; ...y la lista de 0x7FA0
	jr demo_va		;8179   ; a empezar
demo_1:
	ld a,001h		;817b   ; la fase 1 y la lista de 0x7FA0
	ld (0e00ah),a		;817d   ; la fase 1
	ld hl,07fa0h		;8180   ; la lista
	jr demo_va		;8183
demo_0:
	ld a,005h		;8185   ; la fase 5 y la lista de 0x7F00
	ld (0e00ah),a		;8187   ; la fase 5
	ld a,000h		;818a   ; la pantalla 0
	ld hl,07f00h		;818c
demo_va:
	ld (0e03eh),a		;818f   ; la posicion
	ld a,(0e00ah)		;8192   ; 0xE048 = la fase + 1
	inc a			;8195
	ld (0e048h),a		;8196   ; 0xE048
	xor a			;8199   ; sin trucos...
	ld (0e039h),a		;819a   ; sin ESC...
	ld (0e1b8h),a		;819d
	ld (0e023h),a		;81a0   ; ...ni SELECT
	ld (0e049h),a		;81a3   ; la vuelta 0
	ld (0e037h),hl		;81a6   ; la lista de mandos
	ld (0e00bh),a		;81a9   ; sin vidas de reserva
	inc a			;81ac   ; la ronda 1
	ld (0e009h),a		;81ad   ; la ronda 1
	jr fase_va		;81b0   ; a la fase
partida_empieza:		; Una partida: jugando (0xE000 = 1), la ronda 1 (0xE009), la fase 0, cuatro vidas de reserva, los puntos a cero
	xor a			;81b2   ; a cero: la demostracion...
	ld (0e027h),a		;81b3   ; sin demostracion
	ld (0e00ah),a		;81b6   ; ...la fase...
	ld (0e049h),a		;81b9   ; la vuelta 0
	ld (0e04fh),a		;81bc   ; sin la vida de los 50.000
	ld (0e1b8h),a		;81bf   ; 0xE1B8
	ld (0e03bh),a		;81c2   ; sin nada encima...
	ld (0e03ch),a		;81c5   ; ...ni que tirar
	ld (0e03eh),a		;81c8   ; la posicion 0
	ld (0e03fh),a		;81cb
	ld (0e03dh),a		;81ce   ; la fase 0
	inc a			;81d1   ; 1
	ld (0e000h),a		;81d2   ; 0xE000 = 1
	ld (0e009h),a		;81d5   ; la ronda 1
	ld (0e048h),a		;81d8   ; la fase 1 del pueblo
	ld a,004h		;81db   ; 4 vidas
	ld (0e00bh),a		;81dd   ; en 0xE00B
	ld hl,0e001h		;81e0   ; los puntos (0xE001-0xE006) a cero
	ld b,006h		;81e3   ; seis cifras
partida_borra:
	ld (hl),000h		;81e5   ; una cifra a 0
	inc hl			;81e7   ; la siguiente
	djnz partida_borra		;81e8   ; seis
	xor a			;81ea   ; y los tres bytes BCD
	ld (0e00eh),a		;81eb   ; los puntos a cero
	ld (0e00dh),a		;81ee   ; los puntos a cero
	ld (0e00ch),a		;81f1
fase:		; Una fase: la pantalla en blanco; su escena (0xE04A, de la tabla de 0x840D); la pantalla y los sprites; el gatito en la X 0x12; el mapa (0xE700); el color del cielo segun la ronda; la musica 2 y el bucle
	call tiempo_1100		;81f4   ; la pantalla en blanco
fase_va:
	ld a,(0e00ah)		;81f7   ; la fase...
	ld (0e03dh),a		;81fa
	ld hl,0840dh		;81fd   ; ...su escena (0x840D)...
	add a,l			;8200   ; + la fase
	jr nc,L_8204		;8201
	inc h			;8203
L_8204:
	ld l,a			;8204
	ld a,(hl)			;8205   ; la escena
	ld (0e04ah),a		;8206   ; ...en 0xE04A
	call pantalla_limpia		;8209   ; la pantalla a cero
	call marcador_pon		;820c   ; el marcador
	ld ix,0e300h		;820f   ; el gatito: fuera...
	ld (ix+000h),0ech		;8213   ; Y 0xEC
	ld (ix+001h),012h		;8217   ; ...X 0x12, color 15
	ld (ix+003h),00fh		;821b   ; color 15
	ld (ix+007h),000h		;821f   ; el dibujo 0
	ld (ix+013h),00dh		;8223   ; el segundo, color 13
	ld (ix+01ch),020h		;8227   ; el dibujo 0x20
	ld a,(0e03bh)		;822b   ; 0xE03B y 0xE03C, los de antes
	ld (ix+01dh),a		;822e   ; lo que lleva encima
	ld a,(0e03ch)		;8231   ; lo que tira
	ld (ix+008h),a		;8234
	call gatito_dibujo		;8237   ; sus sprites
	call vidas_pon		;823a   ; las vidas
	ld hl,0e700h		;823d   ; la pantalla de la RAM...
	ld bc,002c0h		;8240   ; ...0x2C0 casillas...
L_8243:
	ld (hl),080h		;8243   ; ...a 0x80
	inc hl			;8245   ; la siguiente
	dec bc			;8246
	ld a,c			;8247
	or b			;8248
	jr nz,L_8243		;8249   ; todas
	call pantalla_de_fase		;824b   ; la escena
	call escena_pon		;824e   ; la pantalla
	ld hl,0e700h		;8251   ; a la VRAM (fila 2)
	ld de,01840h		;8254   ; a la fila 2
	ld bc,002c0h		;8257
	call 0005ch		;825a   ; LDIRVM
	ld (ix+000h),088h		;825d   ; Y 0x88
	call gatito_sitio		;8261   ; sus sprites
	call sprites_ram		;8264   ; los sprites
	call sprites_vram_tabla		;8267   ; a la VRAM
	call puntos_pinta		;826a   ; los puntos
	ld b,004h		;826d   ; el color: + 4 en las escenas 0-3
	ld a,(0e04ah)		;826f   ; la escena
	cp 004h		;8272
	jr c,L_8278		;8274
	ld b,000h		;8276   ; si no, + 0
L_8278:
	ld a,(0e009h)		;8278   ; la ronda: 1, 0xD0...
	cp 001h		;827b
	jr nz,L_8283		;827d
	ld a,0d0h		;827f   ; 0xD0
	jr fase_color		;8281
L_8283:
	cp 002h		;8283
	jr nz,L_828B		;8285
	ld a,090h		;8287   ; ...2, 0x90...
	jr fase_color		;8289
L_828B:
	ld a,0b0h		;828b   ; ...3, 0xB0
fase_color:
	add a,b			;828d
	ld hl,02240h		;828e   ; los colores de 0x40 casillas en el segundo tercio...
	ld bc,00040h		;8291   ; 0x40 bytes
	call 00056h		;8294   ; FILVRM
	ld hl,02a40h		;8297   ; ...y en el tercero
	ld bc,00040h		;829a   ; 0x40 bytes
	call 00056h		;829d   ; FILVRM
	call 00044h		;82a0   ; ENASCR
	ld a,002h		;82a3   ; la musica 2
	call musica_pide		;82a5   ; pide la musica
	call espera_musica		;82a8   ; entera
	xor a			;82ab   ; las cuentas y los botones a 0
	ld (0e010h),a		;82ac   ; 0xE010
	ld (0e01fh),a		;82af   ; 0xE01F
	ld (0e022h),a		;82b2   ; el boton 1
	ld (0e020h),a		;82b5   ; el boton 2
	ld (0e026h),a		;82b8   ; el de empezar
	ld (0e180h),a		;82bb   ; la palanca
	inc a			;82be
	ld (0e027h),a		;82bf   ; 0xE027 = 1
fase_bucle:		; El bucle de la fase: el gatito tocado (0xE183), la fase acabada (0xE186), F1 (0xE1B3), STOP (0xE1B5); cada cuadro todo; en la pausa (0xE1B7), solo el gatito, que se lava; si cae por debajo de la Y 0xB0, muere (0xE183 = 2); desde 0xE03E = 8, en la X 0x78 y la Y 0x88-0x8F, la fase acabada; sin partida, con el boton, el titulo
	ld a,(0e183h)		;82c2   ; tocado?
	and a			;82c5
	jp nz,gatito_tocado		;82c6   ; si
	ld a,(0e186h)		;82c9   ; la fase acabada?
	cp 001h		;82cc
	jp z,fase_acabada		;82ce   ; si
	ld a,(0e1b3h)		;82d1   ; F1?
	and a			;82d4
	jp nz,tecla_f1_va		;82d5   ; si
	ld a,(0e1b5h)		;82d8   ; STOP?
	and a			;82db
	jp nz,pausa		;82dc   ; si
fase_cuadro:
	ld a,(0e011h)		;82df   ; un cuadro
	cp 001h		;82e2   ; un cuadro?
	jr c,fase_final_mira		;82e4
	xor a			;82e6   ; la cuenta a 0
	ld (0e011h),a		;82e7   ; la cuenta a 0
	call sprites_ram		;82ea   ; los sprites
	call sprites_vram_tabla		;82ed   ; a la VRAM
	call agua_anima		;82f0   ; el agua
	call escena3_anima		;82f3   ; la escena 3
	call sonido_fondo		;82f6   ; el ruido de fondo
	ld a,(0e1b7h)		;82f9   ; la pausa?
	and a			;82fc
	jr z,fase_todo		;82fd   ; no
	ld a,(0e013h)		;82ff   ; 0xD0 cuadros?
	cp 0d0h		;8302
	jr c,pausa_dibujo		;8304
	ld (ix+002h),008h		;8306   ; el dibujo 8
	jr fase_bucle_fin		;830a
pausa_dibujo:
	and 010h		;830c   ; cada 16 cuadros, el dibujo 0 o 4
	rrca			;830e
	rrca			;830f
	ld (ix+002h),a		;8310   ; su dibujo
	jr fase_bucle_fin		;8313
fase_todo:
	call pantalla_objetos		;8315   ; los enemigos de la pantalla
	call gatito_colores		;8318   ; los parpadeos
	call gatito_gravedad		;831b   ; la caida
	call gatito_mueve		;831e   ; el gatito se mueve
	call salto		;8321   ; el salto
	call tiro		;8324   ; el tiro
	call pantalla_cambia		;8327   ; el cambio de pantalla
	call tiempo		;832a   ; el tiempo
	call puntos_pinta		;832d   ; los puntos
	call enemigos		;8330   ; los enemigos
	call objetos_e400		;8333   ; los objetos
	ld a,(ix+000h)		;8336   ; la Y 0xB0-0xB7: se ha caido
	cp 0b0h		;8339   ; la Y...
	jr c,fase_final_mira		;833b
	cp 0b8h		;833d
	jr nc,fase_final_mira		;833f
	ld a,002h		;8341   ; muere
	ld (0e183h),a		;8343   ; 0xE183 = 2
	ld (ix+009h),001h		;8346   ; cayendo
	ld (ix+01bh),000h		;834a
	ld (ix+01dh),000h		;834e   ; sin nada encima
fase_final_mira:
	ld a,(0e03eh)		;8352   ; 0xE03E 8 o mas?
	cp 008h		;8355   ; la posicion 8 o mas?
	jr c,fase_bucle_fin		;8357
	ld a,(ix+001h)		;8359   ; la X 0x78?
	cp 078h		;835c
	jr nz,fase_bucle_fin		;835e
	ld a,(ix+000h)		;8360   ; la Y 0x88-0x8F?
	cp 088h		;8363
	jr c,fase_bucle_fin		;8365
	cp 090h		;8367
	jr nc,fase_bucle_fin		;8369
	ld a,001h		;836b   ; la fase acabada
	ld (0e186h),a		;836d   ; 0xE186 = 1
fase_bucle_fin:
	ld a,(0e000h)		;8370   ; jugando?
	and a			;8373
	jp nz,fase_bucle		;8374   ; si: otro cuadro
	ld a,(0e026h)		;8377   ; si no: el boton?
	and a			;837a
	jp z,fase_bucle		;837b   ; no: otro cuadro
	jp titulo		;837e   ; el titulo
tecla_f1_va:		; F1: el gatito tocado (0xE183 = 1) y su caida
	xor a			;8381
	ld (ix+01dh),a		;8382   ; sin nada encima
	inc a			;8385
	ld (0e183h),a		;8386   ; 0xE183 = 1
	jp gatito_cae		;8389   ; a caer
pausa:		; STOP: 0xE1B7 cambia; al pararse, los objetos (0xE300, 0x80 bytes) se guardan en 0xEE80 y el gatito sale en tres sprites con otros dibujos (0x8D1D); al seguir, todo vuelve
	xor a			;838c
	ld (0e1b5h),a		;838d   ; gastado
	ld a,(0e1b7h)		;8390   ; al reves
	cpl			;8393
	ld (0e1b7h),a		;8394   ; apuntado
	and a			;8397
	jr nz,pausa_para		;8398   ; se para
	call sprites_dibujos		;839a   ; los dibujos de siempre
	ld hl,0ee80h		;839d   ; los objetos, de vuelta
	ld de,0e300h		;83a0   ; a 0xE300
	ld bc,00080h		;83a3   ; 0x80 bytes
	ldir		;83a6
	jr fase_bucle_fin		;83a8   ; al bucle
pausa_para:
	ld hl,0e300h		;83aa   ; los objetos, guardados
	ld de,0ee80h		;83ad   ; a 0xEE80
	ld bc,00080h		;83b0   ; 0x80 bytes
	ldir		;83b3
	call sprites_dibujos_pausa		;83b5   ; los otros dibujos
	ld (ix+002h),000h		;83b8   ; tres sprites: 0, 0x0C y 0x10
	ld (ix+012h),00ch		;83bc   ; el segundo sprite, 0x0C
	ld (ix+022h),010h		;83c0   ; el tercero, 0x10
	ld (ix+013h),00dh		;83c4   ; colores 13
	ld (ix+023h),00dh		;83c8
	ld (ix+030h),0ech		;83cc   ; el cuarto, fuera
	ld a,(ix+000h)		;83d0   ; sus Y
	sub 00eh		;83d3   ; 14 mas arriba
	ld (ix+000h),a		;83d5
	add a,010h		;83d8   ; los otros dos, 16 mas abajo
	ld (ix+010h),a		;83da
	ld (ix+020h),a		;83dd
	ld a,(ix+001h)		;83e0   ; sus X (8 como poco)
	cp 008h		;83e3   ; la X: 8 como poco
	jr nc,pausa_x		;83e5
	ld a,008h		;83e7
	ld (ix+001h),a		;83e9
pausa_x:
	sub 008h		;83ec   ; 8 a la izquierda...
	ld (ix+011h),a		;83ee   ; ...el segundo
	add a,010h		;83f1   ; el tercero, 8 a la derecha
	ld (ix+021h),a		;83f3
	xor a			;83f6
	ld (0e013h),a		;83f7   ; la cuenta a 0
	jp fase_bucle_fin		;83fa   ; al bucle
sonido_fondo:		; El ruido de fondo: el efecto 4 con +0x1D, si no el 5
	ld a,(ix+01dh)		;83fd   ; lleva algo encima?
	and a			;8400
	jr z,sonido_fondo_5		;8401
	ld a,004h		;8403   ; el efecto 4
	jr sonido_fondo_pide		;8405
sonido_fondo_5:
	ld a,005h		;8407   ; el efecto 5
sonido_fondo_pide:
	call efecto_pide		;8409   ; pedido
	ret			;840c

; ----------------------------------------------------------------------
; DATOS fase_escenas: La escena de cada fase (18: tres rondas de seis): 0, 1,
;   2, 3, 5, 4
;   0x840d..0x841f  (18 bytes)
DATA_fase_escenas:
	defb 000h,001h,002h,003h,005h,004h,000h,001h,002h,003h,005h,004h,000h,001h,002h,003h	; 840d  ................
	defb 005h,004h	; 841d

; ======================================================================
; CODIGO 0x841f..0x8613  (500 bytes)
; ======================================================================


agua_anima:		; En la escena 2: cada 3 cuadros (0xE1BC) los dibujos de dos casillas cambian (0xE1BD, de cuatro): las de 0x6798 y 0x6780 en los tres tercios; el agua que cae
	ld a,(0e04ah)		;841f   ; la escena 2?
	cp 002h		;8422   ; 2?
	ret nz			;8424
	ld a,(0e1bch)		;8425   ; 3 cuadros
	inc a			;8428
	ld (0e1bch),a		;8429   ; apuntada
	cp 003h		;842c   ; 3?
	ret c			;842e
	xor a			;842f   ; a cero
	ld (0e1bch),a		;8430
	ld a,(0e1bdh)		;8433   ; el siguiente de cuatro...
	inc a			;8436
	and 003h		;8437   ; de cuatro
	ld (0e1bdh),a		;8439   ; apuntado
	rlca			;843c   ; ...x 8
	rlca			;843d
	rlca			;843e
	ld hl,06798h		;843f   ; el dibujo de 0x6798 + eso...
	add a,l			;8442   ; + el paso
	ld l,a			;8443
	push hl			;8444
	ld de,00798h		;8445   ; ...a la casilla 0xF3 del primer tercio
	ld bc,00008h		;8448   ; 8 bytes
	call 0005ch		;844b   ; LDIRVM
	pop hl			;844e
	push hl			;844f   ; otra vez
	ld de,00f98h		;8450   ; del segundo
	ld bc,00008h		;8453   ; 8 bytes
	call 0005ch		;8456   ; LDIRVM
	pop hl			;8459
	ld de,01798h		;845a   ; del tercero
	ld bc,00008h		;845d   ; 8 bytes
	call 0005ch		;8460   ; LDIRVM
	ld a,(0e1bdh)		;8463   ; la otra: de dos
	and 001h		;8466   ; de dos
	rlca			;8468
	rlca			;8469
	rlca			;846a
	ld hl,06780h		;846b   ; 0x6780 + eso...
	add a,l			;846e   ; + el paso
	ld l,a			;846f
	push hl			;8470
	ld de,00780h		;8471   ; ...a la casilla 0xF0 de los tres tercios
	ld bc,00008h		;8474   ; 8 bytes
	call 0005ch		;8477   ; LDIRVM
	pop hl			;847a
	push hl			;847b
	ld de,00f80h		;847c   ; al segundo tercio
	ld bc,00008h		;847f   ; 8 bytes
	call 0005ch		;8482   ; LDIRVM
	pop hl			;8485
	ld de,01780h		;8486   ; al tercero
	ld bc,00008h		;8489   ; 8 bytes
	call 0005ch		;848c   ; LDIRVM
	ret			;848f
escena3_anima:		; En la escena 3: cada 8 cuadros el dibujo de la casilla 0x88 cambia (0xE1BE, de cuatro; 0x6440), en los tres tercios
	ld a,(0e04ah)		;8490   ; la escena 3?
	cp 003h		;8493   ; 3?
	ret nz			;8495
	ld a,(0e1bch)		;8496   ; 8 cuadros
	inc a			;8499
	ld (0e1bch),a		;849a   ; apuntada
	cp 008h		;849d   ; 8?
	ret c			;849f
	xor a			;84a0   ; a cero
	ld (0e1bch),a		;84a1
	ld a,(0e1beh)		;84a4   ; el siguiente de cuatro
	inc a			;84a7
	and 003h		;84a8   ; de cuatro
	ld (0e1beh),a		;84aa   ; apuntado
	rlca			;84ad
	rlca			;84ae
	rlca			;84af
	ld hl,06440h		;84b0   ; 0x6440 + eso
	add a,l			;84b3   ; + el paso
	ld l,a			;84b4
	push hl			;84b5
	ld de,00440h		;84b6   ; al primer tercio
	ld bc,00008h		;84b9   ; 8 bytes
	call 0005ch		;84bc   ; LDIRVM
	pop hl			;84bf
	push hl			;84c0
	ld de,00c40h		;84c1   ; al segundo
	ld bc,00008h		;84c4   ; 8 bytes
	call 0005ch		;84c7   ; LDIRVM
	pop hl			;84ca
	ld de,01440h		;84cb   ; al tercero
	ld bc,00008h		;84ce   ; 8 bytes
	call 0005ch		;84d1   ; LDIRVM
	ret			;84d4
gatito_tocado:		; El gatito tocado (0xE183): con SELECT en el titulo (0xE023) no pasa nada, salvo con 0xE183 = 2; si no, el sonido a cero, el gatito sube 0x28 cuadros y baja otros 0x28 cambiando de dibujo cada 4; despues de 0x80 cuadros, una vida menos y la fase otra vez; sin vidas, con ESC en el titulo (0xE039), CONTINUE PUSH TRIG1 / END PUSH TRIG2; si no, GAME OVER
	ld a,(0e183h)		;84d5   ; 2?
	cp 002h		;84d8
	jr z,gatito_cae		;84da   ; 2: muere aunque haya SELECT
	ld a,(0e023h)		;84dc   ; SELECT en el titulo?
	and a			;84df
	jr z,gatito_cae		;84e0   ; no: muere
	xor a			;84e2   ; nada
	ld (0e183h),a		;84e3   ; 0
	jp fase_cuadro		;84e6   ; al bucle
gatito_cae:		; Tocado: si lleva algo (+0x1D), lo pierde (+0x1B, el efecto 1) y sigue; si no, el sonido a cero, el efecto 2, sube 0x20 cuadros y baja otros tantos (dos puntos por cuadro), espera 0x80 cuadros y una vida menos; sin vidas, con ESC en el titulo (0xE039: 2, siempre; 1, una vez) CONTINUE PUSH TRIG1 / END PUSH TRIG2; si no, GAME OVER; la fase vuelve a empezar desde su punto de control (0xE03E)
	xor a			;84e9   ; 0xE03C y 0xE03B a 0
	ld (0e03ch),a		;84ea   ; nada que tirar
	ld (0e03bh),a		;84ed   ; nada encima
	ld a,(0e183h)		;84f0   ; 2: se ha caido...
	cp 002h		;84f3   ; caido?
	jr nz,gatito_cae_lleva		;84f5
	ld (ix+003h),000h		;84f7   ; ...sin color
	ld (ix+013h),000h		;84fb   ; el segundo sprite
	ld (ix+023h),000h		;84ff   ; el tercero
gatito_cae_lleva:
	ld a,(ix+01bh)		;8503   ; ya perdio algo?
	and a			;8506
	jr z,gatito_cae_mira		;8507   ; no
	jr gatito_cae_sigue		;8509   ; si: sigue
gatito_cae_mira:
	ld a,(ix+01dh)		;850b   ; lleva algo?
	and a			;850e
	jr z,gatito_muere		;850f   ; no: muere
	ld (ix+01dh),000h		;8511   ; lo pierde
	inc (ix+01bh)		;8515   ; uno mas
	ld a,001h		;8518   ; el efecto 1
	call efecto_pide		;851a   ; pedido
gatito_cae_sigue:
	call gatito_dibujo		;851d   ; sus sprites
	xor a			;8520   ; 0xE183 = 0
	ld (0e183h),a		;8521   ; 0
	jp fase_cuadro		;8524   ; al bucle
gatito_muere:
	call sonido_reinicia		;8527   ; el sonido a cero
	xor a			;852a
	ld (0e027h),a		;852b   ; sin demostracion
	ld (0e011h),a		;852e   ; la cuenta a 0
gatito_muere_espera:
	ld a,(0e011h)		;8531   ; 2 cuadros
	cp 002h		;8534   ; 2 cuadros?
	jr c,gatito_muere_espera		;8536
	ld a,002h		;8538   ; el efecto 2
	call efecto_pide		;853a   ; pedido
	xor a			;853d
	ld (0e012h),a		;853e   ; la cuenta a 0
	ld (ix+002h),010h		;8541   ; el dibujo 0x10
	ld (ix+01ch),010h		;8545   ; su dibujo
gatito_muere_cuadro:
	ld a,(0e011h)		;8549   ; un cuadro
	cp 001h		;854c   ; un cuadro?
	jr c,gatito_muere_cuadro		;854e
	xor a			;8550   ; la cuenta a 0
	ld (0e011h),a		;8551
	call gatito_dibujo		;8554   ; sus sprites
	call sprites_ram		;8557   ; los sprites
	call sprites_vram_tabla		;855a   ; a la VRAM
	inc (ix+01eh)		;855d   ; la cuenta
	ld a,(ix+01eh)		;8560
	cp 020h		;8563   ; 0x20 cuadros sube
	jr nc,gatito_muere_baja		;8565
	dec (ix+000h)		;8567   ; dos puntos
	dec (ix+000h)		;856a   ; dos puntos arriba
	jr gatito_muere_cuadro		;856d
gatito_muere_baja:
	cp 040h		;856f   ; otros 0x20 baja
	jr nc,gatito_muere_fin		;8571
	inc (ix+000h)		;8573   ; dos puntos abajo
	inc (ix+000h)		;8576
	jr gatito_muere_cuadro		;8579
gatito_muere_fin:
	ld a,(0e012h)		;857b   ; 0x80 cuadros
	cp 080h		;857e   ; 0x80?
	jr c,gatito_muere_fin		;8580
	ld a,(0e00bh)		;8582   ; vidas?
	and a			;8585
	jp nz,vida_menos		;8586   ; si: una menos
	ld a,(0e039h)		;8589   ; ESC en el titulo?
	and a			;858c
	jp z,game_over		;858d   ; no: GAME OVER
	cp 001h		;8590   ; 1: solo esta vez
	jr nz,continuar		;8592   ; 2: siempre
	xor a			;8594   ; se gasta
	ld (0e039h),a		;8595
continuar:
	call objetos_fuera		;8598   ; todos fuera
	call pantalla_cierra		;859b   ; la pantalla se borra
	ld de,018c7h		;859e   ; CONTINUE PUSH TRIG1 (0x8613) en la fila 6
	ld hl,08613h		;85a1   ; CONTINUE PUSH TRIG1
	ld bc,00013h		;85a4
	call 0005ch		;85a7   ; LDIRVM
	ld de,01907h		;85aa   ; END      PUSH TRIG2 (0x8626) en la fila 8
	ld hl,08626h		;85ad   ; END      PUSH TRIG2
	ld bc,00013h		;85b0
	call 0005ch		;85b3   ; LDIRVM
	xor a			;85b6   ; las cuentas y los botones a 0
	ld (0e010h),a		;85b7   ; las cuentas...
	ld (0e1a0h),a		;85ba   ; 0xE1A0
	ld (0e020h),a		;85bd   ; ...y los botones a 0
	ld (0e022h),a		;85c0   ; el boton 1
continuar_espera:
	ld a,(0e022h)		;85c3   ; el boton 1?
	and a			;85c6
	jr z,continuar_boton2		;85c7   ; no: el 2
	jr continuar_si		;85c9   ; si: continuar
continuar_boton2:
	ld a,(0e020h)		;85cb   ; el boton 2?
	and a			;85ce
	jr z,continuar_espera		;85cf   ; no: espera
	jr game_over		;85d1   ; GAME OVER
continuar_si:
	ld a,005h		;85d3   ; 5 (4 despues de la resta)
	ld (0e00bh),a		;85d5   ; apuntadas
vida_menos:
	ld a,(0e00bh)		;85d8   ; una menos
	sub 001h		;85db
	daa			;85dd   ; en BCD
	ld (0e00bh),a		;85de   ; apuntadas
	ld a,(0e03eh)		;85e1   ; el punto de control...
	and 0fch		;85e4   ; ...de cuatro en cuatro...
	cp 008h		;85e6   ; ...el 8 vuelve al 4
	jr nz,vida_menos_control		;85e8   ; no
	ld a,004h		;85ea   ; 4
vida_menos_control:
	ld (0e03eh),a		;85ec   ; apuntado
vida_menos_fase:
	jp fase_va		;85ef   ; la fase otra vez
game_over:		; GAME OVER (0x911E) en la fila 10, la musica 1, la espera y el titulo
	call ram_borra		;85f2   ; la pantalla limpia
	ld de,0194ch		;85f5   ; la fila 10, columna 12
	ld hl,0911eh		;85f8   ; GAME OVER
	ld bc,00009h		;85fb
	call 0005ch		;85fe   ; LDIRVM
	ld a,001h		;8601   ; la musica 1
	call musica_pide		;8603   ; pide la musica
	call espera_musica		;8606   ; entera
	xor a			;8609   ; sin partida
	ld (0e000h),a		;860a   ; sin partida
	ld (0e026h),a		;860d   ; el boton a 0
	jp titulo		;8610   ; el titulo

; ----------------------------------------------------------------------
; DATOS continuar_textos: CONTINUE PUSH TRIG1 (0x8613) y END      PUSH TRIG2
;   (0x8626)
;   0x8613..0x8639  (38 bytes)
DATA_continuar_textos:
	defb 013h,01fh,01eh,024h,019h,01eh,025h,015h,010h,020h,025h,023h,018h,010h,024h,022h	; 8613  ...$..%.. %#..$"
	defb 019h,017h,001h,015h,01eh,014h,010h,010h,010h,010h,010h,010h,020h,025h,023h,018h	; 8623  ............ %#.
	defb 010h,024h,022h,019h,017h,002h	; 8633

; ======================================================================
; CODIGO 0x8639..0x8879  (576 bytes)
; ======================================================================


fase_acabada:		; La fase acabada (0xE186): guarda lo que lleva (0xE03C, 0xE03B), la musica 3; tras 0x50 cuadros, en la columna 17 sube una torre de dibujos (la tabla de 0x88B3, uno cada 12 cuadros, once) con una casilla de la fase en lo alto (0x8904); en la ultima fase de un pueblo (escena 4), CLEAR ... TOWN con su nombre; el tiempo que queda se cobra (un punto por unidad, cuatro por cuadro, el efecto A 1); la fase siguiente: cada seis, un pueblo mas (GO TO y su nombre); despues de la 18, GREAT! e I LOVE YOU, la musica 3 dos veces y otra vez la primera
	ld (ix+003h),00fh		;8639   ; color 15
	ld a,(ix+008h)		;863d   ; lo que lleva, guardado
	ld (0e03ch),a		;8640   ; lo que tira
	ld a,(ix+01dh)		;8643   ; lo que lleva...
	ld (0e03bh),a		;8646   ; ...guardado
	ld (ix+01dh),000h		;8649   ; sin nada encima
	ld (ix+000h),0ech		;864d   ; el gatito fuera
	ld (ix+01ch),000h		;8651   ; el dibujo 0
	ld (ix+070h),0ech		;8655   ; el tiro fuera
	ld (ix+071h),000h		;8659
	ld a,003h		;865d   ; la musica 3
	call musica_pide		;865f   ; pide la musica
	call gatito_dibujo		;8662   ; sus sprites
	call sprites_ram		;8665   ; los sprites
	call sprites_vram_tabla		;8668   ; a la VRAM
	xor a			;866b   ; la cuenta a 0
	ld (0e013h),a		;866c   ; la cuenta a 0
fase_acabada_espera:
	ld a,(0e013h)		;866f   ; 0x50 cuadros
	cp 050h		;8672   ; 0x50?
	jr c,fase_acabada_espera		;8674
	xor a			;8676   ; el paso a 0
	ld (0e1abh),a		;8677   ; el paso 0
	ld a,(0e048h)		;867a   ; la fase 6 del pueblo?
	cp 006h		;867d   ; la 6?
	jr nz,fase_acabada_abajo		;867f
	ld hl,01911h		;8681   ; la fila 8, columna 17, desde el 4
	ld (0e1a8h),hl		;8684   ; su sitio
	ld a,004h		;8687   ; desde el paso 4
	ld (0e1aah),a		;8689
	ld (ix+000h),038h		;868c   ; Y 0x38
	jr fase_acabada_va		;8690
fase_acabada_abajo:
	ld hl,01991h		;8692   ; la fila 12, columna 17, desde el 0
	ld (0e1a8h),hl		;8695   ; su sitio
	xor a			;8698   ; desde el 0
	ld (0e1aah),a		;8699
	ld (ix+000h),058h		;869c   ; Y 0x58
fase_acabada_va:
	call gatito_dibujo		;86a0   ; sus sprites
	ld a,(0e00ah)		;86a3   ; la fase 17 (la ultima)?
	cp 011h		;86a6
	jr nz,fase_acabada_pinta		;86a8
	ld a,(ix+000h)		;86aa   ; dos sprites mas a su lado: 0x80 color 11 y 0x84 color 9
	ld (ix+040h),a		;86ad   ; a su lado...
	add a,008h		;86b0
	ld (ix+050h),a		;86b2
	ld a,(ix+001h)		;86b5   ; ...10 a la derecha
	add a,00ah		;86b8
	ld (ix+041h),a		;86ba
	ld (ix+051h),a		;86bd
	ld (ix+042h),080h		;86c0   ; 0x80, color 11
	ld (ix+043h),00bh		;86c4
	ld (ix+052h),084h		;86c8   ; 0x84, color 9
	ld (ix+053h),009h		;86cc
fase_acabada_pinta:
	call sprites_ram		;86d0   ; los sprites
	call sprites_vram_tabla		;86d3   ; a la VRAM
fase_acabada_paso:
	ld a,(0e013h)		;86d6   ; 12 cuadros
	cp 00ch		;86d9   ; 12?
	jr c,fase_acabada_paso		;86db
	xor a			;86dd   ; la cuenta a 0
	ld (0e013h),a		;86de
	ld hl,088b3h		;86e1   ; el dibujo del paso (0x88B3)
	ld a,(0e1abh)		;86e4   ; el paso x 2
	add a,a			;86e7
	add a,l			;86e8
	jr nc,L_86EC		;86e9
	inc h			;86eb
L_86EC:
	ld l,a			;86ec
	ld e,(hl)			;86ed   ; su puntero
	inc hl			;86ee
	ld d,(hl)			;86ef
	ld hl,(0e1a8h)		;86f0   ; el sitio
	call dibujo_vram		;86f3   ; pintado
	ld a,(0e1abh)		;86f6   ; el primero: sin casilla
	and a			;86f9
	jr z,fase_acabada_sube		;86fa   ; el primero, sin
	ld hl,(0e1a8h)		;86fc   ; la casilla de la fase (0x8904)...
	inc hl			;86ff   ; una fila abajo y a la derecha
	ld de,00020h		;8700
	add hl,de			;8703
	push hl			;8704
	ld hl,08904h		;8705   ; la casilla de la fase
	ld a,(0e00ah)		;8708
	add a,l			;870b
	jr nc,fase_acabada_casilla		;870c
	inc h			;870e
fase_acabada_casilla:
	ld l,a			;870f
	ld a,(hl)			;8710   ; la casilla
	pop hl			;8711
	call 0004dh		;8712   ; ...encima
fase_acabada_sube:
	ld a,(0e1abh)		;8715   ; el paso siguiente
	inc a			;8718
	ld (0e1abh),a		;8719   ; apuntado
	ld de,0ffe0h		;871c   ; una fila arriba
	ld hl,(0e1a8h)		;871f   ; una fila arriba
	add hl,de			;8722
	ld (0e1a8h),hl		;8723
	ld a,(0e1aah)		;8726   ; la cuenta
	inc a			;8729
	ld (0e1aah),a		;872a   ; apuntada
	cp 00bh		;872d   ; once
	jr c,fase_acabada_paso		;872f
	xor a			;8731   ; las cuentas a 0
	ld (0e011h),a		;8732   ; las cuentas a 0
	ld (0e1a0h),a		;8735
	ld a,(0e04ah)		;8738   ; la escena 4?
	cp 004h		;873b   ; la escena 4?
	jr nz,tiempo_cobra		;873d
	ld de,01881h		;873f   ; CLEAR       TOWN (0x8879) en la fila 2
	ld hl,08879h		;8742   ; CLEAR       TOWN
	ld bc,00010h		;8745
	call 0005ch		;8748   ; LDIRVM
	ld a,(0e009h)		;874b   ; el pueblo: 1, PEACH...
	cp 001h		;874e   ; el 1?
	jr nz,fase_acabada_pueblo2		;8750
	ld hl,0888eh		;8752   ; PEACH
	jr fase_acabada_nombre		;8755
fase_acabada_pueblo2:
	cp 002h		;8757   ; ...2, APPLE...
	jr nz,fase_acabada_pueblo3		;8759
	ld hl,08893h		;875b   ; APPLE
	jr fase_acabada_nombre		;875e
fase_acabada_pueblo3:
	ld hl,08898h		;8760   ; ...3, LEMON
fase_acabada_nombre:
	ld de,01887h		;8763   ; en el hueco (columna 7)
	ld bc,00005h		;8766   ; 5 letras
	call 0005ch		;8769   ; LDIRVM
tiempo_cobra:
	ld a,(0e011h)		;876c   ; un cuadro
	cp 001h		;876f   ; un cuadro?
	jr c,tiempo_cobra		;8771
	xor a			;8773   ; la cuenta a 0
	ld (0e011h),a		;8774
	call tiempo_cobra_uno		;8777   ; cuatro unidades
	call tiempo_cobra_uno		;877a   ; dos
	call tiempo_cobra_uno		;877d   ; tres
	call tiempo_cobra_uno		;8780   ; cuatro
	ld a,(0e1a0h)		;8783   ; acabado?
	and a			;8786
	jp nz,fase_siguiente		;8787   ; si: la fase siguiente
	ld a,001h		;878a   ; el efecto A 1
	call efecto_a_pide		;878c   ; pedido
	jr tiempo_cobra		;878f
tiempo_cobra_uno:		; Una unidad del tiempo (0xE040-0xE042, tres cifras) menos y un punto; con el tiempo a 0, 0xE1A0 = 1
	ld a,(0e040h)		;8791   ; las unidades?
	cp 000h		;8794   ; 0?
	jr nz,tiempo_cobra_unidad		;8796
	ld a,(0e041h)		;8798   ; las decenas?
	cp 000h		;879b   ; 0?
	jr nz,tiempo_cobra_decena		;879d
	ld a,(0e042h)		;879f   ; las centenas?
	cp 000h		;87a2   ; 0?
	jr nz,tiempo_cobra_centena		;87a4
	inc a			;87a6   ; todo a 0: acabado
	ld (0e1a0h),a		;87a7   ; acabado
	ret			;87aa
tiempo_cobra_unidad:
	dec a			;87ab   ; una menos
	ld (0e040h),a		;87ac
	jr tiempo_cobra_punto		;87af
tiempo_cobra_decena:
	dec a			;87b1   ; una menos
	ld (0e041h),a		;87b2
	ld a,009h		;87b5   ; las unidades a 9
	ld (0e040h),a		;87b7   ; las unidades a 9
	jr tiempo_cobra_punto		;87ba
tiempo_cobra_centena:
	dec a			;87bc   ; una menos
	ld (0e042h),a		;87bd
	ld a,009h		;87c0
	ld (0e041h),a		;87c2   ; las decenas...
	ld (0e040h),a		;87c5   ; ...y las unidades a 9
tiempo_cobra_punto:
	ld a,001h		;87c8   ; un punto (en pantalla, 10)
	call puntos_suma		;87ca   ; a los puntos
	call tiempo_pinta		;87cd   ; el tiempo
	call puntos_pinta		;87d0   ; los puntos
	ret			;87d3
fase_siguiente:
	xor a			;87d4   ; el punto de control a 0
	ld (0e03eh),a		;87d5   ; apuntado
	ld (0e011h),a		;87d8   ; la cuenta a 0
fase_siguiente_espera:
	ld a,(0e011h)		;87db   ; 0x30 cuadros
	cp 030h		;87de   ; 0x30?
	jr c,fase_siguiente_espera		;87e0
	ld hl,0e00ah		;87e2   ; la fase siguiente
	inc (hl)			;87e5   ; apuntada
	ld hl,0e048h		;87e6   ; la del pueblo...
	inc (hl)			;87e9   ; apuntada
	ld a,(hl)			;87ea
	cp 007h		;87eb   ; ...7?
	jp c,fase_siguiente_sin_pueblo		;87ed
	ld (hl),001h		;87f0   ; la 1 del pueblo siguiente
	ld hl,0e049h		;87f2
	inc (hl)			;87f5   ; la vuelta + 1
	ld hl,0e009h		;87f6   ; el pueblo siguiente
	inc (hl)			;87f9   ; apuntado
	ld a,(0e00ah)		;87fa   ; la 18: el final
	cp 012h		;87fd   ; 18?
	jr nc,final		;87ff
	ld de,01881h		;8801   ; GO TO (0x8889) en la fila 2
	ld hl,08889h		;8804   ; GO TO
	ld bc,00005h		;8807
	call 0005ch		;880a   ; LDIRVM
	ld a,(0e009h)		;880d   ; el pueblo: 2, APPLE...
	cp 002h		;8810   ; el 2?
	jr nz,fase_siguiente_pueblo3		;8812
	ld hl,08893h		;8814
	jr fase_siguiente_nombre		;8817
fase_siguiente_pueblo3:
	cp 003h		;8819   ; ...3, LEMON...
	jr nz,fase_siguiente_pueblo1		;881b
	ld hl,08898h		;881d   ; LEMON
	jr fase_siguiente_nombre		;8820
fase_siguiente_pueblo1:
	ld hl,0888eh		;8822   ; ...1, PEACH
fase_siguiente_nombre:
	ld de,01887h		;8825   ; en la columna 7
	ld bc,00005h		;8828   ; 5 letras
	call 0005ch		;882b   ; LDIRVM
	xor a			;882e
	ld (0e011h),a		;882f   ; la cuenta a 0
fase_siguiente_pausa:
	ld a,(0e011h)		;8832   ; 0x70 cuadros
	cp 070h		;8835   ; 0x70?
	jr c,fase_siguiente_pausa		;8837
	jp vida_menos_fase		;8839   ; la fase
fase_siguiente_sin_pueblo:
	ld a,040h		;883c   ; 0x30 cuadros solo
	ld (0e011h),a		;883e   ; la cuenta desde 0x40
	jr fase_siguiente_pausa		;8841
final:		; El final: GREAT! (0x889D) en la fila 3 e I LOVE YOU con un corazon (0x88A3) en la fila 4, la musica 3 dos veces, y otra vez la fase 0 del pueblo 1
	ld hl,0889dh		;8843   ; GREAT!
	ld de,01864h		;8846   ; la fila 3, columna 4
	ld bc,00006h		;8849
	call 0005ch		;884c   ; LDIRVM
	ld hl,088a3h		;884f   ; I LOVE YOU
	ld de,01881h		;8852   ; la fila 4, columna 1
	ld bc,00010h		;8855
	call 0005ch		;8858   ; LDIRVM
	ld a,003h		;885b   ; la musica 3...
	call musica_pide		;885d   ; pide la musica
	call espera_musica		;8860   ; entera
	ld a,003h		;8863   ; ...y otra vez
	call musica_pide		;8865   ; pide la musica
	call espera_musica		;8868   ; entera
	xor a			;886b   ; la fase 0...
	ld (0e00ah),a		;886c   ; la fase 0
	inc a			;886f   ; ...del pueblo 1
	ld (0e009h),a		;8870   ; el pueblo 1
	ld (0e048h),a		;8873   ; la fase 1 del pueblo
	jp vida_menos_fase		;8876   ; a jugar

; ----------------------------------------------------------------------
; DATOS fase_acabada_datos: CLEAR       TOWN (0x8879), GO TO (0x8889), los
;   pueblos PEACH (0x888E), APPLE (0x8893) y LEMON (0x8898), GREAT! (0x889D),
;   I LOVE YOU y un corazon (0x88A3); los once dibujos de la torre (0x88B3,
;   punteros a 0x88CD-0x88F3) y la casilla de cada fase (0x8904, 18)
;   0x8879..0x8916  (157 bytes)
DATA_fase_acabada_datos:
	defb 013h,01ch,015h,011h,022h,010h,010h,010h,010h,010h,010h,010h,024h,01fh,027h,01eh	; 8879  ....".......$.'.
	defb 017h,01fh,010h,024h,01fh,020h,015h,011h,013h,018h,011h,020h,020h,01ch,015h,01ch	; 8889  ...$. .....  ...
	defb 015h,01dh,01fh,01eh,017h,022h,015h,011h,024h,08bh,019h,010h,01ch,01fh,026h,015h	; 8899  ....."..$.....&.
	defb 010h,029h,01fh,025h,010h,088h,089h,010h,08ah,010h,0cdh,088h,0d2h,088h,0dah,088h	; 88a9  .).%............
	defb 0e5h,088h,0f3h,088h,0f3h,088h,0f3h,088h,0f3h,088h,0f3h,088h,0f3h,088h,0f3h,088h	; 88b9  ................
	defb 0f3h,088h,0f3h,088h,003h,001h,048h,049h,04ah,003h,002h,048h,049h,04ah,04ch,081h	; 88c9  ......HIJ..HIJL.
	defb 04bh,003h,003h,048h,049h,04ah,04ch,081h,04bh,04dh,04eh,04fh,003h,004h,048h,049h	; 88d9  K..HIJL.KMNO..HI
	defb 04ah,04ch,081h,04bh,04dh,04eh,04fh,082h,044h,082h,003h,005h,048h,049h,04ah,04ch	; 88e9  JL.KMNO.D...HIJL
	defb 081h,04bh,04dh,04eh,04fh,082h,044h,082h,082h,082h,082h,007h,005h,003h,002h,004h	; 88f9  .KMNO.D.........
	defb 013h,006h,001h,008h,000h,009h,011h,003h,002h,007h,004h,006h,024h	; 8909  ............$

; ----------------------------------------------------------------------
; DATOS codigo_suelto_8916: Codigo que nadie llama: si IY esta en la pantalla
;   (Y 0x0C-0xA7, X por debajo de 0xF6)
;   0x8916..0x8929  (19 bytes)
DATA_codigo_suelto_8916:
	defb 0fdh,07eh,000h,0feh,00ch,038h,00ch,0feh,0a8h,030h,008h,0fdh,07eh,001h,0feh,0f6h	; 8916  .~...8...0..~...
	defb 030h,001h,0c9h	; 8926

; ======================================================================
; CODIGO 0x8929..0x8c7e  (853 bytes)
; ======================================================================


otro_borra:		; Los 16 bytes del objeto IY a cero, y fuera (Y 0xEC)
	push iy		;8929   ; su principio
	pop hl			;892b
	ld b,010h		;892c   ; 16 bytes
otro_borra_byte:
	ld (hl),000h		;892e   ; a cero
	inc hl			;8930
	djnz otro_borra_byte		;8931
	ld (iy+000h),0ech		;8933   ; fuera
	ret			;8937
cerca_gatito:		; ¿Toca? Segun lo que lleve (+0x1D, mas alto) y si esta agachado (+4): cerca_y o la comparacion de abajo
	ld a,(ix+01dh)		;8938   ; lleva algo?
	and a			;893b
	jr nz,cerca_alto		;893c   ; si
	ld a,(ix+004h)		;893e   ; agachado?
	and a			;8941
	jr nz,cerca_agachado		;8942   ; si
cerca_y:		; ¿Toca en Y? A = la Y de IY menos la del protagonista (IX): C (toca) si, con signo, queda entre C - 0x100 y B - 1 (B, el margen por un lado; C, 0x100 menos el del otro)
	ld a,(iy+000h)		;8944   ; la Y del otro...
	sub (ix+000h)		;8947   ; ...menos la del protagonista
cerca_mira:
	cp b			;894a   ; menos que B (de 0 a B - 1): toca
	ret c			;894b   ; C
	cp c			;894c   ; C o mas (de C - 0x100 a -1)?
	jr c,cerca_no		;894d
	scf			;894f   ; si: toca (C)
	ret			;8950   ; C: toca
cerca_no:
	and a			;8951   ; NC: no
	ret			;8952   ; NC
cerca_agachado:		; Agachado: la Y de IY menos la del gatito entre B y 0xFA
	ld a,(iy+000h)		;8953   ; la X
	sub (ix+000h)		;8956   ; la Y del gatito
	cp b			;8959
	ret c			;895a
	cp 0fah		;895b   ; 0xFA?
	jr c,cerca_no		;895d
	scf			;895f   ; C: toca
	ret			;8960
cerca_alto:		; Con algo encima: 16 mas de alto
	ld a,c			;8961   ; 16 menos...
	sub 010h		;8962
	ld c,a			;8964   ; ...de alto
	ld a,(ix+004h)		;8965   ; agachado?
	and a			;8968
	jr z,cerca_y		;8969
	ld a,(iy+000h)		;896b   ; la Y...
	sub (ix+000h)		;896e   ; ...menos la del gatito
	cp b			;8971
	ret c			;8972
	cp 0eah		;8973   ; 0xEA?
	jr c,cerca_no		;8975
	scf			;8977   ; C: toca
	ret			;8978
cerca_x:		; ¿Toca en X? A = la X de IY menos la del gatito
	ld a,(iy+001h)		;8979   ; la X de IY...
	sub (ix+001h)		;897c   ; ...menos la del gatito
	jr cerca_mira		;897f
cerca_y2:		; Como cerca_y, con el sprite +0x70
	ld a,(iy+000h)		;8981   ; la Y de IY...
	sub (ix+070h)		;8984   ; ...menos la del tiro
	jr cerca_mira		;8987
cerca_x2:		; Como cerca_x, con el sprite +0x70
	ld a,(iy+001h)		;8989   ; la X de IY...
	sub (ix+071h)		;898c   ; ...menos la del tiro
	jr cerca_mira		;898f
tiempo:		; TIME baja: una unidad cada 8 - la vuelta (0xE049; 3 como poco) cuadros; por debajo de 100, el efecto 3; a cero (0xE182), TIME=OVER (0x90E7) y el gatito tocado (0xE183 = 1)
	ld a,(0e186h)		;8991   ; la fase acaba?
	and a			;8994
	ret nz			;8995
	ld a,(0e183h)		;8996   ; tocado?
	and a			;8999
	ret nz			;899a
	ld a,(0e182h)		;899b   ; ya sin tiempo?
	and a			;899e
	ret nz			;899f
	ld a,(0e049h)		;89a0   ; la vuelta...
	ld b,a			;89a3
	ld a,008h		;89a4   ; ...8 menos ella...
	sub b			;89a6   ; 8 - la vuelta
	cp 00ah		;89a7   ; ...3 como poco
	jr nc,tiempo_tres		;89a9
	cp 003h		;89ab
	jr nc,tiempo_cuadros		;89ad
tiempo_tres:
	ld a,003h		;89af   ; 3
tiempo_cuadros:
	ld b,a			;89b1
	ld a,(0e01fh)		;89b2   ; tantos cuadros?
	cp b			;89b5   ; tantos?
	jp c,tiempo_vram		;89b6
	xor a			;89b9   ; la cuenta a 0
	ld (0e01fh),a		;89ba   ; la cuenta a 0
	ld hl,0e043h		;89bd   ; el millar y la centena a 0?
	cp (hl)			;89c0
	jr nz,tiempo_resta		;89c1
	dec hl			;89c3   ; la centena
	cp (hl)			;89c4
	jr nz,tiempo_resta		;89c5
	ld a,003h		;89c7   ; el efecto 3: poco tiempo
	call efecto_pide		;89c9   ; pedido
tiempo_resta:
	xor a			;89cc
	ld hl,0e040h		;89cd   ; las unidades?
	cp (hl)			;89d0
	jr nz,tiempo_unidad		;89d1   ; no: una menos
	inc hl			;89d3   ; las decenas?
	cp (hl)			;89d4
	jr nz,tiempo_decena		;89d5   ; no
	inc hl			;89d7   ; las centenas?
	cp (hl)			;89d8
	jr nz,tiempo_centena		;89d9   ; no
	inc hl			;89db   ; el millar?
	cp (hl)			;89dc
	jr nz,tiempo_millar		;89dd   ; no
	inc a			;89df   ; todo a 0: sin tiempo
	ld (0e182h),a		;89e0   ; 0xE182 = 1
	xor a			;89e3
	ld (ix+01dh),a		;89e4   ; sin nada encima
	inc a			;89e7   ; el gatito tocado
	ld (0e183h),a		;89e8   ; 0xE183 = 1
	ld hl,090e7h		;89eb   ; TIME=OVER
	jp L_8A23		;89ee   ; OVER en las cifras
tiempo_millar:		; Un millar menos y las de abajo a 9
	dec (hl)			;89f1   ; el millar
	ld a,009h		;89f2   ; y las otras a 9
	dec hl			;89f4
	ld (hl),a			;89f5   ; a 9
tiempo_nueve2:
	dec hl			;89f6
	ld (hl),a			;89f7   ; a 9
tiempo_nueve1:
	dec hl			;89f8
	ld (hl),a			;89f9   ; a 9
	jr tiempo_pinta		;89fa   ; a la pantalla
tiempo_centena:		; Una centena menos
	dec (hl)			;89fc   ; la centena
	ld a,009h		;89fd   ; las de abajo a 9
	jr tiempo_nueve2		;89ff
tiempo_decena:		; Una decena menos
	dec (hl)			;8a01   ; la decena
	ld a,009h		;8a02   ; las de abajo a 9
	jr tiempo_nueve1		;8a04
tiempo_unidad:		; Una unidad menos
	dec (hl)			;8a06   ; la unidad
tiempo_pinta:		; TIME en la pantalla: las cifras al reves en 0xE044-0xE047 y los ceros de la izquierda, espacios (0x10)
	ld b,004h		;8a07   ; cuatro cifras...
	ld de,0e047h		;8a09   ; al reves...
	ld hl,0e040h		;8a0c   ; desde las unidades
tiempo_copia:
	ld a,(hl)			;8a0f   ; una cifra...
	ld (de),a			;8a10   ; ...en 0xE084-0xE087
	inc hl			;8a11   ; la siguiente
	dec de			;8a12   ; hacia atras
	djnz tiempo_copia		;8a13   ; cuatro
	ld bc,00400h		;8a15   ; los ceros de la izquierda: B = 4, C = 0x10 (el espacio)
	xor a			;8a18   ; 0
tiempo_ceros:
	cp (hl)			;8a19   ; 0?
	jr nz,tiempo_vram		;8a1a   ; no: listo
	ld (hl),c			;8a1c   ; un espacio
	inc hl			;8a1d   ; la siguiente
	djnz tiempo_ceros		;8a1e   ; cuatro
tiempo_vram:		; Las cuatro cifras de TIME (0xE044) en la fila 1, columna 6
	ld hl,0e044h		;8a20   ; las cifras
L_8A23:
	ld de,01826h		;8a23   ; la fila 1, columna 6
	ld bc,00004h		;8a26   ; cuatro casillas
	jp 0005ch		;8a29   ; LDIRVM
sprites_ram:		; Los 16 objetos de 0xE300 (16 bytes: los 4 primeros son sus atributos) a 0xE100
	ld hl,0e300h		;8a2c   ; los objetos...
	ld de,0e100h		;8a2f   ; ...a 0xE100
	ld b,010h		;8a32   ; 16
sprites_ram_uno:
	push bc			;8a34
	ld bc,00004h		;8a35   ; cuatro bytes
	ldir		;8a38   ; los atributos
	ld bc,0000ch		;8a3a   ; el siguiente (+16)
	add hl,bc			;8a3d
	pop bc			;8a3e
	djnz sprites_ram_uno		;8a3f   ; 16
	ret			;8a41
pantalla_limpia:		; La pantalla apagada, la tabla de nombres a 0x10, la RAM de 0xE100 a cero, el tiempo a 1100, los botones a 0, los dibujos y colores de las casillas (0x6180 / 0x7180, o 0x6980 / 0x7980 desde la escena 4) en los tres tercios; en la escena 0, otros dibujos (0x60C0, 0x70C0) en las casillas 0x34-0x3B, 0x50-0x59 y 0x90-0x95; y los de los sprites
	call 00041h		;8a42   ; DISSCR
	call nombres_borra		;8a45   ; la tabla de nombres
	call ram_borra		;8a48   ; la RAM
	call tiempo_1100		;8a4b   ; el tiempo
	xor a			;8a4e   ; los botones a 0
	ld (0e026h),a		;8a4f   ; los botones a 0
	ld (0e020h),a		;8a52   ; el boton 2
	ld (0e022h),a		;8a55   ; el boton 1
	ld (0e024h),a		;8a58   ; 0xE024
	ld (0e180h),a		;8a5b   ; la palanca
	ld de,00180h		;8a5e   ; los dibujos, en los tres tercios...
	call casillas_pon		;8a61   ; en el primer tercio
	ld de,00980h		;8a64   ; el segundo
	call casillas_pon		;8a67
	ld de,01180h		;8a6a   ; el tercero
	call casillas_pon		;8a6d
	ld de,02180h		;8a70   ; los colores en el primero
	call colores_pon		;8a73
	ld de,02980h		;8a76   ; el segundo
	call colores_pon		;8a79
	ld de,03180h		;8a7c   ; el tercero
	call colores_pon		;8a7f
	ld a,(0e04ah)		;8a82   ; la escena 0?
	and a			;8a85
	jr z,escena0_casillas		;8a86   ; si
	jp sprites_dibujos		;8a88   ; los dibujos de los sprites
escena0_casillas:
	ld de,001a0h		;8a8b   ; 0x60C0: 0x40 bytes a la casilla 0x34...
	ld hl,060c0h		;8a8e
	ld bc,00040h		;8a91   ; 0x40 bytes
	call 0005ch		;8a94   ; LDIRVM
	ex de,hl			;8a97
	ld de,00280h		;8a98   ; ...0x50 a la 0x50...
	ld bc,00050h		;8a9b   ; 0x50 bytes
	call 0005ch		;8a9e   ; LDIRVM
	ex de,hl			;8aa1
	ld de,00480h		;8aa2   ; ...y 0x30 a la 0x90; en los tres tercios
	ld bc,00030h		;8aa5   ; 0x30 bytes
	call 0005ch		;8aa8   ; LDIRVM
	ld de,009a0h		;8aab   ; el segundo tercio
	ld hl,060c0h		;8aae
	ld bc,00040h		;8ab1
	call 0005ch		;8ab4   ; LDIRVM
	ex de,hl			;8ab7
	ld de,00a80h		;8ab8
	ld bc,00050h		;8abb
	call 0005ch		;8abe   ; LDIRVM
	ex de,hl			;8ac1
	ld de,00c80h		;8ac2
	ld bc,00030h		;8ac5
	call 0005ch		;8ac8   ; LDIRVM
	ld de,011a0h		;8acb   ; el tercero
	ld hl,060c0h		;8ace
	ld bc,00040h		;8ad1
	call 0005ch		;8ad4   ; LDIRVM
	ex de,hl			;8ad7
	ld de,01280h		;8ad8
	ld bc,00050h		;8adb
	call 0005ch		;8ade   ; LDIRVM
	ex de,hl			;8ae1
	ld de,01480h		;8ae2
	ld bc,00030h		;8ae5
	call 0005ch		;8ae8   ; LDIRVM
	ld de,021a0h		;8aeb   ; y sus colores (0x70C0)
	ld hl,070c0h		;8aee   ; los colores (0x70C0)
	ld bc,00040h		;8af1
	call 0005ch		;8af4   ; LDIRVM
	ex de,hl			;8af7
	ld de,02280h		;8af8
	ld bc,00050h		;8afb
	call 0005ch		;8afe   ; LDIRVM
	ex de,hl			;8b01
	ld de,02480h		;8b02
	ld bc,00030h		;8b05
	call 0005ch		;8b08   ; LDIRVM
	ld de,029a0h		;8b0b   ; el segundo tercio
	ld hl,070c0h		;8b0e
	ld bc,00040h		;8b11
	call 0005ch		;8b14   ; LDIRVM
	ex de,hl			;8b17
	ld de,02a80h		;8b18
	ld bc,00050h		;8b1b
	call 0005ch		;8b1e   ; LDIRVM
	ex de,hl			;8b21
	ld de,02c80h		;8b22
	ld bc,00030h		;8b25
	call 0005ch		;8b28   ; LDIRVM
	ld de,031a0h		;8b2b   ; el tercero
	ld hl,070c0h		;8b2e
	ld bc,00040h		;8b31
	call 0005ch		;8b34   ; LDIRVM
	ex de,hl			;8b37
	ld de,03280h		;8b38
	ld bc,00050h		;8b3b
	call 0005ch		;8b3e   ; LDIRVM
	ex de,hl			;8b41
	ld de,03480h		;8b42
	ld bc,00030h		;8b45
	call 0005ch		;8b48   ; LDIRVM
	jp sprites_dibujos		;8b4b   ; los dibujos de los sprites
marcador_pon:		; El marcador de arriba: HISCORE: (0x910F) en la fila 0 y SCORE: (0x9111) en la 1, TIME= (0x90E2), las vidas, ROUND (0x90DB) con el pueblo y la fase, y TIME
	ld de,0180ah		;8b4e   ; HISCORE: en la fila 0, columna 10
	ld hl,0910fh		;8b51   ; HISCORE:0000000
	ld bc,0000fh		;8b54
	call 0005ch		;8b57   ; LDIRVM
	ld de,0182ch		;8b5a   ; SCORE: (sus ultimas letras) en la fila 1, columna 12
	ld hl,09111h		;8b5d   ; SCORE:000000
	ld bc,0000dh		;8b60
	call 0005ch		;8b63   ; LDIRVM
	ld hl,090e2h		;8b66   ; TIME= en la fila 1, columna 1
	ld de,01821h		;8b69
	ld bc,00005h		;8b6c   ; cinco
	call 0005ch		;8b6f   ; LDIRVM
	call vidas_pon		;8b72   ; las vidas
	call ronda_pinta		;8b75   ; ROUND
	call tiempo_vram		;8b78   ; el tiempo
	ret			;8b7b
ronda_pinta:		; ROUND (0x90DB) en la fila 0, columna 1, con el pueblo (0xE009) y la fase del pueblo (0xE048): ROUND1-1
	ld hl,090dbh		;8b7c   ; ROUND y el guion
	ld de,01801h		;8b7f   ; la fila 0, columna 1
	ld bc,00007h		;8b82
	call 0005ch		;8b85   ; LDIRVM
	ld a,(0e009h)		;8b88   ; el pueblo
	ld hl,01806h		;8b8b   ; la columna 6
	call 0004dh		;8b8e   ; WRTVRM
	ld a,(0e048h)		;8b91   ; la fase
	inc hl			;8b94   ; la columna 8
	inc hl			;8b95
	call 0004dh		;8b96   ; WRTVRM
	ret			;8b99
tiempo_1100:		; El tiempo a 1100: las cifras a 0 y 0xE043 / 0xE044 a 1
	call tiempo_cero		;8b9a   ; las cifras a 0
	ld a,001h		;8b9d   ; el millar y la centena a 1
	ld (0e044h),a		;8b9f
	ld (0e043h),a		;8ba2
	ret			;8ba5
tiempo_cero:		; Las cifras del tiempo (0xE040-0xE042, 0xE045-0xE047) a 0
	xor a			;8ba6
	ld (0e047h),a		;8ba7   ; las cifras de la pantalla a 0...
	ld (0e046h),a		;8baa
	ld (0e045h),a		;8bad
	ld (0e040h),a		;8bb0   ; ...y las de la cuenta
	ld (0e041h),a		;8bb3
	ld (0e042h),a		;8bb6
	ret			;8bb9
ram_borra:		; 0x1000 bytes de 0xE100 a cero; y 16 objetos fuera
	ld hl,0e100h		;8bba   ; desde 0xE100...
	ld bc,01000h		;8bbd   ; ...0x1000 bytes
ram_borra_byte:
	ld (hl),000h		;8bc0   ; ...a cero
	inc hl			;8bc2   ; el siguiente
	dec bc			;8bc3   ; uno menos
	ld a,c			;8bc4
	or b			;8bc5
	jr nz,ram_borra_byte		;8bc6
objetos_fuera:		; 16 objetos de 16 bytes desde 0xE300 fuera (Y 0xEC) y los sprites
	ld hl,0e300h		;8bc8   ; 16 objetos...
	ld de,00010h		;8bcb   ; 16 bytes cada uno
	ld b,010h		;8bce   ; 16
objetos_fuera_y:
	ld (hl),0ech		;8bd0   ; ...fuera
	add hl,de			;8bd2   ; el siguiente
	djnz objetos_fuera_y		;8bd3   ; 16
	call sprites_ram		;8bd5   ; los sprites
	call sprites_vram_tabla		;8bd8   ; a la VRAM
	ret			;8bdb
ram_e400_borra:		; Los 256 bytes de 0xE400 a cero
	ld hl,0e400h		;8bdc   ; 0xE400...
	ld b,000h		;8bdf   ; ...256 bytes
ram_e400_byte:
	ld (hl),000h		;8be1   ; a cero
	inc hl			;8be3   ; el siguiente
	djnz ram_e400_byte		;8be4
	ret			;8be6
objetos_e380_fuera:		; Los 0x80 bytes de 0xE380 a cero y sus ocho objetos fuera
	ld hl,0e380h		;8be7   ; 0xE380...
	ld b,080h		;8bea   ; ...0x80 bytes
objetos_e380_byte:
	ld (hl),000h		;8bec   ; a cero
	inc hl			;8bee   ; el siguiente
	djnz objetos_e380_byte		;8bef
	ld hl,0e380h		;8bf1   ; y los ocho...
	ld de,00010h		;8bf4   ; 16 bytes cada uno
	ld b,008h		;8bf7   ; ocho
objetos_e380_y:
	ld (hl),0ech		;8bf9   ; fuera
	add hl,de			;8bfb   ; el siguiente
	djnz objetos_e380_y		;8bfc
	call sprites_ram		;8bfe   ; los sprites
	call sprites_vram_tabla		;8c01   ; a la VRAM
	ret			;8c04
pantalla_cierra:		; La zona de juego (filas 2-23) se borra columna a columna, de izquierda a derecha, una cada 2 cuadros
	ld hl,01840h		;8c05   ; la fila 2, columna 0
	ld (0e1a0h),hl		;8c08   ; apuntada
	ld b,020h		;8c0b   ; 32 columnas
	xor a			;8c0d   ; la cuenta a 0
	ld (0e010h),a		;8c0e
	ld de,00020h		;8c11   ; una fila
pantalla_cierra_columna:
	ld c,016h		;8c14   ; 22 filas
	ld hl,(0e1a0h)		;8c16   ; la columna
pantalla_cierra_espera:
	ld a,(0e010h)		;8c19   ; la cuenta
	cp 002h		;8c1c   ; 2 cuadros?
	jr c,pantalla_cierra_espera		;8c1e
	xor a			;8c20   ; la cuenta a 0
	ld (0e010h),a		;8c21   ; a 0
pantalla_cierra_fila:
	ld a,080h		;8c24   ; el espacio
	call 0004dh		;8c26   ; WRTVRM
	add hl,de			;8c29   ; la fila siguiente
	dec c			;8c2a   ; una fila menos
	jr nz,pantalla_cierra_fila		;8c2b
	ld hl,(0e1a0h)		;8c2d   ; la columna...
	inc hl			;8c30   ; la columna siguiente
	ld (0e1a0h),hl		;8c31   ; ...apuntada
	djnz pantalla_cierra_columna		;8c34
	ret			;8c36
nombres_borra:		; La tabla de nombres llena de la casilla 0x10 (el espacio)
	ld a,010h		;8c37   ; el espacio...
	ld hl,01800h		;8c39   ; ...en la tabla de nombres...
	ld bc,00300h		;8c3c   ; ...0x300 casillas
	call 00056h		;8c3f   ; FILVRM
	ret			;8c42
letras_pon:		; Las letras de la BIOS ("0" a "_", 0x1D3F, 0x180 bytes) a la VRAM en DE; y DE al tercio siguiente
	ld hl,01d3fh		;8c43   ; la fuente de la BIOS
tercio_copia:
	push bc			;8c46
	ld bc,00180h		;8c47   ; 0x180 bytes
tercio_copia_bc:
	call 0005ch		;8c4a   ; LDIRVM
	ld bc,00800h		;8c4d   ; al tercio siguiente
	add hl,bc			;8c50
	ex de,hl			;8c51   ; en DE
	pop bc			;8c52
	ret			;8c53
casillas_pon:		; Los dibujos de las casillas 0x30-0xFF (0x6180, o 0x6980 desde la escena 4; 0x680 bytes) en DE
	push bc			;8c54
	ld a,(0e04ah)		;8c55   ; la escena
	cp 004h		;8c58   ; 4 o mas?
	jr c,casillas_pon_1		;8c5a
	ld hl,06980h		;8c5c   ; 0x6980
	jr casillas_pon_va		;8c5f
casillas_pon_1:
	ld hl,06180h		;8c61   ; 0x6180
casillas_pon_va:
	ld bc,00680h		;8c64   ; 0x680 bytes
	jr tercio_copia_bc		;8c67
colores_pon:		; Sus colores (0x7180, o 0x7980 desde la escena 4) en DE
	push bc			;8c69
	ld a,(0e04ah)		;8c6a   ; la escena
	cp 004h		;8c6d   ; 4 o mas?
	jr c,colores_pon_1		;8c6f
	ld hl,07980h		;8c71   ; 0x7980
	jr casillas_pon_va		;8c74
colores_pon_1:
	ld hl,07180h		;8c76   ; 0x7180
	ld bc,00680h		;8c79   ; 0x680 bytes
	jr tercio_copia_bc		;8c7c

; ----------------------------------------------------------------------
; DATOS codigo_suelto_8C7E: Codigo que nadie llama: un trozo de copia de 16
;   bytes a la VRAM
;   0x8c7e..0x8c8a  (12 bytes)
DATA_codigo_suelto_8C7E:
	defb 0c5h,001h,010h,000h,0cdh,05ch,000h,001h,020h,000h,018h,0c6h	; 8c7e  .....\.. ...

; ======================================================================
; CODIGO 0x8c8a..0x8c97  (13 bytes)
; ======================================================================


colores_ocho:		; 8 bytes de colores a A en HL; y HL al tercio siguiente
	push bc			;8c8a
	ld bc,00008h		;8c8b   ; 8 bytes
	call 00056h		;8c8e   ; FILVRM
	ld de,00800h		;8c91   ; al tercio siguiente
	add hl,de			;8c94   ; al tercio siguiente
	pop bc			;8c95
	ret			;8c96

; ----------------------------------------------------------------------
; DATOS codigo_suelto_8C97: Codigo que nadie llama: 0x280 bytes a 0xF0
;   0x8c97..0x8c9f  (8 bytes)
DATA_codigo_suelto_8C97:
	defb 0c5h,001h,080h,002h,03eh,0f0h,018h,0efh	; 8c97  ....>...

; ======================================================================
; CODIGO 0x8c9f..0x90db  (1084 bytes)
; ======================================================================


casillas_titulo:		; Las casillas del titulo: 0x6000 y 0x6800 en la tabla de dibujos, 0x7000 y 0x7800 en la de colores, en los tres tercios
	ld b,003h		;8c9f   ; tres tercios
	ld de,00180h		;8ca1
casillas_titulo_1:
	ld hl,06000h		;8ca4   ; 0x6000
	call tercio_copia		;8ca7   ; 0x180 bytes
	djnz casillas_titulo_1		;8caa
	ld b,003h		;8cac   ; tres
	ld de,00300h		;8cae
casillas_titulo_2:
	ld hl,06800h		;8cb1   ; 0x6800
	call tercio_copia		;8cb4
	djnz casillas_titulo_2		;8cb7
	ld b,003h		;8cb9   ; tres
	ld de,02180h		;8cbb
casillas_titulo_3:
	ld hl,07000h		;8cbe   ; 0x7000
	call tercio_copia		;8cc1
	djnz casillas_titulo_3		;8cc4
	ld b,003h		;8cc6   ; tres
	ld de,02300h		;8cc8
casillas_titulo_4:
	ld hl,07800h		;8ccb   ; 0x7800
	call tercio_copia		;8cce
	djnz casillas_titulo_4		;8cd1
	ret			;8cd3
sprites_dibujos:		; Los dibujos de los sprites (0x5800, 0x800 bytes) a 0x3800; salvo en la escena 5, los de 0x57A0 y 0x56C0 en los sprites 0x4C y 0xCC; en la escena 4, los de 0x6F30 y 0x6F70 en los 0x68 y 0xE8
	ld de,03800h		;8cd4   ; a 0x3800
	ld hl,05800h		;8cd7   ; desde 0x5800
	ld bc,00800h		;8cda   ; 0x800 bytes
	call 0005ch		;8cdd   ; LDIRVM
	ld a,(0e04ah)		;8ce0   ; la escena 5?
	cp 005h		;8ce3   ; la escena 5?
	jr z,sprites_dibujos_4		;8ce5
	ld hl,057a0h		;8ce7   ; 0x40 bytes de 0x57A0...
	ld de,03a60h		;8cea   ; al sprite 0x4C
	ld bc,00040h		;8ced
	call 0005ch		;8cf0   ; LDIRVM
	ld hl,056c0h		;8cf3   ; ...y de 0x56C0
	ld de,03e60h		;8cf6   ; al sprite 0xCC
	ld bc,00040h		;8cf9
	call 0005ch		;8cfc   ; LDIRVM
sprites_dibujos_4:
	ld a,(0e04ah)		;8cff   ; la escena 4?
	cp 004h		;8d02   ; la escena 4?
	ret nz			;8d04
	ld hl,06f30h		;8d05   ; 0x6F30...
	ld de,03b40h		;8d08   ; al sprite 0x68
	ld bc,00040h		;8d0b
	call 0005ch		;8d0e   ; LDIRVM
	ld hl,06f70h		;8d11   ; ...y 0x6F70
	ld de,03f40h		;8d14   ; al sprite 0xE8
	ld bc,00040h		;8d17
	jp 0005ch		;8d1a   ; LDIRVM
sprites_dibujos_pausa:		; Los dibujos de la pausa (0x5700, 0xA0 bytes) a 0x3800
	ld de,03800h		;8d1d   ; a 0x3800
	ld hl,05700h		;8d20   ; desde 0x5700
	ld bc,000a0h		;8d23   ; 0xA0 bytes
	jp 0005ch		;8d26   ; LDIRVM
sonido_reinicia:		; 0xE007 = 0xFF: la interrupcion pone el sonido a cero (0xB07E)
	ld a,0ffh		;8d29
	ld (0e007h),a		;8d2b   ; 0xE007 = 0xFF
	ret			;8d2e
sprites_vram:		; Los 16 objetos de 0xE300 (16 bytes cada uno: los 4 primeros son sus atributos) a 0xE100 y a la VRAM (0x1B00, 0x40 bytes)
	ld hl,0e300h		;8d2f   ; desde 0xE300
	ld de,0e100h		;8d32   ; a 0xE100
	ld b,004h		;8d35   ; 16
	call sprites_ram_uno		;8d37
sprites_vram_tabla:		; Los atributos de 0xE100 a la VRAM (0x1B00, 0x40 bytes)
	ld de,01b00h		;8d3a   ; la tabla de atributos
	ld hl,0e100h		;8d3d   ; desde 0xE100
	ld bc,00040h		;8d40   ; 0x40 bytes
	call 0005ch		;8d43   ; LDIRVM
	ret			;8d46
puntos_pinta:		; Las seis cifras de los puntos (0xE001) en la fila 1 y del record (0xE02E) en la fila 0, columna 18
	ld hl,0e001h		;8d47   ; los puntos
	ld de,01832h		;8d4a   ; la fila 1, columna 18
	ld bc,00006h		;8d4d   ; seis
	call 0005ch		;8d50   ; LDIRVM
	ld hl,0e02eh		;8d53   ; el record
	ld de,01812h		;8d56   ; la fila 0
	ld bc,00006h		;8d59   ; seis
	jp 0005ch		;8d5c   ; LDIRVM
puntos_suma:		; Jugando, los puntos + A (BCD, las dos ultimas cifras, 0xE00E) con su acarreo; cada 10.000 (100.000 en pantalla) una vida mas; al pasar de 999999 el record se queda con los puntos; desde 5.000 (0xE00D 0x50; en pantalla 50.000), una vida mas, una vez (0xE04F); y las cifras y el record
	ld b,a			;8d5f   ; lo que se suma
	ld a,(0e000h)		;8d60   ; jugando?
	and a			;8d63
	ret z			;8d64   ; no: nada
	ld a,(0e00eh)		;8d65   ; las dos ultimas
	add a,b			;8d68
	daa			;8d69   ; en BCD
	ld (0e00eh),a		;8d6a   ; apuntadas
	jr nc,puntos_mira		;8d6d   ; sin acarreo
	ld a,001h		;8d6f   ; acarreo
puntos_suma_cien:
	ld b,a			;8d71
	ld a,(0e00dh)		;8d72   ; las centenas
	add a,b			;8d75
	daa			;8d76   ; en BCD
	ld (0e00dh),a		;8d77   ; apuntadas
	jr nc,puntos_mira		;8d7a
	call vida_mas		;8d7c   ; cada 10.000 (100.000 en pantalla), una vida mas
	ld a,001h		;8d7f   ; acarreo
	ld b,a			;8d81   ; 1
	ld a,(0e00ch)		;8d82   ; las decenas de millar
	add a,b			;8d85
	daa			;8d86   ; en BCD
	ld (0e00ch),a		;8d87   ; apuntadas
	jr nc,puntos_mira		;8d8a
	ld a,(0e00eh)		;8d8c   ; se pasa: el record = los puntos
	ld (0e036h),a		;8d8f   ; el record: los puntos
	ld a,(0e00dh)		;8d92   ; el record: los puntos
	ld (0e035h),a		;8d95
	ld a,(0e00ch)		;8d98
	ld (0e034h),a		;8d9b
puntos_mira:
	ld a,(0e00dh)		;8d9e   ; 1.000 (10.000 en pantalla)?
	cp 050h		;8da1   ; 5.000 (50.000 en pantalla)?
	jr c,puntos_fin		;8da3   ; no
	ld a,(0e04fh)		;8da5   ; ya dada?
	and a			;8da8
	jr nz,puntos_fin		;8da9   ; dada
	inc a			;8dab   ; dada
	ld (0e04fh),a		;8dac   ; apuntada
	call vida_mas		;8daf   ; una vida mas
puntos_fin:
	call puntos_cifras		;8db2   ; las cifras
	call record_mira		;8db5   ; el record
	ret			;8db8
puntos_cifras:		; Los tres bytes BCD de los puntos (0xE00C) en seis cifras (0xE001), una por byte
	ld hl,0e001h		;8db9   ; las cifras
	ld de,0e00ch		;8dbc   ; los bytes BCD
	ld b,003h		;8dbf   ; tres
cifras_bcd:		; B bytes BCD de DE a cifras en HL (dos por byte)
	ld a,(de)			;8dc1   ; un byte
	ld c,a			;8dc2   ; guardado
	and 0f0h		;8dc3   ; la cifra alta
	rrca			;8dc5
	rrca			;8dc6
	rrca			;8dc7
	rrca			;8dc8
	ld (hl),a			;8dc9   ; apuntada
	inc hl			;8dca   ; la siguiente
	ld a,c			;8dcb   ; la baja
	and 00fh		;8dcc   ; la baja
	ld (hl),a			;8dce   ; la baja
	inc hl			;8dcf   ; la siguiente
	inc de			;8dd0   ; el siguiente
	djnz cifras_bcd		;8dd1   ; tres bytes
	ret			;8dd3
record_mira:		; Si los puntos (0xE00C) pasan del record (0xE034), son el record nuevo y sus cifras (0xE02E)
	ld de,0e034h		;8dd4   ; el record
	ld hl,0e00ch		;8dd7   ; los puntos
	ld a,(de)			;8dda   ; el byte alto...
	ld b,a			;8ddb
	ld a,(hl)			;8ddc   ; ...contra el de los puntos
	cp b			;8ddd   ; menos: nada
	ret c			;8dde   ; menor: nada
	jr nz,record_nuevo_3		;8ddf   ; mayor: record nuevo
	inc de			;8de1   ; iguales: el siguiente
	inc hl			;8de2
	ld a,(de)			;8de3   ; el siguiente
	ld b,a			;8de4
	ld a,(hl)			;8de5
	cp b			;8de6   ; menos?
	ret c			;8de7   ; menor: nada
	jr nz,record_nuevo_2		;8de8   ; mas: record
	inc de			;8dea   ; el bajo
	inc hl			;8deb
	ld a,(de)			;8dec   ; el siguiente
	ld b,a			;8ded
	ld a,(hl)			;8dee
	cp b			;8def   ; menos?
	ret c			;8df0   ; menor: nada
	jr record_nuevo		;8df1   ; igual o mas: record
record_nuevo_3:
	inc de			;8df3
	inc hl			;8df4
record_nuevo_2:
	inc de			;8df5
	inc hl			;8df6
record_nuevo:		; Los tres bytes, hacia atras
	ld bc,00003h		;8df7   ; tres bytes...
	lddr		;8dfa   ; ...hacia atras
	ld hl,0e02eh		;8dfc   ; sus cifras
	ld de,0e034h		;8dff   ; el record
	ld b,003h		;8e02   ; tres bytes
	jr cifras_bcd		;8e04   ; sus cifras
vida_mas:		; Una vida mas (BCD, 99 como mucho) y su cifra en el marcador
	ld a,(0e00bh)		;8e06   ; una mas
	add a,001h		;8e09   ; una mas
	daa			;8e0b   ; en BCD
	ld (0e00bh),a		;8e0c   ; apuntadas
	jr nc,vidas_pinta		;8e0f   ; sin pasar de 99
	ld a,099h		;8e11   ; 99 como mucho
	ld (0e00bh),a		;8e13   ; 99
	jr vidas_pinta		;8e16
vidas_pon:		; El gatito (0xFF) y "=" en la fila 0, columna 27, y las vidas
	ld a,0ffh		;8e18   ; el gatito
	ld hl,0181bh		;8e1a   ; la fila 0, columna 27
	call 0004dh		;8e1d   ; WRTVRM
	inc hl			;8e20   ; la siguiente
	ld a,00dh		;8e21   ; "="
	call 0004dh		;8e23   ; WRTVRM
vidas_pinta:		; Las vidas (0xE00B, BCD) en la fila 0, columna 29
	ld a,(0e00bh)		;8e26   ; las vidas
	and 0f0h		;8e29   ; la cifra alta
	rrca			;8e2b
	rrca			;8e2c
	rrca			;8e2d
	rrca			;8e2e
	ld hl,0181dh		;8e2f   ; la columna 29
	call 0004dh		;8e32   ; WRTVRM
	ld a,(0e00bh)		;8e35   ; la baja
	and 00fh		;8e38   ; la cifra baja
	inc hl			;8e3a
	call 0004dh		;8e3b   ; WRTVRM
	ret			;8e3e
espera_musica:		; Espera 8 cuadros, despues hasta que la musica acabe y otros 16
	xor a			;8e3f   ; la cuenta a 0
	ld (0e011h),a		;8e40
espera_musica_8:
	ld a,(0e011h)		;8e43
	cp 008h		;8e46   ; 8?
	jr c,espera_musica_8		;8e48
espera_musica_cuadro:
	call sprites_ram		;8e4a   ; los sprites
	call sprites_vram_tabla		;8e4d   ; a la VRAM
	ld a,(0e000h)		;8e50   ; jugando?
	and a			;8e53
	jr nz,espera_musica_mira		;8e54
	ld a,(0e026h)		;8e56   ; el boton?
	and a			;8e59
	ret nz			;8e5a
espera_musica_mira:
	ld a,(0e2bdh)		;8e5b   ; sonando?
	and a			;8e5e
	jr nz,espera_musica_cuadro		;8e5f
	ld a,(0e2beh)		;8e61
	and a			;8e64
	jr nz,espera_musica_cuadro		;8e65
	ld (0e011h),a		;8e67   ; la cuenta a 0
	call sonido_reinicia		;8e6a   ; el sonido a cero
espera_musica_16:
	ld a,(0e011h)		;8e6d   ; 16 cuadros mas
	cp 010h		;8e70   ; 16?
	jr c,espera_musica_16		;8e72
	ret			;8e74
interrupcion:		; La interrupcion (H.TIMI): el sonido a cero si se pidio (0xE007); sin nada sonando, B y C callados; el motor de sonido; 16 cuentas de cuadros (0xE010-0xE01F); jugando, F1 (0xE1B3: el gatito cae) y STOP (0xE1B5: el modo de 0xE1B7), los botones (0xE020: el 2 o GRAPH; 0xE022: el 1 o la barra) y la palanca
	ld a,(0e007h)		;8e75   ; se pidio el sonido a cero?
	cp 0ffh		;8e78   ; se pidio?
	jr nz,interrupcion_sonido		;8e7a
	call sonido_cero		;8e7c   ; a cero
	xor a			;8e7f   ; 0xE007 = 0
	ld (0e007h),a		;8e80
interrupcion_sonido:
	ld a,(0e2bdh)		;8e83   ; el canal de musica 1...
	ld b,a			;8e86
	ld a,(0e2c1h)		;8e87   ; ...y el 2
	add a,b			;8e8a   ; sonando alguno?
	and a			;8e8b   ; un efecto?
	jr nz,interrupcion_motor		;8e8c
	ld e,000h		;8e8e   ; sin efecto: los canales B y C a volumen 0
	ld a,009h		;8e90   ; ...a volumen 0
	call 00093h		;8e92   ; WRTPSG
	ld e,000h		;8e95   ; el C...
	ld a,00ah		;8e97   ; el registro 10
	call 00093h		;8e99   ; ...WRTPSG
interrupcion_motor:
	call sonido		;8e9c   ; el motor de sonido
	ld hl,0e010h		;8e9f   ; 16 cuentas...
	ld b,010h		;8ea2   ; 16 cuentas
L_8EA4:
	inc (hl)			;8ea4   ; ...una mas
	inc hl			;8ea5   ; la siguiente
	djnz L_8EA4		;8ea6
	ld a,(0e000h)		;8ea8   ; jugando?
	and a			;8eab
	jr z,interrupcion_quieto		;8eac   ; no: fuera de partida
	ld a,006h		;8eae   ; la fila 6: F1 (bit 5)?
	call 00141h		;8eb0   ; SNSMAT
	bit 5,a		;8eb3   ; F1?
	jr z,tecla_f1		;8eb5
	xor a			;8eb7   ; suelta
	ld (0e1b4h),a		;8eb8   ; suelta
	jr tecla_stop		;8ebb
tecla_f1:
	ld a,(0e1b4h)		;8ebd   ; ya sostenida?
	and a			;8ec0
	jr nz,tecla_stop		;8ec1
	inc a			;8ec3   ; recien pulsada: el gatito cae (0xE1B3)
	ld (0e1b3h),a		;8ec4   ; 0xE1B3 = 1
	ld (0e1b4h),a		;8ec7
tecla_stop:
	ld a,007h		;8eca   ; la fila 7: STOP (bit 4)?
	call 00141h		;8ecc   ; SNSMAT
	bit 4,a		;8ecf   ; STOP?
	jr z,tecla_stop_pulsada		;8ed1
	xor a			;8ed3   ; suelta
	ld (0e1b6h),a		;8ed4   ; suelta
	jr botones		;8ed7
tecla_stop_pulsada:
	ld a,(0e1b6h)		;8ed9
	and a			;8edc
	jr nz,botones		;8edd
	inc a			;8edf   ; recien pulsada: 0xE1B5
	ld (0e1b5h),a		;8ee0
	ld (0e1b6h),a		;8ee3
botones:
	ld de,0e020h		;8ee6   ; el boton 2 del mando (GTTRIG 3)
	ld hl,0e021h		;8ee9   ; el boton 2 del mando (GTTRIG 3)
	ld a,003h		;8eec
	call boton_mando		;8eee
	ld de,0e022h		;8ef1   ; el boton 1 (GTTRIG 1)
	ld hl,0e02dh		;8ef4
	ld a,001h		;8ef7
	call boton_mando		;8ef9
	ld a,001h		;8efc   ; y sostenido
	call 000d8h		;8efe
	ld (0e19dh),a		;8f01
	ld de,0e020h		;8f04   ; GRAPH y la barra
	ld hl,0e02bh		;8f07
	call botones_teclado		;8f0a
palanca:		; La palanca: los cursores o el mando 1 (GTSTCK 0 y 1), en 0xE180
	xor a			;8f0d
	call 000d5h		;8f0e   ; GTSTCK 0: los cursores
	ld (0e181h),a		;8f11
	ld a,001h		;8f14
	call 000d5h		;8f16   ; GTSTCK 1: el mando 1
	ld c,a			;8f19
	ld a,(0e181h)		;8f1a
	or c			;8f1d   ; uno u otro
	ld (0e180h),a		;8f1e
	ret			;8f21
interrupcion_quieto:		; Fuera de partida: en la demostracion (0xE027), cada 16 cuadros una entrada de la lista de 0xE037 (desde 0x5200): la mitad baja la palanca, la alta los botones (0x10 el 1, 0x20 el 2, otra los dos); en el titulo, el boton de empezar (0xE026) y la palanca
	ld a,(0e027h)		;8f22   ; la demostracion?
	and a			;8f25
	jr z,interrupcion_titulo		;8f26
	ld a,(0e016h)		;8f28
	cp 010h		;8f2b
	jr c,boton_empezar		;8f2d
	xor a			;8f2f
	ld (0e016h),a		;8f30
	ld hl,(0e037h)		;8f33   ; la lista
	ld a,(hl)			;8f36
	inc hl			;8f37
	ld (0e037h),hl		;8f38
	ld b,a			;8f3b
	and 00fh		;8f3c   ; la palanca
	ld (0e180h),a		;8f3e
	ld a,b			;8f41
	and 0f0h		;8f42   ; los botones
	and a			;8f44
	jr z,boton_empezar		;8f45
	cp 010h		;8f47
	jr nz,L_8F50		;8f49
	ld (0e020h),a		;8f4b
	jr boton_empezar		;8f4e
L_8F50:
	ld (0e022h),a		;8f50
	jr boton_empezar		;8f53
interrupcion_titulo:
	call boton_empezar		;8f55
	jr palanca		;8f58
boton_empezar:		; El boton de empezar (0xE026): la barra o el boton 1 del mando
	ld de,0e026h		;8f5a
	ld hl,0e025h		;8f5d
	call barra_lee		;8f60
	ld a,(de)			;8f63
	ld (0e181h),a		;8f64
	ld hl,0e021h		;8f67
	ld a,001h		;8f6a
	call boton_mando		;8f6c
	ld a,(de)			;8f6f   ; ...o lo del mando
	ld b,a			;8f70
	ld a,(0e181h)		;8f71   ; una...
	or b			;8f74   ; ...u otro
	ld (de),a			;8f75
	ret			;8f76
boton_mando:		; GTTRIG A: lo recien pulsado en (DE) y lo sostenido en (HL)
	call 000d8h		;8f77   ; GTTRIG
	and a			;8f7a
boton_mira:
	jr nz,boton_pulsado		;8f7b   ; pulsado?
boton_suelto:
	ld (hl),000h		;8f7d   ; suelto
	ret			;8f7f
boton_pulsado:
	ld a,(hl)			;8f80   ; ya sostenido?
	and a			;8f81
	ret nz			;8f82
	inc a			;8f83   ; recien pulsado
	ld (hl),a			;8f84   ; sostenido
	ld (de),a			;8f85   ; recien pulsado
	ret			;8f86
barra_lee:		; La barra (fila 8, bit 0): lo mismo
	ld a,008h		;8f87   ; la fila 8...
	call 00141h		;8f89   ; SNSMAT
	rrca			;8f8c   ; el bit 0: pulsada = 0
	jr nc,boton_pulsado		;8f8d
	jr boton_suelto		;8f8f
botones_teclado:		; La barra como boton 1 y GRAPH (fila 6, bit 2) como boton 2
	ld a,006h		;8f91   ; la fila 6
	call 00141h		;8f93   ; SNSMAT
	cpl			;8f96   ; pulsada = 1
	bit 2,a		;8f97   ; GRAPH (bit 2)
	call boton_mira		;8f99
	inc hl			;8f9c   ; los siguientes
	inc de			;8f9d
	inc de			;8f9e
	ld a,008h		;8f9f   ; la fila 8
	call 00141h		;8fa1   ; SNSMAT
	cpl			;8fa4
	push af			;8fa5
	rrca			;8fa6   ; la barra: el bit 0
	jr nc,barra_suelta		;8fa7
	ld a,0ffh		;8fa9
	jr barra_sostenida		;8fab
barra_suelta:
	xor a			;8fad
barra_sostenida:
	ld b,a			;8fae
	ld a,(0e19dh)		;8faf   ; con el boton 1 del mando, sostenido
	or b			;8fb2
	ld (0e19dh),a		;8fb3
	pop af			;8fb6
	bit 0,a		;8fb7
	jr boton_mira		;8fb9
presentacion:		; La presentacion de CASIO: cada 3 cuadros, dos CASIO entran por los lados (filas 11 y 12) y, desde el paso 9, otros dos bajan y suben hacia el centro; con el paso 21, la musica 4 y SOFTWARE (0x8B14) debajo; 128 cuadros o el boton y la pantalla en blanco
	ld a,001h		;8fbb   ; el paso 1
	ld (0e187h),a		;8fbd
	ld hl,0180ch		;8fc0   ; el que baja: la fila 0, columna 12
	ld (0e189h),hl		;8fc3
	ld hl,01aech		;8fc6   ; el que sube: la fila 23
	ld (0e18bh),hl		;8fc9
presentacion_cuadro:
	ld a,(0e014h)		;8fcc   ; 3 cuadros
	cp 003h		;8fcf
	jr c,presentacion_cuadro		;8fd1
	xor a			;8fd3
	ld (0e014h),a		;8fd4
	call presentacion_lineas		;8fd7
	call presentacion_lados		;8fda
	ld hl,0e187h		;8fdd   ; un paso mas
	inc (hl)			;8fe0
	ld a,(hl)			;8fe1
	cp 015h		;8fe2   ; 21?
	jr nc,presentacion_junta		;8fe4
	cp 009h		;8fe6   ; desde el 9...
	jr c,presentacion_sigue		;8fe8
	ld hl,(0e189h)		;8fea   ; ...el de arriba baja una fila...
	ld bc,00020h		;8fed
	add hl,bc			;8ff0
	ld (0e189h),hl		;8ff1
	ld hl,(0e18bh)		;8ff4   ; ...y el de abajo sube
	sbc hl,bc		;8ff7
	ld (0e18bh),hl		;8ff9
presentacion_sigue:
	jr presentacion_cuadro		;8ffc
presentacion_junta:
	ld a,004h		;8ffe   ; la musica 4
	call musica_pide		;9000   ; pide la musica
L_9003:
	ld a,(0e014h)		;9003   ; 0x80 cuadros
	cp 080h		;9006
	jr c,L_9003		;9008
	xor a			;900a
	ld (0e026h),a		;900b   ; el boton a 0
	call sonido_reinicia		;900e   ; el sonido a cero
	call nombres_borra		;9011   ; la pantalla en blanco
	ret			;9014
presentacion_lineas:		; Desde el paso 9: el CASIO que baja (las dos filas de 0x7F8A y 0x7F81 con una en blanco, 0x7F93, encima) y el que sube (con la blanca debajo)
	ld a,(0e187h)		;9015   ; el paso
	cp 009h		;9018   ; 9?
	ret c			;901a
	ld bc,00008h		;901b   ; 8 casillas
	ld hl,07f8ah		;901e   ; la fila de abajo del que baja
	ld de,(0e189h)		;9021
	call 0005ch		;9025   ; LDIRVM
	ld de,00020h		;9028
	and a			;902b
	sbc hl,de		;902c   ; una fila arriba
	ex de,hl			;902e
	ld hl,07f81h		;902f   ; la de arriba
	ld bc,00008h		;9032
	call 0005ch		;9035   ; LDIRVM
	ld de,00020h		;9038
	and a			;903b
	sbc hl,de		;903c   ; una fila arriba
	ex de,hl			;903e
	ld hl,07f93h		;903f   ; la blanca
	ld bc,00008h		;9042
	call 0005ch		;9045   ; LDIRVM
	ld bc,00008h		;9048
	ld hl,07f81h		;904b   ; el que sube: la de arriba
	ld de,(0e18bh)		;904e
	call 0005ch		;9052   ; LDIRVM
	ld de,00020h		;9055
	add hl,de			;9058   ; una fila abajo
	ex de,hl			;9059
	ld hl,07f8ah		;905a   ; la de abajo
	ld bc,00008h		;905d
	call 0005ch		;9060   ; LDIRVM
	ld de,00020h		;9063
	add hl,de			;9066   ; una fila abajo
	ex de,hl			;9067
	ld hl,07f93h		;9068   ; la blanca
	ld bc,00008h		;906b
	call 0005ch		;906e   ; LDIRVM
	ret			;9071
presentacion_lados:		; Los dos CASIO de los lados en las filas 11 y 12: uno entra por la derecha casilla a casilla y el otro por la izquierda, leido desde el final
	ld a,(0e187h)		;9072   ; el paso
	ld c,a			;9075
	cp 009h		;9076   ; ...no mas de 9
	jr c,presentacion_arriba		;9078
	ld c,009h		;907a   ; 9 como mucho
presentacion_arriba:
	ld hl,01980h		;907c   ; en la fila 12, columna 0, menos el paso
	ld b,a			;907f   ; la columna, hacia la izquierda
	ld a,l			;9080
	sub b			;9081
	ld l,a			;9082
	ex de,hl			;9083
	ld hl,07f81h		;9084   ; la fila de arriba de CASIO...
	ld b,000h		;9087
	call 0005ch		;9089
	ld de,00020h		;908c
	add hl,de			;908f
	ex de,hl			;9090
	ld hl,07f8ah		;9091
	ld a,(0e187h)		;9094
	cp 009h		;9097
	jr c,L_909D		;9099
	ld a,009h		;909b
L_909D:
	ld c,a			;909d   ; C casillas
	call 0005ch		;909e   ; LDIRVM
	ld hl,01960h		;90a1   ; el otro: la fila 11
	ld a,(0e187h)		;90a4
	ld c,a			;90a7
	cp 009h		;90a8   ; 9 o mas?
	jr c,L_90B2		;90aa
	sub 009h		;90ac   ; pasado el 9, se mueve
	add a,l			;90ae
	ld l,a			;90af
	ld c,009h		;90b0   ; 9
L_90B2:
	ex de,hl			;90b2   ; DE: la VRAM
	ld hl,07f89h		;90b3   ; la fila de arriba, desde el final
	ld a,l			;90b6
	sub c			;90b7   ; - C
	jr nc,L_90BB		;90b8
	dec h			;90ba
L_90BB:
	ld l,a			;90bb
	call 0005ch		;90bc   ; LDIRVM
	ld de,00020h		;90bf   ; una fila abajo
	add hl,de			;90c2
	ex de,hl			;90c3
	ld a,(0e187h)		;90c4   ; el paso
	ld c,a			;90c7
	cp 009h		;90c8
	jr c,L_90CE		;90ca
	ld c,009h		;90cc
L_90CE:
	ld hl,07f92h		;90ce
	ld a,l			;90d1
	sub c			;90d2
	jr nc,L_90D6		;90d3
	dec h			;90d5
L_90D6:
	ld l,a			;90d6
	call 0005ch		;90d7
	ret			;90da

; ----------------------------------------------------------------------
; DATOS textos: Los textos: ROUND y el guion (0x90DB), TIME=OVER (0x90E2;
;   TIME= en el marcador, OVER sobre las cifras), GAME START (0x90EB), CASIO
;   en casillas (0x90F5), PUSH TRIG:1 OR SPACE (0x90FB), HISCORE:0000000
;   (0x910F; SCORE:, 0x9111) y GAME OVER (0x911E)
;   0x90db..0x9130  (85 bytes)
DATA_textos:
	defb 022h,01fh,025h,01eh,014h,010h,0feh,024h,019h,01dh,015h,00dh,01fh,026h,015h,022h	; 90db  ".%....$.....&."
	defb 017h,011h,01dh,015h,010h,023h,024h,011h,022h,024h,08ah,08bh,08ch,08dh,08eh,08fh	; 90eb  .....#$."$......
	defb 020h,025h,023h,018h,010h,024h,022h,019h,017h,00ah,001h,010h,01fh,022h,010h,023h	; 90fb   %#..$"......".#
	defb 020h,011h,013h,015h,018h,019h,023h,013h,01fh,022h,015h,00ah,000h,000h,000h,000h	; 910b   .....#.."......
	defb 000h,000h,000h,017h,011h,01dh,015h,010h,01fh,026h,015h,022h,010h,010h,010h,010h	; 911b  .........&."....
	defb 010h,010h,010h,010h,000h	; 912b

; ======================================================================
; CODIGO 0x9130..0x9223  (243 bytes)
; ======================================================================


tiro_arco:		; Lo que tira el gatito con +8 de 2 o mas: sale desde su cabeza (+0x70, dibujo 0x70, color 15, el efecto A 5) hacia donde mira; avanza 2 puntos por cuadro, sube 20 pasos (la tabla de 0x9223), baja otros tantos y despues cae 3 por cuadro; se rompe contra una casilla solida (menos de 0x80) o al salir de la pantalla
	ld a,(ix+034h)		;9130   ; en marcha?
	and a			;9133
	jr nz,tiro_arco_va		;9134
	inc (ix+034h)		;9136   ; en marcha
	ld a,005h		;9139   ; el efecto A 5
	call efecto_a_pide		;913b
	ld a,(ix+000h)		;913e   ; 8 por encima del gatito
	sub 008h		;9141
	ld (ix+070h),a		;9143
	ld a,(ix+001h)		;9146
	ld (ix+071h),a		;9149
	ld (ix+072h),070h		;914c   ; dibujo 0x70, color 15
	ld (ix+073h),00fh		;9150
	ld a,(ix+017h)		;9154   ; hacia donde mira?
	and a			;9157
	jr nz,tiro_arco_izq		;9158
	ld (ix+035h),000h		;915a
	jr tiro_arco_va		;915e
tiro_arco_izq:
	ld (ix+035h),001h		;9160
tiro_arco_va:
	xor a			;9164   ; el boton, gastado
	ld (0e020h),a		;9165
	ld a,(ix+035h)		;9168   ; a la izquierda?
	and a			;916b
	jp nz,tiro_arco_izq_va		;916c
	ld a,(ix+071h)		;916f   ; en el borde?
	cp 0e8h		;9172
	jp nc,tiro_arco_fuera		;9174
	add a,002h		;9177   ; 2 a la derecha
	ld (ix+071h),a		;9179
tiro_arco_altura:
	ld a,(ix+037h)		;917c   ; subiendo?
	and a			;917f
	jr nz,tiro_arco_baja		;9180
	inc (ix+036h)		;9182   ; un paso mas
	ld a,(ix+036h)		;9185
	cp 014h		;9188   ; 20?
	jr c,tiro_arco_sube		;918a
	inc (ix+037h)		;918c
	jr tiro_arco_baja		;918f
tiro_arco_sube:
	ld hl,09223h		;9191   ; cuanto sube (0x9223)
	add a,l			;9194
	jr nc,L_9198		;9195
	inc h			;9197
L_9198:
	ld l,a			;9198   ; la tabla + el paso
	ld b,(hl)			;9199   ; cuanto
	ld a,(ix+070h)		;919a   ; la Y...
	sub b			;919d   ; ...menos eso
	ld (ix+070h),a		;919e
	jp tiro_arco_dibujo		;91a1
tiro_arco_baja:
	ld a,(ix+037h)		;91a4   ; bajando?
	cp 001h		;91a7
	jr nz,tiro_arco_cae		;91a9
	dec (ix+036h)		;91ab   ; un paso menos
	jr nz,tiro_arco_baja_paso		;91ae
	inc (ix+037h)		;91b0
tiro_arco_baja_paso:
	ld a,(ix+036h)		;91b3
	ld hl,09223h		;91b6
	add a,l			;91b9
	jr nc,tiro_arco_baja_tabla		;91ba
	inc h			;91bc
tiro_arco_baja_tabla:
	ld l,a			;91bd
	ld a,(hl)			;91be
	add a,(ix+070h)		;91bf
	ld (ix+070h),a		;91c2
	jr tiro_arco_mira		;91c5
tiro_arco_cae:
	ld a,(ix+070h)		;91c7   ; cae 3 por cuadro
	add a,003h		;91ca
	ld (ix+070h),a		;91cc
tiro_arco_mira:
	ld a,(ix+070h)		;91cf   ; arriba del todo?
	cp 0e0h		;91d2
	jr nc,tiro_arco_dibujo		;91d4
	cp 0b0h		;91d6   ; abajo del todo?
	jr nc,tiro_arco_fuera		;91d8
	ld hl,0e700h		;91da   ; la casilla de la pantalla de la RAM (0xE700)
	ld a,(ix+070h)		;91dd
	cp 010h		;91e0   ; en el marcador: nada
	jr c,tiro_arco_dibujo		;91e2
	sub 008h		;91e4   ; la fila...
	srl a		;91e6
	srl a		;91e8
	srl a		;91ea
	ld b,a			;91ec
	ld de,00020h		;91ed
tiro_arco_fila:
	add hl,de			;91f0
	djnz tiro_arco_fila		;91f1
	ld a,(ix+071h)		;91f3   ; ...y la columna
	add a,008h		;91f6
	srl a		;91f8
	srl a		;91fa
	srl a		;91fc
	add a,l			;91fe
	ld l,a			;91ff
	ld a,(hl)			;9200   ; la casilla
	cp 080h		;9201   ; solida (menos de 0x80)?
	jr c,tiro_arco_fuera		;9203
tiro_arco_dibujo:
	ld a,(0e012h)		;9205   ; cada 8 cuadros, 0x70 o 0x74
	and 008h		;9208
	rrca			;920a
	add a,070h		;920b
	ld (ix+072h),a		;920d
	ret			;9210
tiro_arco_fuera:
	xor a			;9211
	ld (ix+034h),a		;9212
	ld (ix+036h),a		;9215
	ld (ix+037h),a		;9218
	ld (ix+038h),a		;921b
	ld (ix+070h),0ech		;921e   ; fuera
	ret			;9222

; ----------------------------------------------------------------------
; DATOS tiro_arco_tabla: Cuanto sube lo que tira el gatito en cada uno de los
;   20 pasos
;   0x9223..0x9237  (20 bytes)
DATA_tiro_arco_tabla:
	defb 003h,003h,002h,002h,002h,001h,002h,002h,001h,001h,001h,002h,001h,000h,001h,000h	; 9223  ................
	defb 001h,000h,000h,000h	; 9233

; ======================================================================
; CODIGO 0x9237..0x98e3  (1708 bytes)
; ======================================================================


tiro_arco_izq_va:
	ld a,(ix+071h)		;9237   ; en el borde?
	cp 008h		;923a
	jr c,$-43		;923c
	sub 002h		;923e   ; 2 a la izquierda
	ld (ix+071h),a		;9240
	jp tiro_arco_altura		;9243
tiro:		; El boton 2 (0xE020): con +8 = 1 (lo que lleva), un tiro recto (+0x70, dibujo 0x7C, el efecto A 5) a 5 puntos por cuadro hacia donde mira, que parpadea (0x78 color 9 / 0x7C color 15); con 2 o mas, el tiro en arco (0x9130); sin nada (0), nada; no si esta agachado, salvo que lleve algo encima (+0x1D)
	ld a,(ix+034h)		;9246   ; el tiro en arco en marcha?
	and a			;9249
	jp nz,tiro_arco		;924a
	ld a,(ix+00dh)		;924d   ; el recto en marcha?
	and a			;9250
	jr nz,tiro_va		;9251
	ld a,(0e020h)		;9253   ; el boton 2?
	and a			;9256
	ret z			;9257
	xor a			;9258   ; gastado
	ld (0e020h),a		;9259
	ld a,(ix+01dh)		;925c   ; lleva algo encima?
	and a			;925f
	jr nz,tiro_que		;9260
	ld a,(ix+004h)		;9262   ; agachado: nada
	and a			;9265
	ret nz			;9266
tiro_que:
	ld a,(ix+008h)		;9267   ; que lleva?
	and a			;926a
	ret z			;926b   ; nada
	cp 001h		;926c   ; 1: el recto; si no, en arco
	jp nz,tiro_arco		;926e
	ld (ix+00dh),001h		;9271   ; en marcha
	ld a,005h		;9275   ; el efecto A 5
	call efecto_a_pide		;9277
	ld a,(ix+000h)		;927a   ; a su altura - 8
	sub 008h		;927d
	ld (ix+070h),a		;927f
	ld a,(ix+001h)		;9282
	ld (ix+071h),a		;9285
	ld (ix+073h),00fh		;9288   ; color 15
	ld a,(ix+017h)		;928c   ; hacia donde mira?
	and a			;928f
	jr nz,tiro_izq		;9290
	ld (ix+018h),000h		;9292   ; a la derecha
	ld (ix+072h),07ch		;9296
	jr tiro_va		;929a
tiro_izq:
	ld (ix+018h),001h		;929c
	ld (ix+072h),07ch		;92a0
tiro_va:
	xor a			;92a4
	ld (0e020h),a		;92a5
	ld a,(ix+018h)		;92a8   ; a la izquierda?
	and a			;92ab
	jr nz,tiro_va_izq		;92ac
	ld a,(ix+071h)		;92ae   ; en el borde?
	cp 0e8h		;92b1
	jr nc,tiro_fuera		;92b3
	ld a,(ix+071h)		;92b5   ; 5 a la derecha
	add a,005h		;92b8
	jr tiro_pon		;92ba
tiro_va_izq:
	ld a,(ix+071h)		;92bc
	cp 008h		;92bf
	jr c,tiro_fuera		;92c1
	ld a,(ix+071h)		;92c3   ; 5 a la izquierda
	sub 005h		;92c6
tiro_pon:
	ld (ix+071h),a		;92c8
	ld a,(0e012h)		;92cb   ; cada cuadro, 0x78 color 9...
	and 001h		;92ce
	and a			;92d0
	jr nz,tiro_pon2		;92d1
	ld (ix+072h),078h		;92d3
	ld (ix+073h),009h		;92d7
	ret			;92db
tiro_pon2:
	ld (ix+072h),07ch		;92dc   ; ...o 0x7C color 15
	ld (ix+073h),00fh		;92e0
	ret			;92e4
tiro_fuera:
	ld (ix+070h),0ech		;92e5
	ld (ix+00dh),000h		;92e9
	ld (ix+019h),000h		;92ed
	ret			;92f1
gatito_colores:		; Los parpadeos del gatito: +0x1F (cinco vueltas de 256 cuadros, color 0 / 13, mas deprisa al final), +0x1A (0x20 cuadros, 7 / 15) y +0x1B (0x80 cuadros despues de perder lo que llevaba, 0 / 15)
	ld a,(ix+01fh)		;92f2   ; +0x1F?
	and a			;92f5
	jp z,gatito_colores_1a		;92f6
	inc (ix+01fh)		;92f9   ; la cuenta
	jr nz,gatito_colores_1f		;92fc
	inc (ix+01fh)		;92fe
	inc (ix+01eh)		;9301   ; una vuelta mas
	ld a,(ix+01eh)		;9304
	cp 005h		;9307   ; 5: acabado
	jr z,gatito_colores_1f_fin		;9309
gatito_colores_1f:
	ld a,(ix+01eh)		;930b   ; la ultima: cada 4 cuadros
	cp 004h		;930e
	jr c,gatito_colores_8		;9310
	ld a,(0e012h)		;9312   ; cada 4
	and 004h		;9315
gatito_colores_pon:
	and a			;9317
	jr nz,gatito_colores_13		;9318
	ld (ix+003h),000h		;931a   ; color 0
	jr gatito_colores_1a		;931e
gatito_colores_13:
	ld (ix+003h),00dh		;9320   ; color 13
	jr gatito_colores_1a		;9324
gatito_colores_8:
	ld a,(0e012h)		;9326   ; cada 8
	and 008h		;9329
	jr gatito_colores_pon		;932b
gatito_colores_1f_fin:
	ld (ix+003h),00dh		;932d   ; color 13 y a cero
	ld (ix+01eh),000h		;9331
	ld (ix+01fh),000h		;9335
gatito_colores_1a:
	ld a,(ix+01ah)		;9339   ; +0x1A?
	and a			;933c
	jp z,gatito_colores_1b		;933d
	inc (ix+01ah)		;9340   ; la cuenta
	ld a,(ix+01ah)		;9343
	cp 020h		;9346   ; 0x20?
	jr c,gatito_colores_1a_pon		;9348
	ld (ix+01ah),000h		;934a   ; a cero, color 13
	ld (ix+003h),00dh		;934e
	ret			;9352
gatito_colores_1a_pon:
	ld a,(0e012h)		;9353   ; cada 2 cuadros, 7 o 15
	and 002h		;9356
	and a			;9358
	jr nz,gatito_colores_15		;9359
	ld (ix+003h),007h		;935b
	ret			;935f
gatito_colores_15:
	ld (ix+003h),00fh		;9360
	ret			;9364
gatito_colores_1b:
	ld a,(ix+01bh)		;9365   ; +0x1B?
	and a			;9368
	ret z			;9369
	inc (ix+01bh)		;936a   ; la cuenta
	ld a,(ix+01bh)		;936d
	cp 080h		;9370   ; 0x80?
	jr c,gatito_colores_1b_pon		;9372
	ld (ix+01bh),000h		;9374   ; a cero
gatito_colores_1b_15:
	ld (ix+003h),00fh		;9378   ; color 15
	ret			;937c
gatito_colores_1b_pon:
	ld a,(0e012h)		;937d   ; cada 4 cuadros, 0 o 15
	and 004h		;9380
	and a			;9382
	jr z,gatito_colores_1b_15		;9383
	ld (ix+003h),000h		;9385
	ret			;9389
gatito_gravedad:		; Sin saltar: si debajo de los dos pies no hay suelo (las casillas desde 0x80 dejan pasar), cae (+9 = 1) tres puntos por cuadro hasta una casilla solida, en una fila exacta (Y multiplo de 8); en las escaleras (+0xC: 1 o 2) se mueve con ellas
	ld a,(ix+005h)		;938a   ; saltando?
	and a			;938d
	ret nz			;938e
	ld a,(ix+009h)		;938f   ; cayendo?
	and a			;9392
	jr nz,gatito_cae_va		;9393
gatito_gravedad_mira:
	call casillas_pies		;9395   ; las casillas de debajo (+0x14, +0x15)
	ld a,(ix+014h)		;9398   ; el pie izquierdo libre?
	cp 080h		;939b
	jr c,gatito_suelo		;939d
	ld a,(ix+015h)		;939f   ; y el derecho?
	cp 080h		;93a2
	jr c,gatito_suelo		;93a4
	ld (ix+009h),001h		;93a6   ; cae
	jr gatito_cae_va		;93aa
gatito_suelo:
	ld (ix+00ch),000h		;93ac   ; en el suelo
	ret			;93b0
gatito_cae_va:
	ld a,(ix+00ch)		;93b1   ; 2?
	cp 002h		;93b4
	jr nz,gatito_cae_1		;93b6
	call salto_der		;93b8
	jr gatito_cae_paso		;93bb
gatito_cae_1:
	cp 001h		;93bd
	jr nz,gatito_cae_paso		;93bf
	call salto_izq		;93c1
gatito_cae_paso:
	ld b,003h		;93c4   ; tres puntos
gatito_cae_punto:
	push bc			;93c6
	call casillas_pies		;93c7   ; las casillas de debajo
	ld a,(ix+014h)		;93ca   ; libres?
	cp 080h		;93cd
	jr c,gatito_cae_borde		;93cf
	ld a,(ix+015h)		;93d1
	cp 080h		;93d4
	jr c,gatito_cae_borde		;93d6
gatito_cae_baja:
	inc (ix+000h)		;93d8   ; un punto abajo
	call gatito_sitio		;93db   ; sus sprites
	pop bc			;93de
	djnz gatito_cae_punto		;93df
	ret			;93e1
gatito_cae_borde:
	call casillas_suelo		;93e2   ; las casillas de abajo
	ld a,(ix+014h)		;93e5
	cp 080h		;93e8
	jr c,gatito_cae_baja		;93ea
	ld a,(ix+015h)		;93ec
	cp 080h		;93ef
	jr c,gatito_cae_baja		;93f1
	ld a,(ix+000h)		;93f3   ; en una fila exacta?
	and 007h		;93f6
	and a			;93f8
	jr nz,gatito_cae_baja		;93f9
	pop bc			;93fb
	ld (ix+009h),000h		;93fc   ; en el suelo
	ld (ix+00ch),000h		;9400
	ld a,(ix+007h)		;9404   ; su dibujo
	ld (ix+01ch),a		;9407
	jp gatito_dibujo		;940a
gatito_lados:		; Cada 2 cuadros, segun la palanca: 2-4 a la derecha, 6-8 a la izquierda
	inc (ix+006h)		;940d   ; cada 2 cuadros
	ld a,(ix+006h)		;9410
	cp 002h		;9413
	ret c			;9415
	ld (ix+006h),000h		;9416
	ld a,(0e180h)		;941a   ; la palanca
	cp 002h		;941d
	jp z,gatito_derecha		;941f
	cp 003h		;9422
	jp z,gatito_derecha		;9424
	cp 004h		;9427
	jp z,gatito_derecha		;9429
	cp 006h		;942c
	jp z,gatito_izquierda		;942e
	cp 007h		;9431
	jp z,gatito_izquierda		;9433
	cp 008h		;9436
	jp z,gatito_izquierda		;9438
	ret			;943b
gatito_mueve:		; El gatito segun la palanca (0xE180): de pie y sin caer, 1 nada, 2-4 a la derecha, 5 agacharse, 6-8 a la izquierda; suelta, de pie otra vez; saltando o cayendo, solo de lado cada 2 cuadros
	ld a,(0e186h)		;943c   ; la fase acaba?
	and a			;943f
	ret nz			;9440
	ld a,(ix+005h)		;9441   ; saltando?
	and a			;9444
	jr nz,gatito_lados		;9445
	ld a,(ix+009h)		;9447   ; cayendo?
	and a			;944a
	jr nz,gatito_lados		;944b
	ld a,(0e180h)		;944d   ; la palanca
	and a			;9450
	jr z,gatito_de_pie		;9451
	cp 001h		;9453
	jr z,gatito_arriba		;9455
	cp 002h		;9457
	jp z,gatito_derecha		;9459
	cp 003h		;945c
	jp z,gatito_derecha		;945e
	cp 004h		;9461
	jp z,gatito_derecha		;9463
	cp 005h		;9466
	jp z,gatito_agacha		;9468
	cp 006h		;946b
	jp z,gatito_izquierda		;946d
	cp 007h		;9470
	jp z,gatito_izquierda		;9472
	cp 008h		;9475
	jp z,gatito_izquierda		;9477
gatito_de_pie:
	ld a,(ix+004h)		;947a   ; agachado?
	and a			;947d
	jr z,gatito_quieto		;947e
	ld a,(ix+007h)		;9480   ; su dibujo de antes
	ld (ix+01ch),a		;9483
	call gatito_dibujo		;9486
	ld (ix+004h),000h		;9489   ; de pie
gatito_quieto:
	ld a,(ix+01ch)		;948d   ; el dibujo 8 (andando a la derecha)...
	cp 008h		;9490
	jr nz,gatito_quieto_izq		;9492
	xor a			;9494   ; ...pasa al 0
	ld (ix+01ch),a		;9495
	jp gatito_dibujo		;9498
gatito_quieto_izq:
	cp 088h		;949b   ; y el 0x88...
	ret nz			;949d
	ld a,080h		;949e   ; ...al 0x80
	ld (ix+01ch),a		;94a0
	jp gatito_dibujo		;94a3
gatito_arriba:
	ret			;94a6
gatito_agacha:		; Abajo: agachado (+4 = 1), con el dibujo 0x20 (o 0xA0 mirando a la izquierda)
	ld a,(ix+004h)		;94a7   ; ya agachado?
	and a			;94aa
	ret nz			;94ab
	ld (ix+004h),001h		;94ac
	ld a,(ix+01ch)		;94b0   ; el dibujo de antes, guardado
	ld (ix+007h),a		;94b3
	bit 7,a		;94b6   ; a la izquierda?
	jr nz,gatito_agacha_izq		;94b8
	ld a,020h		;94ba
	jr gatito_agacha_pon		;94bc
gatito_agacha_izq:
	ld a,0a0h		;94be
gatito_agacha_pon:
	ld (ix+01ch),a		;94c0
	jp gatito_dibujo		;94c3
gatito_derecha:		; A la derecha: antes del borde (0xF0), un punto si esta libre; en el borde, la pantalla siguiente (0xE03E + 1): si no hay (0), se queda; con 0xFF, vuelve a la 3
	ld a,(ix+001h)		;94c6   ; en el borde?
	cp 0f0h		;94c9
	jp c,gatito_anda_der		;94cb
gatito_borde:
	ld a,(0e198h)		;94ce   ; ya cambiando?
	and a			;94d1
	ret nz			;94d2
pantalla_siguiente:
	ld hl,0e03eh		;94d3   ; la siguiente...
	inc (hl)			;94d6
	call pantalla_de_fase		;94d7   ; ...si hay
	and a			;94da
	jr nz,pantalla_siguiente_hay		;94db
	ld hl,0e03eh		;94dd   ; no hay: la de antes
	dec (hl)			;94e0
	call pantalla_de_fase		;94e1
	ld a,(0e012h)		;94e4
	jp gatito_dibujo_der		;94e7
pantalla_siguiente_hay:
	cp 0ffh		;94ea   ; 0xFF?
	jr z,pantalla_vuelve		;94ec
	ld (0e03fh),a		;94ee   ; la pantalla
	ld a,001h		;94f1   ; cambiando (0xE198)
	ld (0e198h),a		;94f3
	ret			;94f6
pantalla_vuelve:
	ld a,003h		;94f7   ; vuelve a la 3
	ld (0e03eh),a		;94f9
	jr pantalla_siguiente		;94fc
gatito_izquierda:		; A la izquierda: desde la X 2, un punto si esta libre; en el borde, quieto (no hay pantalla de antes)
	ld a,(ix+001h)		;94fe   ; en el borde?
	cp 002h		;9501
	jp nc,gatito_anda_izq		;9503
gatito_izq_borde:
	ld a,(0e012h)		;9506
	jp gatito_dibujo_izq		;9509
casillas_cuerpo:		; Las dos casillas de la pantalla de la RAM (0xE700) a la altura del gatito (16 mas arriba si lleva algo), en las X + 4 y + 11: en +0x14 y +0x15; fuera de la pantalla, 0x80 (libres)
	ld a,(ix+01dh)		;950c   ; lleva algo?
	and a			;950f
	jr nz,casillas_cuerpo_alto		;9510
	ld a,(ix+000h)		;9512   ; la Y...
	cp 0d0h		;9515   ; ...dentro?
	jr nc,casillas_libres		;9517
	cp 00ch		;9519
	jr c,casillas_libres		;951b
	jr casillas_cuerpo_fila		;951d
casillas_cuerpo_alto:
	ld a,(ix+000h)		;951f   ; la Y
	cp 0d0h		;9522   ; dentro?
	jr nc,casillas_libres		;9524
	cp 01ch		;9526
	jr c,casillas_libres		;9528
	sub 00ch		;952a   ; 12 mas arriba
casillas_cuerpo_fila:
	sub 00ch		;952c   ; la fila
	srl a		;952e
	srl a		;9530
	srl a		;9532
	and a			;9534
	jr z,casillas_cuerpo_fila0		;9535   ; la fila 0?
	ld b,a			;9537
	ld hl,0e700h		;9538   ; la pantalla de la RAM
	ld de,00020h		;953b
casillas_cuerpo_suma:
	add hl,de			;953e   ; una fila
	djnz casillas_cuerpo_suma		;953f
	jr casillas_cuerpo_col		;9541
casillas_cuerpo_fila0:
	ld hl,0e700h		;9543
casillas_cuerpo_col:
	push hl			;9546
	ld a,(ix+001h)		;9547   ; la X + 4
	add a,004h		;954a
	srl a		;954c
	srl a		;954e
	srl a		;9550
	add a,l			;9552
	jr nc,casillas_cuerpo_1		;9553
	inc h			;9555
casillas_cuerpo_1:
	ld l,a			;9556
	ld a,(hl)			;9557   ; la casilla
	ld (ix+014h),a		;9558
	pop hl			;955b
	ld a,(ix+001h)		;955c   ; la X + 11
	add a,00bh		;955f
	srl a		;9561
	srl a		;9563
	srl a		;9565
	add a,l			;9567
	jr nc,casillas_cuerpo_2		;9568
	inc h			;956a
casillas_cuerpo_2:
	ld l,a			;956b
	ld a,(hl)			;956c   ; la casilla
	ld (ix+015h),a		;956d
	ret			;9570
casillas_libres:
	ld (ix+014h),080h		;9571   ; libres
	ld (ix+015h),080h		;9575
	ret			;9579
gatito_anda_der:
	ld (ix+004h),000h		;957a   ; de pie
	call casillas_der		;957e   ; las casillas de delante
	ld a,(ix+014h)		;9581   ; libres?
	cp 080h		;9584
	jr c,gatito_anda_der_no		;9586
	ld a,(ix+015h)		;9588
	cp 080h		;958b
	jr c,gatito_anda_der_no		;958d
	inc (ix+001h)		;958f   ; un punto a la derecha
	call gatito_sitio		;9592   ; sus sprites
	ld a,(ix+001h)		;9595
gatito_dibujo_der:
	ld (ix+017h),000h		;9598   ; mirando a la derecha
	and 004h		;959c   ; su paso: 0 u 8
	rlca			;959e
	ld (ix+01ch),a		;959f
	ld (ix+007h),a		;95a2
	jp gatito_dibujo		;95a5
gatito_anda_der_no:
	ld a,(0e012h)		;95a8
	jr gatito_dibujo_der		;95ab
casillas_der:		; Las dos casillas a la derecha del gatito (X + 12): la de su fila y la de abajo (dos si no esta en una fila exacta), en +0x14 y +0x15
	ld a,(ix+000h)		;95ad
	cp 0d0h		;95b0   ; abajo del todo?
	jp nc,casillas_libres		;95b2
	cp 010h		;95b5   ; arriba del todo?
	jp c,casillas_libres		;95b7
	sub 010h		;95ba   ; la Y - 16...
	srl a		;95bc   ; ...entre 8
	srl a		;95be
	srl a		;95c0
	ld b,a			;95c2
	and a			;95c3
	jr z,casillas_der_fila0		;95c4
	ld hl,0e700h		;95c6   ; la pantalla de la RAM
	ld de,00020h		;95c9
casillas_der_suma:
	add hl,de			;95cc   ; una fila
	djnz casillas_der_suma		;95cd
	jr casillas_der_col		;95cf
casillas_der_fila0:
	ld hl,0e700h		;95d1
casillas_der_col:
	ld a,(ix+001h)		;95d4   ; la X + 12...
	add a,00ch		;95d7
	srl a		;95d9   ; ...entre 8
	srl a		;95db
	srl a		;95dd
	add a,l			;95df
	jr nc,casillas_der_lee		;95e0
	inc h			;95e2
casillas_der_lee:
	ld l,a			;95e3
	ld a,(hl)			;95e4   ; la casilla
	ld (ix+014h),a		;95e5   ; en +0x14
	ld a,(ix+000h)		;95e8   ; en una fila exacta?
	and 007h		;95eb
	and a			;95ed
	jr nz,casillas_der_dos		;95ee
	ld de,00020h		;95f0   ; la de abajo
	add hl,de			;95f3
	ld a,(hl)			;95f4
	ld (ix+015h),a		;95f5   ; en +0x15
	ret			;95f8
casillas_der_dos:
	ld de,00040h		;95f9   ; dos mas abajo
	add hl,de			;95fc
	ld a,(hl)			;95fd
	ld (ix+015h),a		;95fe   ; en +0x15
	ret			;9601
gatito_anda_izq:
	ld (ix+004h),000h		;9602   ; de pie
	call casillas_izq		;9606   ; las casillas de delante
	ld a,(ix+014h)		;9609   ; libres?
	cp 080h		;960c   ; libre?
	jr c,gatito_anda_izq_no		;960e
	ld a,(ix+015h)		;9610   ; y la otra?
	cp 080h		;9613
	jr c,gatito_anda_izq_no		;9615
	dec (ix+001h)		;9617   ; un punto a la izquierda
	call gatito_sitio		;961a   ; sus sprites
	ld a,(ix+001h)		;961d
gatito_dibujo_izq:
	ld (ix+017h),001h		;9620   ; mirando a la izquierda
	and 004h		;9624   ; su paso
	rlca			;9626
	add a,080h		;9627   ; su paso: 0x80 u 0x88
	ld (ix+01ch),a		;9629   ; su dibujo
	ld (ix+007h),a		;962c   ; guardado
	jp gatito_dibujo		;962f
gatito_anda_izq_no:
	ld a,(0e012h)		;9632
	jr gatito_dibujo_izq		;9635
casillas_izq:		; Lo mismo a la izquierda (X + 3)
	ld a,(ix+000h)		;9637
	cp 0d0h		;963a   ; abajo del todo?
	jp nc,casillas_libres		;963c
	cp 010h		;963f   ; arriba del todo?
	jp c,casillas_libres		;9641
	sub 010h		;9644   ; la Y - 16...
	srl a		;9646   ; ...entre 8
	srl a		;9648
	srl a		;964a
	and a			;964c
	jr z,casillas_izq_fila0		;964d
	ld b,a			;964f
	ld hl,0e700h		;9650   ; la pantalla de la RAM
	ld de,00020h		;9653
casillas_izq_suma:
	add hl,de			;9656   ; una fila
	djnz casillas_izq_suma		;9657
	jr casillas_izq_col		;9659
casillas_izq_fila0:
	ld hl,0e700h		;965b
casillas_izq_col:
	ld a,(ix+001h)		;965e   ; la X + 3...
	add a,003h		;9661
	srl a		;9663   ; ...entre 8
	srl a		;9665
	srl a		;9667
	add a,l			;9669
	jr nc,casillas_izq_lee		;966a
	inc h			;966c
casillas_izq_lee:
	ld l,a			;966d
	ld a,(hl)			;966e   ; la casilla
	ld (ix+014h),a		;966f   ; en +0x14
	ld a,(ix+000h)		;9672   ; en una fila exacta?
	and 007h		;9675
	and a			;9677
	jr nz,casillas_izq_dos		;9678
	ld de,00020h		;967a   ; la de abajo
	add hl,de			;967d
	ld a,(hl)			;967e
	ld (ix+015h),a		;967f   ; en +0x15
	ret			;9682
casillas_izq_dos:
	ld de,00040h		;9683   ; dos mas abajo
	add hl,de			;9686
	ld a,(hl)			;9687
	ld (ix+015h),a		;9688   ; en +0x15
	ret			;968b
casillas_pies:		; Las dos casillas debajo de los pies del gatito (X + 4 y + 11) en +0x14 y +0x15
	ld a,(ix+000h)		;968c
	cp 0d0h		;968f   ; abajo del todo?
	jp nc,casillas_libres		;9691
	srl a		;9694   ; la Y / 8
	srl a		;9696
	srl a		;9698
	and a			;969a
	jr nz,casillas_pies_fila		;969b
	ld hl,0e700h		;969d   ; la pantalla de la RAM
	jr casillas_pies_col		;96a0
casillas_pies_fila:
	ld b,a			;96a2
	ld hl,0e700h		;96a3   ; la pantalla de la RAM
	ld de,00020h		;96a6
casillas_pies_suma:
	add hl,de			;96a9   ; una fila
	djnz casillas_pies_suma		;96aa
casillas_pies_col:
	push hl			;96ac
	ld a,(ix+001h)		;96ad   ; la X + 4...
	add a,004h		;96b0
	srl a		;96b2   ; ...entre 8
	srl a		;96b4
	srl a		;96b6
	add a,l			;96b8
	jr nc,casillas_pies_1		;96b9
	inc h			;96bb
casillas_pies_1:
	ld l,a			;96bc
	ld a,(hl)			;96bd   ; la casilla
	ld (ix+014h),a		;96be   ; en +0x14
	pop hl			;96c1
	ld a,(ix+001h)		;96c2   ; la X + 11...
	add a,00bh		;96c5
	srl a		;96c7   ; ...entre 8
	srl a		;96c9
	srl a		;96cb
	add a,l			;96cd
	jr nc,casillas_pies_2		;96ce
	inc h			;96d0
casillas_pies_2:
	ld l,a			;96d1
	ld a,(hl)			;96d2   ; la casilla
	ld (ix+015h),a		;96d3   ; en +0x15
	ret			;96d6
casillas_suelo:		; La casilla de debajo (X + 8, Y - 13) y la de mas abajo, en +0x14 y +0x15
	ld a,(ix+000h)		;96d7
	cp 0d0h		;96da   ; abajo del todo?
	jp nc,casillas_libres		;96dc
	cp 013h		;96df   ; arriba del todo?
	jp c,casillas_libres		;96e1
	sub 00dh		;96e4   ; la Y - 13...
	srl a		;96e6   ; ...entre 8
	srl a		;96e8
	srl a		;96ea
	ld b,a			;96ec
	and a			;96ed
	jr z,casillas_suelo_fila0		;96ee
	ld hl,0e700h		;96f0   ; la pantalla de la RAM
	ld de,00020h		;96f3
casillas_suelo_suma:
	add hl,de			;96f6   ; una fila
	djnz casillas_suelo_suma		;96f7
	jr casillas_suelo_col		;96f9
casillas_suelo_fila0:
	ld hl,0e700h		;96fb
casillas_suelo_col:
	ld a,(ix+001h)		;96fe   ; la X + 8...
	add a,008h		;9701
	srl a		;9703   ; ...entre 8
	srl a		;9705
	srl a		;9707
	add a,l			;9709
	jr nc,casillas_suelo_lee		;970a
	inc h			;970c
casillas_suelo_lee:
	ld l,a			;970d
	ld a,(hl)			;970e   ; la casilla
	ld (ix+014h),a		;970f   ; en +0x14
	ld de,00020h		;9712   ; la de abajo
	add hl,de			;9715
	ld a,(hl)			;9716
	ld (ix+015h),a		;9717   ; en +0x15
	ret			;971a
salto:		; El salto, con el boton 1 (0xE022): de pie, sin agacharse ni caer; el efecto A 6; hacia la derecha (palanca 2 o 3), la izquierda (7 u 8) o recto; sube por la tabla de 0x98E3 mientras se tenga pulsado el boton (si se suelta, deja de subir); las casillas 0x50-0x5F lo paran por arriba; despues baja hasta una casilla solida; a los lados, las 0x40-0x7F lo paran
	ld a,(0e186h)		;971b   ; la fase acaba?
	and a			;971e
	ret nz			;971f
	ld a,(ix+005h)		;9720   ; ya saltando?
	and a			;9723
	jr nz,salto_va		;9724
	ld a,(ix+004h)		;9726   ; agachado?
	and a			;9729
	ret nz			;972a
	ld a,(ix+009h)		;972b   ; cayendo?
	and a			;972e
	ret nz			;972f
	ld a,(0e022h)		;9730   ; el boton 1?
	and a			;9733
	ret z			;9734
	xor a			;9735   ; gastado
	ld (0e022h),a		;9736
	inc (ix+005h)		;9739   ; saltando
	ld a,(ix+01ch)		;973c   ; su dibujo, guardado
	ld (ix+007h),a		;973f
	ld a,006h		;9742   ; el efecto A 6
	call efecto_a_pide		;9744
	ld c,002h		;9747   ; 2: a la derecha...
	ld a,(0e180h)		;9749
	cp 002h		;974c
	jr z,salto_dir		;974e
	cp 003h		;9750
	jr z,salto_dir		;9752
	dec c			;9754   ; 1: a la izquierda...
	cp 008h		;9755
	jr z,salto_dir		;9757
	cp 007h		;9759
	jr z,salto_dir		;975b
	dec c			;975d   ; 0: recto
salto_dir:
	ld (ix+00ah),c		;975e
	ld (ix+00ch),c		;9761
salto_va:
	xor a			;9764
	ld (0e022h),a		;9765
	call salto_lado		;9768   ; de lado
	ld a,(ix+00bh)		;976b   ; bajando?
	and a			;976e
	jp nz,salto_baja		;976f
	ld a,(0e000h)		;9772   ; jugando...
	and a			;9775
	jr z,salto_sube		;9776
	ld a,(0e19dh)		;9778   ; ...y el boton suelto?
	and a			;977b
	jr nz,salto_sube		;977c
	ld (ix+016h),020h		;977e   ; deja de subir
	jr salto_baja_empieza		;9782
salto_sube:
	ld a,(ix+016h)		;9784   ; el final de la tabla?
	cp 020h		;9787
	jr z,salto_baja_empieza		;9789
	ld hl,098e3h		;978b   ; cuanto sube (0x98E3)
	ld a,(ix+016h)		;978e
	inc (ix+016h)		;9791   ; el paso siguiente
	add a,l			;9794
	jr nc,L_9798		;9795
	inc h			;9797
L_9798:
	ld l,a			;9798
	ld a,(hl)			;9799
	and a			;979a
	jp z,salto_fin		;979b
	ld b,a			;979e
salto_sube_punto:
	push bc			;979f
	call casillas_cuerpo		;97a0   ; las casillas de encima
	ld a,(ix+014h)		;97a3   ; 0x50-0x5F: un techo
	cp 050h		;97a6
	jr c,salto_sube_der		;97a8
	cp 060h		;97aa
	jr c,salto_techo		;97ac
salto_sube_der:
	ld a,(ix+015h)		;97ae
	cp 050h		;97b1
	jr c,salto_sube_uno		;97b3
	cp 060h		;97b5
	jr c,salto_techo		;97b7
salto_sube_uno:
	dec (ix+000h)		;97b9   ; un punto arriba
	call gatito_sitio		;97bc
	pop bc			;97bf
	djnz salto_sube_punto		;97c0
	jp salto_fin		;97c2
salto_techo:
	pop bc			;97c5
	ld a,(ix+016h)		;97c6   ; al empezar: no salta
	and a			;97c9
	jr nz,salto_baja_empieza		;97ca
	ld (ix+005h),000h		;97cc
	ld (ix+00ah),000h		;97d0
	ret			;97d4
salto_baja_empieza:
	ld (ix+00bh),001h		;97d5   ; a bajar
salto_baja:
	ld a,(ix+016h)		;97d9   ; el final?
	and a			;97dc
	jr z,salto_acaba		;97dd
	dec (ix+016h)		;97df   ; un paso menos
	ld hl,098e3h		;97e2
	ld a,(ix+016h)		;97e5
	add a,l			;97e8
	jr nc,salto_baja_tabla		;97e9
	inc h			;97eb
salto_baja_tabla:
	ld l,a			;97ec
	ld a,(hl)			;97ed
	and a			;97ee
	jp z,salto_fin		;97ef
	ld b,a			;97f2
salto_baja_punto:
	push bc			;97f3
	call casillas_pies		;97f4   ; las casillas de debajo
	ld a,(ix+014h)		;97f7
	cp 080h		;97fa
	jr c,salto_suelo_mira		;97fc
	ld a,(ix+015h)		;97fe
	cp 080h		;9801
	jr c,salto_suelo_mira		;9803
salto_baja_uno:
	inc (ix+000h)		;9805   ; un punto abajo
	call gatito_sitio		;9808
	pop bc			;980b
	djnz salto_baja_punto		;980c
	jr salto_fin		;980e
salto_suelo_mira:
	ld a,(ix+000h)		;9810   ; en una fila exacta?
	and 007h		;9813   ; en una fila exacta?
	and a			;9815
	jr nz,salto_baja_uno		;9816
	call casillas_suelo		;9818   ; las casillas de debajo
	ld a,(ix+014h)		;981b
	cp 080h		;981e   ; libre?
	jr c,salto_baja_uno		;9820
	ld a,(ix+015h)		;9822   ; y la otra?
	cp 080h		;9825
	jr c,salto_baja_uno		;9827
	jr salto_suelo		;9829
salto_acaba:
	ld (ix+00bh),000h		;982b   ; de pie
	ld (ix+00ah),000h		;982f
	ld (ix+005h),000h		;9833
	ld (ix+016h),000h		;9837
	ld a,(ix+007h)		;983b
	ld (ix+01ch),a		;983e
	call gatito_dibujo		;9841
	jp gatito_gravedad_mira		;9844   ; a caer
salto_suelo:
	pop bc			;9847
	ld (ix+00bh),000h		;9848   ; en el suelo
	ld (ix+00ah),000h		;984c
	ld (ix+005h),000h		;9850
	ld (ix+016h),000h		;9854
	ld (ix+00ch),000h		;9858
	ld a,(ix+007h)		;985c
	ld (ix+01ch),a		;985f
	jp gatito_dibujo		;9862
salto_fin:
	ret			;9865
salto_lado:		; De lado en el salto: recto, el dibujo 8 (0x88 a la izquierda); a la derecha, un punto si las casillas 0x40-0x7F no lo paran (en el borde, la pantalla siguiente), dibujo 0x18; a la izquierda, lo mismo, 0x98
	ld a,(ix+00ah)		;9866   ; recto?
	and a			;9869
	jr nz,salto_lado_va		;986a
	ld a,(ix+017h)		;986c   ; a la izquierda?
	and a			;986f
	jr nz,salto_lado_dibujo_izq		;9870
	ld a,008h		;9872
salto_lado_dibujo:
	ld (ix+01ch),a		;9874
	jp gatito_dibujo		;9877
salto_lado_dibujo_izq:
	ld a,088h		;987a
	jr salto_lado_dibujo		;987c
salto_lado_va:
	cp 002h		;987e
	jr nz,salto_izq		;9880
salto_der:
	call casillas_der		;9882   ; las casillas de delante
	ld a,(ix+014h)		;9885
	cp 040h		;9888   ; 0x40-0x7F: pared
	jr c,salto_der_2		;988a
	cp 080h		;988c
	jr c,salto_pared		;988e
salto_der_2:
	ld a,(ix+015h)		;9890
	cp 040h		;9893
	jr c,salto_der_paso		;9895
	cp 080h		;9897
	jr c,salto_pared		;9899
salto_der_paso:
	ld a,(ix+001h)		;989b   ; en el borde: la pantalla siguiente
	cp 0f0h		;989e
	jp z,gatito_borde		;98a0
	inc (ix+001h)		;98a3   ; un punto
	ld a,018h		;98a6
	ld (ix+01ch),a		;98a8
	jp gatito_dibujo		;98ab
salto_pared:
	ld (ix+00ah),000h		;98ae
	ld (ix+00ch),000h		;98b2
	ret			;98b6
salto_izq:
	call casillas_izq		;98b7   ; las casillas de delante
	ld a,(ix+014h)		;98ba
	cp 040h		;98bd
	jr c,salto_izq_2		;98bf
	cp 080h		;98c1
	jr c,salto_pared		;98c3
salto_izq_2:
	ld a,(ix+015h)		;98c5
	cp 040h		;98c8
	jr c,salto_izq_paso		;98ca
	cp 080h		;98cc
	jr c,salto_pared		;98ce
salto_izq_paso:
	ld a,(ix+001h)		;98d0   ; en el borde?
	cp 000h		;98d3
	jp z,gatito_izq_borde		;98d5
	dec (ix+001h)		;98d8   ; un punto
	ld a,098h		;98db
	ld (ix+01ch),a		;98dd
	jp gatito_dibujo		;98e0

; ----------------------------------------------------------------------
; DATOS salto_tabla: Cuanto sube el gatito en cada paso del salto (36), y
;   cuanto baja, al reves
;   0x98e3..0x9907  (36 bytes)
DATA_salto_tabla:
	defb 003h,003h,003h,003h,003h,002h,003h,002h,002h,003h,002h,002h,002h,002h,002h,002h	; 98e3  ................
	defb 001h,002h,002h,001h,002h,001h,001h,002h,001h,001h,001h,000h,001h,000h,000h,001h	; 98f3  ................
	defb 000h,000h,000h,000h	; 9903

; ======================================================================
; CODIGO 0x9907..0x9976  (111 bytes)
; ======================================================================


gatito_dibujo:		; Los sprites del gatito con su dibujo (+0x1C): dos (el segundo, 8 mas abajo); llevando algo encima (+0x1D), tres: lo que lleva (0x40, 0x28 o 0x34, segun este agachado, andando o de pie; +0x80 mirando a la izquierda) 16 por encima
	ld a,(ix+01dh)		;9907   ; lleva algo?
	and a			;990a
	jr nz,gatito_lleva		;990b
	ld a,(ix+01ch)		;990d   ; el dibujo
	ld (ix+002h),a		;9910
	add a,004h		;9913   ; el segundo, 4 mas
	ld (ix+012h),a		;9915
	jr gatito_sitio_2		;9918
gatito_sitio:		; Los sitios de sus sprites
	ld a,(ix+01dh)		;991a
	and a			;991d
	jr nz,gatito_lleva		;991e
gatito_sitio_2:
	ld a,(ix+000h)		;9920   ; el segundo, 8 mas abajo
	add a,008h		;9923
	ld (ix+010h),a		;9925
	ld a,(ix+001h)		;9928
	ld (ix+011h),a		;992b
	ld (ix+020h),0ech		;992e   ; el tercero, fuera
	ret			;9932
gatito_lleva:		; Con algo encima: tres sprites
	ld a,(ix+000h)		;9933
	ld (ix+010h),a		;9936
	sub 010h		;9939   ; lo que lleva, 16 por encima
	ld (ix+020h),a		;993b
	ld (ix+023h),00fh		;993e   ; color 15
	ld a,(ix+001h)		;9942
	ld (ix+011h),a		;9945
	ld (ix+021h),a		;9948
	ld a,(ix+01ch)		;994b   ; el dibujo, sin el lado
	and 07fh		;994e
	cp 020h		;9950   ; agachado?
	jr nz,gatito_lleva_anda		;9952
	ld b,040h		;9954   ; 0x40
	jr gatito_lleva_pon		;9956
gatito_lleva_anda:
	cp 008h		;9958   ; andando?
	jr nz,gatito_lleva_pie		;995a
	ld b,028h		;995c   ; 0x28
	jr gatito_lleva_pon		;995e
gatito_lleva_pie:
	ld b,034h		;9960   ; de pie: 0x34
gatito_lleva_pon:
	ld a,(ix+01ch)		;9962   ; + el lado
	and 080h		;9965
	add a,b			;9967
	ld (ix+022h),a		;9968
	add a,004h		;996b
	ld (ix+002h),a		;996d
	add a,004h		;9970
	ld (ix+012h),a		;9972
	ret			;9975

; ----------------------------------------------------------------------
; DATOS byte_9976: Un "ret" (0xC9) suelto detras de otro
;   0x9976..0x9977  (1 bytes)
DATA_byte_9976:
	defb 0c9h	; 9976

; ======================================================================
; CODIGO 0x9977..0x9caa  (819 bytes)
; ======================================================================


pantalla_cambia:		; El cambio de pantalla (0xE198: 1, a la siguiente; 2, a la de antes): los objetos fuera, la RAM 0xE9C0 (0x580 bytes) a 0x80; la pantalla de ahora y la nueva lado a lado en la RAM (0xE9C0, filas de 0x40) y, cada 2 cuadros, 32 veces, la ventana se corre una columna y el gatito 8 puntos hacia atras; al final, la nueva en 0xE700
	ld a,(0e198h)		;9977   ; cambiando?
	and a			;997a
	ret z			;997b
	call ram_e400_borra		;997c   ; los objetos de 0xE400...
	call objetos_e380_fuera		;997f   ; ...y los de 0xE380 fuera
	ld (ix+070h),0ech		;9982   ; el tiro fuera
	ld (ix+00dh),000h		;9986
	ld (ix+034h),000h		;998a
	ld (ix+003h),00fh		;998e
	call sprites_ram		;9992   ; los sprites
	call sprites_vram_tabla		;9995
	ld a,(0e198h)		;9998   ; hacia donde
	ld d,a			;999b
	ld hl,0e9c0h		;999c   ; 0xE9C0...
	ld bc,00580h		;999f   ; ...0x580 bytes...
L_99A2:
	ld (hl),080h		;99a2   ; ...a 0x80
	inc hl			;99a4
	dec bc			;99a5
	ld a,c			;99a6
	or b			;99a7
	jr nz,L_99A2		;99a8
	xor a			;99aa   ; acabado: 0xE198 y las cuentas a 0
	ld (0e198h),a		;99ab
	ld (0e19bh),a		;99ae
	ld (0e1bah),a		;99b1
	ld (0e1bbh),a		;99b4
	ld a,d			;99b7   ; a la siguiente?
	cp 001h		;99b8
	jp nz,pantalla_cambia_atras		;99ba
	ld hl,0e700h		;99bd   ; la de ahora a la izquierda (0xE9C0)
	ld de,0e9c0h		;99c0
	call pantalla_a_doble		;99c3
	call escena_pon		;99c6   ; la nueva
	ld hl,0e700h		;99c9   ; a la derecha (0xE9E0)
	ld de,0e9e0h		;99cc
	call pantalla_a_doble		;99cf
	ld hl,0e9c1h		;99d2   ; la ventana: desde la columna 1
	ld (0e195h),hl		;99d5
	ld hl,01840h		;99d8   ; a la fila 2 de la VRAM
	ld (0e193h),hl		;99db
	xor a			;99de
	ld (0e010h),a		;99df
	ld b,020h		;99e2   ; 32 pasos
pantalla_cambia_paso:
	ld a,(0e010h)		;99e4   ; 2 cuadros
	cp 002h		;99e7
	jr c,pantalla_cambia_paso		;99e9
	xor a			;99eb
	ld (0e010h),a		;99ec
	ld hl,(0e195h)		;99ef
	ld (0e191h),hl		;99f2
	ld c,016h		;99f5   ; 22 filas
pantalla_cambia_fila:
	push bc			;99f7
	ld hl,(0e191h)		;99f8
	ld de,(0e193h)		;99fb
	ld bc,00020h		;99ff
	call 0005ch		;9a02   ; LDIRVM
	ld hl,(0e191h)		;9a05
	ld de,00040h		;9a08   ; la fila siguiente de la RAM (0x40)
	add hl,de			;9a0b
	ld (0e191h),hl		;9a0c
	ld hl,(0e193h)		;9a0f
	ld de,00020h		;9a12   ; la de la VRAM
	add hl,de			;9a15
	ld (0e193h),hl		;9a16
	pop bc			;9a19
	dec c			;9a1a
	jr nz,pantalla_cambia_fila		;9a1b
	push bc			;9a1d
	ld hl,(0e195h)		;9a1e   ; la ventana, una columna mas
	inc hl			;9a21
	ld (0e195h),hl		;9a22
	ld hl,01840h		;9a25
	ld (0e193h),hl		;9a28
	ld a,(ix+001h)		;9a2b   ; el gatito, 8 a la izquierda (14 como poco)
	cp 008h		;9a2e
	jr nc,pantalla_cambia_gatito		;9a30
	ld a,00eh		;9a32
pantalla_cambia_gatito:
	sub 008h		;9a34
	ld (ix+001h),a		;9a36
	call gatito_sitio		;9a39
	call sprites_vram		;9a3c
	pop bc			;9a3f
	djnz pantalla_cambia_paso		;9a40
	ld hl,0e9e0h		;9a42   ; la nueva, a 0xE700
	ld de,0e700h		;9a45
	ld b,016h		;9a48
pantalla_cambia_copia:
	push bc			;9a4a   ; la fila
	ld bc,00020h		;9a4b   ; 32 casillas
	ldir		;9a4e   ; copiadas
	pop bc			;9a50
	push de			;9a51
	ld de,00020h		;9a52   ; se salta la otra mitad
	add hl,de			;9a55
	pop de			;9a56
	djnz pantalla_cambia_copia		;9a57   ; 22 filas
	ret			;9a59
pantalla_cambia_atras:		; Lo mismo hacia la izquierda
	ld hl,0e700h		;9a5a   ; la de ahora
	ld de,0e9e0h		;9a5d   ; a la derecha (0xE9E0)
	call pantalla_a_doble		;9a60
	call escena_pon		;9a63   ; la nueva
	ld hl,0e700h		;9a66
	ld de,0e9c0h		;9a69   ; a la izquierda (0xE9C0)
	call pantalla_a_doble		;9a6c
	ld hl,0e9dfh		;9a6f   ; la ventana: desde la columna 31
	ld (0e195h),hl		;9a72
	ld hl,01840h		;9a75   ; a la fila 2
	ld (0e193h),hl		;9a78
	xor a			;9a7b
	ld (0e010h),a		;9a7c   ; la cuenta a 0
	ld b,020h		;9a7f   ; 32 pasos
pantalla_cambia_atras_paso:
	ld a,(0e010h)		;9a81
	cp 002h		;9a84   ; 2 cuadros?
	jr c,pantalla_cambia_atras_paso		;9a86
	xor a			;9a88
	ld (0e010h),a		;9a89   ; la cuenta a 0
	ld hl,(0e195h)		;9a8c
	ld (0e191h),hl		;9a8f
	ld c,016h		;9a92   ; 22 filas
pantalla_cambia_atras_fila:
	push bc			;9a94
	ld hl,(0e191h)		;9a95
	ld de,(0e193h)		;9a98
	ld bc,00020h		;9a9c
	call 0005ch		;9a9f   ; LDIRVM
	ld hl,(0e191h)		;9aa2
	ld de,00040h		;9aa5   ; la fila siguiente de la RAM
	add hl,de			;9aa8
	ld (0e191h),hl		;9aa9
	ld hl,(0e193h)		;9aac
	ld de,00020h		;9aaf   ; la de la VRAM
	add hl,de			;9ab2
	ld (0e193h),hl		;9ab3
	pop bc			;9ab6
	dec c			;9ab7   ; una fila menos
	jr nz,pantalla_cambia_atras_fila		;9ab8
	push bc			;9aba
	ld hl,(0e195h)		;9abb
	dec hl			;9abe   ; la ventana, una columna atras
	ld (0e195h),hl		;9abf
	ld hl,01840h		;9ac2
	ld (0e193h),hl		;9ac5
	ld a,(ix+001h)		;9ac8   ; el gatito...
	cp 0e8h		;9acb
	jr nc,pantalla_cambia_atras_sigue		;9acd
	add a,008h		;9acf   ; ...8 a la derecha
	ld (ix+001h),a		;9ad1
	call gatito_sitio		;9ad4   ; sus sprites
	call sprites_vram		;9ad7   ; a la VRAM
pantalla_cambia_atras_sigue:
	pop bc			;9ada
	djnz pantalla_cambia_atras_paso		;9adb   ; 32 pasos
	ld hl,0e9c0h		;9add   ; la nueva...
	ld de,0e700h		;9ae0   ; ...a 0xE700
	ld b,016h		;9ae3   ; 22 filas
pantalla_cambia_atras_copia:
	push bc			;9ae5
	ld bc,00020h		;9ae6   ; 32 casillas
	ldir		;9ae9
	pop bc			;9aeb
	push de			;9aec
	ld de,00020h		;9aed   ; se salta la otra mitad
	add hl,de			;9af0
	pop de			;9af1
	djnz pantalla_cambia_atras_copia		;9af2
	ret			;9af4
pantalla_a_doble:		; 22 filas de 32 de HL a DE, con filas de 0x40
	ld (0e193h),de		;9af5
	ld b,016h		;9af9
pantalla_a_doble_fila:
	push bc			;9afb   ; la fila
	ld de,(0e193h)		;9afc   ; su sitio
	ld bc,00020h		;9b00   ; 32 casillas
	ldir		;9b03   ; copiadas
	push hl			;9b05
	ld hl,(0e193h)		;9b06   ; la fila siguiente (0x40)
	ld de,00040h		;9b09
	add hl,de			;9b0c
	ld (0e193h),hl		;9b0d
	pop hl			;9b10
	pop bc			;9b11
	djnz pantalla_a_doble_fila		;9b12   ; 22 filas
	ret			;9b14
escena_pon:		; La pantalla 0xE03F en 0xE700: su puntero de la tabla de 0x4114; el primer byte llena el fondo; si el segundo es 0, el suelo (siete filas de 0xAD97 en 0xE8E0); despues tres listas hasta 0xFF: tiras de casillas (la fila, la columna, cuantas y la pieza de 0xAD85; con 0xFE, rectangulos de dos casillas alternas), rectangulos de una casilla y dibujos
	ld hl,0e700h		;9b15   ; 0x280 casillas a 0x80
	ld bc,00280h		;9b18
escena_borra:
	ld (hl),080h		;9b1b
	inc hl			;9b1d
	dec bc			;9b1e
	ld a,c			;9b1f
	or b			;9b20
	jr nz,escena_borra		;9b21
	ld a,(0e03fh)		;9b23   ; la pantalla...
	ld hl,04114h		;9b26   ; ...su puntero (0x4114)
	add a,a			;9b29
	add a,l			;9b2a
	jr nc,escena_puntero		;9b2b
	inc h			;9b2d
escena_puntero:
	ld l,a			;9b2e
	ld e,(hl)			;9b2f
	inc hl			;9b30
	ld d,(hl)			;9b31
	ld a,(de)			;9b32   ; el fondo
	ld (0e1a0h),a		;9b33
	inc de			;9b36
	ld hl,0e700h		;9b37   ; 0x2C0 casillas...
	ld bc,002c0h		;9b3a
escena_fondo:
	ld a,(0e1a0h)		;9b3d
	ld (hl),a			;9b40
	inc hl			;9b41
	dec bc			;9b42
	ld a,c			;9b43
	or b			;9b44
	jr nz,escena_fondo		;9b45
	ld a,(de)			;9b47   ; con suelo?
	inc de			;9b48
	and a			;9b49
	jr nz,escena_tiras		;9b4a
	push de			;9b4c
	ld de,0e8e0h		;9b4d   ; cuatro filas de suelo...
	ld b,004h		;9b50
	call suelo_filas		;9b52
	ld de,0e960h		;9b55   ; ...y tres
	ld b,003h		;9b58
	call suelo_filas		;9b5a
	pop de			;9b5d
escena_tiras:
	ld a,(de)			;9b5e   ; 0xFF: a los rectangulos
	cp 0ffh		;9b5f
	jp z,escena_rect1_empieza		;9b61
	cp 0feh		;9b64   ; 0xFE: los de dos casillas
	jp z,escena_rect2		;9b66
	call escena_sitio		;9b69   ; su sitio
	ld a,(de)			;9b6c   ; cuantas
	ld b,a			;9b6d
	inc de			;9b6e
	ld a,(de)			;9b6f   ; la pieza
	inc de			;9b70
	ld (0e1a1h),a		;9b71
	add a,a			;9b74
	push de			;9b75
	ld de,0ad85h		;9b76   ; la tabla de piezas (0xAD85)
	add a,e			;9b79
	jr nc,escena_pieza		;9b7a
	inc d			;9b7c
escena_pieza:
	ld e,a			;9b7d   ; la pieza
	push hl			;9b7e
	ld a,(de)			;9b7f   ; su puntero
	ld l,a			;9b80
	inc de			;9b81
	ld a,(de)			;9b82
	ld h,a			;9b83
	ex de,hl			;9b84
	pop hl			;9b85
escena_tira_casilla:
	ld a,(de)			;9b86   ; una casilla
	ld (hl),a			;9b87   ; puesta
	inc hl			;9b88
	inc de			;9b89
	djnz escena_tira_casilla		;9b8a   ; tantas
	pop de			;9b8c
	jr escena_tiras		;9b8d   ; la siguiente tira
escena_rect2:
	inc de			;9b8f
escena_rect2_uno:
	ld a,(de)			;9b90
	cp 0ffh		;9b91
	jp z,escena_rect1_empieza		;9b93
	call escena_sitio		;9b96
	ld a,(de)			;9b99   ; el ancho
	ld (0e1a0h),a		;9b9a   ; apuntado
	inc de			;9b9d
	ld a,(de)			;9b9e   ; el alto
	inc de			;9b9f
	ld b,a			;9ba0   ; las filas
	ld (0e1a1h),hl		;9ba1   ; su sitio
	ld a,(de)			;9ba4   ; la casilla
	ld (0e1a4h),a		;9ba5   ; apuntada
	inc de			;9ba8
	xor a			;9ba9
	ld (0e1a3h),a		;9baa   ; la primera fila, par
trozo_rect2_fila:
	ld hl,(0e1a1h)		;9bad   ; su sitio
	ld a,(0e1a0h)		;9bb0   ; el ancho
	ld c,a			;9bb3
	ld a,(0e1a3h)		;9bb4   ; fila par o impar?
	and a			;9bb7
	jr nz,trozo_rect2_impar		;9bb8
	cpl			;9bba   ; la siguiente, impar
	ld (0e1a3h),a		;9bbb
trozo_rect2_par:
	ld a,(0e1a4h)		;9bbe   ; N y N+1
	ld (hl),a			;9bc1   ; N
	inc hl			;9bc2   ; la siguiente
	dec c			;9bc3
	jr z,trozo_rect2_sigue		;9bc4
	ld a,(0e1a4h)		;9bc6   ; N + 1
	inc a			;9bc9
	ld (hl),a			;9bca
	inc hl			;9bcb   ; la siguiente
	dec c			;9bcc
	jr nz,trozo_rect2_par		;9bcd   ; la fila entera
	jr trozo_rect2_sigue		;9bcf
trozo_rect2_impar:
	cpl			;9bd1   ; la siguiente, par
	ld (0e1a3h),a		;9bd2
trozo_rect2_impar_par:
	ld a,(0e1a4h)		;9bd5   ; N+2 y N+3
	add a,002h		;9bd8   ; N + 2
	ld (hl),a			;9bda
	inc hl			;9bdb   ; la siguiente
	dec c			;9bdc
	jr z,trozo_rect2_sigue		;9bdd
	ld a,(0e1a4h)		;9bdf   ; N + 3
	add a,003h		;9be2
	ld (hl),a			;9be4
	inc hl			;9be5   ; la siguiente
	dec c			;9be6
	jr nz,trozo_rect2_impar_par		;9be7   ; la fila entera
	jr trozo_rect2_sigue		;9be9
trozo_rect2_sigue:
	ld hl,(0e1a1h)		;9beb   ; la fila siguiente
	push de			;9bee
	ld de,00020h		;9bef   ; una fila abajo
	add hl,de			;9bf2
	pop de			;9bf3
	ld (0e1a1h),hl		;9bf4
	djnz trozo_rect2_fila		;9bf7   ; una fila menos
	jr escena_rect2_uno		;9bf9   ; el siguiente
escena_rect1_empieza:
	inc de			;9bfb
escena_rect1:
	ld a,(de)			;9bfc
	cp 0ffh		;9bfd
	jr z,escena_dibujos_empieza		;9bff
	call escena_sitio		;9c01
	ld (0e1a2h),hl		;9c04   ; apuntado
	ld a,(de)			;9c07   ; el ancho
	ld (0e1a0h),a		;9c08
	inc de			;9c0b
	ld a,(de)			;9c0c   ; el alto
	ld b,a			;9c0d   ; las filas
	inc de			;9c0e
	ld a,(de)			;9c0f   ; la casilla
	ld (0e1a1h),a		;9c10   ; apuntada
	inc de			;9c13
trozo_rect1_fila:
	ld a,(0e1a0h)		;9c14   ; el ancho
	ld c,a			;9c17
trozo_rect1_casilla:
	ld a,(0e1a1h)		;9c18   ; la casilla
	ld (hl),a			;9c1b   ; puesta
	inc hl			;9c1c   ; la siguiente
	dec c			;9c1d
	jr nz,trozo_rect1_casilla		;9c1e   ; la fila entera
	push de			;9c20
	ld de,00020h		;9c21   ; una fila abajo
	ld hl,(0e1a2h)		;9c24
	add hl,de			;9c27
	ld (0e1a2h),hl		;9c28
	pop de			;9c2b
	djnz trozo_rect1_fila		;9c2c   ; una fila menos
	jr escena_rect1		;9c2e   ; el siguiente
escena_dibujos_empieza:
	inc de			;9c30
escena_dibujos:
	ld a,(de)			;9c31   ; 0xFF: el final
	cp 0ffh		;9c32
	jp z,escena_fin		;9c34
	call escena_sitio		;9c37   ; su sitio
	ld a,(de)			;9c3a   ; el puntero del dibujo
	ld c,a			;9c3b
	inc de			;9c3c
	ld a,(de)			;9c3d
	ld b,a			;9c3e
	inc de			;9c3f
	push de			;9c40
	ld e,c			;9c41
	ld d,b			;9c42
	call dibujo_pon		;9c43
	pop de			;9c46
	jr escena_dibujos		;9c47
dibujo_pon:		; Un dibujo de casillas (ancho, alto y las casillas) en HL (filas de 32)
	ld a,(de)			;9c49   ; el ancho
	ld (0e1a0h),a		;9c4a   ; apuntado
	inc de			;9c4d
	ld a,(de)			;9c4e   ; el alto
	ld b,a			;9c4f   ; las filas
	inc de			;9c50
dibujo_fila:
	ld a,(0e1a0h)		;9c51   ; el ancho
	ld c,a			;9c54
	push hl			;9c55   ; su principio
dibujo_casilla:
	ld a,(de)			;9c56   ; una casilla
	ld (hl),a			;9c57   ; en el mapa
	inc de			;9c58
	inc hl			;9c59
	dec c			;9c5a   ; una menos
	jr nz,dibujo_casilla		;9c5b   ; la fila entera
	pop hl			;9c5d   ; la fila
	push de			;9c5e
	ld de,00020h		;9c5f   ; la fila siguiente
	add hl,de			;9c62
	pop de			;9c63
	djnz dibujo_fila		;9c64   ; una fila menos
	ret			;9c66
escena_fin:
	ret			;9c67
escena_sitio:		; HL = 0xE700 + la fila (A) x 32 + la columna (DE+1)
	ld hl,0e700h		;9c68
	and a			;9c6b   ; la fila 0?
	jr z,trozo_sitio_col		;9c6c
	ld b,a			;9c6e   ; las filas
	push de			;9c6f
	ld de,00020h		;9c70   ; x 32
trozo_sitio_fila:
	add hl,de			;9c73
	djnz trozo_sitio_fila		;9c74
	pop de			;9c76
trozo_sitio_col:
	inc de			;9c77   ; la columna
	ld a,(de)			;9c78   ; + la columna
	add a,l			;9c79
	jr nc,L_9C7D		;9c7a
	inc h			;9c7c
L_9C7D:
	ld l,a			;9c7d
	inc de			;9c7e
	ret			;9c7f   ; DE, al dato siguiente
pantalla_de_fase:		; La pantalla que toca (0xE03F): de la tabla de 0x4038 (la fase 0xE03D x 2) y la posicion 0xE03E
	ld a,(0e03dh)		;9c80   ; la fase...
	add a,a			;9c83
	ld hl,04038h		;9c84   ; ...su lista (0x4038)
	add a,l			;9c87
	jr nc,pantalla_de_fase_lista		;9c88
	inc h			;9c8a
pantalla_de_fase_lista:
	ld l,a			;9c8b
	ld e,(hl)			;9c8c
	inc hl			;9c8d
	ld d,(hl)			;9c8e
	ex de,hl			;9c8f
	ld a,(0e03eh)		;9c90   ; + la posicion
	add a,l			;9c93
	jr nc,pantalla_de_fase_lee		;9c94
	inc h			;9c96
pantalla_de_fase_lee:
	ld l,a			;9c97
	ld a,(hl)			;9c98   ; la pantalla
	ld (0e03fh),a		;9c99
	ret			;9c9c
suelo_filas:		; B filas de 32 casillas del suelo (0xAD97) en DE
	ld hl,0ad97h		;9c9d
suelo_fila:
	push bc			;9ca0   ; una fila
	ld bc,00020h		;9ca1   ; 32 casillas
	ldir		;9ca4   ; copiadas
	pop bc			;9ca6
	djnz suelo_fila		;9ca7   ; B filas
	ret			;9ca9

; ----------------------------------------------------------------------
; DATOS codigo_suelto_9CAA: Seis bytes que nadie lee: el principio de
;   pantalla_objetos otra vez
;   0x9caa..0x9cb0  (6 bytes)
DATA_codigo_suelto_9CAA:
	defb 03fh,0e0h,021h,000h,0b0h,087h	; 9caa

; ======================================================================
; CODIGO 0x9cb0..0x9d2b  (123 bytes)
; ======================================================================


pantalla_objetos:		; Una vez por pantalla (0xE19B): sus enemigos y objetos, de la tabla de 0xB000 (la pantalla x 2): hasta 0xFF, la Y, la X y el tipo de cada enemigo en 0xE380 (16 bytes cada uno); hasta 0xFF, cuatro bytes de cada objeto en 0xE400
	ld a,(0e19bh)		;9cb0   ; ya puestos?
	and a			;9cb3
	ret nz			;9cb4
	inc a			;9cb5
	ld (0e19bh),a		;9cb6
	ld a,(0e03fh)		;9cb9   ; la pantalla...
	ld hl,0b000h		;9cbc   ; ...su lista (0xB000)
	add a,a			;9cbf
	add a,l			;9cc0
	jr nc,L_9CC4		;9cc1
	inc h			;9cc3
L_9CC4:
	ld l,a			;9cc4
	ld e,(hl)			;9cc5
	inc hl			;9cc6
	ld d,(hl)			;9cc7
	ld hl,0e380h		;9cc8   ; los enemigos
pantalla_enemigo:
	ld a,(de)			;9ccb   ; 0xFF?
	cp 0ffh		;9ccc
	jr z,pantalla_objetos_2		;9cce
	ld (hl),a			;9cd0   ; la Y
	inc hl			;9cd1
	inc de			;9cd2
	ld a,(de)			;9cd3
	ld (hl),a			;9cd4   ; la X
	inc hl			;9cd5
	inc hl			;9cd6
	inc hl			;9cd7
	inc de			;9cd8
	ld a,(de)			;9cd9
	ld (hl),a			;9cda   ; el tipo (+4)
	push de			;9cdb
	ld de,0000ch		;9cdc   ; el siguiente
	add hl,de			;9cdf
	pop de			;9ce0
	inc de			;9ce1
	jr pantalla_enemigo		;9ce2
pantalla_objetos_2:
	inc de			;9ce4
	ld hl,0e400h		;9ce5   ; los objetos
pantalla_objeto:
	ld a,(de)			;9ce8   ; 0xFF?
	cp 0ffh		;9ce9
	ret z			;9ceb
	ld (hl),a			;9cec   ; cuatro bytes
	inc hl			;9ced
	inc de			;9cee
	ld a,(de)			;9cef
	ld (hl),a			;9cf0
	inc hl			;9cf1
	inc de			;9cf2
	ld a,(de)			;9cf3
	ld (hl),a			;9cf4
	inc hl			;9cf5
	inc de			;9cf6
	ld a,(de)			;9cf7
	ld (hl),a			;9cf8
	inc de			;9cf9
	push de			;9cfa
	ld de,0000dh		;9cfb   ; el siguiente
	add hl,de			;9cfe
	pop de			;9cff
	jr pantalla_objeto		;9d00
objetos_e400:		; Los 12 objetos de 0xE400 (16 bytes; +2 el tipo): los que tienen tipo van a su rutina por la tabla de 0x9D2B
	ld iy,0e400h		;9d02
	ld b,00ch		;9d06   ; 12
objetos_e400_otro:
	push bc			;9d08
	ld a,(iy+002h)		;9d09   ; tipo?
	and a			;9d0c   ; tiene tipo?
	jr nz,objetos_e400_uno		;9d0d
objetos_e400_sigue:
	ld de,00010h		;9d0f   ; el siguiente: + 16
	add iy,de		;9d12
	pop bc			;9d14
	djnz objetos_e400_otro		;9d15
	ret			;9d17
objetos_e400_uno:
	call objetos_e400_salta		;9d18   ; su rutina
	jr objetos_e400_sigue		;9d1b
objetos_e400_salta:		; Salta a la rutina del tipo A (0x9D2B)
	ld hl,09d2bh		;9d1d
	add a,a			;9d20
	add a,l			;9d21
	jr nc,objetos_e400_lee		;9d22
	inc h			;9d24
objetos_e400_lee:
	ld l,a			;9d25   ; la direccion
	ld e,(hl)			;9d26
	inc hl			;9d27
	ld d,(hl)			;9d28
	ex de,hl			;9d29
	jp (hl)			;9d2a   ; salta

; ----------------------------------------------------------------------
; DATOS tabla_9d2b: Las rutinas de los 6 tipos de 0x9D1D
;   0x9d2b..0x9d37  (12 bytes)
DATA_tabla_9d2b:
	defb 0c9h,09dh,0c9h,09dh,052h,09eh,07ch,09eh,088h,09fh,04ah,0a0h	; 9d2b  ....R.|...J.

; ======================================================================
; CODIGO 0x9d37..0x9db7  (128 bytes)
; ======================================================================


objeto_borra:		; Los 16 bytes del objeto IY a cero
	push iy		;9d37
	pop hl			;9d39
	ld b,010h		;9d3a
objeto_borra_byte:
	ld (hl),000h		;9d3c
	inc hl			;9d3e
	djnz objeto_borra_byte		;9d3f
	ret			;9d41
objeto_sitio:		; El sitio del objeto IY en la tabla de nombres: 0x1800 + (Y / 8 + 1) x 32 + X / 8
	ld a,(iy+000h)		;9d42   ; la Y / 8
	srl a		;9d45
	srl a		;9d47
	srl a		;9d49
	ld b,a			;9d4b
	ld hl,01800h		;9d4c   ; la tabla de nombres, una fila mas
	ld de,00020h		;9d4f
objeto_sitio_fila:
	add hl,de			;9d52
	djnz objeto_sitio_fila		;9d53
	ld a,(iy+001h)		;9d55   ; + la X / 8
	srl a		;9d58
	srl a		;9d5a
	srl a		;9d5c
	add a,l			;9d5e
	jr nc,objeto_sitio_col		;9d5f
	inc h			;9d61
objeto_sitio_col:
	ld l,a			;9d62
	ret			;9d63
dibujo_vram:		; Un dibujo (ancho, alto y las casillas, en DE) en la tabla de nombres desde HL
	ld (0e1a0h),hl		;9d64   ; el sitio
	ld a,(de)			;9d67   ; el ancho
	ld (0e1a2h),a		;9d68
	inc de			;9d6b
	ld a,(de)			;9d6c   ; el alto
	ld b,a			;9d6d
	inc de			;9d6e
dibujo_vram_fila:
	ld a,(0e1a2h)		;9d6f   ; el ancho
	ld c,a			;9d72
	ld hl,(0e1a0h)		;9d73
dibujo_vram_casilla:
	ld a,(de)			;9d76   ; una casilla
	call 0004dh		;9d77   ; WRTVRM
	inc de			;9d7a   ; la siguiente
	inc hl			;9d7b
	dec c			;9d7c   ; una menos
	jr nz,dibujo_vram_casilla		;9d7d
	ld hl,(0e1a0h)		;9d7f   ; la fila...
	push de			;9d82
	ld de,00020h		;9d83   ; ...siguiente
	add hl,de			;9d86
	ld (0e1a0h),hl		;9d87
	pop de			;9d8a
	djnz dibujo_vram_fila		;9d8b   ; una fila menos
	ret			;9d8d
enemigos:		; Los 8 enemigos de 0xE380 (16 bytes; +4 el tipo): cada uno a su rutina por la tabla de 0x9DB7
	ld iy,0e380h		;9d8e
	ld b,008h		;9d92   ; ocho
otros_uno:
	push bc			;9d94   ; la cuenta
	ld a,(iy+004h)		;9d95   ; esta?
	and a			;9d98
	jr nz,otros_mueve		;9d99
otros_sig:
	ld de,00010h		;9d9b   ; el siguiente: + 16
	add iy,de		;9d9e
	pop bc			;9da0
	djnz otros_uno		;9da1
	ret			;9da3
otros_mueve:
	call enemigos_salta		;9da4   ; se mueve
	jr otros_sig		;9da7
enemigos_salta:		; Salta a la rutina del tipo A (0x9DB7)
	ld hl,09db7h		;9da9
	add a,a			;9dac
	add a,l			;9dad
	jr nc,enemigos_lee		;9dae
	inc h			;9db0
enemigos_lee:
	ld l,a			;9db1   ; la direccion
	ld e,(hl)			;9db2
	inc hl			;9db3
	ld d,(hl)			;9db4
	ex de,hl			;9db5
	jp (hl)			;9db6   ; salta

; ----------------------------------------------------------------------
; DATOS tabla_9db7: Las rutinas de los 9 tipos de 0x9DA9
;   0x9db7..0x9dc9  (18 bytes)
DATA_tabla_9db7:
	defb 0e5h,0a0h,0e5h,0a0h,0f6h,0a1h,039h,0a3h,0e3h,0a3h,097h,0a4h,022h,0a6h,0bdh,0a6h	; 9db7  ......9....."...
	defb 013h,0a8h	; 9dc7

; ======================================================================
; CODIGO 0x9dc9..0x9e0a  (65 bytes)
; ======================================================================


objeto_tiro1:		; Los tipos 0 y 1: lo que se tira en recto (las casillas 0x6C-0x6F, 0x9E0A); al cogerlo, +8 = 1, el efecto A 4 y se borra (0x9E10 o 0x9E16, segun el fondo)
	ld a,(iy+005h)		;9dc9   ; pintado?
	and a			;9dcc
	jr nz,objeto_tiro1_coge		;9dcd
	inc (iy+005h)		;9dcf
	call objeto_sitio		;9dd2   ; su sitio
	ld de,09e0ah		;9dd5   ; su dibujo
	call dibujo_vram		;9dd8
	ret			;9ddb
objeto_tiro1_coge:
	ld bc,004fch		;9ddc   ; cerca?
	call cerca_gatito		;9ddf
	ret nc			;9de2
	ld bc,004fch		;9de3
	call cerca_x		;9de6
	ret nc			;9de9
	ld (ix+008h),001h		;9dea   ; +8 = 1
	ld a,004h		;9dee   ; el efecto A 4
objeto_coge:
	call efecto_a_pide		;9df0   ; pide el efecto
	call objeto_sitio		;9df3   ; su sitio
	ld a,(iy+003h)		;9df6   ; el fondo
	and a			;9df9
	jr nz,objeto_coge_82		;9dfa
	ld de,09e10h		;9dfc   ; 0x81
	jr objeto_coge_borra		;9dff
objeto_coge_82:
	ld de,09e16h		;9e01   ; 0x82
objeto_coge_borra:
	call dibujo_vram		;9e04
	jp objeto_borra		;9e07   ; fuera

; ----------------------------------------------------------------------
; DATOS objetos_dibujos: Los dibujos de los objetos, de 2 x 2 casillas: lo que
;   se tira en recto (0x9E0A), los dos fondos que los borran (0x9E10, 0x9E16),
;   lo que se tira en arco (0x9E1C), los premios (0x9E22, 0x9E28, 0x9E3A,
;   0x9E40) y los obstaculos (0x9E2E, 0x9E34, 0x9E46, 0x9E4C)
;   0x9e0a..0x9e52  (72 bytes)
DATA_objetos_dibujos:
	defb 002h,002h,06ch,06dh,06eh,06fh,002h,002h,081h,081h,081h,081h,002h,002h,082h,082h	; 9e0a  ..lmno..........
	defb 082h,082h,002h,002h,068h,069h,06ah,06bh,002h,002h,078h,079h,07ah,07bh,002h,002h	; 9e1a  ....hijk..xyz{..
	defb 07ch,07dh,07eh,07fh,002h,002h,074h,075h,076h,077h,002h,002h,070h,071h,072h,073h	; 9e2a  |}~...tuvw..pqrs
	defb 002h,002h,0a8h,0a9h,0aah,0abh,002h,002h,0ach,0adh,0aeh,0afh,002h,002h,0a4h,0a5h	; 9e3a  ................
	defb 0a6h,0a7h,002h,002h,0a0h,0a1h,0a2h,0a3h	; 9e4a  ........

; ======================================================================
; CODIGO 0x9e52..0xa604  (1970 bytes)
; ======================================================================


objeto_tiro2:		; El tipo 2: lo que se tira en arco (0x68-0x6B, 0x9E1C); al cogerlo, +8 = 2
	ld a,(iy+005h)		;9e52   ; pintado?
	and a			;9e55
	jr nz,objeto_tiro2_coge		;9e56
	inc (iy+005h)		;9e58   ; pintado
	call objeto_sitio		;9e5b   ; su sitio
	ld de,09e1ch		;9e5e   ; su dibujo
	call dibujo_vram		;9e61
	ret			;9e64
objeto_tiro2_coge:
	ld bc,004fch		;9e65   ; cerca en Y?
	call cerca_gatito		;9e68
	ret nc			;9e6b
	ld bc,004fch		;9e6c   ; y en X?
	call cerca_x		;9e6f
	ret nc			;9e72
	ld (ix+008h),002h		;9e73   ; +8 = 2: en arco
	ld a,004h		;9e77   ; el efecto A 4
	jp objeto_coge		;9e79   ; cogido
premio:		; El tipo 3, un premio (+3): 0, 100 puntos; 1, 500; 2, 1.000; 3, 2.000 (en pantalla); +0x80, con el otro fondo; el 4 (o 0x84) es el 3 (0x83) y ademas da una vida y la musica 5; el 2 y el 3 estan escondidos: salen cuando les da lo que tira el gatito en arco
	ld a,(iy+005h)		;9e7c   ; pintado?
	and a			;9e7f
	jr nz,premio_mira		;9e80
	ld a,(iy+003h)		;9e82   ; el 4?
	cp 004h		;9e85
	jr nz,premio_84		;9e87
	ld (iy+003h),003h		;9e89   ; el 3 con una vida
	ld (iy+007h),001h		;9e8d
	jr premio_pinta		;9e91
premio_84:
	cp 084h		;9e93
	jr nz,premio_pinta		;9e95
	ld (iy+003h),083h		;9e97
	ld (iy+007h),001h		;9e9b
premio_pinta:
	call objeto_sitio		;9e9f
	ld a,(iy+003h)		;9ea2   ; cual?
	and a			;9ea5
	jr nz,premio_pinta1		;9ea6
	ld de,09e22h		;9ea8   ; el 0
	jr premio_pinta_va		;9eab
premio_pinta1:
	cp 001h		;9ead
	jr nz,premio_pinta80		;9eaf
	ld de,09e28h		;9eb1
	jr premio_pinta_va		;9eb4
premio_pinta80:
	cp 080h		;9eb6
	jr nz,premio_pinta81		;9eb8
	ld de,09e3ah		;9eba
	jr premio_pinta_va		;9ebd
premio_pinta81:
	cp 081h		;9ebf
	jr nz,premio_pintado		;9ec1
	ld de,09e40h		;9ec3
premio_pinta_va:
	call dibujo_vram		;9ec6
premio_pintado:
	inc (iy+005h)		;9ec9
	ret			;9ecc
premio_mira:
	ld a,(iy+003h)		;9ecd   ; los escondidos (2, 3, 0x82, 0x83)...
	cp 002h		;9ed0
	jr c,premio_coge		;9ed2
	cp 004h		;9ed4
	jr c,premio_escondido		;9ed6
	cp 082h		;9ed8
	jr nc,premio_escondido		;9eda
premio_coge:
	ld bc,004fch		;9edc   ; cerca?
	call cerca_gatito		;9edf
	ret nc			;9ee2
	ld bc,004fch		;9ee3
	call cerca_x		;9ee6
	ret nc			;9ee9
	call objeto_sitio		;9eea   ; borrado
	ld a,(iy+003h)		;9eed
	bit 7,a		;9ef0
	jr nz,premio_coge_82		;9ef2
	ld de,09e10h		;9ef4
	jr premio_coge_borra		;9ef7
premio_coge_82:
	ld de,09e16h		;9ef9
premio_coge_borra:
	call dibujo_vram		;9efc
	ld a,(iy+003h)		;9eff   ; cual?
	res 7,a		;9f02
	and a			;9f04
	jr nz,premio_coge1		;9f05
	ld a,010h		;9f07   ; el 0: 100 puntos
	jr premio_puntos		;9f09
premio_coge1:
	cp 001h		;9f0b
	jr nz,premio_coge2		;9f0d
	ld a,050h		;9f0f   ; el 1: 500
premio_puntos:
	call puntos_suma		;9f11
	ld a,003h		;9f14   ; el efecto A 3
	call efecto_a_pide		;9f16
premio_vida:
	ld a,(iy+007h)		;9f19   ; con una vida?
	and a			;9f1c
	jp z,objeto_borra		;9f1d
	call vida_mas		;9f20   ; una vida mas
	ld a,005h		;9f23   ; la musica 5
	call musica_pide		;9f25
	jp objeto_borra		;9f28
premio_coge2:
	cp 002h		;9f2b   ; el 2: 1.000
	jr nz,premio_coge3		;9f2d
	ld a,001h		;9f2f
	jr premio_cien		;9f31
premio_coge3:
	ld a,002h		;9f33   ; el 3: 2.000
premio_cien:
	call puntos_suma_cien		;9f35
	ld a,003h		;9f38
	call efecto_a_pide		;9f3a
	jr premio_vida		;9f3d
premio_escondido:
	ld a,(iy+008h)		;9f3f   ; ya a la vista?
	and a			;9f42
	jr nz,premio_coge		;9f43
	ld a,(ix+034h)		;9f45   ; el tiro en arco en marcha?
	and a			;9f48
	ret z			;9f49
	ld bc,003fdh		;9f4a   ; le da?
	call cerca_y2		;9f4d
	ret nc			;9f50
	ld bc,003fdh		;9f51
	call cerca_x2		;9f54
	ret nc			;9f57
	call objeto_sitio		;9f58   ; se ve
	ld a,(iy+003h)		;9f5b
	cp 002h		;9f5e
	jr nz,premio_escondido_3		;9f60
	ld de,09e22h		;9f62
	jr premio_escondido_pinta		;9f65
premio_escondido_3:
	cp 003h		;9f67
	jr nz,premio_escondido_82		;9f69
	ld de,09e28h		;9f6b
	jr premio_escondido_pinta		;9f6e
premio_escondido_82:
	cp 082h		;9f70
	jr nz,premio_escondido_83		;9f72
	ld de,09e3ah		;9f74
	jr premio_escondido_pinta		;9f77
premio_escondido_83:
	ld de,09e40h		;9f79
premio_escondido_pinta:
	call dibujo_vram		;9f7c
	inc (iy+008h)		;9f7f   ; a la vista
	ld a,003h		;9f82
	call efecto_a_pide		;9f84
	ret			;9f87
obstaculo:		; El tipo 4, un obstaculo (+3, cuatro dibujos): tocarlo entero mata al gatito (0xE183 = 1); cuatro tiros en arco lo rompen (el efecto A 3) y entonces se coge: 400 o 600 puntos (en pantalla)
	ld a,(iy+005h)		;9f88   ; pintado?
	and a			;9f8b
	jr nz,obstaculo_mira		;9f8c
	call objeto_sitio		;9f8e
	ld a,(iy+003h)		;9f91
	and a			;9f94
	jr nz,obstaculo_1		;9f95
	ld de,09e2eh		;9f97
	jr obstaculo_pinta		;9f9a
obstaculo_1:
	cp 001h		;9f9c
	jr nz,obstaculo_2		;9f9e
	ld de,09e34h		;9fa0
	jr obstaculo_pinta		;9fa3
obstaculo_2:
	cp 002h		;9fa5
	jr nz,obstaculo_3		;9fa7
	ld de,09e46h		;9fa9
	jr obstaculo_pinta		;9fac
obstaculo_3:
	ld de,09e4ch		;9fae
obstaculo_pinta:
	call dibujo_vram		;9fb1
	inc (iy+005h)		;9fb4
	ret			;9fb7
obstaculo_mira:
	ld a,(iy+003h)		;9fb8   ; ya roto?
	res 1,a		;9fbb
	and a			;9fbd
	jr nz,obstaculo_toca		;9fbe
	ld a,(ix+034h)		;9fc0   ; el tiro en arco?
	and a			;9fc3
	jr z,obstaculo_toca		;9fc4
	ld bc,00cfah		;9fc6   ; le da?
	call cerca_y2		;9fc9
	jr nc,obstaculo_toca		;9fcc
	ld bc,007fch		;9fce
	call cerca_x2		;9fd1
	jr nc,obstaculo_toca		;9fd4
	call objeto_sitio		;9fd6
	call tiro_arco_fuera		;9fd9   ; el tiro fuera
	inc (iy+006h)		;9fdc   ; uno mas
	ld a,(iy+006h)		;9fdf
	cp 004h		;9fe2   ; 4?
	jr c,obstaculo_toca		;9fe4
	ld a,(iy+003h)		;9fe6   ; roto
	bit 1,a		;9fe9
	jr nz,obstaculo_roto2		;9feb
	ld de,09e34h		;9fed
	jr obstaculo_roto		;9ff0
obstaculo_roto2:
	ld de,09e4ch		;9ff2
obstaculo_roto:
	call dibujo_vram		;9ff5
	ld a,003h		;9ff8
	call efecto_a_pide		;9ffa
	set 0,(iy+003h)		;9ffd   ; roto (el bit 0)
obstaculo_toca:
	ld bc,006fch		;a001   ; cerca?
	call cerca_gatito		;a004
	ret nc			;a007
	ld bc,006fch		;a008
	call cerca_x		;a00b
	ret nc			;a00e
	ld a,(iy+003h)		;a00f   ; entero?
	res 1,a		;a012
	and a			;a014
	jr nz,obstaculo_coge		;a015
	ld a,001h		;a017   ; el gatito tocado
	ld (0e183h),a		;a019
	ret			;a01c
obstaculo_coge:
	call objeto_sitio		;a01d   ; su sitio
	ld a,(iy+003h)		;a020   ; el fondo?
	bit 1,a		;a023
	jr nz,obstaculo_coge2		;a025
	ld de,09e10h		;a027   ; 0x81
	jr obstaculo_coge_borra		;a02a
obstaculo_coge2:
	ld de,09e16h		;a02c   ; 0x82
obstaculo_coge_borra:
	call dibujo_vram		;a02f   ; borrado
	ld a,(iy+003h)		;a032   ; roto?
	bit 0,a		;a035
	jr z,obstaculo_coge_400		;a037
	ld a,060h		;a039   ; 600 puntos
	jr obstaculo_puntos		;a03b
obstaculo_coge_400:
	ld a,040h		;a03d   ; 400
obstaculo_puntos:
	call puntos_suma		;a03f
	ld a,003h		;a042
	call efecto_a_pide		;a044
	jp objeto_borra		;a047
nada:		; El tipo 5: nada
	ret			;a04a
enemigo_casillas:		; Las casillas de la pantalla de la RAM alrededor del enemigo IY: a sus lados (+0xE, +0xF; fuera de la pantalla, 0x80) y debajo (+0xC, +0xD)
	ld a,(iy+000h)		;a04b
	sub 001h		;a04e   ; la Y - 1...
	srl a		;a050   ; ...entre 8
	srl a		;a052
	srl a		;a054
	ld b,a			;a056
	ld hl,0e700h		;a057   ; la pantalla de la RAM
	ld de,00020h		;a05a
enemigo_casillas_fila:
	add hl,de			;a05d   ; una fila
	djnz enemigo_casillas_fila		;a05e
	push hl			;a060
	ld a,(iy+001h)		;a061   ; la X
	cp 008h		;a064   ; en el borde?
	jr c,enemigo_casillas_fuera		;a066
	cp 0e8h		;a068
	jr nc,enemigo_casillas_fuera		;a06a
	sub 002h		;a06c   ; la X - 2...
	srl a		;a06e   ; ...entre 8
	srl a		;a070
	srl a		;a072
	add a,l			;a074
	ld l,a			;a075
	ld a,(hl)			;a076   ; la casilla de la izquierda
	ld (iy+00eh),a		;a077   ; en +0xE
	ld a,(iy+001h)		;a07a   ; la X + 14...
	add a,00eh		;a07d
	srl a		;a07f
	srl a		;a081
	srl a		;a083
	pop hl			;a085
	add a,l			;a086
	ld l,a			;a087
	ld a,(hl)			;a088   ; la de la derecha
	ld (iy+00fh),a		;a089   ; en +0xF
enemigo_casillas_debajo:
	ld hl,0e700h		;a08c   ; debajo
	ld a,(iy+000h)		;a08f   ; la Y...
	srl a		;a092   ; ...entre 8
	srl a		;a094
	srl a		;a096
	ld b,a			;a098
enemigo_casillas_debajo_fila:
	add hl,de			;a099
	djnz enemigo_casillas_debajo_fila		;a09a
	ld a,(iy+001h)		;a09c   ; la X...
	srl a		;a09f   ; ...entre 8
	srl a		;a0a1
	srl a		;a0a3
	add a,l			;a0a5
	ld l,a			;a0a6
	ld a,(hl)			;a0a7   ; la casilla de debajo
	ld (iy+00ch),a		;a0a8   ; en +0xC
	inc hl			;a0ab
	ld a,(hl)			;a0ac   ; la siguiente
	ld (iy+00dh),a		;a0ad   ; en +0xD
	ret			;a0b0
enemigo_casillas_fuera:
	pop hl			;a0b1
	ld (iy+00eh),080h		;a0b2   ; libres
	ld (iy+00fh),080h		;a0b6
	jr enemigo_casillas_debajo		;a0ba
explosion:		; La explosion (+0xA su cuenta): 0x20 cuadros con los dibujos 0xF8 / 0xFC cada 4 y el color 15 / 9 cada 8; despues, fuera
	inc (iy+00ah)		;a0bc
	ld a,(iy+00ah)		;a0bf
	cp 020h		;a0c2
	jr c,explosion_dibujo		;a0c4
	jp otro_borra		;a0c6
explosion_dibujo:
	ld a,(0e012h)		;a0c9   ; cada 4 cuadros...
	and 004h		;a0cc
	add a,0f8h		;a0ce   ; ...0xF8 o 0xFC
	ld (iy+002h),a		;a0d0
	ld a,(0e012h)		;a0d3   ; cada 8...
	and 008h		;a0d6
	and a			;a0d8
	jr nz,explosion_color9		;a0d9
	ld (iy+003h),00fh		;a0db   ; ...color 15...
	ret			;a0df
explosion_color9:
	ld (iy+003h),009h		;a0e0   ; ...o 9
	ret			;a0e4
andarin:		; Los tipos 0 y 1: anda por el suelo (dibujo 0x68, color 15; 13 en la escena 4) un punto cada 5 cuadros, da la vuelta en los bordes y las paredes y cae si no hay suelo (fuera por abajo); solo uno a la vez baja de su plataforma (0xE1BA); si toca al gatito, tocado; el tiro en arco lo derrota: 50 puntos (en pantalla) y la explosion
	ld a,(iy+005h)		;a0e5   ; al salir...
	and a			;a0e8
	jr nz,andarin_va		;a0e9
	ld (iy+002h),078h		;a0eb   ; ...dibujo 0x68, color 15
	ld (iy+003h),00fh		;a0ef
	inc (iy+005h)		;a0f3
	ld a,(0e04ah)		;a0f6   ; la escena 4?
	cp 004h		;a0f9
	ret nz			;a0fb
	ld (iy+003h),00dh		;a0fc   ; color 13
	ret			;a100
andarin_va:
	cp 005h		;a101   ; 5: la explosion
	jr z,explosion		;a103
	inc (iy+006h)		;a105   ; cada 5 cuadros
	ld a,(iy+006h)		;a108
	cp 005h		;a10b
	jp c,andarin_dibujo		;a10d
	ld (iy+006h),000h		;a110
	call enemigo_casillas		;a114   ; las casillas de alrededor
	ld a,(iy+007h)		;a117   ; a la derecha?
	and a			;a11a
	jr nz,andarin_der		;a11b
	ld a,(iy+001h)		;a11d   ; en el borde?
	cp 008h		;a120
	jr c,andarin_vuelta		;a122
	ld a,(iy+00eh)		;a124   ; pared?
	cp 080h		;a127
	jr c,andarin_vuelta		;a129
	ld a,(iy+008h)		;a12b   ; ya puede bajar?
	and a			;a12e
	jr nz,andarin_izq		;a12f
	ld a,(0e1bah)		;a131   ; otro bajando?
	and a			;a134
	jr nz,andarin_borde		;a135
	inc a			;a137   ; este
	ld (0e1bah),a		;a138
	ld (iy+008h),a		;a13b
	jr andarin_izq		;a13e
andarin_borde:
	ld a,(iy+00ch)		;a140   ; sin suelo delante: da la vuelta
	cp 080h		;a143
	jr nc,andarin_vuelta		;a145
andarin_izq:
	dec (iy+001h)		;a147   ; un punto a la izquierda
	jr andarin_cae		;a14a
andarin_vuelta:
	ld a,(iy+007h)		;a14c   ; da la vuelta
	cpl			;a14f
	ld (iy+007h),a		;a150
	jr andarin_cae		;a153
andarin_der:
	ld a,(iy+001h)		;a155   ; en el borde?
	cp 0e8h		;a158
	jr nc,andarin_vuelta		;a15a
	ld a,(iy+00fh)		;a15c   ; pared?
	cp 080h		;a15f
	jr c,andarin_vuelta		;a161
	ld a,(iy+008h)		;a163   ; ya puede bajar?
	and a			;a166
	jr nz,andarin_der_paso		;a167
	ld a,(0e1bah)		;a169   ; otro bajando?
	and a			;a16c
	jr nz,andarin_borde_der		;a16d
	inc a			;a16f   ; este
	ld (0e1bah),a		;a170
	ld (iy+008h),a		;a173
	jr andarin_der_paso		;a176
andarin_borde_der:
	ld a,(iy+00dh)		;a178
	cp 080h		;a17b
	jr nc,andarin_vuelta		;a17d
andarin_der_paso:
	inc (iy+001h)		;a17f   ; un punto a la derecha
andarin_cae:
	ld a,(iy+00ch)		;a182   ; sin suelo...
	cp 080h		;a185
	jr c,andarin_dibujo		;a187
	ld a,(iy+00dh)		;a189
	cp 080h		;a18c
	jr c,andarin_dibujo		;a18e
	inc (iy+000h)		;a190   ; ...cae dos puntos
	inc (iy+000h)		;a193
	ld a,(iy+000h)		;a196   ; abajo del todo?
	cp 0b0h		;a199
	jr c,andarin_dibujo		;a19b
	xor a			;a19d   ; fuera
	ld (0e1bah),a		;a19e
	jp otro_borra		;a1a1
andarin_dibujo:
	ld a,(0e012h)		;a1a4   ; cada 16 cuadros, su paso
	and 010h		;a1a7
	rrca			;a1a9
	rrca			;a1aa
	ld b,a			;a1ab   ; y su lado
	ld a,(iy+007h)		;a1ac
	cpl			;a1af
	and 080h		;a1b0
	add a,b			;a1b2
	add a,068h		;a1b3
	ld (iy+002h),a		;a1b5
	ld bc,005f6h		;a1b8   ; toca al gatito?
	call cerca_gatito		;a1bb
	jr nc,andarin_tiro		;a1be
	ld bc,00af6h		;a1c0
	call cerca_x		;a1c3
	jr nc,andarin_tiro		;a1c6
	ld a,001h		;a1c8   ; tocado
	ld (0e183h),a		;a1ca
	ret			;a1cd
andarin_tiro:
	ld a,(ix+034h)		;a1ce   ; el tiro en arco?
	and a			;a1d1
	ret z			;a1d2
	ld bc,00af6h		;a1d3   ; le da?
	call cerca_y2		;a1d6
	ret nc			;a1d9
	ld bc,00af6h		;a1da
	call cerca_x2		;a1dd
	ret nc			;a1e0
	call tiro_arco_fuera		;a1e1   ; el tiro fuera
	ld a,005h		;a1e4   ; la explosion y 5 puntos (50 en pantalla)
	ld (iy+005h),a		;a1e6
	call puntos_suma		;a1e9
	xor a			;a1ec
	ld (0e1bah),a		;a1ed
	ld a,002h		;a1f0   ; el efecto A 2
	call efecto_a_pide		;a1f2
	ret			;a1f5
aparece:		; El tipo 2: aparece en su sitio al cabo de 0x30-0x6F cuadros, parpadeando (dibujo 0xF0, color 9 / 11) los ultimos 0x28; despues va hacia el lado del gatito, cae si no hay suelo, y desaparece en los bordes o abajo; vuelve a salir en su sitio; si toca al gatito, tocado; cualquier tiro lo derrota: 100 puntos (en pantalla); solo uno a la vez (0xE1BB)
	ld a,(iy+005h)		;a1f6   ; al salir...
	and a			;a1f9
	jr nz,aparece_va		;a1fa
	ld a,r		;a1fc   ; ...la espera al azar
	and 03fh		;a1fe
	add a,030h		;a200
	ld (iy+006h),a		;a202
	inc (iy+005h)		;a205
	ld (iy+002h),0f0h		;a208   ; dibujo 0xF0, color 9
	ld (iy+003h),009h		;a20c
	ld a,(iy+00ah)		;a210   ; su sitio, guardado?
	and a			;a213
	jr nz,aparece_sitio		;a214
	ld a,(iy+000h)		;a216   ; la primera vez, se guarda
	ld (iy+00ah),a		;a219
	ld a,(iy+001h)		;a21c
	ld (iy+00bh),a		;a21f
	ret			;a222
aparece_sitio:
	ld (iy+000h),a		;a223   ; si no, vuelve a el
	ld a,(iy+00bh)		;a226
	ld (iy+001h),a		;a229
	ret			;a22c
aparece_va:
	cp 003h		;a22d   ; 3: desaparecido
	jp z,aparece_vuelve		;a22f
	ld a,(iy+008h)		;a232   ; su turno?
	and a			;a235
	jr nz,aparece_espera		;a236
	ld a,(0e1bbh)		;a238   ; otro en marcha?
	and a			;a23b
	ret nz			;a23c
	inc a			;a23d
	ld (0e1bbh),a		;a23e
	ld (iy+008h),a		;a241
aparece_espera:
	ld a,(iy+005h)		;a244
	cp 001h		;a247   ; esperando?
	jr nz,aparece_anda		;a249
	dec (iy+006h)		;a24b   ; la cuenta
	jr nz,aparece_parpadea		;a24e
	inc (iy+005h)		;a250   ; sale
	ld (iy+003h),009h		;a253
	ld a,(ix+001h)		;a257   ; hacia el gatito
	cp (iy+001h)		;a25a
	jr c,aparece_izq		;a25d
	ld (iy+007h),0ffh		;a25f
	ret			;a263
aparece_izq:
	ld (iy+007h),000h		;a264
	ret			;a268
aparece_parpadea:
	ld a,(iy+006h)		;a269   ; los ultimos 0x28 cuadros...
	cp 028h		;a26c
	ret nc			;a26e
	ld a,(0e012h)		;a26f   ; ...color 9 u 11
	and 002h		;a272
	add a,009h		;a274
	ld (iy+003h),a		;a276
	ret			;a279
aparece_anda:
	call enemigo_casillas		;a27a   ; las casillas
	ld a,(iy+00ch)		;a27d   ; sin suelo: cae
	cp 080h		;a280
	jr c,aparece_lados		;a282
	ld a,(iy+00dh)		;a284
	cp 080h		;a287
	jr c,aparece_lados		;a289
	inc (iy+000h)		;a28b
	inc (iy+000h)		;a28e
	ld a,(iy+000h)		;a291
	cp 0b0h		;a294
	jr c,aparece_dibujo		;a296
	jr aparece_fuera		;a298
aparece_lados:
	ld a,(iy+007h)		;a29a   ; a la izquierda?
	and a			;a29d
	jr nz,aparece_der		;a29e
	ld a,(iy+001h)		;a2a0   ; el borde?
	cp 008h		;a2a3
	jr c,aparece_fuera		;a2a5
	dec (iy+001h)		;a2a7   ; un punto
	jr aparece_dibujo		;a2aa
aparece_fuera:
	xor a			;a2ac
	ld (0e1bbh),a		;a2ad
	ld (iy+005h),003h		;a2b0   ; desaparecido
	ld (iy+006h),000h		;a2b4
	ld (iy+000h),0ech		;a2b8
	ret			;a2bc
aparece_der:
	ld a,(iy+001h)		;a2bd
	cp 0e8h		;a2c0
	jr nc,aparece_fuera		;a2c2
	inc (iy+001h)		;a2c4
aparece_dibujo:
	ld a,(0e012h)		;a2c7   ; cada 8 cuadros, 0xF0 o 0xF4
	and 008h		;a2ca
	rrca			;a2cc
	add a,0f0h		;a2cd
	ld (iy+002h),a		;a2cf
	ld bc,00af6h		;a2d2   ; toca al gatito?
	call cerca_gatito		;a2d5
	jr nc,aparece_tiro		;a2d8
	ld bc,008f8h		;a2da
	call cerca_x		;a2dd
	jr nc,aparece_tiro		;a2e0
	ld a,001h		;a2e2   ; tocado
	ld (0e183h),a		;a2e4
	ret			;a2e7
aparece_tiro:
	ld a,(ix+00dh)		;a2e8   ; el tiro recto?
	and a			;a2eb
	jr nz,aparece_tiro_toca		;a2ec
	ld a,(ix+034h)		;a2ee   ; o el de arco?
	and a			;a2f1
	ret z			;a2f2
aparece_tiro_toca:
	ld bc,00af6h		;a2f3
	call cerca_y2		;a2f6
	ret nc			;a2f9
	ld bc,00af6h		;a2fa
	call cerca_x2		;a2fd
	ret nc			;a300
	xor a			;a301
	ld (0e1bbh),a		;a302
	ld a,010h		;a305   ; 10 puntos (100 en pantalla)
	call puntos_suma		;a307
	call tiro_fuera		;a30a   ; los tiros fuera
	call tiro_arco_fuera		;a30d
	ld a,002h		;a310   ; el efecto A 2
	call efecto_a_pide		;a312
	ld (iy+006h),000h		;a315
	ld (iy+005h),003h		;a319
	ret			;a31d
aparece_vuelve:
	inc (iy+006h)		;a31e   ; la cuenta
	ld a,(iy+006h)		;a321
	cp 020h		;a324   ; 0x20: la explosion
	jr c,aparece_explota		;a326
	cp 040h		;a328   ; 0x40: otra vez
	jr c,aparece_oculto		;a32a
	ld (iy+005h),000h		;a32c
	ret			;a330
aparece_oculto:
	ld (iy+000h),0ech		;a331
	ret			;a335
aparece_explota:
	jp explosion_dibujo		;a336
regalo:		; El tipo 3 (si el gatito no lleva ya algo encima): aparece en un sitio al azar (X 0x40-0xBF, Y 0x40-0x7F) un rato, parpadeando (dibujo 0xE4, color 11 / 15), y desaparece; hasta diez veces; si el gatito lo toca: la musica 5 y 0x41 cuadros cambiando, y despues lo lleva encima (+0x1D = 1): el siguiente golpe solo se lo quita
	ld a,(iy+005h)		;a339   ; en marcha?
	and a			;a33c
	jr nz,regalo_va		;a33d
	ld a,(ix+01dh)		;a33f   ; ya lleva algo: fuera
	and a			;a342
	jp nz,otro_borra		;a343
	inc (iy+005h)		;a346
	ld a,r		;a349   ; su X al azar
	and 07fh		;a34b
	add a,040h		;a34d
	ld (iy+001h),a		;a34f
regalo_espera_azar:
	ld a,r		;a352   ; la espera al azar: 0x30-0x6F
	and 03fh		;a354
	add a,030h		;a356
	ld (iy+006h),a		;a358
	ret			;a35b
regalo_va:
	cp 001h		;a35c   ; 1: esperando
	jr nz,regalo_sale		;a35e
	dec (iy+006h)		;a360   ; la espera
	ret nz			;a363
	call regalo_espera_azar		;a364
	ld (iy+002h),0e4h		;a367   ; sale: dibujo 0xE4...
	ld a,r		;a36b   ; ...su Y al azar
	and 03fh		;a36d
	add a,040h		;a36f
	ld (iy+000h),a		;a371
	inc (iy+005h)		;a374
	ret			;a377
regalo_sale:
	dec (iy+006h)		;a378   ; su tiempo
	jr nz,regalo_color		;a37b
	ld (iy+000h),0ech		;a37d   ; se va
	ld (iy+005h),000h		;a381
	inc (iy+009h)		;a385   ; una vez mas
	ld a,(iy+009h)		;a388
	cp 00ah		;a38b   ; 10: fuera del todo
	jp z,otro_borra		;a38d
	ret			;a390
regalo_color:
	ld a,(0e012h)		;a391   ; cada 8 cuadros, color 11 o 15
	and 008h		;a394
	rrca			;a396
	add a,00bh		;a397
	ld (iy+003h),a		;a399
	ld bc,00af6h		;a39c   ; lo toca el gatito?
	call cerca_gatito		;a39f
	ret nc			;a3a2
	ld bc,008f8h		;a3a3
	call cerca_x		;a3a6
	ret nc			;a3a9
	ld a,005h		;a3aa   ; la musica 5
	call musica_pide		;a3ac
	ld (iy+000h),0ech		;a3af   ; fuera
	xor a			;a3b3
	ld (0e013h),a		;a3b4
	ld (0e014h),a		;a3b7
regalo_cambia:
	ld a,(0e013h)		;a3ba   ; 4 cuadros
	cp 004h		;a3bd
	jr c,regalo_cambia		;a3bf
	xor a			;a3c1
	ld (0e013h),a		;a3c2
	ld a,(ix+01dh)		;a3c5   ; lleva / no lleva
	cpl			;a3c8
	ld (ix+01dh),a		;a3c9
	call gatito_dibujo		;a3cc   ; sus sprites
	call sprites_ram		;a3cf
	call sprites_vram_tabla		;a3d2
	ld a,(0e014h)		;a3d5   ; 0x41 veces?
	cp 041h		;a3d8
	jr c,regalo_cambia		;a3da
	ld (ix+01dh),001h		;a3dc   ; lo lleva
	jp otro_borra		;a3e0
andarin_alto:		; El tipo 4: anda por las plataformas (dibujo 0x5C, color 11) un punto por cuadro y da la vuelta en los bordes; si toca al gatito, tocado; solo el tiro recto lo derrota: 500 puntos (en pantalla)
	ld a,(iy+005h)		;a3e3   ; al salir, color 11
	and a			;a3e6
	jr nz,andarin_alto_va		;a3e7
	inc (iy+005h)		;a3e9
	ld (iy+003h),00bh		;a3ec
	ret			;a3f0
andarin_alto_va:
	cp 005h		;a3f1   ; 5: la explosion
	jp z,explosion		;a3f3
	inc (iy+006h)		;a3f6
	ld a,(iy+006h)		;a3f9
	cp 001h		;a3fc
	jp c,andarin_alto_dibujo		;a3fe
	ld (iy+006h),000h		;a401
	call enemigo_casillas		;a405   ; las casillas
	ld a,(iy+007h)		;a408   ; a la derecha?
	and a			;a40b
	jr nz,andarin_alto_der		;a40c
	ld a,(iy+001h)		;a40e   ; el borde?
	cp 008h		;a411
	jr c,andarin_alto_vuelta		;a413
	ld a,(iy+00eh)		;a415   ; pared?
	cp 080h		;a418
	jr c,andarin_alto_vuelta		;a41a
	ld a,(iy+00ch)		;a41c   ; suelo delante?
	cp 080h		;a41f
	jr nc,andarin_alto_vuelta		;a421
	dec (iy+001h)		;a423   ; un punto a la izquierda
	jr andarin_alto_dibujo		;a426
andarin_alto_vuelta:
	ld a,(iy+007h)		;a428
	cpl			;a42b
	ld (iy+007h),a		;a42c
	jr andarin_alto_dibujo		;a42f
andarin_alto_der:
	ld a,(iy+001h)		;a431
	cp 0e8h		;a434
	jr nc,andarin_alto_vuelta		;a436
	ld a,(iy+00fh)		;a438
	cp 080h		;a43b
	jr c,andarin_alto_vuelta		;a43d
	ld a,(iy+00dh)		;a43f
	cp 080h		;a442
	jr nc,andarin_alto_vuelta		;a444
	inc (iy+001h)		;a446   ; un punto a la derecha
andarin_alto_dibujo:
	ld a,(0e012h)		;a449   ; cada 8 cuadros, 0x5C o 0x60, y su lado
	and 008h		;a44c
	rrca			;a44e
	add a,05ch		;a44f
	ld b,a			;a451
	ld a,(iy+007h)		;a452
	cpl			;a455
	and 080h		;a456
	add a,b			;a458
	ld (iy+002h),a		;a459
	ld bc,00af6h		;a45c   ; toca al gatito?
	call cerca_gatito		;a45f
	jr nc,andarin_alto_tiro		;a462
	ld bc,00af6h		;a464
	call cerca_x		;a467
	jr nc,andarin_alto_tiro		;a46a
	ld a,001h		;a46c   ; tocado
	ld (0e183h),a		;a46e
	ret			;a471
andarin_alto_tiro:
	ld a,(ix+00dh)		;a472   ; el tiro recto?
	and a			;a475
	ret z			;a476
	ld bc,00af6h		;a477
	call cerca_y2		;a47a
	ret nc			;a47d
	ld bc,00cf4h		;a47e
	call cerca_x2		;a481
	ret nc			;a484
	ld a,002h		;a485   ; el efecto A 2
	call efecto_a_pide		;a487
	ld a,050h		;a48a   ; 50 puntos (500 en pantalla)
	call puntos_suma		;a48c
	ld (iy+005h),005h		;a48f   ; la explosion
	call tiro_fuera		;a493
	ret			;a496
saltarin:		; El tipo 5: anda y, cada tanto al azar, salta (la tabla de 0xA604: sube 15 pasos y baja); cae si no hay suelo; si toca al gatito: con algo encima, lo derrota; si no, tocado; cualquier tiro lo derrota: 100 puntos (en pantalla)
	ld a,(iy+005h)		;a497   ; al salir: la espera al azar, color 15
	and a			;a49a
	jr nz,saltarin_va		;a49b
	inc (iy+005h)		;a49d
	ld a,r		;a4a0
	and 07fh		;a4a2
	ld (iy+009h),a		;a4a4
	ld (iy+003h),00fh		;a4a7
	ret			;a4ab
saltarin_va:
	cp 005h		;a4ac   ; 5: la explosion
	jp z,explosion		;a4ae
	call enemigo_casillas		;a4b1   ; las casillas
	inc (iy+006h)		;a4b4   ; cada 2 cuadros
	ld a,(iy+006h)		;a4b7
	cp 002h		;a4ba
	jp c,saltarin_dibujo		;a4bc
	ld (iy+006h),000h		;a4bf
	ld a,(iy+008h)		;a4c3   ; saltando?
	and a			;a4c6
	jr nz,saltarin_lado		;a4c7
	dec (iy+009h)		;a4c9   ; la espera
	jr nz,saltarin_lado		;a4cc
	ld (iy+008h),001h		;a4ce   ; salta
saltarin_lado:
	ld a,(iy+007h)		;a4d2   ; a la derecha?
	and a			;a4d5
	jp nz,saltarin_der		;a4d6
	ld a,(iy+001h)		;a4d9   ; el borde?
	cp 008h		;a4dc
	jp c,saltarin_vuelta		;a4de
	ld a,(iy+008h)		;a4e1   ; saltando: sin mirar el suelo
	and a			;a4e4
	jr nz,saltarin_izq		;a4e5
	ld a,(iy+00eh)		;a4e7
	cp 080h		;a4ea
	jp c,saltarin_vuelta		;a4ec
saltarin_izq:
	dec (iy+001h)		;a4ef   ; un punto a la izquierda
saltarin_salto:
	ld a,(iy+008h)		;a4f2   ; saltando?
	and a			;a4f5
	jr z,saltarin_cae		;a4f6
	ld hl,0a604h		;a4f8   ; la tabla (0xA604)
	ld a,(iy+009h)		;a4fb
	cp 00fh		;a4fe   ; subiendo (15 pasos)?
	jr nc,saltarin_baja		;a500
	add a,l			;a502
	jr nc,saltarin_sube		;a503
	inc h			;a505
saltarin_sube:
	ld l,a			;a506
	ld a,(hl)			;a507   ; cuanto
	add a,(iy+000h)		;a508
	ld (iy+000h),a		;a50b
	inc (iy+009h)		;a50e
	jp saltarin_dibujo		;a511
saltarin_baja:
	cp 01eh		;a514   ; 0x1E: acabado
	jr c,saltarin_baja_paso		;a516
saltarin_acaba:
	ld (iy+008h),000h		;a518
	ld a,r		;a51c   ; otra espera al azar
	and 07fh		;a51e
	ld (iy+009h),a		;a520
	jr saltarin_dibujo		;a523
saltarin_baja_paso:
	ld hl,0a604h		;a525
	add a,l			;a528
	jr nc,saltarin_baja_tabla		;a529
	inc h			;a52b
saltarin_baja_tabla:
	ld l,a			;a52c
	ld b,(hl)			;a52d
saltarin_baja_punto:
	push bc			;a52e
	ld a,(iy+000h)		;a52f   ; en una fila exacta?
	and 007h		;a532
	and a			;a534
	jr nz,saltarin_baja_uno		;a535
	call enemigo_casillas		;a537   ; suelo?
	ld a,(iy+00ch)		;a53a
	cp 080h		;a53d
	jr c,saltarin_suelo		;a53f
	ld a,(iy+00ch)		;a541
	cp 080h		;a544
	jr c,saltarin_suelo		;a546
saltarin_baja_uno:
	inc (iy+000h)		;a548   ; un punto abajo
	pop bc			;a54b
	djnz saltarin_baja_punto		;a54c
	inc (iy+009h)		;a54e
	jr saltarin_dibujo		;a551
saltarin_suelo:
	pop hl			;a553
	jr saltarin_acaba		;a554
saltarin_cae:
	ld b,003h		;a556   ; sin saltar: cae 3 puntos si no hay suelo
saltarin_cae_punto:
	push bc			;a558   ; uno
	call enemigo_casillas		;a559   ; las casillas
	ld a,(iy+00ch)		;a55c   ; suelo?
	cp 080h		;a55f
	jr c,saltarin_cae_fin		;a561
	ld a,(iy+00dh)		;a563
	cp 080h		;a566
	jr c,saltarin_cae_fin		;a568
	inc (iy+000h)		;a56a   ; un punto abajo
	pop bc			;a56d
	djnz saltarin_cae_punto		;a56e   ; tres
	jr saltarin_dibujo		;a570
saltarin_cae_fin:
	pop bc			;a572
	jr saltarin_dibujo		;a573
saltarin_vuelta:
	ld a,(iy+007h)		;a575   ; da la vuelta y salta
	cpl			;a578
	ld (iy+007h),a		;a579
	ld (iy+008h),001h		;a57c
	ld (iy+009h),000h		;a580
	ret			;a584
saltarin_der:
	ld a,(iy+001h)		;a585   ; en el borde?
	cp 0e8h		;a588
	jr nc,saltarin_vuelta		;a58a
	ld a,(iy+008h)		;a58c   ; saltando?
	and a			;a58f
	jr nz,saltarin_der_paso		;a590
	ld a,(iy+00fh)		;a592   ; pared?
	cp 080h		;a595
	jr c,saltarin_vuelta		;a597
saltarin_der_paso:
	inc (iy+001h)		;a599   ; un punto a la derecha
	jp saltarin_salto		;a59c
saltarin_dibujo:
	ld a,(iy+000h)		;a59f   ; abajo del todo: fuera
	cp 0b0h		;a5a2
	jp nc,otro_borra		;a5a4
	ld a,(0e013h)		;a5a7   ; cada 8 cuadros, 0x54 o 0x58, y su lado
	and 008h		;a5aa
	rrca			;a5ac
	add a,054h		;a5ad
	ld b,a			;a5af
	ld a,(iy+007h)		;a5b0
	cpl			;a5b3
	and 080h		;a5b4
	add a,b			;a5b6
	ld (iy+002h),a		;a5b7
saltarin_toca:
	ld bc,00af6h		;a5ba   ; toca al gatito?
	call cerca_gatito		;a5bd
	jr nc,saltarin_tiro		;a5c0
	ld bc,00af6h		;a5c2
	call cerca_x		;a5c5
	jr nc,saltarin_tiro		;a5c8
	ld a,(ix+01dh)		;a5ca   ; lleva algo encima?
	and a			;a5cd
	jr nz,saltarin_derrotado		;a5ce
	ld a,001h		;a5d0   ; no: tocado
	ld (0e183h),a		;a5d2
	ret			;a5d5
saltarin_tiro:
	ld a,(ix+00dh)		;a5d6   ; algun tiro?
	and a			;a5d9
	jr nz,L_A5E1		;a5da
	ld a,(ix+034h)		;a5dc
	and a			;a5df
	ret z			;a5e0
L_A5E1:
	ld bc,00af6h		;a5e1
	call cerca_y2		;a5e4
	ret nc			;a5e7
	ld bc,008f8h		;a5e8
	call cerca_x2		;a5eb
	ret nc			;a5ee
	call tiro_fuera		;a5ef   ; los tiros fuera
	call tiro_arco_fuera		;a5f2
saltarin_derrotado:
	ld a,010h		;a5f5   ; 10 puntos (100 en pantalla)
	call puntos_suma		;a5f7
	ld a,002h		;a5fa   ; el efecto A 2
	call efecto_a_pide		;a5fc
	ld (iy+005h),005h		;a5ff   ; la explosion
	ret			;a603

; ----------------------------------------------------------------------
; DATOS saltarin_tabla: Cuanto se mueve el tipo 5 en cada paso del salto: 15
;   hacia arriba (negativos) y 15 hacia abajo
;   0xa604..0xa622  (30 bytes)
DATA_saltarin_tabla:
	defb 0fdh,0fdh,0fdh,0fdh,0fdh,0fdh,0feh,0feh,0feh,0feh,0feh,0ffh,0ffh,0ffh,0ffh,001h	; a604  ................
	defb 001h,001h,001h,002h,002h,002h,002h,002h,003h,003h,003h,003h,003h,003h	; a614  ..............

; ======================================================================
; CODIGO 0xa622..0xa83d  (539 bytes)
; ======================================================================


paseante:		; El tipo 6: anda por las plataformas (dibujo 0x4C, color 8) un punto cada 3 cuadros, da la vuelta al azar, en los bordes y en las paredes, y cae si no hay suelo; toca y se derrota como el tipo 5 (100 puntos en pantalla)
	ld a,(iy+005h)		;a622   ; al salir: la espera al azar, color 8
	and a			;a625
	jr nz,paseante_va		;a626
	inc (iy+005h)		;a628
	ld a,r		;a62b
	and 07fh		;a62d
	ld (iy+009h),a		;a62f
	ld (iy+003h),008h		;a632
	ret			;a636
paseante_va:
	cp 005h		;a637   ; 5: la explosion
	jp z,explosion		;a639
	inc (iy+006h)		;a63c   ; cada 3 cuadros
	ld a,(iy+006h)		;a63f
	cp 003h		;a642
	jr c,paseante_dibujo		;a644
	ld (iy+006h),000h		;a646
	call enemigo_casillas		;a64a   ; las casillas
	dec (iy+009h)		;a64d   ; la espera: da la vuelta?
	jr z,paseante_azar		;a650
	ld a,(iy+007h)		;a652   ; a la derecha?
	and a			;a655
	jr nz,paseante_der		;a656
	ld a,(iy+001h)		;a658   ; el borde?
	cp 008h		;a65b
	jr c,paseante_vuelta		;a65d
	ld a,(iy+00eh)		;a65f   ; pared?
	cp 080h		;a662
	jr c,paseante_vuelta		;a664
	dec (iy+001h)		;a666   ; un punto a la izquierda
	jr paseante_cae		;a669
paseante_azar:
	ld a,r		;a66b   ; otra espera al azar
	and 07fh		;a66d
	ld (iy+009h),a		;a66f
paseante_vuelta:
	ld a,(iy+007h)		;a672
	cpl			;a675
	ld (iy+007h),a		;a676
	ret			;a679
paseante_der:
	ld a,(iy+001h)		;a67a
	cp 0e8h		;a67d
	jr nc,paseante_vuelta		;a67f
	ld a,(iy+00fh)		;a681
	cp 080h		;a684
	jr c,paseante_vuelta		;a686
	inc (iy+001h)		;a688   ; un punto a la derecha
paseante_cae:
	ld a,(iy+00ch)		;a68b   ; sin suelo: cae dos puntos
	cp 080h		;a68e
	jr c,paseante_dibujo		;a690
	ld a,(iy+00dh)		;a692
	cp 080h		;a695
	jr c,paseante_dibujo		;a697
	inc (iy+000h)		;a699
	inc (iy+000h)		;a69c
paseante_dibujo:
	ld a,(iy+000h)		;a69f   ; abajo del todo: fuera
	cp 0ach		;a6a2
	jp nc,otro_borra		;a6a4
	ld a,(0e012h)		;a6a7   ; cada 8 cuadros, 0x4C o 0x50, y su lado
	and 008h		;a6aa
	rrca			;a6ac
	add a,04ch		;a6ad
	ld b,a			;a6af
	ld a,(iy+007h)		;a6b0
	cpl			;a6b3
	and 080h		;a6b4
	add a,b			;a6b6
	ld (iy+002h),a		;a6b7
	jp saltarin_toca		;a6ba   ; toca o lo derrotan
volador:		; El tipo 7: entra por el lado contrario al del gatito a una altura al azar (0x10-0x4F), color 11; desde la segunda vuelta, a veces (y siempre en las pantallas 0x43, 0x48 y 0x49 de la escena 4) de color 1, y esos sueltan un tipo 8 (en 0xE3F0) al pasar por encima del gatito; vuela de lado y cada 6 cuadros se acerca a la altura del gatito; al salir por el otro lado, vuelve al rato; si toca al gatito, tocado; cualquier tiro lo derrota: 300 puntos (en pantalla)
	ld a,(iy+005h)		;a6bd   ; en marcha?
	and a			;a6c0
	jr nz,volador_va		;a6c1
	inc (iy+005h)		;a6c3
	ld a,(ix+001h)		;a6c6   ; el gatito a la izquierda?
	cp 080h		;a6c9
	jr nc,volador_izq		;a6cb
	ld (iy+001h),0f0h		;a6cd   ; entra por la derecha
	ld (iy+007h),000h		;a6d1
	jr volador_altura		;a6d5
volador_izq:
	ld (iy+001h),000h		;a6d7   ; entra por la izquierda
	ld (iy+007h),0ffh		;a6db
volador_altura:
	ld a,r		;a6df   ; a una altura al azar
	and 03fh		;a6e1
	add a,010h		;a6e3
	ld (iy+000h),a		;a6e5
	ld (iy+003h),00bh		;a6e8   ; color 11
	ld a,(0e049h)		;a6ec   ; la primera vuelta: siempre
	and a			;a6ef
	ret z			;a6f0
	ld a,(0e04ah)		;a6f1   ; la escena 4?
	cp 004h		;a6f4
	jr z,volador_escena4		;a6f6
	ld a,r		;a6f8   ; al azar...
	bit 3,a		;a6fa
	ret nz			;a6fc
	ld (iy+003h),001h		;a6fd   ; ...color 1
	ret			;a701
volador_escena4:
	ld a,(0e03fh)		;a702   ; las pantallas 0x43, 0x48 y 0x49
	cp 043h		;a705
	jr z,volador_color1		;a707
	cp 048h		;a709
	jr z,volador_color1		;a70b
	cp 049h		;a70d
	ret nz			;a70f
volador_color1:
	ld (iy+003h),001h		;a710
	ret			;a714
volador_espera:
	cp 005h		;a715   ; 5: la explosion
	jp z,explosion		;a717
	dec (iy+006h)		;a71a   ; la espera para volver
	ret nz			;a71d
	ld (iy+005h),000h		;a71e
	ret			;a722
volador_va:
	cp 001h		;a723
	jr nz,volador_espera		;a725
	ld a,(iy+007h)		;a727   ; hacia donde?
	and a			;a72a
	jr nz,volador_der		;a72b
	dec (iy+001h)		;a72d   ; un punto a la izquierda
	ld a,(iy+001h)		;a730
	cp 004h		;a733   ; el borde?
	jr nc,volador_altura_cambia		;a735
volador_fuera:
	ld (iy+000h),0ech		;a737   ; fuera...
	inc (iy+005h)		;a73b
	ld a,r		;a73e   ; ...hasta dentro de un rato
	and 03fh		;a740
	add a,030h		;a742
	ld (iy+006h),a		;a744
	ret			;a747
volador_der:
	inc (iy+001h)		;a748   ; un punto a la derecha
	ld a,(iy+001h)		;a74b
	cp 0ech		;a74e
	jr c,volador_altura_cambia		;a750
	jr volador_fuera		;a752
volador_altura_cambia:
	inc (iy+006h)		;a754   ; cada 6 cuadros
	ld a,(iy+006h)		;a757
	cp 006h		;a75a
	jr c,volador_suelta		;a75c
	ld (iy+006h),000h		;a75e
	ld a,(ix+000h)		;a762   ; hacia la altura del gatito
	sub 008h		;a765
	ld b,a			;a767
	ld a,(iy+000h)		;a768
	cp b			;a76b
	jr c,volador_baja		;a76c
	dec (iy+000h)		;a76e
	jr volador_suelta		;a771
volador_baja:
	inc (iy+000h)		;a773
volador_suelta:
	ld a,(iy+001h)		;a776   ; encima del gatito?
	ld b,(ix+001h)		;a779
	sub b			;a77c
	cp 006h		;a77d
	jr c,L_A785		;a77f
	cp 0fah		;a781
	jr c,volador_dibujo		;a783
L_A785:
	ld a,(0e049h)		;a785   ; la primera vuelta: no
	and a			;a788
	jr z,volador_dibujo		;a789
	cp 001h		;a78b   ; la segunda: solo los de color 1
	jr nz,volador_suelta_va		;a78d
	ld a,(iy+003h)		;a78f
	cp 001h		;a792
	jr nz,volador_dibujo		;a794
volador_suelta_va:
	ld a,(0e3f4h)		;a796   ; ya hay uno cayendo?
	and a			;a799
	jr nz,volador_dibujo		;a79a
	ld a,008h		;a79c   ; el tipo 8...
	ld (0e3f4h),a		;a79e
	ld a,(iy+000h)		;a7a1   ; ...debajo de el...
	add a,008h		;a7a4
	ld (0e3f0h),a		;a7a6
	ld a,(iy+001h)		;a7a9
	ld (0e3f1h),a		;a7ac
	ld a,00fh		;a7af   ; ...color 15
	ld (0e3f3h),a		;a7b1
volador_dibujo:
	ld a,(iy+000h)		;a7b4   ; abajo del todo: fuera
	cp 0b0h		;a7b7
	jp nc,volador_fuera		;a7b9
	ld a,(0e012h)		;a7bc   ; cada 8 cuadros, 0x4C o 0x50, y su lado
	and 008h		;a7bf
	rrca			;a7c1
	add a,04ch		;a7c2
	ld b,a			;a7c4
	ld a,(iy+007h)		;a7c5
	cpl			;a7c8
	and 080h		;a7c9
	add a,b			;a7cb
	ld (iy+002h),a		;a7cc
	ld bc,00af6h		;a7cf   ; toca al gatito?
	call cerca_gatito		;a7d2
	jr nc,volador_tiro		;a7d5
	ld bc,00af6h		;a7d7
	call cerca_x		;a7da
	jr nc,volador_tiro		;a7dd
	ld a,001h		;a7df   ; tocado
	ld (0e183h),a		;a7e1
	ret			;a7e4
volador_tiro:
	ld a,(ix+00dh)		;a7e5   ; algun tiro?
	and a			;a7e8
	jr nz,L_A7F0		;a7e9
	ld a,(ix+034h)		;a7eb
	and a			;a7ee
	ret z			;a7ef
L_A7F0:
	ld bc,00af6h		;a7f0
	call cerca_y2		;a7f3
	ret nc			;a7f6
	ld bc,00af6h		;a7f7
	call cerca_x2		;a7fa
	ret nc			;a7fd
	ld (iy+005h),005h		;a7fe   ; la explosion
	call tiro_arco_fuera		;a802
	call tiro_fuera		;a805
	ld a,030h		;a808   ; 30 puntos (300 en pantalla)
	call puntos_suma		;a80a
	ld a,002h		;a80d   ; el efecto A 2
	call efecto_a_pide		;a80f
	ret			;a812
cae_cosa:		; El tipo 8: lo que suelta el tipo 7: cae un punto por cuadro (dibujo 0x90 / 0x94) hasta abajo; si toca al gatito, tocado
	ld a,(0e012h)		;a813   ; cada 8 cuadros, 0x90 o 0x94
	and 008h		;a816
	rrca			;a818
	add a,090h		;a819
	ld (iy+002h),a		;a81b
	inc (iy+000h)		;a81e   ; un punto abajo
	ld a,(iy+000h)		;a821   ; abajo del todo: fuera
	cp 0ach		;a824
	jp nc,otro_borra		;a826
	ld bc,009f7h		;a829   ; toca al gatito?
	call cerca_gatito		;a82c
	ret nc			;a82f
	ld bc,008f8h		;a830
	call cerca_x		;a833
	ret nc			;a836
	ld a,001h		;a837   ; tocado
	ld (0e183h),a		;a839
	ret			;a83c

; ----------------------------------------------------------------------
; DATOS pantallas_2: Tres bytes y mas pantallas (0xA840-0xAD84), de la tabla
;   de 0x4114
;   0xa83d..0xad85  (1352 bytes)
DATA_pantallas_2:
	defb 006h,004h,050h,080h,001h,0feh,012h,000h,006h,004h,050h,012h,00ah,005h,004h,050h	; a83d  ..P.......P....P
	defb 012h,016h,00ah,004h,050h,012h,011h,003h,004h,050h,0ffh,011h,000h,006h,001h,054h	; a84d  ....P....P.....T
	defb 011h,00ah,005h,001h,054h,011h,016h,00ah,001h,054h,011h,011h,003h,001h,054h,006h	; a85d  ....T....T....T.
	defb 00ch,001h,008h,060h,00eh,00ch,001h,003h,064h,00ah,018h,001h,004h,060h,00eh,018h	; a86d  ...`....d....`..
	defb 001h,003h,064h,00ch,012h,001h,002h,060h,00eh,012h,001h,003h,064h,0ffh,00eh,004h	; a87d  ..d....`....d...
	defb 0deh,0a8h,00bh,00ah,0e6h,0a8h,006h,00ah,0e6h,0a8h,006h,00dh,0eah,0a8h,00ah,016h	; a88d  ................
	defb 0e6h,0a8h,00ah,019h,0eah,0a8h,00ch,010h,0e6h,0a8h,00ch,013h,0eah,0a8h,00eh,01dh	; a89d  ................
	defb 0deh,0a8h,0ffh,080h,001h,0feh,012h,000h,020h,004h,050h,0ffh,011h,000h,020h,001h	; a8ad  ........ .P... .
	defb 054h,0ffh,00bh,00dh,09ah,0afh,00ch,00eh,0a6h,0afh,007h,00eh,0d0h,0afh,008h,00fh	; a8bd  T...............
	defb 0dah,0afh,0ffh,002h,002h,098h,099h,09ch,09dh,002h,001h,038h,039h,002h,001h,03ah	; a8cd  ...........89..:
	defb 03bh,002h,003h,058h,059h,05ch,05dh,05eh,05fh,002h,001h,061h,062h,002h,001h,065h	; a8dd  ;..XY\]^_..ab..e
	defb 066h,080h,001h,0feh,000h,000h,020h,004h,054h,008h,010h,00ch,002h,054h,00ah,00eh	; a8ed  f..... .T....T..
	defb 005h,002h,054h,00ah,01ah,002h,005h,054h,00ch,00ch,007h,002h,054h,00eh,00ah,007h	; a8fd  ..T....T....T...
	defb 003h,054h,00eh,011h,007h,001h,054h,011h,000h,011h,005h,054h,013h,011h,00fh,003h	; a90d  .T....T....T....
	defb 054h,0ffh,0ffh,0ffh,080h,001h,0feh,000h,000h,020h,004h,054h,004h,004h,008h,009h	; a91d  T........ .T....
	defb 054h,004h,00ch,014h,003h,054h,00bh,00eh,012h,002h,054h,013h,000h,004h,003h,054h	; a92d  T....T....T....T
	defb 013h,007h,019h,003h,054h,011h,00ch,014h,002h,054h,0ffh,0ffh,0ffh,080h,001h,0feh	; a93d  ....T....T......
	defb 000h,000h,004h,007h,054h,000h,004h,01ch,002h,054h,00bh,000h,020h,002h,054h,007h	; a94d  ....T....T.. .T.
	defb 006h,005h,004h,054h,007h,00dh,002h,004h,054h,007h,011h,002h,004h,054h,007h,015h	; a95d  ...T....T....T..
	defb 002h,004h,054h,007h,019h,002h,004h,054h,011h,000h,006h,005h,054h,013h,006h,005h	; a96d  ..T....T....T...
	defb 003h,054h,013h,00dh,006h,003h,054h,013h,017h,009h,003h,054h,0ffh,0ffh,0ffh,080h	; a97d  .T....T....T....
	defb 001h,0feh,000h,000h,020h,002h,054h,002h,004h,014h,002h,054h,004h,006h,012h,002h	; a98d  .... .T....T....
	defb 054h,004h,01ah,006h,002h,054h,00bh,000h,004h,002h,054h,00bh,00ah,005h,008h,054h	; a99d  T....T....T....T
	defb 00bh,011h,004h,005h,054h,00bh,017h,009h,002h,054h,00dh,008h,002h,006h,054h,010h	; a9ad  ....T....T....T.
	defb 00fh,006h,004h,054h,00fh,006h,002h,004h,054h,011h,004h,002h,002h,054h,013h,000h	; a9bd  ...T....T....T..
	defb 00fh,003h,054h,014h,00fh,011h,002h,054h,011h,01ah,006h,003h,054h,002h,01eh,002h	; a9cd  ..T....T....T...
	defb 002h,054h,0ffh,0ffh,0ffh,080h,001h,0feh,000h,000h,020h,004h,054h,004h,000h,006h	; a9dd  .T........ .T...
	defb 002h,054h,004h,00ch,002h,005h,054h,004h,014h,002h,005h,054h,004h,01ch,004h,005h	; a9ed  .T....T....T....
	defb 054h,00bh,000h,002h,002h,054h,00bh,004h,002h,002h,054h,009h,008h,002h,002h,054h	; a9fd  T....T....T....T
	defb 009h,010h,002h,002h,054h,009h,018h,002h,002h,054h,011h,000h,006h,005h,054h,00fh	; aa0d  ....T....T....T.
	defb 00ah,00ah,007h,054h,00fh,016h,00ah,002h,054h,015h,014h,00ch,002h,054h,0ffh,0ffh	; aa1d  ...T....T....T..
	defb 0ffh,080h,001h,0feh,000h,000h,00fh,001h,054h,007h,000h,004h,002h,054h,005h,006h	; aa2d  ........T....T..
	defb 007h,002h,054h,000h,00fh,002h,009h,054h,000h,011h,002h,007h,054h,000h,013h,002h	; aa3d  ..T....T....T...
	defb 005h,054h,000h,015h,002h,003h,054h,000h,017h,009h,001h,054h,00fh,000h,004h,002h	; aa4d  .T....T....T....
	defb 054h,015h,000h,006h,001h,054h,00dh,006h,00bh,009h,054h,00fh,011h,00fh,007h,054h	; aa5d  T....T....T....T
	defb 00bh,013h,00dh,004h,054h,009h,015h,00bh,002h,054h,007h,017h,009h,002h,054h,005h	; aa6d  ....T....T....T.
	defb 019h,007h,002h,054h,0ffh,0ffh,0ffh,080h,001h,0feh,005h,000h,002h,011h,054h,005h	; aa7d  ...T..........T.
	defb 004h,008h,002h,054h,007h,00ch,005h,002h,054h,009h,011h,005h,002h,054h,005h,018h	; aa8d  ...T....T....T..
	defb 002h,002h,054h,00ch,018h,004h,002h,054h,003h,01ch,002h,00fh,054h,014h,002h,014h	; aa9d  ..T....T....T...
	defb 002h,054h,010h,006h,006h,004h,054h,00eh,00ch,002h,006h,054h,012h,00eh,002h,002h	; aaad  .T....T....T....
	defb 054h,010h,010h,002h,004h,054h,012h,014h,002h,002h,054h,012h,01ah,006h,004h,054h	; aabd  T....T....T....T
	defb 003h,01ch,002h,00fh,054h,0ffh,0ffh,0ffh,080h,001h,0feh,000h,005h,002h,002h,054h	; aacd  ....T..........T
	defb 003h,007h,002h,002h,054h,002h,01ah,002h,002h,054h,009h,006h,014h,005h,054h,00ah	; aadd  ....T....T....T.
	defb 01ch,004h,002h,054h,012h,000h,00ch,004h,054h,014h,00ch,002h,002h,054h,014h,012h	; aaed  ...T....T....T..
	defb 002h,002h,054h,014h,016h,00ah,002h,054h,012h,01ah,006h,002h,054h,011h,01eh,002h	; aafd  ..T....T....T...
	defb 001h,054h,000h,01ch,004h,004h,054h,0ffh,0ffh,0ffh,080h,001h,0feh,000h,00ah,016h	; ab0d  .T....T.........
	defb 001h,054h,00ah,000h,003h,002h,054h,008h,003h,005h,002h,054h,008h,00ah,007h,001h	; ab1d  .T....T....T....
	defb 054h,007h,013h,00dh,002h,054h,011h,000h,005h,005h,054h,00fh,005h,005h,007h,054h	; ab2d  T....T....T....T
	defb 00dh,00ah,004h,009h,054h,00dh,012h,00eh,009h,054h,0ffh,0ffh,0ffh,080h,001h,0feh	; ab3d  ....T....T......
	defb 007h,000h,002h,002h,054h,00dh,000h,006h,009h,054h,009h,004h,008h,004h,054h,007h	; ab4d  ....T....T....T.
	defb 006h,006h,002h,054h,005h,008h,004h,002h,054h,004h,00ah,002h,001h,054h,011h,006h	; ab5d  ...T....T....T..
	defb 002h,002h,054h,013h,006h,01ah,003h,054h,000h,00eh,002h,00dh,054h,00bh,010h,002h	; ab6d  ..T....T....T...
	defb 002h,054h,000h,010h,010h,003h,054h,003h,01dh,003h,006h,054h,007h,014h,006h,002h	; ab7d  .T....T....T....
	defb 054h,011h,014h,00ch,002h,054h,00fh,016h,004h,002h,054h,00dh,018h,002h,002h,054h	; ab8d  T....T....T....T
	defb 00dh,01ch,004h,006h,054h,0ffh,0ffh,0ffh,080h,001h,0feh,000h,000h,020h,003h,054h	; ab9d  ....T........ .T
	defb 003h,000h,003h,006h,054h,007h,00fh,005h,002h,054h,008h,007h,002h,003h,054h,00bh	; abad  ....T....T....T.
	defb 005h,006h,002h,054h,00dh,000h,00dh,009h,054h,00fh,00dh,002h,002h,054h,011h,00dh	; abbd  ...T....T....T..
	defb 013h,005h,054h,00dh,015h,00bh,004h,054h,009h,017h,009h,004h,054h,007h,019h,007h	; abcd  ..T....T....T...
	defb 002h,054h,0ffh,0ffh,0ffh,080h,001h,0feh,000h,000h,004h,003h,054h,000h,00dh,013h	; abdd  .T..........T...
	defb 002h,054h,002h,011h,00fh,002h,054h,004h,008h,002h,002h,054h,006h,006h,007h,002h	; abed  .T....T....T....
	defb 054h,007h,000h,004h,00fh,054h,00ch,004h,002h,00ah,054h,010h,006h,002h,006h,054h	; abfd  T....T....T....T
	defb 00eh,008h,003h,008h,054h,00ch,00bh,004h,00ah,054h,00ah,00fh,003h,00ch,054h,00ah	; ac0d  ....T....T....T.
	defb 016h,004h,004h,054h,00eh,015h,007h,004h,054h,012h,016h,004h,004h,054h,00ah,01dh	; ac1d  ...T....T....T..
	defb 003h,002h,054h,011h,01eh,002h,003h,054h,014h,014h,003h,002h,054h,0ffh,0ffh,0ffh	; ac2d  ..T....T....T...
	defb 080h,001h,0feh,000h,000h,020h,004h,054h,004h,006h,004h,008h,054h,00ah,000h,004h	; ac3d  ..... .T....T...
	defb 002h,054h,00bh,00ch,014h,002h,054h,004h,01eh,002h,007h,054h,011h,000h,017h,005h	; ac4d  .T....T....T....
	defb 054h,013h,017h,002h,003h,054h,012h,01ch,004h,004h,054h,0ffh,0ffh,0ffh,080h,001h	; ac5d  T....T....T.....
	defb 0feh,000h,000h,002h,005h,054h,005h,000h,003h,002h,054h,007h,000h,002h,004h,054h	; ac6d  .....T....T....T
	defb 00bh,000h,003h,002h,054h,004h,006h,007h,002h,054h,006h,006h,002h,002h,054h,008h	; ac7d  ....T....T....T.
	defb 005h,003h,002h,054h,00ah,006h,002h,005h,054h,00fh,005h,003h,007h,054h,012h,000h	; ac8d  ...T....T....T..
	defb 003h,004h,054h,014h,008h,003h,002h,054h,00bh,00ah,002h,004h,054h,000h,010h,001h	; ac9d  ..T....T....T...
	defb 008h,054h,008h,010h,009h,002h,054h,000h,015h,004h,001h,054h,001h,017h,002h,002h	; acad  .T....T....T....
	defb 054h,00ah,010h,004h,002h,054h,00bh,00fh,001h,002h,054h,00ch,010h,002h,002h,054h	; acbd  T....T....T....T
	defb 000h,019h,007h,004h,054h,00ah,01bh,005h,00ch,054h,00fh,018h,003h,007h,054h,011h	; accd  ....T....T....T.
	defb 016h,002h,005h,054h,013h,010h,006h,003h,054h,0ffh,0ffh,0ffh,080h,001h,0feh,000h	; acdd  ...T....T.......
	defb 000h,020h,004h,054h,004h,016h,00ah,004h,054h,00ah,000h,003h,00ch,054h,014h,003h	; aced  . .T....T....T..
	defb 00ah,002h,054h,014h,011h,004h,002h,054h,014h,018h,008h,002h,054h,00ch,007h,00dh	; acfd  ..T....T....T...
	defb 002h,054h,00ch,017h,009h,002h,054h,0ffh,0ffh,0ffh,080h,001h,0feh,00ch,000h,005h	; ad0d  .T....T.........
	defb 002h,054h,014h,000h,020h,002h,054h,011h,008h,018h,003h,054h,00eh,00ah,00ah,003h	; ad1d  .T.. .T....T....
	defb 054h,00ch,00fh,005h,002h,054h,00ch,016h,002h,005h,054h,00ch,01ah,002h,005h,054h	; ad2d  T....T....T....T
	defb 006h,006h,002h,002h,054h,006h,00bh,002h,002h,054h,006h,00fh,002h,002h,054h,006h	; ad3d  ....T....T....T.
	defb 013h,002h,002h,054h,006h,017h,002h,002h,054h,006h,01ch,002h,002h,054h,0ffh,0ffh	; ad4d  ...T....T....T..
	defb 0ffh,080h,001h,0feh,011h,000h,020h,005h,054h,00bh,00eh,00ah,006h,054h,000h,018h	; ad5d  ...... .T....T..
	defb 008h,011h,054h,0ffh,0ffh,00dh,00eh,077h,0adh,0ffh,003h,004h,08fh,080h,080h,08fh	; ad6d  ..T....w........
	defb 080h,080h,08fh,080h,080h,08fh,080h,080h	; ad7d  ........

; ----------------------------------------------------------------------
; DATOS piezas_mapa: Las piezas de las tiras de casillas (0xAD85: 9 punteros),
;   las siete filas del suelo (0xAD97, 32 casillas cada una) y las demas
;   piezas; y 0xFF hasta 0xB000
;   0xad85..0xb000  (635 bytes)
DATA_piezas_mapa:
	defb 097h,0adh,0b7h,0adh,0d7h,0adh,0f7h,0adh,017h,0aeh,037h,0aeh,057h,0aeh,066h,0aeh	; ad85  ..........7.W.f.
	defb 074h,0aeh,0d8h,0d9h,0d8h,0d9h,0d8h,0d9h,0d8h,0d8h,0d8h,0d9h,0d9h,0d9h,0d8h,0d8h	; ad95  t...............
	defb 0d9h,0d8h,0d9h,0d9h,0d8h,0d8h,0d9h,0d8h,0d9h,0d8h,0d8h,0d9h,0d9h,0d9h,0d8h,0d9h	; ada5  ................
	defb 0d8h,0d9h,0d8h,0d9h,0d6h,0d9h,0d8h,0d7h,0d6h,0d8h,0d9h,0d9h,0d8h,0d8h,0d6h,0d8h	; adb5  ................
	defb 0d9h,0d7h,0d6h,0d8h,0d9h,0d8h,0d7h,0d8h,0d9h,0d8h,0d8h,0d6h,0d7h,0d8h,0d9h,0d9h	; adc5  ................
	defb 0d8h,0d6h,0d7h,0d8h,0d9h,0d9h,0d8h,0d7h,0d7h,0d8h,0d8h,0d9h,0d8h,0d9h,0d9h,0d9h	; add5  ................
	defb 0d8h,0d8h,0d8h,0d8h,0d7h,0d8h,0d9h,0d9h,0d8h,0d9h,0d8h,0d9h,0d9h,0d8h,0d7h,0d8h	; ade5  ................
	defb 0d9h,0d8h,0d8h,0d8h,0d9h,0d8h,0d9h,0d8h,0d9h,0d9h,0d9h,0d8h,0d8h,0d9h,0d8h,0d9h	; adf5  ................
	defb 0d7h,0d8h,0d8h,0d6h,0d8h,0d9h,0d9h,0d9h,0d8h,0d6h,0d8h,0d7h,0d8h,0d9h,0d8h,0d9h	; ae05  ................
	defb 0d8h,0d8h,032h,030h,032h,033h,030h,033h,032h,031h,030h,032h,033h,033h,032h,032h	; ae15  ..20230321023322
	defb 030h,032h,033h,031h,030h,032h,033h,032h,031h,032h,033h,032h,031h,032h,033h,033h	; ae25  0231023212321233
	defb 032h,030h,0b0h,0b1h,0b4h,0b5h,0b0h,0b1h,0b4h,0b5h,0b0h,0b1h,0b4h,0b5h,0b0h,0b1h	; ae35  20..............
	defb 0b4h,0b5h,0b0h,0b1h,0b4h,0b5h,0b0h,0b1h,0b4h,0b5h,0b0h,0b1h,0b4h,0b5h,0b0h,0b1h	; ae45  ................
	defb 0b4h,0b5h,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh,03bh	; ae55  ..;;;;;;;;;;;;;;
	defb 03bh,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,084h	; ae65  ;...............
	defb 085h,086h,084h,085h,086h,084h,085h,086h,084h,085h,086h,084h,085h,086h,084h,084h	; ae75  ................
	defb 085h,086h,084h,085h,086h,084h,085h,086h,084h,085h,086h,084h,085h,086h,084h,003h	; ae85  ................
	defb 001h,038h,034h,037h,004h,001h,038h,035h,036h,037h,005h,001h,038h,034h,035h,036h	; ae95  .847..8567..8456
	defb 037h,001h,003h,0e6h,0e7h,0e8h,001h,002h,0e9h,0eah,004h,002h,0ebh,0dbh,0dbh,0dbh	; aea5  7...............
	defb 0ech,0edh,0eeh,0efh,004h,002h,0dbh,0dbh,0dbh,0e1h,0e5h,0e4h,0e3h,0e2h,001h,002h	; aeb5  ................
	defb 0dfh,0e0h,002h,001h,0e5h,0e4h,001h,003h,0dch,0ddh,0deh,003h,001h,0edh,0eeh,0efh	; aec5  ................
	defb 001h,001h,0deh,003h,002h,0ebh,0dbh,0dbh,0ech,0edh,0eeh,001h,001h,0efh,001h,002h	; aed5  ................
	defb 0ebh,0ech,002h,008h,0cbh,0dbh,0cch,0dbh,0cdh,0dbh,0ceh,0dbh,0cfh,0dbh,0dbh,0d0h	; aee5  ................
	defb 0dbh,0d1h,0dbh,0d2h,001h,002h,0d3h,0d4h,001h,003h,0c0h,0c1h,0c2h,001h,002h,0c3h	; aef5  ................
	defb 0c4h,001h,005h,0bbh,0bch,0bdh,0beh,0bfh,002h,001h,0b8h,0bah,002h,008h,0c9h,0c7h	; af05  ................
	defb 0cah,0c8h,0cbh,0dbh,0cch,0dbh,0cdh,0dbh,0ceh,0dbh,0cfh,0dbh,0dbh,0d0h,002h,002h	; af15  ................
	defb 0b7h,0b9h,0b8h,0bah,002h,001h,034h,034h,003h,001h,034h,034h,034h,003h,007h,095h	; af25  ......44..444...
	defb 096h,097h,099h,09ah,09bh,099h,09ah,09bh,099h,09ah,09bh,099h,09ah,09bh,099h,09ah	; af35  ................
	defb 09bh,099h,09ah,09bh,003h,007h,03dh,03eh,03fh,099h,09ah,09bh,099h,09ah,09bh,099h	; af45  ......=>?.......
	defb 09ah,09bh,099h,09ah,09bh,099h,09ah,09bh,099h,09ah,09bh,004h,002h,090h,099h,09ah	; af55  ................
	defb 09bh,094h,09dh,09eh,09fh,003h,001h,039h,038h,03ah,003h,001h,036h,038h,037h,003h	; af65  .......98:..687.
	defb 003h,091h,092h,093h,059h,05ah,05bh,051h,052h,053h,004h,002h,090h,051h,052h,053h	; af75  ....YZ[QRS...QRS
	defb 050h,055h,056h,057h,003h,005h,051h,052h,053h,051h,052h,053h,051h,052h,053h,051h	; af85  PUVW..QRSQRSQRSQ
	defb 052h,053h,051h,052h,053h,00ah,001h,040h,041h,040h,041h,040h,041h,040h,041h,040h	; af95  RSQRS..@A@A@A@A@
	defb 041h,008h,005h,08ch,042h,043h,08ch,08ch,08ch,08ch,08ch,08dh,080h,080h,08dh,08ch	; afa5  A...BC..........
	defb 08ch,08ch,08ch,08dh,080h,080h,08dh,08ch,08ch,08ch,08ch,08dh,080h,080h,08dh,08ch	; afb5  ................
	defb 08ch,08ch,08ch,08dh,080h,080h,08dh,08eh,08eh,08eh,08eh,008h,001h,040h,041h,040h	; afc5  .............@A@
	defb 041h,040h,041h,040h,041h,006h,003h,08ch,08ch,08ch,08ch,08ch,08ch,08ch,08ch,08ch	; afd5  A@A@A...........
	defb 08ch,08ch,08ch,08eh,08eh,08eh,08eh,08eh,08eh,08ch,08ch,08ch,08ch,08ch,08ch,08ch	; afe5  ................
	defb 08ch,08ch,08ch,08eh,08eh,08eh,08eh,08eh,08eh,0ffh,0ffh	; aff5  ...........

; ----------------------------------------------------------------------
; DATOS pantallas_enemigos: Los enemigos y los objetos de cada pantalla
;   (0xB000: un puntero por pantalla; cada lista: Y, X y tipo de cada enemigo
;   hasta 0xFF, y cuatro bytes de cada objeto hasta 0xFF); y 0xFF hasta 0xB700
;   0xb000..0xb700  (1792 bytes)
DATA_pantallas_enemigos:
	defb 0d0h,0b0h,0e3h,0b0h,0fah,0b0h,00dh,0b1h,02fh,0b1h,052h,0b1h,070h,0b1h,087h,0b1h	; b000  ......../.R.p...
	defb 0adh,0b1h,00dh,0b1h,0cfh,0b1h,0f2h,0b1h,01ch,0b2h,047h,0b2h,06dh,0b2h,052h,0b1h	; b010  ..........G.m.R.
	defb 08ch,0b2h,0a3h,0b2h,0cbh,0b2h,0f0h,0b2h,00ch,0b3h,034h,0b3h,059h,0b3h,082h,0b3h	; b020  ..........4.Y...
	defb 0a7h,0b3h,034h,0b3h,0dah,0b3h,082h,0b3h,08ch,0b2h,0fdh,0b3h,059h,0b3h,046h,0b4h	; b030  ..4.........Y.F.
	defb 07bh,0b4h,084h,0b4h,094h,0b4h,0b0h,0b4h,0bdh,0b4h,0d7h,0b4h,0eeh,0b4h,009h,0b5h	; b040  {...............
	defb 01ch,0b5h,03bh,0b5h,04eh,0b5h,065h,0b5h,07ch,0b5h,098h,0b5h,0afh,0b5h,0cah,0b5h	; b050  ..;.N.e.|.......
	defb 0deh,0b5h,0eeh,0b5h,00dh,0b6h,028h,0b6h,043h,0b6h,05ah,0b6h,028h,0b6h,078h,0b6h	; b060  ......(.C.Z.(.x.
	defb 0deh,0b5h,0eeh,0b5h,00dh,0b6h,028h,0b6h,043h,0b6h,05ah,0b6h,028h,0b6h,078h,0b6h	; b070  ......(.C.Z.(.x.
	defb 05dh,06dh,069h,06dh,078h,06dh,09ah,06dh,0bfh,06dh,0e1h,06dh,0ffh,06dh,02ah,06eh	; b080  ]mimxm.m.m.m.m*n
	defb 09ah,06dh,09ah,06dh,0bfh,06dh,047h,06eh,071h,06eh,09eh,06eh,09eh,06eh,047h,06eh	; b090  .m.m.mGnqn.n.nGn
	defb 020h,07dh,035h,07dh,048h,07dh,068h,07dh,07bh,07dh,095h,07dh,0b0h,07dh,0ceh,07dh	; b0a0   }5}H}h}{}.}.}.}
	defb 0e1h,07dh,0f8h,07dh,00eh,07eh,02dh,07eh,03dh,07eh,065h,07eh,078h,07eh,090h,07eh	; b0b0  .}.}.~-~=~e~x~.~
	defb 08ah,0b2h,08ah,0b2h,08ah,0b2h,08ah,0b2h,08ah,0b2h,08ah,0b2h,020h,06dh,0cfh,06eh	; b0c0  ............ m.n
	defb 068h,098h,001h,068h,0b0h,001h,0ech,000h,003h,0ffh,020h,0a0h,002h,080h,028h,048h	; b0d0  h..h...... ...(H
	defb 003h,082h,0ffh,048h,078h,001h,038h,0b0h,001h,088h,098h,005h,0ffh,018h,0a8h,003h	; b0e0  ...Hx.8.........
	defb 080h,018h,0b8h,003h,080h,048h,040h,003h,082h,0ffh,020h,040h,001h,040h,0c8h,001h	; b0f0  .....H@... @.@..
	defb 088h,070h,005h,0ffh,030h,080h,003h,081h,020h,0d8h,003h,083h,0ffh,028h,048h,001h	; b100  .p..0... ....(H.
	defb 018h,0e7h,001h,088h,088h,004h,050h,088h,001h,0ffh,020h,018h,003h,084h,038h,080h	; b110  ......P... ...8.
	defb 003h,080h,038h,090h,003h,080h,030h,0b8h,001h,080h,078h,0b8h,004h,003h,0ffh,028h	; b120  ..8...0...x....(
	defb 048h,001h,040h,088h,001h,088h,090h,005h,0ffh,018h,010h,002h,080h,060h,050h,003h	; b130  H.@..........`P.
	defb 080h,028h,0c0h,003h,080h,028h,0d0h,003h,081h,028h,0e0h,003h,080h,078h,0b8h,004h	; b140  .(...(...(...x..
	defb 002h,0ffh,048h,030h,001h,010h,098h,001h,028h,0d0h,001h,088h,080h,005h,0ffh,060h	; b150  ..H0....(......`
	defb 050h,003h,081h,030h,060h,003h,081h,060h,0c0h,003h,081h,028h,018h,003h,083h,0ffh	; b160  P..0`..`...(....
	defb 050h,038h,001h,018h,078h,001h,038h,0d8h,001h,0ffh,010h,040h,003h,083h,050h,088h	; b170  P8..x.8....@..P.
	defb 003h,081h,078h,090h,004h,002h,0ffh,060h,030h,001h,028h,0a0h,001h,040h,0d8h,001h	; b180  ..x....`0.(..@..
	defb 088h,068h,005h,0ffh,018h,030h,004h,003h,048h,060h,003h,081h,020h,0c0h,003h,080h	; b190  .h...0..H`.. ...
	defb 020h,0d0h,003h,080h,020h,0e0h,003h,080h,078h,0c0h,004h,002h,0ffh,048h,038h,001h	; b1a0   ... ...x....H8.
	defb 030h,0c0h,001h,088h,080h,005h,0ech,000h,003h,0ffh,078h,050h,002h,080h,020h,058h	; b1b0  0.........xP.. X
	defb 003h,080h,020h,068h,003h,080h,020h,078h,003h,080h,018h,0e0h,003h,083h,0ffh,088h	; b1c0  .. h.. x........
	defb 038h,005h,018h,088h,001h,038h,0b0h,001h,0ffh,058h,008h,003h,080h,048h,030h,003h	; b1d0  8....8...X...H0.
	defb 080h,038h,058h,003h,080h,058h,090h,001h,080h,078h,0c0h,004h,002h,018h,028h,003h	; b1e0  .8X..X...x....(.
	defb 083h,0ffh,010h,048h,001h,010h,088h,001h,010h,0c8h,001h,088h,068h,001h,0ffh,058h	; b1f0  ...H........h..X
	defb 018h,003h,080h,058h,028h,003h,080h,020h,010h,003h,083h,078h,070h,004h,002h,078h	; b200  ...X(.. ...xp..x
	defb 0b0h,004h,002h,048h,068h,003h,081h,050h,0a8h,003h,081h,0ffh,028h,058h,001h,028h	; b210  ...Hh..P....(X.(
	defb 090h,001h,028h,0d0h,001h,0ffh,040h,018h,003h,083h,028h,050h,003h,081h,028h,088h	; b220  ..(...@...(P..(.
	defb 002h,080h,028h,0c8h,003h,081h,050h,0a8h,003h,081h,078h,050h,004h,002h,078h,088h	; b230  ..(...P...xP..x.
	defb 004h,002h,078h,0c8h,004h,003h,0ffh,018h,068h,001h,010h,0a0h,001h,088h,050h,005h	; b240  ..x.....h.....P.
	defb 0ech,000h,003h,0ffh,058h,020h,003h,081h,018h,020h,003h,081h,048h,040h,003h,081h	; b250  ....X ... ..H@..
	defb 078h,088h,004h,003h,028h,0c0h,003h,083h,078h,0e0h,004h,002h,0ffh,050h,038h,001h	; b260  x...(...x....P8.
	defb 030h,058h,001h,018h,078h,001h,028h,0b0h,001h,038h,0d8h,001h,0ffh,078h,090h,004h	; b270  0X..x.(..8...x..
	defb 002h,010h,0d0h,003h,083h,050h,088h,003h,081h,0ffh,0ffh,0ffh,088h,090h,005h,030h	; b280  .....P.........0
	defb 080h,001h,020h,050h,002h,0ffh,020h,000h,003h,003h,020h,020h,003h,000h,020h,0c0h	; b290  .. P.. ...  .. .
	defb 002h,000h,0ffh,010h,038h,002h,030h,058h,002h,020h,0b8h,002h,050h,0e7h,002h,088h	; b2a0  ....8.0X. ..P...
	defb 070h,005h,0ech,000h,003h,0ffh,020h,030h,003h,000h,020h,040h,003h,000h,020h,050h	; b2b0  p..... 0.. @.. P
	defb 003h,000h,020h,060h,003h,000h,020h,070h,003h,003h,0ffh,020h,020h,002h,030h,050h	; b2c0  .. `.. p...  .0P
	defb 002h,028h,0a0h,002h,038h,0d0h,002h,088h,098h,005h,0ffh,010h,078h,003h,002h,020h	; b2d0  .(..8.......x.. 
	defb 078h,004h,001h,020h,0c8h,003h,001h,020h,0d8h,003h,001h,010h,078h,003h,003h,0ffh	; b2e0  x.. ... ....x...
	defb 050h,078h,001h,030h,0d8h,001h,0ffh,018h,048h,003h,083h,018h,088h,003h,080h,018h	; b2f0  Px.0....H.......
	defb 098h,003h,081h,088h,058h,004h,001h,088h,0b8h,004h,000h,0ffh,020h,030h,002h,028h	; b300  ....X....... 0.(
	defb 050h,002h,038h,088h,002h,048h,0b0h,002h,028h,0e0h,002h,078h,050h,001h,0ffh,010h	; b310  P.8..H..(..xP...
	defb 008h,003h,003h,028h,068h,003h,001h,028h,078h,003h,003h,028h,088h,003h,001h,068h	; b320  ...(h..(x..(...h
	defb 098h,002h,001h,0ffh,048h,038h,002h,028h,060h,002h,020h,0b0h,002h,030h,0d0h,002h	; b330  ....H8.(`. ..0..
	defb 088h,070h,005h,0ffh,028h,020h,003h,000h,028h,030h,003h,000h,030h,078h,004h,000h	; b340  .p..( ..(0..0x..
	defb 030h,0a0h,003h,003h,088h,0b0h,004h,001h,0ffh,020h,060h,002h,040h,080h,002h,030h	; b350  0........ `.@..0
	defb 0a0h,002h,088h,0a0h,004h,0ech,000h,003h,0ffh,030h,060h,003h,001h,030h,070h,003h	; b360  .........0`..0p.
	defb 001h,030h,080h,003h,001h,048h,080h,001h,000h,030h,0e0h,003h,001h,070h,0b0h,003h	; b370  .0...H...0...p..
	defb 083h,0ffh,0ech,000h,007h,0ffh,020h,018h,003h,080h,020h,028h,003h,080h,010h,060h	; b380  ...... ... (...`
	defb 003h,080h,010h,070h,003h,080h,030h,068h,003h,083h,028h,0e8h,003h,083h,088h,068h	; b390  ...p..0h..(....h
	defb 004h,000h,088h,098h,004h,000h,0ffh,038h,038h,002h,028h,058h,002h,030h,078h,002h	; b3a0  .......88.(X.0x.
	defb 020h,0b8h,002h,050h,0d0h,002h,088h,0b8h,005h,0ech,000h,003h,0ffh,018h,018h,003h	; b3b0   ..P............
	defb 000h,018h,028h,003h,000h,018h,058h,003h,000h,018h,068h,003h,000h,018h,078h,003h	; b3c0  ..(...X...h...x.
	defb 000h,018h,0c8h,002h,000h,040h,0d8h,003h,003h,0ffh,048h,058h,001h,040h,0c8h,001h	; b3d0  .....@....HX.@..
	defb 088h,068h,005h,0ffh,038h,030h,004h,000h,040h,058h,004h,000h,028h,098h,003h,003h	; b3e0  .h..80..@X..(...
	defb 028h,0a8h,003h,001h,028h,0c8h,003h,001h,048h,0d8h,004h,001h,0ffh,038h,038h,002h	; b3f0  (...(...H....88.
	defb 020h,078h,002h,038h,0b8h,002h,040h,0d0h,002h,088h,068h,005h,0ffh,020h,028h,003h	; b400   x.8..@...h.. (.
	defb 001h,020h,060h,004h,001h,038h,060h,004h,000h,050h,060h,004h,001h,070h,098h,004h	; b410  . `..8`..P`..p..
	defb 002h,070h,0c0h,004h,002h,018h,0b0h,003h,003h,018h,0c0h,003h,003h,018h,0d0h,003h	; b420  .p..............
	defb 003h,018h,0e0h,003h,003h,028h,0b0h,003h,000h,028h,0c0h,003h,000h,028h,0d0h,003h	; b430  .....(...(...(..
	defb 000h,028h,0e0h,003h,000h,0ffh,0ech,000h,007h,0ffh,060h,020h,003h,081h,050h,048h	; b440  .(........` ..PH
	defb 003h,081h,040h,070h,003h,081h,030h,098h,003h,081h,020h,0c0h,003h,081h,010h,0e8h	; b450  ..@p..0... .....
	defb 003h,081h,018h,030h,003h,081h,070h,030h,004h,002h,070h,058h,004h,002h,070h,080h	; b460  ...0..p0..pX..p.
	defb 004h,002h,070h,0a8h,004h,002h,070h,0d0h,004h,002h,0ffh,0ech,000h,007h,0ffh,028h	; b470  ..p...p........(
	defb 080h,002h,001h,0ffh,0ech,000h,003h,078h,039h,001h,0ffh,090h,090h,003h,081h,020h	; b480  .......x9...... 
	defb 078h,003h,083h,0ffh,040h,0a8h,001h,0ech,000h,007h,0ffh,020h,080h,003h,080h,020h	; b490  x...@...... ... 
	defb 090h,003h,080h,020h,0a0h,003h,080h,090h,040h,003h,081h,020h,038h,003h,083h,0ffh	; b4a0  ... ....@.. 8...
	defb 028h,080h,001h,0ffh,070h,048h,003h,081h,070h,0a8h,003h,080h,0ffh,070h,0a0h,001h	; b4b0  (...pH..p....p..
	defb 038h,0c8h,001h,0ech,000h,003h,0ech,000h,007h,0ffh,080h,068h,002h,001h,050h,038h	; b4c0  8..........h..P8
	defb 003h,082h,030h,070h,003h,081h,0ffh,048h,058h,001h,070h,0a8h,001h,0ech,000h,007h	; b4d0  ..0p...HX.p.....
	defb 0ffh,098h,070h,003h,081h,020h,098h,003h,080h,020h,0a8h,003h,080h,0ffh,050h,048h	; b4e0  ..p.. ... ....PH
	defb 001h,030h,070h,001h,040h,0b8h,001h,0ffh,088h,058h,003h,081h,088h,088h,003h,081h	; b4f0  .0p.@....X......
	defb 088h,0b8h,003h,081h,060h,090h,003h,083h,0ffh,090h,050h,001h,038h,078h,001h,0ech	; b500  ....`.....P.8x..
	defb 000h,007h,0ffh,028h,028h,003h,083h,050h,0d0h,003h,080h,0ffh,040h,070h,001h,0ech	; b510  ...((..P....@p..
	defb 000h,007h,0ech,000h,003h,0ffh,020h,080h,003h,084h,058h,090h,003h,080h,048h,0b0h	; b520  ...... ...X...H.
	defb 002h,001h,028h,0c8h,003h,080h,028h,0d8h,003h,080h,0ffh,018h,090h,001h,058h,0d8h	; b530  ..(...(.......X.
	defb 001h,0ech,000h,007h,0ffh,080h,038h,003h,081h,070h,098h,003h,081h,0ffh,048h,058h	; b540  ......8..p....HX
	defb 001h,040h,098h,001h,020h,0d8h,001h,0ffh,030h,020h,003h,083h,038h,070h,003h,080h	; b550  .@.. ...0 ..8p..
	defb 028h,0b8h,003h,080h,0ffh,020h,078h,001h,048h,0e0h,001h,0ech,000h,007h,0ffh,028h	; b560  (.... x.H......(
	defb 040h,003h,081h,068h,040h,002h,001h,038h,0b8h,003h,083h,0ffh,020h,0a0h,001h,088h	; b570  @..h@..8.... ...
	defb 050h,001h,0ffh,020h,028h,003h,080h,020h,068h,003h,080h,020h,0a0h,003h,080h,020h	; b580  P.. (.. h.. ... 
	defb 0d8h,003h,080h,058h,080h,002h,001h,0ffh,018h,080h,001h,030h,0c8h,001h,0ech,000h	; b590  ...X.......0....
	defb 007h,0ffh,070h,050h,003h,080h,080h,0a8h,003h,080h,050h,080h,003h,082h,0ffh,020h	; b5a0  ..pP......P.... 
	defb 048h,001h,058h,0b8h,001h,0ech,000h,007h,0ffh,090h,050h,002h,001h,090h,060h,003h	; b5b0  H.X.......P...`.
	defb 081h,078h,080h,003h,081h,030h,0b0h,003h,083h,0ffh,0ech,000h,007h,088h,0d8h,001h	; b5c0  .x...0..........
	defb 0ffh,020h,060h,003h,081h,020h,098h,003h,081h,038h,0d0h,003h,083h,0ffh,0ech,000h	; b5d0  . `.. ...8......
	defb 003h,0ech,000h,007h,0ffh,058h,0a8h,002h,001h,048h,0d8h,003h,083h,0ffh,0ech,000h	; b5e0  .....X...H......
	defb 007h,038h,040h,001h,0ech,000h,003h,0ffh,050h,070h,003h,080h,030h,0b8h,003h,081h	; b5f0  .8@.....Pp..0...
	defb 060h,0c0h,003h,080h,060h,0d0h,003h,083h,060h,0e0h,003h,080h,0ffh,0ech,000h,007h	; b600  `...`...`.......
	defb 018h,060h,001h,088h,080h,001h,0ffh,040h,030h,003h,080h,058h,068h,003h,080h,030h	; b610  .`.....@0..Xh..0
	defb 0a8h,003h,080h,060h,0c8h,004h,002h,0ffh,058h,050h,001h,038h,088h,001h,018h,0c0h	; b620  ...`....XP.8....
	defb 001h,0ffh,040h,020h,003h,081h,040h,030h,003h,081h,030h,068h,003h,083h,018h,088h	; b630  ..@ ..@0..0h....
	defb 002h,001h,0ffh,0ech,000h,007h,028h,048h,001h,088h,0d0h,001h,0ffh,060h,030h,002h	; b640  ......(H.....`0.
	defb 001h,050h,088h,004h,002h,030h,0c8h,003h,084h,0ffh,0ech,000h,007h,0ech,000h,003h	; b650  .P...0..........
	defb 030h,058h,001h,028h,0a8h,001h,0ffh,058h,038h,003h,081h,050h,080h,004h,003h,050h	; b660  0X.(...X8..P...P
	defb 0c0h,001h,001h,030h,0e8h,003h,083h,0ffh,0ech,000h,007h,058h,04ch,001h,050h,0b8h	; b670  ...0.......XL.P.
	defb 001h,0ffh,048h,028h,003h,083h,028h,058h,003h,081h,028h,078h,003h,081h,020h,098h	; b680  ..H(..(X..(x.. .
	defb 004h,003h,070h,088h,003h,081h,028h,0e0h,003h,080h,038h,0e0h,003h,081h,048h,0e0h	; b690  ..p...(...8...H.
	defb 003h,080h,058h,0e0h,003h,081h,0ffh,004h,003h,070h,088h,003h,081h,028h,0e0h,003h	; b6a0  ..X......p...(..
	defb 080h,038h,0e0h,003h,081h,048h,0e0h,003h,080h,058h,0e0h,003h,081h,0ffh,0e0h,003h	; b6b0  .8...H...X......
	defb 081h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b6c0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b6d0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b6e0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b6f0  ................

; ----------------------------------------------------------------------
; DATOS sonido_tablas: Las tablas del sonido: 6 musicas (0xB700, 6 bytes: las
;   piezas de A, B y C; la 0 en silencio), 8 efectos del canal A (0xB724, 2
;   bytes) y 6 de B y C (0xB734, 4 bytes)
;   0xb700..0xb74c  (76 bytes)
DATA_sonido_tablas:
	defb 0a0h,0bbh,0a0h,0bbh,0a0h,0bbh,0a4h,0bbh,0cbh,0bbh,0dbh,0bbh,0dfh,0bbh,0ffh,0bbh	; b700  ................
	defb 006h,0bch,013h,0bch,040h,0bch,070h,0bch,008h,0bdh,00ch,0bdh,010h,0bdh,09dh,0bch	; b710  ....@.p.........
	defb 0bfh,0bch,0e1h,0bch,02ah,0bbh,02eh,0bbh,034h,0bbh,04ah,0bbh,069h,0bbh,07bh,0bbh	; b720  ....*...4.J.i.{.
	defb 08bh,0bbh,099h,0bbh,0a0h,0bbh,0a0h,0bbh,016h,0bdh,026h,0bdh,038h,0bdh,044h,0bdh	; b730  ..........&.8.D.
	defb 00dh,0beh,041h,0beh,078h,0bdh,0d6h,0bdh,0afh,0beh,078h,0beh	; b740  ..A.x.....x.

; ======================================================================
; CODIGO 0xb74c..0xba21  (725 bytes)
; ======================================================================


efecto_a_pide:		; Pide el efecto A del canal A (0xE2C0), solo en partida, con la misma regla: se queda el de numero mas bajo
	ld b,a			;b74c   ; el numero
	ld a,(0e000h)		;b74d   ; en partida?
	and a			;b750
	ret z			;b751
sonido_a_pon:
	ld a,b			;b752
	ld hl,0e2c0h		;b753   ; el efecto del canal A pedido
	jr pide_va		;b756
efecto_pide:		; Pide el efecto A (0xE2C2), solo en partida: si ya hay uno, se queda el de numero mas bajo
	ld b,a			;b758   ; el numero
	ld a,(0e000h)		;b759   ; en partida?
	and a			;b75c
	ret z			;b75d
	ld a,b			;b75e
	ld hl,0e2c2h		;b75f   ; el efecto pedido
pide_va:
	ld b,a			;b762
	ld a,(hl)			;b763   ; ya hay uno?
	and a			;b764
	jr z,pide_pon		;b765
	cp b			;b767   ; el de antes es menor: se queda
	ret c			;b768
pide_pon:
	ld (hl),b			;b769   ; el nuevo
	ret			;b76a
musica_pide:		; Pide la musica A (0xE2BE), con la misma regla
	ld hl,0e2beh		;b76b   ; la musica pedida
	jr pide_va		;b76e
sonido:		; El sonido de cada cuadro (desde la interrupcion): una musica nueva o un efecto nuevo empiezan; los tres canales (0xE280, 0xE292, 0xE2A4, 18 bytes) siguen
	ld hl,0e2bdh		;b770   ; una musica sonando?
	xor a			;b773
	cp (hl)			;b774   ; sonando?
	jr nz,sonido_musica_sigue		;b775
	inc hl			;b777   ; una pedida?
	cp (hl)			;b778
	jp nz,musica_empieza		;b779   ; empieza
	inc hl			;b77c   ; el efecto A sonando?
	cp (hl)			;b77d
	jr nz,sonido_a_sigue		;b77e
	inc hl			;b780
	cp (hl)			;b781
	jp nz,sonido_a_empieza		;b782
sonido_bc_mira2:
	xor a			;b785
	inc hl			;b786   ; el de B y C sonando?
	cp (hl)			;b787
	jr nz,sonido_bc_sigue		;b788
	inc hl			;b78a
	cp (hl)			;b78b
	jp nz,sonido_bc_empieza		;b78c
sonido_musica_sigue:		; Sonando una musica: si la pedida gana, empieza; si no, los canales
	call pedido_gana		;b78f
	jp c,musica_empieza		;b792
	jr sonido_canal_a		;b795
sonido_a_sigue:		; Sonando un efecto de A: si el pedido gana, empieza
	call pedido_gana		;b797
	jp c,sonido_a_empieza		;b79a
	jr sonido_bc_mira2		;b79d
sonido_bc_sigue:		; Sonando uno de B y C: si el pedido gana, empieza
	call pedido_gana		;b79f
	jp c,sonido_bc_empieza		;b7a2
sonido_canal_a:		; El canal A: su bloque a 0xE2C3, un paso y de vuelta
	ld a,(0e2bdh)		;b7a5   ; la musica?
	and a			;b7a8
	jr nz,sonido_canal_a_va		;b7a9
	ld a,(0e2bfh)		;b7ab   ; o un efecto que use el canal A?
	and a			;b7ae
	jr z,sonido_canal_b		;b7af
sonido_canal_a_va:
	ld hl,0e280h		;b7b1   ; el canal A
	call canal_a_trabajo		;b7b4   ; al canal de trabajo
	ld bc,00008h		;b7b7   ; los registros 0 y 1, volumen el 8
	xor a			;b7ba
	call canal_paso_pon		;b7bb
	push af			;b7be
	ld de,0e280h		;b7bf
	call canal_de_trabajo		;b7c2
	pop af			;b7c5
	and a			;b7c6   ; 0: sigue
	jr z,sonido_canal_b		;b7c7
	cp 001h		;b7c9
	jp z,musica_acaba		;b7cb
	cp 002h		;b7ce
	jp z,sonido_a_acaba		;b7d0
sonido_canal_b:		; Los canales B y C: con la musica o el efecto de B y C, un paso de cada uno (los registros 2-3 y 9, 4-5 y 10); al acabar, 0xB3ED
	ld a,(0e2bdh)		;b7d3   ; la musica?
	and a			;b7d6
	jr nz,sonido_canal_b_va		;b7d7
	ld a,(0e2c1h)		;b7d9   ; o el efecto de B y C?
	and a			;b7dc
	ret z			;b7dd
sonido_canal_b_va:
	ld hl,0e292h		;b7de   ; el canal B
	call canal_a_trabajo		;b7e1
	ld bc,00209h		;b7e4   ; los registros 2 y 3, volumen el 9
	ld a,(0e008h)		;b7e7   ; sus bits del registro 7
	rrca			;b7ea
	ld (0e008h),a		;b7eb
	ld a,001h		;b7ee   ; el canal 1
	call canal_paso_pon		;b7f0
	push af			;b7f3
	ld de,0e292h		;b7f4   ; y de vuelta
	call canal_de_trabajo		;b7f7
	pop af			;b7fa
	cp 003h		;b7fb   ; 3: sigue
	jr z,sonido_canal_c		;b7fd
	ld b,a			;b7ff
	ld a,(0e008h)		;b800   ; los bits de vuelta
	rlca			;b803
	ld (0e008h),a		;b804
	ld a,b			;b807
	and a			;b808
	jp nz,sonido_bc_acaba		;b809   ; acabado
sonido_canal_c:		; El canal C (los registros 4 y 5, volumen el 10); despues el barrido del ruido
	ld hl,0e2a4h		;b80c   ; el canal C
	call canal_a_trabajo		;b80f
	ld bc,0040ah		;b812   ; los registros 4 y 5, volumen el 10
	ld a,(0e008h)		;b815   ; sus bits del registro 7
	rrca			;b818
	rrca			;b819
	ld (0e008h),a		;b81a
	ld a,002h		;b81d   ; el canal 2
	call canal_paso_pon		;b81f
	push af			;b822
	ld de,0e2a4h		;b823   ; y de vuelta
	call canal_de_trabajo		;b826
	pop af			;b829
	cp 003h		;b82a   ; 3: sigue
	jp z,ruido_barrido		;b82c
	ld b,a			;b82f   ; los bits de vuelta
	ld a,(0e008h)		;b830
	rlca			;b833
	rlca			;b834
	ld (0e008h),a		;b835
	ld a,b			;b838   ; acabado?
	and a			;b839
	jp nz,sonido_bc_acaba		;b83a
	jp ruido_barrido		;b83d   ; el barrido del ruido
canal_a_trabajo:		; Copia el bloque del canal (HL, 18 bytes) a 0xE2C3
	ld de,0e2c3h		;b840   ; al canal de trabajo
copia18:
	ld bc,00012h		;b843   ; 18 bytes
	ldir		;b846
	ret			;b848
canal_de_trabajo:		; Y de vuelta a DE
	ld hl,0e2c3h		;b849
	jr copia18		;b84c
canal_paso:		; Un paso del canal de trabajo: si la nota sigue, nada; si no, el byte siguiente de la pieza: una nota (menos de 0xF0) o una orden
	ld hl,0e2cdh		;b84e   ; la nota sigue?
	ld a,(hl)			;b851
	and a			;b852
	jr z,canal_byte		;b853
	call canal_cuenta		;b855   ; su cuenta
	and a			;b858
	ret z			;b859
canal_byte:		; El byte siguiente de la pieza (0xE2C3): menos de 0xF0, una nota (duracion y volumen, el tono) y 3; si no, una orden
	ld iy,0e2cdh		;b85a
	ld hl,(0e2c3h)		;b85e
	ld a,(hl)			;b861   ; el byte
	cp 0f0h		;b862   ; 0xF0 o mas: una orden
	jr nc,L_B88B		;b864
	call nota_pon		;b866
	call nota_tono		;b869
	ld (0e2c3h),hl		;b86c   ; apuntado
	ld a,(0e008h)		;b86f   ; el canal con tono, sin ruido
	res 0,a		;b872
	set 3,a		;b874
canal_mezcla:
	ld c,a			;b876
	ld a,(0e2d5h)		;b877   ; corrido al canal
	and a			;b87a
	ld b,a			;b87b
	ld a,c			;b87c
	jr z,canal_mezcla_pon		;b87d
canal_mezcla_corre:
	rlca			;b87f
	djnz canal_mezcla_corre		;b880
canal_mezcla_pon:
	ld (0e008h),a		;b882   ; el registro 7
	call psg_mezcla		;b885
	ld a,003h		;b888
	ret			;b88a
L_B88B:
	jp z,canal_ruido		;b88b
	cp 0ffh		;b88e   ; 0xFF: el final
	jr nz,canal_orden_f7		;b890
	ld a,001h		;b892   ; 1
	ret			;b894
canal_orden_f7:
	cp 0f7h		;b895   ; 0xF7: callar
	jr nz,canal_orden_fe		;b897
	ld a,002h		;b899   ; 2
	ret			;b89b
canal_orden_fe:
	cp 0feh		;b89c   ; 0xFE: al principio
	jr nz,canal_orden_fd		;b89e
	ld hl,(0e2c5h)		;b8a0   ; la pieza otra vez desde su principio
	jr canal_orden_sigue		;b8a3
canal_orden_fd:		; 0xFD n: la marca 1 y cuantas veces
	cp 0fdh		;b8a5   ; 0xFD n: el primer bucle, n veces
	jr nz,canal_orden_fc		;b8a7
	inc hl			;b8a9   ; cuantas veces...
	ld a,(hl)			;b8aa
	ld (iy+005h),a		;b8ab   ; ...en +5
	inc hl			;b8ae
	ld (0e2c7h),hl		;b8af   ; la marca 1
	jr canal_orden_sigue		;b8b2
canal_orden_fc:		; 0xFC: vuelve a la marca 1 si quedan
	cp 0fch		;b8b4   ; 0xFC: el final del primer bucle
	jr nz,canal_orden_fb		;b8b6
	dec (iy+005h)		;b8b8   ; una vez menos
	jr nz,canal_orden_fc_vuelve		;b8bb
	inc hl			;b8bd   ; ya: sigue
	jr canal_orden_sigue		;b8be
canal_orden_fc_vuelve:
	ld hl,(0e2c7h)		;b8c0   ; a la marca 1
	jr canal_orden_sigue		;b8c3
canal_orden_fb:		; 0xFB n: la marca 2
	cp 0fbh		;b8c5   ; 0xFB n: el segundo bucle
	jr nz,canal_orden_fa		;b8c7
	inc hl			;b8c9   ; cuantas veces...
	ld a,(hl)			;b8ca
	ld (iy+006h),a		;b8cb   ; ...en +6
	inc hl			;b8ce
	ld (0e2c9h),hl		;b8cf   ; la marca 2
canal_orden_sigue:		; Sigue leyendo
	ld (0e2c3h),hl		;b8d2   ; por donde va
	jr canal_byte		;b8d5
canal_orden_fa:		; 0xFA: vuelve a la marca 2
	cp 0fah		;b8d7   ; 0xFA: su final
	jr nz,canal_orden_f9		;b8d9
	dec (iy+006h)		;b8db   ; una vez menos
	jr nz,canal_orden_fa_vuelve		;b8de
	inc hl			;b8e0   ; ya: sigue
	jr canal_orden_sigue		;b8e1
canal_orden_fa_vuelve:
	ld hl,(0e2c9h)		;b8e3   ; a la marca 2
	jr canal_orden_sigue		;b8e6
canal_orden_f9:		; 0xF9 n: la marca 3
	cp 0f9h		;b8e8   ; 0xF9 n: el tercer bucle
	jr nz,canal_orden_f8		;b8ea
	inc hl			;b8ec   ; cuantas veces...
	ld a,(hl)			;b8ed
	ld (iy+007h),a		;b8ee   ; ...en +7
	inc hl			;b8f1
	ld (0e2cbh),hl		;b8f2   ; la marca 3
	jr canal_orden_sigue		;b8f5
canal_orden_f8:		; 0xF8 (o mas): vuelve a la marca 3
	dec (iy+007h)		;b8f7   ; una vez menos
	jr nz,canal_orden_f8_vuelve		;b8fa
	inc hl			;b8fc   ; ya: sigue
	jr canal_orden_sigue		;b8fd
canal_orden_f8_vuelve:
	ld hl,(0e2cbh)		;b8ff   ; a la marca 3
	jr canal_orden_sigue		;b902
canal_ruido:		; 0xF0: una nota de ruido (el periodo y su barrido) y su duracion; el canal, a ruido en el registro 7
	call ruido_pon		;b904   ; el ruido
	inc hl			;b907
	call nota_pon		;b908
	inc hl			;b90b
	ld (0e2c3h),hl		;b90c
	ld a,(0e008h)		;b90f
	res 3,a		;b912
	set 0,a		;b914
	jp canal_mezcla		;b916
ruido_barrido:		; El barrido del ruido: cada tantos cuadros, el periodo + el paso, unas cuantas veces
	ld a,(0e2b6h)		;b919   ; hay ruido?
	and a			;b91c
	ret z			;b91d
	ld a,(0e2b7h)		;b91e   ; con barrido?
	and a			;b921
	ret z			;b922
	ld a,(0e2b9h)		;b923   ; quedan pasos?
	and a			;b926
	ret z			;b927
	ld a,(0e2bbh)		;b928   ; la espera...
	dec a			;b92b   ; ...un cuadro menos
	ld (0e2bbh),a		;b92c
	ret nz			;b92f
	ld a,(0e2b9h)		;b930   ; un paso menos
	dec a			;b933
	ld (0e2b9h),a		;b934
	ld a,(0e2bah)		;b937   ; otra vez la espera
	ld (0e2bbh),a		;b93a
	ld a,(0e2b8h)		;b93d   ; el periodo...
	ld b,a			;b940
	ld a,(0e2bch)		;b941   ; ...mas el paso
	add a,b			;b944
	ld (0e2b8h),a		;b945
	jp psg_ruido		;b948   ; al registro 6
canal_paso_pon:		; El canal A (0-2) en 0xE2D5 y un paso
	ld (0e2d5h),a		;b94b
	call canal_paso		;b94e
sonido_fin:
	ret			;b951
pedido_gana:		; (HL) el que suena, (HL+1) el pedido: Z sin pedido; C si el pedido es de numero menor (gana)
	ld b,(hl)			;b952   ; el que suena
	inc hl			;b953
	ld a,(hl)			;b954   ; el pedido
	and a			;b955
	ret z			;b956   ; ninguno: Z
	cp b			;b957   ; C si gana
	ret			;b958
canal_cuenta:		; La cuenta de la nota (+1): acabada, A = 1; si no, la envolvente: cada tantos cuadros el volumen baja uno; con 15, se corta a la mitad
	inc hl			;b959
	dec (hl)			;b95a
	jp z,canal_cuenta_fin		;b95b
	inc hl			;b95e
	ld a,(hl)			;b95f
	and a			;b960
	jp z,canal_cuenta_sigue		;b961
	cp 00fh		;b964   ; 15: la envolvente corta
	jr z,canal_cuenta_15		;b966
	inc hl			;b968
	dec (hl)			;b969   ; la cuenta de la envolvente
	jr nz,canal_cuenta_sigue		;b96a
	dec hl			;b96c
	ld a,(hl)			;b96d   ; la espera...
	inc hl			;b96e
	ld (hl),a			;b96f   ; ...otra vez
	inc hl			;b970
	dec (hl)			;b971   ; el volumen, uno menos
	ld a,(hl)			;b972
	call psg_c		;b973   ; al PSG
	and a			;b976
	jr nz,canal_cuenta_sigue		;b977
	dec hl			;b979   ; volumen 0: sin envolvente
	dec hl			;b97a
	ld (hl),a			;b97b
canal_cuenta_sigue:
	xor a			;b97c
	ret			;b97d
canal_cuenta_15:
	inc hl			;b97e
	dec (hl)			;b97f   ; la cuenta
	jr nz,canal_cuenta_sigue		;b980
	xor a			;b982
	dec hl			;b983
	ld (hl),a			;b984   ; el volumen a 0
	call psg_c		;b985
	ret			;b988
canal_cuenta_fin:
	dec hl			;b989   ; acabada
	xor a			;b98a
	ld (hl),a			;b98b   ; acabada: A = 1
	ld a,001h		;b98c   ; 1
	ret			;b98e
ruido_pon:		; El ruido: su periodo fijo o con barrido (periodo, cuantas veces, cada cuanto, el paso)
	ld (iy+000h),a		;b98f   ; la nota
	inc hl			;b992
	ld a,(hl)			;b993   ; con barrido?
	ld (0e2b7h),a		;b994   ; con barrido (cuantas veces)?
	and a			;b997
	jr nz,ruido_barre		;b998
	inc hl			;b99a
	ld a,(hl)			;b99b   ; el periodo...
	ld (0e2b8h),a		;b99c
	call psg_ruido		;b99f   ; ...registro 6
	xor a			;b9a2   ; sin barrido
	ld (0e2b9h),a		;b9a3
	ld (0e2bah),a		;b9a6
	ld (0e2bbh),a		;b9a9
	ld (0e2bch),a		;b9ac
	inc a			;b9af   ; hay ruido
	ld (0e2b6h),a		;b9b0
	ret			;b9b3
ruido_barre:
	ld (0e2b6h),a		;b9b4   ; hay ruido con barrido
	ld (0e2bch),a		;b9b7
	inc hl			;b9ba
	ld a,(hl)			;b9bb   ; el periodo...
	ld (0e2b8h),a		;b9bc
	call psg_ruido		;b9bf   ; ...registro 6
	inc hl			;b9c2
	ld a,(hl)			;b9c3   ; cuantas veces...
	ld (0e2b9h),a		;b9c4
	inc hl			;b9c7
	ld a,(hl)			;b9c8   ; ...cada cuanto
	ld (0e2bah),a		;b9c9
	ld (0e2bbh),a		;b9cc
	ret			;b9cf
nota_pon:		; Una nota: el byte de arriba es la duracion (la tabla 0xBA21, o el byte siguiente con 0xE), el de abajo el volumen (15: la mitad)
	ld a,(hl)			;b9d0   ; la nota...
	ld (iy+000h),a		;b9d1
	and 00fh		;b9d4   ; ...el volumen (la mitad baja)
	ld (iy+002h),a		;b9d6
	ld a,(hl)			;b9d9   ; la duracion (la mitad alta)...
	and 0f0h		;b9da
	rrca			;b9dc
	rrca			;b9dd
	rrca			;b9de
	rrca			;b9df
	cp 00eh		;b9e0   ; ...0xE: en el byte siguiente
	jr z,nota_duracion_byte		;b9e2
	ld de,0ba21h		;b9e4   ; la tabla de duraciones
	add a,e			;b9e7
	jr nc,nota_duracion		;b9e8
	inc d			;b9ea
nota_duracion:
	ld e,a			;b9eb
	ld a,(de)			;b9ec   ; la duracion
	jr nota_volumen		;b9ed
nota_duracion_byte:
	inc hl			;b9ef
	ld a,(hl)			;b9f0
nota_volumen:
	ld (iy+001h),a		;b9f1
	ld a,(iy+002h)		;b9f4   ; volumen 15?
	cp 00fh		;b9f7
	jr nz,nota_cuenta		;b9f9
	ld a,(iy+001h)		;b9fb   ; la duracion...
	push bc			;b9fe
	ld c,a			;b9ff
	srl a		;ba00   ; ...menos la mitad: la espera
	ld b,a			;ba02
	ld a,c			;ba03
	sub b			;ba04
	pop bc			;ba05
nota_cuenta:
	ld (iy+003h),a		;ba06   ; la cuenta de la envolvente
	ld a,00fh		;ba09   ; el volumen 15
	ld (iy+004h),a		;ba0b
	jp psg_c		;ba0e   ; al PSG
nota_tono:		; El tono de la nota: un byte de periodo bajo (0x10 o mas) o dos (el alto y el bajo), al registro B (+1 el alto)
	inc hl			;ba11
	ld a,(hl)			;ba12   ; el primer byte
	cp 010h		;ba13   ; menos de 0x10: el alto
	jr nc,nota_tono_bajo		;ba15
	call psg_b1		;ba17
	inc hl			;ba1a
	ld a,(hl)			;ba1b
nota_tono_bajo:
	call psg_b		;ba1c
	inc hl			;ba1f
	ret			;ba20

; ----------------------------------------------------------------------
; DATOS duraciones: Las 14 duraciones de las notas (0x80, 0x60 ... 1)
;   0xba21..0xba2f  (14 bytes)
DATA_duraciones:
	defb 080h,060h,040h,030h,020h,018h,010h,00ch,008h,006h,004h,003h,002h,001h	; ba21  .`@0 .........

; ======================================================================
; CODIGO 0xba2f..0xbb2a  (251 bytes)
; ======================================================================


psg_c:		; WRTPSG: el registro C
	ld e,a			;ba2f   ; el valor...
	ld a,c			;ba30   ; ...el registro C
psg:
	jp 00093h		;ba31   ; WRTPSG
psg_b:		; El registro B
	ld e,a			;ba34   ; el registro B
	ld a,b			;ba35
	jr psg		;ba36
psg_b1:		; El registro B + 1
	ld e,a			;ba38   ; el registro B + 1
	ld a,b			;ba39
	inc a			;ba3a
	jr psg		;ba3b
psg_mezcla:		; El registro 7
	ld e,a			;ba3d   ; el registro 7
	ld a,007h		;ba3e
	jr psg		;ba40
psg_ruido:		; El registro 6
	ld e,a			;ba42   ; el registro 6
	ld a,006h		;ba43
	jr psg		;ba45
musica_empieza:		; Una musica: los tres canales de la tabla 0xB700 (6 bytes por musica: la musica N en 0xB700 + 6N)
	ld hl,0b700h		;ba47   ; la tabla de musicas
	ld a,(0e2beh)		;ba4a   ; la pedida...
	ld (0e2bdh),a		;ba4d   ; ...suena
	ld b,a			;ba50   ; x 6
	add a,b			;ba51
	add a,b			;ba52
	add a,b			;ba53
	add a,b			;ba54
	add a,b			;ba55
	call canal_a_tabla		;ba56
	inc hl			;ba59
	call canales_bc		;ba5a
	ld (0e28ah),a		;ba5d
	ld (0e2beh),a		;ba60   ; el pedido, gastado
	ld a,0f8h		;ba63
mezcla_pon:		; El registro 7 (0xE008) al PSG y los canales
	ld (0e008h),a		;ba65
	call psg_mezcla		;ba68
	jp sonido_canal_a		;ba6b
musica_acaba:		; La pieza del canal A acabada: si hay otra musica pedida, empieza; si no, todo callado (0xB386)
	ld a,(0e2beh)		;ba6e   ; una pedida?
	and a			;ba71
	jr nz,musica_empieza		;ba72
	ld (0e2bdh),a		;ba74   ; ninguna suena
	dec a			;ba77
sonido_cero:		; Todo callado: el registro 7 a A (0xFF desde la interrupcion) y los canales a cero
	ld (0e008h),a		;ba78
	call psg_mezcla		;ba7b
canales_borra:		; Los tres canales y lo demas (0xE280, 0x43 bytes) a cero
	ld hl,0e280h		;ba7e
	ld b,043h		;ba81   ; 0x43 bytes
canales_borra_byte:
	ld (hl),000h		;ba83
	inc hl			;ba85
	djnz canales_borra_byte		;ba86
	ret			;ba88
sonido_a_empieza:		; Un efecto del canal A: su pieza de la tabla de 0xB724 (2 bytes por efecto)
	ld hl,0b724h		;ba89
	ld a,(0e2c0h)		;ba8c   ; el pedido...
	ld (0e2bfh),a		;ba8f   ; ...suena
	add a,a			;ba92
	call canal_a_tabla		;ba93
	xor a			;ba96   ; sin nota en marcha
	ld (0e28ah),a		;ba97
	ld (0e2c0h),a		;ba9a   ; el pedido, gastado
	ld a,(0e008h)		;ba9d   ; el canal A con tono
	res 0,a		;baa0
	ld (0e008h),a		;baa2
	call psg_mezcla		;baa5
	ld hl,0e2c0h		;baa8
	jp sonido_bc_mira2		;baab
sonido_a_acaba:		; El efecto del canal A acabado (0xF7): otro pedido, o el canal A callado
	ld a,(0e2c0h)		;baae   ; otro pedido?
	and a			;bab1
	jr nz,sonido_a_empieza		;bab2
	ld (0e2bfh),a		;bab4   ; ninguno suena
	ld hl,0e280h		;bab7   ; el canal A a cero
	ld b,012h		;baba
	call canales_borra_byte		;babc
	ld a,(0e008h)		;babf
	or 009h		;bac2
mezcla_pon_fin:
	ld (0e008h),a		;bac4
	jp psg_mezcla		;bac7
sonido_bc_empieza:		; Un efecto de los canales B y C: sus dos piezas de la tabla de 0xB734 (4 bytes por efecto)
	ld hl,0b734h		;baca
	ld a,(0e2c2h)		;bacd   ; el pedido...
	ld (0e2c1h),a		;bad0   ; ...suena
	add a,a			;bad3   ; x 4
	add a,a			;bad4
	add a,l			;bad5
	ld l,a			;bad6
	call canales_bc		;bad7   ; las dos piezas
	ld (0e2c2h),a		;bada   ; el pedido, gastado
	ld a,(0e008h)		;badd   ; B y C con tono
	and 0f9h		;bae0
	jp mezcla_pon		;bae2
sonido_bc_acaba:		; El efecto de B y C acabado: otro pedido, o B y C callados
	ld a,(0e2c2h)		;bae5   ; otro pedido?
	and a			;bae8
	jr nz,sonido_bc_empieza		;bae9
	ld (0e2c1h),a		;baeb
	ld hl,0e292h		;baee   ; los canales B y C...
	ld b,024h		;baf1
	call canales_borra_byte		;baf3
	ld a,(0e008h)		;baf6   ; el mezclador: B y C callados
	or 036h		;baf9
	jr mezcla_pon_fin		;bafb
canales_bc:		; Los canales B y C desde la tabla HL
	ld e,(hl)			;bafd   ; la pieza del canal B
	inc hl			;bafe
	ld d,(hl)			;baff
	ld (0e292h),de		;bb00   ; ...y su principio
	ld (0e294h),de		;bb04
	inc hl			;bb08
	ld e,(hl)			;bb09   ; la del canal C
	inc hl			;bb0a
	ld d,(hl)			;bb0b
	ld (0e2a4h),de		;bb0c
	ld (0e2a6h),de		;bb10
	xor a			;bb14   ; sin nota en marcha
	ld (0e29ch),a		;bb15
	ld (0e2aeh),a		;bb18
	ret			;bb1b
canal_a_tabla:		; El canal A desde la tabla
	add a,l			;bb1c   ; + la musica x 6
	ld l,a			;bb1d
	ld e,(hl)			;bb1e   ; el canal A: su pieza...
	inc hl			;bb1f
	ld d,(hl)			;bb20
	ld (0e280h),de		;bb21   ; ...y su principio
	ld (0e282h),de		;bb25
	ret			;bb29

; ----------------------------------------------------------------------
; DATOS piezas: Las piezas de la musica y de los efectos (notas y ordenes
;   0xF0-0xFF)
;   0xbb2a..0xc000  (1238 bytes)
DATA_piezas:
	defb 01ch,000h,000h,0f7h,0a1h,000h,06bh,0a1h,050h,0f7h,0d1h,000h,010h,0d1h,040h,0d1h	; bb2a  ......k.P.....@.
	defb 020h,0d1h,050h,0d1h,030h,0d1h,060h,0d1h,040h,0d1h,070h,0d1h,050h,0d1h,080h,0f7h	; bb3a   .P.0.`.@.p.P...
	defb 0d1h,000h,020h,0d1h,001h,080h,0d1h,000h,030h,0d1h,001h,060h,0d1h,000h,040h,0d1h	; bb4a  .. .....0..`..@.
	defb 001h,040h,0d1h,000h,050h,0d1h,001h,020h,0d1h,000h,060h,0d1h,001h,000h,0f7h,0c1h	; bb5a  .@..P.. ..`.....
	defb 000h,060h,0c1h,050h,0c1h,040h,0c1h,030h,0c1h,048h,0c1h,038h,0c1h,028h,0c1h,018h	; bb6a  .`.P.@.0.H.8.(..
	defb 0f7h,0d1h,000h,0d0h,0d1h,0c0h,0d1h,0b0h,0d1h,0a0h,0d1h,090h,0d1h,080h,0d1h,070h	; bb7a  ...............p
	defb 0f7h,0d1h,000h,080h,0d1h,030h,0d1h,02eh,0d1h,02ch,0d1h,02ah,0d1h,028h,0f7h,0f0h	; bb8a  .....0...,.*.(..
	defb 002h,01ch,008h,002h,05ah,0f7h,01ch,000h,000h,0ffh,064h,002h,081h,064h,081h,064h	; bb9a  ....Z.....d..d.d
	defb 001h,0ach,064h,0ach,064h,002h,0a7h,064h,0a7h,083h,001h,0ach,083h,0c5h,083h,0fch	; bbaa  ..d.d..d........
	defb 083h,002h,03bh,064h,002h,081h,064h,081h,064h,001h,0ach,064h,0ach,048h,002h,081h	; bbba  ..;d..d.d..d.H..
	defb 0ffh,0fdh,003h,063h,000h,0a0h,063h,08fh,063h,07fh,063h,06bh,0fch,048h,000h,0a0h	; bbca  ...c..c.c.ck.H..
	defb 0ffh,044h,001h,0fch,0feh,063h,000h,0feh,063h,001h,01dh,064h,000h,0feh,064h,001h	; bbda  .D...c..c..d..d.
	defb 040h,064h,000h,0feh,064h,001h,01dh,063h,000h,0feh,064h,0d6h,082h,0d6h,082h,0e2h	; bbea  @d..d..c..d.....
	defb 064h,0d6h,048h,0a0h,0ffh,048h,002h,081h,048h,003h,057h,0feh,064h,001h,0fch,064h	; bbfa  d.H..H..H.W.d..d
	defb 001h,0ach,064h,001h,0fch,064h,001h,0ach,0feh,064h,001h,0ach,064h,001h,07dh,064h	; bc0a  ..d..d...d..d.}d
	defb 001h,053h,063h,000h,0d6h,081h,0d6h,064h,0feh,063h,0feh,081h,0feh,064h,001h,040h	; bc1a  .Sc....d.c...d.@
	defb 063h,000h,0aah,081h,0aah,063h,0beh,081h,0beh,064h,0d6h,063h,07fh,081h,07fh,063h	; bc2a  c....c...d.c...c
	defb 08fh,081h,08fh,048h,0d6h,0ffh,064h,003h,057h,064h,002h,03bh,064h,003h,057h,063h	; bc3a  ...H..d.Wd.;d.Wc
	defb 002h,0a7h,081h,0a7h,064h,081h,063h,081h,081h,081h,064h,002h,0fah,063h,002h,0a7h	; bc4a  ....d.c...d..c..
	defb 081h,0a7h,063h,081h,081h,081h,064h,03bh,063h,03bh,081h,03bh,063h,0fah,081h,0fah	; bc5a  ..c...d;c;.;c...
	defb 048h,0a7h,0feh,083h,0fch,083h,064h,001h,053h,064h,001h,040h,064h,001h,01dh,063h	; bc6a  H.....d.Sd.@d..c
	defb 000h,0aah,081h,0aah,064h,0d6h,063h,0d6h,081h,0d6h,064h,000h,0feh,063h,000h,08fh	; bc7a  ....d.c...d..c..
	defb 081h,08fh,063h,0a0h,081h,0a0h,064h,0aah,063h,06bh,081h,06bh,063h,071h,081h,071h	; bc8a  ..c...d.ck.kcq.q
	defb 048h,0aah,0feh,082h,000h,0a6h,082h,0beh,082h,0aah,082h,0a0h,082h,0beh,082h,0aah	; bc9a  H...............
	defb 082h,0a0h,082h,08fh,082h,0aah,082h,0a0h,082h,08fh,082h,07fh,082h,0a0h,082h,08fh	; bcaa  ................
	defb 082h,07fh,082h,06bh,0ffh,082h,002h,081h,082h,002h,0a7h,064h,002h,0fah,082h,003h	; bcba  ...k.......d....
	defb 057h,064h,002h,0fah,082h,002h,081h,062h,001h,0fch,082h,001h,0ach,082h,001h,0c5h	; bcca  Wd.....b........
	defb 064h,002h,03bh,048h,002h,081h,0feh,091h,000h,000h,0fdh,000h,082h,000h,0d6h,082h	; bcda  d.;H............
	defb 0beh,082h,0aah,082h,0a0h,082h,0beh,082h,0aah,082h,0a0h,082h,08fh,082h,0aah,082h	; bcea  ................
	defb 0a0h,082h,08fh,082h,07fh,082h,0a0h,082h,08fh,082h,07fh,082h,06bh,0fch,026h,000h	; bcfa  ............k.&.
	defb 050h,0ffh,026h,000h,040h,0ffh,081h,000h,000h,026h,020h,0ffh,0a1h,000h,010h,0a1h	; bd0a  P.&.@....& .....
	defb 020h,0a1h,030h,0a1h,040h,0a1h,050h,0a1h,060h,0a1h,070h,0ffh,0a1h,000h,080h,0a1h	; bd1a   .0.@.P.`.p.....
	defb 090h,0a1h,0a0h,0a1h,0b0h,0a1h,0c0h,0a1h,0d0h,0a1h,0e0h,0a1h,0f0h,0ffh,064h,002h	; bd2a  ..............d.
	defb 081h,082h,001h,040h,0feh,0cah,00eh,001h,01dh,0feh,082h,000h,0a0h,082h,07fh,082h	; bd3a  ...@............
	defb 06bh,082h,07fh,082h,06bh,082h,071h,082h,08fh,082h,06bh,082h,07fh,064h,050h,0ffh	; bd4a  k...k.q...k..dP.
	defb 063h,002h,0cfh,081h,005h,09eh,081h,09eh,063h,002h,0cfh,0fch,0fdh,002h,063h,006h	; bd5a  c.......c.....c.
	defb 04eh,063h,003h,027h,081h,006h,04eh,081h,04eh,063h,003h,027h,0fch,0ffh,082h,000h	; bd6a  Nc.'..N.Nc.'....
	defb 0aah,082h,0beh,063h,0d6h,082h,0aah,082h,0beh,063h,08fh,081h,07fh,081h,07fh,082h	; bd7a  ...c.....c......
	defb 08fh,081h,0a0h,062h,0aah,062h,0d6h,081h,07fh,081h,071h,062h,06bh,081h,07fh,081h	; bd8a  ...b.b....qbk...
	defb 071h,063h,06bh,081h,08fh,081h,0a0h,081h,0aah,081h,0beh,046h,0d6h,082h,07fh,082h	; bd9a  qck........F....
	defb 08fh,064h,0a0h,082h,07fh,082h,08fh,064h,06bh,082h,0a0h,082h,08fh,082h,07fh,082h	; bdaa  .d.....dk.......
	defb 071h,082h,0d6h,082h,0feh,082h,0e2h,082h,0d6h,082h,08fh,082h,071h,082h,08fh,082h	; bdba  q...........q...
	defb 08eh,046h,08fh,062h,071h,062h,07fh,062h,08fh,062h,0a0h,0feh,0fdh,004h,066h,003h	; bdca  .F.bqb.b.b....f.
	defb 057h,066h,004h,075h,0fch,0fdh,002h,066h,002h,081h,066h,003h,057h,0fch,0fdh,001h	; bdda  Wf.u...f..f.W...
	defb 066h,002h,03bh,066h,002h,0fah,0fch,0fdh,001h,066h,003h,057h,066h,004h,075h,0fch	; bdea  f.;f.....f.Wf.u.
	defb 0fdh,004h,066h,002h,081h,066h,003h,057h,0fch,0fdh,004h,066h,002h,03bh,066h,002h	; bdfa  ..f..f.W...f.;f.
	defb 0fah,0fch,0ffh,082h,000h,0d6h,082h,0beh,063h,0aah,082h,0d6h,082h,0beh,063h,0aah	; be0a  ........c.....c.
	defb 081h,06bh,081h,071h,082h,07fh,081h,08fh,062h,07fh,062h,08fh,081h,06bh,081h,05fh	; be1a  .k.q....b.b..k._
	defb 062h,055h,081h,05fh,081h,055h,063h,050h,081h,055h,081h,05fh,081h,06bh,081h,071h	; be2a  bU._.UcP.U._.k.q
	defb 081h,07fh,081h,08fh,064h,08fh,0ffh,0fdh,004h,082h,003h,057h,082h,004h,075h,0fch	; be3a  ....d......W..u.
	defb 0fdh,002h,082h,002h,081h,082h,003h,057h,0fch,0fdh,001h,082h,002h,03bh,082h,002h	; be4a  .......W.....;..
	defb 0fah,0fch,0fdh,001h,082h,003h,057h,082h,004h,075h,0fch,0fdh,004h,082h,002h,081h	; be5a  ......W..u......
	defb 082h,003h,057h,0fch,0fdh,004h,082h,002h,03bh,082h,002h,0fah,0fch,0ffh,0fdh,004h	; be6a  ..W.....;.......
	defb 048h,003h,057h,048h,004h,075h,0fch,0fdh,002h,048h,002h,081h,048h,003h,057h,0fch	; be7a  H.WH.u...H..H.W.
	defb 0fdh,001h,048h,002h,03bh,048h,002h,0fah,0fch,0ffh,001h,048h,003h,057h,048h,004h	; be8a  ..H.;H.....H.WH.
	defb 075h,0fch,0fdh,004h,048h,002h,081h,048h,003h,057h,0fch,0fdh,004h,048h,002h,03bh	; be9a  u...H..H.W...H.;
	defb 048h,002h,0fah,0fch,0ffh,064h,000h,0d6h,082h,0beh,082h,0aah,064h,0beh,082h,0aah	; beaa  H....d......d...
	defb 082h,0a0h,064h,0aah,082h,0a0h,082h,08fh,064h,0a0h,082h,08fh,082h,07fh,064h,06bh	; beba  ..d.....d.....dk
	defb 064h,071h,064h,07fh,064h,08fh,064h,0d6h,082h,0beh,064h,0d6h,082h,0aah,064h,08fh	; beca  dqd.d.d...d...d.
	defb 082h,0beh,082h,0aah,064h,0a0h,082h,0aah,082h,0a0h,064h,08fh,082h,0a0h,082h,08fh	; beda  ....d.....d.....
	defb 064h,07fh,082h,08fh,082h,07fh,064h,071h,082h,08fh,082h,08fh,082h,07fh,082h,07fh	; beea  d.....dq........
	defb 082h,071h,082h,071h,082h,06bh,082h,071h,082h,07fh,082h,08fh,064h,08fh,0feh,08fh	; befa  .q.q.k.q....d...
	defb 062h,0a0h,0feh,08fh,062h,0a0h,0feh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf0a  b...b...........
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf1a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf2a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf3a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf4a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf5a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf6a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b2h,001h,003h,00ah,00eh,007h,0feh,011h,000h,007h	; bf7a  ................
	defb 005h,05ch,00ch,004h,001h,005h,05ch,003h,005h,002h,013h,05ch,008h,00eh,006h,00ah	; bf8a  .\....\....\....
	defb 05ch,003h,01ah,002h,013h,05ch,011h,01eh,002h,005h,05ch,0ffh,004h,007h,013h,004h	; bf9a  \....\....\.....
	defb 0f3h,008h,007h,007h,00ah,0f3h,008h,014h,006h,00ah,0f3h,012h,007h,013h,004h,0f3h	; bfaa  ................
	defb 0ffh,008h,000h,060h,050h,0ffh,002h,001h,038h,03ah,002h,001h,036h,038h,0ffh,0ffh	; bfba  ...`P...8:..68..
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfca  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfda  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0afh,032h,011h,0e0h,032h,027h,0e0h,0c3h,023h,085h	; bfea  .......2..2'..#.
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bffa
