<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
    <nav class="bg-gradient-to-r from-brand-900 to-brand-700">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <div class="flex items-center">
                    <div class="flex-shrink-0 flex items-center">
                        <span class="text-white font-bold text-xl">Intranet</span>
                    </div>
                    <div class="hidden md:ml-6 md:flex md:space-x-4">
                        <a href="${pageContext.request.contextPath}/app/inicio" 
                           class="${seccion == 'inicio' ? 'bg-brand-500 text-white' : 'text-gray-200 hover:bg-brand-600'} px-3 py-2 rounded-md text-sm font-medium transition duration-150 ease-in-out">
                            <i class="fas fa-home mr-1"></i> Inicio
                        </a>
                        <a href="${pageContext.request.contextPath}/app/matricula" 
                           class="${seccion == 'matricula' ? 'bg-brand-500 text-white' : 'text-gray-200 hover:bg-brand-600'} px-3 py-2 rounded-md text-sm font-medium transition duration-150 ease-in-out">
                            <i class="fas fa-user-graduate mr-1"></i> Matrícula
                        </a>
                        <a href="${pageContext.request.contextPath}/app/horario" 
                           class="${seccion == 'horario' ? 'bg-brand-500 text-white' : 'text-gray-200 hover:bg-brand-600'} px-3 py-2 rounded-md text-sm font-medium transition duration-150 ease-in-out">
                            <i class="fas fa-calendar-alt mr-1"></i> Horario
                        </a>
                        <a href="${pageContext.request.contextPath}/app/notas" 
                           class="${seccion == 'notas' ? 'bg-brand-500 text-white' : 'text-gray-200 hover:bg-brand-600'} px-3 py-2 rounded-md text-sm font-medium transition duration-150 ease-in-out">
                            <i class="fas fa-book mr-1"></i> Notas
                        </a>
                    </div>
                </div>
                <div class="flex items-center">
                    <a href="${pageContext.request.contextPath}/app/login" 
                       class="text-gray-200 hover:bg-brand-800 px-3 py-2 rounded-md text-sm font-medium transition duration-150 ease-in-out">
                        <i class="fas fa-sign-out-alt mr-1"></i> Salir
                    </a>
                </div>
            </div>
            
            <!-- Menú móvil -->
            <div class="md:hidden">
                <div class="px-2 pt-2 pb-3 space-y-1">
                    <a href="${pageContext.request.contextPath}/app/inicio" 
                       class="${seccion == 'inicio' ? 'bg-brand-500 text-white' : 'text-gray-200 hover:bg-brand-600'} block px-3 py-2 rounded-md text-base font-medium">
                        <i class="fas fa-home mr-1"></i> Inicio
                    </a>
                    <a href="${pageContext.request.contextPath}/app/matricula" 
                       class="${seccion == 'matricula' ? 'bg-brand-500 text-white' : 'text-gray-200 hover:bg-brand-600'} block px-3 py-2 rounded-md text-base font-medium">
                        <i class="fas fa-user-graduate mr-1"></i> Matrícula
                    </a>
                    <a href="${pageContext.request.contextPath}/app/horario" 
                       class="${seccion == 'horario' ? 'bg-brand-500 text-white' : 'text-gray-200 hover:bg-brand-600'} block px-3 py-2 rounded-md text-base font-medium">
                        <i class="fas fa-calendar-alt mr-1"></i> Horario
                    </a>
                    <a href="${pageContext.request.contextPath}/app/notas" 
                       class="${seccion == 'notas' ? 'bg-brand-500 text-white' : 'text-gray-200 hover:bg-brand-600'} block px-3 py-2 rounded-md text-base font-medium">
                        <i class="fas fa-book mr-1"></i> Notas
                    </a>
                    <a href="${pageContext.request.contextPath}/app/login" 
                       class="text-gray-200 hover:bg-brand-800 block px-3 py-2 rounded-md text-base font-medium">
                        <i class="fas fa-sign-out-alt mr-1"></i> Salir
                    </a>
                </div>
            </div>
        </div>  
    </nav>
</div>