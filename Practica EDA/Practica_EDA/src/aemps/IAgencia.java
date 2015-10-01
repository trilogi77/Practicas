package aemps;
import java.util.Calendar;


public interface IAgencia {
	void recibir(Medicamento medicamento); 		//recibe un medicamento y lo mete en la lista de solicitud
	void revisar();			//coje el primero y decide si aprueba o no el medicamento
	void consultarMedicamento(String nombreMedicamento);		//imprime por pantalla toda la infor del medicamento
	void aprobar(String nombreMedicamento);
	void retirar(String nombreMedicamento);
	void consultarAprobados(Calendar fecha); 	//consulta cuantos medicamentos se aprobaron antes de la fecha
	void consultarAprobados();		//consulta cuantos medicamentos se aprobaron
	void consultarRetirados(Calendar fecha);	//consulta cuantos medicamentos se retiraron antes de la fecha
	void consultarRetirados();		////consulta cuantos medicamentos se retiraron
	void consultaMedicamentos(String principioActivo);		//dice los medicamentos que tienen el ppio activo
	void recibir();
}

