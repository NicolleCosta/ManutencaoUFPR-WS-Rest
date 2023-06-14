/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package br.ufpr.manutencao.servlet;

import br.ufpr.manutencao.dto.MaterialDTO;
import br.ufpr.manutencao.dto.OrdemServicoDTO;
import br.ufpr.manutencao.facade.FacadeException;
import br.ufpr.manutencao.facade.MaterialFacade;
import br.ufpr.manutencao.facade.OrdemServicoFacade;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author nicol
 */
@WebServlet(name = "MaterialServlet", urlPatterns = {"/MaterialServlet"})
public class MaterialServlet extends HttpServlet {

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
        String action = request.getParameter("action");
        try {
            if (action == null) {
                //redireciona
                response.sendRedirect("LogoutServlet");
            } else {
                switch (action) {
                    case "mostrarCadastrarMateriais":

                        System.out.println("estrou no mostrarCadastrarMateriais");
                        //PEGA O PARAMETRO PASSADO PELA PAGINA
                        String numeroOS = request.getParameter("numero");
                        //buscar Ordem Servico
                        OrdemServicoDTO ordemServico = OrdemServicoFacade.buscarOS(numeroOS);

                        //buscar Ordem Servico
                        request.setAttribute("ordem", ordemServico);
                        RequestDispatcher rd = getServletContext().getRequestDispatcher("/almoxarife/retiradaMaterial.jsp");
                        rd.forward(request, response);
                        break;

                    case "novoMaterial":
                        System.out.println("entrou no mostrarCadastroMaterial");
                        
                        String nome = request.getParameter("nome");
                        
                        MaterialDTO material= new MaterialDTO();
                        material.setNome(nome);                        
                        MaterialFacade.adicionarMaterial(material);
                        
                        //redireciona
                        request.setAttribute("info", " Material Adicionado");
                        request.setAttribute("page", "/almoxarife/home.jsp");
                        rd = getServletContext().getRequestDispatcher("/OrdemDeServicoServlet?action=mostrarOrdemDeServico");
                        rd.forward(request, response);
                        break;

                    case "registraRetiradaMaterial":
                        System.out.println("entrou no registraRetiradaMaterial");

                        rd = getServletContext().getRequestDispatcher("/almoxarife/registraRetiradaMaterial.jsp");

                        rd.forward(request, response);
                        break;

                    default:
                        //redireciona
                        response.sendRedirect("LogoutServlet");
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
