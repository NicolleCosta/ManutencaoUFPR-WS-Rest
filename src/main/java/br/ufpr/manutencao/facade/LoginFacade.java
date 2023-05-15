/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.facade;

import br.ufpr.manutencao.dto.UsuarioDTO;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

/**
 *
 * @author nicol
 */
public class LoginFacade {

    public static UsuarioDTO login(String cpf, String senha)throws FacadeException, IOException {
 
        HttpClient httpClient = HttpClient.newHttpClient();
        
        // Crie o corpo da requisição com os dados de login
        ObjectMapper mapper = new ObjectMapper();
        ObjectNode requestBody = mapper.createObjectNode();
        requestBody.put("cpf", cpf);
        requestBody.put("senha", senha);
        String requestBodyString = requestBody.toString();
        
        System.out.println("chegou");
        
        // Defina a URL do endpoint do backend
        String backendURL = "http://localhost:8080/manutencaoufpr/webresources/usuario/login";
        
        // Crie a requisição POST com o corpo da requisição
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(backendURL))
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(requestBodyString))
                .build();
        
        try {
            // Faça a chamada ao backend
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            
            // Verifique o código de status da resposta
            int statusCode = response.statusCode();
            
            // Se o código de status for 200 (OK), processe a resposta do backend
            if (statusCode == 200) {
                String responseBody = response.body();
                
                // Converta o JSON de resposta para um objeto UsuarioDTO
                UsuarioDTO usuarioDTO = mapper.readValue(responseBody, UsuarioDTO.class);
                System.out.println("entrou no if de sucesso");
                System.out.println(usuarioDTO.getNome());
                return usuarioDTO;
            } else {
                System.out.println("entrou no else de falha");
                System.out.println("Erro no login: " + response.body());
                // Se o código de status for diferente de 200, lance uma exceção ou retorne um valor indicando o erro
                throw new FacadeException("Erro no login: " + response.body());
            }
        } catch (IOException | InterruptedException e) {
            // Trate qualquer exceção que ocorra durante a chamada ao backend
            throw new FacadeException("Erro na chamada ao backend: " + e.getMessage(), e);
        }
        
    }
    
}
