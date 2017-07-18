package org.uqbar.arena.examples.plantsvszombies.personaje

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.arena.examples.plantsvszombies.exception.ConfigurationException
import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
abstract class Personaje extends Entity {
	int resistencia
	int potenciaDeAtaque
	String nombre
	String descripcion
	int energia

	def validar() {
		if (potenciaDeAtaque < poderDeAtaqueMinimo || potenciaDeAtaque > poderDeAtaqueMaximo)
			throw new ConfigurationException("Potencia de ataque invalida: " + potenciaDeAtaque)
		if (resistencia < resistenciaMinima || resistencia > resistenciaMaxima)
			throw new ConfigurationException("Resistencia invalida: " + resistencia)
		if (!tieneNombre)
			throw new ConfigurationException("Debe ingresar un nombre.")
	}

	def private tieneNombre() {
		nombre != null && !nombre.trim().equals("")
	}
	
	def estasVivo(){
		energia > 0
	}
	
	override toString() {
		getNombre
	}

	def int poderDeAtaqueMinimo()

	def int poderDeAtaqueMaximo()

	def int resistenciaMinima()

	def int resistenciaMaxima()

}
