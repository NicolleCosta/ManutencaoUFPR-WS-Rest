/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package br.ufpr.manutencao.servlet;

import br.ufpr.manutencao.dto.ChamadoDTO;
import br.ufpr.manutencao.dto.EspecialidadeDTO;
import br.ufpr.manutencao.dto.OrdemServicoDTO;
import br.ufpr.manutencao.facade.ChamadoFacade;
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
import java.util.List;

/**
 *
 * @author nicol
 */
@WebServlet(name = "OrdemDeServicoServlet", urlPatterns = {"/OrdemDeServicoServlet"})
public class OrdemDeServicoServlet extends HttpServlet {

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
                    case "mostrarOdemDeServico":
                        System.out.println("estrou no mostrarOdemDeServico");
                        //Carrega a lista de chamados para apresentar
                        List<OrdemServicoDTO> ordensServico = OrdemServicoFacade.buscarOrdensDeServico();
                        System.out.println(ordensServico);

                        //ADD OBJ NA REQUISIÇÃO
                        request.setAttribute("ordensServico", ordensServico);
                        //redireciona
                        RequestDispatcher rd = getServletContext().getRequestDispatcher("/administrador/ordensDeServico.jsp");
                        rd.forward(request, response);

                        break;

                    case "novaOrdemServico":
                        System.out.println("entrou na novaOrdemServico");

                        int idChamado = Integer.parseInt(request.getParameter("idChamado"));

                        String descricaoLocal = request.getParameter("descricaoLocal");
                        String descricaoProblema = request.getParameter("descricaoProblema");
                        String numeroOS = request.getParameter("numeroOS");
                        int especialidade = Integer.parseInt(request.getParameter("especialidade"));

                        OrdemServicoDTO ordem = new OrdemServicoDTO();

                        ordem.setDescricaoLocal(descricaoLocal);
                        ordem.setDescricaoProblema(descricaoProblema);
                        ordem.setEspecialidadeId(new EspecialidadeDTO(especialidade));
                        ordem.setNumeroOS(numeroOS);
                        
                         System.out.println(ordem);

                        //função para add OS no bd via Facade
                        OrdemServicoFacade.adicionarOS(ordem);
                        
                        //funcao para id da OS nova via Facade
                        int idOS= OrdemServicoFacade.buscarIdOS(numeroOS);
                        System.out.println(idOS);
 
                        //funcao para buscar Associar Chamado ao ID da OS
                        ChamadoFacade.associarChamado(idChamado,idOS);

                        //redireciona
                        request.setAttribute("info", "Chamado associado à nova Ordem de Serviço!");
                        request.setAttribute("page", "/home.jsp");
                        rd = getServletContext().getRequestDispatcher("/ChamadoServlet?action=mostrarHomeAdmin");
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
