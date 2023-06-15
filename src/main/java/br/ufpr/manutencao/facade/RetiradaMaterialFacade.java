/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.facade;

import br.ufpr.manutencao.dto.RetiradaMaterialDTO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
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
public class RetiradaMaterialFacade {

    public static void adicionaListaRetirada(List<RetiradaMaterialDTO> listaRetiradaMaterial) throws FacadeException, JsonProcessingException {
HttpClient httpClient = HttpClient.newHttpClient();
        ObjectMapper mapper = new ObjectMapper();

        // Corpo da requisição
        String requestBody = mapper.writeValueAsString(listaRetiradaMaterial);
        //URL do endpoint do backend
        String backendURL = "http://localhost:8080/manutencaoufpr/webresources/retiradamaterial/create";

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
                System.out.println("Retiradas adicionadas com sucesso!");
            } else {
                System.out.println("Falha ao adicionar. Código de status: " + statusCode);
                System.out.println("Corpo da resposta: " + response.body());
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new FacadeException("Erro na requisição: " + e.getMessage());
        }
    }

}
