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
        <title>Home - Administrador</title>

        <!-- Configurações da pagina (fim do head) e Cabeçalho da página -->
        <%@include file="header.jsp" %>

        <!-- Corpo da página -->
    <div class="w-100">
        <h1 class="text-center">Chamados</h1>
    </div>
    <div class="container text-center">
        <div class="row">
            <div class="col-sm-8">
                <form class="d-flex" role="search">
                    <input class="form-control me-2" type="search" placeholder="Buscar Chamado" aria-label="Search">
                    <button class="btn btn-warning" type="submit">Buscar</button>
                </form>
            </div>
        </div>
    </div>

    <!-- Texto Título -->
    <div class="w-100">
        <h2 class="text-center">Chamados Em Aberto</h2>
    </div>

    <div class="container-fluid display-table">
        <div class="row display-table-row">
            <div class="col-md-10 col-sm-11 display-table-cell v-align">
                <div class="user-dashboard">
                    <div class="row">

                        <!-- INICIO DE CONTEÚDO  -->

                        <!-- Texto Título -->
                        <div class="w-100">
                            <h2 class="text-center">Chamados Abertos</h2>
                        </div>

                        <!-- tabela -->
                        <div class="table-secondary">
                            <table class="table align-middle mb-0 bg-white table-hover">
                                <thead class="bg-light">
                                    <tr>
                                        <th>ID</th>
                                        <th>Campus</th>
                                        <th>Usuário</th>
                                        <th>Data e Hora</th>
                                        <th>Status</th>
                                        <th>Ação</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="chamado"
                                               items="${requestScope.chamadosAbertos}">
                                        <tr>
                                            <td>
                                                <p class="fw-normal mb-1">
                                                    <c:out value="${chamado.id}" />
                                                </p>
                                            </td>
                                            <td>
                                                <p class="fw-normal mb-1">
                                                    <c:out
                                                        value="${chamado.predioId.campusId.nome}" />
                                                </p>
                                            </td>
                                            <td>
                                                <p class="fw-normal mb-1">
                                                    <c:out value="${chamado.usuarioId.nome}" />
                                                </p>
                                            </td>
                                            <td>
                                                <p class="fw-normal mb-1">
                                                    <fmt:formatDate value="${chamado.dataHora}"
                                                                    pattern="dd/MM/yyyy - HH:mm:ss" />
                                                </p>
                                            </td>
                                            <td>
                                                <p>
                                                    <c:if test="${chamado.statusId.id == 1}">
                                                        <span class="badge badge-success rounded-pill d-inline">Aberto</span>
                                                    </c:if>
                                                </p>
                                            </td>
                                            <td>
                                                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#chamadoModal<c:out value="${chamados.chamado.id}"/>">
                                                    Detalhes
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>



                        <!-- Texto Título -->
                        <div class="w-100">
                            <h2 class="text-center">Chamados Em Andamento</h2>
                        </div>


                        <!-- tabela -->
                        <div class="table-responsive-sm w-100 py-2">
                            <table class="table align-middle mb-0 bg-white">
                                <thead class="bg-light">
                                    <tr>
                                        <th>ID</th>
                                        <th>Campus</th>
                                        <th>Usuário</th>
                                        <th>Ordem de Serviço Associada</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="chamados"
                                               items="${requestScope.chamadosEmAndamento}">
                                        <tr>
                                            <td>
                                                <p class="fw-normal mb-1">
                                                    <c:out value="${chamados.id}"/>
                                                </p>
                                            </td>
                                            <td>
                                                <p class="fw-normal mb-1">
                                                    <c:out
                                                        value="${chamados.predioId.campusId.nome}" />
                                                </p>
                                            </td>
                                            <td>
                                                <p class="fw-normal mb-1">
                                                    <c:out value="${chamados.dataHoraChamado}" />
                                                </p>
                                            </td>
                                            <td>
                                                <p> ${chamados.situacao == 0 ? '<span
                                                      class="badge badge-success rounded-pill d-inline">Aberto</span>'
                                                      : '<span
                                                      class="badge badge-secondary rounded-pill d-inline">Encerrado</span>'}
                                                </p>
                                            </td>
                                            <td>
                                                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#chamadoModal<c:out value="${chamados.id}"/>">
                                                    Detalhes
                                                </button>

                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <!--********** MODAL CHAMADO **************-->


                        <c:forEach var="chamado" items="${requestScope.chamadosAbertos}">
                            <div id="chamadoModal<c:out value="${chamado.id}"/>"
                                 class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false"
                                 tabindex="-1" aria-labelledby="chamadoModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <div class="row">
                                                    <div class="col-sm-8">
                                                        <div class="w-50">
                                                            <p class="text-body-secondary">Chamado</p>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-2">
                                                        <p>Id Chamado</p>
                                                    </div>
                                                    <div class="col-sm-2">
                                                        <p class="text-center"><c:out value="${chamados.id}"/></p>
                                                    </div>
                                                </div>
                                                <button type="button" class="btn-close"
                                                        data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>

                                            <div class="modal-body">
                                                <form>

                                                    <div class="container">

                                                        <div class="row">
                                                            <div class="col-sm-12">
                                                                <label for="recipient-name" class="col-form-label">Usuario</label>
                                                                <input type="text" name="nomeUsuario" value="<c:out value="${chamados.usuario}"/> " readonly="readonly" />
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-sm-6">
                                                                <label for="recipient-name"
                                                                       class="col-form-label">Campus:</label>
                                                                <input type="text" name="nomeCampus" value="<c:out value="${chamados.predioId.campusId.nome}"/> " readonly="readonly" />
                                                            </div>

                                                            <div class="col-sm-6">
                                                                <label for="recipient-name"
                                                                       class="col-form-label">Predio</label>
                                                                <input type="text" name="nomeCampus" value="<c:out value="${chamados.predioId.nome}"/> " readonly="readonly" />
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-sm-12">
                                                                <label for="message-text" class="col-form-label">Descrição do Local</label>
                                                                <textarea class="form-control text-bg-light" id="local-text" readonly></textarea>
                                                            </div>

                                                        </div>

                                                        <div class="row">
                                                            <div class="col-sm-12">
                                                                <label for="message-text" class="col-form-label">Descrição do Problema</label>
                                                                <textarea class="form-control text-bg-light" id="problema-text" readonly><c:out value="${chamados.descricaoProblema}"/></textarea>
                                                            </div>
                                                        </div>

                                                        <div class="row">
                                                            <div class="col-sm-4">
                                                                <label for="recipient-name" class="col-form-label">Status</label>
                                                                <input type="text" name="status" value="<c:out value="${chamados.status}"/> " readonly="readonly" />
                                                            </div>

                                                            <div class="col-sm-4">
                                                                <label for="recipient-name" class="col-form-label">Ordem de Serviço</label>
                                                                <input type="text" name="ordemDeServiço" value="<c:out value="${chamados.ordemDeServiço}"/> " readonly="readonly" />
                                                            </div>
                                                            <div class="col-sm-4">
                                                                <label for="recipient-name" class="col-form-label">Data e Hora</label>
                                                                <input type="text" name="dataHora" value="<c:out value="${chamados.dataHoraChamado}"/> " readonly="readonly" />
                                                            </div>
                                                        </div>
                                                </form>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <div class="row text-left">
                                                <div class="col">
                                                    <button type="button"
                                                            class="btn btn-secondary">Associar</button>
                                                </div>
                                                <div class="col">
                                                    <button type="button" class="btn btn-warning">Nova Ordem De Serviço</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </body>

</html>