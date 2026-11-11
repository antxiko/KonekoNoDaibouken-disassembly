"""Los GIF de la web: tramos de las grabaciones de openMSX (tools/guiones/*.tcl, grabados con
tools/lanza_graba.ps1 en C-BIOS_MSX1_JP, -bp 0x8E75 -ram "0xE000 0x1000"), pintados con tools/vdp.py; cada imagen
dura el tiempo emulado que dura en la grabacion.

Los tramos salen de la RAM grabada: 0xE000 jugando, 0xE027 la demostracion, 0xE00A la fase, 0xE009 el pueblo,
0xE00B las vidas, 0xE183 el gatito tocado, 0xE186 la fase acabada, 0xE03E la pantalla, 0xE1B7 STOP, 0xE1B3 F1,
0xE31D lo que lleva encima, 0xE2BD la musica.

  atraccion   sin tocar nada: la presentacion de CASIO, el titulo y las demostraciones
  partida     un piloto sencillo (tools/guiones/partida.tcl): pierde las cinco vidas en la primera pantalla
  invencible  el mismo piloto con SELECT pulsada en el titulo: coge un globo
  forzada     el mismo piloto con SELECT; cada fase se da por acabada con un poke (FORZADA): las 18 fases y el final
  teclas      STOP y F1
  continuar   ESC pulsada en el titulo: sin vidas, CONTINUE PUSH TRIG1 y cuatro vidas mas

Las grabaciones son grandes: cada una se lee UNA vez.

Uso: gifs.py docs/imagenes
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import vdp          # noqa: E402

# (fichero, grabacion, desde, hasta, cada)
TRAMOS = [
    ("presentacion.gif", "atraccion", 1, 200, 2),       # la presentacion de CASIO
    ("titulo.gif", "atraccion", 200, 450, 3),           # el titulo: el gatito lo cruza y sale su nombre
    ("demostracion.gif", "atraccion", 2900, 3700, 3),   # la demostracion de la fase 5
    ("salida.gif", "partida", 400, 760, 2),             # la primera fase: el prado
    ("tocada.gif", "partida", 700, 870, 2),             # tocado: sube, cae y la fase otra vez
    ("game_over.gif", "partida", 3300, 3744, 3),        # la ultima vida y GAME OVER
    ("globo.gif", "invencible", 960, 1140, 2),          # coge un globo: lo lleva encima
    ("bosque.gif", "forzada", 2800, 3200, 2),           # la fase 1-2: el bosque
    ("cascadas.gif", "forzada", 4800, 5200, 2),         # la fase 1-3: las cascadas
    ("lago.gif", "forzada", 6800, 7200, 2),             # la fase 1-4: el lago
    ("ladrillos.gif", "forzada", 8800, 9200, 2),        # la fase 1-5: los ladrillos
    ("ciudad.gif", "forzada", 10800, 11200, 2),         # la fase 1-6: la ciudad
    ("fase_acabada.gif", "forzada", 1880, 2420, 3),     # la fase acabada: el globo y el tiempo cobrado
    ("pueblo.gif", "forzada", 11840, 12420, 3),         # CLEAR PEACH TOWN y GO TO APPLE
    ("final.gif", "forzada", 34580, 35660, 3),          # la ultima fase acabada (el globo T) y el final: GREAT!! I LOVE YOU
    ("pausa.gif", "teclas", 880, 1450, 3),              # STOP
    ("f1.gif", "teclas", 1790, 1900, 2),                # F1: una vida menos
    ("continuar.gif", "continuar", 5300, 5420, 2),      # ESC en el titulo: CONTINUE PUSH TRIG1
]


def main(salida):
    raiz = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    for grab in dict.fromkeys(t[1] for t in TRAMOS):
        mios = [t for t in TRAMOS if t[1] == grab]
        gifs = {t[0]: vdp.Gif() for t in mios}
        tope = max(t[3] for t in mios) + max(t[4] for t in mios)
        espera = {}                                    # fichero -> (imagen, t) pendiente de su duracion
        for n, c in enumerate(vdp.cuadros(os.path.join(raiz, "work", grab + ".bin"))):
            if n > tope:
                break
            for fichero, _, desde, hasta, cada in mios:
                if desde <= n <= hasta + cada and (n - desde) % cada == 0:
                    if fichero in espera:
                        im, t = espera.pop(fichero)
                        gifs[fichero].pon(im, (c["t"] - t) * 1000.0 / gifs[fichero].ms)
                    if n <= hasta:
                        espera[fichero] = (vdp.imagen(c["vram"], c["regs"], 1), c["t"])
        for fichero, _, desde, hasta, cada in mios:
            if fichero in espera:                       # la grabacion acaba antes: la ultima, un paso
                im, _t = espera.pop(fichero)
                gifs[fichero].pon(im, cada)
            ruta = os.path.join(salida, fichero)
            gifs[fichero].guarda(ruta, 4000)
            print("%-24s %4d imagenes, %8d bytes" % (fichero, len(gifs[fichero]), os.path.getsize(ruta)))


if __name__ == "__main__":
    main(sys.argv[1])
