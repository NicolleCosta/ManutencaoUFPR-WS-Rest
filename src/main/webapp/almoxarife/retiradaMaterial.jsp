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


    <!-- Nesta tabela só teremos uma linha, com as informações do chamado que vamos cadastrar os materiais, as informações disponíveis já estão listadas abaixo -->
    <div class="table-secondary table-sm p-3 text-center">      
        <table class="table align-middle mb-0 bg-white table-hover p-3">
            <thead class="bg-light">
                <tr>
                    <th>N# Ordem</th>
                    <th>Campus</th>
                    <th>Prédio</th>
                    <th>Operário</th>
                    <th>Especialidade</th>
                    <th>Status</th>
                </tr>

            </thead>
            <tbody data-bs-toggle="modal" data-bs-target="#modalOdermDeServico">
                <tr>
                    <td>
                        <p class="fw-normal mb-1">
                            # <c:out value="${ordem.numeroOS}" />
                        </p>
                    </td>
                    <td>
                        <p class="fw-normal mb-1">
                            <c:out value="${ordem.predioId.campusId.nome}" />
                        </p>
                    </td>
                    <td>
                        <p class="fw-normal mb-1">
                            <c:out value="${ordem.predioId.nome}" />
                        </p>
                    </td>
                    <td>
                        <p class="fw-normal mb-1">
                            <c:out value="${ordem.usuarioOperarioId.nome}" /> 
                        </p>
                    </td>
                    <td>
                        <p class="fw-normal mb-1">
                            <c:out value="${ordem.especialidadeId.nome}" />
                        </p>
                    </td>
                    <td>
                        <p class="fw-normal mb-1">
                            <span class="badge badge-sm c-status"
                                  style="background-color:
                                  <c:choose>
                                      <c:when test="${ordem.dataFinalizacao eq null}">
                                          orange
                                      </c:when>
                                      <c:otherwise>
                                          green
                                      </c:otherwise>
                                  </c:choose>;">
                                <c:choose>
                                    <c:when test="${ordem.dataFinalizacao eq null}">
                                        Aberta
                                    </c:when>
                                    <c:otherwise>
                                        Finalizada
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </p>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <br>


    <div class="row p-3">

        <!-- Retirada -->
        <div class="col">

            <div class="card border-primary mb-3">
                <div class="card-header">RETIRADA</div>                 
                <form id="retiradaMaterial" action="MaterialServlet?action=registraRetiradaMaterial" method="POST">
                    <div id="table-container">
                        <div class="row px-3">
                            <div class="col-sm-2">
                                <label for="quantidade" class="col-form-label">Quantidade</label>
                            </div>
                            <div class="col-sm-2">
                                <label for="unidade" class="col-form-label">Unidade</label>
                            </div>
                            <div class="col-sm-6">
                                <label for="material" class="col-form-label">Material</label>
                            </div>
                            <div class="col-sm-2">
                            </div>
                        </div>
                        <div id="rows-container">
                            <!-- Existing rows can be added dynamically using JSTL -->

                            <div class="row px-3 py-2">
                                <div class="col-sm-2">
                                    <input type="number" class="form-control text-bg-light" name="quantidade[]" required>
                                </div>
                                <div class="col-sm-2">
                                    <input type="text" class="form-control text-bg-light" name="unidade[]" required>
                                </div>
                                <div class="col-sm-6">
                                    <select class="form-select" name="material[]" required>
                                        <option value="">Selecione o Material</option>
                                        <c:forEach var="material" items="${requestScope.materiais}">
                                            <option class="list-group-item" value="${material.id}">${material.nome}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-sm-2 text-center">
                                    <button type="button" class="btn btn-close btn-sm" onclick="deleteRow(this)"></button>
                                </div>
                            </div>
                            <input type="text" class="form-control text-bg-light" name="ordem" value="${ordem.id}" hidden>
                            <input type="text" class="form-control text-bg-light" name="nrOS" value="${ordem.numeroOS}" hidden>
                        </div>

                        <div class="row">
                            <div class="col-sm-12 text-start">
                                <a href="#" class="btn btn-link" onclick="addRow()">Adicionar Linha</a>
                            </div>
                        </div>

                        <!-- Row for buttons -->
                        <div class="row p-3">
                            <div class="col-sm-12 text-end">
                                <button class="btn btn-danger fw-bold" type="button" data-bs-toggle="modal" data-bs-target="#novoMaterialModal">Novo Material</button>
                                <button class="btn btn-dark" type="button" onclick="limparFormulario()">Cancelar</button>
                                <button class="btn btn-warning fw-bold" type="submit">Salvar</button>
                            </div>
                        </div>
                    </div>
                </form>

                <script>
                    function addRow() {
                        var row = document.createElement("div");
                        row.className = "row px-3 py-2";
                        row.innerHTML = `
                        <div class="col-sm-2">
                                    <input type="number" class="form-control text-bg-light" name="quantidade[]" required>
                                </div>
                                <div class="col-sm-2">
                                    <input type="text" class="form-control text-bg-light" name="unidade[]" required>
                                </div>
                                <div class="col-sm-6">
                                    <select class="form-select" name="material[]" required>
                                      <option value="">Selecione o Material</option>
                    <c:forEach var="material" items="${requestScope.materiais}">
                                        <option class="list-group-item" value="${material.id}">${material.nome}</option>
                    </c:forEach>
                                    </select>
                                  </div>
                                <div class="col-sm-2 text-center">
                                    <button type="button" class="btn btn-close btn-sm" onclick="deleteRow(this)"></button>
                                </div>
                    `;
                        document.getElementById("rows-container").appendChild(row);
                    }

                    function deleteRow(button) {
                        var row = button.parentNode.parentNode;
                        row.parentNode.removeChild(row);
                    }
                </script>
                <script>
                    function limparFormulario() {

                        var formulario = document.getElementById("retiradaMaterial"); 
                        formulario.reset();
                    }
                </script>

            </div>

        </div>

        <!-- Histórico -->
        <div class="col">
            <div class="card border-primary mb-3">
                <div class="card-header">Histórico</div> 
                <div class="table-secondary">
                    <table class="table align-middle mb-0 bg-white table-hover text-center">
                        <thead class="bg-light">
                            <tr>
                                <th>Data e Hora</th>
                                <th>Quantidade</th>
                                <th>Unidade</th>
                                <th>Material</th>
                                <th>Almoxarife</th> 
                            </tr>
                        </thead>
                        <tbody data-bs-toggle="modal" data-bs-target="#modalOdermDeServico">
                            <c:forEach var="retirada" items="${requestScope.retiradas}">
                                <tr>
                                    <td>
                                        <p class="fw-normal mb-1">
                                            <fmt:formatDate value="${retirada.dataHora}" pattern="dd/MM/yyyy - HH:mm" var="formattedDate" />
                                            <c:out value="${formattedDate}" />
                                        </p>
                                    </td>
                                    <td>
                                        <p class="fw-normal mb-1">
                                            <c:out value="${retirada.quantidade}" />
                                        </p>
                                    </td>
                                    <td>
                                        <p class="fw-normal mb-1">
                                            <c:out value="${retirada.unidade}" />
                                        </p>
                                    </td>
                                    <td>
                                        <p class="fw-normal mb-1">
                                            <c:out value="${retirada.materialId.nome}" />
                                        </p>
                                    </td>
                                    <td>
                                        <p class="fw-normal mb-1">                    <c:out value="${retirada.usuarioId.nome}" />
                                        </p>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>




    <!--********** MODAL Ordem de Serviço**************-->

    <div class="modal fade" id="modalOdermDeServico" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
         aria-labelledby="chamadoModalLabel" aria-hidden="true">
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
                                <p class="text-center"># <c:out value="${ordem.numeroOS}" /> </p>
                            </div>
                        </div>
                    </div>

                    <div class="container">
                        <div class="row">
                            <div class="col-sm-6">
                                <label for="recipient-name" class="col-form-label">Campus:</label>
                                <input type="text" class="form-control text-bg-light" id="campus-name" value ="${ordem.predioId.campusId.nome}" readonly>
                            </div>
                            <div class="col-sm-6">
                                <label for="recipient-name" class="col-form-label">Predio</label>
                                <input type="text" class="form-control text-bg-light" id="predio-name" value ="${ordem.predioId.nome}" readonly>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <label for="message-text" class="col-form-label">Descrição do Local</label>
                                <textarea class="form-control text-bg-light" id="local-text" readonly>${ordem.descricaoLocal}</textarea>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-12">
                                <label for="message-text" class="col-form-label">Descrição do Problema</label>
                                <textarea class="form-control text-bg-light" id="problema-text" readonly>${ordem.descricaoProblema}</textarea>
                            </div>

                        </div>

                        <div class="row">
                            <div class="col-sm-6">
                                <label  class="col-form-label fw-bold ">Data Abertura</label>
                                <fmt:formatDate value="${ordem.dataAbertura}" pattern="dd/MM/yyyy" var="formattedDate"/>
                                <input type="text" class="form-control text-bg-light" id="Data" value="${formattedDate}" readonly>
                            </div>
                            <div class="col-sm-6">
                                <label  class="col-form-label fw-bold ">Data Finalização</label>
                                <fmt:formatDate value="${ordem.dataFinalizacao}" pattern="dd/MM/yyyy" var="formattedDate"/>
                                <input type="text" class="form-control text-bg-light" id="Data" value="${formattedDate}" readonly>
                            </div>
                        </div>
                        <div class="row py-2">
                            <div class="col-sm-6">
                                <label class="col-form-label fw-bold ">Especialidade:</label>
                                <input type="text" class="form-control text-bg-light" id="campus-name" value ="${ordem.especialidadeId.nome}" readonly>
                            </div>
                            <div class="col-sm-6">
                                <label class="col-form-label fw-bold ">Operário</label>
                                <input type="text" class="form-control text-bg-light" id="predio-name" value ="${ordem.usuarioOperarioId.nome}" readonly>
                            </div>
                        </div>

                        <div class="row py-2">
                            <div class="col-sm-12">
                                <label class="col-form-label fw-bold ">Comentário Operário</label>
                                <c:forEach var="comentario" items="${requestScope.comentarios}">
                                    <c:if test="${comentario.ordemServicoId.id == ordem.id }">
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

    <!--********** MODAL NOVO MATERIAL**************-->

    <div class="modal fade" id="novoMaterialModal" data-bs-keyboard="false" tabindex="-1"
         aria-labelledby="novoMaterialModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="row">
                        <h3 class="modal-title text-primary">CADASTRO DE MATERIAL</h3>
                    </div>                    
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>

                </div>

                <div class="modal-body">
                    <form action="MaterialServlet?action=novoMaterial" method="POST">
                        <div class="container">
                            <p>Digite abaixo o nome do novo material.</p>
                            <div class="row py-3">
                                <div class="col-12">
                                    <label for="recipient-name" class="col-form-label fw-bold">Nome do Material</label>
                                    <input type="text" class="form-control text-bg-light"  id="material-name" name="nome" required>
                                </div>
                            </div>
                            <div class=" p-3" >
                                <div class="row">
                                    <p class="text-danger">Verifique na lista abaixo se o material já está cadastrado</p>
                                </div>  
                                <label for="message-text" class="col-form-label">Materiais Cadastrados</label>
                                <c:forEach var="material" items="${requestScope.materiais}">
                                    <ul class="list-group">
                                        <li class="list-group-item">${material.nome}</li>
                                    </ul>
                                </c:forEach>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <div class="row text-left">
                                <div class="col">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"
                                            aria-label="Close">Cancelar</button>
                                    <button type="submit" class="btn btn-warning fw-bold">Salvar Material</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>

</html>