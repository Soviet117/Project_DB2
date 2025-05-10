<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema Académico</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div>
        <nav>
            <div>
                <div>
                    <div>
                        <div>
                            <span>Intranet</span>
                        </div>

                        <div>
                            <a href="${pageContext.request.contextPath}/dashboard/inicio" class="${seccion == 'inicio' ? '' : ''}">
                                <i class="fas fa-home mr-1"></i> Inicio
                            </a>
                            <a href="${pageContext.request.contextPath}/app/matricula" class="${seccion == 'matricula' ? '' : ''}">
                                <i class="fas fa-user-graduate mr-1"></i> Matrícula
                            </a>
                            <a href="${pageContext.request.contextPath}/app/horario" class="${seccion == 'horario' ? '' : ''}">
                                <i class="fas fa-calendar-alt mr-1"></i> Horario
                            </a>
                            <a href="${pageContext.request.contextPath}/dashboard/notas" class="${seccion == 'notas' ? '' : ''}">
                                <i class="fas fa-book mr-1"></i> Notas
                            </a>
                        </div>
                    </div>

                    <div>
                        <a href="${pageContext.request.contextPath}/logout">
                            <i class="fas fa-sign-out-alt mr-1"></i> Salir
                        </a>
                    </div>

                   
                </div>
            </div>

            
        </nav>

      

        
    </div>

    
</body>
</html>