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
import proy01.modelo.dao.PersonaDao;
import proy01.modelo.daoImpl.CompraDaoImpl;
import proy01.modelo.daoImpl.PersonaDaoImpl;
import proy01.modelo.entidad.Compra;
import proy01.modelo.entidad.Persona;
import proy01.modelo.entidad.Proveedor;

/**
 *
 * @author Eliacer Fernandez
 */
public class ControlCompra extends HttpServlet {

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
        
    String id_compra=request.getParameter("id_compra");id_compra = id_compra==null?"":id_compra;    
    String id_usuario=request.getParameter("id_usuario");id_usuario = id_usuario==null?"":id_usuario;
    String id_comprobante=request.getParameter("id_comprobante");id_comprobante = id_comprobante==null?"":id_comprobante;
    String num_comp=request.getParameter("num_comp");num_comp = num_comp==null?"":num_comp;
    String id_forma_pago=request.getParameter("id_forma_pago");id_forma_pago = id_forma_pago==null?"":id_forma_pago;
    String id_moneda=request.getParameter("id_moneda");id_moneda = id_moneda==null?"":id_moneda;
    String id_proveedor=request.getParameter("id_proveedor");id_proveedor = id_proveedor==null?"":id_proveedor;
    String proveedor=request.getParameter("proveedor");proveedor = proveedor==null?"":proveedor;//busqueda....
    String fecha_comp=request.getParameter("fecha_comp");fecha_comp = fecha_comp==null?"":fecha_comp;  
    String igv=request.getParameter("igv");igv = igv==null?"":igv;
    String flete=request.getParameter("flete");flete = flete==null?"":flete;
    String descripcion=request.getParameter("descripcion");descripcion = descripcion==null?"":descripcion;
    String opcion = request.getParameter("opcion");opcion = opcion == null ? "" : opcion;
    String mensaje="";
    String alert="";
    
