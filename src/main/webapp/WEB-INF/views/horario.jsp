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
        <title>Intranet Berraco </title>
        <style>
            table {
                border-collapse: collapse;
                width: 100%;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: center;
            }
            th {
                background-color: #f2f2f2;
            }
            .curso {
                background-color: #e6f2ff;
                border-radius: 4px;
                padding: 5px;
                margin: 2px;
                font-size: 0.85em;
            }
        </style>
    </head>
    <body>
        <h1>Horario</h1>
        <input id="depuracion">
        
        <table id="horarioTable">
            <thead>
                <tr>
                <th>Hora</th>
                <th>Lunes</th>
                <th>Martes</th>
                <th>Miercoles</th>
                <th>Jueves</th>
                <th>Viernes</th>
                <th>Sabado</th>
            </tr>
            </thead>
            <tbody>
                <tr>
                    <td>07:00 - 08:20</td>
                    <td data-hora="1" data-dia="1"></td>
                    <td data-hora="1" data-dia="2"></td>
                    <td data-hora="1" data-dia="3"></td>
                    <td data-hora="1" data-dia="4"></td>
                    <td data-hora="1" data-dia="5"></td>
                    <td data-hora="1" data-dia="6"></td>
                </tr>
                <tr>
                    <td>08:30 - 10:00</td>
                    <td data-hora="2" data-dia="1"></td>
                    <td data-hora="2" data-dia="2"></td>
                    <td data-hora="2" data-dia="3"></td>
                    <td data-hora="2" data-dia="4"></td>
                    <td data-hora="2" data-dia="5"></td>
                    <td data-hora="2" data-dia="6"></td>
                </tr>
                <tr>
                    <td>10:10 - 11:45</td>
                    <td data-hora="3" data-dia="1"></td>
                    <td data-hora="3" data-dia="2"></td>
                    <td data-hora="3" data-dia="3"></td>
                    <td data-hora="3" data-dia="4"></td>
                    <td data-hora="3" data-dia="5"></td>
                    <td data-hora="3" data-dia="6"></td>
                </tr>
                <tr>
                    <td>12:00 - 13:30</td>
                    <td data-hora="4" data-dia="1"></td>
                    <td data-hora="4" data-dia="2"></td>
                    <td data-hora="4" data-dia="3"></td>
                    <td data-hora="4" data-dia="4"></td>
                    <td data-hora="4" data-dia="5"></td>
                    <td data-hora="4" data-dia="6"></td>
                </tr>
                <tr>
                    <td>14:00 - 15:30</td>
                    <td data-hora="5" data-dia="1"></td>
                    <td data-hora="5" data-dia="2"></td>
                    <td data-hora="5" data-dia="3"></td>
                    <td data-hora="5" data-dia="4"></td>
                    <td data-hora="5" data-dia="5"></td>
                    <td data-hora="5" data-dia="6"></td>
                </tr>
                <tr>
                    <td>15:45 - 17:15</td>
                    <td data-hora="6" data-dia="1"></td>
                    <td data-hora="6" data-dia="2"></td>
                    <td data-hora="6" data-dia="3"></td>
                    <td data-hora="6" data-dia="4"></td>
                    <td data-hora="6" data-dia="5"></td>
                    <td data-hora="6" data-dia="6"></td>
                </tr>
                <tr>
                    <td>17:30 - 19:00</td>
                    <td data-hora="7" data-dia="1"></td>
                    <td data-hora="7" data-dia="2"></td>
                    <td data-hora="7" data-dia="3"></td>
                    <td data-hora="7" data-dia="4"></td>
                    <td data-hora="7" data-dia="5"></td>
                    <td data-hora="7" data-dia="6"></td>
                </tr>
                <tr>
                    <td>19:10 - 20:40</td>
                    <td data-hora="8" data-dia="1"></td>
                    <td data-hora="8" data-dia="2"></td>
                    <td data-hora="8" data-dia="3"></td>
                    <td data-hora="8" data-dia="4"></td>
                    <td data-hora="8" data-dia="5"></td>
                    <td data-hora="8" data-dia="6"></td>
                </tr>
                <tr>
                    <td>20:50 - 22:20</td>
                    <td data-hora="9" data-dia="1"></td>
                    <td data-hora="9" data-dia="2"></td>
                    <td data-hora="9" data-dia="3"></td>
                    <td data-hora="9" data-dia="4"></td>
                    <td data-hora="9" data-dia="5"></td>
                    <td data-hora="9" data-dia="6"></td>
                </tr>
            </tbody>
        </table>
    </body>
    
    <script>
        function loadHorarios() {
           
            corregirAtributosCeldas();

            fetch('${pageContext.request.contextPath}/controllerDataHorario/verHorario', {
                method: 'GET',
                headers: {
                    'Accept': 'application/json'
                }
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Error al cargar los datos del horario: ' + response.status);
                }
                return response.json(); 
            })
            .then(horarios => {
                if (horarios == null || horarios.length === 0) {
                    console.error("No hay datos de horarios disponibles");
                    document.getElementById('depuracion').value = "No hay datos de horarios";
                } else {
                    console.log("Horarios cargados:", horarios);
                    document.getElementById('depuracion').value = "Horarios cargados: " + horarios.length;

                    horarios.forEach(curso => {
                        
                        const idHora = typeof curso.id_hora === 'string' ? parseInt(curso.id_hora) : curso.id_hora;
                        const idDia = typeof curso.id_dia === 'string' ? parseInt(curso.id_dia) : curso.id_dia;

                        
                        const celda = encontrarCeldaPorIndices(idHora, idDia);

                        if (celda) {
                            
                            const cursoElement = document.createElement('div');
                            cursoElement.className = 'curso';
                            cursoElement.innerHTML = `
                                <strong>${curso.nom_curso}</strong><br>
                                ${curso.codigo}<br>
                                Aula: ${curso.nom_aula}
                            `;

                            celda.appendChild(cursoElement);
                        } else {
                            console.error('No se pudo encontrar celda para hora:', idHora, 'día:', idDia);
                        }
                    });
                }
            })
            .catch(error => {
                console.error("Error al cargar datos del horario:", error);
                document.getElementById('depuracion').value = "Error: " + error;
            });        
        }

       
        function corregirAtributosCeldas() {
          
            const filas = document.querySelectorAll('#horarioTable tbody tr');

            filas.forEach((fila, indexFila) => {
                
                const idHora = indexFila + 1;

                const celdas = fila.querySelectorAll('td:not(:first-child)');

                celdas.forEach((celda, indexCelda) => {
                    
                    const idDia = indexCelda + 1;

                    
                    celda.setAttribute('data-hora', idHora);
                    celda.setAttribute('data-dia', idDia);

                });
            });

        }

        function encontrarCeldaPorIndices(idHora, idDia) {
            //iniciamos con hora          
            const filas = document.querySelectorAll('#horarioTable tbody tr');
            if (!filas || filas.length < idHora) {
                console.error('No se encontró la fila para hora:', idHora);
                return null;
            }

            const fila = filas[idHora - 1]; 

            //iniciamos con dia
            const celdas = fila.querySelectorAll('td');
            if (!celdas || celdas.length < idDia + 1) {
                console.error('No se encontró la celda para día:', idDia);
                return null;
            }

            return celdas[idDia]; 
        }

        document.addEventListener('DOMContentLoaded', loadHorarios);
    </script>
</html>