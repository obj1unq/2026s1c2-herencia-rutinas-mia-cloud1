class Rutina { 
    method caloriasQuemadas(tiempo) {
        return 100 * (tiempo - self.descanso(tiempo)) * self.intensidad()
    }
    method descanso(tiempo)
    method intensidad()
}

class Running inherits Rutina{
    const intensidad 
    override method descanso(tiempo) {
        return if (tiempo > 20) 5 else 2
    }

    override method intensidad() {
        return intensidad
    }
}

class Maraton inherits Running {
    override method caloriasQuemadas(tiempo) {
        return super(tiempo) * 2
    }
}

class Remo inherits Rutina {
    override method descanso(tiempo) {
        return tiempo / 5
    }

    override method intensidad() = 1.3
}

class RemoCompetitivo inherits Remo {
    override method intensidad() = 1.7
    override method descanso(tiempo) { 
        return 2.max( super(tiempo)- 3)}
}

class Persona {
    var property peso
    method pesoQuePierde(rutina) {
        return rutina.caloriasQuemadas(self.tiempoDeEjercicio()) / self.kilosPorCaloríaQuePierde()
    }

    method aplicar(rutina) {
        self.validarSiPuedeAplicarRutina(rutina)
        peso = peso - self.pesoQuePierde(rutina)
    } 
    method tiempoDeEjercicio()
    method kilosPorCaloríaQuePierde()

    method validarSiPuedeAplicarRutina(rutina) {
        if (not self.puedeHacerRutina(rutina)) {
            self.error("No puede hacer esta rutina")
        }
    }

    method puedeHacerRutina(rutina)
}

class Sedentaria inherits Persona {
    const tiempoDeEjercicio
    override method kilosPorCaloríaQuePierde() = 7000
    override method puedeHacerRutina(rutina) { return peso > 50 }
    override method tiempoDeEjercicio() { return tiempoDeEjercicio}
}

class Atleta inherits Persona{
    override method tiempoDeEjercicio() = 90
    override method kilosPorCaloríaQuePierde() = 8000
    override method puedeHacerRutina(rutina) { 
        return rutina.caloriasQuemadas(self.tiempoDeEjercicio()) > 10000
    }
    override method pesoQuePierde(rutina) { 
        return super(rutina) - 1
    }
}

class Predio {
    const property rutinas = []
    method caloriasTotalesPara(persona) {
        return rutinas.sum({ r => r.caloriasQuemadas(persona.tiempoDeEjercicio()) })
    }

    method esElPredioMasTranquiloPara(persona) {
        return rutinas.any({ r => r.caloriasQuemadas(persona.tiempoDeEjercicio()) < 500 })
    }

    method rutinaMasExigentePara(persona) {
        return rutinas.max({ r => r.caloriasQuemadas(persona.tiempoDeEjercicio()) })
    }

}

class Club {
    const property predios = []
    method mejorPredioPara(persona) {
        return predios.max({p => p.caloriasTotalesPara(persona)})
    }

    method prediosTranquilosPara(persona) {
        return predios.filter({p => p.esElPredioMasTranquiloPara(persona)})
    }

    method rutinasMasExigentesPara(persona) {
        return predios.map({p => p.rutinaMasExigentePara(persona)})
    }
}