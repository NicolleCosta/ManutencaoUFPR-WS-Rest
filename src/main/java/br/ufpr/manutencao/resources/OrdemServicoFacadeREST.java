/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.resources;

import br.ufpr.manutencao.beans.OrdemServico;
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
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.MediaType;

/**
 *
 * @author nicol
 */
@jakarta.ejb.Stateless
@Path("/ordemservico")
public class OrdemServicoFacadeREST extends AbstractFacade<OrdemServico> {

    @PersistenceContext(unitName = "my_persistence_unit")
    private EntityManager em;

    public OrdemServicoFacadeREST() {
        super(OrdemServico.class);
    }

    @POST
    @Override
    @Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public void create(OrdemServico entity) {
        super.create(entity);
    }

    @PUT
    @Path("{id}")
    @Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public void edit(@PathParam("id") Integer id, OrdemServico entity) {
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
    public OrdemServico find(@PathParam("id") Integer id) {
        return super.find(id);
    }
@GET
@Path("buscarIdPorOS")
@Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
public Integer buscarIdPorNumeroOS(@QueryParam("numeroOS") String numeroOS) {
    TypedQuery<OrdemServico> query = em.createNamedQuery(
            "OrdemServico.findByNumeroOS", OrdemServico.class);
    query.setParameter("numeroOS", numeroOS);
    List<OrdemServico> results = query.getResultList();
    if (results.isEmpty()) {
        return null;
    } else {
        return results.get(0).getId();
    }
}

    @GET
    @Override
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<OrdemServico> findAll() {
        return super.findAll();
    }

    @GET
    @Path("{from}/{to}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<OrdemServico> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) {
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
