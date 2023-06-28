/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


$(document).ready(function ($) {
    $("input[name=telefone]").mask('(00) 00000-0000');
    $("input[name=cpf]").mask('000.000.000-00');

    $("#salva-cadastro").click(function () {
        $("input[name=telefone]").val($("input[name=telefone]").cleanVal()); 
        $("input[name=cpf]").val($("input[name=cpf]").cleanVal()); 
    });
    
    $("#salva-cadastro-2").click(function () {
        $("input[name=telefone]").val($("input[name=telefone]").cleanVal()); 
        $("input[name=cpf]").val($("input[name=cpf]").cleanVal()); 
    });
    
    
    $("#logar").click(function () {
        $("input[name=cpf]").val($("input[name=cpf]").cleanVal()); 
    });
});