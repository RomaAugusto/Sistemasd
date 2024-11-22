<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : index
    Created on : 19/11/2021, 07:15:10 PM
    Author     : javie
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
                            <h1 class="mt-2 text-center">Insertar Clientes</h1>
                            <form action="ControlerCliente" method="post" class="mt-3 formulario-estilos">
                                <div class="container">

                                    <div class="row">
                                        <div class="col-12 col-md-6 mb-3" hidden="">
                                            <label for="Id">Id Cliente</label>
                                            <input type="text" name="Id" id="Id" class="form-control">
                                        </div>

                                        <div class="col-12 col-md-6 mb-3">
                                            <label for="apellidos">Apellidos</label>
                                            <input type="text" name="apellidos" id="apellidos" class="form-control" maxlength="50">
                                            <small id="apellidosError" class="text-danger"></small>
                                        </div>
                                        <div class="col-12 col-md-6 mb-3">
                                            <label for="nombres">Nombres</label>
                                            <input type="text" name="nombres" id="nombres" class="form-control" maxlength="50">
                                            <small id="nombresError" class="text-danger"></small>
                                        </div>
                                        <div class="col-12 col-md-6 mb-3">
                                            <label for="dni">DNI</label>
                                            <input type="number" name="DNI" id="dni" class="form-control">
                                            <small id="dniError" class="text-danger"></small>
                                        </div>
                                        <div class="col-12 col-md-6 mb-3">
                                            <label for="direccion">Dirección</label>
                                            <input type="text" name="direccion" id="direccion" class="form-control" maxlength="100">
                                            <small id="direccionError" class="text-danger"></small>
                                        </div>
                                        <div class="col-12 col-md-6 mb-3">
                                            <label for="telefono">Teléfono</label>
                                            <input type="number" name="telefono" id="telefono" class="form-control">
                                            <small id="telefonoError" class="text-danger"></small>
                                        </div>
                                        <div class="col-12 col-md-6 mb-3">
                                            <label for="movil">Móvil</label>
                                            <input type="number" name="movil" id="movil" class="form-control">
                                            <small id="movilError" class="text-danger"></small>
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
                document.title = "Agregar | Cliente";
            });
        </script>

        <script>
            document.getElementById('telefono').addEventListener('input', function (event) {
                var value = event.target.value;
                if (value.length > 10) {
                    event.target.value = value.slice(0, 10);
                }
            });
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

        </script>

        <script src="JStyle.js"></script>

    </body>
</html>



