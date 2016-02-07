package org.uqbar.arena.examples.plantsvszombies.tablero

import static org.junit.Assert.*
import org.junit.Before
import org.junit.Test
import org.uqbar.arena.examples.plantsvszombies.jardin.JardinDeJuego
import org.uqbar.arena.examples.plantsvszombies.planta.Planta
import org.uqbar.arena.examples.plantsvszombies.planta.TipoDePlanta
import org.uqbar.arena.examples.plantsvszombies.exception.NoHayLugarException
import org.uqbar.arena.examples.plantsvszombies.exception.ConfigurationException
import org.uqbar.arena.examples.plantsvszombies.planta.TipoAcuatica

class TestJardinDeJuego {

	JardinDeJuego jardin
	Planta planta
	TipoDePlanta tipo

	@Before
	def void init() {
		jardin = new JardinDeJuego
		jardin.crearTablero(2, 4)

		tipo = new TipoAcuatica

		planta = new Planta() => [
			potenciaDeAtaque = 15
			resistencia = 15
			nombre = "Meduza"
			setTipo(tipo)
			validar
		]
	}

	@Test(expected=typeof(ConfigurationException))
	def void cantidadDeFilaIncorrecto() {
		jardin.crearTablero(0, 5)
	}

	@Test(expected=typeof(ConfigurationException))
	def void cantidadDeCasillerosMinimoIncorrectos() {
		jardin.crearTablero(1, 0)
	}

	@Test(expected=typeof(ConfigurationException))
	def void cantidadDeCasillerosMaximoIncorrectos() {
		jardin.crearTablero(1, jardin.numeroDeCasillerosPorFila + 1)
	}

	@Test
	def void crearTableroConDosFilas() {
		assertEquals(2, jardin.numeroDeFilasDelTablero)
	}

	@Test
	def void crearTableroConCuatroColumnas() {
		assertEquals(4, jardin.getNumeroDeFila(0).cantidadDeCasilleros)
	}

	@Test
	def void casilleroLibre() {
		assertFalse(jardin.estaElCasilleroOcupado(1, 3))
	}

	@Test
	def void hayLugarEnLaFilaParaUnaPlanta() {
		assertTrue(jardin.hayLugarEnLaFila(1))
	}

	@Test(expected=typeof(NoHayLugarException))
	def void noHayLugarEnLaFila() {
		var tipo = planta.tipo
		jardin.getNumeroDeFila(1).tipo = tipo
		for (i : 0 .. jardin.numeroDeCasillerosPorFila) {
			jardin.agregarPlantaAlaFila(planta, 1)
		}
		jardin.agregarPlantaAlaFila(planta, 1)
	}

	@Test
	def void cantidadTotalDePlantasEnElJardin() {
		val tipo = planta.tipo
		jardin.getNumeroDeFila(1).tipo = tipo
		jardin.getNumeroDeFila(0).tipo = tipo
		jardin.agregarPlantaAlaFila(planta, 1)
		jardin.agregarPlantaAlaFila(planta, 0)
		assertEquals(2, jardin.cantidadDePlantasDeUnTipo(tipo))
	}

	@Test
	def void noHayPlantasEnElJardin() {
		assertEquals(0, jardin.cantidadDePlantasDeUnTipo(tipo))
	}

}
