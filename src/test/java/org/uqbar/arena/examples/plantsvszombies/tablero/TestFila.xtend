package org.uqbar.arena.examples.plantsvszombies.tablero

import org.junit.Before
import org.junit.Test
import org.uqbar.arena.examples.plantsvszombies.exception.NoHayLugarException
import org.uqbar.arena.examples.plantsvszombies.exception.TipoInvalidoDePlantaException
import org.uqbar.arena.examples.plantsvszombies.jardin.Fila
import org.uqbar.arena.examples.plantsvszombies.planta.Planta
import org.uqbar.arena.examples.plantsvszombies.planta.TipoAcuatica
import org.uqbar.arena.examples.plantsvszombies.planta.TipoDePlanta
import org.uqbar.arena.examples.plantsvszombies.planta.TipoTerrestre

import static org.junit.Assert.*

class TestFila {
	Fila fila
	Planta planta
	TipoDePlanta tipo

	@Before
	def void init() {
		fila = new Fila(5)
		tipo = new TipoTerrestre
		fila.definirTipo(tipo)

		planta = new Planta => [
			potenciaDeAtaque = 15
			resistencia = 15
			nombre = "Meduza"
			// ojo que si hacemos tipo = xxx toma en cuenta el de la clase actual
			setTipo(new TipoTerrestre)
			validar
		]
	}

	@Test
	def void crearFilaConCincoCasilleros() {
		assertEquals(5, fila.cantidadDeCasilleros)
	}

	@Test
	def void agregarUnaPlantaAunaFila() {
		fila.agregaUnaPlantaAlCasillero(planta, 0)
		fila.agregaUnaPlantaAlCasillero(planta, 1)
		assertEquals(2, fila.cantidadDeCasillerosOcupados)
	}

	@Test(expected=typeof(TipoInvalidoDePlantaException))
	def void noSePuedeAgregarUnaPlantaDeDistintoTipo() {
		planta.tipo = new TipoAcuatica
		fila.agregaUnaPlantaAlCasillero(planta, 0)
	}

	@Test(expected=typeof(NoHayLugarException))
	def void noSePuedeAgregarPlantaSiNoHayLugar() {
		for (i : 1 .. fila.cantidadDeCasilleros) {
			fila.agregaUnaPlantaAlCasillero(planta, i - 1)
		}
		fila.agregaUnaPlantaAlCasillero(planta, 1)
	}

}
