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
public class EspecialidadeDTO{

    private Integer id;
    private String nome;
    

    public EspecialidadeDTO() {
    }

    public EspecialidadeDTO(Integer id) {
        this.id = id;
    }

    public EspecialidadeDTO(Integer id, String nome) {
        this.id = id;
        this.nome = nome;
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

    @Override
    public String toString() {
        return "EspecialidadeDTO{" +
                "id=" + id +
                ", nome='" + nome + '\'' +
                '}';
    }
}
