package org.uqbar.arena.examples.plantsvszombies.ataque

import java.util.ArrayList
import java.util.List
import org.uqbar.arena.examples.plantsvszombies.jardin.Casillero
import org.uqbar.arena.examples.plantsvszombies.jardin.Fila
import org.uqbar.arena.examples.plantsvszombies.planta.Planta
import org.uqbar.arena.examples.plantsvszombies.recompensa.RecompensaObserver
import org.uqbar.arena.examples.plantsvszombies.zombie.Zombie
import org.uqbar.commons.model.exceptions.UserException

class Ataque {
	Fila fila
	Zombie zombie
	List<RecompensaObserver> recompensaObservers = new ArrayList

	new(Fila unaFila, Zombie unZombie) {
		fila = unaFila
		zombie = unZombie
		this.validar
	}

	def addRecompensaObserver(RecompensaObserver recompensa) {
		recompensaObservers.add(recompensa)
	}

	def validar() {
		if (null == fila) {
			throw new UserException("Seleccione una nueva fila para atacar.")
		}
		if (fila.cantidadDeCasillerosOcupados <= 0) {
			throw new UserException("La fila debe tener plantas.")
		}
	}

	def darPremio() {
		recompensaObservers.forEach[observer|observer.darPremio]
	}

	def void comenzarAtaque() {
		while (zombie.estasVivo && fila.cantidadDeCasillerosOcupados > 0) {
			val casillero = fila.casilleros.findLast[c|c.estasOcupado]
			ataquense(casillero)
			fila.removerPlantasMuertas
		}
		darPremio()
	}

	def private ataquense(Casillero unCasillero) {
		atacarALaPlanta(unCasillero.planta)
		atacarAlZombie()
	}

	def private atacarALaPlanta(Planta unaPlanta) {
		unaPlanta.energia = unaPlanta.energia - zombie.potenciaDeAtaque
	}

	def private atacarAlZombie() {
		for (Casillero casillero : fila.casillerosOcupados) {
			val reductor = calcularReductor(casillero)
			val danio = casillero.planta.potenciaDeAtaque * reductor
			zombie.energia = zombie.energia - danio as int
		}
	}

	def private calcularReductor(Casillero unCasillero) {
		val distancia = (unCasillero.numeroDeCasillero * 100) / fila.cantidadDeCasilleros as double
		distancia / 100 as double
	}

}
