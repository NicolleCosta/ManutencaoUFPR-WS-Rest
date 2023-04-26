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
public class PredioDTO implements Serializable{
   private Integer id;
   private String nome;
   private CampusDTO campusId; 

    public PredioDTO() {
    }

    public PredioDTO(Integer id, String nome, CampusDTO campusId) {
        this.id = id;
        this.nome = nome;
        this.campusId = campusId;
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

    public CampusDTO getCampusId() {
        return campusId;
    }

    public void setCampusId(CampusDTO campusId) {
        this.campusId = campusId;
    }
   
   
}
