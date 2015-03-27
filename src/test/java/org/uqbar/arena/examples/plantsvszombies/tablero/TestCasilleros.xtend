package org.uqbar.arena.examples.plantsvszombies.tablero

import org.junit.Before
import org.junit.Test
import org.uqbar.arena.examples.plantsvszombies.jardin.Casillero
import org.uqbar.arena.examples.plantsvszombies.planta.Planta
import org.uqbar.arena.examples.plantsvszombies.planta.TipoAcuatica

import static org.junit.Assert.*

class TestCasilleros {

	Casillero casillero
	Planta planta

	@Before
	def void init() {
		casillero = new Casillero(1)
		planta = new Planta() => [
			potenciaDeAtaque = 15
			resistencia = 15
			nombre = "Meduza"
			tipo= new TipoAcuatica
			validar
		]
	}

	@Test
	def void estaOcupadoElCasillero() {
		casillero.setPlanta(planta)
		assertTrue(casillero.estasOcupado)
	}

	@Test
	def void estaLibreElCasillero() {
		assertTrue(casillero.estasLibre)
	}
	
}
