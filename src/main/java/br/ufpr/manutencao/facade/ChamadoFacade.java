/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.facade;

import br.ufpr.manutencao.dto.ChamadoDTO;
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
public class ChamadoFacade {

    public static List<ChamadoDTO> buscarChamadosAbertos() throws FacadeException {
        try {
            // URL do endpoint do backend
            String backendURL = "http://localhost:8080/manutencaoufpr/webresources/chamado/listaChamadosAbertos";

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
                List<ChamadoDTO> chamados = mapper.readValue(responseBody, new TypeReference<List<ChamadoDTO>>() {
                });

                System.out.println("entrou na facade aberto " + chamados);
                return chamados;
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

    public static List<ChamadoDTO> buscarChamadosEmAndamento() throws FacadeException {
        try {
            // URL do endpoint do backend
            String backendURL = "http://localhost:8080/manutencaoufpr/webresources/chamado/listaChamadosEmAndamento";

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
                List<ChamadoDTO> chamados = mapper.readValue(responseBody, new TypeReference<List<ChamadoDTO>>() {
                });

                return chamados;
            } else {
                // Se o código de status for diferente de 200
                throw new FacadeException("Erro ao listar chamados: " + response.body());
            }
        } catch (IOException | InterruptedException e) {
            // Exceção que ocorre durante a chamada ao backend
            throw new FacadeException("Erro na chamada ao backend: " + e.getMessage(), e);
        }
    }

    public static void associarChamado(int idChamado, int idOS) throws FacadeException {
        HttpClient httpClient = HttpClient.newHttpClient();

        // URL do endpoint do backend
        String backendURL = "http://localhost:8080/manutencaoufpr/webresources/chamados/atualizarIdOSChamado/" + idChamado + "/" + idOS;

        // Requisição PUT sem corpo
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(backendURL))
                .header("Content-Type", "application/json")
                .PUT(HttpRequest.BodyPublishers.noBody())
                .build();

        try {
            // Chamada ao backend
            HttpResponse<Void> response = httpClient.send(request, HttpResponse.BodyHandlers.discarding());

            // Verificação do código de status
            int statusCode = response.statusCode();
            if (statusCode == 200 || statusCode==204) {
                System.out.println("Chamado associado à ordem de serviço.");
            } else {
                System.out.println("Erro na associação do chamado à ordem de serviço: " + response.body());
                throw new FacadeException("Erro na associação do chamado à ordem de serviço: " + response.body());
            }
        } catch (IOException | InterruptedException e) {
            // Exceção que ocorre durante a chamada ao backend
            throw new FacadeException("Erro na chamada ao backend: " + e.getMessage(), e);
        }
    }

}
