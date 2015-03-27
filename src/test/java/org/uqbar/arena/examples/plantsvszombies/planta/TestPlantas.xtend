package org.uqbar.arena.examples.plantsvszombies.planta

import org.junit.Test

import static org.junit.Assert.*
import org.uqbar.arena.examples.plantsvszombies.planta.Planta
import org.uqbar.arena.examples.plantsvszombies.exception.ConfigurationException

class TestPlantas {
	Planta planta
	
	@Test(expected=typeof(ConfigurationException))
	def void plantaConPoderDeAtaqueCero() {
		planta = new Planta() => [
			potenciaDeAtaque = 0
			resistencia = 0
			nombre = "Meduza"
			validar
		]
	}
	
	@Test 
	def void plantaTienePoderDeAtaque(){
		planta = new Planta() => [
			potenciaDeAtaque = 1
			resistencia = 1
			nombre = "Sirasol"
		]
		assertTrue(planta.resistencia == 1)
	}
	
}