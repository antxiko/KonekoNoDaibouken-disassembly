# Koneko no Daibouken - commented disassembly

*(También [en castellano](README.es.md).)*

The commented disassembly of **Koneko no Daibouken** (Casio, 1986) for the MSX: a 32 KB cartridge with its header at 0x4000.

- **100%** of the binary explained: 10,785 bytes of code and 21,983 of named data, not one byte unassigned.
- **41.9%** of the listing commented, 625 routines and labels, none below 10% of comments.
- The listing reassembles into the original ROM **byte for byte**.
- The title comes from running the ROM, checked against openMSX point by point; the CASIO intro, the demo, the six scenes, a balloon, the end of a stage, a town cleared, the ending, STOP, F1 and the continue trick, played in GIF in openMSX; the five tunes, from its own sound engine, identical to openMSX frame by frame.

The site: <https://antxiko.github.io/KonekoNoDaibouken-disassembly/>
(in Spanish: <https://antxiko.github.io/KonekoNoDaibouken-disassembly/es/>).

## Reproducing it

The ROM image is not distributed. Put yours in the root as `koneko.rom` (sha256 `e6eb6105...`) and run `make`. The details, in [UNDER THE HOOD](docs/UNDER-THE-HOOD.md).

## Legal

The game belongs to Casio and its rights holders. The licence in `LICENSE` covers only the tools, the comments, the analysis and the documentation here. See [LEGAL-NOTICE.md](LEGAL-NOTICE.md).
