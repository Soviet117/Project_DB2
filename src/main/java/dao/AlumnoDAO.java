package dao;

import java.util.Date;
import java.util.List;
import model.Alumno;

/**
 *
 * @author Soviet
 */
public interface AlumnoDAO {
  
    List<Alumno> loadAlumnos();
    
    Alumno loadAlumno(int id_alumno);
    
    boolean updateAlumno(int id_alumno, String dni, String nombres, String apellidos, Date fecha_n, String celular,
        String correo, String direccion);
}
