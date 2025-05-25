package dao;

import java.util.List;
import model.HorarioMatricula;

/**
 *
 * @author Soviet
 */
public interface MatriculaDAO {
    
    List<HorarioMatricula> loadHorarios(int id_alumno);
    
    List<HorarioMatricula> loadHorariosM(int id_alumno);
    
    boolean insertMatricula(int id_alumno, int id_horario, int id_curso);
    
    boolean deleteCursoNoSelect(int id_alumno, int id_horario, int id_curso);
}
