<%-- 
    Document   : ordemDeServico
    Created on : 4 de jun de 2023, 17:53:43
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
        <title>Ordens de Serviço - Administrador</title>

        <!-- Configurações da pagina (fim do head) e Cabeçalho da página -->
        <%@include file="header.jsp" %>

        <!-- Corpo da página -->


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
                    <th>Campus</th>
                    <th>Operário</th>
                    <th>Especialidade</th>
                    <th>Status</th>
                    <th>Detalhes</th>
                </tr>
            </thead>
            <tbody data-bs-toggle="modal" data-bs-target="#modalOdermDeServico">
                <c:forEach var="ordem" items="${requestScope.ordensDeServico}">
                    <tr>
                        <td>
                            <p class="fw-normal mb-1">
                                <c:out value="${ordem.id}" />
                            </p>
                        </td>


                        <td>
                            <p class="fw-normal mb-1">
                                <c:out value="${ordem.campus.nome}" />
                            </p>
                        </td>

                        <td>
                            <p class="fw-normal mb-1">
                                <c:out value="${ordem.operario.nome}" />
                            </p>
                        </td>
                        <td>
                            <p class="fw-normal mb-1">
                                <c:out value="${ordem.operario.especialidade}" />
                            </p>
                        </td>
                        <td>
                            <p class="fw-normal mb-1">
                                <c:out value="${ordem.status.nome}" />
                            </p>
                        </td>
                        <td>
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalOdermDeServico">
                                Detalhes
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>



    <!--********** MODAL Ordem de Serviço**************-->

    <div class="modal fade" id="modalOdermDeServico"  data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="chamadoModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="w-50">
                                <p class="text-body-secondary">Ordem de Serviço</p>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <p>Id Ordem de Serviço</p>
                        </div>
                        <div class="col-sm-2">
                            <p class="text-center">#20203659</p>
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
                                    <input type="text" class="form-control text-bg-light" id="campus-name" readonly>
                                </div>

                                <div class="col-sm-6">
                                    <label for="recipient-name" class="col-form-label">Predio</label>
                                    <input type="text" class="form-control text-bg-light" id="predio-name" readonly>
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
                                    <textarea class="form-control text-bg-light" id="problema-text" readonly></textarea>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-4">
                                    <label for="recipient-name" class="col-form-label">Status</label>
                                    <input type="text" class="form-control text-bg-light" id="status" readonly>
                                </div>


                                <div class="col-sm-4">
                                    <label for="recipient-name" class="col-form-label">Data e Hora</label>
                                    <input type="text" class="form-control text-bg-light" id="Data" readonly>
                                </div>
                            </div>
                            <!-- ***************** FOR EACH COMENTÁRIO ************************** -->
                            <div class="row">
                                <div class="col-sm-12">
                                    <label for="message-text" class="col-form-label">Comentário Operário</label>
                                    <textarea class="form-control text-bg-light" id="problema-text" readonly></textarea>
                                </div>
                            </div>
                    </form>
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
</body>
</html>

