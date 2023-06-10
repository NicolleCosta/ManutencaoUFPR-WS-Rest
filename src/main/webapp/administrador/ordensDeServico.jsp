<%-- 
    Document   : ordemDeServico
    Created on : 4 de jun de 2023, 17:53:43
    Author     : nicol
--%>


<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<!-- Validar se usuário está logado -->
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
        <title>Ordens de Serviço - Administrador</title>

        <!-- Configurações da pagina (fim do head) e Cabeçalho da página -->

        <%@include file="header.jsp" %>
    </head>
    <body>

        <div class="w-100">
            <h1 class="text-center">Ordem De Serviço</h1>
        </div>

        <div class="container text-center">
            <div class="row">
                <div class="col-sm-8">
                    <form class="d-flex" role="search">
                        <input class="form-control me-2" type="search" placeholder="Buscar Ordem De Serviço" aria-label="Search">
                        <button class="btn btn-warning" type="submit">Buscar</button>
                    </form>
                </div>
            </div>
        </div>

        <div class="table-secondary">
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
                        <tr>
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

        <!-- Modals -->
        <c:forEach var="o" items="${requestScope.ordensServico}">
            <div class="modal fade" data-bs-keyboard="false" tabindex="-1" aria-labelledby="ordemModalLabel"
                 aria-hidden="true" id="modalOrdemDeServico${o.id}">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="w-50">
                                        <p class="text-body-secondary">Ordem de Serviço</p>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <p>Nº Ordem de Serviço</p>
                                </div>
                                <div class="col-sm-6">
                                    <p class="text-center"># <c:out value="${o.numeroOS}"/></p>
                                </div>
                            </div>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>

                        <div class="modal-body">
                            <div class="container">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label for="recipient-name" class="col-form-label">Campus:</label>
                                        <input type="text" class="form-control text-bg-light" id="campus-name" value ="${o.predioId.campusId.nome}" readonly>
                                    </div>
                                    <div class="col-sm-6">
                                        <label for="recipient-name" class="col-form-label">Prédio</label>
                                        <input type="text" class="form-control text-bg-light" id="predio-name" value ="${o.predioId.nome}" readonly>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label for="message-text" class="col-form-label">Descrição do Local</label>
                                        <textarea class="form-control text-bg-light" id="local-text" readonly><c:out value="${o.descricaoLocal}"/></textarea>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label for="message-text" class="col-form-label">Descrição do Problema</label>
                                        <textarea class="form-control text-bg-light" id="problema-text" readonly><c:out value="${o.descricaoProblema}"/></textarea>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-4">
                                        <label for="recipient-name" class="col-form-label">Data Abertura</label>
                                        <fmt:formatDate value="${o.dataAbertura}" pattern="dd/MM/yyyy" var="formattedDate"/>
                                        <input type="text" class="form-control text-bg-light" id="Data" value="${formattedDate}" readonly>
                                    </div>
                                    <div class="col-sm-4">
                                        <label for="recipient-name" class="col-form-label">Data Finalização</label>
                                        <fmt:formatDate value="${o.dataFinalizacao}" pattern="dd/MM/yyyy" var="formattedDate"/>
                                        <input type="text" class="form-control text-bg-light" id="Data" value="${formattedDate}" readonly>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label for="recipient-name" class="col-form-label">Especialidade:</label>
                                            <input type="text" class="form-control text-bg-light" id="campus-name" value ="${o.especialidadeId.nome}" readonly>
                                        </div>
                                        <div class="col-sm-6">
                                            <label for="recipient-name" class="col-form-label">Operário</label>
                                            <input type="text" class="form-control text-bg-light" id="predio-name" value ="${o.usuarioOperarioId.nome}" readonly>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label for="message-text" class="col-form-label">Comentário Operário</label>
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
                            <div class="row text-left">
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
