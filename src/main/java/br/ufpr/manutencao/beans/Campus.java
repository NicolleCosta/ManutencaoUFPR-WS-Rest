/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.beans;

import java.io.Serializable;
import java.util.Collection;
import jakarta.persistence.Basic;
import jakarta.persistence.Cacheable;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

/**
 *
 * @author nicol
 */
@Entity
@Cacheable(false)
@Table(name = "tb_campus")
@NamedQueries({
    @NamedQuery(name = "Campus.findAll", query = "SELECT c FROM Campus c WHERE c.status = 'true' ORDER BY LOWER(c.nome) ASC"),
    @NamedQuery(name = "Campus.findById", query = "SELECT c FROM Campus c WHERE c.id = :id AND c.status = 'true'"),
    @NamedQuery(name = "Campus.findByNome", query = "SELECT c FROM Campus c WHERE c.nome = :nome AND c.status = 'true'")})
public class Campus implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;   
    @Column(name = "nome")
    private String nome;
    @Column(name = "status")
    private boolean status;
    
// Retirado para nao gerar problema de looping já que está em outra classe       
//    @OneToMany(mappedBy = "campusId")
//    private Collection<Predio> predioCollection;

    public Campus() {
    }

    public Campus(Integer id) {
        this.id = id;
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
    
    

//    public Collection<Predio> getPredioCollection() {
//        return predioCollection;
//    }
//
//    public void setPredioCollection(Collection<Predio> predioCollection) {
//        this.predioCollection = predioCollection;
//    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Campus)) {
            return false;
        }
        Campus other = (Campus) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "br.ufpr.manutencao.beans.Campus[ id=" + id + " ]";
    }
    
}
