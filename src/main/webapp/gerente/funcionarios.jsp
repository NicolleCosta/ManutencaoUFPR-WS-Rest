<%-- 
    Document   : funcionarios
    Created on : 10 de jun de 2023, 13:51:58
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
        <title>Funcionários - Gerente</title>

        <!-- Configurações da pagina (fim do head) e Cabeçalho da página -->

        <%@include file="header.jsp" %>
    <div class="w-100">
        <h1 class="text-center">Funcionários</h1>
    </div>
    <div class="container text-center">
        <div class="row p-3">
            <div class="col-6">
                <form class="d-flex" role="search">
                    <input class="form-control me-2" type="search" placeholder="Buscar Funcionário" aria-label="Search">
                    <button class="btn btn-warning" type="submit" >Buscar</button>
                </form>
            </div>
            <div class="col-6">

                <div class="d-grid gap-2 d-md-flex justify-content-md-end">

                    <div class="btn-group" role="group" aria-label="Basic example">


                        <button class="btn btn-primary " data-bs-toggle="modal" data-bs-target="#novoFuncionarioModal">Novo Funcionário</button>

                    </div>
                </div>

            </div>

        </div>



        <div class="table-secondary">
            <table class="table align-middle mb-0 bg-white table-hover">
                <thead class="bg-light">
                    <tr>
                        <th>Nome</th>
                        <th>Cargo</th>
                        <th>Situação</th>
                        <th></th>


                    </tr>
                </thead>
                <tbody data-bs-toggle="modal" data-bs-target="#modalFuncionario">
                    <c:forEach var="chamados" items="${requestScope.operario}">
                        <tr>
                            <td>
                                <p class="fw-normal mb-1">
                                    Harry Potter <!--  <c:out value="${operario.nome}" /> -->
                                </p>
                            </td>
                            <td>
                                <p class="fw-normal mb-1">
                                    Gerente<!--  <c:out value="${operario.nome}" /> -->
                                </p>
                            </td>

                            <td>
                                <p class="fw-normal mb-1">
                                    Ativo<!--  <c:out value="${operario.status}" /> -->
                                </p>
                            </td>


                            <td>
                                <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                                        data-bs-target="#modalFuncionario">
                                    Detalhes
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>



        <!--********** MODAL Funcionario **************-->

        <div class="modal fade" id="modalFuncionario" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
             aria-labelledby="modalFuncionarioLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="modalOperario">Funcionário</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-right">
                            <div class="row row-cols-2">
                                <div class="col">
                                    <p>id Funcionário</p>
                                </div>
                                <div class="col">
                                    <p>#201822569</p>
                                </div>

                            </div>
                        </div>



                        <div class="container">
                            <div class="row">
                                <div>Nome</div>
                                <div>
                                    <input type="text" class="form-control text-bg-light" id="nome" readonly>
                                </div>

                                <div class="container text-right">
                                    <div class="row row-cols-3">
                                        <div class="col">
                                            <label>CPF</label>
                                            <input type="text" class="form-control text-bg-light" id="cpf" readonly>
                                        </div>
                                        <div class="col">
                                            <label>Telefone</label>
                                            <input type="text" class="form-control text-bg-light" id="telefone" readonly>
                                        </div>
                                        <div class="col">
                                            <label>Situação</label>
                                            <input type="text" class="form-control text-bg-light" id="situação" readonly>
                                        </div>

                                    </div>
                                </div>


                                <div>
                                    <label>Email</label>
                                    <input type="text" class="form-control text-bg-light" id="email" readonly>
                                </div>


                                <div class="d-grid gap-2 d-md-flex justify-content-md-start">

                                    <h5 class="p-3"> Cargo </h5>


                                    <div class="form-check p-3 ">
                                        <input class="form-check-input" type="radio" name="flexRadioDefault" id="gerenteCheck" checked disabled>
                                        <label class="form-check-label" for="flexRadioDefault1">
                                            Gerente
                                        </label>
                                    </div>
                                    <div class="form-check p-3">
                                        <input class="form-check-input" type="radio" name="flexRadioDefault" id="administradorCheck" disabled>
                                        <label class="form-check-label" for="flexRadioDefault2">
                                            Administrador
                                        </label>
                                    </div>

                                    <div class="form-check p-3">
                                        <input class="form-check-input" type="radio" name="flexRadioDefault" id="almoxarifeCheck" disabled>
                                        <label class="form-check-label" for="flexRadioDefault2">
                                            Almoxarife
                                        </label>
                                    </div>



                                </div>









                            </div>

                        </div>



                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-warning" data-bs-toggle="modal"
                                data-bs-target="#modalDesbloqueio" disabled>Desbloquear</button>
                        <button type="button" class="btn btn-danger" data-bs-toggle="modal"
                                data-bs-target="#modalBloqueio">Bloquear</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-warning" data-bs-toggle="modal"
                                data-bs-target="#editarFuncionarioModal">Editar</button>

                    </div>
                </div>
            </div>
        </div>





        <!--********** MODAL EDITAR Funcionario **************-->

        <div class="modal fade" id="editarFuncionarioModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
             aria-labelledby="editarFuncionarioModal" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="modalOperario">Funcionário</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-right">
                            <div class="row row-cols-2">
                                <div class="col">
                                    <p>id Funcionário</p>
                                </div>
                                <div class="col">
                                    <p>#201822569</p>
                                </div>

                            </div>
                        </div>



                        <div class="container">
                            <div class="row">
                                <div>Nome</div>
                                <div>
                                    <input type="text" class="form-control text-bg-light" id="nome" >
                                </div>

                                <div class="container text-right">
                                    <div class="row row-cols-3">
                                        <div class="col">
                                            <label>CPF</label>
                                            <input type="text" class="form-control text-bg-light" id="cpf" readonly>
                                        </div>
                                        <div class="col">
                                            <label>Telefone</label>
                                            <input type="text" class="form-control text-bg-light" id="telefone" >
                                        </div>
                                        <div class="col">
                                            <label>Situação</label>
                                            <input type="text" class="form-control text-bg-light" id="situação" readonly>
                                        </div>

                                    </div>
                                </div>


                                <div>
                                    <label>Email</label>
                                    <input type="text" class="form-control text-bg-light" id="email" >
                                </div>
                            </div>

                            <div class="d-grid gap-2 d-md-flex justify-content-md-start">

                                <h5 class="p-3"> Cargo </h5>


                                <div class="form-check p-3 ">
                                    <input class="form-check-input" type="radio" name="flexRadioDefault" id="gerenteCheck">
                                    <label class="form-check-label" for="flexRadioDefault1">
                                        Gerente
                                    </label>
                                </div>
                                <div class="form-check p-3">
                                    <input class="form-check-input" type="radio" name="flexRadioDefault" id="administradorCheck">
                                    <label class="form-check-label" for="flexRadioDefault2">
                                        Administrador
                                    </label>
                                </div>

                                <div class="form-check p-3">
                                    <input class="form-check-input" type="radio" name="flexRadioDefault" id="almoxarifeCheck">
                                    <label class="form-check-label" for="flexRadioDefault2">
                                        Almoxarife
                                    </label>
                                </div>



                            </div>


                        </div>



                    </div>
                    <div class="modal-footer">

                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-warning">Salvar</button>

                    </div>
                </div>
            </div>
        </div>





        <!--********** MODAL CONFIRMA BLOQUEIO**************-->
        <div class="modal fade" id="modalBloqueio" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
             aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel">CONFIRMAÇÃO DE BLOQUEIO - Funcionário</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p class="fw-bold">Tem certeza que deseja BLOQUEAR o Funcionário?</p>

                        <div>Nome</div>
                        <div>
                            <input type="text" class="form-control text-bg-light" id="nome" readonly>
                        </div>


                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-danger">Bloquear</button>
                    </div>
                </div>
            </div>
        </div>



        <!--********** MODAL CONFIRMA DESBLOQUEIO**************-->
        <div class="modal fade" id="modalDesbloqueio" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
             aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel">CONFIRMAÇÃO DE DESBLOQUEIO - Funcionário</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p class="fw-bold">Tem certeza que deseja DESBLOQUEAR o Funcionário</p>

                        <div>Nome</div>
                        <div>
                            <input type="text" class="form-control text-bg-light" id="nome" readonly>
                        </div>


                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-warning">Desbloqueio</button>
                    </div>
                </div>
            </div>
        </div>


        <!--********** MODAL Novo Funcionario **************-->

        <div class="modal fade" id="novoFuncionarioModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
             aria-labelledby="novoFuncionarioModal" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="modalOperario">Novo Funcionário</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-right">
                            <div class="row row-cols-2">
                                <div class="col">
                                    <p>id Funcionário</p>
                                </div>
                                <div class="col">
                                    <p>#201822569</p>
                                </div>

                            </div>
                        </div>



                        <div class="container">
                            <div class="row">
                                <div>Nome</div>
                                <div>
                                    <input type="text" class="form-control text-bg-light" id="nome" >
                                </div>

                                <div class="container text-right">
                                    <div class="row row-cols-3">
                                        <div class="col">
                                            <label>CPF</label>
                                            <input type="text" class="form-control text-bg-light" id="cpf" >
                                        </div>
                                        <div class="col">
                                            <label>Telefone</label>
                                            <input type="text" class="form-control text-bg-light" id="telefone" >
                                        </div>
                                        <div class="col">
                                            <label>Situação</label>
                                            <input type="text" class="form-control text-bg-light" id="situação">
                                        </div>

                                    </div>
                                </div>


                                <div>
                                    <label>Email</label>
                                    <input type="text" class="form-control text-bg-light" id="email" >
                                </div>
                            </div>

                        </div>


                        <div class="d-grid gap-2 d-md-flex justify-content-md-start">

                            <h5 class="p-3"> Cargo </h5>


                            <div class="form-check p-3 ">
                                <input class="form-check-input" type="radio" name="flexRadioDefault" id="gerenteCheck">
                                <label class="form-check-label" for="flexRadioDefault1">
                                    Gerente
                                </label>
                            </div>
                            <div class="form-check p-3">
                                <input class="form-check-input" type="radio" name="flexRadioDefault" id="administradorCheck">
                                <label class="form-check-label" for="flexRadioDefault2">
                                    Administrador
                                </label>
                            </div>

                            <div class="form-check p-3">
                                <input class="form-check-input" type="radio" name="flexRadioDefault" id="almoxarifeCheck">
                                <label class="form-check-label" for="flexRadioDefault2">
                                    Almoxarife
                                </label>
                            </div>                 
                        </div>



                    </div>
                    <div class="modal-footer">

                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-warning">Salvar</button>

                    </div>
                </div>
            </div>
        </div>
    </body>
</html>