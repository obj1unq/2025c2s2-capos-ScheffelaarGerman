object rolando {
    var property capacidadMochila = 2
    var property mochila = []
    var property totalEncuentros = []

    method encontrar(artefacto) {
        totalEncuentros.add(artefacto)
        if (mochila.size() < capacidadMochila) {
            mochila.add(artefacto)
        }
    }

    method artefactos() {
        return mochila
    }

    method configurarCapacidad(nuevaCapacidad) {
        capacidadMochila = nuevaCapacidad
    }

    method vaciarMochila() {
        mochila.clear()
    }

    method llegarAlCastillo() {
        castilloDePiedra.recibir(mochila)
        vaciarMochila()
    }

    method posesiones() {
        return mochila + castilloDePiedra.artefactosEnCastillo()
    }

    method posee(artefacto) {
        return posesiones().contains(artefacto)
    }

    method encuentros() {
        return totalEncuentros
    }
}

object castilloDePiedra {
    var property artefactos = []

    method recibir(coleccionArtefactos) {
        artefactos.addAll(coleccionArtefactos)
    }

    method artefactosEnCastillo() {
        return artefactos
    }
}

object espadaDelDestino {}
object libroDeHechizos {}
object collarDivino {}
object armaduraValyria {}
