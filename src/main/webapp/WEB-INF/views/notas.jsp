<%--
    Document   : notas
    Created on : 9 may. 2025, 11:46:25 p. m.
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Intranet Sideral Carrión</title>
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
                                900: '#002333', //oscuro
                                800: '#00384d',
                                700: '#005670', 
                                600: '#007699',
                                500: '#0098c1'  
                            }
                        }
                    }
                }
            }
        </script>
    </head>
    <body class="bg-gray-100 min-h-screen">
        
        <jsp:include page="/WEB-INF/views/panel.jsp" />
        
        <div class="container mx-auto px-4 py-6">
            <div class="mb-6">
                <h1 class="text-3xl font-bold text-brand-900 mb-2">Mis Notas</h1>
                <div class="h-1 w-32 bg-brand-500"></div>
            </div>
            
            <div id="mensaje-notas" class="bg-blue-100 border-l-4 border-blue-500 text-blue-700 p-4 mb-6 rounded shadow-md">
                <p class="flex items-center">
                    <i class="fas fa-spinner fa-spin mr-2"></i>
                    <span>Cargando notas...</span>
                </p>
            </div>
            
            <div class="bg-white rounded-lg shadow-md p-6 mb-8">
                <h2 class="text-xl font-semibold text-brand-700 mb-4 flex items-center">
                    <i class="fas fa-graduation-cap mr-2"></i>Calificaciones Académicas
                </h2>
                
                <div id="notas-container" class="space-y-4">
                    <!-- Las notas se cargarán dinámicamente aquí -->
                </div>
            </div>
        </div>

        <script>
            function loadNotas() {
                const mensajeDiv = document.getElementById('mensaje-notas');

                fetch('${pageContext.request.contextPath}/controllerDataNotas/loadNotas', {
                    method: 'GET',
                    headers: {
                        'Accept': 'application/json',
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                })
                .then(response => {

                    if (response.status === 401) {
                        return response.json().then(errorData => {
                            console.log('Sesión expirada detectada:', errorData);

                            mensajeDiv.classList.remove('bg-blue-100', 'border-blue-500', 'text-blue-700');
                            mensajeDiv.classList.add('bg-red-100', 'border-red-500', 'text-red-700');
                            mensajeDiv.querySelector('span').textContent = errorData.message || 'Su sesión ha expirado.';
                            mensajeDiv.querySelector('i').className = 'fas fa-exclamation-triangle mr-2';

                            setTimeout(() => {
                                window.location.href = errorData.redirect || '${pageContext.request.contextPath}/app/login';
                            }, 2000);

                            throw new Error('session_expired');
                        });
                    }

                    if (!response.ok) {
                        throw new Error('Error al cargar los datos de notas: ' + response.status);
                    }
                    return response.json();
                })
                .then(notas => {
                    console.log('Notas recibidas:', notas.length);
                    console.log('Detalle de la nota: ', notas);
                    const notasContainer = document.getElementById('notas-container');
                    notasContainer.innerHTML = '';

                    if (notas == null || notas.length === 0) {
                        mensajeDiv.classList.remove('bg-blue-100', 'border-blue-500', 'text-blue-700');
                        mensajeDiv.classList.add('bg-yellow-100', 'border-yellow-500', 'text-yellow-700');
                        mensajeDiv.querySelector('span').textContent = 'No hay calificaciones disponibles.';
                        mensajeDiv.querySelector('i').className = 'fas fa-exclamation-triangle mr-2';
                    } else {
                        notas.forEach(nota => {
                            const cursoDiv = document.createElement('div');
                            cursoDiv.className = 'bg-white border border-gray-200 rounded-lg shadow-sm overflow-hidden';

                            const headerDiv = document.createElement('div');
                            headerDiv.className = 'bg-brand-700 text-white px-4 py-3';
                            headerDiv.innerHTML = `
                                <div class="flex flex-col md:flex-row md:justify-between md:items-center">
                                    <div class="font-medium text-lg">\${nota.nombre || 'Nombre no disponible'}</div>
                                    <div class="text-sm">Código: \${nota.codigo || 'N/A'} | Créditos: \${nota.creditos || 'N/A'}</div>
                                </div>
                                <div class="text-sm text-gray-100 mt-1">Profesor: \${nota.profesor || 'No asignado'}</div>
                            `;
                            cursoDiv.appendChild(headerDiv);

                            const contentDiv = document.createElement('div');
                            contentDiv.className = 'p-4';

                            const parcialesDiv = document.createElement('div');
                            parcialesDiv.className = 'mb-4';
                            parcialesDiv.innerHTML = `
                                <div class="font-semibold text-brand-800 mb-2 flex items-center">
                                    <i class="fas fa-clipboard-check mr-2"></i>Evaluaciones Principales
                                </div>
                                <div class="grid grid-cols-2 md:grid-cols-5 gap-2 text-center">
                                    <div class="bg-gray-50 p-3 rounded-lg">
                                        <div class="text-xs text-gray-500">EC [20%]</div>
                                        <div class="text-lg font-bold text-brand-700">\${nota.continuas || '—'}</div>
                                    </div>
                                    <div class="bg-gray-50 p-3 rounded-lg">
                                        <div class="text-xs text-gray-500">E1 [10%]</div>
                                        <div class="text-lg font-bold text-brand-700">\${nota.p1 || '—'}</div>
                                    </div>
                                    <div class="bg-gray-50 p-3 rounded-lg">
                                        <div class="text-xs text-gray-500">E2 [20%]</div>
                                        <div class="text-lg font-bold text-brand-700">\${nota.p2 || '—'}</div>
                                    </div>
                                    <div class="bg-gray-50 p-3 rounded-lg">
                                        <div class="text-xs text-gray-500">E3 [20%]</div>
                                        <div class="text-lg font-bold text-brand-700">\${nota.p3 || '—'}</div>
                                    </div>
                                    <div class="bg-gray-50 p-3 rounded-lg">
                                        <div class="text-xs text-gray-500">EF [30%]</div>
                                        <div class="text-lg font-bold text-brand-700">\${nota.p4 || '—'}</div>
                                    </div>
                                </div>
                            `;
                            contentDiv.appendChild(parcialesDiv);

                            const continuasDiv = document.createElement('div');
                            continuasDiv.className = 'mt-4';
                            continuasDiv.innerHTML = `
                                <div class="font-semibold text-brand-800 mb-2 flex items-center">
                                    <i class="fas fa-tasks mr-2"></i>Evaluaciones Continuas
                                </div>
                                <div class="grid grid-cols-3 md:grid-cols-6 gap-2 text-center">
                                    <div class="bg-gray-50 p-2 rounded-lg">
                                        <div class="text-xs text-gray-500">EC1</div>
                                        <div class="text-md font-bold text-brand-700">\${nota.c1 || '—'}</div>
                                    </div>
                                    <div class="bg-gray-50 p-2 rounded-lg">
                                        <div class="text-xs text-gray-500">EC2</div>
                                        <div class="text-md font-bold text-brand-700">\${nota.c2 || '—'}</div>
                                    </div>
                                    <div class="bg-gray-50 p-2 rounded-lg">
                                        <div class="text-xs text-gray-500">EC3</div>
                                        <div class="text-md font-bold text-brand-700">\${nota.c3 || '—'}</div>
                                    </div>
                                    <div class="bg-gray-50 p-2 rounded-lg">
                                        <div class="text-xs text-gray-500">EC4</div>
                                        <div class="text-md font-bold text-brand-700">\${nota.c4 || '—'}</div>
                                    </div>
                                    <div class="bg-gray-50 p-2 rounded-lg">
                                        <div class="text-xs text-gray-500">EC5</div>
                                        <div class="text-md font-bold text-brand-700">\${nota.c5 || '—'}</div>
                                    </div>
                                    <div class="bg-gray-50 p-2 rounded-lg">
                                        <div class="text-xs text-gray-500">EC6</div>
                                        <div class="text-md font-bold text-brand-700">\${nota.c6 || '—'}</div>
                                    </div>
                                </div>
                            `;
                            contentDiv.appendChild(continuasDiv);

                            cursoDiv.appendChild(contentDiv);
                            notasContainer.appendChild(cursoDiv);
                        });

                        mensajeDiv.classList.remove('bg-blue-100', 'border-blue-500', 'text-blue-700');
                        mensajeDiv.classList.add('bg-green-100', 'border-green-500', 'text-green-700');
                        mensajeDiv.querySelector('span').textContent = 'Notas cargadas correctamente.';
                        mensajeDiv.querySelector('i').className = 'fas fa-check-circle mr-2';

                        setTimeout(() => {
                            mensajeDiv.classList.add('hidden');
                        }, 3000);
                    }
                })
                .catch(error => {
                    console.error('Error al cargar datos de notas:', error);

                    if (error.message === 'session_expired') {
                        return;
                    }

                    mensajeDiv.classList.remove('bg-blue-100', 'border-blue-500', 'text-blue-700');
                    mensajeDiv.classList.add('bg-red-100', 'border-red-500', 'text-red-700');
                    mensajeDiv.querySelector('span').textContent = 'Error al cargar las notas: ' + error.message;
                    mensajeDiv.querySelector('i').className = 'fas fa-times-circle mr-2';
                });
            }

            document.addEventListener('DOMContentLoaded', loadNotas);

            document.addEventListener('DOMContentLoaded', loadNotas);
        </script>
    </body>
</html>