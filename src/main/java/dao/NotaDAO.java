package dao;

import java.util.List;
import model.Nota;

/**
 *
 * @author Soviet
 */
public interface NotaDAO {
    List<Nota> loadNotas(int id_alumno);
}
