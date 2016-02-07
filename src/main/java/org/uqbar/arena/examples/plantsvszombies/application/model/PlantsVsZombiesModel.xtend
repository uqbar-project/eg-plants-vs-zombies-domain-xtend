package org.uqbar.arena.examples.plantsvszombies.application.model

import java.util.ArrayList
import java.util.List
import java.util.Random
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.arena.examples.plantsvszombies.ataque.Ataque
import org.uqbar.arena.examples.plantsvszombies.exception.PlantsVsZombiesException
import org.uqbar.arena.examples.plantsvszombies.jardin.Fila
import org.uqbar.arena.examples.plantsvszombies.jardin.JardinDeJuego
import org.uqbar.arena.examples.plantsvszombies.jardin.JardinZen
import org.uqbar.arena.examples.plantsvszombies.mejoras.Mejora
import org.uqbar.arena.examples.plantsvszombies.mejoras.MejoradorDePlantas
import org.uqbar.arena.examples.plantsvszombies.personaje.Jugador
import org.uqbar.arena.examples.plantsvszombies.planta.Planta
import org.uqbar.arena.examples.plantsvszombies.planta.TipoAcuatica
import org.uqbar.arena.examples.plantsvszombies.planta.TipoDePlanta
import org.uqbar.arena.examples.plantsvszombies.planta.TipoTerrestre
import org.uqbar.arena.examples.plantsvszombies.recompensa.Recompensador
import org.uqbar.arena.examples.plantsvszombies.util.Shuffle
import org.uqbar.arena.examples.plantsvszombies.zombie.Zombie
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.ApplicationContext
import org.uqbar.commons.utils.Observable
import org.uqbar.arena.examples.plantsvszombies.repo.RepoMejoras
import org.uqbar.arena.examples.plantsvszombies.repo.RepoPlantas
import org.uqbar.arena.examples.plantsvszombies.repo.RepoZombies

/**
 * 
 */
@Observable
@Accessors
class PlantsVsZombiesModel {
	Jugador jugadorActual

	//Actores principales del juego
	JardinDeJuego jardinDeJuego
	JardinZen jardinZenJuego
	List<Zombie> zombies

	//Selecciones
	Zombie zombieSeleccionado
	Fila filaSeleccionada
	Planta plantinSeleccionado
	Integer filaAPlantar
	Integer columnaAPlantar
	Mejora mejoraDisponibleSeleccionada
	Mejora mejoraCompradaSeleccionada

	//Para mostrar el jardinZen
	TipoDePlanta tipoDePlantaSeleccionada
	Planta plantaSeleccionada

	Recompensador recompensaObserver
	List<Mejora> mejoras
	List<Mejora> mejorasCompradas

	new() {
		inicializarElementosDeJuego
	}

	def inicializarElementosDeJuego() {
		jardinDeJuego = new JardinDeJuego
		jardinZenJuego = new JardinZen
		recompensaObserver = new Recompensador
		jugadorActual = new Jugador("nombre x default")
		jardinDeJuego.crearTablero(5, 5)
		agregarPlantasAlJardinDeJuego
		tipoDePlantaSeleccionada = new TipoTerrestre
		jardinZenJuego.plantas = repoPlantas.allInstances.toList
		plantinSeleccionado = jardinZenJuego.plantas.get(0)
		crearZombies
		crearMejoras
	}

	def crearMejoras() {
		mejoras = new ArrayList
		mejorasCompradas = new ArrayList
		repoMejoras.allInstances.toList.forEach[m|mejoras.add(m)]
	}

	def getCantidadDeLugaresDisponibles() {
		jardinZenJuego.cantidadDeLugaresLibres(tipoDePlantaSeleccionada)
	}

	def getPlantas() {
		jardinZenJuego.getPlantasDeUnTipo(tipoDePlantaSeleccionada)
	}

	def atacar() {
		val ataque = new Ataque(filaSeleccionada, zombieSeleccionado)
		recompensaObserver = createRecompensaObserver
		ataque.addRecompensaObserver(recompensaObserver)
		ataque.comenzarAtaque
	}
	
