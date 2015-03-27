package org.uqbar.arena.examples.plantsvszombies.recompensa

import org.uqbar.arena.examples.plantsvszombies.zombie.Zombie
import org.uqbar.arena.examples.plantsvszombies.jardin.JardinZen
import org.uqbar.arena.examples.plantsvszombies.home.HomePlantas

class RecompensaDePlantas extends Recompensa {

	HomePlantas homePlantas
	JardinZen jardinZen

	new(Zombie zombie, JardinZen unJardin, HomePlantas laHomePlantas) {
		super(zombie)
		homePlantas = laHomePlantas
		jardinZen = unJardin
	}

	def getPlantaDeRecompensa() {
		val planta = homePlantas.getUnaPlantaDeRecompensa
		jardinZen.agregarPlanta(planta)
		planta
	}

	override generarRecompensa() {
		val planta = plantaDeRecompensa
		log.add("Obtuviste la planta " + planta.nombre + " de recompensa del tipo " + planta.tipo)
	}

}
