<%-- 
    Document   : header
    Created on : 4 de mai de 2023, 22:37:34
    Author     : nicol
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- Menu do topo contendo nome do usuÃ¡rio e botÃ£o de logout  -->

<header class="container-fluid bg-info mb-4">
    <nav class="navbar navbar-expand-lg navbar-light" role="navigation">
        <a class="navbar-brand" href="/geral/index.jsp"></a>
        <div class="headerButtons">
            <ul class="navbar-nav text-white">
                <li class="nav-item">
                    <a class="nav-link" href="/ChamadoServlet"><button type="button" class="buttonYellow">Chamados</button></a>
                </li>
                <li class="nav-item">
                    <a class="buttonYellow" href="/OrdeDeServicoServlet">Ordem de Serviço</a>
                </li>
                <li class="nav-item">
                    <a href="/LocalizacaoServlet"><button type="button" class="buttonYellow">Localização</button></a>
                </li>
                <li class="nav-item">
                    <a href="/UsuarioServlet"><button type="button" class="buttonYellow">Usuário</button></a>
                <li>
                <li class="nav-item">
                    <a href="/CadastroServlet"><button type="button" class="buttonYellow">Operário</button></a>
                </li>
                <li class="nav-item">
                    <a href="/CadastroServlet"><button type="button" class="buttonYellow">Meu Cadastro</button></a>
                </li>
                <li class="nav-item">
                    <a href="LogoutServlet" class="alert-link text-white my-2 my-sm-0"><i class="fas fa-power-off"></i>Sair</a>
                </li>
            </ul>
        </div>
    </nav>
</header>
<div class="row">
    <div class="p-1 col-9 text-left">
        <p>Seja bem vindo(a) <c:out value="${sessionScope.user.nome}"/>!</p>
    </div>
</div>

