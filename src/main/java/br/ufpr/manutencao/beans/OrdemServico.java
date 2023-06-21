/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.beans;

import jakarta.json.bind.annotation.JsonbDateFormat;
import java.io.Serializable;
import java.util.Collection;
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
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;

/**
 *
 * @author nicol
 */
@Entity
@Cacheable(false)
@Table(name = "tb_ordem_servico")
@NamedQueries({
    @NamedQuery(name = "OrdemServico.findAll", query = "SELECT o FROM OrdemServico o"),
    @NamedQuery(name = "OrdemServico.findById", query = "SELECT o FROM OrdemServico o WHERE o.id = :id"),
    @NamedQuery(name = "OrdemServico.findByNumeroOS", query = "SELECT o FROM OrdemServico o WHERE o.numeroOS = :numeroOS"),
    @NamedQuery(name = "OrdemServico.findByDescricao", query = "SELECT o FROM OrdemServico o WHERE o.descricaoProblema = :descricao"),
    @NamedQuery(name = "OrdemServico.findByDataAbertura", query = "SELECT o FROM OrdemServico o WHERE o.dataAbertura = :dataAbertura"),
    @NamedQuery(name = "OrdemServico.findByDataFinalizacao", query = "SELECT o FROM OrdemServico o WHERE o.dataFinalizacao = :dataFinalizacao"),
// ------------------------- Dados da Home Gerente ------------------------------------------------
    @NamedQuery(name = "OrdemServico.contaMais30DiasAbertos", query = "SELECT COUNT(o) FROM OrdemServico o WHERE o.dataAbertura < :dia AND o.dataFinalizacao = null"),  
    @NamedQuery(name = "OrdemServico.contaMais10DiasSemOP", query = "SELECT COUNT(o) FROM OrdemServico o WHERE o.dataAbertura < :dia AND o.dataFinalizacao = null AND o.usuarioOperarioId.id = null"),
    @NamedQuery(name = "OrdemServico.contaAbertos", query = "SELECT COUNT(o) FROM OrdemServico o WHERE o.dataFinalizacao = null AND o.usuarioOperarioId.id = null"),
    @NamedQuery(name = "OrdemServico.contaAndamento", query = "SELECT COUNT(o) FROM OrdemServico o WHERE o.dataFinalizacao = null AND o.usuarioOperarioId.id != null"),
    @NamedQuery(name = "OrdemServico.contaEncerradoUltimos30Dias", query = "SELECT COUNT(o) FROM OrdemServico o WHERE o.dataFinalizacao >= :dia"),

    @NamedQuery(name = "OrdemServico.contaEncerradoAno", query = "SELECT COUNT(o) FROM OrdemServico o WHERE o.dataFinalizacao >= :data"),
    
     @NamedQuery(name = "OrdemServico.top3PrediosOS", query = "SELECT p, COUNT(o) as total FROM OrdemServico o JOIN o.predioId p GROUP BY p ORDER BY total DESC"),
     @NamedQuery(name = "OrdemServico.top3Especialidades", query = "SELECT e, COUNT(o) as total FROM OrdemServico o JOIN o.especialidadeId e GROUP BY e ORDER BY total DESC")
        
})
public class OrdemServico implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Column(name = "descricao_local")
    private String descricaoLocal;

    @Column(name = "data_abertura")
    @Temporal(TemporalType.TIMESTAMP)
    @JsonbDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    private Date dataAbertura;

    @Column(name = "data_finalizacao")
    @Temporal(TemporalType.TIMESTAMP)
    @JsonbDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    private Date dataFinalizacao;
    @Column(name = "descricao_problema")
    private String descricaoProblema;
    @Basic(optional = false)
    @Column(name = "numero_os")
    private String numeroOS;

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
    
    @JoinColumn(name = "predio_id", referencedColumnName = "id")
    @ManyToOne
    private Predio predioId;

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

    public String getDescricaoLocal() {
        return descricaoLocal;
    }

    public void setDescricaoLocal(String descricaoLocal) {
        this.descricaoLocal = descricaoLocal;
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

    public String getDescricaoProblema() {
        return descricaoProblema;
    }

    public void setDescricaoProblema(String descricaoProblema) {
        this.descricaoProblema = descricaoProblema;
    }

    public String getNumeroOS() {
        return numeroOS;
    }

    public void setNumeroOS(String numeroOS) {
        this.numeroOS = numeroOS;
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

    public Predio getPredioId() {
        return predioId;
    }

    public void setPredioId(Predio predioId) {
        this.predioId = predioId;
    }
    

    @PrePersist
    public void prePersist() {
        this.dataAbertura = new Date();
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
