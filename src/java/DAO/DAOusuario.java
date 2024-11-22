package DAO;

import Entidades.Cargo;
import Entidades.Usuario;
import conexion.conexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DAOusuario {

    private conexionBD conexion;

    public DAOusuario() {
        conexion = new conexionBD();
    }

    public Usuario identificar(Usuario user) {
        Usuario usu = null;
        try (Connection con = conexion.Connected();
             PreparedStatement ps = con.prepareStatement("SELECT U.IDUSUARIO, C.NOMBRECARGO FROM usuario U "
                     + "INNER JOIN cargo C ON U.IDCARGO = C.IDCARGO "
                     + "WHERE U.ESTADO = 1 AND U.NOMBREUSUARIO = ? AND U.CLAVE = ?")) {

            ps.setString(1, user.getNombreUsuario());
            ps.setString(2, user.getClave());

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    usu = new Usuario();
                    usu.setId_usuario(rs.getInt("IDUSUARIO"));
                    usu.setNombreUsuario(user.getNombreUsuario());
                    usu.setCargo(new Cargo());
                    usu.getCargo().setNombreCargo(rs.getString("NOMBRECARGO"));
                    usu.setEstado(true);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usu;
    }

    public List<Usuario> listarUsuarios() {
        List<Usuario> usuarios = new ArrayList<>();
        try (Connection con = conexion.Connected();
             PreparedStatement ps = con.prepareStatement("SELECT U.IDUSUARIO, U.NOMBREUSUARIO, U.CLAVE, U.ESTADO, C.NOMBRECARGO "
                     + "FROM usuario U INNER JOIN cargo C ON C.IDCARGO = U.IDCARGO "
                     + "ORDER BY U.IDUSUARIO");
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Usuario usu = new Usuario();
                usu.setId_usuario(rs.getInt("IDUSUARIO"));
                usu.setNombreUsuario(rs.getString("NOMBREUSUARIO"));
                usu.setClave(rs.getString("CLAVE"));
                usu.setEstado(rs.getBoolean("ESTADO"));
                usu.setCargo(new Cargo());
                usu.getCargo().setNombreCargo(rs.getString("NOMBRECARGO"));
                usuarios.add(usu);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usuarios;
    }

    public void registrarUsuarios(Usuario usu) {
        try (Connection con = conexion.Connected();
             PreparedStatement ps = con.prepareStatement("INSERT INTO usuario (NOMBREUSUARIO, CLAVE, ESTADO, IDCARGO) VALUES (?, ?, ?, ?)")) {

            ps.setString(1, usu.getNombreUsuario());
            ps.setString(2, usu.getClave());
            ps.setBoolean(3, usu.isEstado());
            ps.setInt(4, usu.getCargo().getCodigo());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Usuario leerUsuario(int usuarioId) {
        Usuario usus = null;
        try (Connection con = conexion.Connected();
             PreparedStatement ps = con.prepareStatement("SELECT U.IDUSUARIO, U.NOMBREUSUARIO, U.CLAVE, U.ESTADO, U.IDCARGO "
                     + "FROM usuario U WHERE U.IDUSUARIO = ?")) {

            ps.setInt(1, usuarioId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    usus = new Usuario();
                    usus.setId_usuario(rs.getInt("IDUSUARIO"));
                    usus.setNombreUsuario(rs.getString("NOMBREUSUARIO"));
                    usus.setClave(rs.getString("CLAVE"));
                    usus.setEstado(rs.getBoolean("ESTADO"));
                    usus.setCargo(new Cargo());
                    usus.getCargo().setCodigo(rs.getInt("IDCARGO"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usus;
    }

    public void actualizarUsuarios(Usuario usu) {
        try (Connection con = conexion.Connected();
             PreparedStatement ps = con.prepareStatement("UPDATE usuario SET NOMBREUSUARIO = ?, CLAVE = ?, ESTADO = ?, IDCARGO = ? WHERE IDUSUARIO = ?")) {

            ps.setString(1, usu.getNombreUsuario());
            ps.setString(2, usu.getClave());
            ps.setBoolean(3, usu.isEstado());
            ps.setInt(4, usu.getCargo().getCodigo());
            ps.setInt(5, usu.getId_usuario());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void eliminarUsuario(int usuarioId) {
        try (Connection con = conexion.Connected();
             PreparedStatement ps = con.prepareStatement("DELETE FROM usuario WHERE IDUSUARIO = ?")) {

            ps.setInt(1, usuarioId);

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void cambiarVigencia(Usuario usus) {
        try (Connection con = conexion.Connected();
             PreparedStatement ps = con.prepareStatement("UPDATE usuario SET estado = ? WHERE idusuario = ?")) {

            ps.setBoolean(1, usus.isEstado());
            ps.setInt(2, usus.getId_usuario());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
