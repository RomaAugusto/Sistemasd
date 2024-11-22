package Controler;

import Entidades.detallePedido;
import Entidades.pedido;
import Entidades.producto;
import Entidades.cliente;
import boleta.AddressDetails;
import boleta.HeaderDetails;
import boleta.PdfInvoiceCreator;
import boleta.Product;
import boleta.ProductTableHeader;
import conexion.conexionBD;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ControlerPedido", urlPatterns = {"/ControlerPedido"})
public class ControlerPedido extends HttpServlet {

    List<detallePedido> lista = new ArrayList<>();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String Op = request.getParameter("Op");
        ArrayList<pedido> Lista = new ArrayList<>();
        ArrayList<detallePedido> ListaDet = new ArrayList<>();
        ArrayList<producto> ListaPro = new ArrayList<>();
        ArrayList<cliente> ListaClientes = new ArrayList<>();

        conexionBD conBD = new conexionBD();
        Connection conn = conBD.Connected();
        PreparedStatement ps;
        ResultSet rs;
        switch (Op) {
            case "Listar":
                try {
                    String sql = "SELECT Id_Pedido, A.Id_Cliente, B.Apellidos, B.Nombres, A.Fecha,"
                            + "A.SubTotal, A.TotalVenta FROM t_pedido A inner join t_cliente B on A.Id_Cliente=B.Id_Cliente";
                    ps = conn.prepareStatement(sql);
                    rs = ps.executeQuery();
                    while (rs.next()) {
                        pedido Pedido = new pedido();
                        Pedido.setId_Pedido(rs.getString(1));
                        Pedido.setId_Cliente(rs.getString(2));
                        Pedido.setApellidos(rs.getString(3));
                        Pedido.setNombres(rs.getString(4));
                        Pedido.setFecha(rs.getDate(5));
                        Pedido.setSubTotal(rs.getDouble(6));
                        Pedido.setTotalVenta(rs.getDouble(7));
                        Lista.add(Pedido);
                    }
                    request.setAttribute("Lista", Lista);
                    request.getRequestDispatcher("listarPedido.jsp").forward(request, response);
                } catch (SQLException ex) {
                    System.out.println("Error de SQL..." + ex.getMessage());
                } finally {
                    conBD.Discconet();
                }
                break;
            case "Consultar":
                try {
                    String Id = request.getParameter("Id");
                    String sql = "SELECT Id_Pedido,A.Id_Prod,Descripcion,unidad, A.Cantidad, A.Precio, TotalDeta "
                            + "FROM t_detalle_pedido A inner join t_producto B on A.Id_Prod=B.Id_Prod "
                            + "WHERE Id_Pedido=?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, Id);
                    rs = ps.executeQuery();

                    while (rs.next()) {
                        detallePedido DetaPed = new detallePedido();
                        DetaPed.setId_Pedido(rs.getString(1));
                        DetaPed.setId_Prod(rs.getString(2));
                        DetaPed.setDescripcion(rs.getString(3));
                        DetaPed.setUnidadMedida(rs.getString(4));
                        DetaPed.setCantidad(rs.getDouble(5));
                        DetaPed.setPrecio(rs.getDouble(6));
                        DetaPed.setTotalDeta(rs.getDouble(7));
                        ListaDet.add(DetaPed);
                    }
                    request.setAttribute("Lista", ListaDet);
                    request.getRequestDispatcher("consultarPedido.jsp").forward(request, response);
                } catch (SQLException ex) {
                    System.out.println("Error de SQL..." + ex.getMessage());
                } finally {
                    conBD.Discconet();
                }
                break;

            case "Eliminar":
                try {
                    String idPedido = request.getParameter("Id");
                    eliminarPedido(idPedido);
                    response.sendRedirect("ControlerPedido?Op=Listar");
                } catch (SQLException ex) {
                    System.out.println("Error de SQL..." + ex.getMessage());
                }
                break;

            case "Nuevo":
                try {
                    String sql = "SELECT Id_Prod, Descripcion, unidad, precio, cantidad FROM t_producto";
                    ps = conn.prepareStatement(sql);
                    rs = ps.executeQuery();
                    while (rs.next()) {
                        producto Prod = new producto();
                        Prod.setId(rs.getString(1));
                        Prod.setDescripcion(rs.getString(2));
                        Prod.setUnidadMedida(rs.getString(3));
                        Prod.setPrecio(rs.getDouble(4));
                        Prod.setCantidad(rs.getDouble(5));
                        ListaPro.add(Prod);
                    }

                    String sqlClientes = "SELECT Id_Cliente, nombres, apellidos FROM t_cliente";
                    ps = conn.prepareStatement(sqlClientes);
                    rs = ps.executeQuery();
                    while (rs.next()) {
                        cliente client = new cliente();
                        client.setId(rs.getString(1));
                        client.setNombres(rs.getString(2));
                        client.setApellidos(rs.getString(3));
                        ListaClientes.add(client);
                    }

                    request.setAttribute("Lista", ListaPro);
                    request.setAttribute("ListaClientes", ListaClientes);
                    request.getRequestDispatcher("nuevoPedido.jsp").forward(request, response);
                } catch (SQLException ex) {
                    System.out.println("Error de SQL..." + ex.getMessage());
                } finally {
                    conBD.Discconet();
                }
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<detallePedido> detalles = new ArrayList<>();
        conexionBD conBD = new conexionBD();
        Connection conn = conBD.Connected();
        PreparedStatement psPedido = null;
        PreparedStatement psDetalle = null;
        PreparedStatement psCodigo = null;
        PreparedStatement psUpdateStock = null;
        ResultSet rs = null;

        final String[] pedidoCod = {"P0001"};

        String idCliente = request.getParameter("Id");
        String fecha = request.getParameter("descripcion");
        double subtotal = Double.parseDouble(request.getParameter("subtotal"));
        double total = Double.parseDouble(request.getParameter("total"));

        try {
            String sqlCodigo = "SELECT Id_Pedido FROM t_pedido order by Id_Pedido DESC LIMIT 1";
            psCodigo = conn.prepareStatement(sqlCodigo);
            rs = psCodigo.executeQuery();

            if (rs.next()) {
                String idPedido = rs.getString("Id_Pedido");
                String prefix = idPedido.substring(0, 1);
                String numberPart = idPedido.substring(1);

                int number = Integer.parseInt(numberPart);
                number++;

                String newIdPedido = prefix + String.format("%04d", number);

                pedidoCod[0] = newIdPedido;
            }

            String subtotalStr = request.getParameter("subtotal");
            String totalStr = request.getParameter("total");
            if (subtotalStr != null && !subtotalStr.isEmpty()) {
                subtotal = Double.parseDouble(subtotalStr.trim());
            }
            if (totalStr != null && !totalStr.isEmpty()) {
                total = Double.parseDouble(totalStr.trim());
            }

            request.getParameterMap().forEach((key, value) -> {
                if (key.startsWith("cantidad_")) {
                    String idProducto = key.substring(9);
                    try {
                        String cantidadStr = request.getParameter("cantidad_" + idProducto);
                        String precioStr = request.getParameter("precio_" + idProducto);

                        if (cantidadStr != null && !cantidadStr.isEmpty()) {
                            double cantidad = Double.parseDouble(cantidadStr.trim());
                            double precio = Double.parseDouble(precioStr.trim());

                            if (cantidad > 0) {
                                detallePedido detalle = new detallePedido();
                                detalle.setId_Pedido(pedidoCod[0]);
                                detalle.setId_Prod(idProducto);
                                detalle.setCantidad(cantidad);
                                detalle.setPrecio(precio);
                                detalle.setTotalDeta(cantidad * precio);
                                detalles.add(detalle);
                            }
                        }
                    } catch (NumberFormatException e) {
                        System.out.println("Error: " + e.getMessage());
                    }
                }
            });

            conn.setAutoCommit(false);

            String sqlPedido = "INSERT INTO t_pedido (Id_Pedido, Id_Cliente, Fecha, SubTotal, TotalVenta) VALUES (?, ?, ?, ?, ?)";
            psPedido = conn.prepareStatement(sqlPedido);
            psPedido.setString(1, pedidoCod[0]);
            psPedido.setString(2, idCliente);
            psPedido.setString(3, fecha);
            psPedido.setDouble(4, subtotal);
            psPedido.setDouble(5, total);
            psPedido.executeUpdate();

            String sqlDetalle = "INSERT INTO t_detalle_pedido (Id_Pedido, Id_Prod, cantidad, precio, TotalDeta) VALUES (?, ?, ?, ?, ?)";
            psDetalle = conn.prepareStatement(sqlDetalle);

            String sqlUpdateStock = "UPDATE t_producto SET cantidad = cantidad - ? WHERE Id_Prod = ?";
            psUpdateStock = conn.prepareStatement(sqlUpdateStock);

            for (detallePedido detalle : detalles) {
                psDetalle.setString(1, detalle.getId_Pedido());
                psDetalle.setString(2, detalle.getId_Prod());
                psDetalle.setDouble(3, detalle.getCantidad());
                psDetalle.setDouble(4, detalle.getPrecio());
                psDetalle.setDouble(5, detalle.getTotalDeta());
                psDetalle.addBatch();

                // Actualiza el stock del producto
                psUpdateStock.setDouble(1, detalle.getCantidad());
                psUpdateStock.setString(2, detalle.getId_Prod());
                psUpdateStock.addBatch();
            }

            psDetalle.executeBatch();
            psUpdateStock.executeBatch();

            conn.commit();
            // Llamar al método para obtener el archivo PDF
            File pdfFile = archivoDescargar(idCliente, pedidoCod[0], detalles, fecha);

            if (pdfFile != null) {
                // Configurar la respuesta HTTP para descargar el archivo
                response.setContentType("application/pdf");
                response.setHeader("Content-Disposition", "attachment; filename=\"" + pdfFile.getName() + "\"");

                // Abrir el archivo y escribir su contenido al flujo de salida de la respuesta
                try (InputStream fileInputStream = new FileInputStream(pdfFile)) {
                    ServletOutputStream outputStream = response.getOutputStream();
                    byte[] buffer = new byte[4096];
                    int bytesRead = -1;
                    while ((bytesRead = fileInputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                    }

                } catch (IOException e) {
                    System.out.println("Error al leer el archivo PDF: " + e.getMessage());
                }
            } else {
                // Manejar caso donde no se puede generar el archivo PDF
                response.getWriter().println("Error: No se pudo generar el archivo PDF.");
                return; // Terminar la ejecución del método si no hay archivo para descargar
            }
//            response.sendRedirect("nuevoPedido.jsp");

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    System.out.println("Error: " + ex.getMessage());
                }
            }
            System.out.println("Error: " + e.getMessage());
            response.sendRedirect("pedidoError.jsp");

        } finally {
            try {
                if (psPedido != null) {
                    psPedido.close();
                }
                if (psDetalle != null) {
                    psDetalle.close();
                }
                if (psUpdateStock != null) {
                    psUpdateStock.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                System.out.println("Error: " + e.getMessage());
            }
        }
    }

