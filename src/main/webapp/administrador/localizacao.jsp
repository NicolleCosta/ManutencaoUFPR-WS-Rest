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
                    if (!$(this).hasClass('campus-modal')) {
                        var campusSelectorId = $(this).attr('id');
                        var predioSelectorId = campusSelectorId === "campus-name" ? "predio-name" : "predio-bloqueio";

                        if (!campusSelected[campusSelectorId]) {
                            campusSelected[campusSelectorId] = true;
                            $("#" + campusSelectorId + " option[value='']").remove(); // Remove a opção "Selecione" do seletor de campus específico
                        }

                        getPredios(campusSelectorId, predioSelectorId);
                    }
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
                                $("#tabela-predios tbody").empty(); // Limpa as linhas da tabela de prédios

                                $.each(data, function (i, obj) {
                                    $("#" + predioSelectorId).append("<option value=" + obj.id + ">" + obj.nome + "</option>");

                                    // Adiciona uma nova linha na tabela de prédios
                                    var newRow = "<tr><td>" + obj.nome + "</td></tr>";
                                    $("#tabela-predios tbody").append(newRow);
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

                // Função para atualizar os prédios na modal
                function updateModalPredios(campusSelectorId, predioSelectorId) {
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

                            // Remover a opção "Selecione" do seletor de campus específico na modal após selecionar o prédio
                            $("#" + campusSelectorId + " option[value='']").remove();
                        },
                        error: function (request, textStatus, errorThrown) {
                            alert(request.status + ', Error: ' + request.statusText);
                        }
                    });
                }

                // Evento que é acionado quando o campus-nome é alterado
                var campusSelect = document.getElementById("campus-name");
                campusSelect.addEventListener("change", function () {
                    if ($(this).hasClass('campus-modal')) {
                        updateModalPredios("campus-name", "predio-name");
                    } else {
                        limparPredio.call(this);
                    }
                });

                // Evento que é acionado quando o campus-bloqueio é alterado
                var campusBloqueioSelect = document.getElementById("campus-bloqueio");
                campusBloqueioSelect.addEventListener("change", function () {
                    if ($(this).hasClass('campus-modal')) {
                        updateModalPredios("campus-bloqueio", "predio-bloqueio");
                    } else {
                        limparPredio.call(this);
                    }
                });

                function limparPredio() {
                    var predioSelectorId = $(this).attr('id') === "campus-name" ? "predio-name" : "predio-bloqueio";

                    if (campusSelected[$(this).attr('id')]) {
                        var predioSelect = document.getElementById(predioSelectorId);
                        predioSelect.selectedIndex = 0;
                    }
                }
            });
        </script>

        <!-- Configurações da pagina (fim do head) e Cabeçalho da página -->
        <%@include file="header.jsp" %>

        <!-- Corpo da página -->
    <div class="container">
        <c:if test="${requestScope.info != null || param.info != null}">
            <div class="alert alert-success alert-dismissible fade show">
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                <span>${requestScope.info == null ? param.info : requestScope.info}</span>
            </div>
        </c:if>

        <div class="p-3">
            <h1 class="text-primary text-center fw-bold ">Cadastro de Localizações</h1>
        </div>

        <div class="row">
            <div class="col">
                <h2 class="text-center fw-bold text-warning p-3">Consultar</h2>
                    <div class="container text-center">
                        <div class="row row-cols-2 p-3">
                            <div class="col-4 align-middle text-sm-end fw-bold p-3">Campus</div>
                            <div class="col-8 p-3">
                                <div class="dropdown">
                                    <select id="campus-name" class="form-control text-center" name="campus">
                                        <option value="">Selecione</option>
                                        <c:forEach items="${requestScope.listaCampus}" var="campus">
                                            <option value="${campus.id}">${campus.nome}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="col-4 align-middle text-sm-end fw-bold p-3">Prédios</div>
                            <div class="col-8 p-3">
                                <div class="dropdown">     
                                    <table id="tabela-predios" class="table table-striped table-primary">
                                        <tbody>
                                            <!-- Linhas da tabela de prédios serão adicionadas dinamicamente -->
                                        </tbody>
                                    </table>     
                                </div>
                            </div>
                        </div>
                    </div>
                
            </div>

            <div class="col">
                
                    <h2 class="text-center fw-bold text-warning p-3">Nova Localização</h2>
                    <div class="container text-center py-3">
                        <div class="d-grid gap-2 col-6 mx-auto">
                            
                                <button type="button" class="btn btn-primary fw-bold btn-lg" data-bs-toggle="modal"
                                        data-bs-target="#novoCampus">Campus</button>
                           <button type="button" class="btn btn-primary fw-bold btn-lg" data-bs-toggle="modal"
                                                     data-bs-target="#novoPredio">Prédio</button>
                            </div>
                        </div>

                  
            
                            <h2 class="text-center fw-bold text-warning p-3">Bloquear</h2>
                            <div class="container text-center">
                                <div class="d-grid gap-2 col-6 mx-auto">
                                    <button type="button" class="btn btn-outline-danger fw-bold btn-lg"
                                                              data-bs-toggle="modal" data-bs-target="#bloquearCampus">Campus</button>
                                     <button type="button" class="btn btn-outline-danger fw-bold btn-lg" 
                                                              data-bs-toggle="modal" data-bs-target="#bloquearPredio">Prédio</button>
                                    
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
                            <h3 class="modal-title fs-5">NOVA LOCALIZAÇÃO <strong class="text-primary">CAMPUS</strong></h3>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p>Preencha abaixo o nome do novo <strong class="text-primary">campus</strong></p>
                            <div class="container">
                                <div class="row">
                                    
                                        <input type="text" class="form-control text-bg-light" id="nomeNovoCampus" name="nome" required>
                                    
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-warning fw-bold">Cadastrar</button>
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
                            <h3 class="modal-title fs-5">NOVA LOCALIZAÇÃO <strong class="text-primary">PRÉDIO</strong></h3>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                              <p>Preencha abaixo o nome do novo <strong class="text-primary">prédio</strong></p>
                            <div class="container">
                                <div class="row">
                                    <div>Campus</div>
                                    <div>
                                        <div class="dropdown">
                                            <select id="campus-adicionarPredio" class="form-control campus-principal" name="campusSelecionado" required>
                                                <option value="">Esolha o Campus</option>
                                                <c:forEach items="${requestScope.listaCampus}" var="campus">
                                                    <option value="${campus.id}">${campus.nome}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div>Prédio</div>
                                    <div>
                                        <input type="text" class="form-control text-bg-light" id="nomeNovoPredio" name="nome" required>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-warning fw-bold">Cadastrar</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>




