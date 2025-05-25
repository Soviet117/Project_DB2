<%-- 
    Document   : inicio
    Created on : 17 may. 2025, 1:25:22 p. m.
    Author     : HP
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Intranet - Página Principal</title>
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
        
        <div class="container mx-auto px-4 py-8">
            <h1 class="text-3xl font-bold text-brand-700 mb-6">Pantalla Principal</h1>
            
            <!-- Contenido principal -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                <!-- Tarjeta de información 1 -->
                <div class="bg-white rounded-lg shadow-md p-6 border-t-4 border-brand-500">
                    <h2 class="text-xl font-semibold text-brand-900 mb-3">Novedades</h2>
                    <p class="text-gray-600">Encuentra aquí las últimas novedades y anuncios importantes.</p>
                </div>
                
                <!-- Tarjeta de información 2 -->
                <div class="bg-white rounded-lg shadow-md p-6 border-t-4 border-brand-700">
                    <h2 class="text-xl font-semibold text-brand-900 mb-3">Calendario Académico</h2>
                    <p class="text-gray-600">Consulta las fechas importantes del período académico actual.</p>
                </div>
                
                <!-- Tarjeta de información 3 -->
                <div class="bg-white rounded-lg shadow-md p-6 border-t-4 border-brand-900">
                    <h2 class="text-xl font-semibold text-brand-900 mb-3">Enlaces Rápidos</h2>
                    <p class="text-gray-600">Accede rápidamente a las herramientas y recursos más utilizados.</p>
                </div>
            </div>
        </div>
    </body>
</html>