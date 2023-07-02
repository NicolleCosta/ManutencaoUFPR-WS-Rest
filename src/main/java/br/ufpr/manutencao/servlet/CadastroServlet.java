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
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
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
import java.security.SecureRandom;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.commons.codec.binary.Hex;
import org.apache.commons.lang3.RandomStringUtils;

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
        HttpSession session = request.getSession();
        UsuarioDTO user = (UsuarioDTO) session.getAttribute("user");

        try {
            if (action == null || user == null) {
                //redireciona
                response.sendRedirect("LogoutServlet");
            } else {
                switch (action) {
                    case "mostrarMeuCadastro":
                        session = request.getSession();
                        user = (UsuarioDTO) session.getAttribute("user");
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
                        if (user.getTipoUsuarioId().getId().equals(4)) {
                            rd = getServletContext().getRequestDispatcher("/almoxarife/meuCadastro.jsp");
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

                        if (!senha.isEmpty()) {
                            //Gerar novo Salt
                            SecureRandom secureRandom = new SecureRandom();
                            byte[] salt = new byte[16];
                            secureRandom.nextBytes(salt);
                            String saltStr = Hex.encodeHexString(salt);

                            usuario.setSalt(saltStr);
                            usuario.setSenha(senha);
                            //função para atualizar no bd via Facade
                            UsuarioFacade.alterarUsuario(usuario);
                        } else {
                            UsuarioFacade.alterarUsuarioSemSenha(usuario);
                        }

                        //redireciona
                        request.setAttribute("info", " Usuário atualizado");
                        request.setAttribute("page", "/meuCadastro.jsp");
                        rd = getServletContext().getRequestDispatcher("/CadastroServlet?action=mostrarMeuCadastro");
                        rd.forward(request, response);
                        break;

                    case "mostrarUsuariosAdmin":
                        session = request.getSession();
                        user = (UsuarioDTO) session.getAttribute("user");

                        //Carrega a lista de chamados para apresentar
                        List<UsuarioDTO> usuarios = UsuarioFacade.buscarUsuarios();

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

                        //Carrega a lista de chamados para apresentar
                        List<UsuarioDTO> operarios = UsuarioFacade.buscarOperarios();
                        List<EspecialidadeDTO> especialidades = EspecialidadeFacade.buscarEspecialidades();

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

                        nome = request.getParameter("nome");
                        String cpf = request.getParameter("cpf");
                        cpf = cpf.replaceAll("\\D+", "");
                        telefone = request.getParameter("telefone");
                        telefone = telefone.replaceAll("\\D+", "");
                        email = request.getParameter("email");
                        int especialidade = Integer.parseInt(request.getParameter("especialidade"));

                        //Verifica se CPF já existe no sistema
                        UsuarioDTO cpfCadastrado = UsuarioFacade.usuarioCPF(cpf);

                        if (cpfCadastrado == null) {
                            //Gerar o Salt
                            SecureRandom secureRandom = new SecureRandom();
                            byte[] salt = new byte[16];
                            secureRandom.nextBytes(salt);
                            String saltStr = Hex.encodeHexString(salt);

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
                            usuario.setSalt(saltStr);

                            //função para atualizar no bd via Facade
                            UsuarioFacade.adicionarUsuario(usuario);

                            //redireciona
                            request.setAttribute("info", " Operário cadastrado");
                        } else {
                            request.setAttribute("msg", "CPF já possui cadastro no sistema!");
                        }
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
                        telefone = telefone.replaceAll("\\D+", "");
                        email = request.getParameter("email");
                        especialidade = Integer.parseInt(request.getParameter("especialidade"));

                        //altera os valores desse objeto
                        usuario.setNome(nome);
                        usuario.setEmail(email);
                        usuario.setTelefone(telefone);
                        usuario.setEspecialidadeId(new EspecialidadeDTO(especialidade));

                        //função para atualizar no bd via Facade
                        UsuarioFacade.alterarUsuarioSemSenha(usuario);

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
                        UsuarioFacade.alterarUsuarioSemSenha(usuario);

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
                        UsuarioFacade.alterarUsuarioSemSenha(usuario);

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
                        UsuarioFacade.alterarUsuarioSemSenha(usuario);

                        //redireciona
                        request.setAttribute("info", "Situação do usuário atualizada");
                        rd = getServletContext().getRequestDispatcher("/CadastroServlet?action=mostrarUsuariosAdmin");
                        rd.forward(request, response);
                        break;

                    case "mostrarFuncionariosGer":

                        //Carrega a lista de chamados para apresentar
                        List<UsuarioDTO> funcionarios = UsuarioFacade.buscarfuncionarios();

                        List<TipoUsuarioDTO> tiposUsuario = TipoUsuarioFacade.buscarTiposUsuarios();

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
                        telefone = telefone.replaceAll("\\D+", "");
                        email = request.getParameter("email");
                        int tipoUsuario = Integer.parseInt(request.getParameter("tipoUsuario"));

                        //altera os valores desse objeto
                        usuario.setNome(nome);
                        usuario.setEmail(email);
                        usuario.setTelefone(telefone);
                        usuario.setTipoUsuarioId(new TipoUsuarioDTO(tipoUsuario));

                        //função para atualizar no bd via Facade
                        UsuarioFacade.alterarUsuarioSemSenha(usuario);

                        //redireciona
                        request.setAttribute("info", " Funcionário atualizado!");
                        rd = getServletContext().getRequestDispatcher("/CadastroServlet?action=mostrarFuncionariosGer");
                        rd.forward(request, response);
                        break;

                    case "novoFuncionario":

                        nome = request.getParameter("nome");
                        cpf = request.getParameter("cpf");
                        cpf = cpf.replaceAll("\\D+", "");
                        telefone = request.getParameter("telefone");
                        telefone = telefone.replaceAll("\\D+", "");
                        email = request.getParameter("email");
                        tipoUsuario = Integer.parseInt(request.getParameter("tipoUsuario"));

                        //Verifica se CPF já existe no sistema
                        cpfCadastrado = UsuarioFacade.usuarioCPF(cpf);
                        if (cpfCadastrado == null) {
                            //Gerar o Salt
                            SecureRandom secureRandom = new SecureRandom();
                            byte[] salt = new byte[16];
                            secureRandom.nextBytes(salt);
                            String saltStr = Hex.encodeHexString(salt);

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
                            usuario.setSalt(saltStr);

                            //função para atualizar no bd via Facade
                            UsuarioFacade.adicionarUsuario(usuario);

                            //redireciona
                            request.setAttribute("info", " Funcionário cadastrado");
                        } else {
                            request.setAttribute("msg", "CPF já possui cadastro no sistema!");
                        }
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
