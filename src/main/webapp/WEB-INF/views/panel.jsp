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
                            <a href="${pageContext.request.contextPath}/dashboard/cuentas" class="${seccion == 'cuentas' ? '' : ''}">
                                <i class="fas fa-money-bill-wave mr-1"></i> Cuentas Corrientes
                            </a>
                            <a href="${pageContext.request.contextPath}/dashboard/horario" class="${seccion == 'horario' ? '' : ''}">
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

                    <div>
                        <button class="mobile-menu-button">
                            <i class="fas fa-bars text-2xl"></i>
                        </button>
                    </div>
                </div>
            </div>

            
        </nav>

        <main>
            <div>
                <div>
                    <div>
                        <a href="${pageContext.request.contextPath}/dashboard/inicio">
                            <i class="fas fa-home"></i>
                        </a>
                        <span>/</span>
                        <span>${seccion}</span>
                    </div>
                </div>

                <div>
                    <div>
                        <h1>
                            <c:choose>
                                <c:when test="${seccion == 'inicio'}">Panel Principal</c:when>
                                <c:otherwise>${seccion}</c:otherwise>
                            </c:choose>
                        </h1>

                        <c:choose>
                            <c:when test="${seccion == 'inicio'}">
                                <div>
                                    <div>
                                        <div>
                                            <div>
                                                <div>
                                                    <i class="fas fa-calendar-check text-xl"></i>
                                                </div>
                                                <div>
                                                    <h3>Horario de Hoy</h3>
                                                    <p>3 clases programadas</p>
                                                </div>
                                            </div>
                                        </div>

                                        <div>
                                            <div>
                                                <div>
                                                    <i class="fas fa-check-circle text-xl"></i>
                                                </div>
                                                <div>
                                                    <h3>Asistencia</h3>
                                                    <p>95% de asistencia</p>
                                                </div>
                                            </div>
                                        </div>

                                        <div>
                                            <div>
                                                <div>
                                                    <i class="fas fa-exclamation-circle text-xl"></i>
                                                </div>
                                                <div>
                                                    <h3>Pendientes</h3>
                                                    <p>2 tareas por entregar</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:when>

                            <c:when test="${seccion == 'personas'}">
                                <div>
                                    <a href="${pageContext.request.contextPath}/personas/nuevo">
                                        <i class="fas fa-plus mr-1"></i> Nueva Persona
                                    </a>
                                </div>

                                <div>
                                    <table>
                                        <thead>
                                            <tr>
                                                <th scope="col">ID</th>
                                                <th scope="col">DNI</th>
                                                <th scope="col">Apellidos</th>
                                                <th scope="col">Nombres</th>
                                                <th scope="col">Fecha Nacimiento</th>
                                                <th scope="col">Acciones</th>
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
                                                        <a href="${pageContext.request.contextPath}/personas/ver?id=${persona.idPersona}">
                                                            <i class="fas fa-eye"></i>
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/personas/editar?id=${persona.idPersona}">
                                                            <i class="fas fa-edit"></i>
                                                        </a>
                                                        <form action="${pageContext.request.contextPath}/personas" method="post" class="inline">
                                                            <input type="hidden" name="action" value="eliminar">
                                                            <input type="hidden" name="id" value="${persona.idPersona}">
                                                            <button type="submit" onclick="return confirm('¿Está seguro de eliminar esta persona?')">
                                                                <i class="fas fa-trash"></i>
                                                            </button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>

                            <c:otherwise>
                                <div>
                                    <i class="fas fa-tools text-6xl text-gray-300 mb-4"></i>
                                    <h2>Sección en construcción</h2>
                                    <p>Esta funcionalidad estará disponible próximamente.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </main>

        <footer>
            <div>
                <p>
                    &copy; 2025 Sistema Académico. Todos los derechos reservados.
                </p>
            </div>
        </footer>
    </div>

    <script>
        // Toggle para el menú móvil
        const btn = document.querySelector('.mobile-menu-button');
        const menu = document.querySelector('.mobile-menu');

        btn.addEventListener('click', () => {
            menu.classList.toggle('hidden');
        });
    </script>
</body>
</html>