<%-- 
    Document   : Pedidos
    Created on : 12/10/2022, 05:11:15 PM
    Author     : javie
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%  
    if (Controler.ControlerUsuario.USUARIO != null) {
        
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <%@include file="/componentes/header.jspf" %>
    
    <div class="container">
        <h1 class="mt-5">Menú Pedidos</h1>
        <ul class="list-group mt-3">
            <li class="list-group-item"><a href="ControlerPedido?Op=Listar">Listar Pedidos</a></li>
            <li class="list-group-item"><a href="ControlerPedido?Op=Nuevo">Nuevo Pedido</a></li>
        </ul>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
<%
    }else{
    response.sendRedirect("login.jsp");
    }
%>