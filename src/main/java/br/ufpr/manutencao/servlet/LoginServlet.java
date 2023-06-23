/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package br.ufpr.manutencao.servlet;

import br.ufpr.manutencao.dto.LoginDTO;
import br.ufpr.manutencao.dto.UsuarioDTO;
import br.ufpr.manutencao.facade.FacadeException;
import br.ufpr.manutencao.facade.LoginFacade;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.logging.Level;
import java.util.logging.Logger;

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
        try {
            response.setContentType("text/html;charset=UTF-8");
            request.setCharacterEncoding("UTF-8");
            //Valores pegos do formulario
            String cpf = request.getParameter("cpf");
            String senha = request.getParameter("senha");
            
            System.out.println(cpf);
            if(cpf ==  null || senha == null){
                request.setAttribute("msg", "Favor preencher todos os campos!");
                request.setAttribute("page", "/geral/index.jsp");
                RequestDispatcher rd = getServletContext().getRequestDispatcher("/geral/index.jsp");
                rd.forward(request, response);
            }
            UsuarioDTO user = LoginFacade.login(cpf,senha);
            System.out.println("nome " + user.getNome());
            
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
                        //response.sendRedirect("/manutencaoufpr/administrador/home.jsp");
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
            }
        } catch (FacadeException ex) {
            request.setAttribute("msg", " Usuário/Senha inválidos.");
            request.setAttribute("page", "/geral/index.jsp");
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/geral/index.jsp");
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
