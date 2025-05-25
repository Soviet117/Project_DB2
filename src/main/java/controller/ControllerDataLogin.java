package controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import dao.Alumno_LoginDAO;
import dao.impl.Alumno_LoginDAOImpl;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Alumno_Login;

/**
 *
 * @author Soviet
 */
@WebServlet(name = "ControllerDataLogin", urlPatterns = "/controllerDataLogin/*")
public class ControllerDataLogin extends HttpServlet {
    private Alumno_LoginDAO loginDAO = new Alumno_LoginDAOImpl();
    
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        
        if (path != null) {
            switch (path) {
                case "/alumno":
                    verificarAlumno(req, resp);
                    break;
                default:
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                    break;
            }
        }
    }
    
    protected void verificarAlumno(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
        String usuario = req.getParameter("usuariox");
        String password = req.getParameter("passwordx");
        
        System.out.println("Intento de login - Usuario: " + usuario);
        
        List<Alumno_Login> usuarios = loginDAO.loadAL();
        
        Map<String, Object> responseJson = new HashMap<>();
        
        try {
            int usuarioInt = Integer.parseInt(usuario);
            boolean loginExitoso = false;
            int idAlumnoEncontrado = -1;
            
            
            for (Alumno_Login x : usuarios) {
                if (x.getUsuario() == usuarioInt && x.getPassword().equals(password)) {
                    loginExitoso = true;
                    idAlumnoEncontrado = x.getId_alumno();
                    break;
                }
            }
            
            if (loginExitoso) {
                
                HttpSession session = req.getSession(true);
                
                session.setAttribute("id_alumno", idAlumnoEncontrado);
                
                session.setMaxInactiveInterval(1 * 60);
                
                System.out.println("Login exitoso - ID Alumno: " + idAlumnoEncontrado + 
                                 ", Session ID: " + session.getId());
                
              
                responseJson.put("success", true);
                responseJson.put("message", "Login exitoso");
                responseJson.put("id_alumno", idAlumnoEncontrado);
              
                
            } else {
                System.out.println("Login fallido - Credenciales incorrectas");
                                
                responseJson.put("success", false);
                responseJson.put("message", "Usuario o contraseña incorrectos");
                responseJson.put("id_alumno", -1);
            }
            
        } catch (NumberFormatException e) {
            System.err.println("Error al parsear usuario: " + e.getMessage());
            responseJson.put("success", false);
            responseJson.put("message", "Formato de usuario inválido");
            responseJson.put("id_alumno", -1);
        }
        
        ObjectMapper mapper = new ObjectMapper();
        resp.getWriter().write(mapper.writeValueAsString(responseJson));
    }
    
    
    
    
   
    
}