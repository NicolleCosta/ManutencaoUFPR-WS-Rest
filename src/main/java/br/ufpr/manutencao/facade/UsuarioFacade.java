/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.facade;

import br.ufpr.manutencao.dto.UsuarioDTO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.List;
import org.apache.http.entity.StringEntity;

;

/**
 *
 * @author nicol
 */
public class UsuarioFacade {

    public static UsuarioDTO buscaPorID(int id) throws FacadeException {
        HttpClient httpClient = HttpClient.newHttpClient();

        // URL do endpoint do backend
        String backendURL = "http://localhost:8080/manutencaoufpr/webresources/usuario/" + id;

        // Requisição POST com o corpo da requisição
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(backendURL))
                .header("Content-Type", "application/json")
                .build();

        try {
            // Chamada ao backend
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            // Verificação do código de status da resposta
            int statusCode = response.statusCode();

            // Se o código de status for 200 (OK), processa a resposta do backend
            if (statusCode == 200) {
                String responseBody = response.body();

                /// Converte o JSON de resposta para um objeto
                ObjectMapper mapper = new ObjectMapper();
                UsuarioDTO usuarioDTO = mapper.readValue(responseBody, UsuarioDTO.class);
                System.out.println("entrou no if de sucesso");
                System.out.println(usuarioDTO.getNome());
                return usuarioDTO;
            } else {
                System.out.println("entrou no else de falha");
                System.out.println("Erro na busca: " + response.body());
                // Se o código de status for diferente de 200
                throw new FacadeException("Erro na busca do usuario: " + response.body());
            }
        } catch (IOException | InterruptedException e) {
            // Exceção que ocorre durante a chamada ao backend
            throw new FacadeException("Erro na chamada ao backend: " + e.getMessage(), e);
        }

    }

    public static void alterarUsuario(UsuarioDTO usuario) throws FacadeException {
        HttpClient httpClient = HttpClient.newHttpClient();

        // URL do endpoint do backend
        String backendURL = "http://localhost:8080/manutencaoufpr/webresources/usuario/" + usuario.getId();

        // Converte o objeto para JSON
        ObjectMapper mapper = new ObjectMapper();
        String requestBody;
        try {
            requestBody = mapper.writeValueAsString(usuario);
        } catch (IOException e) {
            throw new FacadeException("Erro ao converter o objeto para JSON: " + e.getMessage(), e);
        }

        // Requisição PUT com o corpo da requisição
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(backendURL))
                .header("Content-Type", "application/json")
                .PUT(HttpRequest.BodyPublishers.ofString(requestBody))
                .build();

        try {
            // Chamada ao backend
            HttpResponse<Void> response = httpClient.send(request, HttpResponse.BodyHandlers.discarding());

            // Verificação do código de status
            int statusCode = response.statusCode();
            if (statusCode == 200 || statusCode == 204) {
                System.out.println("Usuário alterado com sucesso.");
            } else {
                System.out.println("Erro na alteração: " + response.body());
                throw new FacadeException("Erro na alteração do usuário: " + response.body());
            }
        } catch (IOException | InterruptedException e) {
            // Exceção que ocorre durante a chamada ao backend
            throw new FacadeException("Erro na chamada ao backend: " + e.getMessage(), e);
        }
    }
    
        public static void alterarUsuarioSemSenha(UsuarioDTO usuario) throws FacadeException {
        HttpClient httpClient = HttpClient.newHttpClient();

        // URL do endpoint do backend
        String backendURL = "http://localhost:8080/manutencaoufpr/webresources/usuario/alterar/" + usuario.getId();

        // Converte o objeto para JSON
        ObjectMapper mapper = new ObjectMapper();
        String requestBody;
        try {
            requestBody = mapper.writeValueAsString(usuario);
        } catch (IOException e) {
            throw new FacadeException("Erro ao converter o objeto para JSON: " + e.getMessage(), e);
        }

        // Requisição PUT com o corpo da requisição
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(backendURL))
                .header("Content-Type", "application/json")
                .PUT(HttpRequest.BodyPublishers.ofString(requestBody))
                .build();

        try {
            // Chamada ao backend
            HttpResponse<Void> response = httpClient.send(request, HttpResponse.BodyHandlers.discarding());

            // Verificação do código de status
            int statusCode = response.statusCode();
            if (statusCode == 200 || statusCode == 204) {
                System.out.println("Usuário alterado com sucesso.");
            } else {
                System.out.println("Erro na alteração: " + response.body());
                throw new FacadeException("Erro na alteração do usuário: " + response.body());
            }
        } catch (IOException | InterruptedException e) {
            // Exceção que ocorre durante a chamada ao backend
            throw new FacadeException("Erro na chamada ao backend: " + e.getMessage(), e);
        }
    }

    public static List<UsuarioDTO> buscarUsuarios() throws FacadeException {
        try {
             // URL do endpoint do backend
            String backendURL = "http://localhost:8080/manutencaoufpr/webresources/usuario/listaUsuarios";

            HttpClient httpClient = HttpClient.newHttpClient();

            // Requisição GET 
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(backendURL))
                    .header("Content-Type", "application/json")
                    .build();

            // Chamada ao backend
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            // Verificação do código de status da resposta
            int statusCode = response.statusCode();

            //  Se o código de status for 200 (OK), processa a resposta do backend
            if (statusCode == 200) {
                String responseBody = response.body();

                // Converte o JSON de resposta para um objeto
                ObjectMapper mapper = new ObjectMapper();
                List<UsuarioDTO> usuarios = mapper.readValue(responseBody, new TypeReference<List<UsuarioDTO>>() {});
                
                System.out.println("entrou na facade aberto "+ usuarios);
                return usuarios;
            } else {
                System.out.println("entrou no else");
                // Se o código de status for diferente de 200
                throw new FacadeException("Erro ao listar chamados: " + response.body());
            }
        } catch (IOException | InterruptedException e) {
            System.out.println("entrou no erro" + e);
            
           // Exceção que ocorre durante a chamada ao backend
            throw new FacadeException("Erro na chamada ao backend: " + e.getMessage(), e);
        }
    }

    public static List<UsuarioDTO> buscarOperarios() throws FacadeException {
        try {
             // URL do endpoint do backend
            String backendURL = "http://localhost:8080/manutencaoufpr/webresources/usuario/listaOperarios";

            HttpClient httpClient = HttpClient.newHttpClient();

            // Requisição GET 
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(backendURL))
                    .header("Content-Type", "application/json")
                    .build();

            // Chamada ao backend
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            // Verificação do código de status da resposta
            int statusCode = response.statusCode();

            //  Se o código de status for 200 (OK), processa a resposta do backend
            if (statusCode == 200) {
                String responseBody = response.body();

                // Converte o JSON de resposta para um objeto
                ObjectMapper mapper = new ObjectMapper();
                List<UsuarioDTO> operarios = mapper.readValue(responseBody, new TypeReference<List<UsuarioDTO>>() {});
                
                System.out.println("entrou na facade aberto "+ operarios);
                return operarios;
            } else {
                System.out.println("entrou no else");
                // Se o código de status for diferente de 200
                throw new FacadeException("Erro ao listar chamados: " + response.body());
            }
        } catch (IOException | InterruptedException e) {
            System.out.println("entrou no erro" + e);
            
           // Exceção que ocorre durante a chamada ao backend
            throw new FacadeException("Erro na chamada ao backend: " + e.getMessage(), e);
        }
    }

    public static void adicionarUsuario(UsuarioDTO usuario) throws FacadeException, JsonProcessingException{

        HttpClient httpClient = HttpClient.newHttpClient();
        ObjectMapper mapper = new ObjectMapper();

        // Corpo da requisição
        String requestBody = mapper.writeValueAsString(usuario);

        // URL do endpoint do backend
        String backendURL = "http://localhost:8080/manutencaoufpr/webresources/usuario";

        // Requisição POST com o corpo da requisição
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(backendURL))
                .header("Content-Type", "application/json; charset=UTF-8") // Adicione o charset ao cabeçalho Content-Type
                .POST(HttpRequest.BodyPublishers.ofString(requestBody, StandardCharsets.UTF_8))
                .build();
        try {
            // Envio da requisição e obtenção da resposta
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            // Verificação do código de status
            int statusCode = response.statusCode();
            if (statusCode == 200 || statusCode == 204) {
                System.out.println("Usuario adicionado com sucesso!");
            } else {
                System.out.println("Falha ao adicionar o usuario. Código de status: " + statusCode);
                System.out.println("Corpo da resposta: " + response.body());
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new FacadeException("Erro na requisição: " + e.getMessage());
        }
    }

    public static List<UsuarioDTO> buscarfuncionarios() throws FacadeException {
        try {
             // URL do endpoint do backend
            String backendURL = "http://localhost:8080/manutencaoufpr/webresources/usuario/listaFuncionarios";

            HttpClient httpClient = HttpClient.newHttpClient();

            // Requisição GET 
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(backendURL))
                    .header("Content-Type", "application/json")
                    .build();

            // Chamada ao backend
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            // Verificação do código de status da resposta
            int statusCode = response.statusCode();

            //  Se o código de status for 200 (OK), processa a resposta do backend
            if (statusCode == 200) {
                String responseBody = response.body();

                // Converte o JSON de resposta para um objeto
                ObjectMapper mapper = new ObjectMapper();
                List<UsuarioDTO> funcionarios = mapper.readValue(responseBody, new TypeReference<List<UsuarioDTO>>() {});
                
                System.out.println("entrou na facade aberto "+ funcionarios);
                return funcionarios;
            } else {
                System.out.println("entrou no else");
                // Se o código de status for diferente de 200
                throw new FacadeException("Erro ao listar chamados: " + response.body());
            }
        } catch (IOException | InterruptedException e) {
            System.out.println("entrou no erro" + e);
            
           // Exceção que ocorre durante a chamada ao backend
            throw new FacadeException("Erro na chamada ao backend: " + e.getMessage(), e);
        }
    }

    public static UsuarioDTO usuarioCPF(String cpf) throws FacadeException {
        HttpClient httpClient = HttpClient.newHttpClient();

        // URL do endpoint do backend
        String backendURL = "http://localhost:8080/manutencaoufpr/webresources/recuperarSenha/" + cpf;

        // Requisição POST com o corpo da requisição
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(backendURL))
                .header("Content-Type", "application/json")
                .build();

        try {
            // Chamada ao backend
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            // Verificação do código de status da resposta
            int statusCode = response.statusCode();

            // Se o código de status for 200 (OK), processa a resposta do backend
            if (statusCode == 200) {
                String responseBody = response.body();

                /// Converte o JSON de resposta para um objeto
                ObjectMapper mapper = new ObjectMapper();
                UsuarioDTO usuarioDTO = mapper.readValue(responseBody, UsuarioDTO.class);
                System.out.println("entrou no if de sucesso");
                System.out.println(usuarioDTO.getNome());
                return usuarioDTO;
            } else {
                System.out.println("entrou no else de falha");
                System.out.println("Erro na busca: " + response.body());
                // Se o código de status for diferente de 200
                throw new FacadeException("Erro na busca do usuario: " + response.body());
            }
        } catch (IOException | InterruptedException e) {
            // Exceção que ocorre durante a chamada ao backend
            throw new FacadeException("Erro na chamada ao backend: " + e.getMessage(), e);
        }
    }
}
