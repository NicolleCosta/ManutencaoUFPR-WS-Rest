<%-- 
    Document   : header
    Created on : 4 de mai de 2023, 22:37:44
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
<script src="https://unpkg.com/@popperjs/core@2"></script>
</head>

<body>

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

        <div class="container p-3" id="navegacaoSuperior">
            <div class="row d-grid gap-2 d-md-flex justify-content-md-center">

                <div class="col-md-auto">
                    <a class="nav-link" href="OrdemDeServicoServlet?action=mostrarOrdemDeServico"><button type="button" class="btn btn-warning fw-bold btn-lg ">Ordem de Serviço</button></a>
                </div>
                <div class="col-md-auto">
                    <a href="CadastroServlet?action=mostrarMeuCadastro"><button type="button" class="btn btn-warning fw-bold  btn-lg">Meu Cadastro</button></a>
                </div>


            </div>
        </div>
    </header>


