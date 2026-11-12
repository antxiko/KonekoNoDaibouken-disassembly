#!/usr/bin/env python3
"""Los sprites de Koneko no Daibouken MONTADOS DESDE LA ROM (ninguna imagen es una captura).

Los dibujos son los 0x800 bytes de 0x5800 que `sprites_dibujos` (0x8CD4) pone en 0x3800, y segun la escena (0xE04A)
cambia algunos: salvo en la 5, 0x40 bytes de 0x57A0 al dibujo 0x4C y de 0x56C0 al 0xCC; en la 4, ademas, 0x6F30 al 0x68
y 0x6F70 al 0xE8. Asi un mismo numero es un bicho distinto segun la escena. Sprites de 16 x 16.

  gatito.png         el gatito: dos sprites, el dibujo (+0x1C) en blanco y el + 4 en magenta 8 puntos mas abajo
                     (`gatito_dibujo` 0x9907, colores de `fase` 0x821B): de pie y andando 0x00 y 0x08 (el paso, el bit
                     2 de la X, 0x959C), tocado 0x10 (0x8545), saltando de lado 0x18 (0x98A6), agachado 0x20, y + 0x80
                     mirando a la izquierda; llevando algo encima (`gatito_lleva`, 0x9933), lo que lleva
                     16 puntos por encima (0x34 de pie, 0x28 andando, 0x40 agachado, en blanco) y el gatito con ese
                     dibujo + 4 y + 8 en el mismo sitio
  enemigos.png       los tipos de 0xE380 (16 bytes, +4 el tipo), un sprite cada uno con su dibujo y el + 4 al andar, y +
                     0x80 hacia el otro lado: el 0 y el 1 (`andarin`: 0x68, blanco; en la escena 4, 0x68 es otro
                     dibujo y va en magenta), el 2 (`aparece`: 0xF0, rojo claro y amarillo claro), el 3 (`regalo`: 0xE4,
                     amarillo claro y blanco), el 4 (`andarin_alto`: 0x5C, amarillo claro), el 5 (`saltarin`: 0x54,
                     blanco), el 6 (`paseante`: 0x4C en la escena 5, rojo), el 7 (`volador`: 0x4C con los dibujos de las
                     otras escenas, amarillo claro o negro) y la explosion (0xF8 y 0xFC, `explosion`)
  andar_cuadros.gif  el gatito andando a los dos lados y los enemigos andando

Uso: hojas.py docs/imagenes | hojas.py cotejo
"""
import os
import sys

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))
import vdp          # noqa: E402

ORG = 0x4000
ROM = open(os.path.join(RAIZ, "koneko.rom"), "rb").read()
FONDO = (40, 96, 160)
POSES = [0x00, 0x08, 0x10, 0x18, 0x20]
# (tipo, escena para los dibujos, dibujo, colores)
ENEMIGOS = [(1, 0, 0x68, (15,)), (1, 4, 0x68, (13,)), (2, 1, 0xF0, (9, 11)), (3, 0, 0xE4, (11, 15)), (4, 4, 0x5C, (11,)),
            (5, 0, 0x54, (15,)), (6, 5, 0x4C, (8,)), (7, 4, 0x4C, (11,)), (7, 2, 0x4C, (1,))]


CAMBIAN = set(range(0x260, 0x2A0)) | set(range(0x340, 0x380)) | set(range(0x660, 0x6A0)) | set(range(0x740, 0x780))


def r(a, n):
    return ROM[a - ORG:a - ORG + n]


def patrones(escena=0):
    """sprites_dibujos (0x8CD4) en la escena."""
    t = bytearray(r(0x5800, 0x800))
    if escena != 5:
        t[0x260:0x2A0] = r(0x57A0, 0x40)
        t[0x660:0x6A0] = r(0x56C0, 0x40)
    if escena == 4:
        t[0x340:0x380] = r(0x6F30, 0x40)
        t[0x740:0x780] = r(0x6F70, 0x40)
    return bytes(t)


