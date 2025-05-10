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
    
    private int id_alumno = 1;
    
    
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
        // <editor-fold defaultstate="collapsed" desc="Compiled Code">
        /* 0: aload_1
         * 1: invokeinterface #8,  1            // InterfaceMethod jakarta/servlet/http/HttpServletRequest.getProtocol:()Ljava/lang/String;
         * 6: astore_3
         * 7: getstatic     #9                  // Field lStrings:Ljava/util/ResourceBundle;
         * 10: ldc           #20                 // String http.method_post_not_supported
         * 12: invokevirtual #11                 // Method java/util/ResourceBundle.getString:(Ljava/lang/String;)Ljava/lang/String;
         * 15: astore        4
         * 17: aload_2
         * 18: aload_0
         * 19: aload_3
         * 20: invokevirtual #12                 // Method getMethodNotSupportedCode:(Ljava/lang/String;)I
         * 23: aload         4
         * 25: invokeinterface #13,  3           // InterfaceMethod jakarta/servlet/http/HttpServletResponse.sendError:(ILjava/lang/String;)V
         * 30: return
         *  */
        // </editor-fold>
    }
     
    protected void loadHorario(HttpServletRequest req, HttpServletResponse resp) throws IOException{
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
        horarios = horarioDAO.loadHorarios(id_alumno);

        
        List<Map<String, Object>> ListHorariosJSON = new ArrayList<>();
        
        for(Horario h: horarios){
            Map<String, Object> horarioJSON = new HashMap<>();
            
            horarioJSON.put("id_horario",h.getId_horario());
            horarioJSON.put("id_hora",h.getId_hora());
            horarioJSON.put("id_dia",h.getId_dia());
            horarioJSON.put("nom_aula", h.getNom_aula());
            horarioJSON.put("id_curso",h.getId_curso());
            horarioJSON.put("nom_curso", h.getNom_curso());
            horarioJSON.put("codigo", h.getCodigo());
            
            ListHorariosJSON.add(horarioJSON);
            
        }
        
        ObjectMapper mapper = new ObjectMapper();
        resp.getWriter().write(mapper.writeValueAsString(ListHorariosJSON));
        
        System.out.println("Aqui estan los cursos en JSON: "+ListHorariosJSON);
        System.out.println("Aqui estan los cursos en DTOs: "+horarios);
    }
    
}
