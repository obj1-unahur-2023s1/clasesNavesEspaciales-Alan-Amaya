class NaveEspacial {
	var velocidad = 0
	var direccion = 0
	var combustible = 0
	
	method acelerar(cuanto) {
		velocidad = (velocidad + cuanto).min(100000)
	}
	method desacelerar(cuanto) {
		velocidad = (velocidad-cuanto).max(0)
	}
	method irHaciaElSol() { direccion = 10 }
	method escaparDelSol() { direccion = -10 }
	method ponerseParaleloAlSol() { direccion = 0 }
	
	method acercarseUnPocoAlSol(){	direccion = (direccion + 1).min(10)	}
	method alejarseUnPocoDelSol(){	direccion = (direccion - 1).max(-10)	}
	
	method cargarCombustible(cuanto){ combustible = (combustible+cuanto).max(0)}
	method descargarCombustible(cuanto){ combustible = (combustible-cuanto).max(0)}
	
	method prepararViaje(){
		self.cargarCombustible(30000)
		self.acelerar(5000)	
	}
	
	method estaTranquila() = combustible >= 4000 and velocidad<=12000
}

class NaveBaliza inherits NaveEspacial{
	var colorAMostrar = ""
	
	method cambiarColorDeBaliza(colorNuevo){ colorAMostrar = colorNuevo}
	
	override method prepararViaje(){
		self.cambiarColorDeBaliza("verde")
		self.ponerseParaleloAlSol()
		super()
	}
	override method estaTranquila() = super() and colorAMostrar != "rojo"
	
	method recibirAmenaza(){
		self.irHaciaElSol()
		self.cambiarColorDeBaliza("rojo")
	}
}

class NavePasajeros inherits NaveEspacial{
	var property cantPasajeros
	var racionesComida
	var racionesBebida
	
	method	cargarComida(cuanto){ racionesComida =+ cuanto}
	method	descargarComida(cuanto){ racionesComida =- cuanto}
	method	cargarBebida(cuanto){ racionesBebida =+ cuanto}
	method	descargarBebida(cuanto){ racionesBebida =- cuanto}
	
	override method prepararViaje(){
		self.cargarComida(cantPasajeros*4)
		self.cargarBebida(cantPasajeros*6)
		self.acercarseUnPocoAlSol()
		super()
	}
	
	method recibirAmenaza(){
		self.acelerar(velocidad*2)
		self.descargarBebida(cantPasajeros*2)
		self.descargarComida(cantPasajeros)
	}
}

class NaveCombate inherits NaveEspacial{
	var esInvisible = false
	var misilesDesplegados = false
	const property mensajesEmitidos = []												//HAY QUE VER
	
	method ponerseVisible() { esInvisible = false }
	method ponerseInvisible() { esInvisible = true }
	method estaInvisible() = esInvisible
	
	method desplegarMisiles() { misilesDesplegados = true }
	method replegarMisiles() { misilesDesplegados = false }
	method misilesDesplegados() = misilesDesplegados
	
	method primerMensaje(){ return mensajesEmitidos.first() }
	method ultimoMensaje(){ return mensajesEmitidos.last() }		
	method mensajesEmitidos(){ return mensajesEmitidos.map() }							
	method emitirMensaje(mensaje){	mensajesEmitidos.add(mensaje)	}
	method esEscueta(){	mensajesEmitidos.all( {m => m.size() <= 30} )	}
	
	override method prepararViaje(){
		self.ponerseVisible()
		self.replegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("Saliendo en misión")
		self.cargarCombustible(30000)
		self.acelerar(5000)
		self.acelerar(15000)
	}
	
	override method estaTranquila() = super() and !misilesDesplegados
	
	method recibirAmenaza(){
		self.acercarseUnPocoAlSol()
		self.acercarseUnPocoAlSol()
		self.emitirMensaje("Amenaza recibida")
	}
}

class NaveHosiptal inherits NavePasajeros {
	var quirofanosPreparados = true
	
	method prepararQuirofanos() {	quirofanosPreparados = true	}
	method usarQuirofanos() {	quirofanosPreparados = false}
	
	override method estaTranquila() = super() and !quirofanosPreparados
	override method recibirAmenaza(){
		super()
		self.prepararQuirofanos()
	}
}

class NaveCombateSigilosa inherits NaveCombate{
	
	override method estaTranquila() = super () and !esInvisible
	
	override method recibirAmenaza(){
		super()
		self.desplegarMisiles()
		self.ponerseInvisible()
	}
}
	
