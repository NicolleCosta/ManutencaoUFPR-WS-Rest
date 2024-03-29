/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package br.ufpr.manutencao.servlet;

import br.ufpr.manutencao.dto.ChamadoDTO;
import br.ufpr.manutencao.dto.ComentarioOperarioDTO;
import br.ufpr.manutencao.dto.EspecialidadeDTO;
import br.ufpr.manutencao.dto.OrdemServicoDTO;
import br.ufpr.manutencao.dto.UsuarioDTO;
import br.ufpr.manutencao.facade.ChamadoFacade;
import br.ufpr.manutencao.facade.ComentarioOperarioFacade;
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
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

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
        HttpSession session = request.getSession();
        UsuarioDTO user = (UsuarioDTO) session.getAttribute("user");

        try {
            if (action == null || user == null) {
                //redireciona
                response.sendRedirect("LogoutServlet");
            } else {
                switch (action) {
                    case "mostrarChamados":

                        List<OrdemServicoDTO> ordens = OrdemServicoFacade.buscarOrdensDeServico();
                        List<EspecialidadeDTO> especialidades = EspecialidadeFacade.buscarEspecialidades();
                        List<ChamadoDTO> chamados = ChamadoFacade.buscarChamados();
                        List<ChamadoDTO> chamadosAsc = new ArrayList<>(chamados);
                        List<ChamadoDTO> chamadosDesc = new ArrayList<>(chamados);
                        List<ComentarioOperarioDTO> comentarios = ComentarioOperarioFacade.buscarComentarios();

                        // Ordenar os comentarios em ordem crescente de dataHora
                        Collections.sort(comentarios, Comparator.comparing(ComentarioOperarioDTO::getDataHora));

                        // Ordenar os chamados em ordem crescente de dataHora
                        Collections.sort(chamadosAsc, Comparator.comparing(ChamadoDTO::getDataHora));

                        // Ordenar os chamados em ordem decrescente de dataHora
                        Collections.sort(chamadosDesc, Comparator.comparing(ChamadoDTO::getDataHora));
                        Collections.reverse(chamadosDesc);


                        request.setAttribute("ordens", ordens);
                        request.setAttribute("especialidades", especialidades);
                        request.setAttribute("comentarios", comentarios);
                        request.setAttribute("listaChamadosAsc", chamadosAsc);
                        request.setAttribute("listaChamadosDesc", chamadosDesc);


                        RequestDispatcher rd = null;
                        //redireciona
                        if (user.getTipoUsuarioId().getId().equals(3)) {
                            rd = getServletContext().getRequestDispatcher("/administrador/home.jsp");
                        }
                        if (user.getTipoUsuarioId().getId().equals(5)) {
                            rd = getServletContext().getRequestDispatcher("/gerente/chamados.jsp");
                        }
                        rd.forward(request, response);

                        break;

                    case "mostrarHomeGer":
                        //Resultados sobre Chamados
                        String qtddChamadosMais30DiasAbertos = ChamadoFacade.contaMais30DiasAbertos();
                        String qtddChamadoMais10DiasSemOS = ChamadoFacade.contaMais10DiasSemOS();
                        String qtddChamadoAbertos = ChamadoFacade.contaAbertos();
                        String qtddChamadoAbertosSemOS = ChamadoFacade.contaAbertosSemOS();
                        String qtddChamadoAno = ChamadoFacade.contaAno();
                        String qtddChamadoEncerradoAno = ChamadoFacade.contaEncerradoAno();
                        //Resultados sobre Ordens
                        String qtddOSMais30DiasAbertos = OrdemServicoFacade.contaMais30DiasAbertos();
                        String qtddOSMais10DiasSemOP = OrdemServicoFacade.contaMais10DiasSemOP();
                        String qtddOSAbertos = OrdemServicoFacade.contaAbertos();
                        String qtddOSAndamento = OrdemServicoFacade.contaAndamento();
                        String qtddOSEncerradoUltimos30Dias = OrdemServicoFacade.contaEncerradoUltimos30Dias();
                        String qtddOSEncerradoAno = OrdemServicoFacade.contaEncerradoAno();
                        List<Map<String, Object>> top3PrediosOSResponse = OrdemServicoFacade.top3PrediosOS();

                        List<Map<String, Object>> top3EspecialidadesResponse = OrdemServicoFacade.top3Especialidades();

                        // Busca o ano atual
                        LocalDate dataAtual = LocalDate.now();
                        int anoAtual = dataAtual.getYear();

                        //ADD NA REQUISIÇÃO
                        request.setAttribute("anoAtual", anoAtual);
                        request.setAttribute("top3PrediosOS", top3PrediosOSResponse);
                        request.setAttribute("top3Especialidades", top3EspecialidadesResponse);

                        request.setAttribute("qtddChamadosMais30DiasAbertos", qtddChamadosMais30DiasAbertos);
                        request.setAttribute("qtddChamadoMais10DiasSemOS", qtddChamadoMais10DiasSemOS);
                        request.setAttribute("qtddChamadoAbertos", qtddChamadoAbertos);
                        request.setAttribute("qtddChamadoAbertosSemOS", qtddChamadoAbertosSemOS);
                        request.setAttribute("qtddChamadoAno", qtddChamadoAno);
                        request.setAttribute("qtddChamadoEncerradoAno", qtddChamadoEncerradoAno);
                        request.setAttribute("qtddOSMais30DiasAbertos", qtddOSMais30DiasAbertos);
                        request.setAttribute("qtddOSMais10DiasSemOP", qtddOSMais10DiasSemOP);
                        request.setAttribute("qtddOSAbertos", qtddOSAbertos);
                        request.setAttribute("qtddOSAndamento", qtddOSAndamento);
                        request.setAttribute("qtddOSEncerradoUltimos30Dias", qtddOSEncerradoUltimos30Dias);
                        request.setAttribute("qtddOSEncerradoAno", qtddOSEncerradoAno);

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
