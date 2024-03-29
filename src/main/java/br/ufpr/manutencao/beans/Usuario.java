/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.beans;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import java.io.Serializable;
import java.util.Collection;
import jakarta.persistence.Basic;
import jakarta.persistence.Cacheable;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Persistence;
import jakarta.persistence.Table;
import jakarta.persistence.TypedQuery;

/**
 *
 * @author nicol
 */
@Entity
@Cacheable(false)
@Table(name = "tb_usuario")
@NamedQueries({
    @NamedQuery(name = "Usuario.findAll", query = "SELECT u FROM Usuario u"),
    @NamedQuery(name = "Usuario.listaUsuarios", query = "SELECT u FROM Usuario u WHERE u.tipoUsuarioId = :id"),
    @NamedQuery(name = "Usuario.listaFuncionarios", query = "SELECT u FROM Usuario u WHERE u.tipoUsuarioId <> :idUsu AND u.tipoUsuarioId <> :idOpe"),
    @NamedQuery(name = "Usuario.findById", query = "SELECT u FROM Usuario u WHERE u.id = :id"),
    @NamedQuery(name = "Usuario.findByNome", query = "SELECT u FROM Usuario u WHERE u.nome = :nome"),
    @NamedQuery(name = "Usuario.findByCpf", query = "SELECT u FROM Usuario u WHERE u.cpf = :cpf"),
    @NamedQuery(name = "Usuario.findByTelefone", query = "SELECT u FROM Usuario u WHERE u.telefone = :telefone"),
    @NamedQuery(name = "Usuario.findByEmail", query = "SELECT u FROM Usuario u WHERE u.email = :email"),
    @NamedQuery(name = "Usuario.findBySenha", query = "SELECT u FROM Usuario u WHERE u.senha = :senha"),
    @NamedQuery(name = "Usuario.findByBloqueio", query = "SELECT u FROM Usuario u WHERE u.bloqueio = :bloqueio"),
    @NamedQuery(name = "Usuario.findByCpf", query = "SELECT u FROM Usuario u WHERE u.cpf = :cpf")})

public class Usuario implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Column(name = "nome")
    private String nome;
    @Column(name = "cpf")
    private String cpf;
    @Column(name = "telefone")
    private String telefone;
    @Column(name = "email")
    private String email;
    @Column(name = "senha")
    private String senha;
    @Column(name = "bloqueio")
    private Boolean bloqueio;
//Retirado para nao gerar problema de looping já que está em outra classe       
//    @OneToMany(mappedBy = "usuarioId")
//    private Collection<RetiradaMaterial> retiradaMaterialCollection;
    @JoinColumn(name = "especialidade_id", referencedColumnName = "id")
    @ManyToOne
    // @JsonBackReference
    private Especialidade especialidadeId;

    @JoinColumn(name = "tipo_usuario_id", referencedColumnName = "id")
    @ManyToOne
    // @JsonBackReference
    private TipoUsuario tipoUsuarioId;

    @Column(name = "salt")
    private String salt;

// Retirado para nao gerar problema de looping já que está em outra classe   
//    @OneToMany(mappedBy = "usuarioId")
//    private Collection<ComentarioOperario> comentarioOperarioCollection;
//    @OneToMany(mappedBy = "usuarioId")
//    private Collection<Chamado> chamadoCollection;
    public Usuario() {
    }

    public Usuario(Integer id) {
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

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public Boolean getBloqueio() {
        return bloqueio;
    }

    public void setBloqueio(Boolean bloqueio) {
        this.bloqueio = bloqueio;
    }

//    public Collection<RetiradaMaterial> getRetiradaMaterialCollection() {
//        return retiradaMaterialCollection;
//    }
//
//    public void setRetiradaMaterialCollection(Collection<RetiradaMaterial> retiradaMaterialCollection) {
//        this.retiradaMaterialCollection = retiradaMaterialCollection;
//    }
    public Especialidade getEspecialidadeId() {
        return especialidadeId;
    }

    public void setEspecialidadeId(Especialidade especialidadeId) {
        this.especialidadeId = especialidadeId;
    }

    public TipoUsuario getTipoUsuarioId() {
        return tipoUsuarioId;
    }

    public void setTipoUsuarioId(TipoUsuario tipoUsuarioId) {
        this.tipoUsuarioId = tipoUsuarioId;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }
    

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
    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Usuario)) {
            return false;
        }
        Usuario other = (Usuario) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "br.ufpr.manutencao.beans.Usuario[ id=" + id + " ]";
    }

}
