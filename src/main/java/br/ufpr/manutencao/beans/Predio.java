/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.beans;

import java.io.Serializable;
import java.util.Collection;
import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

/**
 *
 * @author nicol
 */
@Entity
@Table(name = "tb_predio")
@NamedQueries({
    @NamedQuery(name = "Predio.findAll", query = "SELECT p FROM Predio p"),
    @NamedQuery(name = "Predio.findById", query = "SELECT p FROM Predio p WHERE p.id = :id"),
    @NamedQuery(name = "Predio.findByNome", query = "SELECT p FROM Predio p WHERE p.nome = :nome")})
public class Predio implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Column(name = "nome")
    private String nome;
    @JoinColumn(name = "campus_id", referencedColumnName = "id")
    @ManyToOne
    private Campus campusId;
    // Retirado para nao gerar problema de looping já que está em outra classe   
//    @OneToMany(mappedBy = "predioId")
//    private Collection<Chamado> chamadoCollection;

    public Predio() {
    }

    public Predio(Integer id) {
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

    public Campus getCampusId() {
        return campusId;
    }

    public void setCampusId(Campus campusId) {
        this.campusId = campusId;
    }

//    public Collection<Chamado> getChamadoCollection() {
//        return chamadoCollection;
//    }
//
//    public void setChamadoCollection(Collection<Chamado> chamadoCollection) {
//        this.chamadoCollection = chamadoCollection;
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
        if (!(object instanceof Predio)) {
            return false;
        }
        Predio other = (Predio) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "br.ufpr.manutencao.beans.Predio[ id=" + id + " ]";
    }
    
}
