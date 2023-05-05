/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.facade;

/**
 *
 * @author nicol
 */
public class FacadeException extends Exception {

    public FacadeException(){
        super("Causa do Erro Desconhecida");
    }
    
    public FacadeException(String msg, Exception e) {
        super(msg+" / "+e.getMessage());
    }

    public FacadeException(String msg, ClassNotFoundException e) {
        super(msg+" / "+e.getMessage());
    }

    public FacadeException(String msg) {
        super(msg);
    }
    
}   

