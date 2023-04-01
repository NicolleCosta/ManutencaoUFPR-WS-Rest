/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.dto;

import java.io.Serializable;

/**
 *
 * @author nicol
 */
class UsuarioDTO implements Serializable{
    
    private Integer id;
    private String nome;
    private String cpf;
    private String telefone;
    private String email;
    private String senha;
    private Boolean bloqueio;
    private EspecialidadeDTO especialidadeId;
    private TipoUsuarioDTO tipoUsuarioId;

    public UsuarioDTO() {
    }

    public UsuarioDTO(Integer id, String nome, String cpf, String telefone, String email, String senha, Boolean bloqueio, EspecialidadeDTO especialidadeId, TipoUsuarioDTO tipoUsuarioId) {
        this.id = id;
        this.nome = nome;
        this.cpf = cpf;
        this.telefone = telefone;
        this.email = email;
        this.senha = senha;
        this.bloqueio = bloqueio;
        this.especialidadeId = especialidadeId;
        this.tipoUsuarioId = tipoUsuarioId;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public Boolean getBloqueio() {
        return bloqueio;
    }

    public void setBloqueio(Boolean bloqueio) {
        this.bloqueio = bloqueio;
    }

    public EspecialidadeDTO getEspecialidadeId() {
        return especialidadeId;
    }

    public void setEspecialidadeId(EspecialidadeDTO especialidadeId) {
        this.especialidadeId = especialidadeId;
    }

    public TipoUsuarioDTO getTipoUsuarioId() {
        return tipoUsuarioId;
    }

    public void setTipoUsuarioId(TipoUsuarioDTO tipoUsuarioId) {
        this.tipoUsuarioId = tipoUsuarioId;
    }
    
}
