    package dao.impl;

import dao.MatriculaDAO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.HorarioMatricula;
import oracle.jdbc.OracleTypes;
import util.DatabaseConnection;

/**
 *
 * @author Soviet
 */
public class MatriculaDAOImpl implements MatriculaDAO{

    @Override
    public List<HorarioMatricula> loadHorarios(int id_alumno) {
        List<HorarioMatricula> horarios = new ArrayList<>();
        
        try{
        
        Connection conn = DatabaseConnection.getConnection();
        CallableStatement call = conn.prepareCall("{CALL ADIXON.LOAD_HORARIO_DIS(?,?)}");
        call.registerOutParameter(1, OracleTypes.CURSOR);
        call.setInt(2, id_alumno);
        call.execute();
        ResultSet rs = (ResultSet) call.getObject(1);
        
            
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
                    
                    horarios.add(new HorarioMatricula(id_horario, id_curso, nom_curso, ape_profe, nom_profe, nom_aula, nom_dia, hora_ini, hora_fin, capacidad, cupos));
               
            }
            
        } catch (SQLException e) {
            Logger.getLogger(AlumnoDAOImpl.class.getName()).log(Level.SEVERE, null, e);
        }
        
        return horarios;
    }
    
     @Override
     public  boolean insertMatricula(int id_alumno, int id_horario, int id_curso){
        boolean correct = true;
         
         try {
             String sql = "{CALL ADIXON.create_matricula_horario(?,?,?)}";
             Connection connection = DatabaseConnection.getConnection();
             CallableStatement call = connection.prepareCall(sql);
             call.setInt(1, id_alumno);
             call.setInt(2, id_horario);
             call.setInt(3, id_curso);
             call.executeUpdate();
             
         } catch (SQLException e) {
             System.out.println("El valor de id_alumno: "+id_alumno);
             System.out.println("El valor de horario: "+id_horario);
             System.out.println("El valor de id_curso: "+id_curso);
             System.out.println("Error bien berraco al insertar curso con lo que sea: "+e);
             return false;
         }
 
         return correct;
     }

    @Override
    public List<HorarioMatricula> loadHorariosM(int id_alumno) {
        List<HorarioMatricula> horarios = new ArrayList<>();
        
        try {
            Connection conn = DatabaseConnection.getConnection();
            CallableStatement call = conn.prepareCall("{CALL ADIXON.LOAD_HORARIO_SELECT(?,?)}");
            call.registerOutParameter(1,OracleTypes.CURSOR);
            call.setInt(2, id_alumno);
            call.execute();
            
            ResultSet rs = (ResultSet) call.getObject(1);
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
                
                horarios.add(new HorarioMatricula(id_horario, id_curso, nom_curso, ape_profe, nom_profe, nom_aula, nom_dia, hora_ini, hora_fin, capacidad, cupos));
               
            }
        } catch (SQLException e) {
            
        }
        return horarios;
    }

    @Override
    public boolean deleteCursoNoSelect(int id_alumno, int id_horario, int id_curso) {
        boolean correcto = true;
        
        try {
            
            Connection conn = DatabaseConnection.getConnection();
            CallableStatement call = conn.prepareCall("{CALL ADIXON.DELETE_MATRICULA_HORARIO(?,?,?)}");
            call.setInt(1, id_alumno);
            call.setInt(2, id_horario);
            call.setInt(3, id_curso);
            call.executeUpdate();
            
        } catch (SQLException e) {
            System.err.println("Error la eliminar cursos no seleccionados: "+e);
            correcto = false;
        }
        
        return correcto;
    }

    
     
     
   
}
