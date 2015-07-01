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
import proy01.modelo.dao.ProductoDao;
import proy01.modelo.daoImpl.ProductoDaoImpl;
import proy01.modelo.entidad.Producto;

/**
 *
 * @author Eliacer Fernandez
 */
public class ControlProducto extends HttpServlet {

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
        String id_producto=request.getParameter("id_producto");id_producto = id_producto==null?"":id_producto;
        String codigo=request.getParameter("codigo");codigo = codigo==null?"":codigo;
        String nombre=request.getParameter("nombre");nombre = nombre==null?"":nombre;
        String unidad_medida=request.getParameter("und_medida");unidad_medida = unidad_medida==null?"":unidad_medida;
        String porc_ganan=request.getParameter("porc_ganan");porc_ganan = porc_ganan==null?"":porc_ganan;
        String id_marca=request.getParameter("id_marca");id_marca = id_marca==null?"":id_marca;
        String id_categoria=request.getParameter("id_categoria");id_categoria = id_categoria==null?"":id_categoria;
        String id_ubicacion=request.getParameter("id_ubicacion");id_ubicacion = id_ubicacion==null?"":id_ubicacion;
        String descripcion=request.getParameter("descripcion");descripcion = descripcion==null?"":descripcion;
        
        String buscar_por = request.getParameter("buscar_por");buscar_por = buscar_por==null?"nombre": buscar_por;
        String buscar = request.getParameter("buscar");buscar = buscar==null?"": buscar;
        String mensaje="";
        String alert="";
        Producto producto=new Producto();
        ProductoDao dao=new ProductoDaoImpl();
        
        switch(opcion){
            case "Iniciar":
                request.setAttribute("opcion", "Registrar");
                request.getRequestDispatcher("Registro_productos.jsp").forward(request, response);
                break;
            
            case "Buscar":
                request.setAttribute("buscar_por", buscar_por);
                request.setAttribute("buscar", buscar);
                request.getRequestDispatcher("ModificacionProducto.jsp").forward(request, response);
                break;
                
            case "Registrar":                         
                producto.setCodigo(codigo);
                producto.setNombre(nombre);
                producto.setIdUndMedida(unidad_medida); 
                producto.setPorc_ganacia(Double.parseDouble(porc_ganan));
                producto.setId_marca(id_marca);
                producto.setId_categoria(id_categoria);
                producto.setId_ubicacion(id_ubicacion);
                producto.setDescripcion(descripcion);
                if(dao.InsertProducto(producto))
                {        
                    opcion="ok";
                    alert="success";
                    mensaje = "Se añadió corerctamente el producto... <a href='controlproducto?opcion=Iniciar'>[Seguir Añadiendo] </a><a href='controlproducto?opcion=Ending'> [Terminar] </a>";
                    request.setAttribute("opcion", opcion);
                    request.setAttribute("mensaje", mensaje);
                    request.setAttribute("alert", alert);
                    request.getRequestDispatcher("Registro_productos.jsp").forward(request, response);

                }else{
                    opcion="Registrar";
                    alert="danger";
                    mensaje="No se pudo agregar";
                    request.setAttribute("opcion", opcion);
                    request.setAttribute("mensaje", mensaje);
                    request.setAttribute("alert", alert);
                    request.getRequestDispatcher("Registro_productos.jsp").forward(request, response);
                }
                
            break;
                
            case "Actualizar":
                request.setAttribute("opcion", "Actualizando");
                request.setAttribute("Producto", dao.ObtenerProducto(id_producto));
                request.getRequestDispatcher("Registro_productos.jsp").forward(request, response);
                break;
                
            case "Act":
                
                request.setAttribute("buscar_por", buscar_por);
                request.setAttribute("buscar", buscar);
                request.getRequestDispatcher("ModificacionProducto.jsp").forward(request, response);
                break;
                
            case "Eliminar":
                
                if(dao.DeleteProducto(id_producto)){
                    alert="success";
                    mensaje="Se eliminó correctamente.";
                }
                else{
                    alert="danger";
                    mensaje="No se puede eliminar este producto....";
                }   
                
                request.setAttribute("mensaje", mensaje);
                request.setAttribute("alert", alert);
                request.setAttribute("buscar_por", buscar_por);
                request.setAttribute("buscar", buscar);
                request.getRequestDispatcher("ModificacionProducto.jsp").forward(request, response);
                break;
            case "Actualizando":
                producto.setCodigo(codigo);
                producto.setNombre(nombre);
                producto.setIdUndMedida(unidad_medida); 
                producto.setPorc_ganacia(Double.parseDouble(porc_ganan));
                producto.setId_marca(id_marca);
                producto.setId_categoria(id_categoria);
                producto.setId_ubicacion(id_ubicacion);
                producto.setDescripcion(descripcion);
                
                producto.setIdProducto(id_producto);

                if(dao.UpdateProducto(producto)){
                    
                    alert="success";
                    opcion="ok";
                    mensaje = "Se actualizó corerctamente...<a href='controlproducto?opcion=Rep'>[Reportes] </a>";
                }
                else{
                    alert="warning";
                    mensaje = "No se pudo actualizar";
                }
                
                request.setAttribute("buscar_por", buscar_por);
                request.setAttribute("buscar", buscar);
                request.setAttribute("mensaje", mensaje);
                request.setAttribute("alert", alert);
                request.getRequestDispatcher("ModificacionProducto.jsp").forward(request, response);
                break;
                
            case "Ending":
                request.getRequestDispatcher("bienvenida.jsp").forward(request, response);
                break;
                
            case "Rep":
                request.getRequestDispatcher("Rep_Productos.jsp").forward(request, response);
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
