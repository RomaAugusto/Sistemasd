<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : nuevoProducto
    Created on : 13 may. 2024, 22:49:31
    Author     : Usuario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                            <h1 class="mt-2 text-center">Insertar Producto</h1>
                            <form action="ControlerProducto" method="post" class="mt-3 formulario-estilos">

                                <div class="container">
                                    <div class="row">
                                        <div class="col-12 col-md-6 mb-3" hidden="">
                                            <label for="Id">Id Cliente</label>
                                            <input type="text" name="Id" id="Id" class="form-control">
                                        </div>

                                        <div class="col-12 col-md-6 mb-3">
                                            <label for="Descripcion">Descripción:</label>
                                            <input type="text" name="Descripcion" class="form-control" required>
                                        </div>

                                        <div class="col-12 col-md-6 mb-3">
                                            <label for="unidad">Unidad de Medida:</label>
                                            <select name="unidad" id="unidad" class="form-control" required>
                                                <option value="kilogramos">Kilogramos</option>
                                                <option value="gramos">Gramos</option>
                                                <option value="litros">Litros</option>
                                                <option value="centimetros">Centímetros</option>
                                            </select>
                                        </div>

                                        <div class="col-12 col-md-6 mb-3">
                                            <label for="costo">Costo:</label>
                                            <input type="text" name="costo" class="form-control" required>
                                        </div>
                                        <div class="col-12 col-md-6 mb-3">
                                            <label for="precio">Precio:</label>
                                            <input type="text" name="precio" class="form-control" required>
                                        </div>
                                        <div class="col-12 col-md-6 mb-3">
                                            <label for="cantidad">Cantidad:</label>
                                            <input type="text" name="cantidad" class="form-control" required>
                                        </div>
                                    </div>
                                    <div class="row mt-3">
                                        <div class="col-12">
                                            <input type="submit" name="modificar" value="Grabar" class="btn btn-primary w-100">
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
                document.title = "Agregar | Producto";
            });
        </script>

        <script src="JStyle.js"></script>

    </body>
</html>