def pinta(im, pat, n, x, y, color, escala=1):
    if color & 15 == 0:
        return
    n &= 0xFC
    d = pat[n * 8:n * 8 + 32]
    c = vdp.PALETA[color & 15]
    for fila in range(16):
        for col in range(16):
            if (d[fila + (16 if col >= 8 else 0)] >> (7 - (col & 7))) & 1:
                for ey in range(escala):
                    for ex in range(escala):
                        px, py = (x + col) * escala + ex, (y + fila) * escala + ey
                        if 0 <= px < im.width and 0 <= py < im.height:
                            im.putpixel((px, py), c)


def gatito(d, lleva=False):
    """Los sprites (dy, dibujo, color) del gatito con el dibujo d (+0x1C), como gatito_dibujo / gatito_lleva."""
    if not lleva:
        return [(0, d, 15), (8, d + 4, 13)]
    b = {0x20: 0x40, 0x08: 0x28}.get(d & 0x7F, 0x34) + (d & 0x80)
    return [(0, b + 4, 15), (0, b + 8, 13), (-16, b, 15)]


def grupo(im, pat, sprites, x, y, E):
    for dy, d, c in reversed(sprites):
        pinta(im, pat, d, x, y + dy, c, E)


def hoja(Image):
    pat, E = patrones(0), 4
    im = Image.new("RGB", (10 * 20 * E, 2 * 44 * E), FONDO)
    for fila, lleva in enumerate((False, True)):
        k = 0
        for lado in (0, 0x80):
            for d in POSES:
                grupo(im, pat, gatito(d + lado, lleva), 2 + 20 * k, 20 + 44 * fila, E)
                k += 1
    return im