    private void eliminarPedido(String idPedido) throws SQLException {
        conexionBD conBD = new conexionBD();
        Connection conn = conBD.Connected();
        PreparedStatement psPedido = null;
        PreparedStatement psDetalle = null;

        try {
            conn.setAutoCommit(false);

            String sqlDetalle = "DELETE FROM t_detalle_pedido WHERE Id_Pedido = ?";
            psDetalle = conn.prepareStatement(sqlDetalle);
            psDetalle.setString(1, idPedido);
            psDetalle.executeUpdate();

            String sqlPedido = "DELETE FROM t_pedido WHERE Id_Pedido = ?";
            psPedido = conn.prepareStatement(sqlPedido);
            psPedido.setString(1, idPedido);
            psPedido.executeUpdate();

            conn.commit();

        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (psPedido != null) {
                psPedido.close();
            }
            if (psDetalle != null) {
                psDetalle.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }

    public File archivoDescargar(String idCliente, String idPedido, ArrayList<detallePedido> detalles, String fecha) {
        try {
            LocalDate ld = LocalDate.now();
            String pdfName = idPedido + ".pdf";
            PdfInvoiceCreator cepdf = new PdfInvoiceCreator(pdfName);
            HeaderDetails header = new HeaderDetails();
            header.setInvoiceTitle("TIENDITA DON PEPE");
//            header.setInvoiceNo(idPedido).setInvoiceDate(LocalDate.now().format(DateTimeFormatter.ofPattern("dd-MM-yyyy"))).build();
            header.setInvoiceNo(fecha).build();

            AddressDetails addressDetails = new AddressDetails();
            addressDetails
                    .setBillingCompany("Tiendita don PEPE")
                    .setBillingName(ControlerUsuario.USUARIO.getNombreUsuario() + " - " + ControlerUsuario.USUARIO.getId_usuario())
                    .setBillingAddress("Mz ww lt 21 Los Olivos")
                    .setBillingEmail("tienditadonpepe@gmail.com")
                    .setShippingName(idCliente + "\n")
                    .setShippingAddress(idCliente + "@gmail.com")
                    .build();

            ProductTableHeader productTableHeader = new ProductTableHeader();
            List<Product> productList = getListaProductos(detalles);
            productList = cepdf.modifyProductList(productList);

            List<String> TncList = new ArrayList<>();
            TncList.add("- Nos esforzamos por ofrecer alimentos frescos y de alta calidad. Si hay algún problema con la calidad de la comida, por favor, informe al personal de inmediato para que podamos abordar la situación.");
            String imagePath = "";

            File pdfFile = cepdf.generatePdfFile(productList, TncList, imagePath, header, addressDetails, productTableHeader, false);
            System.out.println("PDF generado en: " + pdfFile.getAbsolutePath());
            return pdfFile;
        } catch (IOException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return null;
    }

    private List<Product> getListaProductos(ArrayList<detallePedido> detalles) {
        try {
            List<Product> productList = new ArrayList<>();
            for (detallePedido de : detalles) {
                int cantidad = Double.valueOf(de.getCantidad()).intValue();
                String nombreProducto = getNombreProducto(de.getId_Prod(), "Descripcion").toString();
                float precio = Float.parseFloat(getNombreProducto(de.getId_Prod(), "Precio").toString());
                productList.add(new Product(nombreProducto, cantidad, precio));
            }
            return productList;
        } catch (NumberFormatException e) {
            System.out.println("ERROR: " + e.getMessage());
        }
        return null;
    }

    private Object getNombreProducto(String idProducto, String columna) {
        Connection conexion = null;
        PreparedStatement consulta = null;
        ResultSet resultado = null;
        String sql = "SELECT * FROM t_producto WHERE Id_Prod=?";
        Object name = "";
        try {
            conexion = new conexionBD().Connected();
            consulta = conexion.prepareCall(sql);
            consulta.setString(1, idProducto);
            resultado = consulta.executeQuery();
            if (resultado.next()) {
                name = resultado.getObject(columna);
            }
            return name;
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return null;
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
