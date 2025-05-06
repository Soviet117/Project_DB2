package dao.impl;

import dao.MatriculaDAO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Horario;
import util.DatabaseConnection;

/**
 *
 * @author Soviet
 */
public class MatriculaDAOImpl implements MatriculaDAO{

    @Override
    public List<Horario> loadHorarios(int id_ciclo, int id_carrera) {
        List<Horario> horarios = new ArrayList<>();
        
        
        
        
        String sql = "SELECT * FROM ADIXON.view_horario_dispo "
                    + "WHERE id_ciclo = "+id_ciclo+" AND id_carrera = 1 OR id_carrera = "+id_carrera;
        try (Connection connection = DatabaseConnection.getConnection();
                PreparedStatement stmt = connection.prepareCall(sql);
                ResultSet rs = stmt.executeQuery()){ 
            
            while (rs.next()) {
                    int id_horario = rs.getInt(1);
                    int id_curso = rs.getInt(2);
                    String nom_curso = rs.getString(3);
                    String ape_profe = rs.getString(6);
                    String nom_profe = rs.getString(7);
                    String nom_aula = rs.getString(8);
                    String nom_dia = rs.getString(9);
                    String hora_ini = rs.getString(10);
                    String hora_fin = rs.getString(11);
                    int capacidad = rs.getInt(12);
                    int cupos = rs.getInt(13);
                    
                    horarios.add(new Horario(id_horario, id_curso, nom_curso, ape_profe, nom_profe, nom_aula, nom_dia, hora_ini, hora_fin, capacidad, cupos));
               
            }
            
        } catch (SQLException e) {
            Logger.getLogger(AlumnoDAOImpl.class.getName()).log(Level.SEVERE, null, e);
        }
        
        return horarios;
    }
    
     @Override
     public void insertMatricula(int id_alumno, int id_horario, String fecha_matri, String estado){
         boolean correct = true;
         
         
     }
    
   
}
