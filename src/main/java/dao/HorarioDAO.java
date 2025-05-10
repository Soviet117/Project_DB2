package dao;

import java.util.List;
import model.Horario;

/**
 *
 * @author Soviet
 */
public interface HorarioDAO {
    List<Horario> loadHorarios(int id_alumno);
}
