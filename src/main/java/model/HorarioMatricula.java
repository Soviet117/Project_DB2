package model;

/**
 *
 * @author Soviet
 */
public class HorarioMatricula {
    private int id_horario;
    private int id_curso;
    private String nombreC;
    private String apellidos;
    private String nombres;
    private String aula;
    private String dia;
    private String Hinicio;
    private String Hfin;
    private int capacidad;
    private int cupos;
    
    public HorarioMatricula(){
        
    }

    public HorarioMatricula(int id_horario, int id_curso, String nombreC, String apellidos, String nombres, 
            String aula, String dia, String Hinicio, String Hfin, int capacidad, int cupos) {
        this.id_horario = id_horario;
        this.id_curso = id_curso;
        this.nombreC = nombreC;
        this.apellidos = apellidos;
        this.nombres = nombres;
        this.aula = aula;
        this.dia = dia;
        this.Hinicio = Hinicio;
        this.Hfin = Hfin;
        this.capacidad = capacidad;
        this.cupos = cupos;
    }

    public int getId_horario() {
        return id_horario;
    }

    public void setId_horario(int id_horario) {
        this.id_horario = id_horario;
    }

    public int getId_curso() {
        return id_curso;
    }

    public void setId_curso(int id_curso) {
        this.id_curso = id_curso;
    }

    public String getNombreC() {
        return nombreC;
    }

    public void setNombreC(String nombreC) {
        this.nombreC = nombreC;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getAula() {
        return aula;
    }

    public void setAula(String aula) {
        this.aula = aula;
    }

    public String getDia() {
        return dia;
    }

    public void setDia(String dia) {
        this.dia = dia;
    }

    public String getHinicio() {
        return Hinicio;
    }

    public void setHinicio(String Hinicio) {
        this.Hinicio = Hinicio;
    }

    public String getHfin() {
        return Hfin;
    }

    public void setHfin(String Hfin) {
        this.Hfin = Hfin;
    }

    public int getCapacidad() {
        return capacidad;
    }

    public void setCapacidad(int capacidad) {
        this.capacidad = capacidad;
    }

    public int getCupos() {
        return cupos;
    }

    public void setCupos(int cupos) {
        this.cupos = cupos;
    }

    @Override
    public String toString() {
        return "Horario{" + "id_horario=" + id_horario + ", id_curso=" + id_curso + ", nombreC=" + nombreC + 
                ", apellidos=" + apellidos + ", nombres=" + nombres + ", aula=" + aula + ", dia=" + dia + 
                ", Hinicio=" + Hinicio + ", Hfin=" + Hfin + ", capacidad=" + capacidad + ", cupos=" + cupos + '}';
    }
    
    
    
}
