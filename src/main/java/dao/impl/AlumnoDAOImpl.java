package dao.impl;

import controller.ControllerDataMatricula;
import dao.AlumnoDAO;
import jakarta.servlet.ServletException;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Alumno;
import oracle.jdbc.OracleTypes;
import util.DatabaseConnection;

/**
 *
 * @author  Soviet
 */
public class AlumnoDAOImpl implements AlumnoDAO{
    private ControllerDataMatricula context;
   
    public AlumnoDAOImpl(ControllerDataMatricula context){
        this.context = context;
    }

    @Override
    public List<Alumno> loadAlumnos() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Alumno loadAlumno(int id_alumno) {
        Alumno alumno = new Alumno();
            
        //esto tinee que ser con callanleStatement con PA
                
        try  {
            
            Connection conn = DatabaseConnection.getConnection();
            CallableStatement call = conn.prepareCall("{CALL ADIXON.LOAD_ALUMNOS(?,?)}");
            call.registerOutParameter(1, OracleTypes.CURSOR);
            call.setInt(2, id_alumno);
            call.execute();
            ResultSet rs = (ResultSet) call.getObject(1);
            
            while (rs.next()) {
                
                alumno.setId_alumno(id_alumno);
                alumno.setId_persona(rs.getInt(2));
                alumno.setCodigo(rs.getString(3));
                alumno.setDni(rs.getString(4));
                alumno.setApellidos(rs.getString(5));
                alumno.setNombres(rs.getString(6));
                alumno.setFecha_n(rs.getDate(7));
                alumno.setNumeroT(rs.getString(8));
                alumno.setCorreo(rs.getString(9));
                alumno.setDireccion(rs.getString(10));
                alumno.setFecha_ingre(rs.getString(11));
                alumno.setPassword(rs.getString(12));
                alumno.setEstado(rs.getString(13));
                alumno.setId_ciclo(rs.getInt(14));
                alumno.setId_carrera(rs.getInt(15));
                
            }
        } catch (SQLException ex) {
            
            
            Logger.getLogger(AlumnoDAOImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return alumno;
    }

    @Override
    public boolean updateAlumno(int id_alumno, String dni, String nombres, String apellidos, Date fecha_n, String celular, String correo, String direccion) {
        boolean correct = true;
         
        try {
            String sql = "{ CALL ADIXON.PA_UPDATE_PERSONA_INFO(?,?,?,?,?,?,?,?)}";
            Connection connection = DatabaseConnection.getConnection();
            CallableStatement call = connection.prepareCall(sql);
            
            call.setInt(1, id_alumno);
            call.setString(2, dni);
            call.setString(3, apellidos);
            call.setString(4, nombres);
            call.setDate(5, (java.sql.Date) fecha_n);
            call.setString(6, celular);
            call.setString(7, correo);
            call.setString(8, direccion);
           
            
            call.executeUpdate();
            correct = true;
            
            
        } catch (SQLException e) {
            correct =  false;
        
        }
       return correct;
    }
    
}
