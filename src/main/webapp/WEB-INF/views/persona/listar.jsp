<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Listado de Personas</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <div class="row">
            <div class="col">
                <h1>Listado de Personas</h1>
                <a href="${pageContext.request.contextPath}/personas/nuevo" class="btn btn-primary mb-3">
                    Nueva Persona
                </a>
                
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>DNI</th>
                            <th>Apellidos</th>
                            <th>Nombres</th>
                            <th>Fecha Nacimiento</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="persona" items="${personas}">
                            <tr>
                                <td>${persona.idPersona}</td>
                                <td>${persona.dni}</td>
                                <td>${persona.apellidos}</td>
                                <td>${persona.nombres}</td>
                                <td>${persona.fechaNacimiento}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/personas/ver?id=${persona.idPersona}" 
                                       class="btn btn-info btn-sm">Ver</a>
                                    <a href="${pageContext.request.contextPath}/personas/editar?id=${persona.idPersona}" 
                                       class="btn btn-warning btn-sm">Editar</a>
                                    <form action="${pageContext.request.contextPath}/personas" method="post" 
                                          style="display: inline;">
                                        <input type="hidden" name="action" value="eliminar">
                                        <input type="hidden" name="id" value="${persona.idPersona}">
                                        <button type="submit" class="btn btn-danger btn-sm" 
                                                onclick="return confirm('¿Está seguro de eliminar esta persona?')">
                                            Eliminar
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
</body>
</html>