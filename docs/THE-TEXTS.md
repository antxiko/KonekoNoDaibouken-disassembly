# The texts

The game writes with the **BIOS font**: at power-on it copies the characters from "0" to "_" (0x1D3F) to tiles
0x00-0x2F of the three thirds (`letras_pon`, 0x8C43). A letter is its code - 0x30, and tile 0x10 is the space. The
game's name, the kitten's name, CASIO and the heart are drawn tiles.

| address | original | translation | where it appears |
|---|---|---|---|
| 0x7F81 | CASIO | Casio | the intro, in drawn tiles |
| 0x7F9D | 仔猫の大冒険 | The kitten's great adventure | the title, in drawn tiles |
| 0x7FB5 | チビちゃん | Chibi-chan (the kitten's name) | the title, letter by letter |
| 0x90F5 | CASIO | Casio | the title, in drawn tiles |
| 0x90FB | PUSH TRIG:1 OR SPACE | Press button 1 or the space bar | the title |
| 0x7FBF | COPYRIGHT 1986 © CASIO | Copyright 1986 Casio | the title |
| 0x90EB | GAME START | The game starts | **no pointer reaches it** ([Curiosities](CURIOSITIES.html)) |
| 0x90DB | ROUND | Round | the scoreboard: ROUND1-1 |
| 0x90E2 | TIME= | Time | the scoreboard |
| 0x90E7 | OVER | Over | on the TIME digits, at zero |
| 0x910F | HISCORE:0000000 | High score | the scoreboard |
| 0x9111 | SCORE:000000 | Score | the scoreboard: the last letters of HISCORE: |
| 0x8879 | CLEAR       TOWN | Town cleared | a town over, with its name |
| 0x8889 | GO TO | Go to | before the next town |
| 0x888E | PEACH / APPLE / LEMON | Peach / Apple / Lemon | the town names |
| 0x889D | GREAT!! | Great! | the ending |
| 0x88A3 | I LOVE YOU | I love you | the ending, with チビ and a heart |
| 0x8613 | CONTINUE PUSH TRIG1 | Continue: press button 1 | no lives left, with ESC on the title |
| 0x8626 | END      PUSH TRIG2 | End: press button 2 | below |
| 0x911E | GAME OVER | Game over | no lives left |
