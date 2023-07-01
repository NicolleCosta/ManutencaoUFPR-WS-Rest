/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.ufpr.manutencao.facade;

import br.ufpr.manutencao.dto.ComentarioOperarioDTO;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
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
public class ComentarioOperarioFacade {

    public static List<ComentarioOperarioDTO> buscarComentarios() throws FacadeException{
        try {
            // URL do endpoint do backend
            String backendURL = "http://localhost:8080/manutencaoufpr/webresources/comentariooperario";

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
                List<ComentarioOperarioDTO> ordens = mapper.readValue(responseBody, new TypeReference<List<ComentarioOperarioDTO>>() {
                });

                return ordens;
            } else {

                throw new FacadeException("Erro ao listar comentarios: " + response.body());
            }
        } catch (IOException | InterruptedException e) {

            throw new FacadeException("Erro na chamada ao backend: " + e.getMessage(), e);
        }
    }

    public static List<ComentarioOperarioDTO> buscarComentarioPorId(Integer id)throws FacadeException{
        try {
            // URL do endpoint do backend
            String backendURL = "http://localhost:8080/manutencaoufpr/webresources/comentariooperario/listarComentarioPorIdOS/" + id;

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
                List<ComentarioOperarioDTO> comentarios = mapper.readValue(responseBody, new TypeReference<List<ComentarioOperarioDTO>>() {
                });

                return comentarios;
            } else {

                throw new FacadeException("Erro ao listar comentarios: " + response.body());
            }
        } catch (IOException | InterruptedException e) {

            throw new FacadeException("Erro na chamada ao backend: " + e.getMessage(), e);
        }
    }
    
}
