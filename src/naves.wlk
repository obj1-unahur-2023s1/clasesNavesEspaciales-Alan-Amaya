class NaveEspacial {
	var velocidad = 0
	var direccion = 0
	
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
	
}

class NaveBaliza inherits NaveEspacial{
	var colorAMostrar = ""
	
	method cambiarColorDeBaliza(colorNuevo){ colorAMostrar = colorNuevo}
	
	method prepararViaje(){
		self.cambiarColorDeBaliza("verde")
		self.ponerseParaleloAlSol()
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
	
	method prepararViaje(){
		self.cargarComida(cantPasajeros*4)
		self.cargarBebida(cantPasajeros*6)
		self.acercarseUnPocoAlSol()
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
	
	method primerMensaje(){ return mensajesEmitidos.first( {	m => m.toString() } ) } //REVISAR
	method ultimoMensaje(){ return mensajesEmitidos.last( {	m => m.toString() } ) }		//REVISAR
	method mensajesEmitidos(){ return mensajesEmitidos.map() }							//REVISAR
	method emitirMensaje(mensaje){	mensaje.printString()	}							//REVISAR
	method esEscueta() = false															//REVISAR
	
	method prepararViaje(){
		self.ponerseVisible()
		self.replegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("Saliendo en misión")
		
	}
	
}
