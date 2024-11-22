<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : index
    Created on : 19/11/2021, 07:15:10 PM
    Author     : javie
--%>

<%@page import="java.util.List"%>
<%@page import="Entidades.detallePedido"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<detallePedido> Lista = (List<detallePedido>) request.getAttribute("Lista");
    double totalCosto = 0.0;
    double totalIgv = 0.0;
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
                    <div class="container">
                        <div>
                            <h1 class="mt-2">Consulta de Pedido</h1>
                            <div class="table-responsive mt-3">
                                <table class="table table-bordered formulario-estilos-table">
                                    <thead class="thead-dark">
                                        <tr>
                                            <th>Id Pedido</th>
                                            <th>Id Producto</th>
                                            <th>Descripción</th>
                                            <th>Unidad Medida</th>
                                            <th>Cantidad</th>
                                            <th>Precio</th>
                                            <th>Total Detalle</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <c:forEach var="campo" items="${Lista}">
                                            <tr>
                                                <td>${campo.getId_Pedido()}</td>
                                                <td>${campo.getId_Prod()}</td>
                                                <td>${campo.getDescripcion()}</td>
                                                <td>${campo.getUnidadMedida()}</td>
                                                <td>${campo.getCantidad()}</td>
                                                <td>${campo.getPrecio()}</td>
                                                <td>${campo.getTotalDeta()}</td>
                                            </tr>
                                        </c:forEach>


                                        <tr>
                                            <td colspan="5"  style="border-bottom: 1px solid transparent; border-left: 1px solid transparent"></td>

                                            <td>Sub total</td>
                                            <td>
                                                <c:set var="totalCosto" value="0.0" />
                                                <c:forEach var="campo" items="${Lista}">
                                                    <c:set var="totalCosto" value="${totalCosto + campo.getTotalDeta()}" />
                                                </c:forEach>
                                                ${totalCosto}
                                            </td>
                                        </tr>

                                        <tr>
                                            <td colspan="5"  style="border-top: 1px solid transparent; border-left: 1px solid transparent;border-bottom: 1px solid transparent"></td>
                                            <td>IGV</td>
                                            <td>
                                                <c:set var="totalIgv" value="${totalCosto * 0.18}" />
                                                <script>
                                                    let totalIgv = ${totalIgv};
                                                    document.write(totalIgv.toFixed(2));
                                                </script>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td colspan="5"  style="border-bottom: 1px solid transparent; border-left: 1px solid transparent;border-top: 1px solid transparent"></td>
                                            <td>Total venta</td>
                                            <td>
                                                <script>
                                                    let totalCosto = ${totalCosto};
                                                    console.log(totalIgv, totalCosto);
                                                    let final = (totalIgv + totalCosto).toFixed(2);
                                                    document.write(final);
                                                </script>
                                            </td>
                                        </tr>
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
                document.title = "Consulta | Pedidos";
            });
        </script>

        <script src="JStyle.js"></script>

    </body>
</html>