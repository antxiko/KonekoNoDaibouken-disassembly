#!/usr/bin/env python3
"""EL CONTENIDO de la web de esta ROM: lo unico que es de este juego.

jekyll.py y make_web.py son la maquinaria y no llevan dentro el nombre de
ningun juego: lo leen de aqui.

Todas las cifras de aqui estan medidas sobre esta ROM, con las herramientas
de tools/: CODIGO y DATOS los imprime tools/presupuesto.py (make sanity),
INSTRUCCIONES, COMENTARIOS y RUTINAS los da tools/densidad.py (make densidad:
"de N" rutinas, "N instrucciones, M comentarios").
"""

NOMBRE = "Koneko no Daibouken"
EDITOR = "Casio"
ANIO = 1986
REPOSITORIO = "https://github.com/antxiko/KonekoNoDaibouken-disassembly"
SHA1 = "0039cff292fe740d8c87cc2131a473cbb4f8c4f4"

CODIGO = 10785
DATOS = 21983
RUTINAS = 625
INSTRUCCIONES = 4891
COMENTARIOS = 2047


def densidad(idioma):
    """El porcentaje comentado, con la coma o el punto de cada idioma."""
    d = "%.1f" % (100.0 * COMENTARIOS / INSTRUCCIONES)
    return d.replace(".", ",") if idioma == "es" else d


PIE_LEGAL = {
    "es": "<em>Koneko no Daibouken</em> es un juego de Casio para MSX, de 1986, en un cartucho de 32 KB. Todos los "
          "derechos sobre el juego siguen siendo de sus titulares. Este trabajo es de preservaci&oacute;n, estudio "
          "y documentaci&oacute;n, y la imagen de la ROM no se distribuye.",
    "en": "<em>Koneko no Daibouken</em> is a 1986 Casio game for the MSX, on a 32 KB cartridge. All rights in the game "
          "remain with their holders. This is preservation, study and documentation work, and the ROM image is not "
          "distributed.",
}

PORTADA = {
    "es": dict(
        titulo="Koneko no Daibouken - desensamblado comentado",
        claim="Un gatito cruza tres pueblos, PEACH, APPLE y LEMON, de seis fases cada uno: prados, bosques, cascadas, "
              "lagos, ladrillos y ciudades, contra el reloj, saltando y tirando lo que encuentra; al final de cada "
              "fase sube un globo, y los tres &uacute;ltimos dicen CAT. El t&iacute;tulo sale de ejecutar la ROM, "
              "cotejado con openMSX punto a punto; la partida en GIF, jugada en openMSX; las cinco m&uacute;sicas, "
              "de su propio motor, id&eacute;nticas a openMSX cuadro a cuadro.",
        ficha=["Casio - <b>(c) 1986</b>",
               "Cartucho de <b>32 KB</b> (cabecera en 0x4000)",
               "<b>MSX</b>", "Volcado <b>0039cff2...</b>"],
        aviso="<b>Aqu&iacute; no hay capturas del juego.</b> El t&iacute;tulo sale de ejecutar la ROM (cotejado "
              "con openMSX) y los GIF son la ROM <b>funcionando en openMSX</b>: en cada cuadro se apuntan la VRAM, "
              "la RAM y los registros del VDP, y <b>c&oacute;digo nuestro los pinta</b>.",
    ),
    "en": dict(
        titulo="Koneko no Daibouken - commented disassembly",
        claim="A kitten crosses three towns, PEACH, APPLE and LEMON, of six stages each: meadows, forests, "
              "waterfalls, lakes, bricks and cities, against the clock, jumping and throwing what it finds; at the "
              "end of each stage a balloon rises, and the last three spell CAT. The title comes from running the "
              "ROM, checked against openMSX point by point; the game in GIF, played in openMSX; the five tunes, from "
              "its own engine, identical to openMSX frame by frame.",
        ficha=["Casio - <b>(c) 1986</b>",
               "<b>32 KB</b> cartridge (header at 0x4000)",
               "<b>MSX</b>", "Dump <b>0039cff2...</b>"],
        aviso="<b>There are no screenshots of the game here.</b> The title comes from running the ROM (checked "
              "against openMSX) and the GIFs are the ROM <b>running in openMSX</b>: on every frame the VRAM, the "
              "RAM and the VDP registers are logged, and <b>our own code paints them</b>.",
    ),
}

PAGINAS = [
    [("THE-GAME.html", "LA-PARTIDA.html", "The game", "La partida",
      "the CASIO intro, the title, the controls, the jump and the throws, the time, the lives and the points",
      "la presentaci&oacute;n de CASIO, el t&iacute;tulo, los mandos, el salto y lo que se tira, el tiempo, las vidas "
      "y los puntos"),
     ("THE-STAGES.html", "LAS-FASES.html", "The stages", "Las fases",
      "the three towns, the six scenes, the screens, the objects, the balloons and the enemies",
      "los tres pueblos, las seis escenas, las pantallas, los objetos, los globos y los enemigos"),
     ("THE-SPRITES.html", "LOS-SPRITES.html", "The sprites", "Los sprites",
      "the kitten and every creature put together from the ROM tables, with the drawings that change by scene",
      "el gatito y cada bicho montados desde las tablas de la ROM, con los dibujos que cambian seg&uacute;n la escena"),
     ("THE-TEXTS.html", "LOS-TEXTOS.html", "The texts", "Los textos",
      "every text in the ROM, with its translation",
      "todos los textos de la ROM, con su traducci&oacute;n"),
     ("THE-MUSIC.html", "LA-MUSICA.html", "The music", "La m&uacute;sica",
      "the five tunes, from its own sound engine and checked against openMSX",
      "las cinco m&uacute;sicas, de su propio motor de sonido y cotejadas con openMSX")],
    [("CURIOSITIES.html", "CURIOSIDADES.html", "Curiosities", "Curiosidades",
      "CAT in the balloons, SELECT and ESC on the title, STOP and F1, a demo played with tile drawings",
      "CAT en los globos, SELECT y ESC en el t&iacute;tulo, STOP y F1, una demostraci&oacute;n jugada con dibujos"),
     ("SECRETS-AND-BUGS.html", "SECRETOS-Y-FALLOS.html", "Secrets and bugs", "Secretos y fallos",
      "what was searched for: the title keys, the screens behind the goal house (two that appear nowhere else, run from the ROM), the high score set to zero past 9,999,990, and the cursor keys and joystick mixed",
      "lo que se ha buscado: las teclas del t&iacute;tulo, las pantallas detr&aacute;s de la casita de la meta (dos que no salen en ning&uacute;n otro sitio, ejecutadas desde la ROM), el r&eacute;cord a cero pasados los 9.999.990, y los cursores y el mando que se mezclan")],
    [("UNDER-THE-HOOD.html", "POR-DENTRO.html", "Under the hood", "Por dentro",
      "rebuilding the ROM, the cartridge, the BIOS it uses, the main loop, the screens, the RAM and the tools",
      "rehacer la ROM, el cartucho, la BIOS que usa, el bucle, las pantallas, la RAM y las herramientas")],
]

# Repositorio nuevo: no hay paginas viejas que redirigir.
VIEJAS = {}

LOGOTIPO = "logotipo.png"
