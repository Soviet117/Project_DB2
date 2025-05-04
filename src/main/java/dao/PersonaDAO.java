package dao;

import model.Persona;
import java.sql.SQLException;
import java.util.List;

public interface PersonaDAO {
 
    List<Persona> listarPersonas() throws SQLException;
   
    Persona obtenerPorId(Integer id) throws SQLException;
  
    Integer insertar(Persona persona) throws SQLException;
    
    boolean actualizar(Persona persona) throws SQLException;
 
    boolean eliminar(Integer id) throws SQLException;
}