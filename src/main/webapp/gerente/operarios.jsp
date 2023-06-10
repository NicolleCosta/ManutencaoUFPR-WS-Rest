<%-- 
    Document   : operario
    Created on : 10 de jun de 2023, 13:55:20
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
        <title>Operários - Gerente</title>

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
    <div class="container text-center">
        <div class="row p-3">
            <div class="col-4 justify-content-md-end">
                <form class="d-flex" role="search">
                    <input class="form-control me-2" type="search" placeholder="Buscar Chamado"
                        aria-label="Search">
                    <button class="btn btn-warning fw-bold" type="submit">Buscar</button>
                </form>
            </div>
            <div class="col d-grid gap-2 d-md-flex justify-content-md-end">               
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#novoOperarioModal">Novo Operário</button>
            </div>
        </div>
    </div>

    <div class="table-secondary">
        <table class="table align-middle mb-0 bg-white table-hover">
            <thead class="bg-light">
                <tr>
                    <th>Nome</th>
                    <th>Disciplina</th>
                    <th>Situação</th>
                    <th></th>
                </tr>
            </thead>
            <tbody data-bs-toggle="modal" data-bs-target="#modalOperario">
                <c:forEach var="operario" items="${requestScope.operarios}">
                    <tr>
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

    <!--********** MODAL OPERARIO **************-->
    <c:forEach var="operario" items="${requestScope.operarios}">
        <div class="modal fade" id="modalOperario<c:out value="${operario.id}"/>" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
             aria-labelledby="modalOperarioLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="modalOperario">Operário</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-right">
                            <div class="row row-cols-6">
                                <div class="col">
                                    <p>id Operário</p>
                                </div>
                                <div class="col">
                                    <p># <c:out value="${operario.id}"/></p>
                                </div>
                            </div>
                        </div>
                        <div class="container">
                            <div class="row">
                                <div>Nome</div>
                                <div>
                                    <input type="text" class="form-control text-bg-light" id="nome" value="${operario.nome}" readonly>
                                </div>
                                <div class="container text-right">
                                    <div class="row row-cols-3">
                                        <div class="col">
                                            <label>CPF</label>
                                            <input type="text" class="form-control text-bg-light" id="cpf" value="${operario.cpf}" readonly>
                                        </div>
                                        <div class="col">
                                            <label>Telefone</label>
                                            <input type="text" class="form-control text-bg-light" id="telefone" value="${operario.telefone}" readonly>
                                        </div>
                                        <div class="col">
                                            <label>Situação</label>
                                            <c:choose>
                                                <c:when test="${operario.bloqueio eq 'false'}">
                                                    <c:set var="status" value="Ativo" />
                                                </c:when>
                                                <c:otherwise>
                                                    <c:set var="status" value="Bloqueado" />
                                                </c:otherwise>
                                            </c:choose>
                                            <input type="text" class="form-control text-bg-light" id="situação" value="${status}" readonly>
                                        </div>

                                    </div>
                                </div>
                                <div>
                                    <label>Email</label>
                                    <input type="text" class="form-control text-bg-light" id="email"  value="${operario.email}" readonly>
                                </div>
                                <div class="row row-cols-6">
                                    <div>
                                        <label>Especialidade:</label>
                                    </div>
                                    <div>
                                        <p> <c:out value="${operario.especialidadeId.nome}"/></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-warning" data-bs-toggle="modal"
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
                            <h1 class="modal-title fs-5" id="modalOperario">Operário</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>

                        <div class="modal-body">
                            <div class="container text-right">
                                <div class="row row-cols-2">
                                    <div class="col">
                                        <p>id Operário</p>
                                    </div>
                                    <div class="col">
                                        <p># <c:out value="${operario.id}"/></p>
                                    </div>
                                    <input type="text" class="form-control text-bg-light" id="id" name="id" value="${operario.id}" hidden>
                                </div>
                            </div>
                            <div class="container">
                                <div class="row">
                                    <div>Nome</div>
                                    <div>
                                        <input type="text" class="form-control text-bg-light" id="nome" name="nome" value="${operario.nome}" required>
                                    </div>
                                    <div class="container text-right">
                                        <div class="row row-cols-3">
                                            <div class="col">
                                                <label>CPF</label>
                                                <input type="text" class="form-control text-bg-light" id="cpf" name="cpf" value="${operario.cpf}" readonly>
                                            </div>
                                            <div class="col">
                                                <label>Telefone</label>
                                                <input type="text" class="form-control text-bg-light" id="telefone" name="telefone" value="${operario.telefone}" required>
                                            </div>
                                            <div class="col">
                                                <label>Situação</label><c:choose>
                                                    <c:when test="${operario.bloqueio eq 'false'}">
                                                        <c:set var="status" value="Ativo" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:set var="status" value="Bloqueado" />
                                                    </c:otherwise>
                                                </c:choose>
                                                <input type="text" class="form-control text-bg-light" id="situação" value="${status}" readonly>
                                            </div>

                                        </div>
                                    </div>
                                    <div>
                                        <label>Email</label>
                                        <input type="text" class="form-control text-bg-light" id="email" name="email" value="${operario.email}" required>
                                    </div>
                                    <div>
                                        <label>Especialidades</label>
                                        <br>

                                        <c:forEach var="especialidade" items="${requestScope.especialidades}">
                                            <c:if test="${especialidade.nome != 'N/A'}">
                                                <input type="radio" name="especialidade" value="${especialidade.id}"  <c:if test="${operario.especialidadeId != null && operario.especialidadeId.id == especialidade.id}"> checked="checked"</c:if> required>
                                                ${especialidade.nome} <br>
                                            </c:if>
                                        </c:forEach>

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
                            <h1 class="modal-title fs-5" id="staticBackdropLabel">CONFIRMAÇÃO DE BLOQUEIO - OPERÁRIO</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p class="fw-bold">Tem certeza que deseja BLOQUEAR o Operário?</p>
                            <input type="text" class="form-control text-bg-light" id="id" name="id" value="${operario.id}" hidden>

                            <div>Nome</div>
                            <div>
                                <input type="text" class="form-control text-bg-light" id="nome" value="${operario.nome}" readonly>
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
                            <h1 class="modal-title fs-5" id="staticBackdropLabel">CONFIRMAÇÃO DE DESBLOQUEIO - OPERÁRIO</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p class="fw-bold">Tem certeza que deseja DESBLOQUEAR o Operário?</p>
                            <input type="text" class="form-control text-bg-light" id="id" name="id" value="${operario.id}" hidden>

                            <div>Nome</div>
                            <div>
                                <input type="text" class="form-control text-bg-light" id="nome" value="${operario.nome}" readonly>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="sumit" class="btn btn-warning">Desbloqueio</button>
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
                        <h1 class="modal-title fs-5" id="modalOperario">Novo Operário</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="container">
                            <div class="row">
                                <div>Nome</div>
                                <div>
                                    <input type="text" class="form-control text-bg-light" id="nome" name="nome" required>
                                </div>

                                <div class="container text-right">
                                    <div class="row row-cols-2">
                                        <div class="col">
                                            <label>CPF</label>
                                            <input type="text" class="form-control text-bg-light" id="cpf" name="cpf" required>
                                        </div>
                                        <div class="col">
                                            <label>Telefone</label>
                                            <input type="text" class="form-control text-bg-light" id="telefone" name="telefone" required>
                                        </div>
                                    </div>
                                </div>
                                <div>
                                    <label>Email</label>
                                    <input type="text" class="form-control text-bg-light" id="email" name="email" required>
                                </div>
                                <div>
                                    <label>Especialidades</label>
                                    <br>
                                    <c:forEach var="especialidade" items="${requestScope.especialidades}">
                                        <c:if test="${especialidade.nome != 'N/A'}">
                                            <input type="radio" name="especialidade" value="${especialidade.id}"> ${especialidade.nome} <br>
                                        </c:if>
                                    </c:forEach>

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
</body>
</html>