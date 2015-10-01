package aemps;
import java.util.Calendar;
import java.util.GregorianCalendar;

public class Medicamento {   	// crea los atributos
	private String nombre;
	private String farmaceutica;
	private String principio_Activo;
	private String indicaciones;
	private Calendar fecha;
	private String fecha1;
	private String efectos_adversos;
	private String Estado_de_Solicitud;
	
	
	//constructor
	public Medicamento(String nombre, String farmaceutica,String  principio_Activo, String indicaciones,String efectos_adversos){
		this.nombre= nombre;
		this.farmaceutica=farmaceutica;
		this.principio_Activo=principio_Activo;
		this.indicaciones=indicaciones;	
		fecha=GregorianCalendar.getInstance();
		fecha1=fecha.getTime().toLocaleString();
		this.efectos_adversos=efectos_adversos;
		
		
	}
	
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getFarmaceutica() {
		return farmaceutica;
	}
	public void setFarmaceutica(String farmaceutica) {
		this.farmaceutica = farmaceutica;
	}
	public String getPrincipio_Activo() {
		return principio_Activo;
	}
	public void setPrincipio_Activo(String principio_Activo) {
		this.principio_Activo = principio_Activo;
	}
	public String getIndicaciones() {
		return indicaciones;
	}
	public void setIndicaciones(String indicaciones) {
		this.indicaciones = indicaciones;
	}
	public String getFecha() {
		String fecha_string=fecha1.toString();
		return fecha_string;
	}

	public String getEfectos_adversos() {
		return efectos_adversos;
	}

	public void setEfectos_adversos(String efectos_adversos) {
		this.efectos_adversos = efectos_adversos;
	}

	public String getEstado_de_Solicitud() {
		return Estado_de_Solicitud;
	}

	public void setEstado_de_Solicitud(String estado_de_Solicitud) {
		Estado_de_Solicitud = estado_de_Solicitud;
	}
	@Override
	public String toString(){
		String string;
		string="Nombre de medicamento: "+nombre+"\n Farmaceutica: "+farmaceutica+"\n Principio activo: "+principio_Activo+"\n indicaciones: "+indicaciones+"\n efectos adversos: "+efectos_adversos;
		
		return string;
	}

}
