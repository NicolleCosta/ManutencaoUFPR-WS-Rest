/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.dto;

import jakarta.json.bind.annotation.JsonbDateFormat;
import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author nicol
 */
public class RetiradaMaterialDTO{
    private Integer id;
    private Integer quantidade;
    private String unidade;
    @JsonbDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    private Date dataHora;
    private MaterialDTO materialId;
    private OrdemServicoDTO ordemServicoId;
    private UsuarioDTO usuarioId;

    public RetiradaMaterialDTO() {
    }

    public RetiradaMaterialDTO(Integer id, Integer quantidade, String unidade, Date dataHora, MaterialDTO materialId, OrdemServicoDTO ordemServicoId, UsuarioDTO usuarioId) {
        this.id = id;
        this.quantidade = quantidade;
        this.unidade = unidade;
        this.dataHora = dataHora;
        this.materialId = materialId;
        this.ordemServicoId = ordemServicoId;
        this.usuarioId = usuarioId;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(Integer quantidade) {
        this.quantidade = quantidade;
    }

    public String getUnidade() {
        return unidade;
    }

    public void setUnidade(String unidade) {
        this.unidade = unidade;
    }

    public Date getDataHora() {
        return dataHora;
    }

    public void setDataHora(Date dataHora) {
        this.dataHora = dataHora;
    }

    public MaterialDTO getMaterialId() {
        return materialId;
    }

    public void setMaterialId(MaterialDTO materialId) {
        this.materialId = materialId;
    }

    public OrdemServicoDTO getOrdemServicoId() {
        return ordemServicoId;
    }

    public void setOrdemServicoId(OrdemServicoDTO ordemServicoId) {
        this.ordemServicoId = ordemServicoId;
    }

    public UsuarioDTO getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(UsuarioDTO usuarioId) {
        this.usuarioId = usuarioId;
    }
    
    
}
