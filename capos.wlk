//-- Personajes--//
object rolando {
    var property mochila  = #{}
    var  property capacidadDeMochila = 2
    var  property hogar = castilloDePiedras 
    var property historialDeEncuentros = []
    var property poderBase = 0
    var property cantidadDePeleas = 0

    method configurarCapacidadDeMochila (capacidad){ capacidadDeMochila = capacidad}
    
    method encontrar(artefacto){
       historialDeEncuentros.add(artefacto)
        if (mochila.size()< capacidadDeMochila) { mochila.add(artefacto)}
    }
    
    method artefactosEnMochila(){return mochila}
    
    method vaciarMochila(){mochila.clear()}
    
    method llegarA (_hogar){
        _hogar.recibir(mochila)
        self.vaciarMochila()
    }

    method posesiones(){return mochila.union(hogar.artefactosEnHogar())}

    method posee(artefacto) {return self.posesiones().contains(artefacto)}

   

    method poderDePelea(){
        return self.poderBase() + mochila.sum({artefacto => artefacto.poderQueAportaA(self)})
    }

 method luchar() {
    mochila.forEach({ artefacto => artefacto.usarEnBatalla(self) })
    self.poderBase(self.poderBase() + 1)
    self.cantidadDePeleas(self.cantidadDePeleas()+1)

    }
}
//-- Artefactos --/

object espadaDelDestino {
    var esLaPrimeraVezQueSeUtiliza = true

    method poderQueAportaA(personaje) {
        if (esLaPrimeraVezQueSeUtiliza) {
            return personaje.poderBase()     
        } else {
            return personaje.poderBase() / 2  
        }
    }

    method usarEnBatalla(unPersonaje) {
        esLaPrimeraVezQueSeUtiliza = false   
    }
}


object libroDeHechizos {
    method usarEnBatalla(unPersonaje){}
}

object collarDivino {
   var cantidadDeBatallas = 0
   
    method poderQueAportaA(personaje){
        if (personaje.poderBase()>6) {
        return 3 + cantidadDeBatallas
        } else { return 3}  
    }
    method usarEnBatalla(unPersonaje){ cantidadDeBatallas += 1 }
}
object armaduraDeAcero {
    method poderQueAportaA(personaje){return 6}
    method usarEnBatalla(unPersonaje){}
}

//-- Hogares-- //
object castilloDePiedras {
    var property artefactos = #{}

    method recibir (artefactosEnMochila){artefactos = artefactos.union(artefactosEnMochila)}
    
    method artefactosEnHogar(){ return artefactos}
}