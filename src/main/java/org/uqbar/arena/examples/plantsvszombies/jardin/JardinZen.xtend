package org.uqbar.arena.examples.plantsvszombies.jardin

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.arena.examples.plantsvszombies.planta.Planta
import org.uqbar.arena.examples.plantsvszombies.planta.TipoDePlanta
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class JardinZen implements Jardin {
	List<Planta> plantas

	override cantidadDePlantasDeUnTipo(TipoDePlanta unTipo) {
		plantas.filter[p|p.tipo.equals(unTipo)].size
	}

	def cantidadDeLugaresLibres(TipoDePlanta unTipo) {
		cantidadMaximaDePlantas - cantidadDePlantasDeUnTipo(unTipo)
	}

	def agregarPlanta(Planta planta) {
		plantas.add(planta)
	}

	def List<Planta> getPlantasDeUnTipo(TipoDePlanta unTipo) {
		plantas.filter[p|p.tipo.equals(unTipo)].toList()
	}

}
