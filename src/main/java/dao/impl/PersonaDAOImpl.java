package dao.impl;

import dao.PersonaDAO;
import model.Persona;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PersonaDAOImpl implements PersonaDAO {

    @Override
    public List<Persona> listarPersonas() throws SQLException {
        List<Persona> personas = new ArrayList<>();
        String sql = "SELECT * FROM ADIXON.persona";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Persona persona = new Persona();
                persona.setIdPersona(rs.getInt(1));
                persona.setDni(rs.getString(2));
                persona.setApellidos(rs.getString(3));
                persona.setNombres(rs.getString(4));
                persona.setFechaNacimiento(rs.getString(5));
                persona.setTelefono(rs.getString(6));
                persona.setCorreo(rs.getString(7));
                persona.setDireccion(rs.getString(8));
                personas.add(persona);
            }
        }
        
        return personas;
    }

    @Override
    public Persona obtenerPorId(Integer id) throws SQLException {
        String sql = "SELECT id_persona, dni, apellidos, nombres, fecha_nacimiento, telefono, correo, direccion FROM personas WHERE id_persona = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Persona persona = new Persona();
                    persona.setIdPersona(rs.getInt("id_persona"));
                    persona.setDni(rs.getString("dni"));
                    persona.setApellidos(rs.getString("apellidos"));
                    persona.setNombres(rs.getString("nombres"));
                    persona.setFechaNacimiento(rs.getString("fecha_nacimiento"));
                    persona.setTelefono(rs.getString("telefono"));
                    persona.setCorreo(rs.getString("correo"));
                    persona.setDireccion(rs.getString("direccion"));
                    return persona;
                }
            }
        }
        
        return null;
    }

    @Override
    public Integer insertar(Persona persona) throws SQLException {
        String sql = "INSERT INTO personas (dni, apellidos, nombres, fecha_nacimiento, telefono, correo, direccion) VALUES (?, ?, ?, ?, ?, ?, ?) RETURNING id_persona";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, persona.getDni());
            stmt.setString(2, persona.getApellidos());
            stmt.setString(3, persona.getNombres());
            //stmt.setDate(4, new java.sql.Date(persona.getFechaNacimiento().getTime()));
            stmt.setString(5, persona.getTelefono());
            stmt.setString(6, persona.getCorreo());
            stmt.setString(7, persona.getDireccion());
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        
        return null;
    }

    @Override
    public boolean actualizar(Persona persona) throws SQLException {
        String sql = "UPDATE personas SET dni = ?, apellidos = ?, nombres = ?, fecha_nacimiento = ?, telefono = ?, correo = ?, direccion = ? WHERE id_persona = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, persona.getDni());
            stmt.setString(2, persona.getApellidos());
            stmt.setString(3, persona.getNombres());
            //stmt.setDate(4, new java.sql.Date(persona.getFechaNacimiento().getTime()));
            stmt.setString(5, persona.getTelefono());
            stmt.setString(6, persona.getCorreo());
            stmt.setString(7, persona.getDireccion());
            stmt.setInt(8, persona.getIdPersona());
            
            return stmt.executeUpdate() > 0;
        }
    }

    @Override
    public boolean eliminar(Integer id) throws SQLException {
        String sql = "DELETE FROM personas WHERE id_persona = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            return stmt.executeUpdate() > 0;
        }
    }
}