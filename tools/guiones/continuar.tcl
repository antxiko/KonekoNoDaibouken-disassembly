# ESC pulsada en el titulo (0xE039 = 2): la barra en el cuadro 400; jugando, quieto, los enemigos lo matan; desde que
# no quedan vidas, la barra cada 60 cuadros (CONTINUE PUSH TRIG1). 7000 cuadros.
proc m {a} { return [debug read memory $a] }
proc toca {fila bit} {
    keymatrixdown $fila $bit
    after time 0.05 "keymatrixup $fila $bit"
}
proc guion {n} {
    if {$n < 390} { keymatrixdown 7 0x04 } else { keymatrixup 7 0x04 }
    if {$n == 400} { toca 8 0x01 }
    if {$n > 600 && [m 0xE00B] == 0 && $n % 60 == 0} { toca 8 0x01 }
    return [expr {$n >= 7000}]
}
