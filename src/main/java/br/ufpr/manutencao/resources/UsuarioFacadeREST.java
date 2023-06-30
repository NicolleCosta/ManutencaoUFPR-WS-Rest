/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.resources;

import br.ufpr.manutencao.beans.TipoUsuario;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import br.ufpr.manutencao.dto.LoginDTO;
import br.ufpr.manutencao.beans.Usuario;
import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Persistence;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.DELETE;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.PUT;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.WebApplicationException;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.io.IOException;
import br.ufpr.manutencao.dto.UsuarioDTO;
import java.util.ArrayList;
import org.apache.commons.codec.digest.DigestUtils;

/**
 *
 * @author nicol
 */
@jakarta.ejb.Stateless
@Path("/usuario")
public class UsuarioFacadeREST extends AbstractFacade<Usuario> {

    @PersistenceContext(unitName = "my_persistence_unit")
    private EntityManager em;

    public UsuarioFacadeREST() {
        super(Usuario.class);
    }

    @POST
    @Override
    @Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public void create(Usuario entity) {
        String senha = entity.getSenha();
        String salt = entity.getSalt();
        String saltSenha = salt + senha;
        String senhaCriptografada = DigestUtils.sha256Hex(saltSenha);
        entity.setSenha(senhaCriptografada);
        super.create(entity);
    }

    @POST
    @Path("/login")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response login(LoginDTO login) {
        try {
            TypedQuery<Usuario> query = em.createNamedQuery("Usuario.findByCpf", Usuario.class);
            query.setParameter("cpf", login.getCpf());
            Usuario usuario = query.getSingleResult();

            String salt = usuario.getSalt();

            String senha = login.getSenha();
            String saltSenha = salt + senha;
            String senhaCriptografada = DigestUtils.sha256Hex(saltSenha);

            if (senhaCriptografada.equals(usuario.getSenha())) {
                ObjectMapper mapper = new ObjectMapper();
                UsuarioDTO usuarioDTO = mapper.convertValue(usuario, UsuarioDTO.class);
                return Response.ok(usuarioDTO).build();
            } else {
                return Response.status(Response.Status.UNAUTHORIZED)
                        .entity("Login inválido")
                        .build();
            }
        } catch (NoResultException e) {
            return Response.status(Response.Status.UNAUTHORIZED)
                    .entity("Login inválido")
                    .build();
        }
    }

    @PUT
    @Path("{id}")
    @Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public void edit(@PathParam("id") Integer id, Usuario entity) {
        String senha = entity.getSenha();
        String salt = entity.getSalt();
        String saltSenha = salt + senha;
        String senhaCriptografada = DigestUtils.sha256Hex(saltSenha);
        entity.setSenha(senhaCriptografada);
        System.out.println("entrou no alterar usuario com  senha");
        super.edit(entity);
    }

    @PUT
    @Path("/alterar/{id}")
    @Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public void editSemSenha(@PathParam("id") Integer id, Usuario entity) {
        System.out.println("entrou no alterar usuario sem senha");
        super.edit(entity);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id) {
        super.remove(super.find(id));
    }

    @GET
    @Path("{id}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public Usuario find(@PathParam("id") Integer id) {
        return super.find(id);
    }

    @GET
    @Override
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<Usuario> findAll() {
        return super.findAll();
    }

    @GET
    @Path("/listaUsuarios")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<UsuarioDTO> listaUsuarios() {
        TipoUsuario tipoUsuario = em.find(TipoUsuario.class, 1);
        TypedQuery<Usuario> query = em.createNamedQuery("Usuario.listaUsuarios", Usuario.class);
        query.setParameter("id", tipoUsuario);
        List<Usuario> usuarios = query.getResultList();
        List<UsuarioDTO> usuariosDTO = new ArrayList<>();
        for (Usuario u : usuarios) {
            UsuarioDTO dto = new UsuarioDTO();
            ObjectMapper mapper = new ObjectMapper();
            dto = mapper.convertValue(u, UsuarioDTO.class);
            usuariosDTO.add(dto);
        }
        return usuariosDTO;
    }

    @GET
    @Path("/listaOperarios")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<UsuarioDTO> listaOperarios() {
        TipoUsuario tipoUsuario = em.find(TipoUsuario.class, 2);
        TypedQuery<Usuario> query = em.createNamedQuery("Usuario.listaUsuarios", Usuario.class);
        query.setParameter("id", tipoUsuario);
        List<Usuario> usuarios = query.getResultList();
        List<UsuarioDTO> usuariosDTO = new ArrayList<>();
        for (Usuario u : usuarios) {
            UsuarioDTO dto = new UsuarioDTO();
            ObjectMapper mapper = new ObjectMapper();
            dto = mapper.convertValue(u, UsuarioDTO.class);
            usuariosDTO.add(dto);
        }
        return usuariosDTO;
    }

    @GET
    @Path("/listaFuncionarios")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<UsuarioDTO> listaFuncionarios() {
        TipoUsuario usuario = em.find(TipoUsuario.class, 1);
        TipoUsuario operario = em.find(TipoUsuario.class, 2);
        TypedQuery<Usuario> query = em.createNamedQuery("Usuario.listaFuncionarios", Usuario.class);
        query.setParameter("idUsu", usuario);
        query.setParameter("idOpe", operario);
        List<Usuario> usuarios = query.getResultList();
        List<UsuarioDTO> usuariosDTO = new ArrayList<>();
        for (Usuario u : usuarios) {
            UsuarioDTO dto = new UsuarioDTO();
            ObjectMapper mapper = new ObjectMapper();
            dto = mapper.convertValue(u, UsuarioDTO.class);
            usuariosDTO.add(dto);
        }
        return usuariosDTO;
    }
    
    @GET
    @Path("/recuperarSenha/{cpf}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public UsuarioDTO recuperarSenha (@PathParam("cpf") String cpf){
        TypedQuery<Usuario> query = em.createNamedQuery("Usuario.findByCpf", Usuario.class);
        query.setParameter("cpf", cpf);
        Usuario usuario = query.getSingleResult();   
        ObjectMapper mapper = new ObjectMapper();
        UsuarioDTO dto = mapper.convertValue(usuario, UsuarioDTO.class);
        return dto;
    }

    @GET
    @Path("{from}/{to}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<Usuario> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) {
        return super.findRange(new int[]{from, to});
    }

    @GET
    @Path("count")
    @Produces(MediaType.TEXT_PLAIN)
    public String countREST() {
        return String.valueOf(super.count());
    }

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

}
