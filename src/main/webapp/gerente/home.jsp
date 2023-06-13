<%-- 
    Document   : home
    Created on : 10 de jun de 2023, 13:49:55
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
        <title>Home - Gerente</title>

        <!-- Configurações da pagina (fim do head) e Cabeçalho da página -->

        <%@include file="header.jsp" %>

    <div class="user-dashboard">
        <div class="row">
            <!-- INICIO DE CONTEÚDO  -->

            <!-- quadros com quantidades -->

            <div class="col-md-3 p-2">
                <div class="list-group border border-danger">
                    <div class="list-group-item">
                        <p class="list-group-item-text">
                            Chamados abertos com mais de 10 dias sem Ordem de Serviço associada</p>
                        <h4 class="list-group-item-heading count">
                            ${requestScope.qtddChamadoMais10DiasSemOS}</h4>
                    </div>
                </div>
            </div>

            <div class="col-md-3 p-2">
                <div class="list-group">
                    <div class="list-group-item border border-danger">
                        <p class="list-group-item-text">
                            Total de chamados abertos com mais de 30 dias</p>
                        <h4 class="list-group-item-heading count">
                            ${requestScope.qtddChamadosMais30DiasAbertos}</h4>
                    </div>
                </div>
            </div>    


            <div class="col-md-3 p-2">
                <div class="list-group border border-danger">
                    <div class="list-group-item">
                        <p class="list-group-item-text">
                            Ordens de Serviço abertas com mais de 10 dias sem especialista associado</p>
                        <h4 class="list-group-item-heading count">
                            ${requestScope.qtddOSMais10DiasSemOP} </h4>
                    </div>
                </div>
            </div>

            <div class="col-md-3 p-2">
                <div class="list-group">
                    <div class="list-group-item border border-danger">
                        <p class="list-group-item-text">
                            Total de Ordens de Serviço abertas com mais de 30 dias</p>
                        <h4 class="list-group-item-heading count">
                            ${requestScope.qtddOSMais30DiasAbertos}</h4>
                    </div>
                </div>
            </div>   


            <div class="col-md-3 p-2">
                <div class="list-group">
                    <div class="list-group-item">
                        <p class="list-group-item-text">
                            Total de chamados abertos sem Ordem de Serviço associada</p>
                        <h4 class="list-group-item-heading count">
                            ${requestScope.qtddChamadoAbertosSemOS}</h4>
                    </div>
                </div>
            </div>

            <div class="col-md-3 p-2">
                <div class="list-group">
                    <div class="list-group-item">
                        <p class="list-group-item-text">
                            Total de chamados abertos</p>
                        <h4 class="list-group-item-heading count">
                            ${requestScope.qtddChamadoAbertos}</h4>
                    </div>
                </div>
            </div>

            <div class="col-md-3 p-2">
                <div class="list-group">
                    <div class="list-group-item">
                        <p class="list-group-item-text">
                            Total de Ordens de Serviço abertas</p>
                        <h4 class="list-group-item-heading count">
                            ${requestScope.qtddOSAbertos} </h4>
                    </div>
                </div>

            </div>

            <div class="col-md-3 p-2">
                <div class="list-group">
                    <div class="list-group-item">
                        <p class="list-group-item-text">
                            Total de Ordens de Serviço em Andamento (Com especialista associado)</p>
                        <h4 class="list-group-item-heading count">
                            ${requestScope.qtddOSAndamento}
                        </h4>
                    </div>
                </div>
            </div>




            <div class="col-md-6 py-2">
                <div class="list-group">
                    <div class="list-group-item">
                        <h3 class="pull-right">
                            <i class="fa fa-bar-chart" aria-hidden="true"></i>
                        </h3>
                        <p class="list-group-item-text"> Dados referentes aos chamados abertos no ano (${requestScope.anoAtual}) </p>
                        <h4 class="list-group-item-heading count">
                            ${requestScope.qtddChamadoEncerradoAno} /  ${qtddChamadoAno} 
                        </h4>
                        <p class="list-group-item-text">
                            Quantidade de chamados encerrados / Quantidade de chamados </p>
                    </div>
                </div>
            </div>

            <div class="col-md-3 p-2">
                <div class="list-group border border-success">
                    <div class="list-group-item">
                        <p class="list-group-item-text">
                            Quantidade de Ordens de Serviço encerradas nos ultimos 30 dias</p>
                        <h4 class="list-group-item-heading count">
                            ${requestScope.qtddOSEncerradoUltimos30Dias}</h4>
                    </div>
                </div>
            </div>

            <div class="col-md-3 p-2">
                <div class="list-group">
                    <div class="list-group-item border border-success">
                        <p class="list-group-item-text">
                            Quantidade de Ordens de Serviço encerradas no Ano (${requestScope.anoAtual})</p>
                        <h4 class="list-group-item-heading count">
                            ${requestScope.qtddOSEncerradoAno} </h4>
                    </div>
                </div>
            </div>  



            <div class="col-md-6  py-2">
                <div class="list-group">
                    <div class="list-group-item">
                        <h4>Especialidadedes</h4>
                        <h6>Maiores Ofensores</h6>
                        <table class="table table-striped table-success table-hover text-center">
                            <thead>
                                <tr class="table-primary">
                                    <th scope="col">#</th>
                                    <th scope="col">Especialidade</th>
                                    <th scope="col">nº de Ordens De Serviço</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="row" items="${requestScope.top3Especialidades}" varStatus="loop">
                                    <tr>
                                        <th scope="row">${loop.index + 1}</th>
                                        <td><c:out value="${row.especialidade}" /></td>
                                        <td><c:out value="${row.count}" /></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="col-md-6  py-2">
                <div class="list-group">
                    <div class="list-group-item">
                        <h4>Prédios</h4>
                        <h6>Maiores Ofensores</h6>
                        <table class="table table-striped table-success table-hover text-center">
                            <thead>
                                <tr class="table-primary">
                                    <th scope="col">#</th>
                                    <th scope="col">Campus/Predio</th>
                                    <th scope="col">nº de Ordens De Serviço</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="row" items="${requestScope.top3PrediosOS}" varStatus="loop">
                                    <tr>
                                        <th scope="row">${loop.index + 1}</th>
                                        <td><c:out value="${row.predio}" /></td>
                                        <td><c:out value="${row.count}" /></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>