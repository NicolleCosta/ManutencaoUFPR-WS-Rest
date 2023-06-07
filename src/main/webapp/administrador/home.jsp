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

    <!--**************** TABELA CHAMADOS EM ANDAMENTO************* -->

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
                                <tbody data-bs-toggle="modal" data-bs-target="#chamadoModal<c:out value="${chamados.chamado.id}"/>">
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
                                                <button href="#" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#chamadoModal<c:out value="${chamados.chamado.id}"/>">
                                                    Detalhes
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>



                        <!-- *********************TABELA CHAMADOS EM ANDAMENTO ********************** -->
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
                                <tbody data-bs-toggle="modal" data-bs-target="#chamadoModal<c:out value="${chamados.chamado.id}"/>">
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
                                                    <c:out value="${chamados.dataHora}" />
                                                </p>
                                            </td>
                                            <td>
                                          
                                            </td>
                                            <td>
                                                <button href="#" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#chamadoModal<c:out value="${chamados.id}"/>">
                                                    Detalhes
                                                </button>

                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <!--********** MODAL CHAMADOS ABERTOS **************-->
                        <c:forEach var="chamado" items="${requestScope.chamadosAbertos}">

                        <div class="modal fade" data-bs-keyboard="false" tabindex="-1" aria-labelledby="chamadoModalLabel"
                        aria-hidden="true"   id="chamadoModal<c:out value="${chamados.chamado.id}"/>">
                       
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
                                                <input type="text" class="form-control text-bg-light" id="ordem-de-servico" value="Em Aberto" readonly>
                                            </div>
                       
                                            <div class="col-sm-4">
                                                <label for="recipient-name" class="col-form-label">Data e Hora</label>
                                                <input type="text" class="form-control text-bg-light" id="Data" pattern="dd/MM/yyyy - HH:mm:ss" value="<c:out value="${chamado.dataHora}"/>" readonly>
                                            </div>
                                        </div>
                       
                                    </div>
                       
                                </div>
                       
                                <div class="modal-footer">
                                    <div class="row text-left">
                                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                            <button type="button" class="btn btn-secondary" data-bs-toggle="modal"
                                                data-bs-target="#associarModal">Associar</button>
                                                <button type="button" class="btn btn-warning" data-bs-toggle="modal"
                                                data-bs-target="#novaOrdemDeServicoModal">Nova Ordem De Serviço</button>
                                        </div>

                       
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



 <!--********** MODAL CHAMADO EM ABERTO **************-->

 <div class="modal fade" id="chamadoModal2" data-bs-keyboard="false" tabindex="-1" aria-labelledby="chamadoModalLabel"
 aria-hidden="true">

 <div class="modal-dialog">
     <div class="modal-content">
         <div class="modal-header">
             <div class="row">
                 <div class="col-sm-8">
                     <div class="w-50">
                         <p class="text-body-secondary" id="chamadoModal">Chamado</p>

                     </div>
                 </div>
                 <div class="col-sm-2">
                     <p>Id Chamado</p>
                 </div>
                 <div class="col-sm-2">
                     <p class="text-center">#20203659</p>
                 </div>
             </div>
             <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>

         <div class="modal-body">


             <div class="container">

                 <div class="row">
                     <div class="col-sm-12">
                         <label for="recipient-name" class="col-form-label">Usuario</label>
                         <input type="text" class="form-control text-bg-light" id="recipient-name" readonly>
                     </div>
                 </div>
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
                         <label for="recipient-name" class="col-form-label">Ordem de Serviço</label>
                         <input type="text" class="form-control text-bg-light" id="ordem-de-servico" readonly>
                     </div>

                     <div class="col-sm-4">
                         <label for="recipient-name" class="col-form-label">Data e Hora</label>
                         <input type="text" class="form-control text-bg-light" id="Data" readonly>
                     </div>
                 </div>

             </div>

         </div>

         <div class="modal-footer">
             <div class="row text-left">
                 <div class="col-sm-8">
                     <button type="button" class="btn btn-secondary" data-bs-toggle="modal"
                         data-bs-target="#associarModal">Associar</button>
                 </div>
                 <div class="col-sm-4">
                     <button type="button" class="btn btn-warning" data-bs-toggle="modal"
                         data-bs-target="#novaOrdemDeServicoModal">Nova Ordem De Serviço</button>
                 </div>

             </div>

         </div>

     </div>
 </div>

