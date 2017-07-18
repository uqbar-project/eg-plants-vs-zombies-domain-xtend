package org.uqbar.arena.examples.plantsvszombies.planta

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.arena.examples.plantsvszombies.exception.ConfigurationException
import org.uqbar.arena.examples.plantsvszombies.personaje.Personaje
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class Planta extends Personaje implements Cloneable {
	TipoDePlanta tipo

	override validar() {
		super.validar
		if (tipo == null) {
			throw new ConfigurationException("Debe configurar un tipo de planta valido")
		}
	}

	override poderDeAtaqueMinimo() {
		0
	}

	override poderDeAtaqueMaximo() {
		100
	}

	override resistenciaMinima() {
		1
	}

	override resistenciaMaxima() {
		50
	}

	def equals(TipoDePlanta unTipo) {
		unTipo.equals(tipo)
	}

	override clone() {
		return super.clone
	}
	
}
