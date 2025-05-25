<%-- 
    Document   : matricularse
    Created on : 1 may. 2025, 12:13:33 a. m.
    Author     : HP
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Matrícula</title>
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
                                900: '#002333', // azul más oscuro
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
        <style>
            /* Estilos adicionales para las tablas */
            .custom-table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
            }
            .custom-table th, .custom-table td {
                padding: 0.75rem 1rem;
                border-bottom: 1px solid #e2e8f0;
            }
            .custom-table th {
                background-color: #005670;
                color: white;
                font-weight: 600;
                text-align: left;
            }
            .custom-table tr:hover {
                background-color: #f7fafc;
            }
        </style>
    </head>
    <body class="bg-gray-100 min-h-screen">
        <!-- Incluir el encabezado desde un archivo separado -->
        <jsp:include page="/WEB-INF/views/panel.jsp" />
        
        <div class="container mx-auto px-4 py-6">
            <div class="mb-6">
                <h1 class="text-3xl font-bold text-brand-900 mb-2">A matricularse</h1>
                <div class="h-1 w-32 bg-brand-500"></div>
            </div>
            
            <!-- Sección de cursos disponibles -->
            <div class="bg-white rounded-lg shadow-md p-6 mb-8">
                <h2 class="text-xl font-semibold text-brand-700 mb-4 flex items-center">
                    <i class="fas fa-book-open mr-2"></i>Cursos disponibles
                </h2>
                <div class="overflow-x-auto">
                    <table id="horarios-table" class="custom-table">
                        <thead>
                            <tr>
                                <th class="rounded-tl-lg">ID Curso</th>
                                <th>Nombre</th>
                                <th>Profesor</th>
                                <th>Aula</th>
                                <th>Horario</th>
                                <th>Total de Cupos</th>
                                <th>Cupos Disponibles</th>
                                <th class="rounded-tr-lg text-center">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Filas serán añadidas dinámicamente por JS -->
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Sección de cursos seleccionados -->
            <div class="bg-white rounded-lg shadow-md p-6 mb-8">
                <h2 class="text-xl font-semibold text-brand-700 mb-4 flex items-center">
                    <i class="fas fa-check-circle mr-2"></i>Cursos seleccionados
                </h2>
                <div class="overflow-x-auto">
                    <table id="seleccionados-table" class="custom-table">
                        <thead>
                            <tr>
                                <th class="rounded-tl-lg">ID Curso</th>
                                <th>Nombre</th>
                                <th>Profesor</th>
                                <th>Aula</th>
                                <th>Horario</th>
                                <th>Total de Cupos</th>
                                <th class="rounded-tr-lg text-center">Acción</th>                
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Filas serán añadidas dinámicamente por JS -->
                        </tbody>
                    </table>
                </div>
            </div>
            
            <!-- Botón de matricular -->
            <div class="flex justify-center mb-8">
                <button id="btn-matricular" class="bg-brand-700 hover:bg-brand-800 text-white font-bold py-3 px-6 rounded-lg shadow-md transition duration-300 ease-in-out transform hover:-translate-y-1 flex items-center">
                    <i class="fas fa-user-graduate mr-2"></i>
                    Completar Matrícula
                </button>
            </div>
        </div>
        
        <script>
            
            let horariosOriginales = [];
            let horariosSeleccionados = [];

            function loadHorarios() {
                fetch('${pageContext.request.contextPath}/controllerDataMatricularse/viewHorarios', {
                    method: 'GET',
                    headers: {
                        'Accept': 'application/json'
                    }
                })
                .then(response => {
                    if(response.status === 401){
                        return response.json().then(errorData => {
                            console.log('Sesión expirada detectada:', errorData);

                            setTimeout(() => {
                                window.location.href =  '${pageContext.request.contextPath}/app/login';
                            }, 2000);

                            throw new Error('session_expired');
                        });
                    }
                    if (!response.ok) {
                        throw new Error("Error al cargar las matriculas: " + response.status);
                    }
                    return response.json();
                })
                .then(horarios => {
                    console.log('Cursos generales: ', horarios);

                    
                    if (Array.isArray(horarios)) {
                        horariosOriginales = [...horarios];
                    } else if (typeof horarios === 'object') {
                        horariosOriginales = Object.values(horarios);
                    }

                    
                    loadHorarioM();
                })
                .catch(error => {
                    console.error('Error al cargar los datos:', error);
                });
            }

            function loadHorarioM() {
                fetch('${pageContext.request.contextPath}/controllerDataMatricularse/viewHorariosM', {
                    method: 'GET',
                    headers: {
                        'Accept': 'application/json'
                    }
                })
                .then(response => {
                    if(response.status === 401){
                        return response.json().then(errorData => {
                            console.log('Sesión expirada detectada:', errorData);

                            setTimeout(() => {
                                window.location.href =  '${pageContext.request.contextPath}/app/login';
                            }, 2000);

                            throw new Error('session_expired');
                        });
                        
                    }
                    if (!response.ok) {
                        throw new Error("Error al cargar las matriculasM: " + response.status);
                    }
                    return response.json();
                })
                .then(horarios => {
                    console.log('Cursos guardados:', horarios);

                    
                    if (horarios && (Array.isArray(horarios) || typeof horarios === 'object')) {
                        
                        const horariosArray = Array.isArray(horarios) ? horarios : Object.values(horarios);

                        horariosArray.forEach(horario => {
                            
                            if (!horariosSeleccionados.some(h => h.id_horario === horario.id_horario)) {
                                
                                if (!horariosOriginales.some(h => h.id_horario === horario.id_horario)) {
                                    horariosOriginales.push({...horario});
                                }

                                horariosSeleccionados.push(horario);
                            }
                        });

                       
                        actualizarTablaHorarios();
                        actualizarTablaSeleccionados();
                    }
                })
                .catch(error => {
                    console.error('Error al cargar los cursos matriculados:', error);
                });
            }

            function actualizarTablaHorarios() {
                const tabla = document.getElementById('horarios-table');
                const tbody = tabla.querySelector('tbody') || tabla.appendChild(document.createElement('tbody'));
                tbody.innerHTML = '';

                horariosOriginales.forEach(horario => {
                    
                    if (!horariosSeleccionados.some(h => h.id_horario === horario.id_horario)) {
                        
                        const cursoYaSeleccionado = horariosSeleccionados.some(h => h.id_curso === horario.id_curso);
                        addHorarioRow(tbody, horario, cursoYaSeleccionado);
                    }
                });
            }

            function actualizarTablaSeleccionados() {
                const tabla = document.getElementById('seleccionados-table');
                const tbody = tabla.querySelector('tbody') || tabla.appendChild(document.createElement('tbody'));
                tbody.innerHTML = '';

                horariosSeleccionados.forEach(horario => {
                    addHorarioSeleccionadoRow(tbody, horario);
                });
            }

            function addHorarioRow(tbody, horario, cursoYaSeleccionado) {
                
                const fila = document.createElement('tr');

                const celdaIdCurso = document.createElement('td');
                celdaIdCurso.textContent = horario.id_horario || '';
                fila.appendChild(celdaIdCurso);

                const celdaNombre = document.createElement('td');
                celdaNombre.textContent = horario.nombreC || '';
                fila.appendChild(celdaNombre);

                const celdaProfesor = document.createElement('td');
                celdaProfesor.textContent = horario.profesor || '';
                fila.appendChild(celdaProfesor);

                const celdaAula = document.createElement('td');
                celdaAula.textContent = horario.aula || '';
                fila.appendChild(celdaAula);

                const celdaDia = document.createElement('td');
                celdaDia.textContent = horario.diaH || horario.diaHora || '';
                fila.appendChild(celdaDia);

                const celdaTcupos = document.createElement('td');
                celdaTcupos.textContent = horario.capacidad || '';
                fila.appendChild(celdaTcupos);

                const celdaCupos = document.createElement('td');
                celdaCupos.textContent = horario.cupos || '';
                fila.appendChild(celdaCupos);

                const celdaAcciones = document.createElement('td');
                celdaAcciones.className = 'text-center';

                
                if (cursoYaSeleccionado) {
                    const btnDeshabilitado = document.createElement('button');
                    btnDeshabilitado.textContent = 'Curso ya seleccionado';
                    btnDeshabilitado.className = 'bg-gray-400 text-white py-1 px-3 rounded text-sm cursor-not-allowed';
                    btnDeshabilitado.disabled = true;
                    btnDeshabilitado.title = 'Ya te has matriculado en este curso con un horario diferente';
                    celdaAcciones.appendChild(btnDeshabilitado);
                } else {
                    const btnSeleccionar = document.createElement('button');
                    btnSeleccionar.textContent = 'Seleccionar';
                    btnSeleccionar.className = 'bg-brand-600 hover:bg-brand-700 text-white py-1 px-3 rounded text-sm transition duration-300';
                    btnSeleccionar.onclick = function() {
                        seleccionarHorario(horario);
                    };
                    celdaAcciones.appendChild(btnSeleccionar);
                }

                fila.appendChild(celdaAcciones);
                tbody.appendChild(fila);
            }

            function addHorarioSeleccionadoRow(tbody, horario) {
               
                const fila = document.createElement('tr');

                const celdaIdCurso = document.createElement('td');
                celdaIdCurso.textContent = horario.id_horario || '';
                fila.appendChild(celdaIdCurso);

                const celdaNombre = document.createElement('td');
                celdaNombre.textContent = horario.nombreC || '';
                fila.appendChild(celdaNombre);

                const celdaProfesor = document.createElement('td');
                celdaProfesor.textContent = horario.profesor || '';
                fila.appendChild(celdaProfesor);

                const celdaAula = document.createElement('td');
                celdaAula.textContent = horario.aula || '';
                fila.appendChild(celdaAula);

                const celdaDia = document.createElement('td');
                celdaDia.textContent = horario.diaH || horario.diaHora || '';
                fila.appendChild(celdaDia);

                const celdaTcupos = document.createElement('td');
                celdaTcupos.textContent = horario.capacidad || '';
                fila.appendChild(celdaTcupos);

                const celdaAcciones = document.createElement('td');
                celdaAcciones.className = 'text-center';
                const btnEliminar = document.createElement('button');
                btnEliminar.textContent = 'Eliminar';
                btnEliminar.className = 'bg-red-500 hover:bg-red-600 text-white py-1 px-3 rounded text-sm transition duration-300';
                btnEliminar.onclick = function() {
                    eliminarSeleccion(horario);
                };
                celdaAcciones.appendChild(btnEliminar);
                fila.appendChild(celdaAcciones);

                tbody.appendChild(fila);
            }

            function seleccionarHorario(horario) {
              
                if (horariosSeleccionados.some(h => h.id_curso === horario.id_curso)) {
                    mostrarAlerta("No puedes matricularte en el mismo curso (ID: " + horario.id_curso + ") en diferentes horarios.", "error");
                    return;
                }

                
                if (!horariosSeleccionados.some(h => h.id_horario === horario.id_horario)) {
                    horariosSeleccionados.push(horario);

                   
                    actualizarTablaHorarios();
                    actualizarTablaSeleccionados();
                }
            }

            function eliminarSeleccion(horario) {
                
                horariosSeleccionados = horariosSeleccionados.filter(h => h.id_horario !== horario.id_horario);

             
                actualizarTablaHorarios();
                actualizarTablaSeleccionados();
            }

            function completarMatricula() {
                if (horariosSeleccionados.length === 0) {
                    mostrarAlerta("No has seleccionado ningún curso para matricular.", "error");
                    return;
                }

                // Arrays para cursos seleccionados
                const idsHorariosSeleccionados = horariosSeleccionados.map(h => h.id_horario);
                const idsCursosSeleccionados = horariosSeleccionados.map(h => h.id_curso);

                // Arrays para cursos NO seleccionados
                const horariosNoSeleccionados = horariosOriginales.filter(horarioOriginal =>
                    !horariosSeleccionados.some(horarioSeleccionado =>
                        horarioSeleccionado.id_horario === horarioOriginal.id_horario
                    )
                );

                const idsHorariosNoSeleccionados = horariosNoSeleccionados.map(h => h.id_horario);
                const idsCursosNoSeleccionados = horariosNoSeleccionados.map(h => h.id_curso);

                console.log("Cursos seleccionados:", {
                    idsHorarios: idsHorariosSeleccionados,
                    idsCursos: idsCursosSeleccionados
                });
                console.log("Cursos NO seleccionados:", {
                    idsHorarios: idsHorariosNoSeleccionados,
                    idsCursos: idsCursosNoSeleccionados
                });

               
                const dataToSend = {
                    
                    cursosIds: idsHorariosSeleccionados,           
                    id_curso: idsCursosSeleccionados,              

                   
                    cursosNoSeleccionadosIds: idsHorariosNoSeleccionados,    
                    id_cursoNoSeleccionados: idsCursosNoSeleccionados       
                };

                fetch('${pageContext.request.contextPath}/controllerDataMatricularse/matricular', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'application/json'
                    },
                    body: JSON.stringify(dataToSend)
                })
                .then(response => {
                    console.log("Status de respuesta:", response.status);

                    if(response.status === 401){
                        return response.json().then(errorData => {
                            console.log('Sesión expirada detectada:', errorData);

                            setTimeout(() => {
                                window.location.href =  '${pageContext.request.contextPath}/app/login';
                            }, 2000);

                            throw new Error('session_expired');
                        });
                    }
                })
                .then(result => {
                    console.log("Resultado procesado:", result);

                    if (result.success) {
                        mostrarAlertaExito(result.message);
                    } else {
                        mostrarAlerta("Error: " + (result.error || "Error desconocido"), "error");
                    }
                })
                .catch(error => {
                    console.error("Error al procesar la matrícula:", error);
                    mostrarAlerta("Error al procesar la matrícula: " + error.message, "error");
                });
            }

            
            function mostrarAlertaExito(mensaje) {
                const overlay = document.createElement('div');
                overlay.className = 'fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50';

                const modal = document.createElement('div');
                modal.className = 'bg-white rounded-lg shadow-lg p-6 max-w-md mx-auto';

                modal.innerHTML = `
                    <div class="text-center">
                        <i class="fas fa-check-circle text-green-500 text-5xl mb-4"></i>
                        <h3 class="text-2xl font-bold text-green-700 mb-2">¡Éxito!</h3>
                        <p class="text-gray-700 mb-6">${mensaje}</p>
                        <div class="flex justify-center space-x-4">
                            <button class="bg-gray-300 hover:bg-gray-400 text-gray-800 py-2 px-4 rounded transition duration-300" id="btn-continuar">
                                Continuar matriculando
                            </button>
                            <button class="bg-brand-700 hover:bg-brand-800 text-white py-2 px-4 rounded transition duration-300" id="btn-volver">
                                Volver al inicio
                            </button>
                        </div>
                    </div>
                `;

                overlay.appendChild(modal);
                document.body.appendChild(overlay);

               
                document.getElementById('btn-continuar').addEventListener('click', function() {
                    document.body.removeChild(overlay);
                    
                    horariosSeleccionados = [];
                    loadHorarios(); 
                });

                document.getElementById('btn-volver').addEventListener('click', function() {
                    window.location.href = '${pageContext.request.contextPath}/app/inicio';
                });
            }

            function mostrarAlerta(mensaje, tipo) {
               
                const overlay = document.createElement('div');
                overlay.className = 'fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50';

                const modal = document.createElement('div');
                modal.className = 'bg-white rounded-lg shadow-lg p-6 max-w-md mx-auto';

                const iconoClase = tipo === 'error' ? 'fas fa-exclamation-circle text-red-500' : 'fas fa-check-circle text-green-500';
                const colorTitulo = tipo === 'error' ? 'text-red-700' : 'text-green-700';

                modal.innerHTML = `
                    <div class="text-center">
                        <i class="${iconoClase} text-4xl mb-4"></i>
                        <h3 class="text-xl font-bold ${colorTitulo} mb-2">Aviso</h3>
                        <p class="text-gray-700 mb-6">${mensaje}</p>
                        <button class="bg-brand-700 hover:bg-brand-800 text-white py-2 px-4 rounded transition duration-300" id="cerrar-alerta">
                            Aceptar
                        </button>
                    </div>
                `;

                overlay.appendChild(modal);
                document.body.appendChild(overlay);

                document.getElementById('cerrar-alerta').addEventListener('click', function() {
                    document.body.removeChild(overlay);
                });
            }



            document.addEventListener('DOMContentLoaded', function() {
               
                loadHorarios();

               
             document.getElementById('btn-matricular').addEventListener('click', completarMatricula);
            });
        </script>
    </body>
</html>