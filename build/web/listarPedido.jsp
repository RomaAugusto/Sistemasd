<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : listar
    Created on : 17/09/2022, 10:54:58 AM
    Author     : javie
--%>
<%@page import="java.util.List"%>
<%@page import="Entidades.pedido"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<pedido> Lista = (List<pedido>) request.getAttribute("Lista");
%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cargando...</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
            />

        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
            integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
            crossorigin="anonymous"
            referrerpolicy="no-referrer"
            />
        <link rel="stylesheet" href="css/style2.css" />

        <link rel="shortcut icon" href="img/icons8-gitlab-32.png" type="image/x-icon">

        <link
            href="https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css"
            rel="stylesheet"
            />
    </head>

    <body>

        <%@include file="/componentes/header.jspf" %>

        <section class="home-section">
            <div class="home-content">
                <i class="bx bx-menu" style='color:#ffffff'></i>

                <div class="text">
                    <div class="container scroll">

                        <div>
                            <h1 class="mt-2">Listado de Pedidos</h1>
                            <div class="table-responsive mt-3">
                                <table class="table table-bordered formulario-estilos-table">
                                    <thead class="thead-dark">
                                        <tr>
                                            <td>Id Pedido</td>
                                            <td>Id Cliente</td>
                                            <td>Apellidos</td>
                                            <td>Nombres</td>
                                            <td>Fecha</td>
                                            <td>Sub Total</td>
                                            <td>Total Pedido</td>
                                            <td colspan="2"></td>

                                        </tr>
                                    </thead>

                                    <tbody>
                                        <c:forEach var="campo" items="${Lista}">
                                            <tr>
                                                <td>${campo.getId_Pedido()}</td>
                                                <td>${campo.getId_Cliente()}</td>
                                                <td>${campo.getApellidos()}</td>
                                                <td>${campo.getNombres()}</td>
                                                <td>${campo.getFecha()}</td>
                                                <td>${campo.getSubTotal()}</td>
                                                <td>${campo.getTotalVenta()}</td>
                                                <td><a href="ControlerPedido?Op=Consultar&Id=${campo.getId_Pedido()}" class="btn btn-info btn-sm">Consultar</a></td>
                                                <td><a href="ControlerPedido?Op=Eliminar&Id=${campo.getId_Pedido()}" class="btn btn-danger btn-sm">Eliminar</a></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>


                    </div>
                </div>
            </div>
        </section>

        <script>
            let arrow = document.querySelectorAll(".arrow");
            for (var i = 0; i < arrow.length; i++) {
                arrow[i].addEventListener("click", (e) => {
                    let arrowParent = e.target.parentElement.parentElement; //selecting main parent of arrow
                    arrowParent.classList.toggle("showMenu");
                });
            }
            let sidebar = document.querySelector(".sidebar");
            let sidebarBtn = document.querySelector(".bx-menu");
            console.log(sidebarBtn);
            sidebarBtn.addEventListener("click", () => {
                sidebar.classList.toggle("close");
            });
        </script>

        <script>
            window.addEventListener("load", function () {
                document.title = "Lista | Pedido";
            });
        </script>

        <script src="JStyle.js"></script>

    </body>
</html>
