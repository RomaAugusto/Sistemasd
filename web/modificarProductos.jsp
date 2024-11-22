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
                            <h1 class="mt-2 text-center">Modificar Producto</h1>
                            <form action="ControlerProducto" method="post" class="mt-3 formulario-estilos">
                                <c:forEach var="campo" items="${Lista}">
                                    <input type="hidden" name="Id" value="${campo.id}">

                                    <!-- Una sola fila para todos los campos -->
                                    <div class="row mb-3">
                                        <!-- Campo: Id Producto -->
                                        <div class="col-12 col-md-6">
                                            <label for="idProducto">Id Producto</label>
                                            <input type="text" id="idProducto" value="${campo.id}" class="form-control" readonly>
                                        </div>

                                        <!-- Campo: Descripción -->
                                        <div class="col-12 col-md-6">
                                            <label for="descripcion">Descripción</label>
                                            <input type="text" name="Descripcion" value="${campo.descripcion}" id="descripcion" class="form-control" maxlength="50">
                                        </div>

                                        <!-- Campo: Unidad de Medida -->
                                        <div class="col-12 col-md-6">
                                            <label for="unidadMedida">Unidad de Medida</label>
                                            <select name="unidad" id="unidadMedida" class="form-control">
                                                <option value="kilogramos" ${campo.getUnidadMedida() == 'kilogramos' ? 'selected' : ''}>Kilogramos</option>
                                                <option value="gramos" ${campo.getUnidadMedida() == 'gramos' ? 'selected' : ''}>Gramos</option>
                                                <option value="litros" ${campo.getUnidadMedida() == 'litros' ? 'selected' : ''}>Litros</option>
                                                <option value="centimetros" ${campo.getUnidadMedida() == 'centimetros' ? 'selected' : ''}>Centímetros</option>
                                            </select>
                                        </div>


                                        <!-- Campo: Costo -->
                                        <div class="col-12 col-md-6">
                                            <label for="costo">Costo</label>
                                            <input type="number" name="costo" value="${campo.costo}" id="costo" class="form-control">
                                        </div>

                                        <!-- Campo: Precio -->
                                        <div class="col-12 col-md-6">
                                            <label for="precio">Precio</label>
                                            <input type="number" name="precio" value="${campo.precio}" id="precio" class="form-control">
                                        </div>

                                        <!-- Campo: Cantidad -->
                                        <div class="col-12 col-md-6">
                                            <label for="cantidad">Cantidad</label>
                                            <input type="number" name="cantidad" value="${campo.cantidad}" id="cantidad" class="form-control">
                                        </div>
                                    </div>
                                </c:forEach>

                                <!-- Botón para modificar el producto -->
                                <input type="submit" name="modificar" value="Modificar" class="btn btn-primary">
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
                document.title = "Modificar | Producto";
            });
        </script>


        <script>
// Validación para el campo de Costo (solo números, un solo punto/coma, máximo 8 dígitos enteros y 2 decimales)
            document.getElementById('costo').addEventListener('input', function (event) {
                var value = event.target.value;

                // Eliminar caracteres no numéricos excepto punto y coma
                value = value.replace(/[^0-9.,]/g, '');

                // Permitir solo un punto o una coma
                if ((value.match(/\./g) || []).length > 1) {
                    value = value.replace(/\./g, '');
                }
                if ((value.match(/,/g) || []).length > 1) {
                    value = value.replace(/,/g, '');
                }

                // Reemplazar la coma por un punto para normalizar el valor decimal
                value = value.replace(',', '.');

                // Limitar a 8 enteros y 2 decimales
                if (value.includes('.')) {
                    var parts = value.split('.');
                    parts[1] = parts[1].slice(0, 2); // Limitar a dos decimales
                    if (parts[0].length > 8) {
                        parts[0] = parts[0].slice(0, 8); // Limitar a 8 enteros
                    }
                    value = parts.join('.');
                } else {
                    // Si no hay punto, limitar solo a 8 dígitos enteros
                    if (value.length > 8) {
                        value = value.slice(0, 8);
                    }
                }

                // Asignar el valor limpio al input
                event.target.value = value;
            });



            // Validación para el campo de Precio (solo números, máximo 2 decimales)
            document.getElementById('precio').addEventListener('input', function (event) {
                var value = event.target.value;
                // Eliminar cualquier carácter no numérico y asegurarse que no tenga más de 10 dígitos
                event.target.value = value.replace(/[^0-9]/g, '').slice(0, 8);
            });

            // Validación para el campo de Cantidad (solo números, máximo 8 enteros y 2 decimales)
            document.getElementById('cantidad').addEventListener('input', function (event) {
                var value = event.target.value;
                // Eliminar cualquier carácter no numérico y asegurarse que no tenga más de 10 dígitos
                event.target.value = value.replace(/[^0-9]/g, '').slice(0, 8);
            });
        </script>
        <script src="JStyle.js"></script>
    </body>
</html>
