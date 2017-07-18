package org.uqbar.arena.examples.plantsvszombies.ataque

import org.junit.Before
import org.junit.Test
import org.uqbar.arena.examples.plantsvszombies.jardin.Fila
import org.uqbar.arena.examples.plantsvszombies.planta.TipoAcuatica
import org.uqbar.arena.examples.plantsvszombies.zombie.Zombie
import org.uqbar.commons.model.exceptions.UserException

class TestAtaque {

	Zombie unZombie
	Fila unaFila

	@Before
	def void init() {
		unZombie = new Zombie => [
			potenciaDeAtaque = 90
			resistencia = 50
			nombre = "Cerebrito"
			validar
		]

		unaFila = new Fila(5)
		unaFila.tipo = new TipoAcuatica
	}
	
	@Test(expected=typeof(UserException))
	def void atacarFilaSinPlantas(){
		new Ataque(unaFila, unZombie)
	}
	
}
