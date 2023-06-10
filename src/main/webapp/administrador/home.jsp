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
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <%@include file="header.jsp" %>


        <!-- Corpo da página -->
    <div class="w-100 p-3">
        <h1 class="text-primary text-center fw-bold ">Chamados</h1>
    </div>
    <div class="row p-3">
        <div class="col-4 justify-content-md-end">
            <form class="d-flex" role="search">
                <input class="form-control me-2" type="search" placeholder="Buscar Chamado"
                       aria-label="Search">
                <button class="btn btn-warning fw-bold" type="submit">Buscar</button>
            </form>
        </div>


    </div>

    <!--**************** Chamados Sem Ordem De Serviço Associada************* -->

    <div class="container-fluid display-table p-3">
        <div class="row display-table-row">
            <!-- INICIO DE CONTEÚDO  -->

            <!-- Texto Título -->
            <div class="w-100">
                <h2 class="text-center fw-bold text-warning p-3">Chamados Sem Ordem De Seriço
                    Associada</h2>
            </div>

            <!-- tabela -->
            <div class="table-secondary table-sm p-3">
                <!-- tabela -->
                <div class="table-secondary">
                    <table class="table align-middle mb-0 bg-white table-hover">
                        <thead class="bg-light">
                            <tr>
                                <th>ID</th>
                                <th>Campus</th>
                                <th>Prédio</th>
                                <th>Usuário</th>
                                <th>Data e Hora</th>
                                <th>Status</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="chamado" items="${requestScope.listaChamadosAsc}">
                                <c:if test="${empty chamado.ordemServicoId}">
                                    <tr data-bs-toggle="modal" data-bs-target="#chamadoModal<c:out value="${chamado.id}"/>">
                                        <td>
                                            <p class="fw-normal mb-1">
                                                <c:out value="${chamado.id}" />
                                            </p>
                                        </td>
                                        <td>
                                            <p class="fw-normal mb-1">
                                                <c:out value="${chamado.predioId.campusId.nome}" />
                                            </p>
                                        </td>
                                        <td>
                                            <p class="fw-normal mb-1">
                                                <c:out value="${chamado.predioId.nome}" />
                                            </p>
                                        </td>
                                        <td>
                                            <p class="fw-normal mb-1">
                                                <c:out value="${chamado.usuarioId.nome}" />
                                            </p>
                                        </td>
                                        <td>
                                            <p class="fw-normal mb-1">
                                                <fmt:formatDate value="${chamado.dataHora}" pattern="dd/MM/yyyy - HH:mm:ss" />
                                            </p>
                                        </td>
                                        <td>
                                            <span class="badge badge-sm c-status" style="background-color:
                                                  <c:choose>
                                                      <c:when test="${chamado.statusId.nome eq 'Aberto'}">orange
                                                      </c:when>
                                                      <c:otherwise>green
                                                      </c:otherwise>
                                                  </c:choose>;">
                                                <c:out value="${chamado.statusId.nome}"/>
                                            </span>
                                        </td>
                                        <td>
                                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#chamadoModal<c:out value="${chamado.id}"/>">
                                                Detalhes
                                            </button>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>



        <!-- *********************Chamados Com Ordem de Serviço Associada ********************** -->

        <div class="container-fluid display-table p-3">
            <div class="row display-table-row">
                <div class="w-100">
                    <h2 class="text-center fw-bold text-warning p-3">Chamados Com Ordem de Serviço
                        Associada</h2>
                </div>

                <!-- tabela -->
                <div class="table-secondary table-sm p-3">
                    <table class="table align-middle mb-0 bg-white">
                        <thead class="bg-light">
                            <tr>
                                <th>ID</th>
                                <th>Campus</th>
                                <th>Prédio</th>
                                <th>Usuário</th>
                                <th>Data e Hora</th>
                                <th>Ordem de Serviço Associada</th>
                                <th>Status</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody data-bs-toggle="modal" data-bs-target="#chamadoEmAndamentoModal">
                            <c:forEach var="chamados" items="${requestScope.listaChamadosDesc}">
                                <c:if test="${not empty chamados.ordemServicoId}">
                                    <tr>
                                        <td>
                                            <p class="fw-normal mb-1">
                                                <c:out value="${chamados.id}"/>
                                            </p>
                                        </td>
                                        <td>
                                            <p class="fw-normal mb-1">
                                                <c:out value="${chamados.predioId.campusId.nome}" />
                                            </p>
                                        </td>
                                        <td>
                                            <p class="fw-normal mb-1">
                                                <c:out value="${chamados.predioId.nome}" />
                                            </p>
                                        </td>
                                        <td>
                                            <p class="fw-normal mb-1">
                                                <c:out value="${chamados.usuarioId.nome}" />
                                            </p>
                                        </td>
                                        <td>
                                            <p class="fw-normal mb-1">
                                                <fmt:formatDate value="${chamados.dataHora}" pattern="dd/MM/yyyy - HH:mm:ss" />
                                            </p>
                                        </td>
                                        <td>
                                            <p class="fw-normal mb-1">
                                                <c:out value="${chamados.ordemServicoId.numeroOS}" />
                                            </p>
                                        </td>
                                        <td>
                                            <span class="badge badge-sm c-status" style="background-color:
                                                  <c:choose>
                                                      <c:when test="${chamados.statusId.nome eq 'Aberto'}">orange
                                                      </c:when>
                                                      <c:otherwise>green
                                                      </c:otherwise>
                                                  </c:choose>;">
                                                <c:out value="${chamados.statusId.nome}"/>
                                            </span>
                                        </td>
                                        <td>
                                            <button  type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#chamadoEmAndamentoModal<c:out value="${chamado.id}"/>">
                                                Detalhes
                                            </button>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>




        <!--********** MODAL CHAMADOS ABERTOS **************-->
        <c:forEach var="chamado" items="${requestScope.listaChamadosAsc}">
            <div class="modal fade" data-bs-keyboard="false" tabindex="-1" aria-labelledby="chamadoModalLabel"
                 aria-hidden="true"   id="chamadoModal<c:out value="${chamado.id}"/>">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="text-primary" id="chamadoModal">Chamado</h3>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>

                        <div class="modal-body">


                            <div class="container">
                                <p>Id Chamado: <c:out value="${chamado.id}"/></p>

                                <div class="row">
                                    <div class="col-sm-12">
                                        <label for="recipient-name" class="col-form-label">Usuario</label>
                                        <input type="text" class="form-control text-bg-light" id="recipient-name" value="<c:out value="${chamado.usuarioId.nome}"/>" readonly>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label for="recipient-name" class="col-form-label">Campus</label>
                                        <input type="text" class="form-control text-bg-light" id="campus-name" value="<c:out value="${chamado.predioId.campusId.nome}" />" readonly>
                                    </div>

                                    <div class="col-sm-6">
                                        <label for="recipient-name" class="col-form-label">Predio</label>
                                        <input type="text" class="form-control text-bg-light" id="predio-name" value="<c:out value="${chamado.predioId.nome}"/>" readonly>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label for="message-text" class="col-form-label">Descrição do Local</label>
                                        <textarea class="form-control text-bg-light" id="local-text" readonly><c:out value="${chamado.descricaoLocal}"/></textarea>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-sm-12">
                                        <label for="message-text" class="col-form-label">Descrição do Problema</label>
                                        <textarea class="form-control text-bg-light" id="problema-text" readonly><c:out value="${chamado.descricaoProblema}"/></textarea>
                                    </div>

                                </div>

                                <div class="row">
                                    <div class="col-sm-4">
                                        <label for="recipient-name" class="col-form-label">Status</label>
                                        <input type="text" class="form-control text-bg-light" id="status" value="<c:out value="${chamado.statusId.nome}"/>" readonly>
                                    </div>

                                    <div class="col-sm-4">
                                        <label for="recipient-name" class="col-form-label">Ordem de Serviço</label>
                                        <input type="text" class="form-control text-bg-light" id="ordem-de-servico" value="Não Associada" readonly>
                                    </div>

                                    <div class="col-sm-4">
                                        <label for="recipient-name" class="col-form-label">Data e Hora</label>
                                        <input type="text" class="form-control text-bg-light" id="Data" pattern="dd/MM/yyyy - HH:mm:ss" value="<fmt:formatDate value="${chamado.dataHora}" pattern="dd/MM/yyyy - HH:mm:ss" />" readonly>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <div class="row text-left">
                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                    <button type="button" class="btn btn-secondary" data-bs-toggle="modal"
                                            data-bs-target="#associarModal<c:out value="${chamado.id}"/>">Associar</button>
                                    <button type="button" class="btn btn-warning" data-bs-toggle="modal"
                                            data-bs-target="#novaOrdemDeServicoModal<c:out value="${chamado.id}"/>">Nova Ordem De Serviço</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>



        <!--********** MODAL CHAMADO EM ANDAMENTO **************-->
        <c:forEach var="chamados" items="${requestScope.listaChamadosDesc}">
        <div class="modal fade" id="chamadoEmAndamentoModal<c:out value="${chamado.id}"/>" data-bs-keyboard="false" tabindex="-1" aria-labelledby="chamadoEmAndamentoModalLabel"
             aria-hidden="true">

            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <div class="row">
                            <div class="col-sm-8">
                                <div class="w-50">
                                    <p class="text-body-secondary" id="chamadoEmAndamentoModal">Chamado</p>
                                </div>
                            </div>
                            <div class="col-sm-2">
                                <p>Id Chamado</p>
                            </div>
                            <div class="col-sm-2">
                                <p class="text-center"><c:out value="${chamados.id}"/></p>
                            </div>
                        </div>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <div class="modal-body">


                        <div class="container">

                            <div class="row">
                                <div class="col-sm-12">
                                    <label for="recipient-name" class="col-form-label">Usuario</label>
                                    <input type="text" class="form-control text-bg-light" value="${chamados.usuarioId.nome}" id="recipient-name" readonly>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <label for="recipient-name" class="col-form-label">Campus</label>
                                    <input type="text" class="form-control text-bg-light" id="campus-name" value="${chamados.predioId.campusId.nome}" readonly>
                                </div>

                                <div class="col-sm-6">
                                    <label for="recipient-name" class="col-form-label">Prédio</label>
                                    <input type="text" class="form-control text-bg-light" id="predio-name" value="${chamados.predioId.nome}" readonly>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <label for="message-text" class="col-form-label">Descrição do Local</label>
                                    <textarea class="form-control text-bg-light" id="local-text" readonly>${chamados.descricaoLocal}</textarea>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <label for="message-text" class="col-form-label">Descrição do Problema</label>
                                    <textarea class="form-control text-bg-light" id="problema-text" readonly>${chamados.descricaoProblema}</textarea>
                                </div>

                            </div>

                            <div class="row">
                                <div class="col-sm-4">
                                    <label for="recipient-name" class="col-form-label">Status</label>
                                    <input type="text" class="form-control text-bg-light" value="${chamados.statusId.nome}" id="status" readonly>
                                </div>

                                <div class="col-sm-4">
                                    <label for="recipient-name" class="col-form-label">Ordem de Serviço</label>
                                    <input type="text" class="form-control text-bg-light" value="${chamados.ordemServicoId.numeroOS}" id="ordem-de-servico" readonly>
                                </div>

                                <div class="col-sm-4">
                                    <label for="recipient-name" class="col-form-label">Data e Hora</label>
                                    <input type="text" class="form-control text-bg-light" id="Data" value="${chamados.dataHora}" readonly>
                                </div>
                            </div>

                            <!-- *********************** FOR EACH ********************** -->
                            <div class="row">
                                <div class="col-sm-12">
                                    <label for="message-text" class="col-form-label">Comentário Operário</label>
                                    <textarea class="form-control text-bg-light" id="problema-text" readonly></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="row text-left">
                            <div class="col">
                                <button type="button" class="btn btn-warning" data-bs-dismiss="modal" aria-label="Close">Fechar</button>
                            </div>

                        </div>

                    </div>

                </div>
            </div>
        </div>
        </c:forEach>
        <!--********** MODAL NOVA ORDEM DE SERVIÇO **************-->
        <c:forEach var="chamado" items="${requestScope.listaChamadosAsc}">
            <div class="modal fade" id="novaOrdemDeServicoModal<c:out value="${chamado.id}"/>" data-bs-backdrop="static" data-bs-keyboard="false"
                 tabindex="-1" aria-labelledby="novaOrdemDeServicoModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <div class="row">
                                <div class="col-sm-8">
                                    <div class="w-50">
                                        <p class="text-body-secondary" id="novaOrdemDeServicoModal">Nova Ordem de Serviço</p>

                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <p>Id Chamado</p>
                                </div>
                                <div class="col-sm-2">
                                    <p class="text-center"># <c:out value="${chamado.id}"/></p>
                                </div>
                            </div>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <form action="OrdemDeServicoServlet?action=novaOrdemServico" method="POST">
                            <div class="modal-body">


                                <input type="text" class="form-control text-bg-light" id="id-chamado" name="idChamado" value="<c:out value="${chamado.id}" />" hidden>

                                <div class="container">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label for="recipient-name" class="col-form-label">Campus:</label>
                                            <input type="text" class="form-control text-bg-light" id="campus-name" name="campus" value="<c:out value="${chamado.predioId.campusId.nome}" />" readonly>

                                        </div>

                                        <div class="col-sm-6">
                                            <label for="recipient-name" class="col-form-label">Predio</label>
                                            <input type="text" class="form-control text-bg-light" id="predio-name" name ="predionome" value="<c:out value="${chamado.predioId.nome}"/>" readonly>
                                            <input type="hidden" name="predio" value="<c:out value="${chamado.predioId.id}"/>">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <label for="message-text" class="col-form-label">Descrição do Local</label>
                                            <textarea class="form-control text-bg-light" id="local-text" name="descricaoLocal" required><c:out value="${chamado.descricaoLocal}"/></textarea>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-12">
                                            <label for="message-text" class="col-form-label">Descrição do Problema</label>
                                            <textarea class="form-control text-bg-light" id="problema-text" name="descricaoProblema" required><c:out value="${chamado.descricaoProblema}"/></textarea>
                                        </div>
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

                                    <div class="row">
                                        <div class="col">
                                            <label for="recipient-name" class="col-form-label">Digite aqui o número da Ordem de Serviço</label>
                                            <input type="text" class="form-control text-bg-light" id="ordem-de-servico" name="numeroOS" required>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="modal-footer">
                                <div class="row text-left">
                                    <div class="col-sm-4">
                                        <button type="submit" class="btn btn-warning" >Cadastrar</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>



        <!--********** MODAL ASSOCIAR **************-->
        <c:forEach var="chamado" items="${requestScope.listaChamadosAsc}">
            <div class="modal fade" id="associarModal<c:out value="${chamado.id}"/>" data-bs-keyboard="false" tabindex="-1"
                 aria-labelledby="associarModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <div class="row">
                                <div class="col-sm-8">
                                    <div class="w-50">
                                        <p class="text-body-secondary">Associar à Ordem de Serviço Existente</p>
                                    </div>
                                </div>
                                <div class="col-sm-2">
                                    <p>Id Chamado</p>
                                </div>
                                <div class="col-sm-2"> <p class="text-center"># <c:out value="${chamado.id}"/></p> 
                                </div>
                            </div>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>

                        <div class="modal-body">
                            <form>

                                <div class="container">


                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label for="recipient-name" class="col-form-label">Campus:</label>
                                            <input type="text" class="form-control text-bg-light" id="campus-name"  value="<c:out value="${chamado.predioId.campusId.nome}"/>" readonly>
                                        </div>

                                        <div class="col-sm-6">
                                            <label for="recipient-name" class="col-form-label">Predio</label>
                                            <input type="text" class="form-control text-bg-light" id="predio-name" value="<c:out value="${chamado.predioId.nome}"/>"  readonly>
                                        </div>
                                    </div>    
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <label for="message-text" class="col-form-label">Descrição do Local</label>
                                            <textarea class="form-control text-bg-light" id="local-text" readonly><c:out value="${chamado.descricaoLocal}"/></textarea>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-12">
                                            <label for="message-text" class="col-form-label">Descrição do Problema</label>
                                            <textarea class="form-control text-bg-light" id="problema-text" readonly><c:out value="${chamado.descricaoProblema}"/></textarea>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label for="recipient-name" class="col-form-label">Ordens de Serviço para o mesmo local</label>
                                        </div>
                                        <div class="list-group">
                                            <c:forEach var="ordem" items="${requestScope.ordens}">
                                                <c:if test="${empty ordem.dataFinalizacao && ordem.predioId.nome == chamado.predioId.nome && ordem.predioId.campusId.nome == chamado.predioId.campusId.nome}">
                                                    <span data-bs-placement="right"
                                                          data-bs-title="DescriçãoLocal: ${ordem.descricaoLocal}   DescriçãoProblema: ${ordem.descricaoProblema}"
                                                          data-bs-toggle="tooltip">
                                                        <button data-bs-target="#ordemDeServico2Modal<c:out value="${ordem.id}"/>" data-bs-toggle="modal"
                                                                type="button"
                                                                class="list-group-item list-group-item-action"># ${ordem.numeroOS}</button>
                                                    </span>
                                                </c:if>  
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <div class="modal-footer">
                            <div class="row text-left">

                                <div>
                                    <button type="button" class="btn btn-warning" data-bs-toggle="modal"
                                            data-bs-target="#novaOrdemDeServicoModal<c:out value="${chamado.id}"/>">Nova Ordem De Serviço</button>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>



        <!--********** MODAL ORDEM DE SERVIÇO **************-->

            <c:forEach var="ordem" items="${requestScope.ordens}">
                <div class="modal fade" id="ordemDeServico2Modal<c:out value="${ordem.id}"/>" data-bs-backdrop="static" tabindex="-1"
                     aria-labelledby="ordemDeServico2ModalLabel" aria-hidden="true">

                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <div class="row">
                                    <div class="col-sm-8">
                                        <div class="w-50">
                                            <p class="text-body-secondary">Ordem De Serviço</p>

                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                        <p>Id Ordem De Serviço</p>
                                    </div>
                                    <div class="col-sm-2">
                                        <p class="text-center">#<c:out value="${ordem.id}"/></p>
                                    </div>
                                </div>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>

                            <div class="modal-body">


                                <div class="container">


                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label for="recipient-name" class="col-form-label">Campus:</label>
                                            <input type="text" class="form-control text-bg-light" id="campus-name" value="<c:out value="${ordem.predioId.campusId.nome}"/>" readonly>
                                        </div>

                                        <div class="col-sm-6">
                                            <label for="recipient-name" class="col-form-label">Predio</label>
                                            <input type="text" class="form-control text-bg-light" id="predio-name" value="<c:out value="${ordem.predioId.nome}"/>" readonly>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <label for="message-text" class="col-form-label">Descrição do Local</label>
                                            <textarea class="form-control text-bg-light" id="local-text" readonly>"<c:out value="${ordem.descricaoLocal}"/>"</textarea>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-12">
                                            <label for="message-text" class="col-form-label">Descrição do Problema</label>
                                            <textarea class="form-control text-bg-light" id="problema-text" readonly>"<c:out value="${ordem.descricaoProblema}"/>"</textarea>
                                        </div>

                                    </div>

                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label for="recipient-name" class="col-form-label">Status</label>
                                            <input type="text" class="form-control text-bg-light" id="status" value="<c:out value="${ordem.statusId.nome}"/>" readonly>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <div class="row text-left">
                                    <div class="col">
                                        <button type="button" class="btn btn-secondary" data-bs-toggle="modal"
                                                data-bs-target="#associarModal">Associar</button>
                                    </div>
                                    <div class="col">
                                        <button type="button" class="btn btn-warning" data-bs-toggle="modal"
                                                data-bs-target="#novaOrdemDeServicoModal">Nova Ordem De Serviço</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>


        <!-- **************** triggers ******************* -->

        <script>
            const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
            const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))
        </script>


    </body>

</html>