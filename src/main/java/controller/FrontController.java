package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 *
 * @author Soviet
 */

@WebServlet(name = "FrontController",urlPatterns = "/app/*")
public class FrontController extends HttpServlet{
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        String path = req.getPathInfo();
         
        if (path == null) {
            
            req.getRequestDispatcher("/WEB-INF/views/panel.jsp").forward(req, resp);
            return;
        }
        
        switch (path) {
            case "/inicio":
                req.getRequestDispatcher("/WEB-INF/views/panel.jsp").forward(req, resp);
                break;
            case "/matricula":
                req.getRequestDispatcher("/WEB-INF/views/matricula.jsp").forward(req, resp);
                break;
            case "/matricularse":
                req.getRequestDispatcher("/WEB-INF/views/matricularse.jsp").forward(req, resp);
                break;
                    
            default:
                    
                throw new AssertionError();
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       
        String path = req.getPathInfo();
        
        switch (path) {
            case "/matricula":
                req.getRequestDispatcher("/WEB-INF/views/matricula.jsp").forward(req, resp);
                break;
                    
            default:
                req.getRequestDispatcher("/WEB-INF/views/matricula.jsp").forward(req, resp);
                throw new AssertionError();
        }
    }
    
}
