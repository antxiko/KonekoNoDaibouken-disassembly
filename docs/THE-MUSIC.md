# The music

Five tunes, in three voices. They are not recordings made by hand: `tools/musica.py` **runs the ROM's own sound
engine** with `tools/z80run.py` -the sound routine (`sonido`, 0xB770), frame by frame, with the number the game writes-
and logs what it writes to the PSG through the BIOS (WRTPSG).

**Checked against openMSX**: the tone and volume registers of the three channels match the recorded ones, **0
different** on every frame looked at, in all five. Four recordings are checked (`tools/guiones/`): the title with the
demos, a game up to GAME OVER, one with SELECT and the forced run through the stages. Each recorded frame is paired
with the engine frame that has the same RAM in the three channels; while an effect plays on a channel, that channel is
not looked at.

## The engine

It is the same engine as other Casio cartridges of those years. It runs once per frame from the interrupt and takes
three **requests**: a tune (0xE2BE), an effect for channel A (0xE2C0) and another for B and C (0xE2C2); the lower
number wins (`musica_pide`, 0xB76B). The tables: six tunes at 0xB700 (0 is silence), eight channel A effects at
0xB724, six B and C ones at 0xB734 and fourteen note lengths at 0xBA21. The title has no music.

| | Who asks for it | Length |
|---|---|---:|
| the CASIO intro | the CASIO logos meet (0x8FFE) | 1.1 s |
| the stage | the stage starts (0x82A3) | 3.2 s |
| the stage over | the balloon at the end of a stage and the ending (0x865D, 0x885B) | 4.5 s |
| the balloon | taking a balloon or the prize with a life (0xA3AA, 0x9F23) | 2.1 s |
| GAME OVER | no lives left (0x8601) | 3.8 s |

None starts again: they all end.

## The CASIO intro

<audio controls src="audio/musica_casio.mp3"></audio>

## The stage

<audio controls src="audio/musica_fase.mp3"></audio>

## The stage over

<audio controls src="audio/musica_fase_acabada.mp3"></audio>

## The balloon

<audio controls src="audio/musica_globo.mp3"></audio>

## GAME OVER

<audio controls src="audio/musica_game_over.mp3"></audio>
