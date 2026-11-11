# La música

Cinco músicas, a tres voces. No son grabaciones hechas a mano: `tools/musica.py` **ejecuta el propio motor de sonido
de la ROM** con `tools/z80run.py` -la rutina del sonido (`sonido`, 0xB770), cuadro a cuadro, con el número que escribe
el juego- y apunta lo que escribe en el PSG por la BIOS (WRTPSG).

**Cotejadas con openMSX**: los registros de tono y volumen de los tres canales casan con los grabados, **0 distintos**
en todos los cuadros mirados, en las cinco. Se cotejan cuatro grabaciones (`tools/guiones/`): el título con las
demostraciones, una partida hasta GAME OVER, una con SELECT y el recorrido forzado por las fases. Cada cuadro grabado
se empareja con el cuadro del motor que tiene la misma RAM en los tres canales; mientras suena un efecto en un canal,
ese canal no se mira.

## El motor

Es el mismo motor que otros cartuchos de Casio de esos años. Va una vez por cuadro desde la interrupción y recibe
tres **pedidos**: una música (0xE2BE), un efecto para el canal A (0xE2C0) y otro para B y C (0xE2C2); gana el de
número menor (`musica_pide`, 0xB76B). Las tablas: seis músicas en 0xB700 (la 0 es el silencio), ocho efectos del
canal A en 0xB724, seis de B y C en 0xB734 y catorce duraciones en 0xBA21. El título no tiene música.

| | Quién la pide | Dura |
|---|---|---:|
| la presentación de CASIO | los CASIO se juntan (0x8FFE) | 1,1 s |
| la fase | al empezar la fase (0x82A3) | 3,2 s |
| la fase acabada | el globo del final de fase y el final (0x865D, 0x885B) | 4,5 s |
| el globo | coger un globo o el premio con vida (0xA3AA, 0x9F23) | 2,1 s |
| GAME OVER | sin vidas (0x8601) | 3,8 s |

Ninguna vuelve a empezar: todas acaban.

## La presentación de CASIO

<audio controls src="../audio/musica_casio.mp3"></audio>

## La fase

<audio controls src="../audio/musica_fase.mp3"></audio>

## La fase acabada

<audio controls src="../audio/musica_fase_acabada.mp3"></audio>

## El globo

<audio controls src="../audio/musica_globo.mp3"></audio>

## GAME OVER

<audio controls src="../audio/musica_game_over.mp3"></audio>
