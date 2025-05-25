<%-- 
    Document   : horario
    Created on : 7 may. 2025, 11:27:26 p. m.
    Author     : HP
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Intranet Berraco</title>
        <!-- Incluir Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com"></script>
        <!-- Font Awesome para iconos -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {
                            'brand': {
                                900: '#002333', // Azul más oscuro
                                800: '#00384d',
                                700: '#005670', // Azul intermedio
                                600: '#007699',
                                500: '#0098c1'  // Azul turquesa
                            }
                        }
                    }
                }
            }
        </script>
    </head>
    <body class="bg-gray-100 min-h-screen">
        
        <!-- Incluir el encabezado desde un archivo separado -->
        <jsp:include page="/WEB-INF/views/panel.jsp" />
        
        <div class="container mx-auto px-4 py-6">
            <div class="mb-6">
                <h1 class="text-3xl font-bold text-brand-900 mb-2">Horario de Clases</h1>
                <div class="h-1 w-32 bg-brand-500"></div>
            </div>
            
            <div id="mensaje-horario" class="bg-blue-100 border-l-4 border-blue-500 text-blue-700 p-4 mb-6 rounded shadow-md hidden">
                <p class="flex items-center">
                    <i class="fas fa-info-circle mr-2"></i>
                    <span>Cargando horario...</span>
                </p>
            </div>
            
            <div class="bg-white rounded-lg shadow-md p-6 mb-8 overflow-x-auto">
                <h2 class="text-xl font-semibold text-brand-700 mb-4 flex items-center">
                    <i class="fas fa-calendar-alt mr-2"></i>Horario Académico
                </h2>
                
                <table id="horarioTable" class="min-w-full border-collapse">
                    <thead>
                        <tr>
                            <th class="bg-brand-700 text-white py-3 px-4 font-medium text-sm">Hora</th>
                            <th class="bg-brand-700 text-white py-3 px-4 font-medium text-sm">Lunes</th>
                            <th class="bg-brand-700 text-white py-3 px-4 font-medium text-sm">Martes</th>
                            <th class="bg-brand-700 text-white py-3 px-4 font-medium text-sm">Miércoles</th>
                            <th class="bg-brand-700 text-white py-3 px-4 font-medium text-sm">Jueves</th>
                            <th class="bg-brand-700 text-white py-3 px-4 font-medium text-sm">Viernes</th>
                            <th class="bg-brand-700 text-white py-3 px-4 font-medium text-sm">Sábado</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="hover:bg-gray-50">
                            <td class="border px-4 py-3 bg-gray-50 font-medium">07:00 - 08:20</td>
                            <td class="border px-2 py-2" data-hora="1" data-dia="1"></td>
                            <td class="border px-2 py-2" data-hora="1" data-dia="2"></td>
                            <td class="border px-2 py-2" data-hora="1" data-dia="3"></td>
                            <td class="border px-2 py-2" data-hora="1" data-dia="4"></td>
                            <td class="border px-2 py-2" data-hora="1" data-dia="5"></td>
                            <td class="border px-2 py-2" data-hora="1" data-dia="6"></td>
                        </tr>
                        <tr class="hover:bg-gray-50">
                            <td class="border px-4 py-3 bg-gray-50 font-medium">08:30 - 10:00</td>
                            <td class="border px-2 py-2" data-hora="2" data-dia="1"></td>
                            <td class="border px-2 py-2" data-hora="2" data-dia="2"></td>
                            <td class="border px-2 py-2" data-hora="2" data-dia="3"></td>
                            <td class="border px-2 py-2" data-hora="2" data-dia="4"></td>
                            <td class="border px-2 py-2" data-hora="2" data-dia="5"></td>
                            <td class="border px-2 py-2" data-hora="2" data-dia="6"></td>
                        </tr>
                        <tr class="hover:bg-gray-50">
                            <td class="border px-4 py-3 bg-gray-50 font-medium">10:10 - 11:45</td>
                            <td class="border px-2 py-2" data-hora="3" data-dia="1"></td>
                            <td class="border px-2 py-2" data-hora="3" data-dia="2"></td>
                            <td class="border px-2 py-2" data-hora="3" data-dia="3"></td>
                            <td class="border px-2 py-2" data-hora="3" data-dia="4"></td>
                            <td class="border px-2 py-2" data-hora="3" data-dia="5"></td>
                            <td class="border px-2 py-2" data-hora="3" data-dia="6"></td>
                        </tr>
                        <tr class="hover:bg-gray-50">
                            <td class="border px-4 py-3 bg-gray-50 font-medium">12:00 - 13:30</td>
                            <td class="border px-2 py-2" data-hora="4" data-dia="1"></td>
                            <td class="border px-2 py-2" data-hora="4" data-dia="2"></td>
                            <td class="border px-2 py-2" data-hora="4" data-dia="3"></td>
                            <td class="border px-2 py-2" data-hora="4" data-dia="4"></td>
                            <td class="border px-2 py-2" data-hora="4" data-dia="5"></td>
                            <td class="border px-2 py-2" data-hora="4" data-dia="6"></td>
                        </tr>
                        <tr class="hover:bg-gray-50">
                            <td class="border px-4 py-3 bg-gray-50 font-medium">14:00 - 15:30</td>
                            <td class="border px-2 py-2" data-hora="5" data-dia="1"></td>
                            <td class="border px-2 py-2" data-hora="5" data-dia="2"></td>
                            <td class="border px-2 py-2" data-hora="5" data-dia="3"></td>
                            <td class="border px-2 py-2" data-hora="5" data-dia="4"></td>
                            <td class="border px-2 py-2" data-hora="5" data-dia="5"></td>
                            <td class="border px-2 py-2" data-hora="5" data-dia="6"></td>
                        </tr>
                        <tr class="hover:bg-gray-50">
                            <td class="border px-4 py-3 bg-gray-50 font-medium">15:45 - 17:15</td>
                            <td class="border px-2 py-2" data-hora="6" data-dia="1"></td>
                            <td class="border px-2 py-2" data-hora="6" data-dia="2"></td>
                            <td class="border px-2 py-2" data-hora="6" data-dia="3"></td>
                            <td class="border px-2 py-2" data-hora="6" data-dia="4"></td>
                            <td class="border px-2 py-2" data-hora="6" data-dia="5"></td>
                            <td class="border px-2 py-2" data-hora="6" data-dia="6"></td>
                        </tr>
                        <tr class="hover:bg-gray-50">
                            <td class="border px-4 py-3 bg-gray-50 font-medium">17:30 - 19:00</td>
                            <td class="border px-2 py-2" data-hora="7" data-dia="1"></td>
                            <td class="border px-2 py-2" data-hora="7" data-dia="2"></td>
                            <td class="border px-2 py-2" data-hora="7" data-dia="3"></td>
                            <td class="border px-2 py-2" data-hora="7" data-dia="4"></td>
                            <td class="border px-2 py-2" data-hora="7" data-dia="5"></td>
                            <td class="border px-2 py-2" data-hora="7" data-dia="6"></td>
                        </tr>
                        <tr class="hover:bg-gray-50">
                            <td class="border px-4 py-3 bg-gray-50 font-medium">19:10 - 20:40</td>
                            <td class="border px-2 py-2" data-hora="8" data-dia="1"></td>
                            <td class="border px-2 py-2" data-hora="8" data-dia="2"></td>
                            <td class="border px-2 py-2" data-hora="8" data-dia="3"></td>
                            <td class="border px-2 py-2" data-hora="8" data-dia="4"></td>
                            <td class="border px-2 py-2" data-hora="8" data-dia="5"></td>
                            <td class="border px-2 py-2" data-hora="8" data-dia="6"></td>
                        </tr>
                        <tr class="hover:bg-gray-50">
                            <td class="border px-4 py-3 bg-gray-50 font-medium">20:50 - 22:20</td>
                            <td class="border px-2 py-2" data-hora="9" data-dia="1"></td>
                            <td class="border px-2 py-2" data-hora="9" data-dia="2"></td>
                            <td class="border px-2 py-2" data-hora="9" data-dia="3"></td>
                            <td class="border px-2 py-2" data-hora="9" data-dia="4"></td>
                            <td class="border px-2 py-2" data-hora="9" data-dia="5"></td>
                            <td class="border px-2 py-2" data-hora="9" data-dia="6"></td>
                        </tr>
                    </tbody>
                </table>
                
                <!-- Campo oculto para depuración -->
                <input type="hidden" id="depuracion">
                
                <div class="mt-6 text-sm text-gray-500">
                    <p class="flex items-center">
                        <i class="fas fa-info-circle mr-2 text-brand-500"></i>
                        Los cursos se cargarán automáticamente desde el sistema.
                    </p>
                </div>
            </div>
        </div>
    </body>
    
    <script>
        function loadHorarios() {
            const mensajeDiv = document.getElementById('mensaje-horario');
            mensajeDiv.classList.remove('hidden');
            mensajeDiv.classList.remove('bg-green-100', 'border-green-500', 'text-green-700', 'bg-red-100', 'border-red-500', 'text-red-700');
            mensajeDiv.classList.add('bg-blue-100', 'border-blue-500', 'text-blue-700');
            mensajeDiv.querySelector('span').textContent = 'Cargando horario...';
            mensajeDiv.querySelector('i').className = 'fas fa-spinner fa-spin mr-2';
            
            fetch('${pageContext.request.contextPath}/controllerDataHorario/verHorario', {
                method: 'GET',
                headers: {
                    'Accept': 'application/json'
                }
            })
            .then(response => {
                console.log('Status de respuesta:', response.status);
                if (response.status === 401) {
                console.log('Sesión expirada detectada - Status 401');

                // Mostrar mensaje de sesión expirada
                mensajeDiv.classList.remove('bg-blue-100', 'border-blue-500', 'text-blue-700');
                mensajeDiv.classList.add('bg-yellow-100', 'border-yellow-500', 'text-yellow-700');
                mensajeDiv.querySelector('span').textContent = 'Sesión expirada. Redirigiendo al login...';
                mensajeDiv.querySelector('i').className = 'fas fa-exclamation-triangle mr-2';

                // Intentar parsear la respuesta JSON (opcional)
                return response.json().then(errorData => {
                    console.log('Datos del error 401:', errorData);

                    // Redireccionar después de un breve delay
                    setTimeout(() => {
                        console.log('Redirigiendo a login...');
                        window.location.href = '${pageContext.request.contextPath}/app/login';
                    }, 2000);

                    // Lanzar error para detener la cadena de promesas
                    throw new Error('session_expired');
                }).catch(jsonError => {
                    // Si no se puede parsear el JSON, aún así redirigir
                    console.log('Error al parsear JSON del 401, pero redirigiendo igual:', jsonError);
                    setTimeout(() => {
                        window.location.href = '${pageContext.request.contextPath}/app/login';
                    }, 2000);
                    throw new Error('session_expired');
                });
            }
                if (!response.ok) {
                    throw new Error('Error al cargar los datos del horario: ' + response.status);
                }
                return response.json();
            })
            .then(horarios => {
                if (horarios == null || horarios.length === 0) {
                    console.error("No hay datos de horarios disponibles");
                    document.getElementById('depuracion').value = "No hay datos de horarios";
                    mensajeDiv.classList.remove('bg-blue-100', 'border-blue-500', 'text-blue-700');
                    mensajeDiv.classList.add('bg-yellow-100', 'border-yellow-500', 'text-yellow-700');
                    mensajeDiv.querySelector('span').textContent = 'No hay cursos registrados en el horario.';
                    mensajeDiv.querySelector('i').className = 'fas fa-exclamation-triangle mr-2';
                } else {
                    console.log("Horarios cargados:", horarios);

                    horarios.forEach(curso => {
                        console.log("Objeto curso completo:", curso);

                        const idHora = typeof curso.id_hora === 'string' ? parseInt(curso.id_hora) : curso.id_hora;
                        const idDia = typeof curso.id_dia === 'string' ? parseInt(curso.id_dia) : curso.id_dia;

                        console.log("Nombre del curso:", curso.nom_curso);
                        console.log("Código del curso:", curso.codigo);
                        console.log("Nombre del aula:", curso.nom_aula);

                        const celda = encontrarCeldaPorIndices(idHora, idDia);

                        if (celda) {
                            insertarDatos(celda, curso.nom_curso, curso.codigo, curso.nom_aula);
                        } else {
                            console.error('No se pudo encontrar celda para hora:', idHora, 'día:', idDia);
                        }
                    });
                    
                    mensajeDiv.classList.remove('bg-blue-100', 'border-blue-500', 'text-blue-700');
                    mensajeDiv.classList.add('bg-green-100', 'border-green-500', 'text-green-700');
                    mensajeDiv.querySelector('span').textContent = 'Horario cargado correctamente.';
                    mensajeDiv.querySelector('i').className = 'fas fa-check-circle mr-2';
                }
            })
            .catch(error => {
                console.error("Error al cargar datos del horario:", error);
                document.getElementById('depuracion').value = "Error: " + error;
                mensajeDiv.classList.remove('bg-blue-100', 'border-blue-500', 'text-blue-700');
                mensajeDiv.classList.add('bg-red-100', 'border-red-500', 'text-red-700');
                mensajeDiv.querySelector('span').textContent = 'Error al cargar el horario: ' + error.message;
                mensajeDiv.querySelector('i').className = 'fas fa-times-circle mr-2';
            });
        }

        function encontrarCeldaPorIndices(idHora, idDia) {
            const filas = document.querySelectorAll('#horarioTable tbody tr');
            if (!filas || filas.length < idHora) {
                console.error('No se encontró la fila para hora:', idHora);
                return null;
            }

            const fila = filas[idHora - 1];

            const celdas = fila.querySelectorAll('td');
            if (!celdas || celdas.length < idDia + 1) {
                console.error('No se encontró la celda para día:', idDia);
                return null;
            }

            return celdas[idDia];
        }

        function insertarDatos(celda, cursoN, codigo, nombreA) {
            const cursoElement = document.createElement('div');
            cursoElement.className = 'curso bg-brand-100 border-l-4 border-brand-500 text-brand-800 p-2 rounded shadow-sm text-sm mb-1';
            cursoElement.innerHTML = `
                <div class="font-medium">\${cursoN || ''}</div>
                <div class="text-xs">\${codigo || ''}</div>
                <div class="text-xs text-gray-600">Aula: \${nombreA || ''}</div>
            `;
            console.log(`Valor de Curso: ${cursoN}`); 
            
            console.log('Valor de nombre Curso Dentro del insetarDATOS: ', cursoN);
            console.log('Valor de codigo Curso Dentro del insetarDATOS: ', codigo);
            console.log('Valor de aula Curso Dentro del insetarDATOS: ', nombreA);
            celda.appendChild(cursoElement);
        }

        document.addEventListener('DOMContentLoaded', loadHorarios);
    </script>
</html>