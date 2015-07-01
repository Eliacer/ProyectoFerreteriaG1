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
import proy01.modelo.dao.CompraDao;
import proy01.modelo.dao.ProductoDao;
import proy01.modelo.daoImpl.CompraDaoImpl;
import proy01.modelo.daoImpl.ProductoDaoImpl;
import proy01.modelo.entidad.Compra;
import proy01.modelo.entidad.DetalleCompra;
import proy01.modelo.entidad.Producto;
import proy01.modelo.entidad.Rep_compras;

/**
 *
 * @author Eliacer Fernandez
 */
public class Compras extends HttpServlet {

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
        
        String num_comp=request.getParameter("num_comp"); num_comp = num_comp == null?"" : num_comp;
        String buscar_por = request.getParameter("buscar_por");buscar_por = buscar_por==null?"nombre": buscar_por;
        String buscar = request.getParameter("buscar");buscar = buscar==null?"": buscar;
        String id_compra=request.getParameter("id_compra");id_compra = id_compra==null?"":id_compra;
        String id_producto=request.getParameter("id_producto");id_producto = id_producto==null?"":id_producto;
        String unidad=request.getParameter("unidad");unidad = unidad==null?"":unidad;
        String cant_may=request.getParameter("cant_may");cant_may = cant_may==null?"":cant_may;
        String cant_menor=request.getParameter("cant_menor");cant_menor = cant_menor==null?"":cant_menor;
        String costo=request.getParameter("costo");costo = costo==null?"":costo;
        String opcion = request.getParameter("opcion");opcion = opcion == null ? "Buscar" : opcion;    
        
        String mensaje="";
        String alert="";
        String simbolo="";
        
        Compra compra = new Compra();
        CompraDao dao = new CompraDaoImpl();
        Rep_compras rep_compras = new Rep_compras();
        Producto producto = new Producto();
        ProductoDao pd=new ProductoDaoImpl();
        DetalleCompra dc = new DetalleCompra();
        DetalleCompra detalleCompra = new DetalleCompra();
        
        if (!num_comp.equals("")) {
            
            compra=dao.ListarCompra(num_comp);
            request.setAttribute("CompraT", dao.ListarCompraT(compra.getId_compra()));
            request.setAttribute("id_compra", compra.getId_compra());
            request.setAttribute("buscar_por", buscar_por);
            request.setAttribute("buscar", buscar);
            request.getRequestDispatcher("Compra_detalle.jsp").forward(request, response);
            
        }
        
