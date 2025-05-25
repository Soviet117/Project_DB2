package model;

/**
 *
 * @author Soviet
 */
public class Alumno_Login {
    private int id_alumno;
    private int usuario;
    private String password;
    
    public Alumno_Login(){
        
    }

    public Alumno_Login(int id_alumno, int usuario, String password) {
        this.id_alumno = id_alumno;
        this.usuario = usuario;
        this.password = password;
    }

    public int getId_alumno() {
        return id_alumno;
    }

    public void setId_alumno(int id_alumno) {
        this.id_alumno = id_alumno;
    }

    public int getUsuario() {
        return usuario;
    }

    public void setUsuario(int usuario) {
        this.usuario = usuario;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "Alumno_Login{" + "id_alumno=" + id_alumno + ", usuario=" + usuario + ", password=" + password + '}';
    }
    
    
}
