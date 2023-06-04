<%-- 
    Document   : header
    Created on : 4 de mai de 2023, 22:37:34
    Author     : nicol
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--configurações de tela no final do head-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
</head>

<body>


<!-- Menu do topo contendo nome do usuariorio e botão de logout  -->

<header class="container-fluid bg-info mb-4">
    <nav class="navbar bg-primary" data-bs-theme="dark">

        <div class="container-fluid">
            <a class="navbar-brand">Manutenção UFPR</a>
            <form class="d-flex" role="search">

                <nav class="nav justify-content-end">
                    <div class="container-md">
                        <span class="navbar-text">
                            Olá, <c:out value="${sessionScope.user.nome}"/>!
                        </span>
                    </div>
                </nav>

                <div class="nav-link">
                    <a href="LogoutServlet" class="alert-link text-white my-2 my-sm-0"><i
                            class="fas fa-power-off"></i>Sair</a>
                </div>
            </form>
        </div>

    </nav>

    <div class="container" id="navegacaoSuperior">
        <div class="row align-items-center">

            <div class="col">
                <a class="nav-link" href="ChamadoServlet?action=mostrarHomeAdmin"><button type="button" class="btn btn-warning">Chamados</button></a>
            </div>  
            <div class="col">
                <a class="nav-link" href="OrdemDeServicoServlet?action=mostrarOrdensDeServiço"><button type="button" class="btn btn-warning ">Ordem de Serviço</button></a>
            </div>
            <div class="col">
                <a href="LocalizacaoServlet?action=mostrarLocalizacao"><button type="button" class="btn btn-warning">Localização</button></a>
            </div>
            <div class="col">
                <a href="CadastroServlet?action=mostrarUsuariosAdmin"><button type="button" class="btn btn-warning">Usuário</button></a>
            </div>
            <div class="col">
                <a href="CadastroServlet?action=mostrarOperariosAdmin"><button type="button" class="btn btn-warning">Operário</button></a>
            </div>
            <div class="col">
                <a href="CadastroServlet?action=mostrarMeuCadastro"><button type="button" class="btn btn-warning">Meu Cadastro</button></a>
            </div>
        </div>
    </div>
</header>


