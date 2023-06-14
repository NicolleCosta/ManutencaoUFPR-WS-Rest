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
    <c:if test="${ sessionScope.user.tipoUsuarioId.nome != 'almoxarife'}">
        <c:redirect url="/geral/index.jsp">
            <c:param name="msg" value="Usuário não possui permissão para acessar essa página." />
        </c:redirect>
    </c:if>
</c:if>

<!doctype html>
<html lang="pt-BR">

    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Retirada Material Almoxarife</title>

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
    </div>

    <div class="container text-center">
        <div class="row">
            <div class="col">
                <form class="d-flex" role="search">
                    <input class="form-control me-2" type="search" placeholder="Buscar Ordem De Serviço"
                           aria-label="Search">
                    <button class="btn btn-warning" type="submit">Buscar</button>
                </form>
            </div>
            <div class="col">

                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#novoMaterialModal">Novo Material</button>
            </div>
        </div>
    </div>


    <!-- Nesta tabela só teremos uma linha, com as informações do chamado que vamos cadastrar os materiais, as informações disponíveis já estão listadas abaixo -->
    <div class="table-secondary">
        <table class="table align-middle mb-0 bg-white table-hover">
            <thead class="bg-light">
            </thead>
            <tbody data-bs-toggle="modal" data-bs-target="#modalOdermDeServico">
                <tr>
                    <td>
                        <p class="fw-normal mb-1">
                            #2020365
                            <!--  <c:out value="${ordemdeservico.id}" /> -->
                        </p>
                    </td>
                    <td>
                        <p class="fw-normal mb-1">
                            Politécnico
                            <!-- <c:out value="${ordemdeservico.campus.nome}" /> -->
                        </p>
                    </td>
                    <td>
                        <p class="fw-normal mb-1">
                            João da Silva
                            <!-- <c:out value="${ordemdeservico.operario.nome}" /> -->
                        </p>
                    </td>
                    <td>
                        <p class="fw-normal mb-1">
                            Elétrica, Pintura, Civil, Hidráulica
                            <!--  <c:out value="${ordemdeservico.operario.especialidade}" /> -->
                        </p>
                    </td>
                    <td>
                        <p class="fw-normal mb-1">
                            Em andamento
                            <!-- <c:out value="${ordemdeservico.status}" /> -->
                        </p>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>

    <!-- Tabela de materiais retirados ******Historico********** para aquela ordem de serviço -->
    <div class="container text-center">
        <div class="row">
            <div class="col">
                <h5>Retirada</h5>
                <div class="container">
                    <div class="row">
                        <div class="col-sm-2">
                            <label for="recipient-name" class="col-form-label">Quantidade</label>                  
                        </div>
                        <div class="col-sm-2">
                            <label for="recipient-name" class="col-form-label">Unidade</label>
                        </div>
                        <div class="col-sm-6">
                            <label for="recipient-name" class="col-form-label">Material</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-2">
                            <input type="number" class="form-control text-bg-light" id="quantidade">
                        </div>
                        <div class="col-sm-2">
                            <input type="text" class="form-control text-bg-light" id="unidade">
                        </div>
                        <div class="col-sm-6">
                            <input type="text" class="form-control text-bg-light" id="Material" >
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-2">
                            <input type="number" class="form-control text-bg-light" id="quantidade">
                        </div>
                        <div class="col-sm-2">
                            <input type="text" class="form-control text-bg-light" id="unidade">
                        </div>
                        <div class="col-sm-6">
                            <input type="text" class="form-control text-bg-light" id="Material" >
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-2">
                            <input type="number" class="form-control text-bg-light" id="quantidade">
                        </div>
                        <div class="col-sm-2">
                            <input type="text" class="form-control text-bg-light" id="unidade">
                        </div>
                        <div class="col-sm-6">
                            <input type="text" class="form-control text-bg-light" id="Material" >
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-2">
                            <input type="number" class="form-control text-bg-light" id="quantidade">
                        </div>
                        <div class="col-sm-2">
                            <input type="text" class="form-control text-bg-light" id="unidade">
                        </div>
                        <div class="col-sm-6">
                            <input type="text" class="form-control text-bg-light" id="Material" >
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-2">
                            <input type="number" class="form-control text-bg-light" id="quantidade">
                        </div>
                        <div class="col-sm-2">
                            <input type="text" class="form-control text-bg-light" id="unidade">
                        </div>
                        <div class="col-sm-6">

                            <input type="text" class="form-control text-bg-light" id="Material" >
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-2">
                            <input type="number" class="form-control text-bg-light" id="quantidade">
                        </div>
                        <div class="col-sm-2">
                            <input type="text" class="form-control text-bg-light" id="unidade">
                        </div>
                        <div class="col-sm-6">
                            <input type="text" class="form-control text-bg-light" id="Material" >
                        </div>
                    </div>

                    <!-- ***************** FOR EACH COMENTÁRIO ************************** -->
                </div>          
            </div>
            <div class="col">
                <h5>Histórico</h5>
                <div class="table-secondary">
                    <table class="table align-middle mb-0 bg-white table-hover">
                        <thead class="bg-light">
                            <tr>
                                <th>Data e Hora</th>
                                <th>Operário</th>
                                <th>Material</th>        
                            </tr>
                        </thead>
                        <tbody data-bs-toggle="modal" data-bs-target="#modalOdermDeServico">
                            <c:forEach var="chamados" items="${requestScope.ordemdeservico}">                         
                                <tr>                               
                                    <td>
                                        <p class="fw-normal mb-1">
                                            12/08/2022
                                            10?45
                                            <!--  <c:out value="" /> -->
                                        </p>
                                    </td>
                                    <td>
                                        <p class="fw-normal mb-1">
                                            João da Silva
                                            <!-- <c:out value="${ordemdeservico.operario.nome}" /> -->
                                        </p>
                                    </td>
                                    <td>
                                        <p class="fw-normal mb-1">
                                            Tijolo,
                                            Pincel,
                                            Martelo,
                                            Tinta.
                                            <!-- <c:out value="${ordemdeservico.operario.especialidade}" /> -->
                                        </p>
                                    </td>      
                                </tr>                    
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="text-left">
            <button class="btn btn-secondary">Cancelar</button>
            <button class="btn btn-warning">Salvar</button>
        </div>
    </div>
    <div>
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#novoMaterialModal">Novo
            Material</button>
    </div>


    <!--********** MODAL Ordem de Serviço**************-->

    <div class="modal fade" id="modalOdermDeServico" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
         aria-labelledby="chamadoModalLabel" aria-hidden="true">
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
                        </div>
                    </form>
                </div>

                <div class="modal-footer">
                    <div class="row text-left">
                        <div class="col">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"
                                    aria-label="Close">Fechar</button>
                            <button type="button" class="btn btn-warning">Cadastrar Material</button>
                        </div>

                    </div>

                </div>
            </div>
        </div>
    </div>

    <!--********** MODAL NOVO MATERIAL**************-->

    <div class="modal fade" id="novoMaterialModal" data-bs-keyboard="false" tabindex="-1"
         aria-labelledby="novoMaterialModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="row">
                        <div class="col">
                            <div class="w-50">
                                <p class="text-body-secondary">Novo Material</p>
                            </div>
                        </div>
                    </div>

                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>

                </div>

                <div class="modal-body">
                    <form>

                        <div class="container">

                            <div class="row">
                                <div class="col-12">
                                    <label for="recipient-name" class="col-form-label">Nome do Material</label>
                                    <input type="text" class="form-control text-bg-light" id="material-name">
                                </div>
                            </div>

                            <!-- ***************** for each lista de materiais ************************** -->
                            <div >

                                <label for="message-text" class="col-form-label">Materiais Cadastrados</label>
                                <ul class="list-group">
                                    <li class="list-group-item">Tijolo Tipo A</li>
                                    <li class="list-group-item">Tijolo Tipo B</li>
                                    <li class="list-group-item">Tijolo Tipo C</li>
                                    <li class="list-group-item">Tijolo Tipo D</li>
                                    <li class="list-group-item">A third item</li>
                                    <li class="list-group-item">A fourth item</li>
                                    <li class="list-group-item">And a fifth one</li>
                                </ul>

                            </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <div class="row text-left">
                    <div class="col">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"
                                aria-label="Close">Cancelar</button>
                        <button type="button" class="btn btn-warning">Salvar Material</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

</html>