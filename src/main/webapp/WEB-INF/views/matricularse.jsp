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
        <title>Matricula</title>
        
    </head>
    <body>
        <h1>A matricularse</h1><br>
        <h2>Cursos disponibles</h2>
        <table id="horarios-table">
            <tr>
                <th>ID Curso</th>
                <th>Nombre</th>
                <th>Profesor</th>
                <th>Aula</th>
                <th>Horario</th>
                <th>Total de Cupos</th>
                <th>Cupos Disponibles</th>
                <th>Acciones</th>
            </tr>
        </table>

        <h2>Cursos seleccionados</h2>
        <table id="seleccionados-table">
            <tr>
                <th>ID Curso</th>
                <th>Nombre</th>
                <th>Profesor</th>
                <th>Aula</th>
                <th>Horario</th>
                <th>Total de Cupos</th>
                <th>Acción</th>                
            </tr>
        </table>
        
        <button id="btn-matricular" class="btn-matricular">Completar Matrícula</button>
        
    <script>
        let horariosOriginales = [];
        let horariosSeleccionados = [];
        
        function loadHorarios(){
            fetch('${pageContext.request.contextPath}/controllerDataMatricularse/viewHorariosM',{
                method: 'GET',
                headers: {
                    'Accept' : 'application/json'
                }
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error("Error al cargar las matriculas: " + response.status);
                }
                return response.json();
            })
            .then(horarios => {
                if (Array.isArray(horarios)) {
                    horariosOriginales = [...horarios];
                } else if (typeof horarios === 'object') {
                    horariosOriginales = Object.values(horarios);
                }
                
                actualizarTablaHorarios();
            })
            .catch(error => {
                console.error('Error al cargar los datos:', error);
            });
        }
        
        function actualizarTablaHorarios() {
            const tabla = document.getElementById('horarios-table');
            
            while (tabla.rows.length > 1) {
                tabla.deleteRow(1);
            }
            
            horariosOriginales.forEach(horario => {
                if (!horariosSeleccionados.some(h => h.id_curso === horario.id_curso)) {
                    addHorarioRow(tabla, horario);
                }
            });
        }
        
        function actualizarTablaSeleccionados() {
            const tabla = document.getElementById('seleccionados-table');
            
            while (tabla.rows.length > 1) {
                tabla.deleteRow(1);
            }
            
            horariosSeleccionados.forEach(horario => {
                addHorarioSeleccionadoRow(tabla, horario);
            });
        }
        
        function addHorarioRow(tabla, horario) {
            const fila = tabla.insertRow();
            
            const celdaIdCurso = fila.insertCell();
            celdaIdCurso.textContent = horario.id_curso || '';
            
            const celdaNombre = fila.insertCell();
            celdaNombre.textContent = horario.nombreC || '';
            
            const celdaProfesor = fila.insertCell();
            celdaProfesor.textContent = horario.profesor || '';
            
            const celdaAula = fila.insertCell();
            celdaAula.textContent = horario.aula || '';
            
            const celdaDia = fila.insertCell();
            celdaDia.textContent = horario.diaH || horario.diaHora || '';
            
            const celdaTcupos = fila.insertCell();
            celdaTcupos.textContent = horario.capacidad || '';
            
            const celdaCupos = fila.insertCell();
            celdaCupos.textContent = horario.cupos || '';
            
            const celdaAcciones = fila.insertCell();
            const btnSeleccionar = document.createElement('button');
            btnSeleccionar.textContent = 'Seleccionar';
            btnSeleccionar.className = 'btn-seleccionar';
            btnSeleccionar.onclick = function() {
                // agregar a seleccionados y eliminar de disponibles
                seleccionarHorario(horario);
            };
            celdaAcciones.appendChild(btnSeleccionar);
        }
        
        function addHorarioSeleccionadoRow(tabla, horario) {
            const fila = tabla.insertRow();
            
            const celdaIdCurso = fila.insertCell();
            celdaIdCurso.textContent = horario.id_curso || '';
            
            const celdaNombre = fila.insertCell();
            celdaNombre.textContent = horario.nombreC || '';
            
            const celdaProfesor = fila.insertCell();
            celdaProfesor.textContent = horario.profesor || '';
            
            const celdaAula = fila.insertCell();
            celdaAula.textContent = horario.aula || '';
            
            const celdaDia = fila.insertCell();
            celdaDia.textContent = horario.diaH || horario.diaHora || '';
            
            const celdaTcupos = fila.insertCell();
            celdaTcupos.textContent = horario.capacidad || '';
            
            const celdaAcciones = fila.insertCell();
            const btnEliminar = document.createElement('button');
            btnEliminar.textContent = 'Eliminar';
            btnEliminar.className = 'btn-eliminar';
            btnEliminar.onclick = function() {
               
                eliminarSeleccion(horario);
            };
            celdaAcciones.appendChild(btnEliminar);
        }
        
        function seleccionarHorario(horario) {
          
            horariosSeleccionados.push(horario);
         
            actualizarTablaHorarios();
            actualizarTablaSeleccionados();
        }
        
        function eliminarSeleccion(horario) {
            
            horariosSeleccionados = horariosSeleccionados.filter(h => h.id_curso !== horario.id_curso);
          
            actualizarTablaHorarios();
            actualizarTablaSeleccionados();
        }
        
       
        function completarMatricula() {
            if (horariosSeleccionados.length === 0) {
                alert("No has seleccionado ningún curso para matricular.");
                return;
            }
            
            
            const cursosIds = horariosSeleccionados.map(h => h.id_curso);
            
            alert("Completando matrícula para los cursos: " + 
                  horariosSeleccionados.map(h => h.nombreC).join(", ") + 
                  "\nIDs: " + cursosIds.join(", "));
            
            
            fetch('${pageContext.request.contextPath}/controllerDataMatricularse/matricular', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                },
                body: JSON.stringify({ cursosIds: cursosIds })
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error("Error al procesar la matrícula: " + response.status);
                }
                return response.json();
            })
            .then(result => {
                alert("Matrícula completada con éxito!");
                
                horariosSeleccionados = [];
                
                loadHorarios();
            })
            .catch(error => {
                console.error("Error al procesar la matrícula:", error);
                alert("Error al procesar la matrícula: " + error.message);
            });
            
        }
        
        
        document.addEventListener('DOMContentLoaded', loadHorarios);
        
        document.getElementById('btn-matricular').addEventListener('click', completarMatricula);
    </script>
    </body>
</html>