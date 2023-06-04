/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package br.ufpr.manutencao.servlet;

import br.ufpr.manutencao.dto.ChamadoDTO;
import br.ufpr.manutencao.dto.UsuarioDTO;
import br.ufpr.manutencao.facade.ChamadoFacade;
import br.ufpr.manutencao.facade.FacadeException;
import br.ufpr.manutencao.facade.UsuarioFacade;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author nicol
 */
@WebServlet(name = "CadastroServlet", urlPatterns = {"/CadastroServlet"})
public class CadastroServlet extends HttpServlet {

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
            if (action == null) {
                //redireciona
                response.sendRedirect("LogoutServlet");
            } else {
                switch (action) {
                    case "mostrarMeuCadastro":
                        HttpSession session = request.getSession();
                        UsuarioDTO user = (UsuarioDTO) session.getAttribute("user");
                        int id = user.getId();
                        //BUSCA OBJETO NO BD via Facade
                        UsuarioDTO admin = UsuarioFacade.buscaPorID(id);
                        request.setAttribute("admin", admin);
                        //ENVIA VIA FOWARD
                        RequestDispatcher rd = request.getRequestDispatcher("/administrador/meuCadastro.jsp");
                        rd.forward(request, response);
                        break;

                    case "alterarCadastro":
                        session = request.getSession();
                        user = (UsuarioDTO) session.getAttribute("user");
                        id = user.getId();
                        //BUSCA OBJETO NO BD via Facade
                        UsuarioDTO usuario = UsuarioFacade.buscaPorID(id);

                        String nome = request.getParameter("nome");
                        String telefone = request.getParameter("telefone");
                        String email = request.getParameter("email");
                        String senha = request.getParameter("senha");

                        //adiciona os valores a esse objeto
                        usuario.setNome(nome);
                        usuario.setEmail(email);
                        usuario.setTelefone(telefone);
                        usuario.setSenha(senha);

                        //função para atualizar no bd via Facade
                        UsuarioFacade.aterarUsuario(usuario);

                        //redireciona
                        request.setAttribute("info", " Usuário atualizado");
                        request.setAttribute("page", "/meuCadastro.jsp");
                        rd = getServletContext().getRequestDispatcher("/CadastroServlet?action=mostrarMeuCadastro");
                        rd.forward(request, response);
                        break;

                    case "mostrarUsuariosAdmin":
                        System.out.println("estrou no mostrarUsuariosAdmin");
                        //Carrega a lista de chamados para apresentar
                        List<UsuarioDTO> usuarios = UsuarioFacade.buscarUsuarios();
                        System.out.println(usuarios);

                        //ADD OBJ NA REQUISIÇÃO
                        request.setAttribute("usuarios", usuarios);
                        //redireciona
                        rd = getServletContext().getRequestDispatcher("/administrador/usuarios.jsp");
                        rd.forward(request, response);
                        break;

                    case "mostrarOperariosAdmin":
                        System.out.println("estrou no mostrarOperariosAdmin");
                        //Carrega a lista de chamados para apresentar
                        List<UsuarioDTO> operarios = UsuarioFacade.buscarOperarios();
                        System.out.println(operarios);

                        //ADD OBJ NA REQUISIÇÃO
                        request.setAttribute("operarios", operarios);
                        //redireciona
                        rd = getServletContext().getRequestDispatcher("/administrador/operarios.jsp");
                        rd.forward(request, response);
                        break;

                    default:
                        //redireciona
                        response.sendRedirect("LogoutServlet");
                        break;
                }

            }
        } catch (FacadeException ex) {
            request.setAttribute("msg", ex);
            request.setAttribute("page", "LogoutServlet");
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/erro.jsp");
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
