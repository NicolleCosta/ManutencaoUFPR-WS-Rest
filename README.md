# ManutencaoUFPR-WS-Rest
<h1 align="center">Manutenção UFPR</h1>


## Descrição do Projeto
<p align="center">Olá! Este repositório é parte de um trabalho de conclusão de curso apresentado por estudantes da Universidade Federal do Paraná, do Curso de Tecnologia em Análise e Desenvolvimento de Sistemas.</p>


# Como rodar o projeto

## 🛠 Pré-requisitos

- Ter o [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) instalado na sua máquina;
- Ter o [Apache NetBeans] v17(https://netbeans.apache.org/download/archive/index.html);
- Ter o [Android Studio](https://developer.android.com/studio) instalado em seu sistema operacional;
- Ter o [PgAdmin] v6.8(https://www.pgadmin.org/download/) 
- Ter o [PostgreSQL] v14 (https://www.postgresql.org/download/)
- Também tem que ter o [Java SE] v11.0.17 (https://www.java.com/pt-BR/download/ie_manual.jsp?locale=pt_BR).



## Passo a Passo

### Passo 1:

Crie uma pasta em um local de sua preferência: 
Clone os dois repositórios que fazem parte deste trabalho

```bash
git clone https://github.com/Janaerc/tccFrontMobile.git
git clone https://github.com/NicolleCosta/ManutencaoUFPR-WS-Rest.git
```

### Passo 2:
Prepare o banco de dados no PgAdmin, utilizando os scripts de criação do banco de dados e povoamento das tabelas, disponível nos apêndices 8 e 9 do documento escrito [Manutenção UFPR] (https://github.com/Janaerc/tccFrontMobile/blob/master/app/build.gradle) 
Não esqueça de povoar as tabelas corretamente, e principalmente povoar o usuário Gerente.
*****LEMBRAR DE ALTERAR PARA O LINK DO MATERIAL FINAL DENTRO DO REPOSITÓRIO*********

### Passo 3:
Abra a pasta ManutencaoUFPR-WS-Rest no NetBens.
Em Web-Pages > WEB-INF > glassfish-resources.xml altere as configurações, para se adequar às configurações do seu postgres.
Faça o Build e execute o sistema.

### Passo 4:
Acesse a aplicação web com o perfil gerente inserido previamente no Banco de Dados:
 	CPF: 00328973084
Senha: 123

### Passo 5:
Navegue até o menu funcionários e adicione um administrador e um almoxarife.

### Passo 6:
Navegue até o menu operário e adicione um operário.


### Passo 7:
Abra a pasta tccFrontMobile no Android Studio, adicione um emulador mínimo de 5 Pixels com Android Oreo API 27. Execute o projeto no NetBeans, e execute o emulador no Android Studio.

### Passo 8:
No emulador, clique na opção primeiro acesso e cadastre-se.

### Passo 9:
Retorne ao homepage do aplicativo e acesse com seus dados de cadastro.
Pronto, você já poderá abrir um chamado.

Se você acessar a aplicação web com os dados do administrador, seu chamado estará esperando para ser associado a um número de ordem de serviço, após a conclusão deste passo você poderá acessar o aplicativo com seus dados de login de operário, e se associar aquela ordem, poderá atualizar o status do andamento e caso deseje poderá retirar um material. Para isso, acesse o perfil de almoxarife e escolha a ordem de serviço associada ao operário, cadastre a retirada de material. Por fim, verifique o andamento pelo perfil de gerente.





<h5> Atenção este projeto foi desenvolvido para </h5> [![Windows](https://svgshare.com/i/ZhY.svg)](https://svgshare.com/i/ZhY.svg)