def hoja_enemigos(Image):
    E = 3
    im = Image.new("RGB", (len(ENEMIGOS) * 4 * 20 * E // 2 + 20 * E, 3 * 20 * E), FONDO)
    for k, (_, escena, d, colores) in enumerate(ENEMIGOS):
        pat = patrones(escena)
        x = 2 + 84 * (k % 4)
        y = 2 + 20 * (k // 4)
        for j, dd in enumerate(((d, d) if d == 0xE4 else (d, d + 4)) + ((d ^ 0x80, (d ^ 0x80) + 4) if d < 0xE0 else ())):
            pinta(im, pat, dd, x + 20 * j, y, colores[j % len(colores)] if d >= 0xE0 else colores[0], E)
    pat = patrones(0)
    for k, (d, c) in enumerate(((0xF8, 15), (0xFC, 9))):
        pinta(im, pat, d, 2 + 84 + 20 * k, 2 + 40, c, E)
    return im


def anima(Image):
    pat, E, cuadros = patrones(0), 4, []
    for n in range(96):
        im = Image.new("RGB", (5 * 20 * E, 32 * E), FONDO)
        lado = 0 if n < 48 else 0x80
        grupo(im, pat, gatito((8 if n & 4 else 0) + lado), 2, 4, E)    # el paso: el bit 2 de la X (0x959C)
        for k, (d, c) in enumerate(((0x68, 15), (0x5C, 11), (0x54, 15))):
            pinta(im, pat, d + (4 if n & 8 else 0) + lado, 22 + 20 * k, 12, c, E)
        cuadros.append(im)
    return cuadros


def guarda_gif(cuadros, ruta, ms=1000 / 60):
    imgs, durs = [], []
    for im in cuadros:
        if imgs and list(im.getdata()) == list(imgs[-1].getdata()):
            durs[-1] += ms
        else:
            imgs.append(im)
            durs.append(ms)
    imgs[0].save(ruta, save_all=True, append_images=imgs[1:], duration=[max(20, int(round(d))) for d in durs],
                 loop=0, disposal=1)


def cotejo():
    """Contra las grabaciones de openMSX (work/*.bin, la RAM 0xE000-0xEFFF):
    1) la tabla de dibujos de los sprites (VRAM 0x3800-0x3FFF) contra `patrones()` de la escena del cuadro (0xE04A);
    2) el gatito (0xE300, 0xE310, 0xE320) contra `gatito()` con su dibujo (+0x1C) y si lleva algo (+0x1D);
    3) los enemigos (0xE380, 16 bytes): el dibujo de su tipo, + 4, + 0x80 o + 0x84, y su color."""
    tabla = {e: patrones(e) for e in range(6)}
    tipos = {}
    for t, _, d, colores in ENEMIGOS:
        for dd in (d, d + 4) + ((d ^ 0x80, (d ^ 0x80) + 4) if d < 0xE0 else ()):
            for c in colores:
                tipos.setdefault(t, set()).add((dd, c))
    tipos[0] = tipos[1]
    tot = dict(patrones=0, pausa=0, pat_carga=0, pat_mal=0, gatito=0, gatito_tocado=0, gatito_mal=0, enemigos=0,
               enemigos_salen=0, enemigos_explota=0, enemigos_mal=0)
    for grab in ("atraccion", "partida", "continuar", "forzada", "invencible", "prueba", "teclas"):
        ruta = os.path.join(RAIZ, "work", grab + ".bin")
        if not os.path.exists(ruta):
            continue
        try:
            cuadros = list(vdp.cuadros(ruta))
        except AssertionError:
            continue
        for c in cuadros:
            v, ram = c["vram"], c["ram"]
            t = v[0x3800:0x4000]
            pat = tabla.get(ram[0x04A], tabla[0])
            if any(t):
                n = len(t.rstrip(bytes(1)))
                if t == pat:
                    tot["patrones"] += 1
                elif t[:0xA0] == r(0x5700, 0xA0) and t[0xA0:] == pat[0xA0:]:
                    tot["pausa"] += 1               # STOP: los dibujos de la pausa (0x5700)
                elif t[:n] == pat[:n] or any(t == p for p in tabla.values()) or                         all(t[k] == pat[k] for k in range(0x800) if k not in CAMBIAN):
                    tot["pat_carga"] += 1           # cargandose, o aun los de la escena de antes
                else:
                    tot["pat_mal"] += 1
            if ram[0x1B7]:
                continue                            # en la pausa el gatito es otro
            s = [ram[0x300 + 16 * k:0x304 + 16 * k] for k in range(3)]
            if s[0][0] < 0xC0 and ram[0x31C] | ram[0x31D] | s[0][2]:
                quiero = gatito(ram[0x31C], ram[0x31D] != 0)
                hay = [((s[k][0] - s[0][0]) & 0xFF, s[k][2], s[k][3] & 15) for k in range(len(quiero))]
                ok = [((dy - quiero[0][0]) & 0xFF, d, cc) for dy, d, cc in quiero] == hay and \
                    all(s[k][1] == s[0][1] for k in range(len(quiero)))
                if ok:
                    tot["gatito"] += 1
                elif ram[0x31C] & 0x7F == 0x10:
                    tot["gatito_tocado"] += 1       # tocado (0x10): parpadea (color 0) y el de abajo tiembla
                else:
                    tot["gatito_mal"] += 1
            for k in range(8):
                e = ram[0x380 + 16 * k:0x390 + 16 * k]
                if e[0] >= 0xC0 or e[4] not in tipos or (e[2] == 0 and e[3] == 0):
                    continue
                if e[2] in (0xF8, 0xFC):
                    tot["enemigos_explota"] += 1
                elif e[2] == 0 or (e[4] in (0, 1) and e[2] == 0x78):
                    tot["enemigos_salen"] += 1      # al salir: aun sin dibujo, o el 0x78 del andarin (0xA0EB)
                elif (e[2], e[3] & 15) in tipos[e[4]] or (e[3] & 15 == 0):
                    tot["enemigos"] += 1
                else:
                    tot["enemigos_mal"] += 1
    return tot


def main(argv):
    if argv and argv[0] == "cotejo":
        print(cotejo())
        return 0
    from PIL import Image
    salida = argv[0]
    os.makedirs(salida, exist_ok=True)
    hoja(Image).save(os.path.join(salida, "gatito.png"))
    hoja_enemigos(Image).save(os.path.join(salida, "enemigos.png"))
    guarda_gif(anima(Image), os.path.join(salida, "andar_cuadros.gif"))
    for f in ("gatito.png", "enemigos.png", "andar_cuadros.gif"):
        print(f, os.path.getsize(os.path.join(salida, f)))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
