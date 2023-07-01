/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.facade;

import br.ufpr.manutencao.dto.MaterialDTO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.List;

/**
 *
 * @author nicol
 */
public class MaterialFacade {

    public static void adicionarMaterial(MaterialDTO material) throws FacadeException, JsonProcessingException {

        HttpClient httpClient = HttpClient.newHttpClient();
        ObjectMapper mapper = new ObjectMapper();

        // Corpo da requisição
        String requestBody = mapper.writeValueAsString(material);
        //URL do endpoint do backend
        String backendURL = "http://localhost:8080/manutencaoufpr/webresources/material";

        // Requisição POST com o corpo da requisição
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(backendURL))
                .header("Content-Type", "application/json; charset=UTF-8") 
                .POST(HttpRequest.BodyPublishers.ofString(requestBody, StandardCharsets.UTF_8))
                .build();
        try {
            // Envio da requisição e obtenção da resposta
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            // Verificação do código de status
            int statusCode = response.statusCode();
            if (statusCode == 200 || statusCode == 204) {
                System.out.println("Material adicionado com sucesso!");
            } else {
                throw new FacadeException("Erro ao listar materiais: " + response.body());
            }
        } catch (IOException | InterruptedException e) {
            throw new FacadeException("Erro na chamada ao backend: " + e.getMessage(), e);
        }
    }

    public static List<MaterialDTO> buscarMateriais() throws FacadeException {
        try {
            // URL do endpoint do backend
            String backendURL = "http://localhost:8080/manutencaoufpr/webresources/material";

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

            if (statusCode == 200) {
                String responseBody = response.body();

                // Converte o JSON de resposta para um objeto
                ObjectMapper mapper = new ObjectMapper();
                List<MaterialDTO> materiais = mapper.readValue(responseBody, new TypeReference<List<MaterialDTO>>() {
                });
                return materiais;
            } else {
                throw new FacadeException("Erro ao listar materiais: " + response.body());
            }
        } catch (IOException | InterruptedException e) {

            throw new FacadeException("Erro na chamada ao backend: " + e.getMessage(), e);
        }
    }
}