</div>



<!--********** MODAL CHAMADO EM ANDAMENTO **************-->

<div class="modal fade" id="chamadoEmAndamentoModal" data-bs-keyboard="false" tabindex="-1" aria-labelledby="chamadoEmAndamentoModalLabel"
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
                     <p class="text-center">#20203659</p>
                 </div>
             </div>
             <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>

         <div class="modal-body">


             <div class="container">

                 <div class="row">
                     <div class="col-sm-12">
                         <label for="recipient-name" class="col-form-label">Usuario</label>
                         <input type="text" class="form-control text-bg-light" id="recipient-name" readonly>
                     </div>
                 </div>
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
                         <label for="recipient-name" class="col-form-label">Ordem de Serviço</label>
                         <input type="text" class="form-control text-bg-light" id="ordem-de-servico" readonly>
                     </div>

                     <div class="col-sm-4">
                         <label for="recipient-name" class="col-form-label">Data e Hora</label>
                         <input type="text" class="form-control text-bg-light" id="Data" readonly>
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





<!--********** MODAL NOVA ORDEM DE SERVIÇO **************-->
<div class="modal fade" id="novaOrdemDeServicoModal" data-bs-backdrop="static" data-bs-keyboard="false"
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
                     <p class="text-center">#20203659</p>
                 </div>
             </div>
             <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>

         <div class="modal-body">


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
                     <div class="col">
                         <label for="recipient-name" class="col-form-label">Digite aqui o número da Ordem de Serviço</label>
                         <input type="text" class="form-control text-bg-light" id="ordem-de-servico">
                     </div>
                 </div>
             </div>

         </div>

         <div class="modal-footer">
             <div class="row text-left">
                 <div class="col-sm-4">
                     <button type="button" class="btn btn-warning" data-bs-toggle="modal"
                         data-bs-target="#novaOrdemDeServicoModal">Cadastrar</button>
                 </div>

             </div>

         </div>
     </div>
 </div>
</div>




<!--********** MODAL ASSOCIAR **************-->
<div class="modal fade" id="associarModal" data-bs-keyboard="false" tabindex="-1"
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
                         <div class="col-sm-6">
                             <label for="recipient-name" class="col-form-label">Ordens de Serviço para o mesmo
                                 local</label>
                         </div>
                         <div class="list-group">
                             <!--  ********************for each**************************** -->
                             <span data-bs-placement="right"
                                 data-bs-title="Descrição do problema  Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
                                 data-bs-toggle="tooltip">
                                 <button data-bs-target="#ordemDeServico2Modal" data-bs-toggle="modal"
                                     type="button"
                                     class="list-group-item list-group-item-action">#20203669</button>
                             </span>
                             <span data-bs-placement="right"
                                 data-bs-title="Descrição do problema  Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
                                 data-bs-toggle="tooltip">
                                 <button data-bs-target="#ordemDeServico2Modal" data-bs-toggle="modal"
                                     type="button"
                                     class="list-group-item list-group-item-action">#20203669</button>
                             </span>
                             <span data-bs-placement="right"
                                 data-bs-title="Descrição do problema  Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
                                 data-bs-toggle="tooltip">
                                 <button data-bs-target="#ordemDeServico2Modal" data-bs-toggle="modal"
                                     type="button"
                                     class="list-group-item list-group-item-action">#20203669</button>
                             </span>

                         </div>
                     </div>
                 </div>


             </form>
         </div>

         <div class="modal-footer">
             <div class="row text-left">

                 <div>
                     <button type="button" class="btn btn-warning" data-bs-toggle="modal"
                         data-bs-target="#novaOrdemDeServicoModal">Nova Ordem De Serviço</button>
                 </div>

             </div>

         </div>

     </div>
 </div>
</div>




<!--********** MODAL ORDEM DE SERVIÇO **************-->
<div class="modal fade" id="ordemDeServico2Modal" data-bs-backdrop="static" tabindex="-1"
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
                     <p class="text-center">#20203659</p>
                 </div>
             </div>
             <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
         </div>

         <div class="modal-body">


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
                     <div class="col-sm-6">
                         <label for="recipient-name" class="col-form-label">Status</label>
                         <input type="text" class="form-control text-bg-light" id="status" readonly>
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


<!-- **************** triggers ******************* -->

<script>
 const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
 const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))
</script>













        
    </body>

</html>