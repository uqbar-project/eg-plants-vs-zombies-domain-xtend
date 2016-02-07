package org.uqbar.arena.examples.plantsvszombies.repo

import org.uqbar.arena.examples.plantsvszombies.mejoras.Mejora
import org.uqbar.arena.examples.plantsvszombies.mejoras.MejoraDefensiva
import org.uqbar.arena.examples.plantsvszombies.mejoras.MejoraOfensiva
import org.uqbar.commons.model.CollectionBasedRepo

class RepoMejoras extends CollectionBasedRepo<Mejora> {

	new() {
	}

	override protected getCriterio(Mejora example) {
		null
	}

	override createExample() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override getEntityType() {
		typeof(Mejora)
	}
}
