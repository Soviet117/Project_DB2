package controller;

import dao.PersonaDAO;
import dao.impl.PersonaDAOImpl;
import model.Persona;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Date;

@WebServlet(name = "PersonaController", urlPatterns = {"/personas"})
public class PersonaController extends HttpServlet {
    private PersonaDAO personaDAO;
    private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    
    @Override
    public void init() throws ServletException {
        super.init();
        personaDAO = new PersonaDAOImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        //  coje lo que viene despues del /personas/ pa ver que accion ejecuta
        String pathInfo = request.getPathInfo();
        String action = pathInfo == null ? "listar" : pathInfo.substring(1);
        
        try {
            switch (action) {
                case "listar":
                    listarPersonas(request, response);
                    break;
                case "nuevo":
                    mostrarFormularioNuevo(request, response);
                    break;
                case "editar":
                    mostrarFormularioEditar(request, response);
                    break;
                case "ver":
                    verPersona(request, response);
                    break;
                default:
                    listarPersonas(request, response);
            }
        } catch (SQLException e) {
            System.err.println("Error de SQL: " + e.getMessage());
            request.setAttribute("error", "Error de base de datos: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "crear":
                    crearPersona(request, response);
                    break;
                case "actualizar":
                    actualizarPersona(request, response);
                    break;
                case "eliminar":
                    eliminarPersona(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/personas");
            }
        } catch (SQLException | ParseException e) {
            System.err.println("Error en operación: " + e.getMessage());
            request.setAttribute("error", "Error en la operación: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }
    
    private void listarPersonas(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        
        List<Persona> personas = personaDAO.listarPersonas();
        request.setAttribute("personas", personas);
        request.getRequestDispatcher("/WEB-INF/views/persona/listar.jsp").forward(request, response);
    }
    
    private void mostrarFormularioNuevo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.getRequestDispatcher("/WEB-INF/views/persona/formulario.jsp").forward(request, response);
    }
    
    private void mostrarFormularioEditar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        Persona persona = personaDAO.obtenerPorId(id);
        
        if (persona == null) {
            request.setAttribute("error", "Persona no encontrada");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        } else {
            request.setAttribute("persona", persona);
            request.getRequestDispatcher("/WEB-INF/views/persona/formulario.jsp").forward(request, response);
        }
    }
    
    private void verPersona(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        Persona persona = personaDAO.obtenerPorId(id);
        
        if (persona == null) {
            request.setAttribute("error", "Persona no encontrada");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        } else {
            request.setAttribute("persona", persona);
            request.getRequestDispatcher("/WEB-INF/views/persona/detalle.jsp").forward(request, response);
        }
    }
    
    private void crearPersona(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ParseException {
        
        Persona persona = new Persona();
        persona.setDni(request.getParameter("dni"));
        persona.setApellidos(request.getParameter("apellidos"));
        persona.setNombres(request.getParameter("nombres"));
        
        String fechaStr = request.getParameter("fechaNacimiento");
Date fecha = dateFormat.parse(fechaStr);
// Convertir Date a String
persona.setFechaNacimiento(dateFormat.format(fecha));
        
        persona.setTelefono(request.getParameter("telefono"));
        persona.setCorreo(request.getParameter("correo"));
        persona.setDireccion(request.getParameter("direccion"));
        
        Integer id = personaDAO.insertar(persona);
        
        if (id != null) {
            response.sendRedirect(request.getContextPath() + "/personas");
        } else {
            request.setAttribute("error", "No se pudo crear la persona");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }
    
    private void actualizarPersona(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ParseException {
        
        int id = Integer.parseInt(request.getParameter("idPersona"));
        
        Persona persona = new Persona();
        persona.setIdPersona(id);
        persona.setDni(request.getParameter("dni"));
        persona.setApellidos(request.getParameter("apellidos"));
        persona.setNombres(request.getParameter("nombres"));
        
        // En el método actualizarPersona:
        String fechaStr = request.getParameter("fechaNacimiento");
        Date fecha = dateFormat.parse(fechaStr);
        // Convertir Date a String
        persona.setFechaNacimiento(dateFormat.format(fecha)); 
        
        persona.setTelefono(request.getParameter("telefono"));
        persona.setCorreo(request.getParameter("correo"));
        persona.setDireccion(request.getParameter("direccion"));
        
        boolean actualizado = personaDAO.actualizar(persona);
        
        if (actualizado) {
            response.sendRedirect(request.getContextPath() + "/personas");
        } else {
            request.setAttribute("error", "No se pudo actualizar la persona");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }
    
    private void eliminarPersona(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        boolean eliminado = personaDAO.eliminar(id);
        
        if (eliminado) {
            response.sendRedirect(request.getContextPath() + "/personas");
        } else {
            request.setAttribute("error", "No se pudo eliminar la persona");
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }
}