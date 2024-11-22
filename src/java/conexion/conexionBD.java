package conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class conexionBD {

    /*
    static String driver = "com.mysql.jdbc.Driver";
    static String url = "jdbc:mysql://db-mysql-nyc3-30524-do-user-17020338-0.a.db.ondigitalocean.com:25060/defaultdb";
    static String user = "doadmin";
    static String pass = "AVNS_6cBv0GiVieHIL685r-F";
     */
    static String driver = "com.mysql.cj.jdbc.Driver";
    static String url = "jdbc:mysql://localhost:3306/final";
    static String user = "root";
    static String pass = "";

    protected Connection conn = null;

    public conexionBD() {
        try {
            Class.forName(driver);
            conn = (Connection) DriverManager.getConnection(url, user, pass);
            if (conn != null) {
                System.out.println("Conexión realizada..." + conn);
            }
        } catch (SQLException ex) {
            System.out.println("Conexión fallida..." + ex.getMessage());
        } catch (ClassNotFoundException ex) {
            System.out.println("Falta Driver " + ex.getMessage());
        }
    }

    public Connection Connected() {
        return conn;
    }

    public Connection Discconet() {
        try {
            conn.close();
        } catch (SQLException ex) {
            System.out.println("Error de desconexión.. " + ex.getMessage());
        }
        return null;
    }

}
