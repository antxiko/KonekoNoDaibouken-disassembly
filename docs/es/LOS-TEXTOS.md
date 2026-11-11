# Los textos

El juego escribe con la **fuente de la BIOS**: al encender copia los caracteres del "0" al "_" (0x1D3F) a las
casillas 0x00-0x2F de los tres tercios (`letras_pon`, 0x8C43). Una letra es su código - 0x30, y la casilla 0x10 es el
espacio. El nombre del juego, el del gatito, CASIO y el corazón son casillas dibujadas.

| dirección | original | traducción | dónde sale |
|---|---|---|---|
| 0x7F81 | CASIO | Casio | la presentación, en casillas dibujadas |
| 0x7F9D | 仔猫の大冒険 | La gran aventura del gatito | el título, en casillas dibujadas |
| 0x7FB5 | チビちゃん | Chibi-chan (el nombre del gatito) | el título, letra a letra |
| 0x90F5 | CASIO | Casio | el título, en casillas dibujadas |
| 0x90FB | PUSH TRIG:1 OR SPACE | Pulsa el botón 1 o la barra | el título |
| 0x7FBF | COPYRIGHT 1986 © CASIO | Copyright 1986 Casio | el título |
| 0x90EB | GAME START | Empieza la partida | **ningún puntero llega a él** ([Curiosidades](CURIOSIDADES.html)) |
| 0x90DB | ROUND | Ronda | el marcador: ROUND1-1 |
| 0x90E2 | TIME= | Tiempo | el marcador |
| 0x90E7 | OVER | Se acabó | sobre las cifras de TIME, a cero |
| 0x910F | HISCORE:0000000 | Récord | el marcador |
| 0x9111 | SCORE:000000 | Puntos | el marcador: las últimas letras de HISCORE: |
| 0x8879 | CLEAR       TOWN | Pueblo superado | acabado un pueblo, con su nombre |
| 0x8889 | GO TO | Ve a | antes del pueblo siguiente |
| 0x888E | PEACH / APPLE / LEMON | Melocotón / Manzana / Limón | los nombres de los pueblos |
| 0x889D | GREAT!! | ¡Genial! | el final |
| 0x88A3 | I LOVE YOU | Te quiero | el final, con チビ y un corazón |
| 0x8613 | CONTINUE PUSH TRIG1 | Continuar: pulsa el botón 1 | sin vidas, con ESC en el título |
| 0x8626 | END      PUSH TRIG2 | Acabar: pulsa el botón 2 | debajo |
| 0x911E | GAME OVER | Fin de la partida | sin vidas |
