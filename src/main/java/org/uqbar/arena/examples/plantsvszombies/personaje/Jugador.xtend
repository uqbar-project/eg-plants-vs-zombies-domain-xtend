package org.uqbar.arena.examples.plantsvszombies.personaje

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class Jugador {
	String nombre
	int recursos

	new(String nombreDelJugador) {
		nombre = nombreDelJugador
		recursos = 400
	}

	def getNombre() {
		nombre
	}

	def agregarRecursos(int nuevosRecursos) {
		if (0 >= nuevosRecursos) {
			throw new UserException("Los nuevos recursos deben ser positivos. Recursos: " + nuevosRecursos)
		}
		recursos = recursos + nuevosRecursos
	}
	
	def descontarRecursos(int valor) {
		recursos = recursos - valor
	}
	
}
