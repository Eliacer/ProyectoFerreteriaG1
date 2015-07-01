/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proy01.Controlador;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import proy01.modelo.dao.FijarPreciosCompraDao;
import proy01.modelo.dao.ProductoDao;
import proy01.modelo.daoImpl.FijarPreciosCompraDaoImpl;
import proy01.modelo.daoImpl.ProductoDaoImpl;
import proy01.modelo.entidad.Compra;
import proy01.modelo.entidad.Producto;

/**
 *
 * @author Eliacer Fernandez
 */
public class ControlPrecios extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String opcion = request.getParameter("opcion");opcion = opcion == null ? "" : opcion;
        String id_compra = request.getParameter("id_compra");id_compra = id_compra == null ? "" : id_compra;
        String id_producto = request.getParameter("id_producto");id_producto = id_producto == null ? "" : id_producto;
        String precio = request.getParameter("precio");precio = precio == null ? "" : precio;
        String mensaje="",alert="";
        
        FijarPreciosCompraDao dao = new FijarPreciosCompraDaoImpl();
        Compra compra = new Compra();
        Producto producto = new Producto();
        ProductoDao pd = new ProductoDaoImpl();
        
        switch(opcion){
            
            case "Iniciar":
                request.setAttribute("listar", dao.ListarComprasNoFijadasPrecios());
                request.getRequestDispatcher("ListarPreciosCompra.jsp").forward(request, response);
                
                break;
                
            case "Fijar":
                request.setAttribute("id_compra", id_compra);
                request.setAttribute("Prodcompra", dao.ListarCompraPrecioSugerido(id_compra));
                request.getRequestDispatcher("FijarPrecios.jsp").forward(request, response);
                
                break;
                
            case "Guardar":
                
                producto.setIdProducto(id_producto);
                producto.setPrecio(Double.parseDouble(precio));
                if(dao.UpdateProdPrecio(producto)&& dao.Updatedetapf(id_compra, id_producto)){
                    producto=pd.ObtenerDatProducto(id_producto);//obtener Producto
                    mensaje="Se actualizó el precio...";
                    alert="success";
                    
                }
                else{
                    mensaje="No se actualizó el precio...";
                    alert="warning";
                    opcion="";
                }
                request.setAttribute("mensaje", mensaje);
                request.setAttribute("alert", alert);
                request.setAttribute("id_compra", id_compra);
                request.setAttribute("Prodcompra", dao.ListarCompraPrecioSugerido(id_compra));
                request.getRequestDispatcher("FijarPrecios.jsp").forward(request, response);
                
                break;
                
            case "Terminar":
                
                if(dao.UpdatePrecio(id_compra)){
                    mensaje="Se actualizó el precio...";
                    alert="success";
                    opcion="";
                }
                else{
                    alert="danger";
                    mensaje="Ocurrio un error...";
                }
                
                request.setAttribute("mensaje", mensaje);
                request.setAttribute("alert", alert);
                request.setAttribute("listar", dao.ListarComprasNoFijadasPrecios());
                request.getRequestDispatcher("ListarPreciosCompra.jsp").forward(request, response);
                
                break;
            default:break;
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
