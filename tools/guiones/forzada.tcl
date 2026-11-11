# FORZADA: un recorrido por las 18 fases con SELECT pulsada en el titulo. El piloto de partida.tcl juega cada fase
# 1500 cuadros y despues se da por acabada con un poke (0xE186 = 1): la torre, el tiempo cobrado y la fase siguiente;
# despues de la 18, el final. Las caidas al vacio (que SELECT no evita) gastan vidas: por debajo de 3, se ponen 9
# (0xE00B). Hasta 600 cuadros despues del final o 70000 cuadros.
proc m {a} { return [debug read memory $a] }
proc pon {a v} { debug write memory $a $v }
proc toca {fila bit} {
    keymatrixdown $fila $bit
    after time 0.05 "keymatrixup $fila $bit"
}
set ::fase -1
set ::desde 0
proc guion {n} {
    if {$n < 390} { keymatrixdown 7 0x40 } else { keymatrixup 7 0x40 }
    if {[m 0xE000] == 0} {
        keymatrixup 8 0xF1
        if {$n == 400} { toca 8 0x01 }
        if {[info exists ::empezada]} {
            if {![info exists ::fin]} { set ::fin $n }
            return [expr {$n >= $::fin + 300}]
        }
        return [expr {$n >= 70000}]
    }
    set ::empezada 1
    set f [m 0xE00A]
    if {$f != $::fase} { set ::fase $f; set ::desde $n }
    if {$n - $::desde >= 1500 && [m 0xE183] == 0 && ![info exists ::hecho($f)]} { pon 0xE186 1; set ::hecho($f) 1 }
    if {[m 0xE00B] < 3} { pon 0xE00B 9 }
    if {[info exists ::hecho(17)] && $f == 0} {
        if {![info exists ::vuelta]} { set ::vuelta $n }
        if {$n >= $::vuelta + 600} { return 1 }
    }
    keymatrixup 8 0xF1
    if {($n / 120) % 5 != 4} { keymatrixdown 8 0x80 } else { keymatrixdown 8 0x10 }
    if {$n % 45 < 20} { keymatrixdown 8 0x01 }
    if {$n % 30 == 0} { toca 6 0x04 }
    return [expr {$n >= 70000}]
}
