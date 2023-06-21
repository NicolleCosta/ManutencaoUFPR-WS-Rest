/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.beans;

import jakarta.json.bind.annotation.JsonbDateFormat;
import java.io.Serializable;
import java.util.Date;
import jakarta.persistence.Basic;
import jakarta.persistence.Cacheable;
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
@Cacheable(false)
@Table(name = "tb_comentario_operario")
@NamedQueries({
    @NamedQuery(name = "ComentarioOperario.findAll", query = "SELECT c FROM ComentarioOperario c"),
    @NamedQuery(name = "ComentarioOperario.findById", query = "SELECT c FROM ComentarioOperario c WHERE c.id = :id"),
    @NamedQuery(name = "ComentarioOperario.findByDescricao", query = "SELECT c FROM ComentarioOperario c WHERE c.descricao = :descricao"),
    @NamedQuery(name = "ComentarioOperario.findByDataHora", query = "SELECT c FROM ComentarioOperario c WHERE c.dataHora = :dataHora"),
    @NamedQuery(name = "ComentarioOperario.listarPorId", query = "SELECT c FROM ComentarioOperario c WHERE c.ordemServicoId.id = :id"),
    @NamedQuery(name = "ComentarioOperario.findByAnexo", query = "SELECT c FROM ComentarioOperario c WHERE c.anexo = :anexo")})
public class ComentarioOperario implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Column(name = "descricao")
    private String descricao;
    @Column(name = "data_hora")
    @Temporal(TemporalType.TIMESTAMP)
    @JsonbDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    private Date dataHora;
    @Column(name = "anexo")
    private String anexo;
    @JoinColumn(name = "ordem_servico_id", referencedColumnName = "id")
    @ManyToOne
    private OrdemServico ordemServicoId;
    @JoinColumn(name = "usuario_id", referencedColumnName = "id")
    @ManyToOne
    private Usuario usuarioId;

    public ComentarioOperario() {
    }

    public ComentarioOperario(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public Date getDataHora() {
        return dataHora;
    }

    public void setDataHora(Date dataHora) {
        this.dataHora = dataHora;
    }

    public String getAnexo() {
        return anexo;
    }

    public void setAnexo(String anexo) {
        this.anexo = anexo;
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
        if (!(object instanceof ComentarioOperario)) {
            return false;
        }
        ComentarioOperario other = (ComentarioOperario) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "br.ufpr.manutencao.beans.ComentarioOperario[ id=" + id + " ]";
    }
    
}
