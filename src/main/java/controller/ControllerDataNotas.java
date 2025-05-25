package controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import dao.impl.NotaDAOImpl;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Nota;
import dao.NotaDAO;

/**
 *
 * @author Soviet
 */
@WebServlet(name = "ControllerDataNotas", urlPatterns = "/controllerDataNotas/*")
public class ControllerDataNotas extends HttpServlet {
    
    private NotaDAO notasDAO;
    List<Nota> notas;
    
    public void init(ServletConfig config) throws ServletException {
        notasDAO = new NotaDAOImpl();
    }
    
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
        String path = req.getPathInfo();
        
        switch (path) {
            case "/loadNotas":
                loadNotas(req, resp);
                break;
            default:
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                resp.getWriter().write("{\"error\": \"Endpoint no encontrado\"}");
        }
    }
    
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
    }
    
    protected int loadId(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        HttpSession session = req.getSession(false);
        
        if (session == null) {
            System.out.println("Sesión es null - redireccionando al login");
            handleSessionExpired(resp, "no_session");
            return -1;
        }
        Integer idAlumno = (Integer) session.getAttribute("id_alumno");
        if (idAlumno == null) {
            System.out.println("ID alumno es null en la sesión - redireccionando al login");
            handleSessionExpired(resp, "no_user_id");
            return -1;
        }
        
       
        try {
            long currentTime = System.currentTimeMillis();
            long lastAccessTime = session.getLastAccessedTime();
            int maxInactiveInterval = session.getMaxInactiveInterval();
            
            if ((currentTime - lastAccessTime) > (maxInactiveInterval * 1000)) {
                System.out.println("Sesión expirada manualmente detectada");
                session.invalidate();
                handleSessionExpired(resp, "session_expired");
                return -1;
            }
            
        } catch (IllegalStateException e) {
            System.out.println("Sesión ya invalidada: " + e.getMessage());
            handleSessionExpired(resp, "session_invalidated");
            return -1;
        }
        
        System.out.println("Sesión válida - ID alumno: " + idAlumno);
        System.out.println("Última vez accedida: " + new java.util.Date(session.getLastAccessedTime()));
        System.out.println("Tiempo máximo inactivo: " + session.getMaxInactiveInterval() + " segundos");
        
        return idAlumno;
    }
    
    private void handleSessionExpired( HttpServletResponse resp, String reason) throws IOException {
        
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("error", reason);
            errorResponse.put("message", "Su sesión ha expirado. Será redireccionado al login.");
            
            ObjectMapper mapper = new ObjectMapper();
            resp.getWriter().write(mapper.writeValueAsString(errorResponse));
    }
    
    protected void loadNotas(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
       
        int idAlumno = loadId(req, resp);
        
       
        if (idAlumno == -1) {
            return; 
        }
        
        notas = notasDAO.loadNotas(idAlumno);
        List<Map<String, Object>> notasJSON = new ArrayList<>();
        System.out.println("Notas jaladas: " + notas);
        
        for (Nota n : notas) {
            Map<String, Object> nJSON = new HashMap<>();
            nJSON.put("id_nota", n.getId_nota());
            nJSON.put("codigo", n.getCodigo());
            nJSON.put("nombre", n.getNombre());
            nJSON.put("creditos", n.getCredito());
            nJSON.put("p1", n.getP1());
            nJSON.put("p2", n.getP2());
            nJSON.put("p3", n.getP3());
            nJSON.put("p4", n.getP4());
            nJSON.put("c1", n.getC1());
            nJSON.put("c2", n.getC2());
            nJSON.put("c3", n.getC3());
            nJSON.put("c4", n.getC4());
            nJSON.put("c5", n.getC5());
            nJSON.put("c6", n.getC6());
            nJSON.put("continuas", n.getContinuas());
            nJSON.put("total", n.getTotal());
            
            notasJSON.add(nJSON);
        }
        
        ObjectMapper mapper = new ObjectMapper();
        resp.getWriter().write(mapper.writeValueAsString(notasJSON));
    }
}