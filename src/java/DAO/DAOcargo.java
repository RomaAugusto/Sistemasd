package DAO;

import conexion.conexionBD;
import Entidades.Cargo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DAOcargo extends conexionBD {

    public List<Cargo> listarCargos() {
        List<Cargo> cargos = new ArrayList<>();
        try (Connection con = Connected();
             PreparedStatement ps = con.prepareStatement("SELECT C.IDCARGO, C.NOMBRECARGO, C.ESTADO FROM cargo C ORDER BY C.IDCARGO");
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Cargo car = new Cargo();
                car.setCodigo(rs.getInt("IDCARGO"));
                car.setNombreCargo(rs.getString("NOMBRECARGO"));
                car.setEstado(rs.getBoolean("ESTADO"));
                cargos.add(car);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cargos;
    }
}
