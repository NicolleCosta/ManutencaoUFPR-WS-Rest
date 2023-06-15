/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.beans;

import jakarta.json.bind.annotation.JsonbDateFormat;
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
@Table(name = "tb_retirada_material")
@NamedQueries({
    @NamedQuery(name = "RetiradaMaterial.findAll", query = "SELECT r FROM RetiradaMaterial r"),
    @NamedQuery(name = "RetiradaMaterial.findById", query = "SELECT r FROM RetiradaMaterial r WHERE r.id = :id"),
    @NamedQuery(name = "RetiradaMaterial.findByQuantidade", query = "SELECT r FROM RetiradaMaterial r WHERE r.quantidade = :quantidade"),
    @NamedQuery(name = "RetiradaMaterial.findByUnidade", query = "SELECT r FROM RetiradaMaterial r WHERE r.unidade = :unidade"),
    @NamedQuery(name = "RetiradaMaterial.findByDataHora", query = "SELECT r FROM RetiradaMaterial r WHERE r.dataHora = :dataHora"),
    @NamedQuery(name = "RetiradaMaterial.listaRetiradaPorIdOS", query = "SELECT r FROM RetiradaMaterial r WHERE r.ordemServicoId = :idOS ORDER BY r.dataHora ASC ")
})
public class RetiradaMaterial implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Column(name = "quantidade")
    private Integer quantidade;
    @Column(name = "unidade")
    private String unidade;
    @Column(name = "data_hora")
    @Temporal(TemporalType.TIMESTAMP)
    @JsonbDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    private Date dataHora;
    @JoinColumn(name = "material_id", referencedColumnName = "id")
    @ManyToOne
    private Material materialId;
    @JoinColumn(name = "ordem_servico_id", referencedColumnName = "id")
    @ManyToOne
    private OrdemServico ordemServicoId;
    @JoinColumn(name = "usuario_id", referencedColumnName = "id")
    @ManyToOne
    private Usuario usuarioId;

    public RetiradaMaterial() {
    }

    public RetiradaMaterial(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(Integer quantidade) {
        this.quantidade = quantidade;
    }

    public String getUnidade() {
        return unidade;
    }

    public void setUnidade(String unidade) {
        this.unidade = unidade;
    }

    public Date getDataHora() {
        return dataHora;
    }

    public void setDataHora(Date dataHora) {
        this.dataHora = dataHora;
    }

    public Material getMaterialId() {
        return materialId;
    }

    public void setMaterialId(Material materialId) {
        this.materialId = materialId;
    }

    public OrdemServico getOrdemServicoId() {
        return ordemServicoId;
    }

    public void setOrdemServicoId(OrdemServico ordemServicoId) {
        this.ordemServicoId = ordemServicoId;
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
        if (!(object instanceof RetiradaMaterial)) {
            return false;
        }
        RetiradaMaterial other = (RetiradaMaterial) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "br.ufpr.manutencao.beans.RetiradaMaterial[ id=" + id + " ]";
    }
    
}
