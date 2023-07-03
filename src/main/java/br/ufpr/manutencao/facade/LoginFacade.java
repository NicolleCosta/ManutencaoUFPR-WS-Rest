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
        
        // Corpo da requisição
        ObjectMapper mapper = new ObjectMapper();
        ObjectNode requestBody = mapper.createObjectNode();
        requestBody.put("cpf", cpf);
        requestBody.put("senha", senha);
        String requestBodyString = requestBody.toString();
             
        // URL do endpoint do backend
        String backendURL = "http://localhost:8080/manutencaoufpr/webresources/usuario/login";
        
        // Requisição POST com o corpo da requisição
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(backendURL))
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(requestBodyString))
                .build();
        
        try {
            // Chamada ao backend
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            
            // Verificação do código de status da resposta
            int statusCode = response.statusCode();
            
            if (statusCode == 200) {
                String responseBody = response.body();
                
                // Converte o JSON de resposta para um objeto 
                UsuarioDTO usuarioDTO = mapper.readValue(responseBody, UsuarioDTO.class);
                return usuarioDTO;
            } else {
                throw new FacadeException("Erro no login: " + response.body());
            }
        } catch (IOException | InterruptedException e) {
            throw new FacadeException("Erro na chamada ao backend: " + e.getMessage(), e);
        }
        
    }
    
}
