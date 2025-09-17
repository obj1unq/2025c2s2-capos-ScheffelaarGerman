//-- Personajes--//
object rolando {
    var property mochila  = #{}
    var  property capacidadDeMochila = 2
    var  property hogar = castilloDePiedras 
    var property historialDeEncuentros = []

    method configurarCapacidadDeMochila (capacidad){ capacidadDeMochila = capacidad}
    
    method encontrar(artefacto){
       historialDeEncuentros.add(artefacto)
        if (mochila.size()< capacidadDeMochila) { mochila.add(artefacto)}
    }
    
    method artefactosEnMochila(){return mochila}

    method llegarA (_hogar){
        _hogar.recibir(mochila)
        mochila.clear()
    }
    method posesiones(){
        return mochila.union(hogar.artefactosEnHogar())
    }
method posee(artefacto) {
    return self.posesiones().contains(artefacto)
}

    

}

//-- Artefactos --/

object espadaDelDestino {}
object libroDeHechizos {}

object collarDivino {}

object armaduraDeAcero {}

//-- Hogares-- //

object castilloDePiedras {
    var property artefactos = #{}

    method recibir (artefactosEnMochila){
        artefactos = artefactos.union(artefactosEnMochila)
    }
  method artefactosEnHogar(){ return artefactos}
}