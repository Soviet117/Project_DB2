package dao;

import java.util.List;
import model.Horario;

/**
 *
 * @author Soviet
 */
public interface MatriculaDAO {
    
    List<Horario> loadHorarios(int id_ciclo, int id_carrera);   
    
    void insertMatricula(int id_alumno, int id_horario, String fecha_matri, String estado);
}
