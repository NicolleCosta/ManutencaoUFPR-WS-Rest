<%-- 
    Document   : index.jsp
    Created on : 4 de mai de 2023, 22:33:50
    Author     : nicol
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login</title>

    <!-- CSS only -->
    <link rel="stylesheet" href="css/style.css" />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
      integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
      crossorigin="anonymous"
    />
    <link
      href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css"
      rel="stylesheet"
      integrity="sha384-T8Gy5hrqNKT+hzMclPo118YTQO6cYprQmhrYwIiQ/3axmI1hQomh7Ud2hPOy8SP1"
      crossorigin="anonymous"
    />
  </head>
  
  <body id="login">


    <div class="box-form">
      <div class="left">
        <div class="overlay">
        <h1>Hello World.</h1>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        Curabitur et est sed felis aliquet sollicitudin</p>
        <span>
        </span>
        </div>
      </div>
     
    <!-- Página de login -->
     <h3 class="text-center">Manutenção UFPR</h3>
    <div class="d-flex justify-content-center align-items-center mt-5 mb-5">
      <div class="card">
    

        <!--Conteúdo de login e cadastro -->

        <div class="tab-content" id="pills-tabContent">
          <!-- Login -->

          <div
            class="tab-pane fade show active"
            id="pills-login"
            role="tabpanel"
            aria-labelledby="pills-login-tab"
          >
            <div class="form px-4 h-auto">
               

              <p class="text-center">Digite seu CPF e senha para entrar</p>
              <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
                <input
                  required
                  type="number"
                  name="cpf"
                  class="form-control mt-4"
                  placeholder="CPF"
                />

                <input
                  required
                  type="password"
                  name="Senha"
                  class="form-control"
                  placeholder="Senha"
                />
                <input
                  type="submit"
                  value="Entrar"
                  class="btn btn-success btn-block"
                />
                
                
                <c:set var="falha" value="${param.falha}" />
                <c:if test="${falha}">
                    <h5>Usuário ou Senha Inválidos</h5>
                    <br>
                </c:if>

                
                
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>


    </div>

  <%@include file="footer.jsp" %>
  
  </body>
</html>
