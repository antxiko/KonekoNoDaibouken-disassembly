# Under the hood

## Rebuilding the ROM

`make verify` assembles `src/koneko.asm` with pasmo and out comes the 32 KB ROM **byte for byte**. `make sanity`
checks what reassembly does not cover: that no byte declared as data is read as code, that no entry point falls in data
and that all 32,768 bytes are explained. `make test` runs the tests. The ROM is not in the repository: put it in the
root as `koneko.rom` (the GoodMSX dump, `[!]`, sha1 `0039cff2...`).

| | bytes |
|---|---|
| traced code | 10,785 |
| named data | 21,983 |
| unexplained | 0 |

The listing has 2,047 comments in 4,891 instructions (41.9%), 625 routines and labels, none under 10% commented, and no
called routine without a name.

## The cartridge

32 KB at 0x4000-0xBFFF, with the header at 0x4000. INIT (0x4010) also puts the cartridge in page 2 and jumps to
0x8000. The data: the screens of each stage and the 104 screens (0x4038-0x56BF and 0xA840-0xAD84), the sprite drawings
(0x56C0-0x5FFF), the tiles and their colours (0x6000-0x7EFF), the controls list of one demo (0x7F00) and the title
tiles (0x7F81); the screen pieces (0xAD85), their enemies and objects (0xB000) and the sound (0xB700-0xBFFF). The code
goes from 0x8000 to 0xA83C.

## The BIOS it uses

RSLREG and ENASLT for the slot; SETGRP, CHGCLR, WRTVDP, DISSCR and ENASCR; FILVRM, LDIRVM and WRTVRM; GTSTCK and GTTRIG
for the controls and SNSMAT for the space bar, GRAPH, STOP, F1, SELECT and ESC; WRTPSG for the sound; and the BIOS font
(0x1D3F).

## The interrupt and the loop

INIT puts a jump to 0x8E75 in the H.TIMI hook. The interrupt runs the sound, counts frames, reads the buttons, the
stick, STOP and F1; in the demo, it is the one that moves the stick and the buttons. The game runs in the **stage
loop** (`fase_bucle`, 0x82C2): once per frame, the water animations, the screen's enemies and objects, the flashing,
the fall, the kitten, the jump, the throw, the screen change, the time, the points, the enemies and the objects.

**Screens.** The screen is built in RAM (0xE700) with its background, the ground, strips of tiles, rectangles and
drawings (`escena_pon`, 0x9B15). When it changes, the current one and the new one are put side by side at 0xE9C0 and
the window moves one column 32 times, every 2 frames (`pantalla_cambia`, 0x9977). Tiles from 0x80 let it through;
0x40-0x7F are walls and 0x50-0x5F, ceilings as well.

## How it was done

The trace follows the code from INIT, the interrupt and two jump tables (the objects and the enemies), declared in
`src/koneko.entries`. The rest was **measured in openMSX** (`tools/omsx_cobertura.tcl`) on a Philips VG 8020, waiting
for the demo and playing: nothing that ran was left out of the trace.

The recordings for the site (`tools/guiones/*.tcl`, recorded with `tools/lanza_graba.ps1` on C-BIOS) log, on every
frame, the VDP registers, the RAM from 0xE000, the PSG and the VRAM that changed. `tools/pantallas.py` runs the title
with `tools/bios.py` (with the font C-BIOS left in the VRAM) and checks it against the recording (**0 different
points**), `tools/gifs.py` makes the GIFs and `tools/musica.py` runs the sound engine.

## The RAM

| | |
|---|---|
| 0xE000 | playing |
| 0xE001-0xE006 | the points, one digit per byte |
| 0xE009 / 0xE00A / 0xE00B | the town / the stage (0-17) / the lives (BCD) |
| 0xE00C-0xE00E | the points, in BCD |
| 0xE020 / 0xE022 | throw / jump, just pressed |
| 0xE023 / 0xE039 | SELECT / ESC on the title |
| 0xE027 / 0xE037 | the demo / its list of controls |
| 0xE03B / 0xE03C | the balloon and what is thrown, from one stage to the next |
| 0xE03D / 0xE03E / 0xE03F | the stage, the position and the screen |
| 0xE040-0xE047 | TIME: the count and its digits |
| 0xE048 / 0xE049 | the stage within the town / the town (0-2) |
| 0xE04F | the 50,000 life, already given |
| 0xE183 / 0xE186 | the kitten hit (2: even with SELECT) / the stage over |
| 0xE198 | the screen change |
| 0xE1B3 / 0xE1B7 | F1 / STOP |
| 0xE280-0xE2D5 | the sound |
| 0xE300 | the kitten (+8 what it throws, +0x1D the balloon; +0x70 its throw) |
| 0xE380 | the 8 enemies (16 bytes each) |
| 0xE400 | the 12 objects (16 bytes each) |
| 0xE700 | the screen in RAM |
| 0xE9C0 | two screens side by side, when changing |
| 0xEE80 | the objects saved during the pause |
