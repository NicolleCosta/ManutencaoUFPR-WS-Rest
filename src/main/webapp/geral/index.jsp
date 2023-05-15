<%-- 
    Document   : index.jsp
    Created on : 4 de mai de 2023, 22:33:50
    Author     : nicol
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<html lang="pt-BR">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>
      SAC - Sistema de Atendimento ao Cliente
    </title>
    <link rel="stylesheet" href="../css/bootstrap.min.css" />
    <link rel="stylesheet" href="../css/fontawesome.min.css" />
    <link rel="stylesheet" href="../css/styles.css" />
    <link rel="icon" type="image/x-icon" href="assets/images/phone-solid.svg">

  </head>
  <body>


    <!-- Corpo da página -->
    <main class="container mb-5">
      
      <div class="text-center">
        <h1 class="text-primary display-3 c-title">
          <img src="assets/sacB.png" class="c-logo-large" alt="Logo do Sistema" />
          SAC - Sistema de Atendimento ao Cliente
        </h1>
      </div>
      <c:if test="${requestScope.msg != null || param.msg != null}" >
                <div class="alert alert-danger alert-dismissible fade show">
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    <span>${requestScope.msg == null ? param.msg : requestScope.msg}</span>
                </div>
      </c:if>
      <div class="row my-3">
        <div class=" d-flex justify-content-center">
          <div class="col-6 p-2 d-flex align-items-stretch">
            <!-- Formulário de login -->
            <form id="form-login" action="LoginServlet" method="POST" class="card text-center bg-info">
              <h2 class="card-header text-light font-weight-bolder">Entrar</h2>
              <img class="card-img-top" src="assets/logo.jpg" alt="Capa">
              <div class="card-body">
                <p class="card-text mt-1 text-light">
                  A BEIBE é uma empresa de Embelezamento Artificial, voltada ao público 
                  jovem e adulto que quer fazer a diferença no mundo. <br> 
                  A <strong>Embuste</strong><sup>&copy;</sup>
                  é a marca de beleza preferida dos brasileiros 
                  (Fonte: Embuste Estatística, 2018). Todos os nossos produtos 
                  tocam sua beleza. É assim que a marca transforma momentos simples em 
                  momentos embusteiros há menos de 0 anos.<br>
                </p>
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
              </div>
            
            </form>
          </div>
        </div>
      </div>
    </main>


    <jsp:include page="footer.jsp" />
</html>
