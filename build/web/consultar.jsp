<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : index
    Created on : 19/11/2021, 07:15:10 PM
    Author     : javie
--%>

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

                            <h1 class="mt-2 text-center">Consulta de Clientes</h1>
                            <div class="container">
                                <c:forEach var="campo" items="${Lista}">
                                    <div class="row mb-3 formulario-estilos">


                                        <div class="col-12 col-md-12 mb-2">
                                            <label for="-${campo.id}"><strong>codigo</strong></label>
                                            <input type="text" class="form-control" id="codigo-${campo.id}" value="${campo.id}" readonly>
                                        </div>

                                        <div class="col-12 col-md-6 mb-2">
                                            <label for="apellidos-${campo.id}"><strong>Apellidos:</strong></label>
                                            <input type="text" class="form-control" id="apellidos-${campo.id}" value="${campo.apellidos}" readonly>
                                        </div>

                                        <div class="col-12 col-md-6 mb-2">
                                            <label for="nombres-${campo.id}"><strong>Nombres:</strong></label>
                                            <input type="text" class="form-control" id="nombres-${campo.id}" value="${campo.nombres}" readonly>
                                        </div>
                                        <div class="col-12 col-md-6 mb-2">
                                            <label for="dni-${campo.id}"><strong>DNI:</strong></label>
                                            <input type="text" class="form-control" id="dni-${campo.id}" value="${campo.DNI}" readonly>
                                        </div>
                                        <div class="col-12 col-md-6 mb-2">
                                            <label for="direccion-${campo.id}"><strong>Dirección:</strong></label>
                                            <input type="text" class="form-control" id="direccion-${campo.id}" value="${campo.direccion}" readonly>
                                        </div>
                                        <div class="col-12 col-md-6 mb-2">
                                            <label for="telefono-${campo.id}"><strong>Teléfono:</strong></label>
                                            <input type="text" class="form-control" id="telefono-${campo.id}" value="${campo.telefono}" readonly>
                                        </div>
                                        <div class="col-12 col-md-6 mb-2">
                                            <label for="movil-${campo.id}"><strong>Móvil:</strong></label>
                                            <input type="text" class="form-control" id="movil-${campo.id}" value="${campo.movil}" readonly>
                                        </div>
                                    </div>
                                </c:forEach>
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
                document.title = "Consulta | Cliente";
            });
        </script>
        <script src="JStyle.js"></script>
    </body>
</html>
