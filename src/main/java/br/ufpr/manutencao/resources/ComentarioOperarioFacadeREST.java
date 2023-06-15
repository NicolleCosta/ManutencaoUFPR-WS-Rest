/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.resources;

import br.ufpr.manutencao.beans.ComentarioOperario;
import br.ufpr.manutencao.beans.OrdemServico;
import br.ufpr.manutencao.dto.ComentarioOperarioDTO;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.List;
import jakarta.persistence.EntityManager;
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
import java.util.ArrayList;

/**
 *
 * @author nicol
 */
@jakarta.ejb.Stateless
@Path("/comentariooperario")
public class ComentarioOperarioFacadeREST extends AbstractFacade<ComentarioOperario> {

    @PersistenceContext(unitName = "my_persistence_unit")
    private EntityManager em;

    public ComentarioOperarioFacadeREST() {
        super(ComentarioOperario.class);
    }

    @POST
    @Override
    @Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public void create(ComentarioOperario entity) {
        super.create(entity);
    }

    @PUT
    @Path("{id}")
    @Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public void edit(@PathParam("id") Integer id, ComentarioOperario entity) {
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
    public ComentarioOperario find(@PathParam("id") Integer id) {
        return super.find(id);
    }

    @GET
    @Override
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<ComentarioOperario> findAll() {
        return super.findAll();
    }

    @GET
    @Path("{from}/{to}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<ComentarioOperario> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) {
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

    // em uso tbm no web -> funcionando caso precise ver a facade
    @GET
    @Path("/listarComentarioPorIdOS/{id}")
    @Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<ComentarioOperarioDTO> listarComentariosPorId(@PathParam("id") Integer id) {
        //OrdemServico ordemServico = new OrdemServico();
        //ordemServico.setId(ordemservicoId);
        //ComentarioOperario comentarioOperario = new ComentarioOperario();
        //comentarioOperario.setOrdemServicoId(ordemServico);
        TypedQuery<ComentarioOperario> query = em.createNamedQuery("ComentarioOperario.listarPorId", ComentarioOperario.class);
        query.setParameter("id", id);
        List<ComentarioOperario> comentarioOperario = new ArrayList<>();
        comentarioOperario = query.getResultList();
        List<ComentarioOperarioDTO> comentarioOperarioDTO = new ArrayList<>();

        for (ComentarioOperario c : comentarioOperario) {
            ComentarioOperarioDTO dto = new ComentarioOperarioDTO();
            ObjectMapper mapper = new ObjectMapper();
            dto = mapper.convertValue(c, ComentarioOperarioDTO.class);
            comentarioOperarioDTO.add(dto);
        }
        return comentarioOperarioDTO;
    }

}
