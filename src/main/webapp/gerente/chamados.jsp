<%-- 
    Document   : chamado
    Created on : 10 de jun de 2023, 13:52:32
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
        <title>Home - Administrador</title>

        <!-- Configurações da pagina (fim do head) e Cabeçalho da página -->

        <%@include file="header.jsp" %>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

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
                <h2 class="text-center fw-bold text-warning p-3">Chamados Sem Ordem De Serviço
                    Associada</h2>
            </div>

            <!-- tabela -->
            <div class="table-secondary table-sm p-3 text-center">
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
    </div>


    <!-- *********************Chamados Com Ordem de Serviço Associada ********************** -->

    <div class="container-fluid display-table p-3">
        <div class="row display-table-row">
            <div class="w-100">
                <h2 class="text-center fw-bold text-warning p-3">Chamados Com Ordem de Serviço
                    Associada</h2>
            </div>

            <!-- tabela -->
            <div class="table-secondary table-sm p-3 text-center">
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
                                        <button  type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#chamadoEmAndamentoModal<c:out value="${chamados.id}"/>">
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




    <!--********** MODAL CHAMADOS ABERTOS / SEM ORDEM DE SERVIÇO ASSOCIADA **************-->
    <c:forEach var="chamado" items="${requestScope.listaChamadosAsc}">
        <div class="modal fade" data-bs-keyboard="false" tabindex="-1" aria-labelledby="chamadoModalLabel"
             aria-hidden="true"   id="chamadoModal<c:out value="${chamado.id}"/>">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <div class="row">
                            <h3 class="modal-title text-primary">Chamado</h3>
                        </div>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <div class="modal-body">


                        <div class="container">
                            <div class="row justify-content-end">
                                <div class="col-sm-4 text-sm-end">
                                    <p class="fw-bold">Nº Chamado</p>
                                </div>
                                <div class="col-sm-4">
                                    <input type="text"id="numero-os" class="form-control text-bg-light" value="${chamado.id}" readonly>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <label for="recipient-name" class="fw-bold col-form-label">Usuario</label>
                                    <input type="text" class="form-control text-bg-light" id="recipient-name" value="<c:out value="${chamado.usuarioId.nome}"/>" readonly>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <label for="recipient-name" class="col-form-label fw-bold">Campus</label>
                                    <input type="text" class="form-control text-bg-light" id="campus-name" value="<c:out value="${chamado.predioId.campusId.nome}" />" readonly>
                                </div>

                                <div class="col-sm-6">
                                    <label for="recipient-name" class="col-form-label fw-bold">Prédio</label>
                                    <input type="text" class="form-control text-bg-light" id="predio-name" value="<c:out value="${chamado.predioId.nome}"/>" readonly>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <label for="message-text" class="col-form-label fw-bold">Descrição do Local</label>
                                    <textarea class="form-control text-bg-light" id="local-text" readonly><c:out value="${chamado.descricaoLocal}"/></textarea>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <label for="message-text" class="col-form-label fw-bold">Descrição do Problema</label>
                                    <textarea class="form-control text-bg-light" id="problema-text" readonly><c:out value="${chamado.descricaoProblema}"/></textarea>
                                </div>

                            </div>

                            <div class="row">
                                <div class="col-sm-4">
                                    <label for="recipient-name" class="col-form-label fw-bold">Status</label>
                                    <input type="text" id="status" readonly class="form-control text-bg-warning" value="${chamado.statusId.nome}"> 
                                </div>

                                <div class="col-sm-4">
                                    <label for="recipient-name" class="col-form-label fw-bold">Ordem de Serviço</label>
                                    <input type="text" class="form-control text-bg-light" id="ordem-de-servico" value="Não Associada" readonly>
                                </div>

                                <div class="col-sm-4">
                                    <label for="recipient-name" class="col-form-label fw-bold">Data e Hora</label>
                                    <input type="text" class="form-control text-bg-light" id="Data" pattern="dd/MM/yyyy - HH:mm:ss" value="<fmt:formatDate value="${chamado.dataHora}" pattern="dd/MM/yyyy - HH:mm:ss" />" readonly>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="row text-left">
                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <button type="button" class="btn btn-primary fw-bold btn-lg" data-bs-toggle="modal"
                                        data-bs-target="#associarModal${chamado.id}">Associar</button>
                                <button type="button" class="btn btn-warning fw-bold btn-lg" data-bs-toggle="modal"
                                        data-bs-target="#novaOrdemDeServicoModal<c:out value="${chamado.id}"/>">Nova Ordem De Serviço</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>



    <!--********** MODAL CHAMADO EM ANDAMENTO / COM ORDEM DE SERVIÇO ASSOCIADA **************-->
    <c:forEach var="chamados" items="${requestScope.listaChamadosDesc}">
        <div class="modal fade" id="chamadoEmAndamentoModal<c:out value="${chamados.id}"/>" data-bs-keyboard="false" tabindex="-1" aria-labelledby="chamadoEmAndamentoModalLabel"
             aria-hidden="true">

            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <div class="row">
                            <h3 class="modal-title text-primary">Chamado</h3>
                        </div>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <div class="modal-body">


                        <div class="container">
                            <div class="row justify-content-end">
                                <div class="col-sm-4 text-sm-end">
                                    <p class="fw-bold">Nº Chamado</p>
                                </div>
                                <div class="col-sm-4">
                                    <input type="text" id="numero-os" class="form-control text-bg-light" value="${chamados.id}" readonly>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <label class="fw-bold col-form-label">Usuario</label>
                                    <input type="text" class="form-control text-bg-light" value="${chamados.usuarioId.nome}" id="recipient-name" readonly>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <label class=" fw-bold col-form-label">Campus</label>
                                    <input type="text" class="form-control text-bg-light" id="campus-name" value="${chamados.predioId.campusId.nome}" readonly>
                                </div>

                                <div class="col-sm-6">
                                    <label class="fw-bold col-form-label">Prédio</label>
                                    <input type="text" class="form-control text-bg-light" id="predio-name" value="${chamados.predioId.nome}" readonly>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <label class="fw-bold col-form-label">Descrição do Local</label>
                                    <textarea class="form-control text-bg-light" id="local-text" readonly>${chamados.descricaoLocal}</textarea>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <label class="fw-bold col-form-label">Descrição do Problema</label>
                                    <textarea class="form-control text-bg-light" id="problema-text" readonly>${chamados.descricaoProblema}</textarea>
                                </div>

                            </div>

                            <div class="row">
                                <div class="col-sm-4">
                                    <label class="fw-bold col-form-label">Status</label>
                                    <input type="text" class="form-control text-bg-warning" value="${chamados.statusId.nome}" id="status" readonly>
                                </div>

                                <div class="col-sm-4">
                                    <label class="fw-bold col-form-label">Ordem de Serviço</label>
                                    <input type="text" class="form-control text-bg-primary fw-bold" value="${chamados.ordemServicoId.numeroOS}" id="ordem-de-servico" readonly>
                                </div>

                                <div class="col-sm-4">
                                    <label class="fw-bold col-form-label">Data e Hora</label>
                                    <input type="text" class="form-control text-bg-light" id="Data" value="<fmt:formatDate value="${chamados.dataHora}" pattern="dd/MM/yyyy - HH:mm:ss" />" readonly>
                                </div>
                            </div>     
                            <div class="row p-2">
                                <div class="col-sm-12">
                                    <label class="col-form-label fw-bold">Comentário Operário</label>
                                    <c:forEach var="comentario" items="${requestScope.comentarios}">
                                        <c:if test="${chamados.ordemServicoId.id == comentario.ordemServicoId.id}">
                                            <textarea class="form-control text-bg-light" id="problema-text" readonly><fmt:formatDate value="${comentario.dataHora}" pattern="dd/MM/yyyy HH:mm:ss" var="formattedDateTime"/><c:out value="${formattedDateTime} : ${comentario.descricao} " /></textarea>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="row text-left">
                            <div class="col">
                                <button type="button" class="btn btn-secondary fw-bold" data-bs-dismiss="modal" aria-label="Close">Fechar</button>
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
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <div class="row">
                            <h3 class="modal-title text-primary">Nova Ordem de Serviço</h3>
                        </div>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="OrdemDeServicoServlet?action=novaOrdemServico" method="POST">

                        <div class="modal-body">

                            <div class="row justify-content-end">
                                <div class="col-sm-4 text-sm-end">
                                    <p class="fw-bold">Nº Chamado</p>
                                </div>
                                <div class="col-sm-4">
                                    <input type="text"id="id-chamado" class="form-control text-bg-light" value="${chamado.id}" readonly>
                                </div>
                            </div>

                            <div class="container">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label for="recipient-name" class="col-form-label fw-bold">Campus</label>
                                        <input type="text" class="form-control text-bg-light" id="campus-name" name="campus" value="<c:out value="${chamado.predioId.campusId.nome}" />" readonly>

                                    </div>

                                    <div class="col-sm-6">
                                        <label for="recipient-name" class="col-form-label fw-bold">Prédio</label>
                                        <input type="text" class="form-control text-bg-light" id="predio-name" name ="predionome" value="<c:out value="${chamado.predioId.nome}"/>" readonly>
                                        <input type="hidden" name="predio" value="<c:out value="${chamado.predioId.id}"/>">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label for="message-text" class="col-form-label fw-bold">Descrição do Local</label>
                                        <textarea class="form-control text-bg-light" id="local-text" name="descricaoLocal" required><c:out value="${chamado.descricaoLocal}"/></textarea>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-sm-12">
                                        <label for="message-text" class="col-form-label fw-bold">Descrição do Problema</label>
                                        <textarea class="form-control text-bg-light" id="problema-text" name="descricaoProblema" required><c:out value="${chamado.descricaoProblema}"/></textarea>
                                    </div>
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
                                        <br>
                                    </div>

                                </div>

                                <div class="row">
                                    <div class="col">
                                        <label for="recipient-name" class="col-form-label fw-bold text-primary">Digite aqui o número da Ordem de Serviço</label>
                                        <input type="text" class="form-control text-bg-primary fw-bold text-dark p-3" style="--bs-bg-opacity: .25;" id="ordem-de-servico" name="numeroOS" required>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <div class="row text-left">
                                <div class="col-sm-4">
                                    <button type="submit" class="btn btn-warning fw-bold btn-lg" >Cadastrar</button>
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
        <div class="modal fade" id="associarModal${chamado.id}" data-bs-keyboard="false" tabindex="-1"
             aria-labelledby="associarModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <div class="row">                        
                            <h3 class="modal-title text-primary">Associar à Ordem de Serviço <strong class="text-primary">Existente</strong></h3>
                        </div>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <div class="modal-body">

                        <div class="container">                                
                            <div class="row justify-content-end">
                                <div class="col-sm-4 text-sm-end">
                                    <p class="fw-bold">Nº Chamado</p>
                                </div>
                                <div class="col-sm-4">
                                    <input type="text" id="numero-ch" class="form-control text-bg-light" name="idChamado" value="${chamado.id}" readonly>
                                </div>
                            </div>


                            <div class="row">
                                <div class="col-sm-6">
                                    <label class="col-form-label fw-bold">Campus</label>
                                    <input type="text" class="form-control text-bg-light" id="campus-name"  value="${chamado.predioId.campusId.nome}" readonly>
                                </div>

                                <div class="col-sm-6">
                                    <label class="col-form-label fw-bold">Prédio</label>
                                    <input type="text" class="form-control text-bg-light" id="predio-name" value="${chamado.predioId.nome}"  readonly>
                                </div>
                            </div>    
                            <div class="row">
                                <div class="col-sm-12">
                                    <label class="col-form-label fw-bold">Descrição do Local</label>
                                    <textarea class="form-control text-bg-light" id="local-text" readonly>${chamado.descricaoLocal}</textarea>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <label class="col-form-label fw-bold">Descrição do Problema</label>
                                    <textarea class="form-control text-bg-light" id="problema-text" readonly>${chamado.descricaoProblema}</textarea>
                                </div>
                            </div>

                            <div class="row">
                                <label class="col-form-label text-primary fw-bold">Ordens de Serviço para o mesmo local</label>

                                <c:set var="conditionSatisfied" value="false" />
                                <div class="accordion" id="accordionExample">
                                    <c:forEach var="ordem" items="${requestScope.ordens}">
                                        <c:if test="${empty ordem.dataFinalizacao && ordem.predioId.nome == chamado.predioId.nome && ordem.predioId.campusId.nome == chamado.predioId.campusId.nome}">
                                            <div class="accordion-item">

                                                <h2 class="accordion-header" id="heading${ordem.numeroOS}">
                                                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${ordem.numeroOS}" aria-expanded="true" aria-controls="collapse${ordem.numeroOS}">
                                                        #${ordem.numeroOS} -  <strong> Descrição do Local: </strong>  ${ordem.descricaoLocal}
                                                    </button>
                                                </h2>
                                                <div id="collapse${ordem.numeroOS}" class="accordion-collapse collapse" aria-labelledby="heading${ordem.numeroOS}" data-bs-parent="#accordionExample">
                                                    <div class="accordion-body">
                                                        <form action="OrdemDeServicoServlet?action=associarOrdemServico" method="POST">
                                                            <table class="table">
                                                                <thead>
                                                                <th scope="col">Descrição Problema</th>
                                                                <th>Especialidade</th>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>                                                            
                                                                        <td>${ordem.descricaoProblema}</td>
                                                                        <td>${ordem.especialidadeId.nome}</td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                            <input type="text" id="chamadoId" class="form-control text-bg-light" name="chamado" value="${chamado.id}" hidden>
                                                            <input type="text" id="numero-os" class="form-control text-bg-light" name="numero" value="${ordem.numeroOS}" hidden>

                                                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                                                <button type="submit" class="btn btn-primary btn-sm">Associar</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                            <c:set var="conditionSatisfied" value="true" />
                                        </c:if>
                                    </c:forEach>
                                </div>
                                <c:if test="${!conditionSatisfied}">
                                    <div class="alert alert-danger" role="alert">
                                        Não temos Ordens de Serviço ativas para o local indicado.
                                    </div>
                                </c:if>

                            </div>
                        </div>


                    </div>

                    <div class="modal-footer">
                        <div class="row text-left">

                            <div>
                                <button type="button" class="btn btn-warning fw-bold btn-lg" data-bs-toggle="modal"
                                        data-bs-target="#novaOrdemDeServicoModal<c:out value="${chamado.id}"/>">Nova Ordem De Serviço</button>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>

</body>
</html>