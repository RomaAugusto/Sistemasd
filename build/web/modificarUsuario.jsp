<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
                            <h1 class="mt-2 text-center">Modificar Usuario</h1>
                            <form action="ControlerUsuario?accion=actualizarUsuario" method="post" class="mt-3 formulario-estilos">   
                                <div class="container">
                                    <div class="row mb-3">
                                        <!-- Campo: ID Usuario -->
                                        <div class="col-12 col-md-6">
                                            <label for="idUsuario">ID Usuario</label>
                                            <input type="text" id="idUsuario" value="${usuario.id_usuario}" class="form-control" readonly>
                                            <input type="hidden" name="hCodigo" value="${usuario.id_usuario}">
                                        </div>

                                        <!-- Campo: Nombre Usuario -->
                                        <div class="col-12 col-md-6">
                                            <label for="txtNombre">Nombre Usuario</label>
                                            <input type="text" name="txtNombre" value="${usuario.nombreUsuario}" class="form-control" maxlength="20">
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <!-- Campo: Clave -->
                                        <div class="col-12 col-md-6">
                                            <label for="txtClave">Clave</label>
                                            <input type="password" name="txtClave" value="${usuario.clave}" class="form-control" maxlength="10">
                                        </div>

                                        <!-- Campo: Cargo -->
                                        <div class="col-12 col-md-6">
                                            <label for="cboCargo">Cargo</label>
                                            <select name="cboCargo" class="form-control">
                                                <c:forEach var="cargo" items="${cargos}">
                                                    <option value="${cargo.codigo}" ${cargo.codigo == usuario.cargo.codigo ? 'selected' : ''}>${cargo.nombreCargo}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <!-- Campo: Estado -->
                                        <div class="col-12 col-md-6">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" name="chkEstado" id="chkEstado" ${usuario.estado ? 'checked' : ''}>
                                                <label class="form-check-label" for="chkEstado">Activo</label>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Botón para enviar el formulario -->

                                    <input type="submit" name="actualizarUsuario" value="Modificar" class="btn btn-primary">
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
                document.title = "Modificar | Usuario";
            });
        </script>

        <script src="JStyle.js"></script>

    </body>
</html>
