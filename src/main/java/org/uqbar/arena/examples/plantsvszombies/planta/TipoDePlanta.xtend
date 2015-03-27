package org.uqbar.arena.examples.plantsvszombies.planta

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
abstract class TipoDePlanta {

	String tipo

	override toString() {
		tipo
	}

	def equals(TipoDePlanta unTipo) {
		getTipo == unTipo.getTipo
	}
	
	def equals(String unTipo) {
		getTipo == unTipo
	}

	def String nombreDePantalla()

}
