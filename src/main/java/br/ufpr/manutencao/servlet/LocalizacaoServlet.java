/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package br.ufpr.manutencao.servlet;

import br.ufpr.manutencao.dto.CampusDTO;
import br.ufpr.manutencao.dto.PredioDTO;
import br.ufpr.manutencao.facade.FacadeException;
import br.ufpr.manutencao.facade.LocalizacaoFacade;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author nicol
 */
@WebServlet(name = "LocalizacaoServlet", urlPatterns = {"/LocalizacaoServlet"})
public class LocalizacaoServlet extends HttpServlet {

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
                    case "mostrarLocalizacao":
                        //Carrega a lista de chamados para apresentar
                        List<CampusDTO> listaCampus = LocalizacaoFacade.buscarCampus();

                        //ADD OBJ NA REQUISIÇÃO
                        request.setAttribute("listaCampus", listaCampus);
                        //redireciona
                        RequestDispatcher rd = getServletContext().getRequestDispatcher("/administrador/localizacao.jsp");
                        rd.forward(request, response);
                        break;

                    case "novoPredio":
                        
                        //pega valor do formulário
                        int campusSelecionado = Integer.parseInt(request.getParameter("campusSelecionado"));
                        String nome = request.getParameter("nome");
                        
                        //cria novo objeto
                        CampusDTO campus = new CampusDTO();
                        campus.setId(campusSelecionado);
                        PredioDTO predio = new PredioDTO();

                        //adiciona os atributos a esse objeto
                        predio.setCampusId(campus);
                        predio.setNome(nome);
                        predio.setStatus(true);
         
                        //Requisicao por Facade
                        LocalizacaoFacade.adicionarPredio(predio);

                        //redireciona
                        request.setAttribute("info", " Predio adicionado com sucesso!");
                        request.setAttribute("page", "localizacao.jsp");
                        rd = getServletContext().getRequestDispatcher("/LocalizacaoServlet?action=mostrarLocalizacao");
                        rd.forward(request, response);
                        break;
                        
                    case "novoCampus":
                        //pega valor do formulário
                        nome = request.getParameter("nome");
                        
                        //cria novo objeto
                        campus = new CampusDTO();

                        //adiciona os atributos a esse objeto
                        campus.setNome(nome);
                        campus.setStatus(true);

                        //Requisicao por Facade
                        LocalizacaoFacade.adicionarCampus(campus);

                        //redireciona
                        request.setAttribute("info", " Campus adicionado com sucesso!");
                        request.setAttribute("page", "localizacao.jsp");
                        rd = getServletContext().getRequestDispatcher("/LocalizacaoServlet?action=mostrarLocalizacao");
                        rd.forward(request, response);
                        break;
                        
                    case "bloquearCampus":
                        //pega valor do formulário
                        campusSelecionado = Integer.parseInt(request.getParameter("campusId"));;
                        

                        //Requisicao por Facade
                        LocalizacaoFacade.bloquearCampus(campusSelecionado);

                        //redireciona
                        request.setAttribute("info", " Campus bloqueado com sucesso!");
                        request.setAttribute("page", "localizacao.jsp");
                        rd = getServletContext().getRequestDispatcher("/LocalizacaoServlet?action=mostrarLocalizacao");
                        rd.forward(request, response);
                        break;
                        
                        
                     case "bloquearPredio":
                        //pega valor do formulário
                        int predioSelecionado = Integer.parseInt(request.getParameter("predioId"));
                      
                        //Requisicao por Facade
                        LocalizacaoFacade.bloquearPredio(predioSelecionado);

                        //redireciona
                        request.setAttribute("info", " Predio bloqueado com sucesso!");
                        request.setAttribute("page", "localizacao.jsp");
                        rd = getServletContext().getRequestDispatcher("/LocalizacaoServlet?action=mostrarLocalizacao");
                        rd.forward(request, response);
                        break;

                    default:
                        //redireciona
                        response.sendRedirect("LogoutServlet");
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
