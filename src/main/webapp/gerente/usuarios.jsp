<%-- 
    Document   : usuarios
    Created on : 10 de jun de 2023, 13:56:50
    Author     : nicol
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%--Validar se usuário está logado--%>
<c:if test="${sessionScope.user == null}">
    <c:redirect url="/geral/index.jsp">
        <c:param name="msg" value="Usuário deve se autenticar para acessar o sistema" />
    </c:redirect>
</c:if>
<c:if test="${ sessionScope.user != null }">
    <c:if test="${ sessionScope.user.tipoUsuarioId.nome != 'gerente'}">
        <c:redirect url="/geral/index.jsp">
            <c:param name="msg" value="Usuário não possui permissão para acessar essa página." />
        </c:redirect>
    </c:if>
</c:if>
<!DOCTYPE html>
<html lang="pt-BR">

    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Usuários - Gerente</title>

        <!-- Configurações da pagina (fim do head) e Cabeçalho da página -->
        <%@include file="header.jsp" %>


        <!-- Corpo da página -->
<div class="container text-center">
    
    <div class="w-100 p-3">
        <c:if test="${requestScope.info != null || param.info != null}">
            <div class="alert alert-success alert-dismissible fade show">
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                <span>${requestScope.info == null ? param.info : requestScope.info}</span>
            </div>
        </c:if>
        <h1 class="text-primary text-center fw-bold">Usuários</h1>
    </div>
    <div class="container text-center">
        <div class="row p-3">
            <div class="col-6">
                <form class="d-flex" role="search">

                    <input  id="searchInput" class="form-control me-2" type="search" placeholder="Buscar Usuário" aria-label="Search">
                    <button class="btn btn-primary fw-bold search-button" type="submit">Buscar</button>
                   


                </form>
            </div>
        </div>
    </div>

    

<div class="table-container" style="max-height: 400px; overflow-y: auto;">
    <div class="table-secondary table-sm p-3 text-center">
        <table class="table align-middle mb-0 bg-white table-hover">
            <thead class="bg-light">
                <tr>
                    <th>Nome</th>
                    <th>Situação</th>
                    <th></th>
                </tr>
            </thead>
                <tbody>
                    <c:forEach var="usuario" items="${requestScope.usuarios}">
                        <tr>
                            <td>
                                <p class="fw-normal mb-1">
                                    <c:out value="${usuario.nome}" />
                                </p>
                            </td>
                            <td>
                                <span class="badge badge-sm c-status" style="background-color:
                                    <c:choose>
                                        <c:when test="${usuario.bloqueio eq 'false'}">
                                            green
                                            <c:set var="status" value="Ativo" />
                                        </c:when>
                                        <c:otherwise>
                                            red
                                            <c:set var="status" value="Bloqueado" />
                                        </c:otherwise>
                                    </c:choose>;">
                                    <c:out value="${status}" />
                                </span>
                            </td>
                            <td>
                                <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                                        data-bs-target="#modalUsuario${usuario.id}">
                                    Detalhes
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
  
</div>
    <!--********** MODAL USUARIO**************-->
    <c:forEach var="usuario" items="${requestScope.usuarios}">
        <div class="modal fade" id="modalUsuario${usuario.id}" data-bs-backdrop="static" data-bs-keyboard="false"
             tabindex="-1" aria-labelledby="modalUsuarioLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title text-primary">Usuário</h3>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row justify-content-end">
                            <div class="col-sm-4 text-sm-end">
                                <p class="fw-bold">ID Usuário</p>
                            </div>
                            <div class="col-sm-4">
                                <input type="text"id="operarioID" class="form-control text-bg-light" value="${usuario.id}" readonly>
                            </div>
                        </div>
                        
                        <div class="container">
                            <div class="row">
                                <label class="fw-bold col-form-label">Nome</label>
                                <div>
                                    <input type="text" class="form-control text-bg-light" id="nome" readonly
                                           value="${usuario.nome}">
                                </div>
                            </div>
                            <div class="row row-cols-3">
                                <div class="col">
                                    <label class="fw-bold col-form-label">CPF</label>
                                    <input type="text" class="form-control text-bg-light" id="cpf" readonly
                                           value="${usuario.cpf}">
                                </div>
                                <div class="col">
                                    <label class="fw-bold col-form-label">Telefone</label>
                                    <input type="text" class="form-control text-bg-light" id="telefone" readonly
                                           value="${usuario.telefone}">
                                </div>
                                <div class="col">
                                    <label class="fw-bold col-form-label">Situação</label>
                                    <c:choose>
                                        <c:when test="${usuario.bloqueio eq 'false'}">
                                            <c:set var="status" value="Ativo" />
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="status" value="Bloqueado" />
                                        </c:otherwise>
                                    </c:choose>
                                    <input type="text" class="form-control text-bg-light" id="situação" value="${status}" readonly>
                                </div>
                            </div>
                            <div class="row">
                                <label class="fw-bold col-form-label">E-mail</label>
                                <div>
                                    <input type="text" class="form-control text-bg-light" id="email" readonly
                                           value="${usuario.email}">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-warning" data-bs-toggle="modal"
                                data-bs-target="#modalDesbloqueio<c:out value="${usuario.id}"/>" <c:if test="${usuario.bloqueio==false}"> disabled </c:if>>Desbloquear</button>
                                <button type="button" class="btn btn-danger" data-bs-toggle="modal"
                                        data-bs-target="#modalBloqueio${usuario.id}" <c:if test="${usuario.bloqueio == true}">disabled </c:if>>Bloquear</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        </div>
                    </div>
                </div>
            </div>
    </c:forEach>

    <!--********** MODAL CONFIRMA BLOQUEIO**************-->
    <c:forEach var="usuario" items="${requestScope.usuarios}">
        <div class="modal fade" id="modalBloqueio${usuario.id}" data-bs-backdrop="static" data-bs-keyboard="false"
             tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <form action="CadastroServlet?action=alterarModoBloqueioUsuario" method="POST">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="staticBackdropLabel">Confirmação de Bloqueio</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="id" value="${usuario.id}" />
                            <p>Deseja realmente bloquear o usuário <strong>${usuario.nome}</strong>?</p>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-danger">Bloquear</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </c:forEach>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
