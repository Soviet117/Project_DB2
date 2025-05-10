package dao;

import java.util.List;
import model.HorarioMatricula;

/**
 *
 * @author Soviet
 */
public interface MatriculaDAO {
    
    List<HorarioMatricula> loadHorarios(int id_ciclo, int id_carrera);   
    
    boolean insertMatricula(int id_matricula, int id_horario);
}
