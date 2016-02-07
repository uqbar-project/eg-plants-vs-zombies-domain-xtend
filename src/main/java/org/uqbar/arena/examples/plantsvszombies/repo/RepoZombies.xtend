package org.uqbar.arena.examples.plantsvszombies.repo

import org.uqbar.arena.examples.plantsvszombies.zombie.Zombie
import org.uqbar.commons.model.CollectionBasedRepo

class RepoZombies extends CollectionBasedRepo<Zombie> {

	new() {
	}

	def create(String unNombre, int unaResistencia, int unaPotenciaDeAtaque) {
		val zombie = new Zombie => [
			nombre = unNombre.trim
			resistencia = unaResistencia
			potenciaDeAtaque = unaPotenciaDeAtaque
			energia = unaResistencia
		]
		this.create(zombie)
	}

	override protected getCriterio(Zombie example) {
		null
	}

	override createExample() {
		new Zombie
	}

	override getEntityType() {
		typeof(Zombie)
	}

	def search(String unZombie) {
		val todos = allInstances
		if (unZombie.nullOrEmpty) {
			todos.toList
		} else {
			todos.filter[z|z.toString().toLowerCase().contains(unZombie.trim.toLowerCase())].toList
		}
	}

}
