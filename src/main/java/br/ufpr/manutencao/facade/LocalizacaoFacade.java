/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.facade;

import br.ufpr.manutencao.dto.CampusDTO;
import br.ufpr.manutencao.dto.PredioDTO;
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

            if (statusCode == 200) {
                String responseBody = response.body();

                // Converte o JSON de resposta para um objeto
                ObjectMapper mapper = new ObjectMapper();
                List<CampusDTO> campus = mapper.readValue(responseBody, new TypeReference<List<CampusDTO>>() {
                });

                return campus;
            } else {
                throw new FacadeException("Erro ao listar campus: " + response.body());
            }
        } catch (IOException | InterruptedException e) {

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
                return predios;
            } else {

                throw new FacadeException("Erro ao listar prédios: " + response.body());
            }
        } catch (IOException | InterruptedException e) {

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

            if (statusCode == 200) {
                String responseBody = response.body();

                // Converte o JSON de resposta para um objeto
                ObjectMapper mapper = new ObjectMapper();
                List<PredioDTO> predios = mapper.readValue(responseBody, new TypeReference<List<PredioDTO>>() {
                });

                return predios;
            } else {
                throw new FacadeException("Erro ao listar prédios: " + response.body());
            }
        } catch (IOException | InterruptedException e) {

            throw new FacadeException("Erro na chamada ao backend: " + e.getMessage(), e);
        }
    }

    public static void adicionarCampus(CampusDTO campus) throws FacadeException, JsonProcessingException {
        HttpClient httpClient = HttpClient.newHttpClient();
        ObjectMapper mapper = new ObjectMapper();

        // Corpo da requisição
        String requestBody = mapper.writeValueAsString(campus);

        // URL do endpoint do backend
        String backendURL = "http://localhost:8080/manutencaoufpr/webresources/campus";

        // Requisição POST com o corpo da requisição
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(backendURL))
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(requestBody, StandardCharsets.UTF_8))
                .build();

        try {
            // Envio da requisição e obtenção da resposta
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            // Verificação do código de status
            int statusCode = response.statusCode();
            if (statusCode == 200 || statusCode == 204) {
                System.out.println("Campus adicionado com sucesso!");
            } else {
                throw new FacadeException("Erro ao adicionar campus: " + response.body());
            }
        } catch (IOException | InterruptedException e) {
            throw new FacadeException("Erro na requisição: " + e.getMessage());
        }
    }

    public static void adicionarPredio(PredioDTO predio) throws FacadeException, JsonProcessingException {

        HttpClient httpClient = HttpClient.newHttpClient();
        ObjectMapper mapper = new ObjectMapper();

        // Corpo da requisição
        String requestBody = mapper.writeValueAsString(predio);

        // URL do endpoint do backend
        String backendURL = "http://localhost:8080/manutencaoufpr/webresources/predio";

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
                System.out.println("Prédio adicionado com sucesso!");
            } else {
                throw new FacadeException("Erro ao adicionar prédio: " + response.body());
            }
        } catch (IOException | InterruptedException e) {
            throw new FacadeException("Erro na requisição: " + e.getMessage());
        }
    }

    public static void bloquearCampus(int campusId) throws FacadeException, JsonProcessingException {
        HttpClient httpClient = HttpClient.newHttpClient();

        // URL do endpoint do backend
        String backendURL = "http://localhost:8080/manutencaoufpr/webresources/campus/bloquear/" + campusId;

        // Requisição PUT
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(backendURL))
                .header("Content-Type", "application/json")
                .PUT(HttpRequest.BodyPublishers.noBody())
                .build();

        try {
            // Envio da requisição e obtenção da resposta
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            // Verificação do código de status
            int statusCode = response.statusCode();
            if (statusCode == 200 || statusCode == 204) {
                System.out.println("Campus bloqueado com sucesso!");
            } else {
                throw new FacadeException("Erro ao bloquear campus: " + response.body());
            }
        } catch (IOException | InterruptedException e) {
            throw new FacadeException("Erro na requisição: " + e.getMessage());
        }
    }

    public static void bloquearPredio(int predioId) throws FacadeException, JsonProcessingException {
        HttpClient httpClient = HttpClient.newHttpClient();

        // URL do endpoint do backend
        String backendURL = "http://localhost:8080/manutencaoufpr/webresources/predio/bloquear/" + predioId;

        // Requisição PUT com o corpo da requisição
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(backendURL))
                .header("Content-Type", "application/json; charset=UTF-8") // Adicione o charset ao cabeçalho Content-Type
                .PUT(HttpRequest.BodyPublishers.noBody())
                .build();

        try {
            // Envio da requisição e obtenção da resposta
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            // Verificação do código de status
            int statusCode = response.statusCode();
            if (statusCode == 200 || statusCode == 204) {
                System.out.println("Prédio bloqueado!");
            } else {
                throw new FacadeException("Erro ao bloquear prédio: " + response.body());
            }
        } catch (IOException | InterruptedException e) {
            throw new FacadeException("Erro na requisição: " + e.getMessage());
        }
    }
}
