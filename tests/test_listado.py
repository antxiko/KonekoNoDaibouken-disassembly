"""Lo que se afirma de la ROM, comprobado contra sus bytes.

Corre con la ROM delante y sin ella: cuando no esta, la imagen se rehace desde
las filas defb/defw del listado, que si viaja con el repositorio. Sin la ROM
solo se comprueba lo que cae en datos.
"""

import os
import re
import subprocess
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))

ROM = os.path.join(RAIZ, "koneko.rom")
ASM = os.path.join(RAIZ, "src", "koneko.asm")
NOTAS = os.path.join(RAIZ, "src", "koneko.notes")
ORG = 0x4000
TAM = 32768

FILA = re.compile(r"^\s+def(b|w)\s+([0-9a-fA-F,h ]+)\s*;\s*([0-9a-f]{4})")


def imagen_desde_el_listado():
    img = bytearray(TAM)
    with open(ASM, encoding="utf-8") as f:
        for ln in f:
            m = FILA.match(ln)
            if not m:
                continue
            ancho, cuerpo, dirr = m.group(1), m.group(2), int(m.group(3), 16)
            p = dirr - ORG
            for tok in cuerpo.split(","):
                tok = tok.strip().rstrip("h")
                if not tok:
                    continue
                v = int(tok, 16)
                if ancho == "b":
                    img[p] = v
                    p += 1
                else:
                    img[p] = v & 0xFF
                    img[p + 1] = v >> 8
                    p += 2
    return bytes(img)


def lee():
    if os.path.exists(ROM):
        with open(ROM, "rb") as f:
            return f.read()
    return imagen_desde_el_listado()


def b(a):
    return lee()[a - ORG]


def w(a):
    rom = lee()
    return rom[a - ORG] | (rom[a - ORG + 1] << 8)


def instruccion(dirr):
    """La instruccion del listado en esa direccion (sin el comentario)."""
    with open(ASM, encoding="utf-8") as f:
        for ln in f:
            m = re.match(r"^	(\S.*?)\s*;([0-9a-f]{4})", ln)
            if m and int(m.group(2), 16) == dirr:
                return m.group(1).replace("	", " ").strip()


class Cabecera(unittest.TestCase):
    def test_ab_e_init_en_0x4010(self):
        rom = lee()
        self.assertEqual(rom[:2], b"AB")
        self.assertEqual(w(0x4002), 0x4010)

    def test_init_pone_la_pagina_2_y_salta(self):
        self.assertEqual([instruccion(a) for a in (0x4030, 0x4032, 0x4035)],
                         ["ld h,080h", "call 00024h", "jp arranque"])

    def test_son_32_kb(self):
        self.assertEqual(len(lee()), TAM)


class LaInterrupcion(unittest.TestCase):
    def test_va_por_h_timi(self):
        self.assertEqual([instruccion(a) for a in (0x8021, 0x8024, 0x8027, 0x8029)],
                         ["ld hl,08e75h", "ld (0fda0h),hl", "ld a,0c3h", "ld (0fd9fh),a"])


def texto(a, n):
    """Casilla = letra - 0x30 (la fuente de la BIOS); 0x10 es el espacio."""
    return "".join(" " if c == 0x10 else chr(c + 0x30) for c in lee()[a - ORG:a - ORG + n])


class LosTextos(unittest.TestCase):
    def test_el_titulo(self):
        self.assertEqual(texto(0x90FB, 20), "PUSH TRIG:1 OR SPACE")
        self.assertEqual(texto(0x90EB, 10), "GAME START")
        self.assertEqual(texto(0x911E, 9), "GAME OVER")

    def test_continuar(self):
        self.assertEqual(texto(0x8613, 19), "CONTINUE PUSH TRIG1")
        self.assertEqual(texto(0x8626, 19), "END      PUSH TRIG2")

    def test_los_pueblos(self):
        self.assertEqual(texto(0x8879, 16), "CLEAR       TOWN")
        self.assertEqual([texto(a, 5) for a in (0x888E, 0x8893, 0x8898)], ["PEACH", "APPLE", "LEMON"])
        self.assertEqual(texto(0x88A3, 10), "I LOVE YOU")

    def test_la_fuente_es_la_de_la_bios(self):
        self.assertEqual(instruccion(0x8C43), "ld hl,01d3fh")


class LasTeclasDelTitulo(unittest.TestCase):
    def test_select(self):
        self.assertEqual([instruccion(a) for a in (0x8082, 0x8087, 0x808D)],
                         ["ld a,007h", "bit 6,a", "ld (0e023h),a"])

    def test_esc_continuar(self):
        self.assertEqual([instruccion(a) for a in (0x8095, 0x809B)], ["bit 2,a", "ld (0e039h),a"])
        self.assertEqual(instruccion(0x8589), "ld a,(0e039h)")


class LaPartida(unittest.TestCase):
    def test_cuatro_vidas(self):
        self.assertEqual([instruccion(a) for a in (0x81DB, 0x81DD)], ["ld a,004h", "ld (0e00bh),a"])

    def test_seis_fases_por_pueblo_y_dieciocho(self):
        self.assertEqual([instruccion(a) for a in (0x87EB, 0x87FD)], ["cp 007h", "cp 012h"])

    def test_la_demo_lee_sus_mandos_del_nombre_del_titulo(self):
        self.assertEqual(instruccion(0x8180), "ld hl,07fa0h")
        self.assertEqual(instruccion(0x809E), "ld hl,07f9dh")


class Sonido(unittest.TestCase):
    def test_seis_musicas(self):
        for k in range(6):
            for j in range(3):
                self.assertTrue(0xBB2A <= w(0xB700 + 6 * k + 2 * j) < 0xC000)


class ElListado(unittest.TestCase):
    def test_densidad_y_flojas(self):
        salida = subprocess.run(
            [sys.executable, os.path.join(RAIZ, "tools", "densidad.py"), ASM],
            capture_output=True, text=True, check=True).stdout
        m = re.search(r"(\d+) instrucciones, (\d+) comentarios", salida)
        self.assertGreaterEqual(int(m.group(2)) * 100, 40 * int(m.group(1)))
        self.assertIn("---- 0 rutinas por debajo del 10 %", salida)

    def test_ningun_call_sin_nombre(self):
        salida = subprocess.run(
            [sys.executable, os.path.join(RAIZ, "tools", "sin_bautizar.py"), ASM],
            capture_output=True, text=True, check=True).stdout
        self.assertTrue(salida.startswith("0 rutinas sin bautizar"), salida[:200])

    def test_cada_comentario_en_su_instruccion(self):
        salida = subprocess.run(
            [sys.executable, os.path.join(RAIZ, "tools", "valida_c.py"), ASM, NOTAS],
            capture_output=True, text=True, check=True).stdout
        self.assertIn("0 fuera de sitio, 0 repetidos", salida)


if __name__ == "__main__":
    unittest.main()
