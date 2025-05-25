package dao.impl;

import dao.Alumno_LoginDAO;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Alumno_Login;
import oracle.jdbc.OracleTypes;
import util.DatabaseConnection;

/**
 *
 * @author Soviet
 */
public class Alumno_LoginDAOImpl implements Alumno_LoginDAO{

    @Override
    public List<Alumno_Login> loadAL() {
        List<Alumno_Login> usuarios = new ArrayList<>();
        
        try {
            Connection conn = DatabaseConnection.getConnection();
            CallableStatement call = conn.prepareCall("{CALL ADIXON.LOAD_USUARIOS(?)}");
            call.registerOutParameter(1, OracleTypes.CURSOR);
            call.execute();
            ResultSet rs = (ResultSet) call.getObject(1);
            
            while (rs.next()) {                
                int id_alumno = rs.getInt(1);
                int codigo = rs.getInt(2);
                String password = rs.getString(3);
                usuarios.add(new Alumno_Login(id_alumno, codigo, password));
            }
            return usuarios;            
        } catch (SQLException e) {
        }
        
        return usuarios;
    }
    
    
    
}
