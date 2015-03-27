package org.uqbar.arena.examples.plantsvszombies.tablero

import java.util.ArrayList
import org.junit.Before
import org.junit.Test
import org.uqbar.arena.examples.plantsvszombies.jardin.JardinZen
import org.uqbar.arena.examples.plantsvszombies.planta.Planta
import org.uqbar.arena.examples.plantsvszombies.planta.TipoDePlanta

import static org.junit.Assert.*
import org.uqbar.arena.examples.plantsvszombies.planta.TipoAcuatica

class TestJardinZen {

	JardinZen jardinZen
	Planta planta
	TipoDePlanta tipo

	@Before
	def void init() {
		jardinZen = new JardinZen
		jardinZen.plantas = new ArrayList
		tipo = new TipoAcuatica
		planta = new Planta => [
			potenciaDeAtaque = 15
			resistencia = 15
			nombre = "Meduza"
			setTipo = new TipoAcuatica
			validar
		]
	}

	@Test
	def void agregarDosPLantas() {
		jardinZen.agregarPlanta(planta)
		jardinZen.agregarPlanta(planta)
		assertEquals(2, jardinZen.cantidadDePlantasDeUnTipo(tipo))
	}

	@Test
	def void cantidadDePlantasAcuaticas() {
		jardinZen.agregarPlanta(planta)
		assertEquals(1, jardinZen.cantidadDePlantasDeUnTipo(tipo))
	}

}
