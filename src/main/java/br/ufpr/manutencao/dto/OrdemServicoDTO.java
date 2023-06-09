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
public class OrdemServicoDTO {
    private Integer id;
    private String descricaoLocal;
    private String descricaoProblema;
    @JsonbDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    private Date dataAbertura;
    @JsonbDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    private Date dataFinalizacao;
    private String numeroOS;
    private EspecialidadeDTO especialidadeId;
    private UsuarioDTO usuarioOperarioId;
    private PredioDTO predioId;

    public OrdemServicoDTO() {
    }

    public OrdemServicoDTO(Integer id, String descricaoLocal, String descricaoProblema, Date dataAbertura, Date dataFinalizacao, String numeroOS, EspecialidadeDTO especialidadeId, UsuarioDTO usuarioOperarioId, PredioDTO predioId) {
        this.id = id;
        this.descricaoLocal = descricaoLocal;
        this.descricaoProblema = descricaoProblema;
        this.dataAbertura = dataAbertura;
        this.dataFinalizacao = dataFinalizacao;
        this.numeroOS = numeroOS;
        this.especialidadeId = especialidadeId;
        this.usuarioOperarioId = usuarioOperarioId;
        this.predioId = predioId;
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

    public Date getDataAbertura() {
        return dataAbertura;
    }

    public void setDataAbertura(Date dataAbertura) {
        this.dataAbertura = dataAbertura;
    }

    public Date getDataFinalizacao() {
        return dataFinalizacao;
    }

    public void setDataFinalizacao(Date dataFinalizacao) {
        this.dataFinalizacao = dataFinalizacao;
    }

    public String getNumeroOS() {
        return numeroOS;
    }

    public void setNumeroOS(String numeroOS) {
        this.numeroOS = numeroOS;
    }

    public EspecialidadeDTO getEspecialidadeId() {
        return especialidadeId;
    }

    public void setEspecialidadeId(EspecialidadeDTO especialidadeId) {
        this.especialidadeId = especialidadeId;
    }

    public UsuarioDTO getUsuarioOperarioId() {
        return usuarioOperarioId;
    }

    public void setUsuarioOperarioId(UsuarioDTO usuarioOperarioId) {
        this.usuarioOperarioId = usuarioOperarioId;
    }

    public PredioDTO getPredioId() {
        return predioId;
    }

    public void setPredioId(PredioDTO predioId) {
        this.predioId = predioId;
    }

    @Override
    public String toString() {
        return "OrdemServicoDTO{" + "id=" + id + ", descricaoLocal=" + descricaoLocal + ", descricaoProblema=" + descricaoProblema + ", dataAbertura=" + dataAbertura + ", dataFinalizacao=" + dataFinalizacao + ", numeroOS=" + numeroOS + ", especialidadeId=" + especialidadeId + ", usuarioOperarioId=" + usuarioOperarioId + ", predioId=" + predioId + '}';
    }
    
}
