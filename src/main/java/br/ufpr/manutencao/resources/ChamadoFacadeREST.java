/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.resources;


import br.ufpr.manutencao.beans.Chamado;
import br.ufpr.manutencao.beans.Especialidade;
import br.ufpr.manutencao.beans.Status;
import br.ufpr.manutencao.beans.Usuario;
import br.ufpr.manutencao.dto.ChamadoDTO;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
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
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.ArrayList;

/**
 *
 * @author nicol
 */
@jakarta.ejb.Stateless
@Path("/chamado")
public class ChamadoFacadeREST extends AbstractFacade<Chamado> {

    @PersistenceContext(unitName = "my_persistence_unit")
    private EntityManager em;

    public ChamadoFacadeREST() {
        super(Chamado.class);
    }

    @POST
    @Override
    @Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public void create(Chamado entity) {
        super.create(entity);
    }

    @PUT
    @Path("{id}")
    @Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public void edit(@PathParam("id") Integer id, Chamado entity) {
        super.edit(entity);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id) {
        super.remove(super.find(id));
    }

    @GET
    @Override
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<Chamado> findAll() {
        return super.findAll();
    }
    
    @GET
    @Path("/listaChamadosAbertos")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<ChamadoDTO> listaChamadoAberto() {
        Status status = em.find(Status.class, 1);
        TypedQuery<Chamado> query = em.createNamedQuery("Chamado.listaChamadoAberto", Chamado.class);
        query.setParameter("id", status);
        List<Chamado> chamados = query.getResultList();
        List<ChamadoDTO> chamadosDTO = new ArrayList<>();

        for (Chamado c : chamados) {
            ChamadoDTO dto = new ChamadoDTO();
            ObjectMapper mapper = new ObjectMapper();
            dto = mapper.convertValue(c, ChamadoDTO.class);
            chamadosDTO.add(dto);
        }

        return chamadosDTO;
    }

    @GET
    @Path("/listaChamadosEmAndamento")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<ChamadoDTO> listaChamadoEmAndamento() {
        Status status = em.find(Status.class, 2);
        TypedQuery<Chamado> query = em.createNamedQuery("Chamado.listaChamadoEmAndamento", Chamado.class);
        query.setParameter("id", status);
        List<Chamado> chamados = query.getResultList();
        List<ChamadoDTO> chamadosDTO = new ArrayList<>();

        for (Chamado c : chamados) {
            ChamadoDTO dto = new ChamadoDTO();
            ObjectMapper mapper = new ObjectMapper();
            dto = mapper.convertValue(c, ChamadoDTO.class);
            chamadosDTO.add(dto);
        }

        return chamadosDTO;
    }



    @GET
    @Path("/listaChamados/{id}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<ChamadoDTO> findAll(@PathParam ("id") Integer id) {
        System.out.println("entrou aqui");
        Usuario chamado = new Usuario();
        chamado.setId(id);
        TypedQuery<Chamado> query = em.createNamedQuery("Chamado.listar", Chamado.class);
        query.setParameter("id", chamado);
        List<Chamado> chamados = query.getResultList();
        List<ChamadoDTO> chamadoDTO = new ArrayList<>();
        System.out.println(chamados);
        for(Chamado c: chamados) {
            ChamadoDTO dto = new ChamadoDTO();
            ObjectMapper mapper = new ObjectMapper();
            dto = mapper.convertValue(c, ChamadoDTO.class);
            chamadoDTO.add(dto);
        }
        
        return chamadoDTO;
    }

    @GET
    @Path("{id}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<Chamado> listaChamadosPorId(@PathParam("id") Integer id) {
        ArrayList<Chamado> listaChamados = new ArrayList<Chamado>();
        try{           
            return listaChamados;
        } catch (NoResultException e){
                    return (List<Chamado>) Response.status(Response.Status.UNAUTHORIZED)
                       .entity("Sem chamados")
                       .build();
        }  
    }
    
    @GET
    @Path("/listaChamadosEmAberto/{id}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<ChamadoDTO> listaCahamadosEmAberto(@PathParam ("id") Integer id) {
        Especialidade especialidade = new Especialidade();
        especialidade.setId(id);
        TypedQuery<Chamado> query = em.createNamedQuery("Chamado.listaChamadoEmAberto", Chamado.class);
        query.setParameter("id", id);
        List<Chamado> chamados = query.getResultList();
        List<ChamadoDTO> chamadoDTO = new ArrayList<>();
        for(Chamado c: chamados) {
            ChamadoDTO dto = new ChamadoDTO();
            ObjectMapper mapper = new ObjectMapper();
            dto = mapper.convertValue(c, ChamadoDTO.class);
            chamadoDTO.add(dto);
        }
        
        return chamadoDTO;
    }

    @GET
    @Path("/chamadoId/{id}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public ChamadoDTO findById (@PathParam("id") Integer id) {
        Chamado chamado = super.find(id);
        ObjectMapper mapper = new ObjectMapper();
        ChamadoDTO chamadoDTO = mapper.convertValue(chamado, ChamadoDTO.class);
        System.out.println(chamado);
        System.out.println(chamadoDTO);
        return chamadoDTO;
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
