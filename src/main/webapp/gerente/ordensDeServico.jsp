<%-- 
    Document   : ordensDeServico
    Created on : 10 de jun de 2023, 13:56:10
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
        <title>Ordens de Serviço - Gerente</title>

        <!-- Configurações da pagina (fim do head) e Cabeçalho da página -->

        <%@include file="header.jsp" %>

    <div class="w-100 p-3">
        <h1 class="text-primary text-center fw-bold ">Ordem de Serviço</h1>
    </div>

    <div class="row p-3">
        <div class="col-4 justify-content-md-end">
            <form class="d-flex" role="search">
                <input class="form-control me-2" type="search" placeholder="Buscar Ordem De Serviço"
                       aria-label="Search">
                <button class="btn btn-warning fw-bold" type="submit">Buscar</button>
            </form>
        </div>





        <div class="container-fluid display-table p-3">
            <div class="row display-table-row">

                <!-- tabela -->
                <div class="table-container" style="max-height: 300px; overflow-y: auto;"></div>
                    <div class="table-secondary table-sm p-3 text-center">
                        <table class="table align-middle mb-0 bg-white table-hover">
                            <thead class="bg-light">
                                <tr>
                                    <th>Ordem de Serviço</th>
                                    <th>Data abertura</th>
                                    <th>Especialidade</th>
                                    <th>Operário</th>
                                    <th>Status</th>
                                    <th>Detalhes</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="o" items="${requestScope.ordensServico}">
                                    <tr data-bs-toggle="modal" data-bs-target="#modalOrdemDeServico${o.id}">
                                        <td>
                                            <p class="fw-normal mb-1">
                                                <c:out value="${o.numeroOS}"/>
                                            </p>
                                        </td>
                                        <td>
                                            <p class="fw-normal mb-1">
                                                <fmt:formatDate value="${o.dataAbertura}" pattern="dd/MM/yyyy"/>
                                            </p>
                                        </td>
                                        <td>
                                            <p class="fw-normal mb-1">
                                                <c:out value="${o.especialidadeId.nome}" />
                                            </p>
                                        </td>
                                        <td>
                                            <p class="fw-normal mb-1">
                                                <c:out value="${o.usuarioOperarioId.nome}" />
                                            </p>
                                        </td>
                                        <td>
                                            <span class="badge badge-sm c-status"
                                                style="background-color:
                                                <c:choose>
                                                    <c:when test="${o.dataFinalizacao eq null}">
                                                        orange
                                                    </c:when>
                                                    <c:otherwise>
                                                        green
                                                    </c:otherwise>
                                                </c:choose>;">
                                                <c:choose>
                                                    <c:when test="${o.dataFinalizacao eq null}">
                                                        Aberta
                                                    </c:when>
                                                    <c:otherwise>
                                                        Finalizada
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                        </td>
                                        <td>
                                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalOrdemDeServico${o.id}">
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


    <!-- Modals -->
    <c:forEach var="o" items="${requestScope.ordensServico}">
        <div class="modal fade" data-bs-keyboard="false" tabindex="-1" aria-labelledby="ordemModalLabel"
             aria-hidden="true" id="modalOrdemDeServico${o.id}">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <div class="row">
                            <h3 class="modal-title text-primary">Ordem de Serviço</h3>
                        </div>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <div class="modal-body">
                        <div class="container">
                            <div class="row justify-content-end">
                                <div class="col-sm-4 text-sm-end">
                                    <p class="fw-bold">Nº Ordem de Serviço</p>
                                </div>
                                <div class="col-sm-4">
                                    <input type="text"id="numero-os" class="form-control text-bg-light" value="${o.numeroOS}" readonly>
                                </div>
                            </div>
                            <div class="row py-2">
                                <div class="col-sm-6">
                                    <label class="col-form-label fw-bold">Campus</label>
                                    <input type="text" class="form-control text-bg-light" id="campus-name" value ="${o.predioId.campusId.nome}" readonly>
                                </div>
                                <div class="col-sm-6">
                                    <label class="col-form-label fw-bold ">Prédio</label>
                                    <input type="text" class="form-control text-bg-light" id="predio-name" value ="${o.predioId.nome}" readonly>
                                </div>
                            </div>
                            <div class="row py-2">
                                <div class="col-sm-12">
                                    <label class="col-form-label fw-bold ">Descrição do Local</label>
                                    <textarea class="form-control text-bg-light" id="local-text" readonly>${o.descricaoLocal}</textarea>
                                </div>
                            </div>
                            <div class="row py-2">
                                <div class="col-sm-12">
                                    <label class="col-form-label fw-bold ">Descrição do Problema</label>
                                    <textarea class="form-control text-bg-light" id="problema-text" readonly>${o.descricaoProblema}</textarea>
                                </div>
                            </div>
                            <div class="row py-2">
                                <div class="col-sm-6">
                                    <label  class="col-form-label fw-bold ">Data Abertura</label>
                                    <fmt:formatDate value="${o.dataAbertura}" pattern="dd/MM/yyyy" var="formattedDate"/>
                                    <input type="text" class="form-control text-bg-light" id="Data" value="${formattedDate}" readonly>
                                </div>
                                <div class="col-sm-6">
                                    <label  class="col-form-label fw-bold ">Data Finalização</label>
                                    <fmt:formatDate value="${o.dataFinalizacao}" pattern="dd/MM/yyyy" var="formattedDate"/>
                                    <input type="text" class="form-control text-bg-light" id="Data" value="${formattedDate}" readonly>
                                </div>
                            </div>
                            <div class="row py-2">
                                <div class="col-sm-6">
                                    <label class="col-form-label fw-bold ">Especialidade</label>
                                    <input type="text" class="form-control text-bg-light" id="campus-name" value ="${o.especialidadeId.nome}" readonly>
                                </div>
                                <div class="col-sm-6">
                                    <label class="col-form-label fw-bold ">Operário</label>
                                    <input type="text" class="form-control text-bg-light" id="predio-name" value ="${o.usuarioOperarioId.nome}" readonly>
                                </div>
                            </div>

                            <div class="row py-2">
                                <div class="col-sm-12">
                                    <label class="col-form-label fw-bold ">Comentário Operário</label>
                                    <c:forEach var="comentario" items="${requestScope.comentarios}">
                                        <c:if test="${comentario.ordemServicoId.id == o.id }">
                                            <textarea class="form-control text-bg-light" id="problema-text" readonly><fmt:formatDate value="${comentario.dataHora}" pattern="dd/MM/yyyy HH:mm:ss" var="formattedDateTime"/><c:out value="${formattedDateTime} : ${comentario.descricao} " /></textarea>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="row text-left py-2">
                            <div class="col-sm-4">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" aria-label="Close">Fechar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</body>
</html>
