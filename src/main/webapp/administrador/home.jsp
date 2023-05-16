<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html>
    <head>

        <title>Home - Administrador</title>
        
    </head>
    <body id="home">

        <!-- Página da home -->

        <div class="container-fluid display-table">
            <div class="row display-table-row">

                

                <div class="col-md-10 col-sm-11 display-table-cell v-align">
                    <%@include file="menu-topo.jsp" %>
                    <%@include file="menu-topo-sub.jsp" %>

                    <div class="user-dashboard">
                        <div class="row">
                            <!-- INICIO DE CONTEÚDO  -->



                            <!-- Texto Título -->
                            <div class="w-100">
                                <h2 class="text-center">Atendimentos em Aberto</h2>
                            </div>

                            <!-- tabela -->
                            <div class="table-responsive-sm w-100 py-2">
                                <table class="table align-middle mb-0 bg-white">
                                    <thead class="bg-light">
                                        <tr>
                                            <th>ID</th>
                                            <th>Produto</th>
                                            <th>Abertura</th>
                                            <th>Status</th>
                                            <th>Resolver</th>
                                         

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="atendimentos" items="${requestScope.atendimentos}">
                                            <tr> 
                                                <td>
                                                    <p class="fw-normal mb-1"> <c:out value="${atendimentos.idAtendimento}"/> </p>                            
                                                </td>
                                                <td>
                                                    <p class="fw-normal mb-1"> <c:out value="${atendimentos.nomeProduto}"/> </p>
                                                </td>
                                                <td>
                                                    <p class="fw-normal mb-1"> <c:out value="${atendimentos.dataHoraAtendimento}"/> </p>
                                                </td>
                                                <td>
                                                    <p> ${atendimentos.situacao == 0 ? '<span class="badge badge-success rounded-pill d-inline">Aberto</span>' : '<span class="badge badge-secondary rounded-pill d-inline">Encerrado</span>'} </p>
                                                </td>

                                                <td>
                                                    <a href="#" data-toggle="modal" data-target="#modalAtendimento<c:out value="${atendimentos.idAtendimento}"/>"><button type="button" class="btn btn-link btn-sm btn-rounded">
                                                           Resolver
                                                        </button></a>
                                                </td>
                                            </tr>
                                        </c:forEach>                    
                                    </tbody>
                                </table>
                            </div>

                             <c:forEach var="atendimentos" items="${requestScope.atendimentos}">
                                <!-- Modal form -->
                                
                               
                                <div id="modalAtendimento<c:out value="${atendimentos.idAtendimento}"/>" class="modal fade" role="dialog">
                                    <div class="modal-dialog">
                                        <!-- Modal content-->
                                        <div class="modal-content">
                                            <div class="modal-header login-header">
                                                <h4 class="modal-title">Informações Atendimento</h4>
                                            </div>
                                            <form action="${pageContext.request.contextPath}/FuncionarioServlet?action=resolver&idAtendimento=${atendimentos.idAtendimento}" method="post" required="true">
                                            <div class="modal-body">
                                                
                                               
                                                <label>Tipo de Atendimento</label>
                                                <input type="text" name="nomeTipoAtendimento" value="<c:out value="${atendimentos.nomeTipoAtendimento}"/>" readonly="readonly" />
                                                <label>Categoria</label>
                                                <input type="text" name="nomeAtendimento" value="<c:out value="${atendimentos.nomeCategoria}"/> " readonly="readonly" />
                                                     <label>Produto</label>
                                                <input type="text" name="nomeProduto" value="<c:out value="${atendimentos.nomeProduto}"/> " readonly="readonly" />
                                                     <label>Descrição</label>
                                               <input type="text" name="descricao" value="<c:out value="${atendimentos.descricao}"/> " readonly="readonly" />
                                                  <label>Solução</label>
                                                  <input name="solucao" type="text" placeholder="Solução" maxlength="255" />
                                                  
                                                
                                            
                                            </div>
                                                   
                                              
                                            <div class="modal-footer">
                                                <button type="button" class="cancel" data-dismiss="modal">
                                                   Fechar
                                                </button>
                                                <button type="submit" class="btn btn-success">Resolver</button>
                                                
                                                     
                                                
                                                
                                            </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach> 

                            <!-- Modal form -->
                            <div id="modal-form" class="modal fade" role="dialog">
                                <div class="modal-dialog">
                                    <!-- Modal content-->
                                    <div class="modal-content">
                                        <div class="modal-header login-header">
                                            <h4 class="modal-title">Editar atendimento</h4>
                                        </div>
                                        <div class="modal-body">
                                            <input type="text" placeholder="Project Title" name="name" />
                                            <input type="text" placeholder="Post of Post" name="mail" />
                                            <input type="text" placeholder="Author" name="passsword" />
                                            <textarea placeholder="Description"></textarea>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="cancel" data-dismiss="modal">
                                                Fechar
                                            </button>
                                            <button type="button" class="add-modal" data-dismiss="modal">
                                                Salvar
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Modal confirm -->
                            <div id="modal-confirm" class="modal fade" role="dialog">
                                <div class="modal-dialog">
                                    <!-- Modal content-->
                                    <div class="modal-content">
                                        <div class="modal-header login-header">
                                            <h4 class="modal-title">Realmente deseja resolver esse atendimento?</h4>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="add-modal" data-dismiss="modal">
                                                Sim
                                            </button>
                                            <button type="button" class="cancel" data-dismiss="modal">
                                                Não
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- FIM DE CONTEÚDO  -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    
    </body>

</html>