package org.uqbar.arena.examples.plantsvszombies.recompensa

import java.util.List
import java.util.Random
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.arena.examples.plantsvszombies.jardin.JardinZen
import org.uqbar.arena.examples.plantsvszombies.personaje.Jugador
import org.uqbar.arena.examples.plantsvszombies.repo.RepoPlantas
import org.uqbar.arena.examples.plantsvszombies.zombie.Zombie
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class Recompensador implements RecompensaObserver {

	Zombie zombie
	RepoPlantas repoPlantas
	JardinZen jardinZen
	Jugador jugador
	Recompensa recompensa
	List<String> log

	def getNumeroRandomEntreCeroYuno() {
		val rand = new Random()
		rand.nextFloat()
	}

	def private darRecompensa() {
		if (getNumeroRandomEntreCeroYuno <= 0.5) {
			recompensa = new RecompensaVacia(zombie)
		} else if (getNumeroRandomEntreCeroYuno <= 0.5) {
			recompensa = new RecompensaDePlantas(zombie, jardinZen, repoPlantas)
		} else {
			recompensa = new RecompensaZombie(zombie, jugador)
		}
	}

	override darPremio() {
		if (!zombie.estasVivo) {
			darRecompensa
		} else {
			recompensa = new RecompensaPerdiste(zombie)
		}
		recompensa.generarRecompensa
		log = recompensa.log
	}
	
}
