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
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Actualización de Datos</title>
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
                                900: '#002333', // oscuro
                                800: '#00384d',
                                700: '#005670', 
                                600: '#007699',
                                500: '#0098c1'  // claro
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
                <h1 class="text-3xl font-bold text-brand-900 mb-2">Actualización de Datos de Matricula</h1>
                <div class="h-1 w-40 bg-brand-500"></div>
            </div>

            <div id="mensaje-actualizacion" class="bg-blue-100 border-l-4 border-blue-500 text-blue-700 p-4 mb-6 rounded shadow-md hidden">
                <p class="flex items-center">
                    <i class="fas fa-info-circle mr-2"></i>
                    <span>Cargando datos del alumno...</span>
                </p>
            </div>

            <div class="bg-white rounded-lg shadow-md p-6 mb-8">
                <h2 class="text-xl font-semibold text-brand-700 mb-4 flex items-center">
                    <i class="fas fa-user-edit mr-2"></i>Información Personal
                </h2>

                <form id="formulario-matricula" class="space-y-6">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <!-- DNI -->
                        <div class="space-y-2">
                            <label for="dniI" class="block text-sm font-medium text-gray-700">
                                Documento Nacional de Identidad
                            </label>
                            <input type="text" id="dniI" name="dniN" required
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-brand-500 focus:border-brand-500 bg-gray-100"
                                   readonly>
                        </div>

                        <!-- Nombre -->
                        <div class="space-y-2">
                            <label for="nombreI" class="block text-sm font-medium text-gray-700">
                                Nombre
                            </label>
                            <input type="text" id="nombreI" name="nombreN" required
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-brand-500 focus:border-brand-500 bg-gray-100"
                                   readonly>
                        </div>

                        <!-- Apellidos -->
                        <div class="space-y-2">
                            <label for="apellidoI" class="block text-sm font-medium text-gray-700">
                                Apellidos
                            </label>
                            <input type="text" id="apellidoI" name="apellidoN" required
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-brand-500 focus:border-brand-500 bg-gray-100"
                                   readonly>
                        </div>

                        <!-- Fecha de nacimiento -->
                        <div class="space-y-2">
                            <label for="fechanI" class="block text-sm font-medium text-gray-700">
                                Fecha de nacimiento
                            </label>
                            <input type="date" id="fechanI" name="fechanN" required
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-brand-500 focus:border-brand-500 bg-gray-100"
                                   readonly>
                        </div>

                        <!-- Número de celular -->
                        <div class="space-y-2">
                            <label for="numerotI" class="block text-sm font-medium text-gray-700">
                                Número de celular
                            </label>
                            <input type="text" id="numerotI" name="numerotN" pattern="[0-9]+" title ="Ingrese solo numeros"
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-brand-500 focus:border-brand-500">
                        </div>

                        <!-- Dirección -->
                        <div class="space-y-2">
                            <label for="direccionI" class="block text-sm font-medium text-gray-700">
                                Dirección
                            </label>
                            <input type="text" id="direccionI" name="direccionN" required
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-brand-500 focus:border-brand-500">
                        </div>
                    </div>
                    
                    <!-- Correo y verificación -->
                    <div class="space-y-2">
                        <label for="correoI" class="block text-sm font-medium text-gray-700">
                            Correo personal
                        </label>
                        <div class="flex space-x-2">
                            <input type="email" id="correoI" name="correoN" required
                                   class="flex-1 px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-brand-500 focus:border-brand-500">
                            <button type="button" name="name" 
                                    class="bg-brand-600 hover:bg-brand-700 text-white px-4 py-2 rounded-md text-sm font-medium transition duration-300">
                                <i class="fas fa-envelope mr-1"></i> Enviar código
                            </button>
                        </div>
                    </div>

                    <div class="space-y-2">
                        <label for="codigoVI" class="block text-sm font-medium text-gray-700">
                            Ingrese el código de verificación
                        </label>
                        <input type="text" id="codigoVI" name="codigoVN" required
                               class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-brand-500 focus:border-brand-500">
                    </div>
                </form>
                
                <div class="mt-8 flex flex-wrap gap-4">
                    <button onclick="actualizarDatos()" 
                            class="bg-brand-700 hover:bg-brand-800 text-white font-medium py-2 px-6 rounded-lg shadow-md transition duration-300 ease-in-out flex items-center">
                        <i class="fas fa-save mr-2"></i> Actualizar datos
                    </button>
                    
                    <button type="button" onclick="verificarEstadoYRedirigir()" 
                            class="bg-brand-500 hover:bg-brand-600 text-white font-medium py-2 px-6 rounded-lg shadow-md transition duration-300 ease-in-out flex items-center">
                        <i class="fas fa-check-circle mr-2"></i> Verificar y continuar
                    </button>
                </div>
            </div>
            
            <!-- Campo oculto para depurar -->
            <input type="hidden" id="depurar">
        </div>

        <script>
            function cargarDatosAlumno() {
                const mensajeDiv = document.getElementById('mensaje-actualizacion');
                mensajeDiv.classList.remove('hidden');
                mensajeDiv.classList.remove('bg-green-100', 'border-green-500', 'text-green-700', 'bg-red-100', 'border-red-500', 'text-red-700');
                mensajeDiv.classList.add('bg-blue-100', 'border-blue-500', 'text-blue-700');
                mensajeDiv.querySelector('span').textContent = 'Cargando datos del alumno...';
                mensajeDiv.querySelector('i').className = 'fas fa-spinner fa-spin mr-2';
                
                fetch('${pageContext.request.contextPath}/controllerDataMatricula/sendAlumno', {
                    method: 'GET',
                    headers: {
                        'Accept': 'application/json'
                    }
                })
                .then(response => {
                    if(response.status === 401){
                        setTimeout(() => {
                                window.location.href = '${pageContext.request.contextPath}/app/login';
                            }, 2000);

                        throw new Error('session_expired');
                    }
                    
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
                        numeroTInput.classList.add('bg-gray-100');
                    } else if (alumno.estado === 'DESACTUALIZADO') {
                        numeroTInput.placeholder = alumno.numeroT;
                    }

                    const direccionInput = document.getElementById('direccionI');
                    if (alumno.estado === 'ACTUALIZADO') {
                        direccionInput.readOnly = true;
                        direccionInput.value = alumno.direccion;
                        direccionInput.classList.add('bg-gray-100');
                    } else if (alumno.estado === 'DESACTUALIZADO') {
                        direccionInput.placeholder = alumno.direccion;
                    }

                    const correoInput = document.getElementById('correoI');
                    if (alumno.estado === 'ACTUALIZADO') {
                        correoInput.readOnly = true;
                        correoInput.value = alumno.correo;
                        correoInput.classList.add('bg-gray-100');
                        
                        const btnEnviarCodigo = correoInput.nextElementSibling;
                        btnEnviarCodigo.disabled = true;
                        btnEnviarCodigo.classList.remove('bg-brand-600', 'hover:bg-brand-700');
                        btnEnviarCodigo.classList.add('bg-gray-300', 'cursor-not-allowed');
                        
                        const codigoVInput = document.getElementById('codigoVI');
                        codigoVInput.readOnly = true;
                        codigoVInput.classList.add('bg-gray-100');
                    } else if (alumno.estado === 'DESACTUALIZADO') {
                        correoInput.placeholder = alumno.correo;
                    }
                    
                    mensajeDiv.classList.remove('bg-blue-100', 'border-blue-500', 'text-blue-700');
                    if (alumno.estado === 'ACTUALIZADO') {
                        mensajeDiv.classList.add('bg-green-100', 'border-green-500', 'text-green-700');
                        mensajeDiv.querySelector('span').textContent = 'Sus datos están actualizados. Puede proceder a la matrícula.';
                        mensajeDiv.querySelector('i').className = 'fas fa-check-circle mr-2';
                    } else {
                        mensajeDiv.classList.add('bg-yellow-100', 'border-yellow-500', 'text-yellow-700');
                        mensajeDiv.querySelector('span').textContent = 'Debe actualizar sus datos para continuar con la matrícula.';
                        mensajeDiv.querySelector('i').className = 'fas fa-exclamation-triangle mr-2';
                    }
                })
                .catch(error => {
                    console.error('Error al cargar los datos:', error);
                    mensajeDiv.classList.remove('bg-blue-100', 'border-blue-500', 'text-blue-700');
                    mensajeDiv.classList.add('bg-red-100', 'border-red-500', 'text-red-700');
                    mensajeDiv.querySelector('span').textContent = error.message;
                    mensajeDiv.querySelector('i').className = 'fas fa-times-circle mr-2';
                });
            }

            function actualizarDatos() {
                event.preventDefault();

                const mensajeDiv = document.getElementById('mensaje-actualizacion');
                mensajeDiv.classList.remove('hidden', 'bg-green-100', 'border-green-500', 'text-green-700', 'bg-red-100', 'border-red-500', 'text-red-700');
                mensajeDiv.classList.add('bg-blue-100', 'border-blue-500', 'text-blue-700');
                mensajeDiv.querySelector('span').textContent = 'Actualizando datos...';
                mensajeDiv.querySelector('i').className = 'fas fa-spinner fa-spin mr-2';

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
                        throw new Error('Error al actualizar los datos: ' + response.status + ' - Respuesta no es JSON válido');
                            
                    }
                    return response.json();
                })
                .then(data => {
                    console.log("Response data:", data);
                    mensajeDiv.classList.remove('bg-blue-100', 'border-blue-500', 'text-blue-700');
                    
                    if (data.status === 'success') {
                        mensajeDiv.classList.add('bg-green-100', 'border-green-500', 'text-green-700');
                        mensajeDiv.querySelector('i').className = 'fas fa-check-circle mr-2';
                    } else {
                        mensajeDiv.classList.add('bg-red-100', 'border-red-500', 'text-red-700');
                        mensajeDiv.querySelector('i').className = 'fas fa-times-circle mr-2';
                    }
                    
                    mensajeDiv.querySelector('span').textContent = data.mensaje;
                })
                .catch(error => {
                    console.error('Error al actualizar los datos:', error);
                    mensajeDiv.classList.remove('bg-blue-100', 'border-blue-500', 'text-blue-700');
                    mensajeDiv.classList.add('bg-red-100', 'border-red-500', 'text-red-700');
                    mensajeDiv.querySelector('span').textContent = 'Error al conectar con el servidor: ' + error.message;
                    mensajeDiv.querySelector('i').className = 'fas fa-times-circle mr-2';
                });
            }
         
            function verificarEstadoYRedirigir(){
                event.preventDefault();
                
                const mensajeDiv = document.getElementById('mensaje-actualizacion');
                mensajeDiv.classList.remove('hidden', 'bg-green-100', 'border-green-500', 'text-green-700', 'bg-red-100', 'border-red-500', 'text-red-700');
                mensajeDiv.classList.add('bg-blue-100', 'border-blue-500', 'text-blue-700');
                mensajeDiv.querySelector('span').textContent = 'Verificando estado...';
                mensajeDiv.querySelector('i').className = 'fas fa-spinner fa-spin mr-2';
                
                fetch('${pageContext.request.contextPath}/controllerDataMatricula/confirmEstado',{
                    method: 'GET',
                    headers: {
                        'Accept': 'application/json'
                    }
                })
                .then(response =>{
                    if(response.status === 401){
                        return response.json().then(errorData => {
                            console.log('Sesión expirada detectada:', errorData);

                            setTimeout(() => {
                                window.location.href = '${pageContext.request.contextPath}/app/login';
                            }, 2000);

                            throw new Error('session_expired');
                        });
                        
                    }
                    if(!response.ok){
                        throw new Error('Error al consultar estado: '+response.status);
                    }
                    return response.json();
                })
                .then(data =>{
                    if(data.status === 'ACTUALIZADO'){

                        mensajeDiv.classList.remove('bg-blue-100', 'border-blue-500', 'text-blue-700');
                        mensajeDiv.classList.add('bg-green-100', 'border-green-500', 'text-green-700');
                        mensajeDiv.querySelector('i').className = 'fas fa-check-circle mr-2';
                        mensajeDiv.querySelector('span').textContent = 'Datos verificados correctamente. Redirigiendo...';
                        
                        setTimeout(() => {
                            window.location.href = '${pageContext.request.contextPath}/app/matricularse';
                        }, 1500);
                    } else if (data.status === 'DESACTUALIZADO') {
                        mensajeDiv.classList.remove('bg-blue-100', 'border-blue-500', 'text-blue-700');
                        mensajeDiv.classList.add('bg-red-100', 'border-red-500', 'text-red-700');
                        mensajeDiv.querySelector('i').className = 'fas fa-exclamation-triangle mr-2';
                        mensajeDiv.querySelector('span').textContent = data.mensaje;
                    } else {
                        mensajeDiv.classList.remove('bg-blue-100', 'border-blue-500', 'text-blue-700');
                        mensajeDiv.classList.add('bg-red-100', 'border-red-500', 'text-red-700');
                        mensajeDiv.querySelector('i').className = 'fas fa-times-circle mr-2';
                        mensajeDiv.querySelector('span').textContent = 'Error al verificar el estado.';
                    }
                }).catch(error =>{
                    console.error('Error al verificar el estado:', error);
                    mensajeDiv.classList.remove('bg-blue-100', 'border-blue-500', 'text-blue-700');
                    mensajeDiv.classList.add('bg-red-100', 'border-red-500', 'text-red-700');
                    mensajeDiv.querySelector('i').className = 'fas fa-times-circle mr-2';
                    mensajeDiv.querySelector('span').textContent = error.message;
                });
            }
            
            document.addEventListener('DOMContentLoaded', cargarDatosAlumno);
        </script>
    </body>
</html>