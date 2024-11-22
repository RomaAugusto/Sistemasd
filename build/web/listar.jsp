<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%

    if (session.getAttribute("usuario") != null) {
%>
<%@page import="java.util.List"%>
<%@page import="Entidades.cliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<cliente> Lista = (List<cliente>) request.getAttribute("Lista");
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
                            <h1 class="mt-2">Listado de Clientes</h1>
                            <div class="table-responsive mt-3">
                                <table class="table table-bordered formulario-estilos-table">
                                    <thead class="thead-dark">
                                        <tr class="text-center">
                                            <th>Cod</th>
                                            <th>Apellidos</th>
                                            <th>Nombres</th>
                                            <th>DNI</th>
                                            <th>Dirección</th>
                                            <th>Teléfono</th>
                                            <th>Móvil</th>
                                            <th colspan="3"></th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="campo" items="${Lista}">
                                            <tr>
                                                <td>${campo.id}</td>
                                                <td>${campo.apellidos}</td>
                                                <td>${campo.nombres}</td>
                                                <td>${campo.DNI}</td>
                                                <td>${campo.direccion}</td>
                                                <td>${campo.telefono}</td>
                                                <td>${campo.movil}</td>
                                                <td><a href="ControlerCliente?Op=Consultar&Id=${campo.id}" class="btn btn-info btn-sm">Consultar</a></td>
                                                <td><a href="ControlerCliente?Op=Modificar&Id=${campo.id}" class="btn btn-primary btn-sm">Modificar</a></td>
                                                <td><a href="ControlerCliente?Op=Eliminar&Id=${campo.id}" class="btn btn-danger btn-sm">Eliminar</a></td>
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
                document.title = "Lista | Cliente";
            });
        </script>

    </body>

    <script src="JStyle.js"></script>

</html>

<%    } else {
        response.sendRedirect("login.jsp");
    }
%>