<%-- 
    Document   : validar
    Created on : 21 de out. de 2024, 09:31:23
    Author     : Lucas Vinícius
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%> 
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            /* Declaração de variáveis */
            String u, s, nom;
            Connection conecta;
            PreparedStatement st;
            ResultSet resultado;
            /*Receber o usuário e a senha digitados no formulário*/
            u = request.getParameter("usuario");
            s = request.getParameter("senha");
            /* Conectar com o banco de dados... */
            Class.forName("com.mysql.cj.jdbc.Driver"); //aponta para a biblioteca JDBC
            conecta = DriverManager.getConnection("jdbc:mysql://localhost:3307/empresa", "root", "p@$$w0rd");
            /*Verificar se o usuário está armazenado na tabela do banco de dados*/
            st = conecta.prepareStatement("SELECT * FROM usuarios WHERE usuario=? AND senha=?");
            st.setString(1, u); //coloca o conteúdo da variável u no Select
            st.setString(2, s); //coloca o conteúdo da variável s no Select
            resultado = st.executeQuery(); //Executa o Select e armazena os dados do usuário
            /* Verifica se o usuário foi encontrado na tabela do Bando de dados */
            if (resultado.next()) {   //se foi encontrado
                //Pega o nome do usuário que está na variável resultado
                response.sendRedirect("restrito.jsp?nome=" + resultado.getString("nome"));
            } else { // Se não foi encontrado
                out.print("Usuário e/ou senha inválidos");
            }

        %>
    </body>
</html>

