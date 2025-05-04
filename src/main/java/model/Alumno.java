package model;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author Soviet
 */
public class Alumno implements Serializable{
    private static final long serialVersionUID = 1L;
    
    private int id_alumno;
    private int id_persona;
    private String codigo;
    private String dni;
    private String nombres;
    private String apellidos;
    private Date fecha_n;
    private String numeroT;
    private String correo;
    private String direccion;
    private String fecha_ingre;
    private String password;
    private String estado;
    private int id_ciclo;
    private int id_carrera;
    
    public Alumno(){
        
    }

    public Alumno(int id_alumno, int id_persona, String codigo, String dni, String nombres, 
            String apellidos, Date fecha_n, String numeroT, String correo, String direccion, 
            String fecha_ingre, String password, String estado, int id_ciclo, int id_carrera) {
        this.id_alumno = id_alumno;
        this.id_persona = id_persona;
        this.codigo = codigo;
        this.dni = dni;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.fecha_n = fecha_n;
        this.numeroT = numeroT;
        this.correo = correo;
        this.direccion = direccion;
        this.fecha_ingre = fecha_ingre;
        this.password = password;
        this.estado = estado;
        this.id_ciclo = id_ciclo;
        this.id_carrera = id_carrera;
    }

    public int getId_alumno() {
        return id_alumno;
    }
    
    public int getId_persona() {
        return id_persona;
    }

    public String getCodigo() {
        return codigo;
    }

    public String getDni() {
        return dni;
    }

    public String getNombres() {
        return nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public Date getFecha_n() {
        return fecha_n;
    }

    public String getNumeroT() {
        return numeroT;
    }

    public String getCorreo() {
        return correo;
    }

    public String getDireccion() {
        return direccion;
    }

    public String getFecha_ingre() {
        return fecha_ingre;
    }

    public String getPassword() {
        return password;
    }

    public String getEstado() {
        return estado;
    }

    public int getId_ciclo() {
        return id_ciclo;
    }

    public int getId_carrera() {
        return id_carrera;
    }

    public void setId_alumno(int id_alumno) {
        this.id_alumno = id_alumno;
    }

    public void setId_persona(int id_persona) {
        this.id_persona = id_persona;
    }
    
    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public void setFecha_n(Date fecha_n) {
        this.fecha_n = fecha_n;
    }

    public void setNumeroT(String numeroT) {
        this.numeroT = numeroT;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public void setFecha_ingre(String fecha_ingre) {
        this.fecha_ingre = fecha_ingre;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public void setId_ciclo(int id_ciclo) {
        this.id_ciclo = id_ciclo;
    }

    public void setId_carrera(int id_carrera) {
        this.id_carrera = id_carrera;
    }

    @Override
    public String toString() {
        return "Alumno{" + "id_alumno=" + id_alumno + ", id_persona=" + id_persona + ", codigo=" + codigo + ", dni=" + dni + ", nombres=" + nombres + ", apellidos=" + apellidos + ", fecha_n=" + fecha_n + ", numeroT=" + numeroT + ", correo=" + correo + ", direccion=" + direccion + ", fecha_ingre=" + fecha_ingre + ", password=" + password + ", estado=" + estado + ", id_ciclo=" + id_ciclo + ", id_carrera=" + id_carrera + '}';
    }
    
}
