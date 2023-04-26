/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.beans;

import java.io.Serializable;
import java.util.Date;
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
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;

/**
 *
 * @author nicol
 */
@Entity
@Table(name = "tb_chamado")
@NamedQueries({
    @NamedQuery(name = "Chamado.findAll", query = "SELECT c FROM Chamado c"),
    @NamedQuery(name = "Chamado.findById", query = "SELECT c FROM Chamado c WHERE c.id = :id"),
    @NamedQuery(name = "Chamado.findByDescricaoLocal", query = "SELECT c FROM Chamado c WHERE c.descricaoLocal = :descricaoLocal"),
    @NamedQuery(name = "Chamado.findByDescricaoProblema", query = "SELECT c FROM Chamado c WHERE c.descricaoProblema = :descricaoProblema"),
    @NamedQuery(name = "Chamado.findByAnexo", query = "SELECT c FROM Chamado c WHERE c.anexo = :anexo"),
    @NamedQuery(name = "Chamado.findByDataHora", query = "SELECT c FROM Chamado c WHERE c.dataHora = :dataHora")})
public class Chamado implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Column(name = "descricao_local")
    private String descricaoLocal;
    @Column(name = "descricao_problema")
    private String descricaoProblema;
    @Column(name = "anexo")
    private String anexo;
    @Column(name = "data_hora")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dataHora;
    @JoinColumn(name = "ordem_servico_id", referencedColumnName = "id")
    @ManyToOne
    private OrdemServico ordemServicoId;
    @JoinColumn(name = "predio_id", referencedColumnName = "id")
    @ManyToOne
    private Predio predioId;
    @JoinColumn(name = "status_id", referencedColumnName = "id")
    @ManyToOne
    private Status statusId;
    @JoinColumn(name = "usuario_id", referencedColumnName = "id")
    @ManyToOne
    private Usuario usuarioId;

    public Chamado() {
    }

    public Chamado(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDescricaoLocal() {
        return descricaoLocal;
    }

    public void setDescricaoLocal(String descricaoLocal) {
        this.descricaoLocal = descricaoLocal;
    }

    public String getDescricaoProblema() {
        return descricaoProblema;
    }

    public void setDescricaoProblema(String descricaoProblema) {
        this.descricaoProblema = descricaoProblema;
    }

    public String getAnexo() {
        return anexo;
    }

    public void setAnexo(String anexo) {
        this.anexo = anexo;
    }

    public Date getDataHora() {
        return dataHora;
    }

    public void setDataHora(Date dataHora) {
        this.dataHora = dataHora;
    }

    public OrdemServico getOrdemServicoId() {
        return ordemServicoId;
    }

    public void setOrdemServicoId(OrdemServico ordemServicoId) {
        this.ordemServicoId = ordemServicoId;
    }

    public Predio getPredioId() {
        return predioId;
    }

    public void setPredioId(Predio predioId) {
        this.predioId = predioId;
    }

    public Status getStatusId() {
        return statusId;
    }

    public void setStatusId(Status statusId) {
        this.statusId = statusId;
    }

    public Usuario getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(Usuario usuarioId) {
        this.usuarioId = usuarioId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Chamado)) {
            return false;
        }
        Chamado other = (Chamado) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "br.ufpr.manutencao.beans.Chamado[ id=" + id + " ]";
    }
    
}