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
import jakarta.servlet.http.HttpSession;
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
@WebServlet(name = "ControllerDataMatricula", urlPatterns = {"/controllerDataMatricula/*", "/controllerDataMatricularse/*"})
public class ControllerDataMatricula extends HttpServlet {
    private AlumnoDAO alumnoDAO;
    private MatriculaDAO matriculaDAO;
  
    private Alumno alumno;
    
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        alumnoDAO = new AlumnoDAOImpl(this);
        matriculaDAO = new MatriculaDAOImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        if (!verificarSesion(req, resp)) {
            return;
        }
        
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
        String path = req.getPathInfo();
        
        if (path != null) {
            switch (path) {
                case "/sendAlumno":
                    sendAlumno(req, resp);
                    break;
                case "/confirmEstado":
                    confirmEstado(req, resp);
                    break;
                case "/viewHorarios":
                    viewHorario(req, resp);
                    break;
                case "/viewHorariosM":
                    viewHorarioM(req, resp);
                    break;
                default:
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                    break;
            }
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!verificarSesion(req, resp)) {
            return;
        }
        
        String path = req.getPathInfo();
        
        if (path != null) {
            switch (path) {
                case "/sendAlumno":
                    updateDataAlumno(req, resp);
                    break;
                case "/matricular":
                    matricularAlumno(req, resp);
                    break;
                default:
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                    break;
            }
        }
    }
    
    private Integer obtenerIdAlumnoSesion(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("id_alumno") != null) {
            return (Integer) session.getAttribute("id_alumno");
        }
        return null;
    }
    
    private boolean verificarSesion(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Integer idAlumno = obtenerIdAlumnoSesion(req);
        
        if (idAlumno == null) {
            
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("error", "Sesión no válida. Debe iniciar sesión.");
            errorResponse.put("redirect", "/login");
            
            ObjectMapper mapper = new ObjectMapper();
            resp.getWriter().write(mapper.writeValueAsString(errorResponse));
            return false;
        }
        
        return true;
    }
    
    protected void confirmEstado(HttpServletRequest req, HttpServletResponse resp) throws IOException{
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
        int idAlumno = loadId(req, resp);
        
        System.out.println("Verificando estado para el alumno: "+idAlumno);
        
        alumno = alumnoDAO.loadAlumno(idAlumno);
        
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
    
    protected void updateDataAlumno(HttpServletRequest req, HttpServletResponse resp) throws IOException{
        try {

            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            
            alumno = alumnoDAO.loadAlumno(loadId(req,resp));
            
           
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
                actualizado = alumnoDAO.updateAlumno(alumno.getId_persona(), dni, nombre, apellido, fechaN, celular, correo, direccion);
            } catch (Exception e) {
                enviarRespuestaError(resp, "Error en la actualización: " + e.getMessage());
                return;
            }

            Map<String, String> respuesta = new HashMap<>();
            if (actualizado) {
                
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
    
    protected void matricularAlumno(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
        
        int idAlumno = loadId(req,resp);
        
        StringBuilder sb = new StringBuilder();
        String line;
        try (BufferedReader reader = req.getReader()) {
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }

        String jsonData = sb.toString();
        System.out.println("JSON recibido: " + jsonData + " - ID Alumno: " + idAlumno);
        
        try (JsonReader jsonReader = Json.createReader(new java.io.StringReader(jsonData))) {
            JsonObject jsonObject = jsonReader.readObject();
            
            
            JsonArray cursosJsonArray = jsonObject.getJsonArray("cursosIds");
            JsonArray idCursoJsonArray = jsonObject.getJsonArray("id_curso");
           
            JsonArray cursosNoSeleccionadosJsonArray = jsonObject.getJsonArray("cursosNoSeleccionadosIds");
            JsonArray idCursoNoSeleccionadosJsonArray = jsonObject.getJsonArray("id_cursoNoSeleccionados");

            
           

          
            List<Integer> listaCursosIds = new ArrayList<>();
            List<Integer> listaID_Curso = new ArrayList<>();
            
            
            List<Integer> listaCursosNoSeleccionadosIds = new ArrayList<>();
            List<Integer> listaID_CursoNoSeleccionados = new ArrayList<>();
            
            boolean todasLasMatriculasExitosas = true;
            String mensajeError = "";
            
        
            for (int i = 0; i < cursosJsonArray.size(); i++) {
                try {
                    int cursoId = (cursosJsonArray.get(i) instanceof JsonNumber) 
                        ? cursosJsonArray.getJsonNumber(i).intValue() 
                        : Integer.parseInt(cursosJsonArray.getString(i));
                    
                    int idCurso = (idCursoJsonArray.get(i) instanceof JsonNumber) 
                        ? idCursoJsonArray.getJsonNumber(i).intValue() 
                        : Integer.parseInt(idCursoJsonArray.getString(i));
                    
                    listaCursosIds.add(cursoId);
                    listaID_Curso.add(idCurso);
                    
                   
                    boolean matriculaExitosa = matriculaDAO.insertMatricula(idAlumno, cursoId, idCurso);
                    
                    if (!matriculaExitosa) {
                        todasLasMatriculasExitosas = false;
                        mensajeError = "Error al insertar la matrícula para el curso ID: " + idCurso;
                        break;
                    }
                    
                } catch (NumberFormatException e) {
                    todasLasMatriculasExitosas = false;
                    mensajeError = "Error en el formato de números en la posición " + i + ": " + e.getMessage();
                    break;
                }
            }
            
           
            if (cursosNoSeleccionadosJsonArray != null && idCursoNoSeleccionadosJsonArray != null) {
                for (int i = 0; i < cursosNoSeleccionadosJsonArray.size(); i++) {
                    try {
                        int cursoNoSeleccionadoId = (cursosNoSeleccionadosJsonArray.get(i) instanceof JsonNumber) 
                            ? cursosNoSeleccionadosJsonArray.getJsonNumber(i).intValue() 
                            : Integer.parseInt(cursosNoSeleccionadosJsonArray.getString(i));
                        
                        int idCursoNoSeleccionado = (idCursoNoSeleccionadosJsonArray.get(i) instanceof JsonNumber) 
                            ? idCursoNoSeleccionadosJsonArray.getJsonNumber(i).intValue() 
                            : Integer.parseInt(idCursoNoSeleccionadosJsonArray.getString(i));
                        
                        listaCursosNoSeleccionadosIds.add(cursoNoSeleccionadoId);
                        listaID_CursoNoSeleccionados.add(idCursoNoSeleccionado);
                        
                    } catch (NumberFormatException e) {
                        System.err.println("Error al procesar curso no seleccionado en posición " + i + ": " + e.getMessage());
                    }
                }
            }
            
           
            JsonObject responseJson;
            if (todasLasMatriculasExitosas && !listaCursosIds.isEmpty()) {
                responseJson = Json.createObjectBuilder()
                        .add("success", true)
                        .add("message", "Matrícula ejecutada correctamente. " + listaCursosIds.size() + " cursos matriculados.")
                        .build();
            } else {
                responseJson = Json.createObjectBuilder()
                        .add("success", false)
                        .add("error", mensajeError.isEmpty() ? "No se pudieron procesar las matrículas" : mensajeError)
                        .build();
            }
            
            resp.getWriter().write(responseJson.toString());
            
            // Debug logs
            System.out.println("=== MATRÍCULA PROCESADA ===");
            System.out.println("ID Alumno (sesión): " + idAlumno);
            System.out.println("Cursos matriculados: " + listaCursosIds.size());
            System.out.println("Cursos no seleccionados: " + listaCursosNoSeleccionadosIds.size());

        } catch (Exception e) {
            System.err.println("Error en matricularAlumno: " + e.getMessage());
            e.printStackTrace();
            
            JsonObject errorResponse = Json.createObjectBuilder()
                    .add("success", false)
                    .add("error", "Error al procesar la petición: " + e.getMessage())
                    .build();
            
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write(errorResponse.toString());
        }
    }
    
    protected void sendAlumno(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
                       
            int idAlumno = loadId(req,resp);
            
            if(idAlumno == -1){
                return;
            }
            
            alumno  = alumnoDAO.loadAlumno(idAlumno);
            

            if (alumno == null) {
                enviarRespuestaError(resp, "Error: alumno no encontrado");
            } else {
                Map<String, String> alumnoJSON = new HashMap<>();
                alumnoJSON.put("id_persona", String.valueOf(alumno.getId_persona()));
                alumnoJSON.put("codigo", alumno.getCodigo());
                alumnoJSON.put("dni", alumno.getDni());
                alumnoJSON.put("nombres", alumno.getNombres());
                alumnoJSON.put("apellidos", alumno.getApellidos());
                alumnoJSON.put("fecha_n", String.valueOf(alumno.getFecha_n()));
                alumnoJSON.put("numeroT", alumno.getNumeroT());
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
    
    protected int loadId(HttpServletRequest req, HttpServletResponse res) throws IOException{
        
        HttpSession session = req.getSession();
        
        if(session == null){
            System.out.println("La session es null.");
            sendSessionExpired(res,"No se puede crear.");
            return -1;
        }
        
        Integer id_A = (Integer) session.getAttribute("id_alumno");
        if(id_A == null){
            System.out.println("El ID del alumno no esta cargado");
            sendSessionExpired(res, "ID_A no se a cargado");
            return -1;
        }
        
        try {
            long currentTime = System.currentTimeMillis();
            long lastAccessTime = session.getLastAccessedTime();
            int maxInactiveInterval = session.getMaxInactiveInterval();
            
            if ((currentTime - lastAccessTime) > (maxInactiveInterval * 1000)) {
                System.out.println("Sesión expirada manualmente detectada");
                session.invalidate();
                sendSessionExpired(res, "session_expired");
                return -1;
            }            
        } catch (IllegalStateException e) {
            System.out.println("Sesión ya invalidada: " + e.getMessage());
            sendSessionExpired(res, "session_invalidated");
            return -1;
        }
        
        return id_A;
    }
    
    private void sendSessionExpired(HttpServletResponse resp, String err) throws IOException{
        resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
        Map<String, String> JSON = new HashMap<>();
        JSON.put("error", err);
        JSON.put("message", "No sepudo obtener correctamente el ID");
        
        ObjectMapper mapper = new ObjectMapper();
        resp.getWriter().write(mapper.writeValueAsString(JSON));
        
    }
    
    protected void viewHorario(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
        
        int idAlumno = loadId(req,resp);
        
        List<HorarioMatricula> horarios = matriculaDAO.loadHorarios(idAlumno);
        List<Map<String, String>> horariosJSONList = new ArrayList<>();

        for (HorarioMatricula h : horarios) {
            Map<String, String> horarioJSON = new HashMap<>();
            horarioJSON.put("id_horario", String.valueOf(h.getId_horario()));
            horarioJSON.put("id_curso", String.valueOf(h.getId_curso()));
            horarioJSON.put("nombreC", h.getNombreC());
            horarioJSON.put("profesor", h.getApellidos() + ", " + h.getNombres());
            horarioJSON.put("aula", h.getAula());
            horarioJSON.put("diaH", h.getDia() + ": " + h.getHinicio() + " - " + h.getHfin());
            horarioJSON.put("capacidad", String.valueOf(h.getCapacidad()));
            horarioJSON.put("cupos", String.valueOf(h.getCupos()));
            horariosJSONList.add(horarioJSON);
        }

        ObjectMapper mapper = new ObjectMapper();
        resp.getWriter().write(mapper.writeValueAsString(horariosJSONList));
    }
    
    protected void viewHorarioM(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
        
        int idAlumno = loadId(req,resp);
        
        List<HorarioMatricula> horarios = matriculaDAO.loadHorariosM(idAlumno);
        List<Map<String, String>> horariosJSONList = new ArrayList<>();

        for (HorarioMatricula h : horarios) {
            Map<String, String> horarioJSON = new HashMap<>();
            horarioJSON.put("id_horario", String.valueOf(h.getId_horario()));
            horarioJSON.put("id_curso", String.valueOf(h.getId_curso()));
            horarioJSON.put("nombreC", h.getNombreC());
            horarioJSON.put("profesor", h.getApellidos() + ", " + h.getNombres());
            horarioJSON.put("aula", h.getAula());
            horarioJSON.put("diaH", h.getDia() + ": " + h.getHinicio() + " - " + h.getHfin());
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