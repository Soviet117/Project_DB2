package controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import dao.HorarioDAO;
import dao.impl.HorarioDAOImpl;
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
import model.Horario;

/**
 *
 * @author Soviet
 */
@WebServlet(name="ControllerDataHorario", urlPatterns = "/controllerDataHorario/*" )
public class ControllerDataHorario extends HttpServlet{
    private HorarioDAO horarioDAO;
    private List<Horario> horarios;
    
    public void init(ServletConfig config) throws ServletException {
        super.init();
        horarioDAO = new HorarioDAOImpl();
    }
    
     protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
        String path = req.getPathInfo();
        
        switch (path) {
            case "/verHorario":
               loadHorario(req, resp);
               break;
            default:
                throw new AssertionError();
        }
        
    }
     
     protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
    }
     
    protected void loadHorario(HttpServletRequest req, HttpServletResponse resp) throws IOException{
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
        horarios = horarioDAO.loadHorarios(loadId(req, resp));

        
        List<Map<String, String>> ListHorariosJSON = new ArrayList<>();
        
        for(Horario h: horarios){
            Map<String, String> horarioJSON = new HashMap<>();
            
            horarioJSON.put("id_horario",String.valueOf(h.getId_horario()));
            horarioJSON.put("id_hora",String.valueOf(h.getId_hora()));
            horarioJSON.put("id_dia",String.valueOf(h.getId_dia()));
            horarioJSON.put("nom_aula", h.getNom_aula());
            horarioJSON.put("id_curso",String.valueOf(h.getId_curso()));
            horarioJSON.put("nom_curso", h.getNom_curso());
            horarioJSON.put("codigo", h.getCodigo());
            
            ListHorariosJSON.add(horarioJSON);
            
        }
        
        ObjectMapper mapper = new ObjectMapper();
        resp.getWriter().write(mapper.writeValueAsString(ListHorariosJSON));
        
        System.out.println("Aqui estan los cursos en JSON: "+ListHorariosJSON);
        System.out.println("Aqui estan los cursos en DTOs: "+horarios);
    }
    
    protected int loadId(HttpServletRequest req, HttpServletResponse resp) throws IOException{
        
        HttpSession session = req.getSession();
        
        if(session == null){
            System.out.println("La berraca session es null, me corto un huevo");
            sendSessionExpired(resp, "La session a expirado");
            return -1;
        }
        
        Integer id_A = (Integer)session.getAttribute("id_alumno");
        if(id_A == null){
            System.out.println("El berraco ID es null, me corto un huevo");
            sendSessionExpired(resp, "La session a expirado");
            return -1;
        }
        System.out.println("El id alumno es, desde horario: "+id_A);
        
        try {
            long currentTime = System.currentTimeMillis();
            long lastAccessTime = session.getLastAccessedTime();
            int maxInactiveInterval = session.getMaxInactiveInterval();
            
            if ((currentTime - lastAccessTime) > (maxInactiveInterval * 1000)) {
                System.out.println("Sesión expirada manualmente detectada");
                session.invalidate();
                sendSessionExpired(resp, "session_expired");
                return -1;
            }            
        } catch (IllegalStateException e) {
            System.out.println("Sesión ya invalidada: " + e.getMessage());
            sendSessionExpired(resp, "session_invalidated");
            return -1;
        }
        
        return id_A;
    }
    
    protected void sendSessionExpired(HttpServletResponse resp, String err) throws IOException{
        resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        
        Map<String, String> JSON = new HashMap<>();
        JSON.put("error", err);
        JSON.put("message","No se pudo cargar correctamente el ID");
        
        ObjectMapper mapper = new ObjectMapper();
        resp.getWriter().write(mapper.writeValueAsString(JSON));
    }
    
}
