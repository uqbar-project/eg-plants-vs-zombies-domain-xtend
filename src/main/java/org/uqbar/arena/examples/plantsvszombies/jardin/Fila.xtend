package org.uqbar.arena.examples.plantsvszombies.jardin

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.arena.examples.plantsvszombies.exception.ConfigurationException
import org.uqbar.arena.examples.plantsvszombies.exception.NoHayLugarException
import org.uqbar.arena.examples.plantsvszombies.exception.TipoInvalidoDePlantaException
import org.uqbar.arena.examples.plantsvszombies.planta.Planta
import org.uqbar.arena.examples.plantsvszombies.planta.TipoDePlanta
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class Fila {
	int cantidadDeCasilleros
	TipoDePlanta tipo
	List<Casillero> casilleros = newArrayList
	int numeroDeDFila

	new(int cantidadDeCasilleros) {
		this.definirCantidadDeCasilleros(cantidadDeCasilleros)
		this.crearCasilleros()
	}

	def definirCantidadDeCasilleros(int cantidadDeCasillerosPorFila) {
		if (cantidadDeCasillerosPorFila < 1)
			throw new ConfigurationException("Cantidad de casilleros por fila no valido: " + cantidadDeCasillerosPorFila)
		cantidadDeCasilleros = cantidadDeCasillerosPorFila
	}

	def void crearCasilleros() {
		(1 .. cantidadDeCasilleros).forEach[numeroDeCasillero|getCasilleros.add(new Casillero(numeroDeCasillero))]
	}

	def getCantidadDeCasilleros() {
		casilleros.size
	}

	def estaOcupadoElCasillero(int numeroDeCasillero) {
		getCasilleros.get(numeroDeCasillero).estasOcupado()
	}

	def agregaUnaPlantaAlCasillero(Planta planta, int numeroDeCasillero) {
		if (!getTipo.equals(planta.getTipo))
			throw new TipoInvalidoDePlantaException(
				"La fila es de tipo " + getTipo.toString + " y la planta de tipo " + planta.getTipo.toString)
		if (numeroDeCasillero < 0 || numeroDeCasillero > getCantidadDeCasilleros)
			throw new NoHayLugarException("El numero de casillero debe ser entre 1 y " + getCantidadDeCasilleros)

		val casillero = casilleros.get(numeroDeCasillero)
		if (casillero.estasOcupado)
			throw new NoHayLugarException(
				"No hay lugar en la fila para agregar una nueva planta en el casillero " + (numeroDeCasillero + 1))

		casillero.planta = planta.clone as Planta
	}

	def hayLugarDisponible() {
		cantidadDeCasillerosLibres > 0
	}

	def definirTipo(TipoDePlanta tipoDePlanta) {
		tipo = tipoDePlanta
	}

	def cantidadDeCasillerosLibres() {
		casillerosLibres.size
	}

	def int cantidadDeCasillerosOcupados() {
		casilleros.size - this.cantidadDeCasillerosLibres
	}

	def List<Casillero> getCasilleros() {
		casilleros
	}

	def casillerosOcupados() {
		casilleros.filter[c|c.estasOcupado].toList
	}

	def estaVacia() {
		cantidadDeCasillerosLibres == casilleros.size
	}

	def removerPlantasMuertas() {
		for (Casillero casillero : casilleros) {
			if (casillero.estaMuertaLaPlanta) {
				casillero.eliminaLaPlanta
			}
		}
	}

	def agregaUnaPlanta(Planta planta) {
		val casillerosLibres = casillerosLibres()
		if (casillerosLibres.isEmpty) {
			throw new NoHayLugarException("No hay lugar para agregar a la planta " + planta.nombre)
		}
		casillerosLibres.get(0).planta = planta
	}
	
	def casillerosLibres() {
		casilleros.filter[casillero | casillero.estasLibre].toList
	}

}
