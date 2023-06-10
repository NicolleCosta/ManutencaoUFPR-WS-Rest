<%-- Document : meuCadastro Created on : 31 de mai de 2023, 20:50:17 Author : nicol --%>

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
            <c:param name="msg"
                     value="Usuário não possui permissão para acessar essa página." />
        </c:redirect>
    </c:if>
</c:if>
<!DOCTYPE html>
<html lang="pt-BR">

    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Meu Cadastro - Administrador</title>



        <!-- Configurações da pagina (fim do head) e Cabeçalho da página -->
        <%@include file="header.jsp" %>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <!-- Corpo da página -->
    <div class="container">
        <c:if test="${requestScope.msg != null || param.msg != null}">
            <div class="alert alert-danger alert-dismissible fade show">
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                <span>${requestScope.msg == null ? param.msg : requestScope.msg}</span>
            </div>
        </c:if>
        <div class="container">
            <c:if test="${requestScope.info != null || param.info != null}">
                <div class="alert alert-success alert-dismissible fade show">
                    <button type="button" class="btn-close"
                            data-bs-dismiss="alert"></button>
                    <span>${requestScope.info == null ? param.info :
                            requestScope.info}</span>
                </div>
            </c:if>
            <div class="row">
                <div class="col">

                    <h1 class="text-primary text-center fw-bold p-3">Meu Cadastro</h1>
                    <jsp:useBean id="usuario" class="br.ufpr.manutencao.dto.UsuarioDTO"
                                 scope="request" />
                    <form action="CadastroServlet?action=alterarCadastro" method="POST"
                          class="mt-5 submit-jsp">
                        <div class="container text-center">
                            <div class="row row-cols-2">
                                <div class="col-4 text-sm-end fw-bold p-3">Nome Completo
                                </div>
                                <div class="col-6 p-3">
                                    <input required maxlength="99" type="text"
                                           class="form-control text-bg-light"
                                           id="nomeCompletoAdm" name="nome"
                                           value="${usuario.nome}">
                                </div>
                                <div class="col-4 text-sm-end fw-bold p-3">CPF</div>
                                <div class="col-6 p-3">
                                    <input type="text" class="form-control text-bg-light"
                                           id="cpf" name="cpf" value="${usuario.cpf}" readonly>
                                </div>
                                <div class="col-4 text-sm-end fw-bold p-3">Telefone</div>
                                <div class="col-6 p-3">
                                    <input type="text" class="form-control text-bg-light"
                                           id="telefone" name="telefone"
                                           value="${usuario.telefone}" required>
                                </div>
                                <div class="col-4 text-sm-end fw-bold p-3">Email</div>
                                <div class="col-6 p-3">
                                    <input type="email" class="form-control text-bg-light"
                                           id="email" name="email" maxlength="99"
                                           value="${usuario.email}" required>
                                </div>
                                <div class="col-4 text-sm-end fw-bold p-3">Senha</div>
                                <div class="col-6 p-3">
                                    <input type="password"
                                           class="form-control text-bg-light" id="senha"
                                           name="senha" maxlength="99" value="${usuario.senha}"
                                           required>
                                </div>
                                <div class="col-4 text-sm-end fw-bold p-3">Confirma Senha
                                </div>
                                <div class="col-6 p-3">
                                    <input type="password"
                                           class="form-control text-bg-light" id="senha2"
                                           maxlength="99" value="${usuario.senha}" required>
                                </div>
                                <script>
                                    document.addEventListener('DOMContentLoaded', function () {
                                        const senha1 = document.getElementById('senha');
                                        const senha2 = document.getElementById('senha2');
                                        const erroSenhaIncorreta = document.getElementById('erroSenhaIncorreta');
                                        const submitButton = document.getElementById('submitButton');

                                        function validaSenhas() {
                                            const senhasIguais = senha1.value === senha2.value;

                                            erroSenhaIncorreta.style.display = senhasIguais ? 'none' : 'block';
                                            submitButton.disabled = !senhasIguais;
                                        }

                                        senha1.addEventListener('input', validaSenhas);
                                        senha2.addEventListener('input', validaSenhas);

                                        // Verifica as senhas ao carregar a página
                                        validaSenhas();
                                    });
                                </script>
                            </div>


                            <div class="d-grid gap-2 justify-content-md-end">
                                <button type="submit" class="btn btn-warning fw-bold btn-lg"
                                        id="submitButton">Salvar</button>
                                <div id="erroSenhaIncorreta"
                                     style="display: none; color: red;">Senhas diferentes!
                                    Para dar continuidade é necessário que as senhas sejam
                                    iguais.</div>

                            </div>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </body>

</html>