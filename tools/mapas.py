"""Los mapas de las 18 fases de Koneko, PINTADOS EJECUTANDO LA ROM: para cada fase, sus pantallas en el orden de su
lista (0x4038), cada una montada por escena_pon (0x9B15) con la RAM y la VRAM grabadas en esa fase (work/forzada.bin:
los dibujos y colores de las casillas son los de su escena). Una tira por fase, de izquierda a derecha, sin
marcador ni sprites; un PNG por pueblo (seis tiras).

Cotejo: cada pantalla montada contra la tabla de nombres grabada en los cuadros en que el juego la tiene quieta
(0xE03F esa pantalla, 0xE198 = 0; los ultimos 40 cuadros, porque pantalla_cambia pone 0xE198 a 0 antes de correr la
pantalla): cuantas casillas distintas en el mejor cuadro (lo que cambia son los objetos y
lo animado, que el juego pinta despues).

Uso: mapas.py docs/imagenes
"""
import os
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, AQUI)
import vdp                  # noqa: E402
from bios import Msx        # noqa: E402
from PIL import Image       # noqa: E402

RAIZ = os.path.dirname(AQUI)
ROM = open(os.path.join(RAIZ, "koneko.rom"), "rb").read()
PUEBLOS = ["PEACH", "APPLE", "LEMON"]


def lista(fase):
    p = ROM[0x4038 - 0x4000 + 2 * fase] | ROM[0x4039 - 0x4000 + 2 * fase] << 8
    out = [ROM[p - 0x4000]]             # la primera puede ser la pantalla 0
    p += 1
    while True:
        s = ROM[p - 0x4000]
        if s in (0, 0xFF):              # 0: no hay mas; 0xFF: vuelve a la posicion 3
            return out
        out.append(s)
        p += 1


def monta(c, pantalla):
    m = Msx(ROM, 0x4000)
    m.mem[0xE000:0xF000] = c["ram"]
    m.mem[0xE03F] = pantalla
    m.llama(0x9B15)
    return bytes(m.mem[0xE700:0xE700 + 22 * 32])


def main(salida):
    cuadro = {}                         # fase -> un cuadro con la pantalla encendida
    grabadas = {}                       # (fase, pantalla) -> tablas de nombres grabadas con ella quieta
    for c in vdp.cuadros(os.path.join(RAIZ, "work", "forzada.bin")):
        r = c["ram"]
        if not (r[0x000] and c["regs"][1] & 0x40):
            continue
        f = r[0x3D]
        if f < 18 and r[0x3E] == 0:
            cuadro[f] = c
        if f < 18 and r[0x198] == 0:
            g = grabadas.setdefault((f, r[0x3F]), [])
            g.append(c["vram"][0x1840:0x1840 + 22 * 32])      # los ultimos: los primeros son del scroll
            del g[:-40]
    total = [0, 0]
    for pueblo in range(3):
        tiras = []
        for f in range(pueblo * 6, pueblo * 6 + 6):
            c = cuadro[f]
            pants = lista(f)
            tira = Image.new("RGB", (256 * len(pants), 176))
            notas = []
            for k, p in enumerate(pants):
                nombres = monta(c, p)
                v = bytearray(c["vram"])
                v[0x1840:0x1840 + len(nombres)] = nombres
                im = vdp.imagen(bytes(v), c["regs"], 1, con_sprites=False).crop((0, 16, 256, 192))
                tira.paste(im, (256 * k, 0))
                g = grabadas.get((f, p))
                if g:
                    d = min(sum(1 for a, b in zip(nombres, x) if a != b) for x in g)
                    notas.append("%02X:%d" % (p, d))
                    total[0] += 1
                    total[1] += d
                else:
                    notas.append("%02X:-" % p)
            print("ROUND%d-%d (%d pantallas)  casillas distintas de la grabada: %s" % (pueblo + 1, f % 6 + 1, len(pants), " ".join(notas)))
            tiras.append(tira)
        ancho = max(t.size[0] for t in tiras)
        hoja = Image.new("RGB", (ancho, 176 * 6 + 8 * 5), (0, 0, 0))
        for i, t in enumerate(tiras):
            hoja.paste(t, (0, i * (176 + 8)))
        hoja = hoja.resize((hoja.size[0] // 2, hoja.size[1] // 2), Image.NEAREST)
        ruta = os.path.join(salida, "mapa_%s.png" % PUEBLOS[pueblo].lower())
        hoja.save(ruta, optimize=True)
        print(ruta, hoja.size)
    print("pantallas cotejadas: %d, casillas distintas en total: %d" % tuple(total))


if __name__ == "__main__":
    main(sys.argv[1])
