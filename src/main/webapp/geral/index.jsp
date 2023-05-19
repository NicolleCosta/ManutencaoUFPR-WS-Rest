<%-- Document : index.jsp Created on : 4 de mai de 2023, 22:33:50 Author : nicol --%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>


<html lang="pt-BR">

    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Login</title>

        <!-- CSS only -->
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
              integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous" />
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet"
              integrity="sha384-T8Gy5hrqNKT+hzMclPo118YTQO6cYprQmhrYwIiQ/3axmI1hQomh7Ud2hPOy8SP1" crossorigin="anonymous" />
    </head>

    <body id="login">


        <div class="box-form">

            <!-- Página de login -->
            <h3 class="text-center">Manutenção UFPR</h3>
            <div class="d-flex justify-content-center align-items-center mt-5 mb-5">
                <div class="card">


                    <!--Conteúdo de login e cadastro -->

                    <div class="tab-content" id="pills-tabContent">

                        <c:if test="${requestScope.msg != null || param.msg != null}" >
                            <div class="alert alert-danger alert-dismissible fade show">
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                <span>${requestScope.msg == null ? param.msg : requestScope.msg}</span>
                            </div>
                        </c:if>
                        <c:if test="${requestScope.info != null || param.info != null}" >
                            <div class="alert alert-success alert-dismissible fade show">
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                <span>${requestScope.info == null ? param.info : requestScope.info}</span>
                            </div>
                        </c:if>
                        
                        <!-- Login -->

                        <div class="row my-3">
                            <div class="row" id="left">
                                <img src="./ufpr.jpg" alt="Image" />
                            </div>
                            <div class=" d-flex justify-content-center">
                                <div class="col-6 p-2 d-flex align-items-stretch">
                                    <!-- Formulário de login -->
                                    <form id="form-login" action="LoginServlet" method="POST" class="card text-center bg-info">
                                        <h2 class="card-header text-light font-weight-bolder">Login</h2>
                                        <div class="form-group text-light text-left">
                                            <label for="email">CPF:</label>
                                            <div class="input-group mb-3">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text">
                                                        <i class="fas fa-at"></i>
                                                    </span>
                                                </div>
                                                <input type="number" id="cpf" class="form-control" name="cpf" />
                                            </div>
                                        </div>
                                        <div class="form-group text-light text-left">
                                            <label for="senha">Senha:</label>
                                            <div class="input-group mb-3">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text">
                                                        <i class="fas fa-unlock-alt"></i>
                                                    </span>
                                                </div>
                                                <input type="password" id="senha" class="form-control" name="senha" />
                                            </div>
                                        </div>
                                        <div class="text-center">
                                            <p class="mt-4 mb-4 h5">
                                                Esqueceu a senha? <a href="mailto:example@email.com">Solicite a recuperação da senha</a>
                                            </p>
                                            <button type="submit" class="btn btn-lg btn-light w-75">
                                                Entrar
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="footer.jsp" %>
    </body>
</html>