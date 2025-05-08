package dao;

import java.util.List;
import model.Horario;

/**
 *
 * @author Soviet
 */
public interface MatriculaDAO {
    
    List<Horario> loadHorarios(int id_ciclo, int id_carrera);   
    
    boolean insertMatricula(int id_matricula, int id_horario);
}
