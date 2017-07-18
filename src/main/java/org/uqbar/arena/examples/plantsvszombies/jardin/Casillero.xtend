package org.uqbar.arena.examples.plantsvszombies.jardin

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.arena.examples.plantsvszombies.exception.ConfigurationException
import org.uqbar.arena.examples.plantsvszombies.planta.Planta
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class Casillero {
	Planta planta
	int numeroDeCasillero

	new(int elNumeroDeCasillero) {
		numeroDeCasillero = elNumeroDeCasillero
	}

	def validar() {
		if (numeroDeCasillero <= 0) {
			throw new ConfigurationException(
				"El numero del casillero debe ser mayor igual a cero. Valor: " + numeroDeCasillero)
		}
	}

	def estasOcupado() {
		planta != null
	}

	def estasLibre() {
		!estasOcupado
	}

	def getNumeroDeCasillero() {
		numeroDeCasillero
	}

	def eliminaLaPlanta() {
		planta = null
	}

	def estaMuertaLaPlanta() {
		estasOcupado && !planta.estasVivo 
	}

}
