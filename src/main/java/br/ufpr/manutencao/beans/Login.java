/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.beans;

import java.io.Serializable;

public class Login implements Serializable {
	private String login;
	private String senha;
	
	public Login() {
		super();
	}
	
	public Login(String login, String senha) {
		super();
		this.login = login;
		this.senha = senha;
	}
		
	public String getLogin() {
		return login;
	}
	public void setLogin(String login) {
		this.login = login;
	}
	public String getSenha() {
		return senha;
	}
	public void setSenha(String senha) {
		this.senha = senha;
	}




}