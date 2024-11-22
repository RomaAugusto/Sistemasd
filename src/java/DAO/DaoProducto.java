package DAO;

import Entidades.producto;
import conexion.conexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DaoProducto {

    conexionBD conBD = new conexionBD();
    Connection con = conBD.Connected();
    PreparedStatement psPedido = null;
    PreparedStatement psDetalle = null;
    PreparedStatement psCodigo = null;
    PreparedStatement ps;
    ResultSet rs = null;
    int r;

    public producto buscar(int id) {
        producto p = new producto();
        String sql = "select * from t_producto where Id_Prod=" + id;
        try {
            con = conBD.Connected();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                p.setId(rs.getString(1));
                p.setDescripcion(rs.getString(2));
                p.setCosto(rs.getDouble(3));
                p.setPrecio(rs.getInt(4));
                p.setCantidad(rs.getDouble(5));
            }
        } catch (SQLException e) {
        }
        return p;
    }

    public void actualizarstock(String idProducto, double cantidad) throws SQLException {
        conexionBD conBD = new conexionBD();
        Connection conn = conBD.Connected();
        PreparedStatement ps = null;

        try {
            String sql = "UPDATE t_producto SET cantidad = cantidad - ? WHERE Id_Prod = ?";
            ps = conn.prepareStatement(sql);
            ps.setDouble(1, cantidad);
            ps.setString(2, idProducto);
            ps.executeUpdate();
        } finally {
            if (ps != null) {
                ps.close();
            }
            conBD.Discconet();
        }
    }

}
