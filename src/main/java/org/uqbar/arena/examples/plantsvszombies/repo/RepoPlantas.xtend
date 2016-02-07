package org.uqbar.arena.examples.plantsvszombies.repo

import java.util.List
import java.util.Random
import org.uqbar.arena.examples.plantsvszombies.planta.Planta
import org.uqbar.arena.examples.plantsvszombies.planta.TipoDePlanta
import org.uqbar.commons.model.CollectionBasedRepo

class RepoPlantas extends CollectionBasedRepo<Planta> {

	List<Planta> plantasDeRecompensa = newArrayList

	new() {
	}

	def create(String unNombre, int unaResistencia, int unaPotenciaDeAtaque, TipoDePlanta unTipoDePlanta) {
		new Planta => [
			nombre = unNombre.trim
			resistencia = unaResistencia
			potenciaDeAtaque = unaPotenciaDeAtaque
			tipo = unTipoDePlanta
			energia = unaResistencia
		]
	}

	def agregarPlantaDeRecompensa(Planta planta) {
		this.plantasDeRecompensa.add(planta)
	}

	override protected getCriterio(Planta example) {
		null
	}

	override createExample() {
		new Planta
	}

	override getEntityType() {
		typeof(Planta)
	}

	def getPlantasDeUnTipo(TipoDePlanta tipo) {
		allInstances.filter[planta|planta.tipo.equals(tipo)].toList
	}

	def getUnaPlantaDeRecompensa() {
		val numeroRandom = new Random().nextInt(plantasDeRecompensa.size)
		plantasDeRecompensa.get(numeroRandom)
	}

}
