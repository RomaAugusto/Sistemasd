/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controler;

//import Entidades.usuarios;
import DAO.DAOusuario;
import Entidades.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author javie
 */
@WebServlet(name = "ValidarLogin", urlPatterns = {"/ValidarLogin"})
public class ValidarLogin extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//       response.setContentType("text/html;charset=UTF-8");
//       String user, pass;
//       user = request.getParameter("txtUsuario");
//       pass= request.getParameter("txtClave");
//       //user=admin, clave=1234
//       if(user.equals("admin")&&pass.equals("1234")){
//          // usuarios nuser=new usuarios(user,pass);
//           HttpSession session = request.getSession();
//           //session.setAttribute("user", nuser);
//           request.getRequestDispatcher("index.jsp").forward(request, response);
//       }
//       else{
//           request.getRequestDispatcher("ErrorLogin").forward(request, response);
//       }
    }

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        String nombreUsuario = request.getParameter("nombreUsuario");
//        String clave = request.getParameter("clave");
//
//        UsuarioDAO usuarioDAO = new UsuarioDAO();
//        Usuario usuario = usuarioDAO.obtenerUsuarioPorNombreClave(nombreUsuario, clave);
//
//        if (usuario != null) {
//            HttpSession session = request.getSession();
//            session.setAttribute("usuario", usuario);
//            if (usuario.getIdCargo() == 1) { // Suponiendo que 1 es el ID del cargo de administrador
//                response.sendRedirect("index.jsp");
//            } else {
//                response.sendRedirect("indexEmpleado.jsp");
//            }
//        } else {
//            response.sendRedirect("login.jsp?error=true");
//        }
    
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
