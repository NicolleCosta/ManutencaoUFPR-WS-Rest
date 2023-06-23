/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.dto;

import java.io.Serializable;

public class LoginDTO {

    private String cpf;
    private String senha;
    private String salt;

    public LoginDTO() {
        super();
    }

    public LoginDTO(String cpf, String senha, String salt) {
        this.cpf = cpf;
        this.senha = senha;
        this.salt = salt;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }
    

}
