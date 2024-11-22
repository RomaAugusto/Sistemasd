<%@page import="java.util.List"%>
<%@page import="Entidades.producto"%>
<%@page import="Entidades.cliente"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<producto> Lista = (List<producto>) request.getAttribute("Lista");
    List<cliente> ListaClientes = (List<cliente>) request.getAttribute("ListaClientes");

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

        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.0/jspdf.plugin.autotable.min.js"></script>


    </head>

    <body>

        <%@include file="/componentes/header.jspf" %>

        <section class="home-section">
            <div class="home-content">
                <i class="bx bx-menu" style='color:#ffffff'></i>

                <div class="text">

                    <div class="container scroll">
                        <div style=" width: 70vw">
                            <h1 class="mt-2">Nuevo Pedido</h1>
                            <form action="ControlerPedido" method="post" class="mt-3 formulario-estilos-bole" onsubmit="return validarFormulario()">
                                <!-- Datos del Cliente -->
                                <div class="row mb-3">
                                    <div class="col-12 col-md-3">
                                        <label for="descripcion">Codigo:</label>
                                        <input type="text" name="cod" class="form-control"  placeholder="12345">
                                    </div>
                                    <div class="col-12 col-md-9">
                                        <label for="Id">Id Cliente:</label>
                                        <select name="Id" class="form-control" required>
                                            <c:forEach var="cliente" items="${ListaClientes}">
                                                <option value="${cliente.getId()}">${cliente.getNombres()} ${cliente.getApellidos()}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-12 col-md-12">

                                        <label for="adress">Direccion:</label>
                                        <input type="text" name="adress" class="form-control"  placeholder="Av Miguel Grau 513-455">
                                    </div>

                                    <!-- Campo Fecha a la izquierda -->
                                    <div class="col-12 col-md-3">
                                        <label for="descripcion">Fecha:</label>
                                        <input type="date" name="descripcion" class="form-control" required>
                                    </div>

                                    <!-- Campo Nro. a la derecha -->
                                    <div class="col-12 col-md-3 ms-auto">
                                        <label for="nro">Nro.</label>
                                        <input type="text" name="nro" class="form-control" placeholder="001">
                                    </div>

                                </div>

                                <!-- Tabla de productos -->
                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead class="thead-dark">
                                            <tr>
                                                <th>Id Producto</th>
                                                <th>Descripción</th>
                                                <th>Unidad</th>
                                                <th>Precio</th>
                                                <th>Stock</th>
                                                <th>Cantidad elegida</th>
                                                <th>Total</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="campo" items="${Lista}">
                                                <tr>
                                                    <td>${campo.getId()}</td>
                                                    <td>${campo.getDescripcion()}</td>
                                                    <td>${campo.getUnidadMedida()}</td>
                                                    <td>s/ ${campo.getPrecio()}0</td>
                                                    <td>${campo.getCantidad()/1}</td>
                                                    <td>
                                                        <input type="number" name="cantidad_${campo.getId()}" class="form-control cantidad" 
                                                               data-precio="${campo.getPrecio()}" data-stock="${campo.getCantidad()}" min="0" 
                                                               oninput="calcularTotales()">
                                                        <input type="hidden" name="costo_${campo.getId()}" value="${campo.getCosto()}">
                                                        <input type="hidden" name="precio_${campo.getId()}" value="${campo.getPrecio()}">
                                                    </td>
                                                    <td class="total_fila">0.00</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Totales -->
                                <div class="container mt-3 mb-5">
                                    <div class="row justify-content-end">
                                        <!-- Sub Total -->
                                        <div class="col-12 col-md-4">
                                            <label for="subtotal">Sub Total:</label>
                                            <input type="text" id="subtotal" name="subtotal" class="form-control d-inline" style="width: auto; border-radius: 0; margin-left: 1.98rem" readonly>
                                        </div>
                                    </div>
                                    <div class="row justify-content-end">
                                        <!-- IGV -->
                                        <div class="col-12 col-md-4">
                                            <label for="igv">IGV:</label>
                                            <input type="text" id="igv" name="igv" class="form-control d-inline" style="width: auto; border-radius: 0; margin-left: 4.95rem" readonly>
                                        </div>
                                    </div>
                                    <div class="row justify-content-end">
                                        <!-- Total a Pagar -->
                                        <div class="col-12 col-md-4">
                                            <label for="total">Total a Pagar:</label>
                                            <input type="text" id="total" name="total" class="form-control d-inline" style="width: auto; border-radius: 0; margin-left: 0.1rem" readonly>
                                        </div>
                                    </div>
                                </div>

                                <!-- Acción oculta y botón de envío -->
                                <input type="hidden" name="action" value="modificar"> <!-- Campo oculto para indicar la acción -->
                                <button type="submit" name="modificar" class="btn btn-primary w-100 mb-3">Grabar</button>

                            </form>
                        </div>
                    </div>

                    <script>
                        function validarFormulario() {
                            let valid = true;
                            let cantidades = document.querySelectorAll('.cantidad');

                            cantidades.forEach(function (input) {
                                let stock = parseInt(input.getAttribute('data-stock'));
                                let cantidad = parseInt(input.value);

                                if (cantidad > stock) {
                                    alert('La cantidad no puede ser mayor al stock disponible.');
                                    input.focus();
                                    valid = false;
                                    return false; // break the loop
                                }
                            });

                            return valid;
                        }
                        function calcularTotales() {
                            let subtotal = 0;
                            let cantidades = document.querySelectorAll('.cantidad');

                            cantidades.forEach(function (input) {
                                let precio = parseFloat(input.getAttribute('data-precio'));
                                let cantidad = parseInt(input.value);
                                let totalFila = precio * cantidad;

                                if (!isNaN(cantidad) && cantidad > 0) {
                                    subtotal += totalFila;
                                } else {
                                    totalFila = 0;
                                }

                                // Actualizar total de la fila
                                input.closest('tr').querySelector('.total_fila').textContent = totalFila.toFixed(2);
                            });

                            let igv = subtotal * 0.18;
                            let total = subtotal + igv;

                            document.getElementById('subtotal').value = subtotal.toFixed(2);
                            document.getElementById('igv').value = igv.toFixed(2);
                            document.getElementById('total').value = total.toFixed(2);
                        }
                    </script>
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
                document.title = "Agregar | Pedido";
            });
        </script>

        <script src="JStyle.js"></script>
    </body>
</html>