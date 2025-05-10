package controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import dao.AlumnoDAO;
import dao.MatriculaDAO;
import dao.impl.AlumnoDAOImpl;
import dao.impl.MatriculaDAOImpl;
import jakarta.json.Json;
import jakarta.json.JsonArray;
import jakarta.json.JsonNumber;
import jakarta.json.JsonObject;
import jakarta.json.JsonReader;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Alumno;
import model.HorarioMatricula;

/**
 *
 * @author Soviet
 */

@WebServlet(name = "ControllerDataMatricula",urlPatterns = {"/controllerDataMatricula/*","/controllerDataMatricularse/*"})
public class ControllerDataMatricula extends HttpServlet{
    private AlumnoDAO alumnoDAO;
    private MatriculaDAO matriculaDAO;
    private int id_alumno = 1;
    private int id_persona = -1;
    private Alumno alumno;
    
    private HttpServletRequest reqX;
    private HttpServletResponse resX;
     
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init();
        alumnoDAO = new AlumnoDAOImpl(this);
        matriculaDAO = new MatriculaDAOImpl();
        
        alumno = alumnoDAO.loadAlumno(id_alumno);
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
        String path = req.getPathInfo();
        
        switch (path) {
            case "/sendAlumno":
                sendAlumno(req,resp);
                break;
            case "/confirmEstado":
                confirmEstado(req,resp);
                break;
            case "/viewHorariosM":
                viewHorarioM(req,resp);
                break;
                
            default:
                throw new AssertionError();
        }
            
        }
        
        
    
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        
        switch (path) {
            case "/sendAlumno":
                updateDataAlumno(req,resp);
                break;
            case "/matricular":
                matricularAlumno(req,resp);
                break;
                
            default:
                xd();
                break;
                
        }
    }
    
    private void xd(){
        System.out.println("Estanendtrando a default");
    }
    
    protected void matricularAlumno(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        StringBuilder sb = new StringBuilder();
        String line;
        try (BufferedReader reader = req.getReader()) {
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }

        String jsonData = sb.toString();
        
        boolean correcto = false;

        try (JsonReader jsonReader = Json.createReader(new java.io.StringReader(jsonData))) {
            JsonObject jsonObject = jsonReader.readObject();
            JsonArray cursosJsonArray = jsonObject.getJsonArray("cursosIds");

            List<Integer> listaCursosIds = new ArrayList<>();
            for (int i = 0; i < cursosJsonArray.size(); i++) {
                // Maneja tanto valores numéricos como strings
                if (cursosJsonArray.get(i) instanceof JsonNumber) {
                    listaCursosIds.add(cursosJsonArray.getJsonNumber(i).intValue());
                } else {
                    //Aqui se ejecuta toda la logica correcta
                    listaCursosIds.add(Integer.parseInt(cursosJsonArray.getString(i)));
                    correcto = matriculaDAO.insertMatricula(1, listaCursosIds.get(i));
                    
                }
            }
            
            if(correcto == true){
                JsonObject responseJson = Json.createObjectBuilder()
                        .add("success", true)
                        .add("message", "Matricula ejecutada correctamente.")
                        .build();
                      

                resp.getWriter().write(responseJson.toString());
            
            }

            System.out.println("Lista de cursos select id: " + listaCursosIds);




        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write(Json.createObjectBuilder().add("error", "Error al leer los datos de la petición: " + e.getMessage()).build().toString());
            e.printStackTrace();
        }
}
    
    protected void updateDataAlumno(HttpServletRequest req, HttpServletResponse resp) throws IOException{
        try {

            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            
            reqX = req;
            resX = resp;
            
            String dni = req.getParameter("dniN");
            String nombre = req.getParameter("nombreN");
            String apellido = req.getParameter("apellidoN");
            String fechaStr = req.getParameter("fechanN");
            Date fechaN = java.sql.Date.valueOf(fechaStr);
            String celular = req.getParameter("numerotN");
            String correo = req.getParameter("correoN");
            String direccion = req.getParameter("direccionN");
            
            boolean actualizado = false;
            try {
                actualizado = alumnoDAO.updateAlumno(id_persona, dni, nombre, apellido, fechaN, celular, correo, direccion);
            } catch (Exception e) {
                enviarRespuestaError(resp, "Error en la actualización: " + e.getMessage());
                return;
            }

            Map<String, String> respuesta = new HashMap<>();
            if (actualizado) {
                //a enviar solo los datos actualizados
                respuesta.put("status", "success");
                respuesta.put("mensaje", "Datos actualizados correctamente");
            } else {
                respuesta.put("status", "error");
                respuesta.put("mensaje", "Error al actualizar los datos");
            }
                
            System.out.println("Ester es el estado del alummo que cargue: "+alumno.getEstado());
            
            ObjectMapper mapper = new ObjectMapper();
            resp.getWriter().write(mapper.writeValueAsString(respuesta));

        } catch (Exception e) {
            enviarRespuestaError(resp, "Error interno del servidor: " + e.getMessage());
        }
    }
    
    protected void sendAlumno(HttpServletRequest req,HttpServletResponse resp) throws IOException{
            try {
                Alumno alumno = alumnoDAO.loadAlumno(1);
                id_alumno = alumno.getId_alumno();
                id_persona = alumno.getId_persona();

                if (alumno == null) {

                    enviarRespuestaError(resp, "Error: alumno no encontrado");
                } else {
                    //todo correccto sldkgnsgnsoringofnvk

                    Map<String, String> alumnoJSON = new HashMap<>();

                    alumnoJSON.put("id_persona", String.valueOf(alumno.getId_persona()));
                    alumnoJSON.put("codido", alumno.getCodigo());
                    alumnoJSON.put("dni", alumno.getDni());
                    alumnoJSON.put("nombres",alumno.getNombres());
                    alumnoJSON.put("apellidos", alumno.getApellidos());
                    alumnoJSON.put("fecha_n", String.valueOf(alumno.getFecha_n()));
                    alumnoJSON.put("numeroT",alumno.getNumeroT());
                    alumnoJSON.put("correo", alumno.getCorreo());
                    alumnoJSON.put("direccion", alumno.getDireccion());
                    alumnoJSON.put("estado", alumno.getEstado());

                    ObjectMapper mapper = new ObjectMapper();
                    resp.getWriter().write(mapper.writeValueAsString(alumnoJSON));
            }
        } catch (Exception e) {
            
            enviarRespuestaError(resp, "Error al cargar datos: " + e.getMessage());
        }
         
    }
    
    protected void confirmEstado(HttpServletRequest req, HttpServletResponse resp) throws IOException{
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
        alumno = alumnoDAO.loadAlumno(1);
        
        String estado = alumno.getEstado();
        
        Map<String, String> mensajeJSON = new HashMap<>();
        
        if(estado.equals("ACTUALIZADO")){
            mensajeJSON.put("status", "ACTUALIZADO");
        }else if(estado.equals("DESACTUALIZADO")){
            mensajeJSON.put("status", "DESACTUALIZADO");
            mensajeJSON.put("mensaje","Por favor actualice los datos antes de continuar");
        }
        
        ObjectMapper objectM = new ObjectMapper();
        resp.getWriter().write(objectM.writeValueAsString(mensajeJSON));
    }
    
    protected void viewHorarioM(HttpServletRequest req, HttpServletResponse resp) throws IOException{
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        List<HorarioMatricula> horarios = matriculaDAO.loadHorarios(id_alumno, alumno.getId_carrera());

      
        List<Map<String, String>> horariosJSONList = new ArrayList<>();
        System.out.println("Horarios: " + horarios);

        for(HorarioMatricula h: horarios) {
            Map<String, String> horarioJSON = new HashMap<>();
            horarioJSON.put("id_horario", String.valueOf(h.getId_horario()));
            horarioJSON.put("id_curso", String.valueOf(h.getId_curso()));
            horarioJSON.put("nombreC", h.getNombreC());
            horarioJSON.put("profesor", h.getApellidos() + ", " + h.getNombres());
            horarioJSON.put("aula", h.getAula());
            horarioJSON.put("diaH", h.getDia()+": "+h.getHinicio()+" - "+h.getHfin());
            horarioJSON.put("capacidad", String.valueOf(h.getCapacidad()));
            horarioJSON.put("cupos", String.valueOf(h.getCupos()));

          
            horariosJSONList.add(horarioJSON);
        }

        ObjectMapper mapper = new ObjectMapper();
        resp.getWriter().write(mapper.writeValueAsString(horariosJSONList));
    }

    protected void enviarRespuestaError(HttpServletResponse resp, String mensaje) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        Map<String, String> error = new HashMap<>();
        error.put("status", "error");
        error.put("mensaje", mensaje);

        ObjectMapper mapper = new ObjectMapper();
        resp.getWriter().write(mapper.writeValueAsString(error));
    }
}