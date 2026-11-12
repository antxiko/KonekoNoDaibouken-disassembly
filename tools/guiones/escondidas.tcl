# ESCONDIDAS (FORZADA): las dos pantallas que hay detras de la casita de la meta, jugando en openMSX.
# El piloto de forzada.tcl, con SELECT pulsada en el titulo. Las fases que no interesan se dan por acabadas a los
# 300 cuadros con el poke de siempre (0xE186 = 1). En ROUND2-2 y ROUND3-3 (la lista 0xE03D = 7 y 14), un GANCHO en
# pantalla_siguiente (0x94D3) pone la posicion (0xE03E) en 8, la de la casita, la primera vez que el gatito llega al
# borde derecho: el juego la sube a 9 y entra la pantalla escondida (0x66 o 0x67), con su scroll; despues, el
# piloto sigue andando a la derecha. Cada una se juega 1500 cuadros. Acaba 200 cuadros despues de la segunda.
# En ROUND3-3 el piloto no llega solo al borde: a los 200 cuadros se pone al gatito en la X 0xF0 (tambien FORZADO).
proc m {a} { return [debug read memory $a] }
proc pon {a v} { debug write memory $a $v }
proc toca {fila bit} {
    keymatrixdown $fila $bit
    after time 0.05 "keymatrixup $fila $bit"
}
set ::fase -1
set ::desde 0
proc gancho {} {
    set l [m 0xE03D]
    if {($l == 7 || $l == 14) && ![info exists ::forzada($l)]} {
        pon 0xE03E 8
        set ::forzada($l) 1
    }
}
debug set_bp 0x94D3 {} { gancho }
proc guion {n} {
    if {$n < 390} { keymatrixdown 7 0x40 } else { keymatrixup 7 0x40 }
    if {[m 0xE000] == 0} {
        keymatrixup 8 0xF1
        if {$n == 400} { toca 8 0x01 }
        return [expr {$n >= 90000}]
    }
    set l [m 0xE03D]
    if {$l != $::fase} { set ::fase $l; set ::desde $n }
    set dura [expr {($l == 7 || $l == 14) ? 1500 : 300}]
    if {$n - $::desde >= $dura && [m 0xE183] == 0 && ![info exists ::hecho($l)]} { pon 0xE186 1; set ::hecho($l) 1 }
    if {[m 0xE00B] < 3} { pon 0xE00B 9 }
    # en ROUND3-3 el piloto no llega solo al borde derecho: a los 200 cuadros, el gatito a la X 0xF0 (FORZADO)
    if {$l == 14 && ![info exists ::forzada(14)] && $n - $::desde >= 200 && [m 0xE198] == 0} {
        pon 0xE301 0xF0; pon 0xE311 0xF0
    }
    if {[info exists ::hecho(14)]} {
        if {![info exists ::fin]} { set ::fin $n }
        if {$n >= $::fin + 200} { return 1 }
    }
    keymatrixup 8 0xF1
    if {($n / 120) % 5 != 4} { keymatrixdown 8 0x80 } else { keymatrixdown 8 0x10 }
    if {$n % 45 < 20} { keymatrixdown 8 0x01 }
    if {$n % 30 == 0} { toca 6 0x04 }
    return [expr {$n >= 90000}]
}