    String nombres=request.getParameter("nombres");nombres = nombres==null?"":nombres;
    String razon_social=request.getParameter("razon_social");razon_social = razon_social==null?"":razon_social;
    String apellidos=request.getParameter("apellidos");apellidos = apellidos==null?"":apellidos;
    String genero=request.getParameter("genero");genero = genero==null?"":genero;
    String fecha_nacimiento=request.getParameter("fecha_nac");fecha_nacimiento = fecha_nacimiento==null?"":fecha_nacimiento;
    String telefono=request.getParameter("telefono");telefono = telefono==null?"":telefono;
    String celular=request.getParameter("celular");celular = celular==null?"":celular;
    String t_doc=request.getParameter("t_doc");t_doc = t_doc==null?"":t_doc;
    String num_doc=request.getParameter("num_doc");num_doc = num_doc==null?"":num_doc;
    String ruc=request.getParameter("ruc");ruc = ruc==null?"":ruc;
    String direccion=request.getParameter("direccion");direccion = direccion==null?"":direccion;
    String estado=request.getParameter("estado");estado = estado == null ? "" : estado;
    String correo=request.getParameter("correo");correo = correo == null ? "" : correo;
    String num_cuenta=request.getParameter("num_cuenta");num_cuenta = num_cuenta == null ? "" : num_cuenta;
    
    
    Persona persona=new Persona();
    PersonaDao dao=new PersonaDaoImpl();
    Compra compra = new Compra();
    CompraDao cd = new CompraDaoImpl();
    Proveedor proveed = new Proveedor();
    
    
    switch(opcion){
        
        case "Iniciar":
                request.getRequestDispatcher("Compra.jsp").forward(request, response);
                break;
        
        case "RegistrarProveedor":
            if((!nombres.equals("") || !razon_social.equals("")) && (!num_doc.equals("")||!ruc.equals(""))){    

                persona.setNombres(nombres);
                persona.setApellidos(apellidos);
                persona.setRazon_social(razon_social);
                persona.setId_tipo_doc(t_doc);
                persona.setNumero_doc(num_doc);
                persona.setRuc(ruc);
                persona.setFecha_nac(fecha_nacimiento);
                persona.setTelefono(telefono);
                persona.setCelular(celular);
                persona.setDireccion(direccion);
                persona.setGenero(genero);

                if(dao.InsertarPersona(persona))
                {          
                    if(!num_doc.equals("")||!ruc.equals("")){
                        if(!num_doc.equals("")){
                            persona =dao.ObtenerPersonaDni(num_doc);
                            id_proveedor=persona.getId_persona();
                        }
                        else if(!ruc.equals("")){
                            persona =dao.ObtenerPersonaRuc(ruc);
                            id_proveedor=persona.getId_persona();
                        }            
                    }                     
                        proveed.setId_proveedor(id_proveedor);
                        proveed.setCorreo_electronico(correo);
                        proveed.setNum_cuenta(num_cuenta);
                        if(dao.RegistrarProveedor(proveed)){
                            alert="info";
                            opcion="Registrar";
                            mensaje = "Se registró corerctamente el proveedor...";             
                        }
                        else{
                            alert="danger";
                            opcion="Continuar";
                            mensaje = "Ocurrio un error...";             
                        }
                }
                else{
                    alert="danger";
                    opcion="Registrar";
                    mensaje = "Ocurrio un error..."; 
                }
            }   
            
            request.setAttribute("opcion", opcion);
            request.setAttribute("alert", alert);
            request.setAttribute("mensaje", mensaje);
            request.getRequestDispatcher("Compra.jsp").forward(request, response);
        break;
            
    case "Registrar":       
        if(!id_proveedor.equals("") && !id_moneda.equals("") &&!id_comprobante.equals("")
                && !num_comp.equals("") && !id_forma_pago.equals("") && !fecha_comp.equals("")){
            
            igv = igv.equals("")?"0":igv;
            flete = flete.equals("")?"0":flete;
            
            compra.setId_usuario(id_usuario);
            compra.setId_comprobante(id_comprobante);
            compra.setNumComprobante(num_comp);
            compra.setId_formaPago(id_forma_pago);
            compra.setId_tipoMoneda(id_moneda);
            compra.setId_proveedor(id_proveedor);
            compra.setFechaCompra(fecha_comp);
            compra.setIgv(igv);
            compra.setFlete(flete);
            compra.setDescripcion(descripcion);

            if(cd.RegistrarCompra(compra)){
                mensaje="Se registro correctamente la compra...";      
                request.setAttribute("num_comp", num_comp);
                request.getRequestDispatcher("buyproducts").forward(request, response);
            }
            else{
                opcion="Registrar";
                alert="danger";
                mensaje="No se pudo registrar la compra...";
                request.setAttribute("opcion", opcion);
                request.setAttribute("alert", alert);
                request.setAttribute("mensaje", mensaje);
                request.getRequestDispatcher("Compra.jsp").forward(request, response);
            }
        }
        
        else if(!proveedor.equals("")){
            request.setAttribute("proveedor", proveedor);
            request.getRequestDispatcher("Compra.jsp").forward(request, response);
        }
    
        else{
            opcion="Registrar";
            alert="danger";
            mensaje="No se pudo registrar la compra...Faltan registrar algunos datos";
            request.setAttribute("opcion", opcion);
            request.setAttribute("alert", alert);
            request.setAttribute("mensaje", mensaje);
            request.getRequestDispatcher("Compra.jsp").forward(request, response);
        }
            
        break;
    
    case "Actualizar":
        
            request.setAttribute("opcion", "Actualizando");
            request.setAttribute("id_compra", id_compra);
            request.setAttribute("Compra", cd.ListarCompraid(id_compra));
            request.getRequestDispatcher("Compra.jsp").forward(request, response);
        break;

    case "Actualizando":
        
            if(!id_proveedor.equals("") && !id_moneda.equals("") &&!id_comprobante.equals("")
                && !num_comp.equals("") && !id_forma_pago.equals("")){
            
            igv = igv.equals("")?"0":igv;
            flete = flete.equals("")?"0":flete;
            
            compra.setId_compra(id_compra);
            compra.setId_usuario(id_usuario);
            compra.setId_comprobante(id_comprobante);
            compra.setNumComprobante(num_comp);
            compra.setId_formaPago(id_forma_pago);
            compra.setId_tipoMoneda(id_moneda);
            compra.setId_proveedor(id_proveedor);
            compra.setIgv(igv);
            compra.setFlete(flete);
            compra.setDescripcion(descripcion);

            if(cd.UpdateCompra(compra)){
                alert="success";
                mensaje="Se actualizo correctamente los datos de la compra...";      
                request.setAttribute("buscar_por", "nombre");
                request.setAttribute("buscar", "");
                request.setAttribute("opcion", "Buscar");
                request.setAttribute("alert", alert);
                request.setAttribute("mensaje", mensaje);
                request.setAttribute("id_compra", id_compra);
                request.setAttribute("CompraT", cd.ListarCompraT(id_compra));
                request.getRequestDispatcher("Compra_detalle.jsp").forward(request, response);
            }
            else{
                opcion="Registrar";
                alert="danger";
                mensaje="No se pudo actualizar los datos de la compra...";
                request.setAttribute("opcion", opcion);
                request.setAttribute("alert", alert);
                request.setAttribute("mensaje", mensaje);
                request.getRequestDispatcher("Compra.jsp").forward(request, response);
            }
        }
        
        else if(!proveedor.equals("")){
            request.setAttribute("proveedor", proveedor);
            request.getRequestDispatcher("Compra.jsp").forward(request, response);
        }
    
        else{
            opcion="Registrar";
            alert="danger";
            mensaje="No se pudo actualizar los datos compra...Faltan registrar algunos datos";
            request.setAttribute("opcion", opcion);
            request.setAttribute("alert", alert);
            request.setAttribute("mensaje", mensaje);
            request.getRequestDispatcher("Compra.jsp").forward(request, response);
        }
            
        break;
}
}// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
