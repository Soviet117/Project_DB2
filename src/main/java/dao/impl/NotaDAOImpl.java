package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Nota;
import util.DatabaseConnection;
import dao.NotaDAO; 
import java.sql.CallableStatement;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author Soviet
 */
public class NotaDAOImpl implements NotaDAO{

    @Override
    public List<Nota> loadNotas(int id_alumno) {
        List<Nota> notas = new ArrayList<>();
        
        try {
            String sql = "{CALL ADIXON.LOAD_NOTAS(?,?)}";
            Connection connection = DatabaseConnection.getConnection();
            CallableStatement call = connection.prepareCall(sql);
            call.registerOutParameter(1, OracleTypes.CURSOR);
            call.setInt(2,id_alumno);
            call.execute();
            ResultSet rs = (ResultSet) call.getObject(1);
            
            while (rs.next()) {                
                int id_nota = rs.getInt(1);
                String codigo = rs.getString(3);
                String nombre = rs.getString(4);
                int creditos = rs.getInt(5);
                double p1 = rs.getDouble(6);
                double p2 = rs.getDouble(7);
                double p3 = rs.getDouble(8);
                double p4 = rs.getDouble(9);
                double c1 = rs.getDouble(10);
                double c2 = rs.getDouble(11);
                double c3 = rs.getDouble(12);
                double c4 = rs.getDouble(13);
                double c5 = rs.getDouble(14);
                double c6 = rs.getDouble(15);
                double continuas = rs.getDouble(16);
                double total = rs.getDouble(17);
                
                notas.add(new Nota(id_nota,codigo, nombre, creditos, p1, p2, p3, p4, 
                                    c1, c2, c3, c4, c5, c6,continuas,total));
                
            }
            
        } catch (SQLException e) {
            Logger.getLogger(AlumnoDAOImpl.class.getName()).log(Level.SEVERE, null, e);
            System.out.println("Error al ejecutar al consulta Implemente en notas: "+e);
        }
        
        return notas;
    }
    
}
