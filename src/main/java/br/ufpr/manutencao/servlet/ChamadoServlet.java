/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package br.ufpr.manutencao.servlet;

import br.ufpr.manutencao.dto.ChamadoDTO;
import br.ufpr.manutencao.dto.EspecialidadeDTO;
import br.ufpr.manutencao.dto.OrdemServicoDTO;
import br.ufpr.manutencao.facade.ChamadoFacade;
import br.ufpr.manutencao.facade.EspecialidadeFacade;
import br.ufpr.manutencao.facade.FacadeException;
import br.ufpr.manutencao.facade.OrdemServicoFacade;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

/**
 *
 * @author nicol
 */
@WebServlet(name = "ChamadoServlet", urlPatterns = {"/ChamadoServlet"})
public class ChamadoServlet extends HttpServlet {

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
                    case "mostrarHomeAdmin":
                        System.out.println("entrou no mostrarhomeAdmin");
                        //Carrega a lista de chamados para apresentar
//                        List<ChamadoDTO> chamadosSemOS = ChamadoFacade.buscarChamadosSemOS();
//                        
//                        
//                        List<ChamadoDTO> chamadosComOS = ChamadoFacade.buscarChamadosComOS();
//                        
//                        List<ChamadoDTO> chamadosAbertos = ChamadoFacade.buscarChamadosAbertos();
//                        System.out.println(chamadosAbertos);
//
//                        List<ChamadoDTO> chamadosEmAndamento = ChamadoFacade.buscarChamadosEmAndamento();
//                        System.out.println(chamadosEmAndamento);
                        List<OrdemServicoDTO> ordens = OrdemServicoFacade.buscarOrdensDeServico();
                        List<EspecialidadeDTO> especialidades = EspecialidadeFacade.buscarEspecialidades();
                        List<ChamadoDTO> chamados = ChamadoFacade.buscarChamados();
                        List<ChamadoDTO> chamadosAsc = new ArrayList<>(chamados);
                        List<ChamadoDTO> chamadosDesc = new ArrayList<>(chamados);

                        // Ordenar os chamados em ordem crescente de dataHora
                        Collections.sort(chamadosAsc, Comparator.comparing(ChamadoDTO::getDataHora));

                        // Ordenar os chamados em ordem decrescente de dataHora
                        Collections.sort(chamadosDesc, Comparator.comparing(ChamadoDTO::getDataHora));
                        Collections.reverse(chamadosDesc);

                        //ADD OBJ NA REQUISIÇÃO
                        //request.setAttribute("chamadosAbertos", chamadosAbertos);
                        //request.setAttribute("chamadosEmAndamento", chamadosEmAndamento);
//                        request.setAttribute("chamadosSemOS", chamadosSemOS);
//                        request.setAttribute("chamadosComOS", chamadosComOS);
                        request.setAttribute("ordens", ordens);
                        request.setAttribute("especialidades", especialidades);
                        request.setAttribute("listaChamadosAsc", chamadosAsc);
                        request.setAttribute("listaChamadosDesc", chamadosDesc);
                        System.out.println("passando os chamados" + chamados);
                        //redireciona
                        RequestDispatcher rd = getServletContext().getRequestDispatcher("/administrador/home.jsp");
                        rd.forward(request, response);
                        break;
                        
                        case "mostrarHomeGer":
                        System.out.println("entrou no mostrarHomeGer");
                        
                        //redireciona
                        rd = getServletContext().getRequestDispatcher("/gerente/home.jsp");
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
