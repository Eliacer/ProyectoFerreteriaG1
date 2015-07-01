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
import javax.servlet.http.HttpSession;
import proy01.modelo.dao.ProductoDao;
import proy01.modelo.dao.VentaDao;
import proy01.modelo.daoImpl.ProductoDaoImpl;
import proy01.modelo.daoImpl.VentaDaoImpl;
import proy01.modelo.entidad.CatCliente;
import proy01.modelo.entidad.DetalleVenta;
import proy01.modelo.entidad.Producto;
import proy01.modelo.entidad.Venta;

/**
 *
 * @author Eliacer Fernandez
 */
public class Ventas extends HttpServlet {

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
            throws ServletException, IOException 
    {
        
        //(String)request.getAttribute(
        String id_configuracion=request.getParameter("id_configuracion");id_configuracion = id_configuracion==null?"":id_configuracion;
        String id_venta=request.getParameter("id_venta");id_venta = id_venta==null?"":id_venta;
        String id_cliente=request.getParameter("id_cliente");id_cliente = id_cliente==null?"":id_cliente;
        String id_usuario=request.getParameter("id_usuario");id_usuario = id_usuario==null?"":id_usuario;    
        String num_comp="";
        String serie=request.getParameter("serie");serie = serie==null?"":serie;
        String fecha_venta=request.getParameter("fecha_venta");fecha_venta = fecha_venta==null?"":fecha_venta;
             
        String id_producto=request.getParameter("id_producto");id_producto = id_producto==null?"":id_producto;
        String cant=request.getParameter("cant");cant = cant==null?"":cant;
        String precio=request.getParameter("precio");precio = precio==null?"":precio;
        String buscar_por = request.getParameter("buscar_por");buscar_por = buscar_por==null?"nombre": buscar_por;
        String buscar = request.getParameter("buscar");buscar = buscar==null?"": buscar;
        String opcion = request.getParameter("opcion");opcion = opcion == null ? "Buscar" : opcion;
        
        
        double descuento=0;
        String mensaje="";
        int stock;
        String alert="";
        
        DetalleVenta dv = new DetalleVenta();
        VentaDao dao = new VentaDaoImpl();
        Venta repventa = new Venta();
        Producto producto = new Producto();
        ProductoDao pd=new ProductoDaoImpl();
        CatCliente cc = new CatCliente();
        
        
        if (!id_cliente.equals("") && !id_configuracion.equals("") && !id_usuario.equals("")) {
            
            repventa=dao.ObtenerNumComp(id_usuario, id_cliente, id_configuracion);
            num_comp=repventa.getNumComprobante();
            
            repventa =dao.ObtenerVenta(num_comp, id_configuracion);
           
            request.setAttribute("buscar_por", buscar_por);
            request.setAttribute("buscar", buscar);
            request.setAttribute("opcion", "Buscar");
            request.setAttribute("id_venta", repventa.getId_venta());
            request.setAttribute("VentaT", dao.ObtenerDatosVenta(repventa.getId_venta()));
            request.getRequestDispatcher("Venta_detalle_1.jsp").forward(request, response);

                
        }
        
        switch(opcion){
            
        case "Buscando": 
           request.setAttribute("buscar_por", buscar_por);
           request.setAttribute("buscar", buscar);
           request.setAttribute("opcion", "Buscar");
           request.setAttribute("id_venta", id_venta);
           request.setAttribute("VentaT", dao.ObtenerDatosVenta(id_venta));
           request.getRequestDispatcher("Venta_detalle_1.jsp").forward(request, response);

        break;
        
        case "add":
            if(!id_producto.equals("")){   
                request.setAttribute("opcion", opcion);
                request.setAttribute("id_venta", id_venta);
                request.setAttribute("VentaT", dao.ObtenerDatosVenta(id_venta));
                request.setAttribute("ProductoDe", pd.ObtenerDatProducto(id_producto));
                request.getRequestDispatcher("Venta_detalle_1.jsp").forward(request, response);
            }
        break;       
        
        case "Agregar":           
            if(!id_venta.equals("")&&!id_producto.equals("")&& !cant.equals("")&& !precio.equals("")){
                
                cc=dao.ObtenerDcto(id_venta);//obteniendo descuento...
                descuento=cc.getDescuento();//dcto en porc
                producto = pd.ObtenerDatProducto(id_producto);
                stock=producto.getStock_actual();//obtenemos el stock
                dv.setId_venta(id_venta);//seteando los datos
                dv.setId_producto(id_producto);
                dv.setCantidad(Integer.parseInt(cant));
                dv.setPreciounitario(Double.parseDouble(precio));
                dv.setDescuento(descuento);

                if(stock>=Double.parseDouble(cant)){
                    if(dao.RegistrarDetVenta(dv)){
                        mensaje="Se añadió el producto...";
                        alert="success";
                        opcion="Buscar";
                    }
                    else{
                        mensaje="¡¡No se pudo añadir el producto...Es posible que este producto estea en la lista!!";
                        alert="danger";
                        opcion="Buscar";
                    } 
                }
                else{
                        mensaje="¡¡No se pudo agregar segun lo solicitado...Solo hay: "+stock+" en stock!!";
                        alert="danger";
                        opcion="Buscar";
                    } 
            }     
            request.setAttribute("opcion", opcion);
            request.setAttribute("mensaje", mensaje);
            request.setAttribute("alert", alert);
            request.setAttribute("buscar_por", buscar_por);
            request.setAttribute("buscar", buscar);
            request.setAttribute("id_venta", id_venta);
            request.setAttribute("VentaT", dao.ObtenerDatosVenta(id_venta));
            request.getRequestDispatcher("Venta_detalle_1.jsp").forward(request, response);            
            
            break;
            
        case "Actualizar":                   
                request.setAttribute("VentaDetalle", dao.ObtenerDetVenta(id_venta, id_producto));
                request.setAttribute("opcion", opcion);
                request.setAttribute("id_venta", id_venta);
                request.setAttribute("VentaT", dao.ObtenerDatosVenta(id_venta));
                request.setAttribute("ProductoDe", pd.ObtenerDatProducto(id_producto));
                request.getRequestDispatcher("Venta_detalle_1.jsp").forward(request, response);
            
        break;
            
        case "Actualizando":           
                cc=dao.ObtenerDcto(id_venta);//obteniendo descuento...
                descuento=cc.getDescuento();//dcto en porc       
                producto = pd.ObtenerDatProducto(id_producto);
                stock=producto.getStock_actual();//obtenemos el stock
                dv.setId_venta(id_venta);
                dv.setId_producto(id_producto);
                dv.setCantidad(Integer.parseInt(cant));
                dv.setPreciounitario(Double.parseDouble(precio));
                dv.setDescuento(descuento);
                if(stock>=Double.parseDouble(cant)){
                    if(dao.UpdateDetVenta(dv)){
                        mensaje="Se actualizo correctamente el producto comprado...";
                        alert="success";
                        opcion="Buscar";
                    }
                    else{
                        mensaje="Ocurrio un error al actualizar el producto comprado...";
                        alert="danger";
                        opcion="Buscar";
                    }
                }
                else{
                        mensaje="¡¡No se pudo agregar segun lo solicitado...Solo hay: "+stock+" en stock!!";
                        alert="danger";
                        opcion="Buscar";
                    } 
                request.setAttribute("opcion", opcion);
                request.setAttribute("mensaje", mensaje);
                request.setAttribute("alert", alert);
                request.setAttribute("buscar_por", buscar_por);
                request.setAttribute("buscar", buscar);
                request.setAttribute("id_venta", id_venta);
                request.setAttribute("VentaT", dao.ObtenerDatosVenta(id_venta));
                request.getRequestDispatcher("Venta_detalle_1.jsp").forward(request, response);
            
            break;    
            
            case "Eliminar":
                if(dao.DeleteProdVenta(id_venta, id_producto)){
                    mensaje="Se elimino correctamente el producto vde la venta...";
                    alert="success";
                    opcion="Buscar";
                }
                else{
                    mensaje="Ocurrio un error al eliminar el producto de la venta...";
                    alert="danger";
                    opcion="Buscar";
                }
                request.setAttribute("opcion", opcion);
                request.setAttribute("mensaje", mensaje);
                request.setAttribute("alert", alert);
                request.setAttribute("buscar_por", buscar_por);
                request.setAttribute("buscar", buscar);
                request.setAttribute("id_venta", id_venta);
                request.setAttribute("VentaT", dao.ObtenerDatosVenta(id_venta));
                request.getRequestDispatcher("Venta_detalle_1.jsp").forward(request, response);
            break;  
            
            case "Finalizar":           
                if(dao.Stockventa(id_venta)){
                    alert="success";
                    mensaje="Se registró correctamente la venta...";
                    request.setAttribute("opcion", "Finalizar");
                    request.setAttribute("mensaje", mensaje);
                    request.setAttribute("alert", alert);
                    request.getRequestDispatcher("Venta_detalle_1.jsp").forward(request, response);
                }
                else{
                    alert="danger";
                    mensaje="Ocurrió un error al registrar la venta...";   
                    request.setAttribute("mensaje", mensaje);
                    request.setAttribute("alert", "alert");
                    request.setAttribute("buscar_por", buscar_por);
                    request.setAttribute("buscar", buscar);
                    request.setAttribute("opcion", "Buscar");
                    request.setAttribute("id_venta", id_venta);
                    request.setAttribute("VentaT", dao.ObtenerDatosVenta(id_venta));
                    request.getRequestDispatcher("Venta_detalle_1.jsp").forward(request, response);
                }
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
