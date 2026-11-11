# Por dentro

## Rehacer la ROM

`make verify` ensambla `src/koneko.asm` con pasmo y sale la ROM de 32 KB **byte a byte**. `make sanity` comprueba lo
que el reensamblado no cubre: que ningún byte declarado como datos se lea como código, que ningún punto de entrada
caiga en datos y que estén explicados los 32.768 bytes. `make test` pasa los tests. La ROM no está en el repositorio:
hay que ponerla en la raíz como `koneko.rom` (el volcado de GoodMSX, `[!]`, sha1 `0039cff2...`).

| | bytes |
|---|---|
| código trazado | 10.785 |
| datos con nombre | 21.983 |
| sin explicar | 0 |

El listado tiene 2.047 comentarios en 4.891 instrucciones (41,9 %), 625 rutinas y etiquetas, ninguna por debajo del
10 % comentada, y ninguna rutina llamada sin nombre.

## El cartucho

32 KB en 0x4000-0xBFFF, con la cabecera en 0x4000. INIT (0x4010) pone el cartucho también en la página 2 y salta a
0x8000. Los datos: las pantallas de cada fase y las 104 pantallas (0x4038-0x56BF y 0xA840-0xAD84), los dibujos de los
sprites (0x56C0-0x5FFF), las casillas y sus colores (0x6000-0x7EFF), la lista de mandos de una demostración (0x7F00)
y las casillas del título (0x7F81); las piezas de las pantallas (0xAD85), sus enemigos y objetos (0xB000) y el sonido
(0xB700-0xBFFF). El código va de 0x8000 a 0xA83C.

## La BIOS que usa

RSLREG y ENASLT para el slot; SETGRP, CHGCLR, WRTVDP, DISSCR y ENASCR; FILVRM, LDIRVM y WRTVRM; GTSTCK y GTTRIG para
los mandos y SNSMAT para la barra, GRAPH, STOP, F1, SELECT y ESC; WRTPSG para el sonido; y la fuente de la BIOS (0x1D3F).

## La interrupción y el bucle

INIT pone un salto a 0x8E75 en el gancho H.TIMI. La interrupción hace el sonido, cuenta cuadros, lee los botones, la
palanca, STOP y F1; en la demostración mueve ella la palanca y los botones. El juego va en el **bucle de la fase**
(`fase_bucle`, 0x82C2): una vez por cuadro, las animaciones del agua, los enemigos y objetos de la pantalla, los
parpadeos, la caída, el gatito, el salto, el tiro, el cambio de pantalla, el tiempo, los puntos, los enemigos y los
objetos.

**Pantallas.** La pantalla se monta en la RAM (0xE700) con su fondo, el suelo, tiras de casillas, rectángulos y dibujos
(`escena_pon`, 0x9B15). Al cambiar, la de ahora y la nueva se ponen lado a lado en 0xE9C0 y la ventana corre 32 veces
una columna, cada 2 cuadros (`pantalla_cambia`, 0x9977). Las casillas desde 0x80 dejan pasar; las de 0x40-0x7F son
paredes y las de 0x50-0x5F, también techos.

## Cómo se ha hecho

El trazado sigue el código desde INIT, la interrupción y dos tablas de saltos (los objetos y los enemigos),
declaradas en `src/koneko.entries`. Lo demás se **midió en openMSX** (`tools/omsx_cobertura.tcl`) en un Philips VG
8020, esperando a la demostración y jugando: nada de lo que se ejecutó quedó fuera del trazado.

Las grabaciones de la web (`tools/guiones/*.tcl`, grabadas con `tools/lanza_graba.ps1` en C-BIOS) apuntan, en cada
cuadro, los registros del VDP, la RAM desde 0xE000, el PSG y la VRAM que ha cambiado. `tools/pantallas.py` ejecuta el
título con `tools/bios.py` (con la fuente que dejó C-BIOS en la VRAM) y lo coteja con la grabación (**0 puntos
distintos**), `tools/gifs.py` hace los GIF y `tools/musica.py` ejecuta el motor de sonido.

## La RAM

| | |
|---|---|
| 0xE000 | jugando |
| 0xE001-0xE006 | los puntos, una cifra por byte |
| 0xE009 / 0xE00A / 0xE00B | el pueblo / la fase (0-17) / las vidas (BCD) |
| 0xE00C-0xE00E | los puntos, en BCD |
| 0xE020 / 0xE022 | tirar / saltar, recién pulsados |
| 0xE023 / 0xE039 | SELECT / ESC en el título |
| 0xE027 / 0xE037 | la demostración / su lista de mandos |
| 0xE03B / 0xE03C | el globo y lo que se tira, de una fase a otra |
| 0xE03D / 0xE03E / 0xE03F | la fase, la posición y la pantalla |
| 0xE040-0xE047 | TIME: la cuenta y sus cifras |
| 0xE048 / 0xE049 | la fase dentro del pueblo / el pueblo (0-2) |
| 0xE04F | la vida de los 50.000, ya dada |
| 0xE183 / 0xE186 | el gatito tocado (2: aunque haya SELECT) / la fase acabada |
| 0xE198 | el cambio de pantalla |
| 0xE1B3 / 0xE1B7 | F1 / STOP |
| 0xE280-0xE2D5 | el sonido |
| 0xE300 | el gatito (+8 lo que tira, +0x1D el globo; +0x70 su tiro) |
| 0xE380 | los 8 enemigos (16 bytes cada uno) |
| 0xE400 | los 12 objetos (16 bytes cada uno) |
| 0xE700 | la pantalla en la RAM |
| 0xE9C0 | dos pantallas lado a lado, al cambiar |
| 0xEE80 | los objetos guardados en la pausa |
