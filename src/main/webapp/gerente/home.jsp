<%-- Document : home Created on : 10 de jun de 2023, 13:49:55 Author : nicol --%>

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
                                    <c:param name="msg"
                                        value="Usuário não possui permissão para acessar essa página." />
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
                           
                           

  
                                <div class="user-dashboard p-3">
                                    <div class="row">
                                        <!-- INICIO DE CONTEÚDO  -->

                                        <!-- quadros com quantidades -->
                                        <div class="col-6">
                                            <div class="card p-3 text-bg-primary">
                                                <h5 class="card-title">Chamados</h5>
                                                <div class="row">
                                                    <div class="col-6 p-2">
                                                        <div class="list-group">
                                                            <div class="list-group-item">
                                                                <p class="list-group-item-text">
                                                                    Total Abertos</p>
                                                                <p></p>
                                                                <h4 class="list-group-item-heading count">
                                                                    ${requestScope.qtddChamadoAbertos}</h4>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-6 p-2">
                                                        <div class="list-group">
                                                            <div class="list-group-item">
                                                                <p class="list-group-item-text">
                                                                    Total Abertos Mais de 30 Dias</p>
                                                                <h4
                                                                    class="list-group-item-heading count text-danger fw-bold">
                                                                    ${requestScope.qtddChamadosMais30DiasAbertos}</h4>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                                <div class="row">

                                                    <div class="col-6 p-2">
                                                        <div class="list-group">
                                                            <div class="list-group-item">
                                                                <p class="list-group-item-text">
                                                                    Total Sem Ordem de Serviço Associada
                                                                </p>

                                                                <h4 class="list-group-item-heading count">
                                                                    ${requestScope.qtddChamadoAbertosSemOS}</h4>
                                                            </div>
                                                        </div>
                                                    </div>


                                                    <div class="col-6 p-2">
                                                        <div class="list-group">
                                                            <div class="list-group-item text-bg-warning">
                                                                <p class="list-group-item-text">
                                                                    Sem Ordem de Serviço Associada <strong>10
                                                                        Dias</strong></p>
                                                                <h4 class="list-group-item-heading count fw-bold">
                                                                    ${requestScope.qtddChamadoMais10DiasSemOS}</h4>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    
                                                    <div class="col-12 p-2">
                                                        
                                                        <div class="list-group">
                                                            <div class="list-group-item">
                                                                <h3 class="pull-right">
                                                                    <i class="fa fa-bar-chart" aria-hidden="true"></i>
                                                                </h3>
                                                                <h5>Totalizador Anual (${requestScope.anoAtual})</h5>
                                                                
                                                                    <h4 class="list-group-item-heading count text-primary d-inline">
                                                                        ${requestScope.qtddChamadoEncerradoAno}
                                                                    </h4>
                                                                    <p class="d-inline">Encerrados</p>
                                                                    <h4 class="list-group-item-heading count d-inline mr-2">
                                                                       /
                                                                    </h4>
                                                                    <h4 class="list-group-item-heading count text-primary d-inline mr-2">
                                                                        ${qtddChamadoAno}
                                                                    </h4>
                                                                    <p class="d-inline">Abertos</p>
                                                              
                                                            
                                                                <div class="progress" role="progressbar" aria-label="Warning example" aria-valuenow="${requestScope.qtddChamadoEncerradoAno}" aria-valuemin="0" aria-valuemax="${qtddChamadoAno}">
                                                                    <div class="progress-bar text-bg-warning fw-bold" style="width: ${requestScope.qtddChamadoEncerradoAno / qtddChamadoAno * 100}%"> <script>
                                                                        var percentage = (${requestScope.qtddChamadoEncerradoAno} / ${qtddChamadoAno} * 100).toFixed(2);
                                                                        document.write(percentage + '%');
                                                                    </script></div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>

                                        <div class="col-6">
                                            <div class="card p-3 text-bg-primary">
                                                <h5 class="card-title">Ordens de Serviço</h5>
                                                <div class="row">
                                                    <div class="col-6 p-2">
                                                        <div class="list-group">
                                                            <div class="list-group-item">
                                                                <p class="list-group-item-text">
                                                                    Total Abertas</p>
                                                                <h4 class="list-group-item-heading count">
                                                                    ${requestScope.qtddOSAbertos} </h4>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-6 p-2">
                                                        <div class="list-group">
                                                            <div class="list-group-item">
                                                                <p class="list-group-item-text">
                                                                    Total Abertas Mais de 30 dias</p>
                                                                <h4 class="list-group-item-heading count  text-danger">
                                                                    ${requestScope.qtddOSMais30DiasAbertos}</h4>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    
                                                    <div class="col-6 p-2">
                                                        <div class="list-group">
                                                            <div class="list-group-item">
                                                                <p class="list-group-item-text">
                                                                    Total Andamento (Especialista Associado)</p>
                                                                <h4 class="list-group-item-heading count">
                                                                    ${requestScope.qtddOSAndamento}
                                                                </h4>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-6 p-2">
                                                        <div class="list-group">
                                                            <div class="list-group-item text-bg-warning">
                                                                <p class="list-group-item-text">
                                                                    Abertas Sem Especialista Associado <strong>10 dias</strong></p>
                                                                <h4 class="list-group-item-heading count fw-bold">
                                                                    ${requestScope.qtddOSMais10DiasSemOP} </h4>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                                <div class="row">
                                        
                                                    
                                                    <div class="col-6 p-2">
                                                        <div class="list-group">
                                                            <div class="list-group-item">
                                                                <p class="list-group-item-text">
                                                                    Encerradas nos ultimos 30 dias
                                                                </p>
                                                                <h4 class="list-group-item-heading count">
                                                                    ${requestScope.qtddOSEncerradoUltimos30Dias}</h4>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-6 p-2">
                                                        <div class="list-group">
                                                            <div class="list-group-item text-bg-success">
                                                                <p class="list-group-item-text">
                                                                    Encerradas no Ano
                                                                    (${requestScope.anoAtual})</p>
                                                                <h4 class="list-group-item-heading count">
                                                                    ${requestScope.qtddOSEncerradoAno} </h4>
                                                            </div>
                                                        </div>
                                                    </div>





                                                </div>
                                                
                                            </div>

                                        </div>


                                       
                                        

                                        

                                    



                                        <div class="col-md-6  py-2">
                                            <div class="list-group text-bg-warning p-2">
                                                <div class="list-group-item">
                                                    <h4>Especialidadedes</h4>
                                                    <h6 class="text-danger">Maiores Ofensores</h6>
                                                    <table
                                                        class="table table-striped table-success table-hover text-center">
                                                        <thead>
                                                            <tr class="table-primary">
                                                                <th scope="col">#</th>
                                                                <th scope="col">Especialidade</th>
                                                                <th scope="col">nº de Ordens De Serviço</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="row"
                                                                items="${requestScope.top3Especialidades}"
                                                                varStatus="loop">
                                                                <tr>
                                                                    <th scope="row">${loop.index + 1}</th>
                                                                    <td>
                                                                        <c:out value="${row.especialidade}" />
                                                                    </td>
                                                                    <td>
                                                                        <c:out value="${row.count}" />
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-6  py-2">
                                            <div class="list-group text-bg-warning p-2">
                                                <div class="list-group-item">
                                                    <h4>Prédios</h4>
                                                    <h6 class="text-danger">Maiores Ofensores</h6>
                                                    <table
                                                        class="table table-striped table-success table-hover text-center">
                                                        <thead>
                                                            <tr class="table-primary">
                                                                <th scope="col">#</th>
                                                                <th scope="col">Campus/Predio</th>
                                                                <th scope="col">nº de Ordens De Serviço</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="row" items="${requestScope.top3PrediosOS}"
                                                                varStatus="loop">
                                                                <tr>
                                                                    <th scope="row">${loop.index + 1}</th>
                                                                    <td>
                                                                        <c:out value="${row.predio}" />
                                                                    </td>
                                                                    <td>
                                                                        <c:out value="${row.count}" />
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
                                </body>

                        </html>