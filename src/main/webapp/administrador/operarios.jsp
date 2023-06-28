<%-- 
    Document   : operario
    Created on : 4 de jun de 2023, 17:18:44
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
    <c:if test="${ sessionScope.user.tipoUsuarioId.nome != 'administrador'}">
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
        <title>Operários - Administrador</title>

        <!-- Configurações da pagina (fim do head) e Cabeçalho da página -->
        <%@include file="header.jsp" %>

        <!-- Corpo da página -->
    <div class="w-100 p-3">
        <c:if test="${requestScope.info != null || param.info != null}">
            <div class="alert alert-success alert-dismissible fade show">
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                <span>${requestScope.info == null ? param.info : requestScope.info}</span>
            </div>
        </c:if>
        <h1 class="text-primary text-center fw-bold">Operários</h1>
    </div>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="container">
                    <div class="row justify-content-center p-3">
                        <div class="col-md-8">
                            <form class="d-flex" role="search">
                                <input id="searchInput" class="form-control me-2" type="search" placeholder="Buscar Operário" aria-label="Search">
                                <button class="btn btn-primary fw-bold search-button" type="submit">Buscar</button>
                            </form>
                        </div>
                        <div class="col d-grid gap-2 d-md-flex justify-content-md-end">               
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#novoOperarioModal">Novo Operário</button>
                        </div>
                    </div>

                    <div class="table-secondary table-sm p-3 text-center">
                        <table class="table align-middle mb-0 bg-white table-hover">
                            <thead>
                                <tr>
                                    <th>Nome</th>
                                    <th>Disciplina</th>
                                    <th>Situação</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="operario" items="${requestScope.operarios}">
                                    <tr data-bs-toggle="modal" data-bs-target="#modalOperario<c:out value="${operario.id}"/>">
                                        <td>
                                            <p class="fw-normal mb-1">
                                                <c:out value="${operario.nome}" />
                                            </p>
                                        </td>
                                        <td>
                                            <p class="fw-normal mb-1">
                                                <c:out value="${operario.especialidadeId.nome}" />
                                            </p>
                                        </td>
                                        <td>
                                            <span class="badge badge-sm c-status" style="background-color:
                                                  <c:choose>
                                                      <c:when test="${operario.bloqueio eq 'false'}">green
                                                          <c:set var="status" value="Ativo" />
                                                      </c:when>
                                                      <c:otherwise>red
                                                          <c:set var="status" value="Bloqueado" />
                                                      </c:otherwise>
                                                  </c:choose>;">
                                                <c:out value="${status}"/>
                                            </span>
                                        </td>
                                        <td>
                                            <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                                                    data-bs-target="#modalOperario<c:out value="${operario.id}"/>">
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
        </div>
    </div>



    <!--********** MODAL OPERARIO **************-->
    <c:forEach var="operario" items="${requestScope.operarios}">
        <div class="modal fade" id="modalOperario<c:out value="${operario.id}"/>" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
             aria-labelledby="modalOperarioLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title text-primary">Operário</h3>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row justify-content-end">
                            <div class="col-sm-4 text-sm-end">
                                <p class="fw-bold">ID Operário</p>
                            </div>
                            <div class="col-sm-4">
                                <input type="text" id="operarioID" class="form-control text-bg-light" value="${operario.id}" readonly>
                            </div>
                        </div>
                        <div class="container">
                            <div class="row">
                                <div class="col-sm-12">
                                    <label class="fw-bold col-form-label">Nome</label>
                                    <input type="text" class="form-control text-bg-light" id="nome" value="${operario.nome}" readonly>
                                </div>
                                <div class="container text-right">
                                    <div class="row row-cols-3 py-2">
                                        <div class="col">
                                            <label class="fw-bold col-form-label">CPF</label>
                                            <input type="text" class="form-control text-bg-light" id="cpf" value="${operario.cpf}" readonly>
                                        </div>
                                        <div class="col">
                                            <label class="fw-bold col-form-label">Telefone</label>
                                            <input type="text" class="form-control text-bg-light" id="telefone" value="${operario.telefone}" readonly>
                                        </div>
                                        <div class="col">
                                            <label class="fw-bold col-form-label">Situação</label>
                                            <c:choose>
                                                <c:when test="${operario.bloqueio eq 'false'}">
                                                    <c:set var="status" value="Ativo" />
                                                    <input type="text" class="form-control text-bg-success" id="situacao" value="${status}" readonly />
                                                </c:when>
                                                <c:otherwise>
                                                    <c:set var="status" value="Bloqueado" />
                                                    <input type="text" class="form-control text-bg-danger" id="situacao" value="${status}" readonly />
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <label class="fw-bold col-form-label">Email</label>
                                    <input type="text" class="form-control text-bg-light" id="email"  value="${operario.email}" readonly>
                                </div>
                                <div class="col-sm-12 py-2">
                                    <label class="fw-bold col-form-label ">Especialidade</label>
                                    <input type="text" class="form-control text-bg-light" id="email"  value="${operario.especialidadeId.nome}" readonly>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                                data-bs-target="#modalDesbloqueio<c:out value="${operario.id}"/>" <c:if test="${operario.bloqueio==false}"> disabled </c:if>>Desbloquear</button>
                                <button type="button" class="btn btn-danger" data-bs-toggle="modal"
                                        data-bs-target="#modalBloqueio<c:out value="${operario.id}"/>"  <c:if test="${operario.bloqueio== true}"> disabled </c:if>>Bloquear</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                <button type="button" class="btn btn-warning" data-bs-toggle="modal"
                                        data-bs-target="#editarOperarioModal<c:out value="${operario.id}"/>">Editar</button>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>

    <!--********** MODAL EDITAR OPERARIO **************-->
    <c:forEach var="operario" items="${requestScope.operarios}"> 
        <div class="modal fade" id="editarOperarioModal<c:out value="${operario.id}"/>" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
             aria-labelledby="editarOperarioModalLabel" aria-hidden="true">
            <form action="CadastroServlet?action=alterarCadastroOperario" method="POST" class="mt-5 submit-jsp">
                <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title text-primary">Operário</h3>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="row justify-content-end">
                                <div class="col-sm-4 text-sm-end">
                                    <p class="fw-bold">ID Operário</p>
                                </div>
                                <div class="col-sm-4">
                                    <input type="text" id="id" name="id" class="form-control text-bg-light" value="${operario.id}" readonly>
                                </div>
                            </div>
                            <div class="container">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label class="fw-bold col-form-label">Nome</label>
                                        <input type="text" class="form-control text-bg-light" id="nomeedit" name="nome" value="${operario.nome}" required>
                                    </div>
                                    <div class="container text-right">
                                        <div class="row row-cols-3 py-2">
                                            <div class="col">
                                                <label class="fw-bold col-form-label">CPF</label>
                                                <input type="text" class="form-control text-bg-secondary" id="cpfedit" name="cpf" value="${operario.cpf}" disabled>
                                            </div>
                                            <div class="col">
                                                <label class="fw-bold col-form-label">Telefone</label>
                                                <input type="text" class="form-control text-bg-light" id="telefoneedit" name="telefone"  value="${operario.telefone}" required>
                                            </div>
                                            <div class="col">
                                                <label class="fw-bold col-form-label">Situação</label>
                                                <c:choose>
                                                    <c:when test="${operario.bloqueio eq 'false'}">
                                                        <c:set var="status" value="Ativo" />
                                                        <input type="text" class="form-control text-bg-success" id="situacaoedit" value="${status}" readonly />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:set var="status" value="Bloqueado" />
                                                        <input type="text" class="form-control text-bg-danger" id="situacaoedit2" value="${status}" readonly />
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-12">
                                        <label class="fw-bold col-form-label">Email</label>
                                        <input type="text" class="form-control text-bg-light" id="emailedit" name="email"  value="${operario.email}">
                                    </div>
                                    <div class="p-3">
                                        <label class="fw-bold">Especialidades</label>
                                        <br>
                                        <div class="row row-cols-3 py-2">
                                            <c:forEach var="especialidade" items="${requestScope.especialidades}">
                                                <c:if test="${especialidade.nome != 'N/A'}">
                                                    <div class="col">
                                                        <input type="radio" name="especialidade" value="${especialidade.id}"  <c:if test="${operario.especialidadeId != null && operario.especialidadeId.id == especialidade.id}"> checked="checked"</c:if> required>
                                                        ${especialidade.nome}
                                                    </div>
                                                </c:if>
                                            </c:forEach>

                                        </div>
                                        </br>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">

                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button id="edit-salva-cadastro" type="submit"  class="btn btn-warning" >Salvar</button>
                        </div>

                    </div>
                </div>
            </form>
        </div>
    </c:forEach>




    <!--********** MODAL CONFIRMA BLOQUEIO**************-->
    <c:forEach var="operario" items="${requestScope.operarios}"> 
        <div class="modal fade" id="modalBloqueio${operario.id}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
             aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <form action="CadastroServlet?action=alterarModoBloqueioOperario" method="POST" class="mt-5 submit-jsp">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title fs-5" id="staticBackdropLabel">CONFIRMAÇÃO DE BLOQUEIO - <strong class="text-danger">OPERÁRIO</strong></h3>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p class="fw-bold">Tem certeza que deseja <strong class="text-danger"> BLOQUEAR </strong> o operário abaixo?</p>
                            <input type="text" class="form-control text-bg-light" id="id" name="id" value="${operario.id}" hidden>

                            <div class="col-sm-12">
                                <label class="fw-bold col-form-label">Nome</label>
                                <input type="text" class="form-control text-bg-light" id="nome" value="${operario.nome}" >
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-danger">Bloquear</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </c:forEach>



    <!--********** MODAL CONFIRMA DESBLOQUEIO**************-->
    <c:forEach var="operario" items="${requestScope.operarios}"> 
        <div class="modal fade" id="modalDesbloqueio${operario.id}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
             aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <form action="CadastroServlet?action=alterarModoBloqueioOperario" method="POST" class="mt-5 submit-jsp">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title fs-5" id="staticBackdropLabel">CONFIRMAÇÃO DE DESBLOQUEIO - <strong class="text-primary">OPERÁRIO</strong></h3>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p class="fw-bold">Tem certeza que deseja <strong class="text-primary"> DESBLOQUEAR </strong> o operário abaixo?</p>
                            <input type="text" class="form-control text-bg-light" id="id" name="id" value="${operario.id}" hidden>

                            <div>Nome</div>
                            <div>
                                <input type="text" class="form-control text-bg-light" id="nome" value="${operario.nome}" readonly>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-primary">Desbloqueio</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </c:forEach>

    <!--********** MODAL NOVO OPERARIO **************-->
    <form action="CadastroServlet?action=novoOperario" method="POST">
        <div class="modal fade" id="novoOperarioModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
             aria-labelledby="novoOperarioModal" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title text-primary">Novo Operário</h3>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="container">
                            <div class="row">
                                <div class="col-sm-12">
                                    <label class="fw-bold col-form-label">Nome</label>
                                    <input type="text" class="form-control text-bg-light" id="nome" name="nome" required>
                                </div>


                                <div class="container text-right">
                                    <div class="row row-cols-2">
                                        <div class="col">
                                            <label class="fw-bold col-form-label">CPF</label>
                                            <input type="text" class="form-control text-bg-light" id="cpf" name="cpf" onBlur="validaCPF(this)" maxlength="14" required>
                                            <span class="validacao-span" id="span-cpf" style="display: none">CPF Inválido!</span>
                                        </div>
                                        <div class="col">
                                            <label class="fw-bold col-form-label">Telefone</label>
                                            <input type="text" class="form-control text-bg-light" id="telefone" name="telefone" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <label class="fw-bold col-form-label">Email</label>
                                    <input type="text" class="form-control text-bg-light" id="email" name="email" required>
                                </div>
                                <div class="p-3">
                                    <label class="fw-bold">Especialidades</label>
                                    <br>
                                    <div class="row row-cols-3 py-2">
                                        <c:forEach var="especialidade" items="${requestScope.especialidades}">
                                            <c:if test="${especialidade.nome != 'N/A'}">
                                                <div class="col">
                                                    <input type="radio" name="especialidade" value="${especialidade.id}"> ${especialidade.nome} 
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                    </br>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-warning">Salvar</button>
                    </div>
                </div>
            </div>
        </div>
    </form>


    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.min.js"></script>
    <script src="js/main.js"></script>
    <script src="${pageContext.servletContext.contextPath}/js/cpf.js"></script>
    <script src="${pageContext.servletContext.contextPath}/js/mask.js"></script>
</body>
</html>