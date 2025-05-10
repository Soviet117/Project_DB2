package dao.impl;

import dao.HorarioDAO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Horario;
import model.HorarioMatricula;
import util.DatabaseConnection;

/**
 *
 * @author Soviet
 */
public class HorarioDAOImpl implements HorarioDAO{

    @Override
    public List<Horario> loadHorarios(int id_alumno) {
        List<Horario> horarios = new ArrayList<>();
        
        
        
        
        String sql = "SELECT * FROM ADIXON.view_horario WHERE id_alumno = "+id_alumno;
        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement stmt = connection.prepareCall(sql);
                ResultSet rs = stmt.executeQuery()){ 
            
            while (rs.next()) {
                    int id_horario = rs.getInt(1);
                    int id_hora = rs.getInt(3);
                    int id_dia = rs.getInt(4);
                    String nom_aula = rs.getString(5);
                    int curso = rs.getInt(6);
                    String nom_curso = rs.getString(7);
                    String codigo = rs.getString(8);
                    
                    horarios.add(new Horario(id_horario, id_hora, id_dia, nom_aula, curso, nom_curso, codigo));
               
            }
            
        } catch (SQLException e) {
            Logger.getLogger(AlumnoDAOImpl.class.getName()).log(Level.SEVERE, null, e);
        }
        
        return horarios;
    }
    
}