<!-- ************MODAL BLOQUEAR CAMPUS**************************** -->
<div class="modal fade" id="bloquearCampus" data-bs-backdrop="true" data-bs-keyboard="false" tabindex="-1"
     aria-labelledby="bloquearCampusLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title fs-5">CONFIRMAÇÃO DE BLOQUEIO <strong class="text-danger">CAMPUS</strong></h3>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Selecione o campus que deseja <strong class="text-danger"> BLOQUEAR </strong> abaixo.</p>
                <p>Caso bloqueie esta localização não estará mais disponível para seleção para abertura de chamados.</p>
                <div class="alert alert-danger d-flex align-items-start" role="alert">
                    <div>
                        <strong class="text-danger">Atenção!</strong> Esta ação não pode ser revertida.
                    </div>
                </div>
                <div class="container">
                    <div class="row">
                        <div>Campus</div>
                        <div>
                            <div class="dropdown">
                                <select id="campus-campusId" class="form-control" name="campus-campusId" required>
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
                <button type="button" class="btn btn-danger" id="bloquearButton">Bloquear</button>
            </div>
        </div>
    </div>
</div>

<!--********** MODAL CONFIRMA BLOQUEIO CAMPUS**************-->
<c:forEach var="campus" items="${requestScope.listaCampus}">
    <div class="modal fade" id="modalBloqueio${campus.id}" data-bs-backdrop="static" data-bs-keyboard="false"
         tabindex="-1" aria-labelledby="modalBoqueioLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <form action="LocalizacaoServlet?action=bloquearCampus" method="POST">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Confirmação de Bloqueio</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" id="campusId${campus.id}" name="campusId" value="${campus.id}"/>
                        <p>Deseja realmente bloquear o campus <strong>${campus.nome}</strong>?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-danger">Bloquear</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</c:forEach>

     <!-- ************MODAL BLOQUEAR PRÉDIO**************************** -->
