<%-- 
    Document   : header
    Created on : 4 de mai de 2023, 22:37:44
    Author     : nicol
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--configurações de tela no final do head-->
<link rel="stylesheet" href="./css/style.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
</head>


<body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>


<!-- Menu do topo contendo nome do usuariorio e botão de logout  -->

<header>
    <nav class="navbar bg-primary" data-bs-theme="dark">

        <div class="container-fluid">
            <a class="navbar-brand fw-bold px-3 p-2" href="ChamadoServlet?action=mostrarChamados">Manutenção
                UFPR</a>
            <form class="d-flex" role="search">

                <nav class="nav justify-content-end">
                    <div class="container-md p-2 px-3">
                        <span class="navbar-text fw-medium ">
                            Olá,
                            <c:out value="${sessionScope.user.nome}" />!
                        </span>
                    </div>
                </nav>


                <div class="nav-link p-2">
                    <a href="LogoutServlet" class="alert-link text-white fw-bold"><i
                            class="fas fa-power-off"></i>Sair</a>
                </div>
            </form>
        </div>

    </nav>
</header>


