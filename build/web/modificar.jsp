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
                            <h1 class="mt-2 text-center">Modificar Clientes</h1>

                            <form action="ControlerCliente" method="post" class="mt-3 formulario-estilos">
                                <div class="container">
                                    <c:forEach var="campo" items="${Lista}">
                                        <input type="hidden" name="Id" value="${campo.id}">
                                        <div class="row mb-3">
                                            <div class="col-12 col-md-12">
                                                <label for="idCliente">Id Cliente</label>
                                                <input type="text" id="idCliente" value="${campo.id}" class="form-control" readonly>
                                            </div>
                                        </div>
                                        <div class="row mb-3">
                                            <div class="col-12 col-md-6">
                                                <label for="apellidos">Apellidos</label>
                                                <input type="text" name="apellidos" value="${campo.apellidos}" id="apellidos" class="form-control" maxlength="50">
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <label for="nombres">Nombres</label>
                                                <input type="text" name="nombres" value="${campo.nombres}" id="nombres" class="form-control" maxlength="50">
                                            </div>
                                        </div>     
                                        <div class="row mb-3">
                                            <div class="col-12 col-md-6">
                                                <label for="dni">DNI</label>
                                                <input type="text" name="DNI" value="${campo.DNI}" id="dni" class="form-control">
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <label for="direccion">Dirección</label>
                                                <input type="text" name="direccion" value="${campo.direccion}" id="direccion" class="form-control" maxlength="100">
                                            </div>
                                        </div>  
                                        <div class="row mb-3">
                                            <div class="col-12 col-md-6">
                                                <label for="telefono">Teléfono</label>
                                                <input type="text" name="telefono" value="${campo.telefono}" id="telefono" class="form-control">
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <label for="movil">Móvil</label>
                                                <input type="text" name="movil" value="${campo.movil}" id="movil" class="form-control">
                                            </div>
                                        </div>                 
                                    </c:forEach>
                                    <div class="row mt-3">
                                        <div class="col-12">
                                            <input type="submit" name="modificar" value="Modificar" class="btn btn-primary w-100"> 
                                        </div>
                                    </div>
                                </div>
                            </form>

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
                document.title = "Modificar | Cliente";
            });
        </script>

        <script>
            // Validación para el campo de teléfono (solo números, máximo 10 dígitos)
            document.getElementById('telefono').addEventListener('input', function (event) {
                var value = event.target.value;
                // Eliminar cualquier carácter no numérico y asegurarse que no tenga más de 10 dígitos
                event.target.value = value.replace(/[^0-9]/g, '').slice(0, 10);
            });

            // Validación para el campo de móvil (solo números, máximo 9 dígitos)
            document.getElementById('movil').addEventListener('input', function (event) {
                var value = event.target.value;
                // Eliminar cualquier carácter no numérico y asegurarse que no tenga más de 9 dígitos
                event.target.value = value.replace(/[^0-9]/g, '').slice(0, 9);
            });

            // Validación para el campo de DNI (solo números, máximo 8 dígitos)
            document.getElementById('dni').addEventListener('input', function (event) {
                var value = event.target.value;
                // Eliminar cualquier carácter no numérico y asegurarse que no tenga más de 8 dígitos
                event.target.value = value.replace(/[^0-9]/g, '').slice(0, 8);
            });

            // Validación para los campos de apellidos y nombres (solo letras)
            document.getElementById('apellidos').addEventListener('input', function (event) {
                var value = event.target.value;
                // Eliminar cualquier carácter que no sea una letra o espacio
                event.target.value = value.replace(/[^a-zA-ZáéíóúÁÉÍÓÚñÑ\s]/g, '');
            });

            document.getElementById('nombres').addEventListener('input', function (event) {
                var value = event.target.value;
                // Eliminar cualquier carácter que no sea una letra o espacio
                event.target.value = value.replace(/[^a-zA-ZáéíóúÁÉÍÓÚñÑ\s]/g, '');
            });

            // Validación para la dirección (solo letras, números y espacios)
            document.getElementById('direccion').addEventListener('input', function (event) {
                var value = event.target.value;
                // Permitir letras, números, espacios y caracteres especiales (como coma, punto, etc.)
                event.target.value = value.replace(/[^a-zA-ZáéíóúÁÉÍÓÚñÑ0-9\s.,-]/g, '');
            });
        </script>

        <script src="JStyle.js"></script>

    </body>
</html>
