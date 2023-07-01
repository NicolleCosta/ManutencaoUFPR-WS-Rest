/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package br.ufpr.manutencao.servlet;

import br.ufpr.manutencao.dto.LoginDTO;
import br.ufpr.manutencao.dto.UsuarioDTO;
import br.ufpr.manutencao.facade.FacadeException;
import br.ufpr.manutencao.facade.LoginFacade;
import br.ufpr.manutencao.facade.UsuarioFacade;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.commons.lang3.RandomStringUtils;

/**
 *
 * @author nicol
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        try {
            if (action != null) {
                switch (action) {
                    case "login":
                        //Valores pegos do formulario
                        String cpf = request.getParameter("cpf");
                        String senha = request.getParameter("senha");

                        if (cpf == null || senha == null) {
                            request.setAttribute("msg", "Favor preencher todos os campos!");
                            request.setAttribute("page", "/geral/index.jsp");
                            RequestDispatcher rd = getServletContext().getRequestDispatcher("/geral/index.jsp");
                            rd.forward(request, response);
                        }
                        UsuarioDTO user = LoginFacade.login(cpf, senha);

                        boolean isBlock = user.getBloqueio();
                        if (isBlock) {
                            request.setAttribute("msg", "Usuário bloqueado. Favor, entrar em contato com o seu gestor.");
                            request.setAttribute("page", "/geral/index.jsp");
                            RequestDispatcher rd = getServletContext().getRequestDispatcher("/geral/index.jsp");
                            rd.forward(request, response);
                        } else {

                            boolean isValid = user.getId() > 0 ? true : false;
                            if (isValid) {
                                //Armazena o nome do usuário na sessão (indicando que o usuário está logado)
                                HttpSession session = request.getSession();
                                UsuarioDTO usu = new UsuarioDTO();
                                usu.setId(user.getId());
                                usu.setNome(user.getNome());
                                usu.setTipoUsuarioId(user.getTipoUsuarioId());
                                session.setAttribute("user", usu);

                                switch (user.getTipoUsuarioId().getNome()) {
                                    case "administrador":
                                        response.sendRedirect("ChamadoServlet?action=mostrarChamados");
                                        break;

                                    case "almoxarife":
                                        response.sendRedirect("OrdemDeServicoServlet?action=mostrarOrdemDeServico");
                                        break;

                                    case "gerente":
                                        response.sendRedirect("ChamadoServlet?action=mostrarHomeGer");
                                        break;

                                    default:
                                        response.sendRedirect("Vai para erro");
                                        break;
                                }
                            } else {
                                request.setAttribute("msg", " Usuário/Senha inválidos.");
                                request.setAttribute("page", "/geral/index.jsp");
                                RequestDispatcher rd = getServletContext().getRequestDispatcher("/geral/index.jsp");
                                rd.forward(request, response);
                                break;
                            }
                            break;
                        }
                        
                    case "esqueciSenha":
                        System.out.println("entrou no esqueciSenha");

                        cpf = request.getParameter("cpf");

                        UsuarioDTO usuario = UsuarioFacade.usuarioCPF(cpf);

                        if (usuario == null) {
                            request.setAttribute("msg", "Não foi encontrado nenhum usuário com esse CPF ");
                            RequestDispatcher rd = getServletContext().getRequestDispatcher("/geral/index.jsp");
                            rd.forward(request, response);
                            break;
                        }

                        //Gerar nova senha
                        String novaSenha = RandomStringUtils.randomAlphanumeric(5);
                        System.out.println("novaSenha" + novaSenha);

                        // Configurações do servidor de e-mail
                        String host = "smtp.office365.com";
                        int porta = 587;
                        String usuarioEmail = " @outlook.com";
                        String senhaEmail = " ";
                        String remetente = " @outlook.com";
                        String menssagem = ("Sua nova senha de acesso é: " + novaSenha);
                        String assunto = ("Recuperação de Senha");
                        String destinatario = usuario.getEmail();

// Configurações adicionais
                        Properties props = new Properties();
                        props.put("mail.smtp.auth", "true");
                        props.put("mail.smtp.starttls.enable", "true");
                        props.put("mail.smtp.host", host);
                        props.put("mail.smtp.port", porta);
                        props.put("mail.smtp.ssl.trust", host);
                        try {
                            // Sessão
                            Session sessao = Session.getDefaultInstance(props);
                            System.out.println("passou pela sessão");

                            Message msg = new MimeMessage(sessao);

                            msg.setContent(menssagem, "text/html");
                            msg.setSubject(assunto);
                            msg.setFrom(new InternetAddress(remetente));
                            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(destinatario));

                            Transport transport = sessao.getTransport("smtp");
                            transport.connect(host, porta, usuarioEmail, senhaEmail);
                            System.out.println("passou pelo envio");
                            usuario.setSenha(novaSenha);
                            UsuarioFacade.alterarUsuario(usuario);
                            System.out.println("alterou a senha");

                            request.setAttribute("info", "E-mail de recuperação de senha enviado!");
                            RequestDispatcher rd = getServletContext().getRequestDispatcher("/geral/index.jsp");
                            rd.forward(request, response);
                        } catch (MessagingException ex) {
                            request.setAttribute("msg", "Não foi possível conectar ao host!!");
                            ex.printStackTrace();
                            RequestDispatcher rd = getServletContext().getRequestDispatcher("/geral/index.jsp");
                            rd.forward(request, response);
                        }
                        break;

                    default:
                        break;
                }
            }
        } catch (FacadeException ex) {
            request.setAttribute("msg", ex);
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/geral/erro.jsp");
            rd.forward(request, response);
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