        switch(opcion){
            
        case "Buscando": 
           request.setAttribute("buscar_por", buscar_por);
           request.setAttribute("buscar", buscar);
           request.setAttribute("opcion", "Buscar");
           request.setAttribute("id_compra", id_compra);
           request.setAttribute("CompraT", dao.ListarCompraT(id_compra));
           request.getRequestDispatcher("Compra_detalle.jsp").forward(request, response);

        break;
            
        case "add":
            if(!id_producto.equals("")){   
                request.setAttribute("opcion", opcion);
                request.setAttribute("id_compra", id_compra);
                request.setAttribute("CompraT", dao.ListarCompraT(id_compra));
                request.setAttribute("ProductoDe", pd.ObtenerDatProducto(id_producto));
                request.getRequestDispatcher("Compra_detalle.jsp").forward(request, response);
            }
        break;
            
        case "Actualizar":                   
                request.setAttribute("CompraDetalle", dao.ObtenerDetCompra(id_compra, id_producto));
                request.setAttribute("CompraT", dao.ListarCompraT(id_compra));
                request.setAttribute("id_compra", id_compra);
                request.setAttribute("opcion", opcion);
                request.setAttribute("ProductoDe", pd.ObtenerDatProducto(id_producto));
                request.getRequestDispatcher("Compra_detalle.jsp").forward(request, response);

        break; 
        case "Agregar":
            
            if(!id_compra.equals("")&&!id_producto.equals("") && !unidad.equals("")&& !cant_may.equals("")
                    && !cant_menor.equals("")&& !costo.equals("")){
                
                detalleCompra.setId_compra(id_compra);
                detalleCompra.setId_producto(id_producto);
                detalleCompra.setId_unidad(unidad);
                detalleCompra.setCantMayor(Integer.parseInt(cant_may));
                detalleCompra.setCantMenor(Integer.parseInt(cant_menor));
                detalleCompra.setCostoMayor(Double.parseDouble(costo));
                if(dao.RegistrarDetCompra(detalleCompra)){
                    mensaje="Se añadió el producto...";  
                    alert="success";
                    opcion="Buscar";
                }
                else{
                    mensaje="¡¡No se pudo añadir el producto...Es posible que ya estea en la Lista!!";
                    alert="danger";
                    opcion="Buscar";
                }             
            }     
            request.setAttribute("opcion", opcion);
            request.setAttribute("mensaje", mensaje);
            request.setAttribute("alert", alert);
            request.setAttribute("buscar_por", buscar_por);
            request.setAttribute("buscar", buscar);
            request.setAttribute("id_compra", id_compra);
            request.setAttribute("CompraT", dao.ListarCompraT(id_compra));
            request.getRequestDispatcher("Compra_detalle.jsp").forward(request, response);
            break;
          
        case "Actualizando":
                dc.setId_compra(id_compra);
                dc.setId_producto(id_producto);
                dc.setId_unidad(unidad);
                dc.setCantMayor(Integer.parseInt(cant_may));
                dc.setCantMenor(Integer.parseInt(cant_menor));
                dc.setCostoMayor(Double.parseDouble(costo));
                
                if(dao.UpdateDeompra(dc)){
                    mensaje="Se actualizo correctamente el producto de la compra...";
                    alert="success";
                    opcion="Buscar";
                }
                else{
                    mensaje="¡¡No se pudo actulizar el producto de la compra...!!";
                    alert="danger";
                    opcion="Buscar";
                }
                
                request.setAttribute("opcion", opcion);
                request.setAttribute("mensaje", mensaje);
                request.setAttribute("alert", alert);
                request.setAttribute("buscar_por", buscar_por);
                request.setAttribute("buscar", buscar);
                request.setAttribute("id_compra", id_compra);
                request.setAttribute("CompraT", dao.ListarCompraT(id_compra));
                request.getRequestDispatcher("Compra_detalle.jsp").forward(request, response);
            break;
            
        case "Eliminar":
                if(dao.DeleteProdCompra(id_compra, id_producto)){
                    mensaje="Se elimino correctamente el producto de la compra...";
                    alert="success";
                    opcion="Buscar";
                }
                else{
                    mensaje="No se pudo eliminar el producto de la compra...";
                    alert="danger";
                    opcion="Buscar";
                }  
                request.setAttribute("opcion", opcion);
                request.setAttribute("mensaje", mensaje);
                request.setAttribute("alert", alert);
                request.setAttribute("buscar_por", buscar_por);
                request.setAttribute("buscar", buscar);
                request.setAttribute("id_compra", id_compra);
                request.setAttribute("CompraT", dao.ListarCompraT(id_compra));
                request.getRequestDispatcher("Compra_detalle.jsp").forward(request, response);
            break; 
        case "Finalizar":
            
            if(dao.StockCompra(id_compra)){
                alert="success";
                mensaje="Se registró correctamente la compra...<a href='FijarPrecios.jsp'>[Fijar precio a los productos] </a>";
                request.setAttribute("opcion", "Finalizar");
                request.setAttribute("mensaje", mensaje);
                request.setAttribute("alert", alert);
                request.getRequestDispatcher("Compra_detalle.jsp").forward(request, response);
            }
            else{
                alert="danger";
                mensaje="Ocurrió un error al registrar la compra...";   
                request.setAttribute("mensaje", mensaje);
                request.setAttribute("alert", "alert");
                request.setAttribute("buscar_por", buscar_por);
                request.setAttribute("buscar", buscar);
                request.setAttribute("opcion", "Buscar");
                request.setAttribute("id_compra", id_compra);
                request.setAttribute("CompraT", dao.ListarCompraT(id_compra));
                request.getRequestDispatcher("Compra_detalle.jsp").forward(request, response);
                
            }
            break; 
            
        case "EliminarVenta":break;
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