<div class="modal fade" id="bloquearPredio" data-bs-backdrop="true" data-bs-keyboard="false" tabindex="-1" aria-labelledby="bloquearPredioLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h3 class="modal-title fs-5">CONFIRMAÇÃO DE BLOQUEIO <strong class="text-danger">PRÉDIO</strong></h3>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <p>Selecione o campus que deseja <strong class="text-danger">BLOQUEAR</strong> abaixo.</p>
          <p>Caso bloqueie esta localização, não estará mais disponível para seleção para abertura de chamados.</p>
          <div class="alert alert-danger d-flex align-items-start" role="alert">
            <div>
              <strong class="text-danger">Atenção!</strong> Esta ação não pode ser revertida.
            </div>
          </div>
          <div class="container">
            <div class="row">
              <div class="col-4">Campus</div>
              <div class="col-8">
                <div class="dropdown">
                    <select id="campus-campusId" class="form-control" name="campus-campusId" required>
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
                  <select id="predio-bloqueio" class="form-control predio-modal" name="predio-bloqueio" required>
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
          <button type="button" class="btn btn-danger" id="bloquearPredioButton">Bloquear</button>
        </div>
      </div>
    </div>
  </div>


<!--********** MODAL CONFIRMA BLOQUEIO PRÉDIO**************-->
<c:forEach var="predio" items="${requestScope.listaPredios}">
  <div class="modal fade" id="modalBloqueioPredio${predio.id}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modalBoqueioPredioLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <form action="LocalizacaoServlet?action=bloquearPredio" method="POST">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Confirmação de Bloqueio</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <input type="hidden" id="predioId${predio.id}" name="predioId" value="${predio.id}" />
            <p>Deseja realmente bloquear o prédio <strong>${predio.nome}</strong>?</p>
          </div>
          <div class="modal-footer">
            <button type="submit" class="btn btn-danger">Bloquear</button>
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
          </div>
        </div>
      </form>
    </div>
  </div>
</c:forEach>








  
                
                <script>
                $(document).ready(function() {
                    // Handle click event on "Bloquear" button in the first modal
                    $("#bloquearPredioButton").click(function() {
                    // Get the selected campus value
                    var predioId = $("#predio-bloqueio").val();

                    // Set the value of the hidden input field in the second modal
                    $("#predioId" + predioId).val(predioId);

                    // Close the first modal
                   // $("#bloquearPredio").modal("hide");

                    // Open the second modal
                    $("#modalBloqueioPredio" + predioId).modal("show");
                    });
                });
                </script>
              
                
                <script>
                    $(document).ready(function() {
                        
                          $("#bloquearButton").click(function() {
                         var campusId = $("#campus-campusId").val();                    
                         $("#campusId" + campusId).val(campusId);
                         $("#bloquearCampus").modal("hide");                    
                         $("#modalBloqueio" + campusId).modal("show");
                     });
     
          
                     });</script>









<!-- ************MODAL BLOQUEAR PRÉDIO original para não perder o código**************************** 
<form action="LocalizacaoServlet?action=bloquearPredio" method="POST">
    <div class="modal fade" id="bloquearPredio" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
         aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title fs-5">CONFIRMAÇÃO DE BLOQUEIO <strong class="text-danger">PRÉDIO</strong></h3>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Tem certeza que deseja <strong class="text-danger"> BLOQUEAR </strong> o PRÉDIO abaixo?</p>
                    <p>Caso bloqueie esta localização não estará mais disponível para
                        seleção para abertura de chamados, <strong class="text-danger">esta ação não pode ser revertída.</strong></p>

                    <div class="container">
                        <div class="row">
                            <div class="col-4">Campus</div>
                            <div class="col-8">
                                <div class="dropdown">

                                    <select id="campus-bloqueio" class="form-control campus-modal" name="campusId" required>
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
                                    <select id="predio-bloqueio" class="form-control campus-modal" name="predioId" required>
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
                    <button type="submit" class="btn btn-danger  fw-bold">Bloquear</button>
                </div>
            </div>
        </div>
    </div>
</form>-->





    </body>

</html>