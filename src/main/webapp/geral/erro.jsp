<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isErrorPage="true"%>

<!DOCTYPE html>
<html lang="pt-BR">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>ManutençãoUFPR - Página de Erro</title>
        <link rel="stylesheet" href="style.css">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: Arial, sans-serif;
            }

            .container {
                margin-top: 50px;
                text-align: center;
            }

            .error-message {
                font-size: 36px;
                font-weight: bold;
                color: #dc3545;
                margin-bottom: 20px;
            }

            .error-details {
                font-size: 24px;
                color: #6c757d;
                margin-bottom: 40px;
            }

            .error-link {
                font-size: 20px;
                color: #007bff;
                text-decoration: none;
            }
        </style>
        <script>
            function goBack() {
                window.location.href = document.referrer;
            }
        </script>
    </head>

    <body>
        <div class="container">
            <p class="error-message">Ops, algo deu errado!</p>
            <p class="error-details">Lamentamos o inconveniente.</p>
            <p class="error-details">${pageContext.exception.message}</p>
            <p class="error-details">${requestScope.msg}</p>

            <a href="#" onclick="goBack()" class="error-link">Voltar</a>
        </div>
    </body>

</html>