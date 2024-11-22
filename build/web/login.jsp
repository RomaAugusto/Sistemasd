<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
        <link rel="stylesheet" href="css/styles.css" />

        <link rel="shortcut icon" href="img/icons8-gitlab-32.png" type="image/x-icon">

        <link
            href="https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css"
            rel="stylesheet"
            />
    </head>

    <style>
        body{
            background: black;
        }
    </style>

    <body>

        <!--
        <form class="login-form" action="ControlerUsuario?accion=verificar" method="post">
            <p class="login-text">
                <span class="fa-stack fa-lg">
                    <i class="fa fa-circle fa-stack-2x"></i>
                    <i class="fa fa-lock fa-stack-1x"></i>
                </span>
            </p>
            <input type="text" name="txtUsu" class="login-username"  required placeholder="Usuario" />
            <input type="password" name="txtPass" class="login-password" required placeholder="Contraseña" />
            <input type="submit" name="verificar" value="Aceptar" class="login-submit" />
        </form>
        -->

        <div class="container">
            <div
                class="row justify-content-center align-items-center"
                style="height: 100vh"
                >
                <div class="col-12 col-md-9 col-lg-6">
                    <!-- Responsive column sizes -->
                    <div class="d-flex align-items-center" style="height: 100%">
                        <div class="hello">

                            <p class="logo">
                                <i class="bx bxl-gitlab" style="color: #ffffff;font-size: 100px;"></i>
                            </p>

                        </div>
                        <!-- Contenedor "Hello!" -->
                        <div class="card border-0 flex-grow-1">
                            <!-- Tarjeta del formulario -->
                            <div class="card-body border_estilos">
                                <form action="ControlerUsuario?accion=verificar" method="post" >
                                    <p>Ingresar a su cuenta</p>
                                    <div class="mb-3">
                                        <input
                                            type="text"
                                            class="form-control"
                                            id="username"
                                            name="txtUsu"
                                            placeholder="Correo Electrónico"
                                            required
                                            />
                                    </div>
                                    <div class="mb-3 input-container">
                                        <input
                                            type="password"
                                            class="form-control"
                                            id="password"
                                            name="txtPass"
                                            placeholder="Contraseña"
                                            required
                                            />

                                        <i
                                            class="fas fa-eye toggle-password"
                                            id="togglePassword"
                                            ></i>
                                    </div>


                                    <button class="btn-neon w-100" type="submit" name="validar"  value="Aceptar"  >
                                        <span id="span1"></span>
                                        <span id="span2"></span>
                                        <span id="span3"></span>
                                        <span id="span4"></span>
                                        Entrar
                                    </button>
                                </form>

                                <%-- mensaje de error de credenciales --%>
                                <c:if test="${not empty msje}">
                                    <div style="color: red; font-weight: normal;">
                                        ${msje}
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            const togglePassword = document.getElementById("togglePassword");
            const passwordInput = document.getElementById("password");

            togglePassword.addEventListener("click", function () {
                // Cambia el tipo del input entre 'password' y 'text'
                const type =
                        passwordInput.getAttribute("type") === "password"
                        ? "text"
                        : "password";
                passwordInput.setAttribute("type", type);

                // Cambia el ícono del ojo
                this.classList.toggle("fa-eye-slash");
                this.classList.toggle("fa-eye");
            });
        </script>

        <script>
            window.addEventListener("load", function () {
                document.title = "Login";
            });
        </script>

    </body>
</html>
