# UNA PARTIDA con un piloto sencillo, nada forzado. La barra en el cuadro 400. Jugando (0xE000 = 1): la derecha casi
# siempre (un rato a la izquierda cada 600 cuadros); la barra (el salto) pulsada 20 cuadros de cada 45; GRAPH (tirar)
# cada 30. Hasta GAME OVER + 300 o 20000 cuadros.
proc m {a} { return [debug read memory $a] }
proc toca {fila bit} {
    keymatrixdown $fila $bit
    after time 0.05 "keymatrixup $fila $bit"
}
proc guion {n} {
    if {[m 0xE000] == 0} {
        keymatrixup 8 0xF1
        if {$n == 400} { toca 8 0x01 }
        if {[info exists ::empezada]} {
            if {![info exists ::fin]} { set ::fin $n }
            return [expr {$n >= $::fin + 300}]
        }
        return [expr {$n >= 20000}]
    }
    set ::empezada 1
    keymatrixup 8 0xF1
    if {($n / 120) % 5 != 4} { keymatrixdown 8 0x80 } else { keymatrixdown 8 0x10 }
    if {$n % 45 < 20} { keymatrixdown 8 0x01 }
    if {$n % 30 == 0} { toca 6 0x04 }
    return [expr {$n >= 20000}]
}
