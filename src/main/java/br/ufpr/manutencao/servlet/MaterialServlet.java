/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package br.ufpr.manutencao.servlet;

import br.ufpr.manutencao.dto.ComentarioOperarioDTO;
import br.ufpr.manutencao.dto.MaterialDTO;
import br.ufpr.manutencao.dto.OrdemServicoDTO;
import br.ufpr.manutencao.dto.RetiradaMaterialDTO;
import br.ufpr.manutencao.dto.UsuarioDTO;
import br.ufpr.manutencao.facade.ComentarioOperarioFacade;
import br.ufpr.manutencao.facade.FacadeException;
import br.ufpr.manutencao.facade.MaterialFacade;
import br.ufpr.manutencao.facade.OrdemServicoFacade;
import br.ufpr.manutencao.facade.RetiradaMaterialFacade;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

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
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        try {
            if (action == null) {
                //redireciona
                response.sendRedirect("LogoutServlet");
            } else {
                switch (action) {
                    case "mostrarCadastrarMateriais":

                        System.out.println("eNtrou no mostrarCadastrarMateriais");
                        //PEGA O PARAMETRO PASSADO PELA PAGINA
                        String numeroOS = request.getParameter("numero");
                        //buscar Ordem Servico , comentaros, materiais
                        OrdemServicoDTO ordemServico = OrdemServicoFacade.buscarOS(numeroOS);
                        List<ComentarioOperarioDTO> comentarios = ComentarioOperarioFacade.buscarComentarioPorId(ordemServico.getId());
                        List<MaterialDTO> materiais = MaterialFacade.buscarMateriais();
                        Collections.sort(materiais, Comparator.comparing(MaterialDTO::getNome));
                        List<RetiradaMaterialDTO> retiradas = RetiradaMaterialFacade.buscarRetiradasIdOS(ordemServico.getId());

                        //add objetos/listas
                        request.setAttribute("retiradas", retiradas);
                        request.setAttribute("materiais", materiais);
                        request.setAttribute("ordem", ordemServico);
                        request.setAttribute("comentarios", comentarios);
                        RequestDispatcher rd = getServletContext().getRequestDispatcher("/almoxarife/retiradaMaterial.jsp");
                        rd.forward(request, response);
                        break;

                    case "novoMaterial":
                        System.out.println("entrou no novoMaterial");

                        String nome = request.getParameter("nome");

                        MaterialDTO material = new MaterialDTO();
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
                        
                        numeroOS = request.getParameter("nrOS");

                        HttpSession session = request.getSession();
                        UsuarioDTO user = (UsuarioDTO) session.getAttribute("user");
                        int usuario = user.getId();
                        String[] quantidades = request.getParameterValues("quantidade[]");
                        String[] unidades = request.getParameterValues("unidade[]");
                        String[] materiaisStr = request.getParameterValues("material[]");
                        int ordem = Integer.parseInt(request.getParameter("ordem"));

                        System.out.println("qtdd: "+quantidades);
                        System.out.println("und: "+unidades);
                        System.out.println("mat: "+materiaisStr);
                        
                        List<RetiradaMaterialDTO> listaRetiradaMaterial = new ArrayList<>();

                        for (int i = 0; i < quantidades.length; i++) {
                            RetiradaMaterialDTO retiradaMaterialDTO = new RetiradaMaterialDTO();

                            retiradaMaterialDTO.setQuantidade(Integer.parseInt(quantidades[i]));
                            retiradaMaterialDTO.setUnidade(unidades[i]);
                            retiradaMaterialDTO.setMaterialId(new MaterialDTO(Integer.parseInt(materiaisStr[i])));
                            retiradaMaterialDTO.setOrdemServicoId(new OrdemServicoDTO(ordem));
                            retiradaMaterialDTO.setUsuarioId(new UsuarioDTO(usuario));
                            listaRetiradaMaterial.add(retiradaMaterialDTO);
                        }
                        System.out.println(listaRetiradaMaterial);
                        RetiradaMaterialFacade.adicionaListaRetirada(listaRetiradaMaterial);

                        rd = getServletContext().getRequestDispatcher("/MaterialServlet?action=mostrarCadastrarMateriais&numero="+numeroOS);

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
