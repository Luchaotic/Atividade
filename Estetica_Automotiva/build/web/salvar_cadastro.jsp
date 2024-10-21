<%-- 
    Document   : salvar_cadastro
    Created on : 21 de out. de 2024, 09:46:12
    Author     : Lucas Vinícius
--%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%> 
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            // Declarar as variáveis
            Connection conecta;
            PreparedStatement st;
            int i;
            String n, m, d;
            double p;
            // Receber os dados digitados no formulário
            i = Integer.parseInt(request.getParameter("id"));
            n = request.getParameter("nome");
            m = request.getParameter("marca");
            p = Double.parseDouble(request.getParameter("preco"));
            d = request.getParameter("data_fab");
            try {
                //Conectar com o banco de dados
                Class.forName("com.mysql.cj.jdbc.Driver"); //aponta para a biblioteca JDBC
                conecta = DriverManager.getConnection("jdbc:mysql://localhost:3308/XXXX", "root", "Lucas0159");
                // Enviar os dados recebidos para a tabela do banco de dados
                st = conecta.prepareStatement("INSERT INTO produtos VALUES(?,?,?,?,?)");
                st.setInt(1, i);
                st.setString(2, n);
                st.setString(3, m);
                st.setDouble(4, p);
                st.setString(5, d);
                st.executeUpdate(); //Eexecuta o INSERT na tabela do BD
                // Informar o usuário que os dados foram gravados
                out.print("Produto cadastrado com sucesso");
            } catch (SQLException erro) {
                if (erro.getMessage().contains("Duplicate entry")) {
                    out.print("Este ID de produto já está cadastrado");
                } else {
                    out.print("Erro: entre em contato com o administrador");
                }
            }
        %>  
    </body>
</html>

