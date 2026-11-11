# LAS TECLAS de la partida: la barra en el cuadro 400; jugando, quieto; STOP en el cuadro 900 y otra vez en 1400;
# F1 en 1800. 2600 cuadros.
proc toca {fila bit} {
    keymatrixdown $fila $bit
    after time 0.05 "keymatrixup $fila $bit"
}
proc guion {n} {
    if {$n == 400} { toca 8 0x01 }
    if {$n == 900 || $n == 1400} { toca 7 0x10 }
    if {$n == 1800} { toca 6 0x20 }
    return [expr {$n >= 2600}]
}
