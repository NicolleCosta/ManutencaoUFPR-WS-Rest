/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.beans;

import java.io.Serializable;
import java.util.Collection;
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
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;

/**
 *
 * @author nicol
 */
@Entity
@Table(name = "tb_ordem_servico")
@NamedQueries({
    @NamedQuery(name = "OrdemServico.findAll", query = "SELECT o FROM OrdemServico o"),
    @NamedQuery(name = "OrdemServico.findById", query = "SELECT o FROM OrdemServico o WHERE o.id = :id"),
    @NamedQuery(name = "OrdemServico.findByDescricao", query = "SELECT o FROM OrdemServico o WHERE o.descricao = :descricao"),
    @NamedQuery(name = "OrdemServico.findByDataAbertura", query = "SELECT o FROM OrdemServico o WHERE o.dataAbertura = :dataAbertura"),
    @NamedQuery(name = "OrdemServico.findByDataFinalizacao", query = "SELECT o FROM OrdemServico o WHERE o.dataFinalizacao = :dataFinalizacao"),
    @NamedQuery(name = "OrdemServico.findByNomeResponsavelDepartamento", query = "SELECT o FROM OrdemServico o WHERE o.nomeResponsavelDepartamento = :nomeResponsavelDepartamento")})
public class OrdemServico implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Column(name = "descricao")
    private String descricao;
    @Column(name = "data_abertura")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dataAbertura;
    @Column(name = "data_finalizacao")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dataFinalizacao;
    @Column(name = "nome_responsavel_departamento")
    private String nomeResponsavelDepartamento;
    
    // Retirado para nao gerar problema de looping já que está em outra classe   
//    @OneToMany(mappedBy = "ordemServicoId")
//    private Collection<RetiradaMaterial> retiradaMaterialCollection;
//    @OneToMany(mappedBy = "ordemServicoId")
//    private Collection<ComentarioOperario> comentarioOperarioCollection;
//    @OneToMany(mappedBy = "ordemServicoId")
//    private Collection<Chamado> chamadoCollection;
    
    @JoinColumn(name = "especialidade_id", referencedColumnName = "id")
    @ManyToOne
    private Especialidade especialidadeId;
    
    @JoinColumn(name = "usuario_operario_id", referencedColumnName = "id")
    @ManyToOne
    private Usuario usuarioOperarioId;


    public OrdemServico() {
    }

    public OrdemServico(Integer id) {
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

    public Date getDataAbertura() {
        return dataAbertura;
    }

    public void setDataAbertura(Date dataAbertura) {
        this.dataAbertura = dataAbertura;
    }

    public Date getDataFinalizacao() {
        return dataFinalizacao;
    }

    public void setDataFinalizacao(Date dataFinalizacao) {
        this.dataFinalizacao = dataFinalizacao;
    }

    public String getNomeResponsavelDepartamento() {
        return nomeResponsavelDepartamento;
    }

    public void setNomeResponsavelDepartamento(String nomeResponsavelDepartamento) {
        this.nomeResponsavelDepartamento = nomeResponsavelDepartamento;
    }
//
//    public Collection<RetiradaMaterial> getRetiradaMaterialCollection() {
//        return retiradaMaterialCollection;
//    }
//
//    public void setRetiradaMaterialCollection(Collection<RetiradaMaterial> retiradaMaterialCollection) {
//        this.retiradaMaterialCollection = retiradaMaterialCollection;
//    }
//
//    public Collection<ComentarioOperario> getComentarioOperarioCollection() {
//        return comentarioOperarioCollection;
//    }
//
//    public void setComentarioOperarioCollection(Collection<ComentarioOperario> comentarioOperarioCollection) {
//        this.comentarioOperarioCollection = comentarioOperarioCollection;
//    }
//
//    public Collection<Chamado> getChamadoCollection() {
//        return chamadoCollection;
//    }
//
//    public void setChamadoCollection(Collection<Chamado> chamadoCollection) {
//        this.chamadoCollection = chamadoCollection;
//    }

    public Especialidade getEspecialidadeId() {
        return especialidadeId;
    }

    public void setEspecialidadeId(Especialidade especialidadeId) {
        this.especialidadeId = especialidadeId;
    }

    public Usuario getUsuarioOperarioId() {
        return usuarioOperarioId;
    }

    public void setUsuarioOperarioId(Usuario usuarioOperarioId) {
        this.usuarioOperarioId = usuarioOperarioId;
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
        if (!(object instanceof OrdemServico)) {
            return false;
        }
        OrdemServico other = (OrdemServico) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "br.ufpr.manutencao.beans.OrdemServico[ id=" + id + " ]";
    }
    
}
