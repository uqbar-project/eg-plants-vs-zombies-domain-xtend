package org.uqbar.arena.examples.plantsvszombies.jardin

import org.uqbar.arena.examples.plantsvszombies.planta.TipoDePlanta

interface Jardin {

	static int cantidadMaximaDePlantas = 20

	def int cantidadDePlantasDeUnTipo(TipoDePlanta unTipo)

}
