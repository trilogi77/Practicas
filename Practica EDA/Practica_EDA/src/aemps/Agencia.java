package aemps;

import java.util.Calendar;
//import edalib.list.singlelink.SQueue;
import java.util.Scanner;

public class Agencia implements IAgencia {
	

	private Cola colaEspera=new Cola();
	
	

	@Override
	public void recibir(Medicamento medicamento) {
		// TODO Auto-generated method stub
		
		
		
		colaEspera.enqueue(medicamento);
		
		
	}

	@Override
	public void revisar() {
		colaEspera.front();
		// TODO Auto-generated method stub

	}

	@Override
	public void consultarMedicamento(String nombreMedicamento) {
		// TODO Auto-generated method stub

	}

	@Override
	public void aprobar(String nombreMedicamento) {
		// TODO Auto-generated method stub

	}

	@Override
	public void retirar(String nombreMedicamento) {
		// TODO Auto-generated method stub

	}

	@Override
	public void consultarAprobados(Calendar fecha) {
		// TODO Auto-generated method stub

	}

	@Override
	public void consultarAprobados() {
		// TODO Auto-generated method stub

	}

	@Override
	public void consultarRetirados(Calendar fecha) {
		// TODO Auto-generated method stub

	}

	@Override
	public void consultarRetirados() {
		// TODO Auto-generated method stub

	}

	@Override
	public void consultaMedicamentos(String principioActivo) {
		// TODO Auto-generated method stub

	}

	@Override
	public void recibir() {
		// TODO Auto-generated method stub
		
	}

	public Cola getColaEspera() {
		return colaEspera;
	}

	public void setColaEspera(Cola colaEspera) {
		this.colaEspera = colaEspera;
	}

}
