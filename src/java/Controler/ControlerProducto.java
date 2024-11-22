package Controler;

import Entidades.Usuario;
import Entidades.producto;
import conexion.conexionBD;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ControlerProducto", urlPatterns = {"/ControlerProducto"})
public class ControlerProducto extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario user = (Usuario) session.getAttribute("usuario");
        if (user == null) {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
        String Op = request.getParameter("Op");
        ArrayList<producto> Lista = new ArrayList<producto>();
        conexionBD conBD = new conexionBD();
        Connection conn = conBD.Connected();
        PreparedStatement ps;
        ResultSet rs;
        switch (Op) {
            case "Listar":
                try {
                    String sql = "SELECT * FROM t_producto";
                    ps = conn.prepareStatement(sql);
                    rs = ps.executeQuery();
                    while (rs.next()) {
                        producto pro = new producto();
                        pro.setId(rs.getString("Id_Prod"));
                        pro.setDescripcion(rs.getString("Descripcion"));
                        pro.setCosto(rs.getDouble("costo"));
                        pro.setPrecio(rs.getDouble("precio"));
                        pro.setUnidadMedida(rs.getString("unidad"));
                        pro.setCantidad(rs.getDouble("cantidad"));
                        Lista.add(pro);
                    }
                    request.setAttribute("Lista", Lista);
                    request.getRequestDispatcher("listarProductos.jsp").forward(request, response);
                } catch (SQLException ex) {
                    System.out.println("Error de SQL..." + ex.getMessage());
                } finally {
                    conBD.Discconet();
                }
                break;
            case "Consultar":
                try {
                    String Id = request.getParameter("Id");
                    String sql = "select * from t_producto where Id_Prod=?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, Id);
                    rs = ps.executeQuery();
                    producto pro = new producto();
                    while (rs.next()) {
                        pro.setId(rs.getString("Id_Prod"));
                        pro.setDescripcion(rs.getString("Descripcion"));
                        pro.setCosto(rs.getFloat("costo"));
                        pro.setPrecio(rs.getFloat("precio"));
                        pro.setCantidad(rs.getFloat("cantidad"));
                        pro.setUnidadMedida(rs.getString("unidad"));
                        Lista.add(pro);
                    }
                    request.setAttribute("Lista", Lista);
                    request.getRequestDispatcher("consultarProductos.jsp").forward(request, response);
                } catch (SQLException ex) {
                    System.out.println("Error de SQL..." + ex.getMessage());
                } finally {
                    conBD.Discconet();
                }
                break;
            case "Modificar":
                try {
                    String Id = request.getParameter("Id");
                    String sql = "select * from t_producto where Id_Prod=?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, Id);
                    rs = ps.executeQuery();
                    producto pro = new producto();
                    while (rs.next()) {
                        pro.setId(rs.getString("Id_Prod"));
                        pro.setDescripcion(rs.getString("Descripcion"));
                        pro.setCosto(rs.getDouble("costo"));
                        pro.setPrecio(rs.getDouble("precio"));
                        pro.setCantidad(rs.getDouble("cantidad"));
                        pro.setUnidadMedida(rs.getString("unidad"));
                        Lista.add(pro);
                    }
                    request.setAttribute("Lista", Lista);
                    request.getRequestDispatcher("modificarProductos.jsp").forward(request, response);
                } catch (SQLException ex) {
                    System.out.println("Error de SQL..." + ex.getMessage());
                } finally {
                    conBD.Discconet();
                }

                break;
            case "Eliminar":
                try {
                    String Id = request.getParameter("Id");
                    String sql = "delete from t_producto where Id_Prod=?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, Id);
                    ps.executeUpdate();
                    /*request.getRequestDispatcher("Productos.jsp").forward(request, response);*/
                    response.sendRedirect("/TiendaDonPepe/ControlerProducto?Op=Listar");
                } catch (SQLException ex) {
                    System.out.println("Error de SQL..." + ex.getMessage());
                } finally {
                    conBD.Discconet();
                }
                break;
            case "Nuevo":
                request.getRequestDispatcher("nuevoProducto.jsp").forward(request, response);

                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        String Id = request.getParameter("Id");
        String Descripcion = request.getParameter("Descripcion");
        String UnidadMedida = request.getParameter("unidad");

        float Costo = 0, Precio = 0, Cantidad = 0;
        try {
            Costo = Float.parseFloat(request.getParameter("costo"));
            Precio = Float.parseFloat(request.getParameter("precio"));
            Cantidad = Float.parseFloat(request.getParameter("cantidad"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Costo, Precio y Cantidad deben ser números válidos.");
            return;
        }

        producto pro = new producto();

        pro.setId(Id);
        pro.setDescripcion(Descripcion);
        pro.setUnidadMedida(UnidadMedida);
        pro.setCosto(Costo);
        pro.setPrecio(Precio);
        pro.setCantidad(Cantidad);

        conexionBD conBD = new conexionBD();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        //System.out.println("Error actualizando tabla..." + ex.getMessage());
        try {
            conn = conBD.Connected();

            if (Id.isEmpty()) {
                // Insertar un nuevo producto
                String sql_new = "select max(Id_Prod) Id_Prod from t_producto";
                String sql_insert = "insert into t_producto(Id_Prod, Descripcion, unidad, costo, precio, cantidad) values(?, ?, ?, ?, ?, ?)";

                String Id_Prod = "";
                ps = conn.prepareStatement(sql_new);
                rs = ps.executeQuery();
                if (rs.next()) {
                    Id_Prod = rs.getString("Id_Prod");
                }
                Id_Prod = newCod(Id_Prod);

                rs.close();
                ps.close();

                ps = conn.prepareStatement(sql_insert);
                ps.setString(1, Id_Prod);
                ps.setString(2, pro.getDescripcion());
                ps.setString(3, pro.getUnidadMedida());
                ps.setDouble(4, pro.getCosto());
                ps.setDouble(5, pro.getPrecio());
                ps.setDouble(6, pro.getCantidad());
                ps.executeUpdate();
            } else {
                // Actualizar un producto existente
                String sql_update = "update t_producto set Descripcion=?, unidad=?, costo=?, precio=?, cantidad=? where Id_Prod=?";
                ps = conn.prepareStatement(sql_update);
                ps.setString(1, pro.getDescripcion());
                ps.setString(2, pro.getUnidadMedida());
                ps.setDouble(3, pro.getCosto());
                ps.setDouble(4, pro.getPrecio());
                ps.setDouble(5, pro.getCantidad());
                ps.setString(6, pro.getId());
                ps.executeUpdate();
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage() + "Error actualizando tabla...");
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        /* response.sendRedirect("listarProductos.jsp");*/
        response.sendRedirect("/TiendaDonPepe/ControlerProducto?Op=Listar");

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private String newCod(String pCodigo) {

        if (pCodigo == null) {
            pCodigo = "P00000"; // Asignar un valor predeterminado si pCodigo es null
        } else {
            int Numero = Integer.parseInt(pCodigo.substring(2)); // Comenzar en el índice 1
            Numero = Numero + 1;
            pCodigo = 'P' + String.format("%05d", Numero); // Formatear el número con 5 dígitos
        }
        return pCodigo;
    }

}
