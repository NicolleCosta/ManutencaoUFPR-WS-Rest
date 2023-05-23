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
public class OrdemServicoDTO {
    private Integer id;
    private String descricao;
    private Date dataAbertura;
    private Date dataFinalizacao;
    private String nomeResponsavelDepartamento;
    private EspecialidadeDTO especialidadeId;
    private UsuarioDTO usuarioOperarioId;

    public OrdemServicoDTO() {
    }

    public OrdemServicoDTO(Integer id, String descricao, Date dataAbertura, Date dataFinalizacao, String nomeResponsavelDepartamento, EspecialidadeDTO especialidadeId, UsuarioDTO usuarioOperarioId) {
        this.id = id;
        this.descricao = descricao;
        this.dataAbertura = dataAbertura;
        this.dataFinalizacao = dataFinalizacao;
        this.nomeResponsavelDepartamento = nomeResponsavelDepartamento;
        this.especialidadeId = especialidadeId;
        this.usuarioOperarioId = usuarioOperarioId;
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

    public String getNomeResponsavelDepartamento() {
        return nomeResponsavelDepartamento;
    }

    public void setNomeResponsavelDepartamento(String nomeResponsavelDepartamento) {
        this.nomeResponsavelDepartamento = nomeResponsavelDepartamento;
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
    
    
    
}
