<%-- 
    Document   : operario
    Created on : 4 de jun de 2023, 17:18:44
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
        <title>Operários - Administrador</title>

        <!-- Configurações da pagina (fim do head) e Cabeçalho da página -->
        <%@include file="header.jsp" %>

        <!-- Corpo da página -->
    <div class="table-secondary">
        <table class="table align-middle mb-0 bg-white table-hover">
            <thead class="bg-light">
                <tr>
                    <th>Nome</th>
                    <th>Disciplina</th>
                    <th>Situação</th>
                    <th></th>
                </tr>
            </thead>
            <tbody data-bs-toggle="modal" data-bs-target="#modalOperario">
                <c:forEach var="operario" items="${requestScope.operarios}">
                    <tr>
                        <td>
                            <p class="fw-normal mb-1">
                                <c:out value="${operario.nome}" />
                            </p>
                        </td>
                        <td>
                            <p class="fw-normal mb-1">
                                <c:out value="${operario.especialidadeId.nome}" />
                            </p>
                        </td>
                        <td>
                            <span class="badge badge-sm c-status" style="background-color:
                                  <c:choose>
                                      <c:when test="${operario.bloqueio eq 'false'}">green
                                          <c:set var="status" value="Ativo" />
                                      </c:when>
                                      <c:otherwise>red
                                          <c:set var="status" value="Bloqueado" />
                                      </c:otherwise>
                                  </c:choose>;">
                                <c:out value="${status}"/>
                            </span>
                        </td>
                        <td>
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                                    data-bs-target="#modalOperario<c:out value="${operario.id}"/>">
                                Detalhes
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>



    <!--********** MODAL OPERARIO **************-->
    <c:forEach var="operario" items="${requestScope.operarios}">
        <div class="modal fade" id="modalOperario<c:out value="${operario.id}"/>" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
             aria-labelledby="modalOperarioLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="modalOperario">Operário</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-right">
                            <div class="row row-cols-2">
                                <div class="col">
                                    <p>id Operário</p>
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


                                <div>
                                    <label>Especialidades</label>
                                    <!-- ****************Não sei se vai funcionar aqui salvar as especialidades por estarem em div diferentes mas vamos tentar ****************** -->
                                    <div class="row">
                                        <div class="col">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value="" id="civilCheck" checked disabled>
                                                <label class="form-check-label" for="flexCheckDefault">
                                                    Civil
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value="" id="pinturaCheck" checked disabled>
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Pintura
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col">

                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value=""
                                                       id="hidraulicaCheck" checked disabled>
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Hidraulica
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value="" id="eletricaCheck"  disabled>
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Elétrica
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value=""
                                                       id="carpintariaCheck" disabled>
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Carpintaria
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value="" id="azulejistaCheck" disabled>
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Azulejista
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value="" id="gesseiroCheck" disabled>
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Gesseiro
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value=""
                                                       id="vidraceiroCheck" disabled>
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Vidraceiro
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value=""
                                                       id="SerralheriaCheck" disabled>
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Serralheria
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col">

                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value="" id="armadorCheck" disabled>
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Armador
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value="" id="soldadorCheck" disabled>
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Soldador
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col">
                                        </div>
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
                                data-bs-target="#editarOperarioModal">Editar</button>
                    </div>
                </div>
            </div>
        </div>
</c:forEach>
        <!--********** MODAL EDITAR OPERARIO **************-->

        <div class="modal fade" id="editarOperarioModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
             aria-labelledby="modalOperarioLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="modalOperario">Operário</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-right">
                            <div class="row row-cols-2">
                                <div class="col">
                                    <p>id Operário</p>
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
                                <div>
                                    <label>Especialidades</label>
                                    <!-- ****************Não sei se vai funcionar aqui salvar as especialidades por estarem em div diferentes mas vamos tentar ****************** -->
                                    <div class="row">
                                        <div class="col">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value="" id="civilCheck">
                                                <label class="form-check-label" for="flexCheckDefault">
                                                    Civil
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value="" id="pinturaCheck">
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Pintura
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col">

                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value=""
                                                       id="hidraulicaCheck">
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Hidraulica
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value="" id="eletricaCheck">
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Elétrica
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value=""
                                                       id="carpintariaCheck">
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Carpintaria
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value=""
                                                       id="azulejistaCheck">
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Azulejista
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value="" id="gesseiroCheck">
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Gesseiro
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value=""
                                                       id="vidraceiroCheck">
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Vidraceiro
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col">

                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value=""
                                                       id="SerralheriaCheck">
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Serralheria
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col">

                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value="" id="armadorCheck">
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Armador
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value="" id="soldadorCheck">
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Soldador
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col">
                                        </div>
                                    </div>
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
                        <h1 class="modal-title fs-5" id="staticBackdropLabel">CONFIRMAÇÃO DE BLOQUEIO - OPERÁRIO</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p class="fw-bold">Tem certeza que deseja BLOQUEAR o Operário?</p>

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
                        <h1 class="modal-title fs-5" id="staticBackdropLabel">CONFIRMAÇÃO DE DESBLOQUEIO - OPERÁRIO</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p class="fw-bold">Tem certeza que deseja DESBLOQUEAR o Operário?</p>
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


        <!--********** MODAL Novo OPERARIO **************-->

        <div class="modal fade" id="novoOperarioModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
             aria-labelledby="novoOperarioModal" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="modalOperario">Novo Operário</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-right">
                            <div class="row row-cols-2">
                                <div class="col">
                                    <p>id Operário</p>
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
                                <div>
                                    <label>Especialidades</label>
                                    <!-- ****************Não sei se vai funcionar aqui salvar as especialidades por estarem em div diferentes mas vamos tentar ****************** -->
                                    <div class="row">
                                        <div class="col">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value="" id="civilCheck">
                                                <label class="form-check-label" for="flexCheckDefault">
                                                    Civil
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value="" id="pinturaCheck">
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Pintura
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value=""
                                                       id="hidraulicaCheck">
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Hidraulica
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value="" id="eletricaCheck">
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Elétrica
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col">

                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value=""
                                                       id="carpintariaCheck">
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Carpintaria
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value=""
                                                       id="azulejistaCheck">
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Azulejista
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value="" id="gesseiroCheck">
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Gesseiro
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value=""
                                                       id="vidraceiroCheck">
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Vidraceiro
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value=""
                                                       id="SerralheriaCheck">
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Serralheria
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col">

                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value="" id="armadorCheck">
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Armador
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value="" id="soldadorCheck">
                                                <label class="form-check-label" for="flexCheckChecked">
                                                    Soldador
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col">
                                        </div>
                                    </div>
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
    </body>
</html>