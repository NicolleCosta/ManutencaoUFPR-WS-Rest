/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.resources;

import br.ufpr.manutencao.beans.OrdemServico;
import br.ufpr.manutencao.dto.OrdemServicoDTO;
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
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;

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
    @Path("buscarPorNumeroOS")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public OrdemServicoDTO buscarPorNumeroOS(@QueryParam("numeroOS") String numeroOS) {
        TypedQuery<OrdemServico> query = em.createNamedQuery(
                "OrdemServico.findByNumeroOS", OrdemServico.class);
        query.setParameter("numeroOS", numeroOS);
        List<OrdemServico> results = query.getResultList();

        if (results.isEmpty()) {
            return null;
        } else {
            ObjectMapper mapper = new ObjectMapper();
            return mapper.convertValue(results.get(0), OrdemServicoDTO.class);
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
    // ------------------------- Dados da Home Gerente ------------------------------------------------
    @GET
    @Path("contaMais30DiasAbertos")
    @Produces(MediaType.TEXT_PLAIN)
    public String contaMais30DiasAbertos() {
        LocalDate diasAtras = LocalDate.now().minusDays(30);
        Date dia = Date.from(diasAtras.atStartOfDay(ZoneId.systemDefault()).toInstant());
        TypedQuery<Long> query = em.createNamedQuery("OrdemServico.contaMais30DiasAbertos", Long.class);
        query.setParameter("dia", dia);
        Long count = query.getSingleResult();

        return String.valueOf(count);
    }
    
    @GET
    @Path("contaMais10DiasSemOP")
    @Produces(MediaType.TEXT_PLAIN)
    public String contaMais10DiasSemOP() {
        LocalDate diasAtras = LocalDate.now().minusDays(10);
        Date dia = Date.from(diasAtras.atStartOfDay(ZoneId.systemDefault()).toInstant());
        TypedQuery<Long> query = em.createNamedQuery("OrdemServico.contaMais10DiasSemOP", Long.class);
        query.setParameter("dia", dia);
        Long count = query.getSingleResult();

        return String.valueOf(count);
    }
    
    
    @GET
    @Path("contaAbertos")
    @Produces(MediaType.TEXT_PLAIN)
    public String contaAbertos() {
        TypedQuery<Long> query = em.createNamedQuery("OrdemServico.contaAbertos", Long.class);
        Long count = query.getSingleResult();

        return String.valueOf(count);
    }
    
    
    @GET
    @Path("contaAndamento")
    @Produces(MediaType.TEXT_PLAIN)
    public String contaAndamento() {
        TypedQuery<Long> query = em.createNamedQuery("OrdemServico.contaAndamento", Long.class);
        Long count = query.getSingleResult();

        return String.valueOf(count);
    }
    
    @GET
    @Path("contaEncerradoUltimos30Dias")
    @Produces(MediaType.TEXT_PLAIN)
    public String contaEncerradoUltimos30Dias() {
        LocalDate diasAtras = LocalDate.now().minusDays(30);
        Date dia = Date.from(diasAtras.atStartOfDay(ZoneId.systemDefault()).toInstant());
        TypedQuery<Long> query = em.createNamedQuery("OrdemServico.contaEncerradoUltimos30Dias", Long.class);
        query.setParameter("dia", dia);
        Long count = query.getSingleResult();

        return String.valueOf(count);
    }
    
    @GET
    @Path("contaEncerradoAno")
    @Produces(MediaType.TEXT_PLAIN)
    public String contaEncerradoAno() {
        LocalDate inicioAno = LocalDate.now().withMonth(1).withDayOfMonth(1);
        Date data = Date.from(inicioAno.atStartOfDay(ZoneId.systemDefault()).toInstant());
        TypedQuery<Long> query = em.createNamedQuery("OrdemServico.contaEncerradoAno", Long.class);
        query.setParameter("data", data);
        Long count = query.getSingleResult();

        return String.valueOf(count);
    }
    
//----------------------------------------------------------------------------------------------------------
 

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

}
