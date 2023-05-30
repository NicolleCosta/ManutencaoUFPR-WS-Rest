/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.resources;


import br.ufpr.manutencao.beans.Campus;
import br.ufpr.manutencao.beans.Especialidade;
import br.ufpr.manutencao.beans.Predio;
import br.ufpr.manutencao.dto.PredioDTO;
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
@Path("/predio")
public class PredioFacadeREST extends AbstractFacade<Predio> {

    @PersistenceContext(unitName = "my_persistence_unit")
    private EntityManager em;

    public PredioFacadeREST() {
        super(Predio.class);
    }

    @POST
    @Override
    @Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public void create(Predio entity) {
        super.create(entity);
    }

    @PUT
    @Path("{id}")
    @Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public void edit(@PathParam("id") Integer id, Predio entity) {
        super.edit(entity);
    }
    
    @PUT
    @Path("bloquear/{id}")
    public void bloquearPredio(@PathParam("id") Integer id) {
        Predio predio = super.find(id);
        predio.setStatus(false);
        super.edit(predio);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id) {
        super.remove(super.find(id));
    }

    @GET
    @Path("{id}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public Predio find(@PathParam("id") Integer id) {
        return super.find(id);
    }

    @GET
    @Path("lista/{id}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<PredioDTO> findAll(@PathParam ("id") Integer id) {
        System.out.println(id);
        Campus campus = new Campus();
        campus.setId(id);
        TypedQuery<Predio> query = em.createNamedQuery("Predio.listar", Predio.class);
        query.setParameter("id", campus);
        List<Predio> predio = query.getResultList();
        List<PredioDTO> predioDTO = new ArrayList<>();
        
        for(Predio p: predio) {
            PredioDTO dto = new PredioDTO();
            dto.setId(p.getId());
            dto.setNome(p.getNome());
            predioDTO.add(dto);
        }
        
        return predioDTO;
    }
    
    @GET
    @Path("/lista")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<Predio> listarTodos() {
        TypedQuery<Predio> query = getEntityManager().createNamedQuery("Predio.findAll", Predio.class);
        return query.getResultList();
    }

    

    @GET
    @Path("{from}/{to}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<Predio> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) {
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
