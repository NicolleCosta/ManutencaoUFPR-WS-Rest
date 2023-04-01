/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.resources;
import jakarta.ws.rs.ApplicationPath;
import jakarta.ws.rs.core.Application;
import java.util.Set;

/**
 *
 * @author nicol
 */
@ApplicationPath("webresources")
public class ApplicationConfig extends Application {

    @Override
    public Set<Class<?>> getClasses() {
        Set<Class<?>> resources = new java.util.HashSet<>();
        addRestResourceClasses(resources);
        return resources;
    }
  
    /**
     * Do not modify addRestResourceClasses() method.
     * It is automatically populated with
     * all resources defined in the project.
     * If required, comment out calling this method in getClasses().
     */
    private void addRestResourceClasses(Set<Class<?>> resources) {
        resources.add(br.ufpr.manutencao.resources.CampusFacadeREST.class);
//        resources.add(br.ufpr.manutencao.resources.ChamadoFacadeREST.class);
//        resources.add(br.ufpr.manutencao.resources.ComentarioOperarioFacadeREST.class);
//        resources.add(br.ufpr.manutencao.resources.EspecialidadeFacadeREST.class);
//        resources.add(br.ufpr.manutencao.resources.MaterialFacadeREST.class);
//        resources.add(br.ufpr.manutencao.resources.OrdemServicoFacadeREST.class);
//        resources.add(br.ufpr.manutencao.resources.PredioFacadeREST.class);
//        resources.add(br.ufpr.manutencao.resources.RetiradaMaterialFacadeREST.class);
//        resources.add(br.ufpr.manutencao.resources.StatusFacadeREST.class);
//        resources.add(br.ufpr.manutencao.resources.TipoUsuarioFacadeREST.class);
//        resources.add(br.ufpr.manutencao.resources.UsuarioFacadeREST.class);
    }
    
}