/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.facade;

import br.ufpr.manutencao.dto.CampusDTO;
import br.ufpr.manutencao.dto.PredioDTO;
import br.ufpr.manutencao.dto.UsuarioDTO;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.List;

/**
 *
 * @author nicol
 */
public class LocalizacaoFacade {

    public static List<CampusDTO> buscarCampus() throws FacadeException {
        try {
            // URL do endpoint do backend
            String backendURL = "http://localhost:8080/manutencaoufpr/webresources/campus/lista";

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
                List<CampusDTO> campus = mapper.readValue(responseBody, new TypeReference<List<CampusDTO>>() {
                });

                System.out.println("entrou na facade aberto " + campus);
                return campus;
            } else {
                System.out.println("entrou no else");
                // Se o código de status for diferente de 200
                throw new FacadeException("Erro ao listar campus: " + response.body());
            }
        } catch (IOException | InterruptedException e) {
            System.out.println("entrou no erro" + e);

            // Exceção que ocorre durante a chamada ao backend
            throw new FacadeException("Erro na chamada ao backend: " + e.getMessage(), e);
        }
    }

    public static List<PredioDTO> buscarPredios() throws FacadeException {
        try {
            // URL do endpoint do backend
            String backendURL = "http://localhost:8080/manutencaoufpr/webresources/predio/lista";

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
                List<PredioDTO> predios = mapper.readValue(responseBody, new TypeReference<List<PredioDTO>>() {
                });

                System.out.println("entrou na facade aberto " + predios);
                return predios;
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

    public static List<PredioDTO> listarPredioPorCampus(int id) throws FacadeException {
        // URL do endpoint do backend
        String backendURL = "http://localhost:8080/manutencaoufpr/webresources/predio/lista/" + id;

        HttpClient httpClient = HttpClient.newHttpClient();

        // Requisição GET
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

                // Converte o JSON de resposta para um objeto
                ObjectMapper mapper = new ObjectMapper();
                List<PredioDTO> predios = mapper.readValue(responseBody, new TypeReference<List<PredioDTO>>() {
                });

                System.out.println("entrou na facade aberto " + predios);
                return predios;
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

    public static void adicionarCampus(CampusDTO campus) throws FacadeException {

        HttpClient httpClient = HttpClient.newHttpClient();
        ObjectMapper mapper = new ObjectMapper();
        try {
            // Corpo da requisição
            String requestBody = mapper.writeValueAsString(campus);

            // URL do endpoint do backend
            String backendURL = "http://localhost:8080/manutencaoufpr/webresources/campus";

            // Requisição POST com o corpo da requisição
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(backendURL))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(requestBody))
                    .build();

            // Envio da requisição e obtenção da resposta
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            // Verificação do código de status
            int statusCode = response.statusCode();
            if (statusCode == 200) {
                System.out.println("Campus adicionado com sucesso!");
            } else {
                System.out.println("Falha ao adicionar o campus. Código de status: " + statusCode);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new FacadeException("Erro na requisição: " + e.getMessage());
        }
    }
}
