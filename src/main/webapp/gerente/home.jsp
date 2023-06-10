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


            <div class="col-md-6 py-2">
                <div class="list-group">
                    <div class="list-group-item">
                        <h3 class="pull-right">
                            <i class="fa fa-bar-chart" aria-hidden="true"></i>
                        </h3>
                        <h4 class="list-group-item-heading count">
                            45/62<!--  ${requestScope.todosAtendimentosEmAberto} | ${requestScope.percentual} % --></h4>
                        <p class="list-group-item-text">
                            Chamados Encerrados [30 dias] </p>
                    </div>
                </div>
            </div>

            <div class="col-md-6  py-2">
                <div class="list-group">
                    <div class="list-group-item">
                        <h3 class="pull-right">
                            <i class="fa fa-bar-chart" aria-hidden="true"></i>
                        </h3>
                        <h4 class="list-group-item-heading count">
                            30/41 <!--  ${requestScope.todosAtendimentos} --></h4>
                        <p class="list-group-item-text">
                            Ordem de Serviço Encerrradas [30 dias]</p>
                    </div>
                </div>

            </div>

            <div class="col-md-3 p-2">
                <div class="list-group">
                    <div class="list-group-item">
                        <p class="list-group-item-text">
                            Chamados Em Aberto</p>
                        <h4 class="list-group-item-heading count">
                            5 <!-- ${requestScope.todasSugestoesEmAberto}/${requestScope.todasSugestoes} --></h4>
                    </div>
                </div>
            </div>

            <div class="col-md-3 p-2">
                <div class="list-group">
                    <div class="list-group-item">
                        <p class="list-group-item-text">
                            Chamados em Andamento</p>
                        <h4 class="list-group-item-heading count">
                            18 <!--  ${requestScope.todasElogioEmAberto}/${requestScope.todosElogio} --></h4>
                    </div>
                </div>
            </div>

            <div class="col-md-3 p-2">
                <div class="list-group">
                    <div class="list-group-item">
                        <p class="list-group-item-text">
                            Ordens de Serviço em Aberto</p>
                        <h4 class="list-group-item-heading count">
                            4<!--  ${requestScope.todasReclamacoesEmAberto}/${requestScope.todasReclamacoes} --></h4>
                    </div>
                </div>

            </div>

            <div class="col-md-3 p-2">
                <div class="list-group">
                    <div class="list-group-item">
                        <p class="list-group-item-text">
                            Ordens de Serviço em Andamento</p>
                        <h4 class="list-group-item-heading count">
                            11
                            <!--  ${requestScope.todasInformacoesEmAberto}/${requestScope.todasInformacoes} -->
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
                        <h4 class="list-group-item-heading count">
                            398/421<!--  ${requestScope.todosAtendimentosEmAberto} | ${requestScope.percentual} % -->
                        </h4>
                        <p class="list-group-item-text">
                            Chamados Encerrados [Ano] </p>
                    </div>
                </div>
            </div>

            <div class="col-md-6  py-2">
                <div class="list-group">
                    <div class="list-group-item">
                        <h3 class="pull-right">
                            <i class="fa fa-bar-chart" aria-hidden="true"></i>
                        </h3>
                        <h4 class="list-group-item-heading count">
                            281/325 <!--  ${requestScope.todosAtendimentos} --></h4>
                        <p class="list-group-item-text">
                            Ordem de Serviço Encerrradas [30 dias]</p>
                    </div>
                </div>

            </div>



            <div class="col-md-6  py-2">
                <div class="list-group">
                    <div class="list-group-item">
                        <h4>Campus</h4>
                        <h6>Maiores Ofensores</h6>
                        <table class="table-primary">
                            <table class="table table-striped table-success table-hover text-center">
                                <thead>
                                    <tr class="table-primary">
                                        <th scope="col">#</th>
                                        <th scope="col">Campus</th>
                                        <th scope="col">Chamados</th>
                                        <th scope="col">Ordens De Serviço</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th scope="row">1</th>
                                        <td>Politécnico</td>
                                        <td>100</td>
                                        <td>65</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">2</th>
                                        <td>Histórico</td>
                                        <td>95</td>
                                        <td>63</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">3</th>
                                        <td>Biológicas</td>
                                        <td>72</td>
                                        <td>49</td>
                                    </tr>
                                </tbody>
                            </table>
                        </table>
                    </div>
                </div>
            </div>


            <div class="col-md-6  py-2">
                <div class="list-group">
                    <div class="list-group-item">
                        <h4>Prédios</h4>
                        <h6>Maiores Ofensores</h6>
                        <table class="table-primary">
                            <table class="table table-striped table-success table-hover text-center">
                                <thead>
                                    <tr class="table-primary">
                                        <th scope="col">#</th>
                                        <th scope="col">Campus</th>
                                        <th scope="col">Prédio</th>
                                        <th scope="col">Chamados</th>
                                        <th scope="col">Ordens De Serviço</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th scope="row">1</th>
                                        <td> Politécnico</td>
                                        <td>Restaurante Universitário</td>
                                        <td>23</td>
                                        <td>15</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">2</th>
                                        <td>Fazenda Canguiri</td>
                                        <td>Administração</td>
                                        <td>20</td>
                                        <td>13</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">3</th>
                                        <td>Biológicas</td>
                                        <td>Ala B</td>
                                        <td>18</td>
                                        <td>11</td>
                                    </tr>
                                </tbody>
                            </table>
                        </table>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <!--********** MODAL CHAMADO EM ABERTO **************-->

    <div class="modal fade" id="chamadoModal" data-bs-keyboard="false" tabindex="-1"
         aria-labelledby="chamadoModalLabel" aria-hidden="true">

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
                                <input type="text" class="form-control text-bg-light" id="recipient-name"
                                       readonly>
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
                                <textarea class="form-control text-bg-light" id="local-text"
                                          readonly></textarea>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-12">
                                <label for="message-text" class="col-form-label">Descrição do Problema</label>
                                <textarea class="form-control text-bg-light" id="problema-text"
                                          readonly></textarea>
                            </div>

                        </div>

                        <div class="row">
                            <div class="col-sm-4">
                                <label for="recipient-name" class="col-form-label">Status</label>
                                <input type="text" class="form-control text-bg-light" id="status" readonly>
                            </div>

                            <div class="col-sm-4">
                                <label for="recipient-name" class="col-form-label">Ordem de Serviço</label>
                                <input type="text" class="form-control text-bg-light" id="ordem-de-servico"
                                       readonly>
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

    <div class="modal fade" id="chamadoEmAndamentoModal" data-bs-keyboard="false" tabindex="-1"
         aria-labelledby="chamadoEmAndamentoModalLabel" aria-hidden="true">

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
                                <input type="text" class="form-control text-bg-light" id="recipient-name"
                                       readonly>
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
                                <textarea class="form-control text-bg-light" id="local-text"
                                          readonly></textarea>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <label for="message-text" class="col-form-label">Descrição do Problema</label>
                                <textarea class="form-control text-bg-light" id="problema-text"
                                          readonly></textarea>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-4">
                                <label for="recipient-name" class="col-form-label">Status</label>
                                <input type="text" class="form-control text-bg-light" id="status" readonly>
                            </div>

                            <div class="col-sm-4">
                                <label for="recipient-name" class="col-form-label">Ordem de Serviço</label>
                                <input type="text" class="form-control text-bg-light" id="ordem-de-servico"
                                       readonly>
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
                                <textarea class="form-control text-bg-light" id="problema-text"
                                          readonly></textarea>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <div class="row text-left">
                        <div class="col">
                            <button type="button" class="btn btn-warning" data-bs-dismiss="modal"
                                    aria-label="Close">Fechar</button>
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
                                <p class="text-body-secondary" id="novaOrdemDeServicoModal">Nova Ordem de
                                    Serviço</p>
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
                                <textarea class="form-control text-bg-light" id="local-text"
                                          readonly></textarea>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-12">
                                <label for="message-text" class="col-form-label">Descrição do Problema</label>
                                <textarea class="form-control text-bg-light" id="problema-text"
                                          readonly></textarea>
                            </div>

                        </div>

                        <div class="row">
                            <div class="col">
                                <label for="recipient-name" class="col-form-label">Digite aqui o número da Ordem
                                    de Serviço</label>
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
                                    <input type="text" class="form-control text-bg-light" id="campus-name"
                                           readonly>
                                </div>

                                <div class="col-sm-6">
                                    <label for="recipient-name" class="col-form-label">Predio</label>
                                    <input type="text" class="form-control text-bg-light" id="predio-name"
                                           readonly>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <label for="message-text" class="col-form-label">Descrição do Local</label>
                                    <textarea class="form-control text-bg-light" id="local-text"
                                              readonly></textarea>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-12">
                                    <label for="message-text" class="col-form-label">Descrição do
                                        Problema</label>
                                    <textarea class="form-control text-bg-light" id="problema-text"
                                              readonly></textarea>
                                </div>

                            </div>

                            <div class="row">
                                <div class="col-sm-6">
                                    <label for="recipient-name" class="col-form-label">Ordens de Serviço para o
                                        mesmo
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
                                <textarea class="form-control text-bg-light" id="local-text"
                                          readonly></textarea>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-12">
                                <label for="message-text" class="col-form-label">Descrição do Problema</label>
                                <textarea class="form-control text-bg-light" id="problema-text"
                                          readonly></textarea>
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
