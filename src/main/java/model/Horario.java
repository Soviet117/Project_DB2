package model;

/**
 *
 * @author Soivet
 */
public class Horario {
    private int id_horario;
    private int id_hora;
    private int id_dia;
    private String nom_aula;
    private int id_curso;
    private String nom_curso;
    private String codigo;
    
    public Horario(){
        
    }

    public Horario(int id_horario, int id_hora, int id_dia, String nom_aula, int id_curso, String nom_curso, String codigo) {
        this.id_horario = id_horario;
        this.id_hora = id_hora;
        this.id_dia = id_dia;
        this.nom_aula = nom_aula;
        this.id_curso = id_curso;
        this.nom_curso = nom_curso;
        this.codigo = codigo;
    }

    public int getId_horario() {
        return id_horario;
    }

    public void setId_horario(int id_horario) {
        this.id_horario = id_horario;
    }

    public int getId_hora() {
        return id_hora;
    }

    public void setId_hora(int id_hora) {
        this.id_hora = id_hora;
    }

    public int getId_dia() {
        return id_dia;
    }

    public void setId_dia(int id_dia) {
        this.id_dia = id_dia;
    }

    public String getNom_aula() {
        return nom_aula;
    }

    public void setNom_aula(String nom_aula) {
        this.nom_aula = nom_aula;
    }

    public int getId_curso() {
        return id_curso;
    }

    public void setId_curso(int id_curso) {
        this.id_curso = id_curso;
    }

    public String getNom_curso() {
        return nom_curso;
    }

    public void setNom_curso(String nom_curso) {
        this.nom_curso = nom_curso;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    @Override
    public String toString() {
        return "Horario{" + "id_horario=" + id_horario + ", id_hora=" + id_hora + ", id_dia=" + id_dia + ", nom_aula=" + nom_aula + ", id_curso=" + id_curso + ", nom_curso=" + nom_curso + ", codigo=" + codigo + '}';
    }
    
    
}
