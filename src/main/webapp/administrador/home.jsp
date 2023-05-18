<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%--Validar se usuário está logado--%>
<c:if test="${sessionScope.user == null}" >
    <c:redirect url="/geral/index.jsp">
        <c:param name="msg" value="Usuário deve se autenticar para acessar o sistema"/>
    </c:redirect>
</c:if>
<c:if test="${ sessionScope.user != null }" >
    <c:if test="${ sessionScope.user.tipoUsuarioId.nome != 'administrador'}" >
        <c:redirect url="/geral/index.jsp">
            <c:param name="msg" value="Usuário não possui permissão para acessar essa página."/>
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
        <!-- CSS only -->
        <link rel="stylesheet" type="text/css" href="css/style.css" />
        <link rel="stylesheet" type="text/css" href="css/custom.css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
              integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous" />
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet"
              integrity="sha384-T8Gy5hrqNKT+hzMclPo118YTQO6cYprQmhrYwIiQ/3axmI1hQomh7Ud2hPOy8SP1" crossorigin="anonymous" />
    </head>


    <body id="home">
        
        <!-- Cabeçalho da página -->
         <%@include file="header.jsp" %>
         
        <!-- Corpo da página -->
        
        <div class="container-fluid display-table">
            <div class="row display-table-row">
                <div class="col-md-10 col-sm-11 display-table-cell v-align">
                    <div class="user-dashboard">
                        <div class="row">

                            <!-- INICIO DE CONTEÚDO  -->
                            <a href="/UsuarioServlet"><button type="button" class="buttonYellow">Usuário</button></a>
                            <!-- Texto Título -->
                            <div class="w-100">
                                <h2 class="text-center">Chamados</h2>
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
                                    <tbody>
                                        <c:forEach var="chamados" items="${requestScope.chamados}">
                                            <tr> 
                                                <td>
                                                    <p class="fw-normal mb-1"> <c:out value="${chamados.idChamado}"/> </p>                            
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