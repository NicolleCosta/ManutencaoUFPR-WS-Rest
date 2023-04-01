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
public class ComentarioOperarioDTO implements Serializable  {
    private Integer id;
    private String descricao;
    private Date dataHora;
    private String anexo;
    private OrdemServicoDTO ordemServicoId;
    private UsuarioDTO usuarioId;

    public ComentarioOperarioDTO() {
    }

    public ComentarioOperarioDTO(Integer id, String descricao, Date dataHora, String anexo, OrdemServicoDTO ordemServicoId, UsuarioDTO usuarioId) {
        this.id = id;
        this.descricao = descricao;
        this.dataHora = dataHora;
        this.anexo = anexo;
        this.ordemServicoId = ordemServicoId;
        this.usuarioId = usuarioId;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public Date getDataHora() {
        return dataHora;
    }

    public void setDataHora(Date dataHora) {
        this.dataHora = dataHora;
    }

    public String getAnexo() {
        return anexo;
    }

    public void setAnexo(String anexo) {
        this.anexo = anexo;
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
    

