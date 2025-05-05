<%--
    Document   : matricula
    Created on : 26 abr. 2025, 4:10:01 p. m.
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Actualización de Datos</title>
    </head>
    <body>
        <h1>Estas en matricula para que actualices tus datos</h1>

        <div id="mensaje-actualizacion" style=" color: green; font-weight: bold; margin-top: 10px;">Cargando datos del alumno...</div>

        <form id="formulario-matricula">
            <label for="dniI">Documento Nacional de Identidad</label>
            <input type="text" id="dniI" name="dniN" required><br><br>

            <label for="nombreI">Nombre</label>
            <input type="text" id="nombreI" name="nombreN" required><br><br>

            <label for="apellidoI">Apellidos</label>
            <input type="text" id="apellidoI" name="apellidoN" required><br><br>

            <label for="fechanI">Fecha de nacimiento</label>
            <input type="date" id="fechanI" name="fechanN" required><br><br>

            <label for="numerotI">Número de celular</label>
            <input type="text" id="numerotI" name="numerotN" pattern="[0-9]+" title ="Ingrese solo numeros"><br><br>

            <label for="direccionI">Dirección</label>
            <input type="text" id="direccionI" name="direccionN" required><br><br>

            <label for="correoI">Correo personal</label>
            <input type="text" id="correoI" name="correoN" required>
            <button type="button" name="name">Enviar codigo de verificación</button> <br><br>

            <label for="codigoVI">Ingrese el codigo de verificacción</label>
            <input type="text" id="codigoVI" name="codigoVN" required><br><br>

            
        </form><br>
        <button  onclick="actualizarDatos()">Actualizar datos</button>
        
        <button type="button" onclick="verificarEstadoYRedirigir()">Verificar Estado y Continuar</button>
        
        
        <input type="text" id="depurar">

        <script>
            
            function cargarDatosAlumno() {
                fetch('${pageContext.request.contextPath}/controllerDataMatricula/sendAlumno', {
                    method: 'GET',
                    headers: {
                        'Accept': 'application/json'
                    }
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Error al cargar los datos del alumno: ' + response.status);
                    }
                    return response.json();
                })
                .then(alumno => {
                    
                    const depurar = document.getElementById('depurar');
                    depurar.value = alumno.estado;
                    
                    document.getElementById('dniI').value = alumno.dni;
                    document.getElementById('nombreI').value = alumno.nombres;
                    document.getElementById('apellidoI').value = alumno.apellidos;
                    document.getElementById('fechanI').value = alumno.fecha_n;
                    document.getElementById('numerotI').value = alumno.numeroT;
                    document.getElementById('direccionI').value = alumno.direccion;
                    document.getElementById('correoI').value = alumno.correo;

                   
                    const numeroTInput = document.getElementById('numerotI');
                    if (alumno.estado === 'ACTUALIZADO') {
                        numeroTInput.readOnly = true;
                        numeroTInput.value = alumno.numeroT;
                    } else if (alumno.estado === 'DESACTUALIZADO') {
                        
                        numeroTInput.placeholder = alumno.numeroT;
                        
                    }

                    const direccionInput = document.getElementById('direccionI');
                    if (alumno.estado === 'ACTUALIZADO') {
                        direccionInput.readOnly = true;
                        direccionInput.value = alumno.direccion;
                    } else if (alumno.estado === 'DESACTUALIZADO') {
                        direccionInput.placeholder = alumno.direccion;
                    }

                    const correoInput = document.getElementById('correoI');
                    if (alumno.estado === 'ACTUALIZADO') {
                        correoInput.readOnly = true;
                        correoInput.value = alumno.correo;
                    } else if (alumno.estado === 'DESACTUALIZADO') {
                        correoInput.placeholder = alumno.correo;
                    }
                    const cargar = document.getElementById('mensaje-actualizacion');
                    cargar.style.display = 'none';
                   
                })
                .catch(error => {
                    console.error('Error al cargar los datos:', error);
                    const mensajeDiv = document.getElementById('mensaje-actualizacion');
                    mensajeDiv.textContent = error.message;
                    mensajeDiv.style.color = 'red';
                    mensajeDiv.style.display = 'block';
                });
            }

            function actualizarDatos() {
                event.preventDefault();

                const mensajeDiv = document.getElementById('mensaje-actualizacion');
                mensajeDiv.textContent = 'Actualizando datos...';
                mensajeDiv.style.color = 'blue';
                mensajeDiv.style.display = 'block';

                const form = document.getElementById('formulario-matricula');
                const formData = new FormData(form);
                const formDataObj = {};
                
               
                formData.forEach((value, key) => {
                    formDataObj[key] = value;
                });
                
                const formDataString = new URLSearchParams(formDataObj).toString();
                console.log("Datos a enviar:", formDataString);

                fetch('${pageContext.request.contextPath}/controllerDataMatricula/sendAlumno', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                        'Accept': 'application/json'
                    },
                    body: formDataString
                })
                .then(response => {
                    console.log("Status:", response.status);
                    console.log("Headers:", response.headers);
                    if (!response.ok) {
                        return response.text().then(text => {
                            console.error("Response body:", text);
                            try {
                                return JSON.parse(text);
                            } catch (e) {
                                throw new Error('Error al actualizar los datos: ' + response.status + ' - Respuesta no es JSON válido');
                            }
                        });
                    }
                    return response.json();
                })
                .then(data => {
                    console.log("Response data:", data);
                    mensajeDiv.textContent = data.mensaje;
                    mensajeDiv.style.color = data.status === 'success' ? 'green' : 'red';
                    mensajeDiv.style.display = 'block';
                })
                .catch(error => {
                    console.error('Error al actualizar los datos:', error);
                    mensajeDiv.textContent = 'Error al conectar con el servidor: ' + error.message;
                    mensajeDiv.style.color = 'red';
                    mensajeDiv.style.display = 'block';
                });
            }
        
            
            function verificarEstadoYRedirigir(){
                event.preventDefault();
                
                fetch('${pageContext.request.contextPath}/controllerDataMatricula/confirmEstado',{
                    method: 'GET',
                    headers: {
                        'Accept': 'application/json'
                    }
                })
                .then(response =>{
                    if(!response.ok){
                        throw new Error('Error al consultar estado: '+response.status);
                    }
                    return response.json();
                })
                .then(data =>{
                    if(data.status === 'ACTUALIZADO'){
                        window.location.href = '${pageContext.request.contextPath}/app/matricularse';
                    } else if (data.status === 'DESACTUALIZADO') {
                        const mensajeDiv = document.getElementById('mensaje-actualizacion');
                        mensajeDiv.textContent = data.mensaje;
                        mensajeDiv.style.color = 'red';
                        mensajeDiv.style.display = 'block';
                    } else {
                        const mensajeDiv = document.getElementById('mensaje-actualizacion');
                        mensajeDiv.textContent = 'Error al verificar el estado.';
                        mensajeDiv.style.color = 'red';
                        mensajeDiv.style.display = 'block';
                    }
                }).catch(error =>{
                    console.error('Error al verificar el estado:', error);
                    const mensajeDiv = document.getElementById('mensaje-actualizacion');
                    mensajeDiv.textContent = error.message;
                    mensajeDiv.style.color = 'red';
                    mensajeDiv.style.display = 'block';
                });
                
            }
            
            document.addEventListener('DOMContentLoaded', cargarDatosAlumno);
        </script>
    </body>
</html>