"""Uso: escondidas.py [<dir>]

Koneko: las pantallas que hay detras de la casita de la meta. 1) pantalla_siguiente (0x94D3) EJECUTADA desde la
posicion 8 en cada fase: que pantalla sale; 2) escena_pon (0x9B15) EJECUTADA con la RAM y la VRAM grabadas en la propia
fase (work/forzada.bin) para las pantallas 0x66 (fase 7, ROUND2-2) y 0x67 (fase 14, ROUND3-3)."""
import os
import sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
os.chdir(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import vdp
from bios import Msx
rom = open("koneko.rom", "rb").read()
salida = os.path.abspath(sys.argv[1]) if len(sys.argv) > 1 else None
for fase in range(18):
    m = Msx(rom, 0x4000)
    m.mem[0xE03D] = fase; m.mem[0xE03E] = 8; m.mem[0xE198] = 0
    camino = []
    for _ in range(4):
        m.mem[0xE198] = 0
        m.llama(0x94D3)
        camino.append((m.mem[0xE03E], m.mem[0xE03F], m.mem[0xE198]))
    print("ROUND%d-%d (fase %2d): desde la meta ->" % (fase // 6 + 1, fase % 6 + 1, fase),
          ", ".join("pos %d pant %02X%s" % (p, q, "" if c else " (se queda)") for p, q, c in camino))
if salida:
    cuadros = {}
    for c in vdp.cuadros("work/forzada.bin"):
        f = c["ram"][0x3D]
        if f in (7, 14) and c["ram"][0x3E] == 0 and c["ram"][0x000] and c["regs"][1] & 0x40:
            cuadros[f] = c          # el ultimo con la pantalla encendida en la primera posicion
    for f, pant, nombre in ((7, 0x66, "escondida_2-2.png"), (14, 0x67, "escondida_3-3.png")):
        c = cuadros[f]
        m = Msx(rom, 0x4000)
        m.mem[0xE000:0xF000] = c["ram"]
        m.mem[0xE03F] = pant
        m.llama(0x9B15)
        v = bytearray(c["vram"])
        v[0x1840:0x1840 + 22 * 32] = m.mem[0xE700:0xE700 + 22 * 32]
        im = vdp.imagen(bytes(v), c["regs"], escala=2, con_sprites=False)
        im.crop((0, 32, 512, 384)).save(os.path.join(salida, nombre), optimize=True)   # sin el marcador grabado
        print("pintada", nombre)
