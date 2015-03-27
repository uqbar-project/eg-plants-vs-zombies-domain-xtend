package org.uqbar.arena.examples.plantsvszombies.recompensa

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.arena.examples.plantsvszombies.zombie.Zombie
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
abstract class Recompensa {
	List<String> log = new ArrayList
	protected Zombie zombie

	new(Zombie unZombie) {
		zombie = unZombie
		addDefaultLog
	}

	def protected addDefaultLog() {
		log.add("Felicitaciones!!. Venciste al zombie: " + zombie.nombre)
	}

	def void generarRecompensa()
}
