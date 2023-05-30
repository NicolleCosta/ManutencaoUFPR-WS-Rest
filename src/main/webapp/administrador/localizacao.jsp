<%-- 
    Document   : localizacao
    Created on : 26 de mai de 2023, 22:09:24
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
        <title>Localização - Administrador</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                var campusSelected = {
                    "campus-name": false,
                    "campus-bloqueio": false
                };

                $("#campus-name, #campus-bloqueio").change(function () {
                    var campusSelectorId = $(this).attr('id');
                    var predioSelectorId = campusSelectorId === "campus-name" ? "predio-name" : "predio-bloqueio";

                    if (!campusSelected[campusSelectorId]) {
                        campusSelected[campusSelectorId] = true;
                        $("#" + campusSelectorId + " option[value='']").remove(); // Remove a opção "Selecione" do seletor de campus específico
                    }

                    getPredios(campusSelectorId, predioSelectorId);
                });

                function getPredios(campusSelectorId, predioSelectorId) {
                    if (campusSelected[campusSelectorId]) {
                        var campusId = $("#" + campusSelectorId).val();
                        var url = "AJAXServlet";
                        $.ajax({
                            url: url,
                            data: {
                                campusId: campusId
                            },
                            dataType: 'json',
                            success: function (data) {
                                $("#" + predioSelectorId).empty();
                                $.each(data, function (i, obj) {
                                    $("#" + predioSelectorId).append("<option value=" + obj.id + ">" + obj.nome + "</option>");
                                });

                                // Remover a opção "Selecione" do seletor de campus após selecionar o prédio
                                $("#" + campusSelectorId + " option[value='']").remove();
                            },
                            error: function (request, textStatus, errorThrown) {
                                alert(request.status + ', Error: ' + request.statusText);
                            }
                        });
                    }
                }

                function limparPredio() {
                    var predioSelectorId = $(this).attr('id') === "campus-name" ? "predio-name" : "predio-bloqueio";

                    if (campusSelected[$(this).attr('id')]) {
                        var predioSelect = document.getElementById(predioSelectorId);
                        predioSelect.selectedIndex = 0;
                    }
                }

                // Evento que é acionado quando o campus-nome é alterado
                var campusSelect = document.getElementById("campus-name");
                campusSelect.addEventListener("change", limparPredio);

                // Evento que é acionado quando o campus-bloqueio é alterado
                var campusBloqueioSelect = document.getElementById("campus-bloqueio");
                campusBloqueioSelect.addEventListener("change", limparPredio);
            });
        </script>



        <!-- Configurações da pagina (fim do head) e Cabeçalho da página -->
        <%@include file="header.jsp" %>

        <!-- Corpo da página -->
    <div class="container">
        <c:if test="${requestScope.info != null || param.info != null}" >
            <div class="alert alert-success alert-dismissible fade show">
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                <span>${requestScope.info == null ? param.info : requestScope.info}</span>
            </div>
        </c:if>
        <div class="row">
            <div class="col">
                <div class="w-100">
                    <h1>Localização</h1>
                    <div class="container text-center">
                        <div class="row row-cols-2">
                            <div class="col-4">Campus</div>
                            <div class="col-8">
                                <div class="dropdown">

                                    <select id="campus-name" class="form-control" name="campus">
                                        <option value="">Selecione</option>
                                        <c:forEach items="${requestScope.listaCampus}" var="campus">
                                            <option value="${campus.id}">${campus.nome}</option>
                                        </c:forEach>
                                    </select>

                                </div>
                            </div>
                            <div class="col-4">Prédio</div>
                            <div class="col-8">
                                <div class="dropdown">                                
                                    <select id="predio-name" class="form-control" name="predio">
                                        <option value="">Selecione</option>
                                        <c:forEach items="${requestScope.listaPredios}" var="predio">
                                            <c:if test="${predio.campusId.id eq '' || predio.campusId.id eq campus.id}">
                                                <option value="${predio.id}">${predio.nome}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <div class="col">
                <div class="w-100">
                    <h1>Nova Localização</h1>
                    <div class="container text-center">
                        <div class="row row-cols-1">
                            <div class="col">
                                <button type="button" class="btn btn-warning" data-bs-toggle="modal"
                                        data-bs-target="#novoCampus">Campus</button>
                            </div>
                            <div class="col"><button type="button" class="btn btn-warning" data-bs-toggle="modal"
                                                     data-bs-target="#novoPredio">Predio</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <div class="col">
                <div class="w-100">
                    <h1>Bloquear</h1>
                    <div class="container text-center">
                        <div class="row row-cols-3">
                            <div class="col"> <button type="button" class="btn btn-warning"
                                                      data-bs-toggle="modal" data-bs-target="#bloquearCampus">Campus</button></div>
                            <div class="col"> <button type="button" class="btn btn-warning" 
                                                      data-bs-toggle="modal" data-bs-target="#bloquearPredio">Prédio</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- ********************************MODAIS********************************* -->


    <!-- ************MODAL NOVO CAMPUS**************************** -->
    <form action="LocalizacaoServlet?action=novoCampus" method="POST">
        <div class="modal fade" id="novoCampus" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
             aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel">NOVA LOCALIZAÇÃO - CAMPUS</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p class="fw-bold">Preencha abaixo o nome do novo campus</p>
                        <div class="container">
                            <div class="row">
                                <div>Campus</div>
                                <div>
                                    <input type="text" class="form-control text-bg-light" id="nomeNovoCampus" name="nome">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-warning">Cadastrar</button>
                    </div>
                </div>
            </div>
        </div>
    </form>


    <!-- ************MODAL NOVO PRÉDIO**************************** -->
    <form action="LocalizacaoServlet?action=novoPredio" method="POST">
        <div class="modal fade" id="novoPredio" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
             aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel">NOVA LOCALIZAÇÃO - PRÉDIO</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p class="fw-bold">Escolha o Campus e Preencha o nome do novo prédio</p>
                        <div class="container">
                            <div class="row">
                                <div>Campus</div>
                                <div>
                                    <div class="dropdown">
                                        <select id="campus-adicionarPredio" class="form-control" name="campusSelecionado">
                                            <option value="">Esolha o Campus</option>
                                            <c:forEach items="${requestScope.listaCampus}" var="campus">
                                                <option value="${campus.id}">${campus.nome}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div>Prédio</div>
                                <div>
                                    <input type="text" class="form-control text-bg-light" id="nomeNovoPredio" name="nome">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-warning">Cadastrar</button>
                    </div>
                </div>
            </div>
        </div>
    </form>






    <!-- ************MODAL BLOQUEAR CAMPUS**************************** -->
    <form action="LocalizacaoServlet?action=bloquearCampus" method="POST">
        <div class="modal fade" id="bloquearCampus" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
             aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel">CONFIRMAÇÃO DE BLOQUEIO - Campus</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p class="fw-bold">Tem certeza que deseja BLOQUEAR o campus abaixo?</p>
                        <p class="text-center text-danger">Caso bloqueie esta localização não estará mais disponível para
                            seleção para abertura de chamados, <strong>esta ação não pode ser revertída.</strong></p>
                        <div class="container">
                            <div class="row">
                                <div>Campus</div>
                                <div>
                                    <div class="dropdown">
                                        <select id="campus-bloquearCampus" class="form-control" name="campusId">
                                            <option value="">Selecione</option>
                                            <c:forEach items="${requestScope.listaCampus}" var="campus">
                                                <option value="${campus.id}">${campus.nome}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-danger">Bloquear</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <!-- ************MODAL BLOQUEAR PRÉDIO**************************** -->
    <form action="LocalizacaoServlet?action=bloquearPredio" method="POST">
        <div class="modal fade" id="bloquearPredio" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
             aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel">CONFIRMAÇÃO DE BLOQUEIO - PRÉDIO</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p class="fw-bold">Tem certeza que deseja BLOQUEAR o PRÉDIO abaixo?</p>
                        <p class="text-center text-danger">Caso bloqueie esta localização não estará mais disponível para
                            seleção para abertura de chamados, <strong>esta ação não pode ser revertída.</strong></p>

                        <div class="container">
                            <div class="row">
                                <div class="col-4">Campus</div>
                                <div class="col-8">
                                    <div class="dropdown">

                                        <select id="campus-bloqueio" class="form-control" name="campusId">
                                            <option value="">Selecione</option>
                                            <c:forEach items="${requestScope.listaCampus}" var="campus">
                                                <option value="${campus.id}">${campus.nome}</option>
                                            </c:forEach>
                                        </select>

                                    </div>
                                </div>
                                <div class="col-4">Prédio</div>
                                <div class="col-8">
                                    <div class="dropdown">                                
                                        <select id="predio-bloqueio" class="form-control" name="predioId">
                                            <option value="">Selecione</option>
                                            <c:forEach items="${requestScope.listaPredios}" var="predio">
                                                <c:if test="${predio.campusId.id eq '' || predio.campusId.id eq campus.id}">
                                                    <option value="${predio.id}">${predio.nome}</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-danger">Bloquear</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>

</html>