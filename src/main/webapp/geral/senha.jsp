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
        <link rel="stylesheet" href="./css/style.css" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
              crossorigin="anonymous">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css"
              rel="stylesheet" integrity="sha384-T8Gy5hrqNKT+hzMclPo118YTQO6cYprQmhrYwIiQ/3axmI1hQomh7Ud2hPOy8SP1"
              crossorigin="anonymous" />
    </head>

    <body id="login">


        <div class="box-form" id="bg-image"
             style="background-image: url('https://ufprvirtual.ufpr.br/theme/image.php/ufprvirtual/theme/1678709585/headerimg');  height: 100vh;  ">



            <!-- Página de login -->


            <!--Conteúdo de login e cadastro -->

            <div class="d-flex justify-content-md-end">
                <div class="tab-content">





                    <div class="container rounded" id="color-overlay">

                        <h1 class="text-center text-primary p-3">Manutenção UFPR</h1>

                        <!-- ************Alertas login************* -->


                      

                        <div class="justify-content-center p-2">
                            <!-- Formulário -->
                            <form id="form-senha" action="LoginServlet" method="POST"
                                  class=" card align-middle text-center bg-primary">
                                <h2 class="card-header text-light font-weight-bolder">Recuperar Senha</h2>
                                <div class="p-3">
                                    <p class="fw-semibold text-light">Para redefinir sua senha, preencha seu CPF abaixo.</p>
                                    <p class="fw-light text-light">Se sua conta for encontrada, um e-mail será enviado para o seu email de cadastro com as instruções para reestabelecer seu acesso.</p>
                                 </div>

                                <div class="form-group text-light text-sm-start p-3">
                                    <label for="cpf" class="text-left">CPF</label>
                                    <div class="input-group mb-3">
                                        <input type="text" class="form-control text-bg-light" id="cpf" name="cpf" maxlength="14" required>

                                    </div>
                                </div>
                                    <div class="py-3">
                                        <button id="logar" type="submit" class="btn btn-lg fw-bold btn-warning w-75">
                                            Enviar
                                        </button>
                                    </div>
                                </div>
                            </form>

                        </div>

                    </div>
                </div>

            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.min.js"></script>
        <script src="js/main.js"></script>
        <script src="${pageContext.servletContext.contextPath}/js/cpf.js"></script>
        <script src="${pageContext.servletContext.contextPath}/js/mask.js"></script>

    </body>

</html>