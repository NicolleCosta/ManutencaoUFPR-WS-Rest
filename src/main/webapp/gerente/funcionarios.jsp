<%-- 
    Document   : funcionarios
    Created on : 10 de jun de 2023, 13:51:58
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
        <title>Funcionários - Gerente</title>

        <!-- Configurações da pagina (fim do head) e Cabeçalho da página -->

        <%@include file="header.jsp" %>
    <div class="w-100">
        <c:if test="${requestScope.info != null || param.info != null}">
            <div class="alert alert-success alert-dismissible fade show">
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                <span>${requestScope.info == null ? param.info : requestScope.info}</span>
            </div>
        </c:if>
        <h1 class="text-center">Funcionários</h1>
    </div>
    <div class="container text-center">
        <div class="row p-3">
            <div class="col-6">
                <form class="d-flex" role="search">
                    <input id="searchInput" class="form-control me-2" type="search" placeholder="Buscar Funcionário" aria-label="Search">
                    <button class="btn btn-primary fw-bold search-button" type="submit" >Buscar</button>
                </form>
            </div>
            <div class="col-6">

                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                    <div class="btn-group" role="group" aria-label="Basic example">
                        <button class="btn btn-primary " data-bs-toggle="modal" data-bs-target="#novoFuncionarioModal">Novo Funcionário</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="table-secondary table-sm p-3 text-center">
            <table class="table align-middle mb-0 bg-white table-hover">
                <thead class="bg-light">
                    <tr>
                        <th>Nome</th>
                        <th>Cargo</th>
                        <th>Situação</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="funcionario" items="${requestScope.funcionarios}">
                        <tr data-bs-toggle="modal"
                            data-bs-target="#modalFuncionario<c:out value="${funcionario.id}"/>">
                            <td>
                                <p class="fw-normal mb-1">
                                    <c:out value="${funcionario.nome}" />
                                </p>
                            </td>
                            <td>
                                <p class="fw-normal mb-1">
                                    <c:out value="${funcionario.tipoUsuarioId.nome}" />
                                </p>
                            </td>

                            <td>
                                <p class="fw-normal mb-1">
                                    <span class="badge badge-sm c-status" style="background-color:
                                          <c:choose>
                                              <c:when test="${funcionario.bloqueio eq 'false'}">green
                                                  <c:set var="status" value="Ativo" />
                                              </c:when>
                                              <c:otherwise>red
                                                  <c:set var="status" value="Bloqueado" />
                                              </c:otherwise>
                                          </c:choose>;">
                                        <c:out value="${status}"/>
                                    </span>
                                </p>
                            </td>
                            <td>
                                <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                                        data-bs-target="#modalFuncionario<c:out value="${funcionario.id}"/>">
                                    Detalhes
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>



    <!--********** MODAL Funcionario **************-->
    <c:forEach var="funcionario" items="${requestScope.funcionarios}">
        <div class="modal fade" id="modalFuncionario<c:out value="${funcionario.id}"/>" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
             aria-labelledby="modalFuncionarioLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="modalOperario">Funcionário</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-right">
                            <div class="row row-cols-2">
                                <div class="col">
                                    <p>id Funcionário</p>
                                </div>
                                <div class="col">
                                    <p># <c:out value="${funcionario.id}"/></p>
                                </div>
                            </div>
                        </div>
                        <div class="container">
                            <div class="row">
                                <div>Nome</div>
                                <div>
                                    <input type="text" class="form-control text-bg-light" id="nome" value="${funcionario.nome}" readonly>
                                </div>
                                <div class="container text-right">
                                    <div class="row row-cols-3">
                                        <div class="col">
                                            <label>CPF</label>
                                            <input type="text" class="form-control text-bg-light" id="cpf" value="${funcionario.cpf}" readonly>
                                        </div>
                                        <div class="col">
                                            <label>Telefone</label>
                                            <input type="text" class="form-control text-bg-light" id="telefone" value="${funcionario.telefone}" readonly>
                                        </div>
                                        <div class="col">
                                            <label>Situação</label>
                                            <c:choose>
                                                <c:when test="${funcionario.bloqueio eq 'false'}">
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
                                    <input type="text" class="form-control text-bg-light" id="email" value="${funcionario.email}" readonly>
                                </div>
                                <div class="d-grid gap-2 d-md-flex justify-content-md-start">                
                                    <div>
                                        <label>Cargo</label>
                                        <input type="text" class="form-control text-bg-light" id="tipoUsuario" value="${funcionario.tipoUsuarioId.nome}" readonly>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-warning"
                                data-bs-toggle="modal" data-bs-target="#modalDesbloqueio<c:out value='${funcionario.id}'/>"
                                <c:if test="${funcionario.bloqueio == false}">disabled</c:if>
                                <c:if test="${sessionScope.user.id == funcionario.id}">disabled</c:if>
                                    >Desbloquear</button>

                                <button type="button" class="btn btn-danger"
                                        data-bs-toggle="modal" data-bs-target="#modalBloqueio<c:out value='${funcionario.id}'/>"
                                <c:if test="${funcionario.bloqueio == true}">disabled</c:if>
                                <c:if test="${sessionScope.user.id == funcionario.id}">disabled</c:if>
                                    >Bloquear</button>

                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>

                                <button type="button" class="btn btn-warning"
                                        data-bs-toggle="modal" data-bs-target="#editarFuncionarioModal<c:out value='${funcionario.id}'/>"
                                <c:if test="${sessionScope.user.id == funcionario.id}">disabled</c:if>
                                    >Editar</button>
                        </div>
                    </div>
                </div>
            </div>
    </c:forEach>


    <!--********** MODAL EDITAR Funcionario **************-->
    <c:forEach var="funcionario" items="${requestScope.funcionarios}">
        <div class="modal fade" id="editarFuncionarioModal<c:out value="${funcionario.id}"/>" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
             aria-labelledby="editarFuncionarioModal" aria-hidden="true">
            <form action="CadastroServlet?action=alterarCadastroFuncionario" method="POST" class="mt-5 submit-jsp">
                <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="modalOperario">Funcionário</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="container text-right">
                                <div class="row row-cols-2">
                                    <div class="col">
                                        <p>id Funcionário</p>
                                    </div>
                                    <div class="col">
                                        <p># <c:out value="${funcionario.id}"/></p>
                                    </div>
                                    <input type="text" class="form-control text-bg-light" id="id" name="id" value="${funcionario.id}" hidden>
                                </div>
                            </div>
                            <div class="container">
                                <div class="row">
                                    <div>Nome</div>
                                    <div>
                                        <input type="text" class="form-control text-bg-light" id="nome" name="nome" value="${funcionario.nome}" required >
                                    </div>
                                    <div class="container text-right">
                                        <div class="row row-cols-3">
                                            <div class="col">
                                                <label>CPF</label>
                                                <input type="text" class="form-control text-bg-light" id="cpf" name="cpf" value="${funcionario.cpf}" readonly>
                                            </div>
                                            <div class="col">
                                                <label>Telefone</label>
                                                <input type="text" class="form-control text-bg-light" id="telefone" name="telefone" value="${funcionario.telefone}" required>
                                            </div>
                                            <div class="col">
                                                <label>Situação</label>
                                                <c:choose>
                                                    <c:when test="${funcionario.bloqueio eq 'false'}">
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
                                        <input type="text" class="form-control text-bg-light" id="email" name="email" value="${funcionario.email}" required>
                                    </div>
                                </div>
                                <div class="d-grid gap-2 d-md-flex justify-content-md-start">
                                    <h5 class="p-3"> Cargo </h5>
                                    <c:forEach var="tipoUsuario" items="${requestScope.tiposUsuario}">
                                        <c:if test="${tipoUsuario.nome != 'usuario' &&  tipoUsuario.nome != 'operario'}">
                                            <input type="radio" name="tipoUsuario" value="${tipoUsuario.id}"  <c:if test="${funcionario.tipoUsuarioId.id == tipoUsuario.id}"> checked="checked"</c:if> required>
                                            ${tipoUsuario.nome} <br>
                                        </c:if>
                                    </c:forEach>
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
    <c:forEach var="funcionario" items="${requestScope.funcionarios}">
        <div class="modal fade" id="modalBloqueio${funcionario.id}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
             aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <form action="CadastroServlet?action=alterarModoBloqueioFuncionario" method="POST" class="mt-5 submit-jsp">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="staticBackdropLabel">CONFIRMAÇÃO DE BLOQUEIO - Funcionário</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p class="fw-bold">Tem certeza que deseja BLOQUEAR o Funcionário?</p>
                            <input type="text" class="form-control text-bg-light" id="id" name="id" value="${funcionario.id}" hidden>

                            <div>Nome</div>
                            <div>
                                <input type="text" class="form-control text-bg-light" id="nome" value="${funcionario.nome}" readonly>
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
    <c:forEach var="funcionario" items="${requestScope.funcionarios}">
        <div class="modal fade" id="modalDesbloqueio${funcionario.id}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
             aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <form action="CadastroServlet?action=alterarModoBloqueioFuncionario" method="POST" class="mt-5 submit-jsp">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="staticBackdropLabel">CONFIRMAÇÃO DE DESBLOQUEIO - Funcionário</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p class="fw-bold">Tem certeza que deseja DESBLOQUEAR o Funcionário</p>
                            <input type="text" class="form-control text-bg-light" id="id" name="id" value="${funcionario.id}" hidden>

                            <div>Nome</div>
                            <div>
                                <input type="text" class="form-control text-bg-light" id="nome" value="${funcionario.nome}" readonly>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-warning">Desbloqueio</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </c:forEach>

    <!--********** MODAL Novo Funcionario **************-->
    <form action="CadastroServlet?action=novoFuncionario" method="POST">
        <div class="modal fade" id="novoFuncionarioModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
             aria-labelledby="novoFuncionarioModal" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="modalOperario">Novo Funcionário</h1>
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
                                    <div class="row row-cols-3">
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
                            </div>
                        </div>
                        <h5 class="p-3"> Cargo </h5>
                        <div class="d-grid gap-2 d-md-flex justify-content-md-start">

                            <c:forEach var="tipoUsuario" items="${requestScope.tiposUsuario}">
                                <c:if test="${tipoUsuario.nome != 'usuario' &&  tipoUsuario.nome != 'operario'}">
                                    <input type="radio" name="tipoUsuario" value="${tipoUsuario.id}"  <c:if test="${funcionario.tipoUsuarioId.id == tipoUsuario.id}"> checked="checked"</c:if> required>
                                    ${tipoUsuario.nome} 
                                </c:if>
                            </c:forEach>
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
    <script src="js/main.js"></script>
</body>
</html>