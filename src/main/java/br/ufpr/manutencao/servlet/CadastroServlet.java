/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package br.ufpr.manutencao.servlet;

import br.ufpr.manutencao.dto.ChamadoDTO;
import br.ufpr.manutencao.dto.EspecialidadeDTO;
import br.ufpr.manutencao.dto.TipoUsuarioDTO;
import br.ufpr.manutencao.dto.UsuarioDTO;
import br.ufpr.manutencao.facade.TipoUsuarioFacade;
import br.ufpr.manutencao.facade.EspecialidadeFacade;
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
                        UsuarioDTO dados = UsuarioFacade.buscaPorID(id);
                        request.setAttribute("usuario", dados);

                        RequestDispatcher rd = null;
                        //redireciona
                        if (user.getTipoUsuarioId().getId().equals(3)) {
                            rd = getServletContext().getRequestDispatcher("/administrador/meuCadastro.jsp");
                        }
                        if (user.getTipoUsuarioId().getId().equals(5)) {
                            rd = getServletContext().getRequestDispatcher("/gerente/meuCadastro.jsp");
                        }
  
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
                        session = request.getSession();
                        user = (UsuarioDTO) session.getAttribute("user");

                        System.out.println("estrou no mostrarUsuariosAdmin");
                        //Carrega a lista de chamados para apresentar
                        List<UsuarioDTO> usuarios = UsuarioFacade.buscarUsuarios();
                        System.out.println(usuarios);

                        //ADD OBJ NA REQUISIÇÃO
                        request.setAttribute("usuarios", usuarios);

                        rd = null;

                        //redireciona
                        if (user.getTipoUsuarioId().getId().equals(3)) {
                            rd = getServletContext().getRequestDispatcher("/administrador/usuarios.jsp");
                        }
                        if (user.getTipoUsuarioId().getId().equals(5)) {
                            rd = getServletContext().getRequestDispatcher("/gerente/usuarios.jsp");
                        }
                        rd.forward(request, response);
                        break;

                    case "mostrarOperariosAdmin":
                        session = request.getSession();
                        user = (UsuarioDTO) session.getAttribute("user");

                        System.out.println("estrou no mostrarOperariosAdmin");
                        //Carrega a lista de chamados para apresentar
                        List<UsuarioDTO> operarios = UsuarioFacade.buscarOperarios();
                        System.out.println(operarios);
                        List<EspecialidadeDTO> especialidades = EspecialidadeFacade.buscarEspecialidades();
                        System.out.println(especialidades);
                        //ADD OBJ NA REQUISIÇÃO
                        request.setAttribute("operarios", operarios);
                        request.setAttribute("especialidades", especialidades);

                        rd = null;

                        //redireciona
                        if (user.getTipoUsuarioId().getId().equals(3)) {
                            rd = getServletContext().getRequestDispatcher("/administrador/operarios.jsp");
                        }
                        if (user.getTipoUsuarioId().getId().equals(5)) {
                            rd = getServletContext().getRequestDispatcher("/gerente/operarios.jsp");
                        }
                        rd.forward(request, response);
                        break;

                    case "novoOperario":
                        System.out.println("entrou serveletnovo usuario");
                        nome = request.getParameter("nome");
                        String cpf = request.getParameter("cpf");
                        telefone = request.getParameter("telefone");
                        email = request.getParameter("email");
                        int especialidade = Integer.parseInt(request.getParameter("especialidade"));

                        usuario = new UsuarioDTO();
                        //adiciona os valores a esse objeto
                        usuario.setNome(nome);
                        usuario.setCpf(cpf);
                        usuario.setTelefone(telefone);
                        usuario.setEmail(email);
                        usuario.setSenha(cpf);
                        usuario.setBloqueio(false);
                        usuario.setEspecialidadeId(new EspecialidadeDTO(especialidade));
                        usuario.setTipoUsuarioId(new TipoUsuarioDTO(2));

                        System.out.println("Usuario : " + usuario);
                        //função para atualizar no bd via Facade
                        UsuarioFacade.adicionarUsuario(usuario);

                        //redireciona
                        request.setAttribute("info", " Operário cadastrado");
                        request.setAttribute("page", "/operarios.jsp");
                        rd = getServletContext().getRequestDispatcher("/CadastroServlet?action=mostrarOperariosAdmin");
                        rd.forward(request, response);
                        break;

                    case "alterarCadastroOperario":
                        id = Integer.parseInt(request.getParameter("id"));

                        //BUSCA OBJETO NO BD via Facade
                        usuario = UsuarioFacade.buscaPorID(id);

                        nome = request.getParameter("nome");
                        telefone = request.getParameter("telefone");
                        email = request.getParameter("email");
                        especialidade = Integer.parseInt(request.getParameter("especialidade"));

                        //altera os valores desse objeto
                        usuario.setNome(nome);
                        usuario.setEmail(email);
                        usuario.setTelefone(telefone);
                        usuario.setEspecialidadeId(new EspecialidadeDTO(especialidade));

                        //função para atualizar no bd via Facade
                        UsuarioFacade.aterarUsuario(usuario);

                        //redireciona
                        request.setAttribute("info", " Operário atualizado");
                        rd = getServletContext().getRequestDispatcher("/CadastroServlet?action=mostrarOperariosAdmin");
                        rd.forward(request, response);
                        break;

                    case "alterarModoBloqueioFuncionario":
                        id = Integer.parseInt(request.getParameter("id"));

                        //BUSCA OBJETO NO BD via Facade
                        usuario = UsuarioFacade.buscaPorID(id);

                        //altera os valores desse objeto
                        if (usuario.getBloqueio() == true) {
                            usuario.setBloqueio(false);
                        } else {
                            usuario.setBloqueio(true);
                        }

                        //função para atualizar no bd via Facade
                        UsuarioFacade.aterarUsuario(usuario);

                        //redireciona
                        request.setAttribute("info", "Situação do funcionário atualizada");
                        rd = getServletContext().getRequestDispatcher("/CadastroServlet?action=mostrarFuncionariosGer");
                        rd.forward(request, response);
                        break;
                        
                        case "alterarModoBloqueioOperario":
                        id = Integer.parseInt(request.getParameter("id"));

                        //BUSCA OBJETO NO BD via Facade
                        usuario = UsuarioFacade.buscaPorID(id);

                        //altera os valores desse objeto
                        if (usuario.getBloqueio() == true) {
                            usuario.setBloqueio(false);
                        } else {
                            usuario.setBloqueio(true);
                        }

                        //função para atualizar no bd via Facade
                        UsuarioFacade.aterarUsuario(usuario);

                        //redireciona
                        request.setAttribute("info", "Situação do operário atualizada");
                        rd = getServletContext().getRequestDispatcher("/CadastroServlet?action=mostrarOperariosAdmin");
                        rd.forward(request, response);
                        break;

                    case "alterarModoBloqueioUsuario":
                        id = Integer.parseInt(request.getParameter("id"));

                        //BUSCA OBJETO NO BD via Facade
                        usuario = UsuarioFacade.buscaPorID(id);

                        //altera os valores desse objeto
                        if (usuario.getBloqueio() == true) {
                            usuario.setBloqueio(false);
                        } else {
                            usuario.setBloqueio(true);
                        }

                        //função para atualizar no bd via Facade
                        UsuarioFacade.aterarUsuario(usuario);

                        //redireciona
                        request.setAttribute("info", "Situação do usuário atualizada");
                        rd = getServletContext().getRequestDispatcher("/CadastroServlet?action=mostrarUsuariosAdmin");
                        rd.forward(request, response);
                        break;
                        
                        
                        case "mostrarFuncionariosGer":
                        System.out.println("entrou no mostrarFuncionariosGer");
                        //Carrega a lista de chamados para apresentar
                        List<UsuarioDTO> funcionarios = UsuarioFacade.buscarfuncionarios();
                        System.out.println(funcionarios);
                        List<TipoUsuarioDTO> tiposUsuario = TipoUsuarioFacade.buscarTiposUsuarios();
                        System.out.println(tiposUsuario);
                        //ADD OBJ NA REQUISIÇÃO
                        request.setAttribute("funcionarios", funcionarios);
                        request.setAttribute("tiposUsuario", tiposUsuario);

                        //redireciona
                        rd = getServletContext().getRequestDispatcher("/gerente/funcionarios.jsp");
                        rd.forward(request, response);
                        break;
                        
                        
                        case "alterarCadastroFuncionario":
                        id = Integer.parseInt(request.getParameter("id"));

                        //BUSCA OBJETO NO BD via Facade
                        usuario = UsuarioFacade.buscaPorID(id);

                        nome = request.getParameter("nome");
                        telefone = request.getParameter("telefone");
                        email = request.getParameter("email");
                        int tipoUsuario = Integer.parseInt(request.getParameter("tipoUsuario"));

                        //altera os valores desse objeto
                        usuario.setNome(nome);
                        usuario.setEmail(email);
                        usuario.setTelefone(telefone);
                        usuario.setTipoUsuarioId(new TipoUsuarioDTO(tipoUsuario));

                        //função para atualizar no bd via Facade
                        UsuarioFacade.aterarUsuario(usuario);

                        //redireciona
                        request.setAttribute("info", " Funcionário atualizado!");
                        rd = getServletContext().getRequestDispatcher("/CadastroServlet?action=mostrarFuncionariosGer");
                        rd.forward(request, response);
                        break;
                        
                        case "novoFuncionario":
                        System.out.println("entrou serveletnovo usuario");
                        nome = request.getParameter("nome");
                        cpf = request.getParameter("cpf");
                        telefone = request.getParameter("telefone");
                        email = request.getParameter("email");
                        tipoUsuario = Integer.parseInt(request.getParameter("tipoUsuario"));

                        usuario = new UsuarioDTO();
                        //adiciona os valores a esse objeto
                        usuario.setNome(nome);
                        usuario.setCpf(cpf);
                        usuario.setTelefone(telefone);
                        usuario.setEmail(email);
                        usuario.setSenha(cpf);
                        usuario.setBloqueio(false);
                        usuario.setEspecialidadeId(new EspecialidadeDTO(1));
                        usuario.setTipoUsuarioId(new TipoUsuarioDTO(tipoUsuario));

                        System.out.println("Usuario : " + usuario);
                        //função para atualizar no bd via Facade
                        UsuarioFacade.adicionarUsuario(usuario);

                        //redireciona
                        request.setAttribute("info", " Funcionário cadastrado");
                        request.setAttribute("page", "/funcionarios.jsp");
                        rd = getServletContext().getRequestDispatcher("/CadastroServlet?action=mostrarFuncionariosGer");
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
