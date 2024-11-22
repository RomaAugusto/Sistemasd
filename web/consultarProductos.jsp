<%@page import="Entidades.producto"%>
<%@page import="java.util.List"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<producto> Lista = (List<producto>) request.getAttribute("Lista");
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
                            <h1 class="mt-2 text-center">Consulta de Productos</h1>
                            <form action="ControlerProducto" method="post" class="mt-3 formulario-estilos">
                                <c:forEach var="campo" items="${Lista}">
                                    <input type="hidden" name="Id" value="${campo.id}">

                                    <!-- Campo: Id Producto -->
                                    <div class="row mb-3">
                                        <div class="col-12 col-md-6">
                                            <label for="idProducto">Id Producto</label>
                                            <input type="text" id="idProducto" value="${campo.id}" class="form-control" readonly>
                                        </div>


                                        <!-- Campo: Descripción -->

                                        <div class="col-12 col-md-6">
                                            <label for="descripcion">Descripción</label>
                                            <input type="text" name="descripcion" value="${campo.descripcion}" id="descripcion" class="form-control" readonly>
                                        </div>


                                        <!-- Campo: Unidad de Medida -->

                                        <div class="col-12 col-md-6">
                                            <label for="unidadMedida">Unidad de Medida</label>
                                            <input type="text" name="unidadMedida" value="${campo.getUnidadMedida()}" id="unidadMedida" class="form-control" readonly>
                                        </div>


                                        <!-- Campo: Costo -->

                                        <div class="col-12 col-md-6">
                                            <label for="costo">Costo</label>
                                            <input type="text" name="costo" value="${campo.costo}" id="costo" class="form-control" readonly>
                                        </div>


                                        <!-- Campo: Precio -->

                                        <div class="col-12 col-md-6">
                                            <label for="precio">Precio</label>
                                            <input type="text" name="precio" value="${campo.precio}" id="precio" class="form-control" readonly>
                                        </div>


                                        <!-- Campo: Cantidad -->

                                        <div class="col-12 col-md-6">
                                            <label for="cantidad">Cantidad</label>
                                            <input type="text" name="cantidad" value="${campo.cantidad}" id="cantidad" class="form-control" readonly>
                                        </div>
                                    </div>
                                </c:forEach>
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
                document.title = "Consulta | Productos";
            });
        </script>

        <script src="JStyle.js"></script>

    </body>
</html>
