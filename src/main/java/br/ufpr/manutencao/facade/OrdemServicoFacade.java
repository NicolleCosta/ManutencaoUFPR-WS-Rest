/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.facade;

import br.ufpr.manutencao.beans.OrdemServico;
import br.ufpr.manutencao.dto.ChamadoDTO;
import br.ufpr.manutencao.dto.OrdemServicoDTO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.List;

/**
 *
 * @author nicol
 */
public class OrdemServicoFacade {

    public static List<OrdemServicoDTO> buscarOrdensDeServico() throws FacadeException {
        try {
            // URL do endpoint do backend
            String backendURL = "http://localhost:8080/manutencaoufpr/webresources/ordemservico";

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
                List<OrdemServicoDTO> ordens = mapper.readValue(responseBody, new TypeReference<List<OrdemServicoDTO>>() {
                });

                System.out.println("entrou na facade aberto " + ordens);
                return ordens;
            } else {
                System.out.println("entrou no else");
                // Se o código de status for diferente de 200
                throw new FacadeException("Erro ao listar ordens: " + response.body());
            }
        } catch (IOException | InterruptedException e) {
            System.out.println("entrou no erro" + e);

            // Exceção que ocorre durante a chamada ao backend
            throw new FacadeException("Erro na chamada ao backend: " + e.getMessage(), e);
        }
    }

    public static void adicionarOS(OrdemServicoDTO ordem) throws FacadeException, JsonProcessingException {

        HttpClient httpClient = HttpClient.newHttpClient();
        ObjectMapper mapper = new ObjectMapper();

        // Corpo da requisição
        String requestBody = mapper.writeValueAsString(ordem);

        // URL do endpoint do backend
        String backendURL = "http://localhost:8080/manutencaoufpr/webresources/ordemservico";

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
                System.out.println("Ordem adicionada com sucesso!");
            } else {
                System.out.println("Falha ao adicionar ordem. Código de status: " + statusCode);
                System.out.println("Corpo da resposta: " + response.body());
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new FacadeException("Erro na requisição: " + e.getMessage());
        }
    }

 public static Integer buscarIdOS(String numeroOS) throws FacadeException {
    try {
        // URL do endpoint do backend
        String backendURL = "http://localhost:8080/manutencaoufpr/webresources/ordemservico/buscarIdPorOS?numeroOS=" + URLEncoder.encode(numeroOS, "UTF-8");

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
            Integer ordemServicoId = mapper.readValue(responseBody, Integer.class);

            return ordemServicoId;

        } else {
            System.out.println("entrou no else");
            // Se o código de status for diferente de 200
            throw new FacadeException("Erro ao buscar ID da ordem de serviço: " + response.body());
        }
    } catch (IOException | InterruptedException e) {
        System.out.println("entrou no erro" + e);

        // Exceção que ocorre durante a chamada ao backend
        throw new FacadeException("Erro na chamada ao backend: " + e.getMessage(), e);
    }
}
}
