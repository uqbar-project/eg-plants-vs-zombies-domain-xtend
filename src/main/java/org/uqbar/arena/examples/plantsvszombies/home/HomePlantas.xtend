package org.uqbar.arena.examples.plantsvszombies.home

import java.util.List
import java.util.Random
import org.uqbar.arena.examples.plantsvszombies.planta.Planta
import org.uqbar.arena.examples.plantsvszombies.planta.TipoAcuatica
import org.uqbar.arena.examples.plantsvszombies.planta.TipoDePlanta
import org.uqbar.arena.examples.plantsvszombies.planta.TipoTerrestre
import org.uqbar.commons.model.CollectionBasedHome

class HomePlantas extends CollectionBasedHome<Planta> {

	List<Planta> plantasDeRecompensa = newArrayList

	new() {
		this.init
	}

	def void init() {
		agregarPlanta(create("Meduza", 45, 20, new TipoAcuatica))
		agregarPlanta(create("Waterprof", 50, 1, new TipoAcuatica))
		agregarPlanta(create("Shooter", 49, 5, new TipoTerrestre))
		agregarPlanta(create("Water lettuce", 33, 80, new TipoAcuatica))
		agregarPlanta(create("Embriofitas", 41, 50, new TipoTerrestre))
		agregarPlanta(create("Helecho", 30, 40, new TipoTerrestre))
		agregarPlanta(create("Sesamo", 50, 20, new TipoTerrestre))
		agregarPlanta(create("Adelfa", 90, 50, new TipoAcuatica))
		agregarPlanta(create("Cyperus", 95, 60, new TipoAcuatica))
		crearPlantasDeRecompensa
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

	def agregarPlanta(Planta planta) {
		this.create(planta)
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

	def crearPlantasDeRecompensa() {
		plantasDeRecompensa => [
			add(create("Maranta", 70, 40, new TipoTerrestre))
			add(create("Alga", 50, 30, new TipoAcuatica))
			add(create("Irupe", 50, 20, new TipoAcuatica))
			add(create("Castus", 45, 20, new TipoTerrestre))
		]
	}

	def getUnaPlantaDeRecompensa() {
		val numeroRandom = new Random().nextInt(plantasDeRecompensa.size)
		plantasDeRecompensa.get(numeroRandom)
	}

}