	def actualizarListaZombies() {
		val listaDeZombies = new ArrayList<Zombie>
		for (Zombie zombie : this.zombies.filter[z|z.estasVivo]) {
			listaDeZombies.add(zombie)
		}
		this.zombies = listaDeZombies
		this.seleccionarZombieNumeroUno
	}

	def agregarPlantasAlJardinDeJuego() {
		val filas = jardinDeJuego.filas
		filas.forEach[fila|agregarPlantasAlaFila(fila)]
	}

	def agregarPlantasAlaFila(Fila fila) {
		var plantas = repoPlantas.getPlantasDeUnTipo(fila.tipo)
		val shuffle = new Shuffle<Planta>
		plantas = shuffle.doTask(plantas)
		val cantidadDeCasilleros = fila.getCantidadDeCasilleros

		var plantasAgregadas = 0
		for (i : 0 ..< cantidadDeCasilleros) {
			val rand = new Random()
			val numeroRandom = rand.nextInt(2)
			if (numeroRandom == 1 && plantasAgregadas < plantas.size) {
				fila.casilleros.get(i).planta = plantas.get(plantasAgregadas).clone as Planta
				plantasAgregadas = plantasAgregadas + 1
			}
		}
	}

	def void crearZombies() {
		val shuffle = new Shuffle<Zombie>
		val zombiesAux = shuffle.doTask(repoZombies.allInstances)
		val rand = new Random()
		val numeroRandom = rand.nextInt(2) + 2 //Entre 2 y 2 zombies
		zombies = zombiesAux.subList(0, numeroRandom)
		seleccionarZombieNumeroUno
	}

	def seleccionarZombieNumeroUno() {
		if (zombies.size > 0) {
			zombieSeleccionado = zombies.get(0)
		}
	}
	
	def actualizarListaPlantas() {
		var numeroDeFila = 0
		if (null != this.filaSeleccionada) {
			numeroDeFila = this.filaSeleccionada.numeroDeDFila
		}

		val filas = this.jardinDeJuego.filas as ArrayList<Fila>
		this.jardinDeJuego.filas = null
		this.jardinDeJuego.filas = filas
		this.filaSeleccionada = this.jardinDeJuego.filas.get(numeroDeFila)

		val plantines = this.jardinZenJuego.plantas as ArrayList<Planta>
		this.jardinZenJuego.plantas = null
		this.jardinZenJuego.plantas = plantines
		val last = this.jardinZenJuego.plantas.size
		this.plantinSeleccionado = this.jardinZenJuego.plantas.get(last - 1)
	}

	def RepoZombies getRepoZombies() {
		ApplicationContext.instance.getSingleton(typeof(Zombie))
	}

	def RepoPlantas getRepoPlantas() {
		ApplicationContext.instance.getSingleton(typeof(Planta))
	}
	
	def RepoMejoras getRepoMejoras() {
		ApplicationContext.instance.getSingleton(typeof(Mejora))
	}

	def cambiarTipoDePlanta() {
		if (getTipoDePlantaSeleccionada.equals(new TipoTerrestre)) {
			tipoDePlantaSeleccionada = new TipoAcuatica
		} else {
			tipoDePlantaSeleccionada = new TipoTerrestre
		}
	}

	def createRecompensaObserver() {
		new Recompensador => [
			jugador = jugadorActual
			jardinZen = jardinZenJuego
			zombie = zombieSeleccionado
			repoPlantas = getRepoPlantas
		]
	}

	def perdioElJuego() {
		jardinDeJuego.filas.filter[f|f.estaVacia].size > 0
	}

	def ganoElJuego() {
		zombies.isEmpty
	}

	def mejorarPlanta() {
		val mejorador = new MejoradorDePlantas(jugadorActual)
		mejorador.mejorar(plantinSeleccionado, mejoraDisponibleSeleccionada)
		mejorasCompradas.add(mejoraDisponibleSeleccionada)
	}
	
	def plantar() {
		try {
			if (null == this.filaSeleccionada || null == this.columnaAPlantar) {
				throw new UserException("Seleccione una fila y numero de casillero en donde plantar")
			}
			this.filaSeleccionada.agregaUnaPlantaAlCasillero(this.plantinSeleccionado, this.columnaAPlantar - 1)
			this.actualizarListaPlantas

		} catch (PlantsVsZombiesException e) {
			throw new UserException(e.message)
		}
	}

}
