<%-- 
    Document   : login
    Created on : 18 may. 2025, 10:41:11 p. m.
    Author     : HP
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Intranet Sideral Carrión</title>
        <!-- Font Awesome para iconos -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 20px;
            }

            .login-container {
                display: flex;
                background: white;
                border-radius: 20px;
                box-shadow: 0 20px 40px rgba(0, 35, 51, 0.1);
                overflow: hidden;
                max-width: 900px;
                width: 100%;
                min-height: 500px;
            }

            .login-left {
                flex: 1;
                background: linear-gradient(135deg, #002333 0%, #005670 50%, #0098c1 100%);
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 40px;
                color: white;
                position: relative;
                overflow: hidden;
            }

            .login-left::before {
                content: '';
                position: absolute;
                top: -50%;
                left: -50%;
                width: 200%;
                height: 200%;
                background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="75" cy="75" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="50" cy="10" r="0.5" fill="rgba(255,255,255,0.05)"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
                animation: float 20s ease-in-out infinite;
            }

            @keyframes float {
                0%, 100% { transform: translateY(0px) rotate(0deg); }
                50% { transform: translateY(-20px) rotate(180deg); }
            }

            .school-icon {
                font-size: 120px;
                margin-bottom: 30px;
                color: #0098c1;
                text-shadow: 0 0 30px rgba(0, 152, 193, 0.5);
                z-index: 1;
                position: relative;
            }

            .welcome-text {
                text-align: center;
                z-index: 1;
                position: relative;
            }

            .welcome-text h1 {
                font-size: 2.5rem;
                font-weight: 300;
                margin-bottom: 10px;
                letter-spacing: 1px;
            }

            .welcome-text p {
                font-size: 1.1rem;
                opacity: 0.9;
                line-height: 1.6;
            }

            .login-right {
                flex: 1;
                padding: 60px 50px;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .login-header {
                text-align: center;
                margin-bottom: 40px;
            }

            .login-header h2 {
                color: #002333;
                font-size: 2rem;
                font-weight: 600;
                margin-bottom: 10px;
            }

            .login-header p {
                color: #666;
                font-size: 1rem;
            }

            .tab-selector {
                display: flex;
                background: #f8f9fa;
                border-radius: 25px;
                padding: 5px;
                margin-bottom: 30px;
                border: 1px solid #e9ecef;
            }

            .tab-button {
                flex: 1;
                padding: 12px 20px;
                border: none;
                background: transparent;
                border-radius: 20px;
                cursor: pointer;
                font-weight: 500;
                transition: all 0.3s ease;
                color: #666;
            }

            .tab-button.active {
                background: #005670;
                color: white;
                box-shadow: 0 2px 10px rgba(0, 86, 112, 0.3);
            }

            .form-group {
                margin-bottom: 25px;
                position: relative;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                color: #002333;
                font-weight: 500;
                font-size: 0.95rem;
            }

            .input-container {
                position: relative;
            }

            .input-container i {
                position: absolute;
                left: 15px;
                top: 50%;
                transform: translateY(-50%);
                color: #999;
                font-size: 1.1rem;
            }

            .form-input {
                width: 100%;
                padding: 15px 15px 15px 45px;
                border: 2px solid #e9ecef;
                border-radius: 12px;
                font-size: 1rem;
                transition: all 0.3s ease;
                background: #fafafa;
            }

            .form-input:focus {
                outline: none;
                border-color: #0098c1;
                background: white;
                box-shadow: 0 0 0 3px rgba(0, 152, 193, 0.1);
            }

            .form-input:focus + i {
                color: #0098c1;
            }

            .login-button {
                width: 100%;
                padding: 15px;
                background: linear-gradient(135deg, #005670 0%, #0098c1 100%);
                color: white;
                border: none;
                border-radius: 12px;
                font-size: 1.1rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                margin-top: 10px;
                position: relative;
                overflow: hidden;
            }

            .login-button:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 25px rgba(0, 86, 112, 0.3);
            }

            .login-button:active {
                transform: translateY(0);
            }

            .login-button::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
                transition: left 0.5s;
            }

            .login-button:hover::before {
                left: 100%;
            }

            #mensaje {
                margin-top: 20px;
                padding: 12px;
                border-radius: 8px;
                text-align: center;
                font-weight: 500;
                display: none;
                animation: slideDown 0.3s ease;
            }

            @keyframes slideDown {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .success {
                background: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }

            .error {
                background: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .login-container {
                    flex-direction: column;
                    max-width: 400px;
                }

                .login-left {
                    min-height: 200px;
                    padding: 30px;
                }

                .school-icon {
                    font-size: 80px;
                    margin-bottom: 20px;
                }

                .welcome-text h1 {
                    font-size: 1.8rem;
                }

                .login-right {
                    padding: 40px 30px;
                }

                .login-header h2 {
                    font-size: 1.5rem;
                }
            }

            .loading {
                pointer-events: none;
                opacity: 0.7;
            }

            .loading::after {
                content: '';
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                width: 20px;
                height: 20px;
                border: 2px solid transparent;
                border-top: 2px solid white;
                border-radius: 50%;
                animation: spin 1s linear infinite;
            }

            @keyframes spin {
                0% { transform: translate(-50%, -50%) rotate(0deg); }
                100% { transform: translate(-50%, -50%) rotate(360deg); }
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <!-- Lado izquierdo con diseño inspirado en la imagen -->
            <div class="login-left">
                <i class="fas fa-graduation-cap school-icon"></i>
                <div class="welcome-text">
                    <h1>Bienvenid@</h1>
                    <p>Sistema de Gestión Académica<br>Sideral Carrión</p>
                </div>
            </div>

            <!-- Lado derecho con el formulario -->
            <div class="login-right">
                <div class="login-header">
                    <h2>Iniciar Sesión</h2>
                    <p>Ingresa tus credenciales para acceder</p>
                </div>

                <!-- Selector de tipo de usuario similar a la imagen -->
                <div class="tab-selector">
                    <button class="tab-button" type="button">Profesor</button>
                    <button class="tab-button active" type="button">Estudiante</button>
                </div>

                <form id="formu" method="post">
                    <div class="form-group">
                        <label for="txt_usuario">Usuario</label>
                        <div class="input-container">
                            <input id="txt_usuario" 
                                   name="usuariox" 
                                   type="text" 
                                   class="form-input"
                                   placeholder="Nombre de usuario" 
                                   required>
                            <i class="fas fa-user"></i>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="txt_password">Contraseña</label>
                        <div class="input-container">
                            <input id="txt_password" 
                                   name="passwordx" 
                                   type="password" 
                                   class="form-input"
                                   placeholder="Contraseña" 
                                   required>
                            <i class="fas fa-lock"></i>
                        </div>
                    </div>

                    <button type="button" id="verificar" class="login-button" onclick="validacion()">
                        <i class="fas fa-sign-in-alt" style="margin-right: 8px;"></i>
                        INICIAR SESIÓN
                    </button>
                </form>

                <div id="mensaje"></div>
            </div>
        </div>

        <script>
            function validacion(){
                var usuario = document.getElementById('txt_usuario').value;
                var password = document.getElementById('txt_password').value;
                var boton = document.getElementById('verificar');
                
                if (!usuario || !password) {
                    mostrarMensaje("Por favor, complete todos los campos", "error");
                    return;
                }
                
                
                boton.classList.add('loading');
                boton.innerHTML = 'Verificando...';
                
                console.log('Verificando credenciales...');
                
                const params = new URLSearchParams();
                params.append('usuariox', usuario);
                params.append('passwordx', password);
                
                fetch('${pageContext.request.contextPath}/controllerDataLogin/alumno', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                        'Accept': 'application/json'
                    },
                    body: params.toString() 
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Error al verificar credenciales.');
                    }
                    return response.json();
                })
                .then(data => {
                    console.log('Respuesta del servidor:', data);
                    if (data.id_alumno > 0) {
                        mostrarMensaje("Acceso concedido. Redirigiendo...", "success");
                        console.log('Alumno logueado: ',data.id_alumno);
                        sessionStorage.setItem('id_alumno', data.id_alumno);
                       
                        setTimeout(() => {
                            window.location.href = '${pageContext.request.contextPath}/app/inicio';
                        }, 1500);
                    } else {
                        mostrarMensaje("Usuario o contraseña incorrectos", "error");
                        console.log('El valor de data.id_alumno: ',data.id_alumno);
                        resetButton();
                    }
                })
                .catch(error => {
                    console.error('Error en la solicitud:', error);
                    mostrarMensaje("Error de conexión: " + error.message, "error");
                    resetButton();
                });
            }
            
            function resetButton() {
                var boton = document.getElementById('verificar');
                boton.classList.remove('loading');
                boton.innerHTML = '<i class="fas fa-sign-in-alt" style="margin-right: 8px;"></i>INICIAR SESIÓN';
            }
            
            function mostrarMensaje(texto, tipo) {
                const mensaje = document.getElementById('mensaje');
                mensaje.textContent = texto;
                mensaje.style.display = 'block';
                mensaje.className = tipo;
                
                setTimeout(() => {
                    mensaje.style.display = 'none';
                }, 5000);
            }

           
            document.querySelectorAll('.tab-button').forEach(button => {
                button.addEventListener('click', function() {
                    document.querySelectorAll('.tab-button').forEach(b => b.classList.remove('active'));
                    this.classList.add('active');
                });
            });

            
            document.addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    validacion();
                }
            });
        </script>
    </body>
</html>