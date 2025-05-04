<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <style>
        .error-container {
            margin-top: 50px;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .error-icon {
            color: #dc3545;
            font-size: 48px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 error-container bg-light">
                <div class="text-center">
                    <div class="error-icon">
                        <i class="bi bi-exclamation-triangle-fill"></i>
                    </div>
                    <h2 class="text-danger">¡Ha ocurrido un error!</h2>
                    
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger mt-3">
                            <p>${error}</p>
                        </div>
                    </c:if>
                    
                
                   
                </div>
            </div>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
</body>
</html>