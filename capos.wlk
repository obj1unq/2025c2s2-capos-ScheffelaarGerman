//-- Personajes--//
object rolando {
    var property mochila  = #{}
    var  property capacidadDeMochila = 2
    var  hogar = castilloDePiedras 
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
    
    method hogar() { return hogar }

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
   
    method poderMaximoEnHogar() {
      return hogar.poderMaximoEnHogar()
    }

method enemigosQuePuedeVencer() {
  var enemigos = [caterina, archibaldo, astra]
  return enemigos.filter({ enemigo => enemigo.poderDePelea() < self.poderDePelea() })
}

method moradasQuePuedeConquistar() {
  return self.enemigosQuePuedeVencer().map({ enemigo => enemigo.hogar() })
}

method esPoderosoEnLaTierro(){

}

method esPoderosoEnLaTierra() {
  var enemigos = [caterina, archibaldo, astra]
  return enemigos.all({ enemigo => self.poderDePelea() > enemigo.poderDePelea() })
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
  var property hechizos = []

  method poderQueAportaA(personaje) {
    if (hechizos.isEmpty()) {
      return 0
    } else {
      return hechizos.first().poderQueAportaA(personaje)
    }
  }

  method usarEnBatalla(unPersonaje) {
  if (not hechizos.isEmpty()) {
    hechizos = hechizos.drop(1)    
  }
}

  method cargarHechizo(unHechizo) {
    hechizos.add(unHechizo)
  }
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

//-- Hogare --//
object castilloDePiedras {
  var property artefactos = #{}

  method recibir(artefactosEnMochila) {
    artefactos = artefactos.union(artefactosEnMochila)
  }

  method artefactosEnHogar() { return artefactos }

  method poderMaximoEnHogar(unPersonaje) {
    const aportes = artefactos
      .map({ artefacto => artefacto.poderQueAportaA(unPersonaje) })
    return aportes.max()
  }
}
object fortalezaDeAcero {}
object palacioDeMarmol {}
object torreDeMarfil{}

//-- Hechizos --//

object bendicion {
    method poderQueAportaA(unPersonaje) {
        return 4      
     }
}

object invisibilidad {
    method poderQueAportaA(unPersonaje) {
        return unPersonaje.poderBase()  
    }
}
object invocacion {
  method poderQueAportaA(unPersonaje) {
    return unPersonaje.hogar().poderMaximoEnHogar(unPersonaje)
  }
}

//-- Enemigos --//
object caterina {
    var property poderDePelea = 28
    var property hogar = fortalezaDeAcero
    
}
object archibaldo {
    var property poderDePelea = 16
    var property hogar = palacioDeMarmol

}

object astra {
    var property poderDePelea = 14
    var property  hogar =   torreDeMarfil
 
}



    
