package Controler;

import DAO.DAOcargo;
import DAO.DAOusuario;
import Entidades.Cargo;
import Entidades.Usuario;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ControlerUsuario", urlPatterns = {"/ControlerUsuario"})
public class ControlerUsuario extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String accion = request.getParameter("accion");

        try {
            if (accion != null) {
                switch (accion) {
                    case "verificar":
                        verificar(request, response);
                        break;
                    case "cerrar":
                        cerrarsession(request, response);
                        break;
                    case "listarUsuarios":
                        listarUsuarios(request, response);
                        break;
                    case "nuevo":
                        presentarFormulario(request, response);
                        break;
                    case "registrar":
                        registrarUsuario(request, response);
                        break;
                    case "leerUsuario":
                        presentarUsuario(request, response);
                        break;
                    case "actualizarUsuario":
                        actualizarUsuario(request, response);
                        break;
                    case "eliminarUsuario":
                        eliminarUsuario(request, response);
                        break;
                    default:
                        response.sendRedirect("login.jsp");
                }
            } else if (request.getParameter("cambiar") != null) {
                cambiarEstado(request, response);
            } else {
                response.sendRedirect("login.jsp");
            }
        } catch (Exception e) {
            request.setAttribute("msje", "Error: " + e.getMessage());
            request.getRequestDispatcher("mensaje.jsp").forward(request, response);
        }
    }
    public static Usuario USUARIO;

    private void verificar(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession sesion;
        DAOusuario dao = new DAOusuario();
//        Usuario USUARIO = this.obtenerUsuario(request);
        USUARIO = this.obtenerUsuario(request);
        USUARIO = dao.identificar(USUARIO);
        if (USUARIO != null) {
            if (USUARIO.getCargo().getNombreCargo().equals("ADMINISTRADOR")) {
                sesion = request.getSession();
                sesion.setAttribute("usuario", USUARIO);
                response.sendRedirect("index.jsp");    
            } else if (USUARIO.getCargo().getNombreCargo().equals("VENDEDOR")) {
                sesion = request.getSession();
                sesion.setAttribute("vendedor", USUARIO);
                response.sendRedirect("index.jsp");
            } else {
                request.setAttribute("msje", "Credenciales Incorrectas");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("msje", "Credenciales Incorrectas");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private void cerrarsession(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession sesion = request.getSession();
        sesion.removeAttribute("usuario");
        sesion.invalidate();
        response.sendRedirect("login.jsp");
    }

    private Usuario obtenerUsuario(HttpServletRequest request) {
        Usuario u = new Usuario();
        u.setNombreUsuario(request.getParameter("txtUsu"));
        u.setClave(request.getParameter("txtPass"));
        return u;
    }

    private void listarUsuarios(HttpServletRequest request, HttpServletResponse response) {
        DAOusuario dao = new DAOusuario();
        List<Usuario> usus = null;
        try {
            usus = dao.listarUsuarios();
            request.setAttribute("usuarios", usus);
            // Redirigir a la página listarUsuarios.jsp después de cargar la lista
            request.getRequestDispatcher("listarUsuarios.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("msje", "No se pudo listar los usuarios" + e.getMessage());
            // Manejo de errores si no se puede cargar la lista
            try {
                request.getRequestDispatcher("listarUsuarios.jsp").forward(request, response);
            } catch (ServletException | IOException ex) {
                ex.printStackTrace();
            }
        } finally {
            dao = null;
        }
    }

    private void presentarFormulario(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        cargarCargos(request);
        request.getRequestDispatcher("nuevoUsuario.jsp").forward(request, response);
    }

    private void cargarCargos(HttpServletRequest request) {
        DAOcargo dao = new DAOcargo();
        List<Cargo> car;

        try {
            car = dao.listarCargos();
            request.setAttribute("cargos", car);
        } catch (Exception e) {
            request.setAttribute("msje", "No se pudo cargar los cargos: " + e.getMessage());
        }
    }

    private void registrarUsuario(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOusuario daoUsu;
        Usuario usu = null;
        Cargo carg;
        if (request.getParameter("txtNombre") != null
                && request.getParameter("txtClave") != null
                && request.getParameter("cboCargo") != null) {

            usu = new Usuario();
            usu.setNombreUsuario(request.getParameter("txtNombre"));
            usu.setClave(request.getParameter("txtClave"));
            carg = new Cargo();
            carg.setCodigo(Integer.parseInt(request.getParameter("cboCargo")));
            usu.setCargo(carg);
            if (request.getParameter("chkEstado") != null) {
                usu.setEstado(true);
            } else {
                usu.setEstado(false);
            }
            daoUsu = new DAOusuario();
            try {
                daoUsu.registrarUsuarios(usu);

                // Después de registrar, cargar nuevamente la lista de usuarios y redireccionar
                listarUsuarios(request, response);
            } catch (Exception e) {
                request.setAttribute("msje",
                        "No se pudo registrar el usuario" + e.getMessage());
                request.setAttribute("usuario", usu);
                this.presentarFormulario(request, response);
            }
        }
    }

    private void presentarUsuario(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int usuarioId = Integer.parseInt(request.getParameter("cod"));
        DAOusuario dao = new DAOusuario();

        try {
            Usuario usus = dao.leerUsuario(usuarioId);
            if (usus != null) {
                request.setAttribute("usuario", usus);
                cargarCargos(request);
                request.getRequestDispatcher("modificarUsuario.jsp").forward(request, response);
            } else {
                request.setAttribute("msje", "No se encontró el usuario");
                listarUsuarios(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("msje", "No se pudo acceder a la base de datos: " + e.getMessage());
            listarUsuarios(request, response);
        }
    }

    private void actualizarUsuario(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Usuario usus = new Usuario();
        usus.setId_usuario(Integer.parseInt(request.getParameter("hCodigo")));
        usus.setNombreUsuario(request.getParameter("txtNombre"));
        usus.setClave(request.getParameter("txtClave"));

        Cargo car = new Cargo();
        car.setCodigo(Integer.parseInt(request.getParameter("cboCargo")));
        usus.setCargo(car);

        if (request.getParameter("chkEstado") != null) {
            usus.setEstado(true);
        } else {
            usus.setEstado(false);
        }

        DAOusuario daoUsu = new DAOusuario();
        try {
            daoUsu.actualizarUsuarios(usus);
            response.sendRedirect("ControlerUsuario?accion=listarUsuarios");
        } catch (Exception e) {
            request.setAttribute("msje", "No se pudo actualizar el usuario: " + e.getMessage());
            presentarUsuario(request, response);
        }
    }

    private void eliminarUsuario(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int usuarioId = Integer.parseInt(request.getParameter("cod"));
        DAOusuario dao = new DAOusuario();

        try {
            dao.eliminarUsuario(usuarioId);
            response.sendRedirect("ControlerUsuario?accion=listarUsuarios");
        } catch (Exception e) {
            request.setAttribute("msje", "No se pudo acceder a la base de datos: " + e.getMessage());
            listarUsuarios(request, response);
        }
    }

    private void cambiarEstado(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOusuario dao;
        Usuario usu;
        try {
            dao = new DAOusuario();
            usu = new Usuario();

            if (request.getParameter("cambiar").equals("activar")) {
                usu.setEstado(true);
            } else {
                usu.setEstado(false);
            }

            if (request.getParameter("cod") != null) {
                usu.setId_usuario(Integer.parseInt(request.getParameter("cod")));
                dao.cambiarVigencia(usu);
            } else {
                request.setAttribute("msje", "No se obtuvo el id del usuario");
            }

        } catch (Exception e) {
            request.setAttribute("msje", e.getMessage());
        }
        this.listarUsuarios(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
