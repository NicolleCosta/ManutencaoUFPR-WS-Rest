/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.dto;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author nicol
 */
public class EspecialidadeDTO  implements Serializable{

    private Integer id;
    private String descricaoLocal;
    private String descricaoProblema;
    private String anexo;
    private Date dataHora;
    private OrdemServicoDTO ordemServicoId;
    private PredioDTO predioId;
    private StatusDTO statusId;
    private UsuarioDTO usuarioId;

    public EspecialidadeDTO() {
    }

    public EspecialidadeDTO(Integer id, String descricaoLocal, String descricaoProblema, String anexo, Date dataHora, OrdemServicoDTO ordemServicoId, PredioDTO predioId, StatusDTO statusId, UsuarioDTO usuarioId) {
        this.id = id;
        this.descricaoLocal = descricaoLocal;
        this.descricaoProblema = descricaoProblema;
        this.anexo = anexo;
        this.dataHora = dataHora;
        this.ordemServicoId = ordemServicoId;
        this.predioId = predioId;
        this.statusId = statusId;
        this.usuarioId = usuarioId;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDescricaoLocal() {
        return descricaoLocal;
    }

    public void setDescricaoLocal(String descricaoLocal) {
        this.descricaoLocal = descricaoLocal;
    }

    public String getDescricaoProblema() {
        return descricaoProblema;
    }

    public void setDescricaoProblema(String descricaoProblema) {
        this.descricaoProblema = descricaoProblema;
    }

    public String getAnexo() {
        return anexo;
    }

    public void setAnexo(String anexo) {
        this.anexo = anexo;
    }

    public Date getDataHora() {
        return dataHora;
    }

    public void setDataHora(Date dataHora) {
        this.dataHora = dataHora;
    }

    public OrdemServicoDTO getOrdemServicoId() {
        return ordemServicoId;
    }

    public void setOrdemServicoId(OrdemServicoDTO ordemServicoId) {
        this.ordemServicoId = ordemServicoId;
    }

    public PredioDTO getPredioId() {
        return predioId;
    }

    public void setPredioId(PredioDTO predioId) {
        this.predioId = predioId;
    }

    public StatusDTO getStatusId() {
        return statusId;
    }

    public void setStatusId(StatusDTO statusId) {
        this.statusId = statusId;
    }

    public UsuarioDTO getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(UsuarioDTO usuarioId) {
        this.usuarioId = usuarioId;
    }
    
    
}
