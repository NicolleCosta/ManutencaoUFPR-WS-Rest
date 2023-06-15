/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.resources;

import br.ufpr.manutencao.beans.Material;
import br.ufpr.manutencao.beans.OrdemServico;
import br.ufpr.manutencao.beans.RetiradaMaterial;
import br.ufpr.manutencao.beans.Usuario;
import br.ufpr.manutencao.dto.RetiradaMaterialDTO;
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
@Path("/retiradamaterial")
public class RetiradaMaterialFacadeREST extends AbstractFacade<RetiradaMaterial> {

    @PersistenceContext(unitName = "my_persistence_unit")
    private EntityManager em;

    public RetiradaMaterialFacadeREST() {
        super(RetiradaMaterial.class);
    }

    @POST
    @Override
    @Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public void create(RetiradaMaterial entity) {
        super.create(entity);
    }

    @POST
    @Path("/create")
    @Consumes(MediaType.APPLICATION_JSON)
    public void createBatch(List<RetiradaMaterialDTO> entities) {
        for (RetiradaMaterialDTO dto : entities) {
            RetiradaMaterial entity = new RetiradaMaterial();
            entity.setQuantidade(dto.getQuantidade());
            entity.setUnidade(dto.getUnidade());

            Material material = new Material();
            material.setId(dto.getMaterialId().getId());
            entity.setMaterialId(material);

            OrdemServico ordemServico = new OrdemServico();
            ordemServico.setId(dto.getOrdemServicoId().getId());
            entity.setOrdemServicoId(ordemServico);

            Usuario usuario = new Usuario();
            usuario.setId(dto.getUsuarioId().getId());
            entity.setUsuarioId(usuario);

            super.create(entity);
        }
    }

    @PUT
    @Path("{id}")
    @Consumes({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public void edit(@PathParam("id") Integer id, RetiradaMaterial entity) {
        super.edit(entity);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id) {
        super.remove(super.find(id));
    }
    
    @GET
    @Path("/listaRetiradaPorIdOS/{id}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<RetiradaMaterialDTO> findAll(@PathParam("id") Integer id) {
        System.out.println("entrou aqui");
        OrdemServico ordem = new OrdemServico();
        ordem.setId(id);
        TypedQuery<RetiradaMaterial> query = em.createNamedQuery("RetiradaMaterial.listaRetiradaPorIdOS", RetiradaMaterial.class);
        query.setParameter("idOS", ordem);
        List<RetiradaMaterial> retiradas = query.getResultList();
        List<RetiradaMaterialDTO> retiradaDTO = new ArrayList<>();
        System.out.println(retiradas);
        for (RetiradaMaterial r : retiradas) {
            RetiradaMaterialDTO dto = new RetiradaMaterialDTO();
            ObjectMapper mapper = new ObjectMapper();
            dto = mapper.convertValue(r, RetiradaMaterialDTO.class);
            retiradaDTO.add(dto);
        }
        return retiradaDTO;
    }
    

    @GET
    @Path("{id}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public RetiradaMaterial find(@PathParam("id") Integer id) {
        return super.find(id);
    }

    @GET
    @Override
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<RetiradaMaterial> findAll() {
        return super.findAll();
    }

    @GET
    @Path("{from}/{to}")
    @Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
    public List<RetiradaMaterial> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) {
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
