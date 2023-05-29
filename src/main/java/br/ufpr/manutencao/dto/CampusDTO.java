/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.dto;

/**
 *
 * @author nicol
 */
public class CampusDTO {
    private Integer id;
    private String nome;
    private boolean status;

    public CampusDTO() {
    }

    public CampusDTO(Integer id, String nome, boolean status) {
        this.id = id;
        this.nome = nome;
        this.status = status;
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

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "CampusDTO{" + "id=" + id + ", nome=" + nome + ", status=" + status + '}';
    }
    
}
