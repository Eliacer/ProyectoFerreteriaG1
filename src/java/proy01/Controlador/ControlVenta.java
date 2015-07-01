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
import proy01.modelo.dao.PersonaDao;
import proy01.modelo.dao.VentaDao;
import proy01.modelo.daoImpl.PersonaDaoImpl;
import proy01.modelo.daoImpl.VentaDaoImpl;
import proy01.modelo.entidad.Cliente;
import proy01.modelo.entidad.ComprobanteConfig;
import proy01.modelo.entidad.DetalleVenta;
import proy01.modelo.entidad.Persona;
import proy01.modelo.entidad.Venta;

/**
 *
 * @author Eliacer Fernandez
 */
public class ControlVenta extends HttpServlet {

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
        
    String id_venta=request.getParameter("id_venta");id_venta = id_venta==null?"":id_venta;    
    String id_usuario=request.getParameter("id_usuario");id_usuario = id_usuario==null?"":id_usuario;    
    String id_configuracion=request.getParameter("id_configuracion");id_configuracion = id_configuracion==null?"":id_configuracion;
    String serie=request.getParameter("serie");serie = serie==null?"":serie;
    String id_forma_pago=request.getParameter("id_forma_pago");id_forma_pago = id_forma_pago==null?"":id_forma_pago;
    String id_cliente=request.getParameter("id_cliente");id_cliente = id_cliente==null?"":id_cliente;
    String tipo_cliente=request.getParameter("tipo_cliente");tipo_cliente = tipo_cliente==null?"":tipo_cliente;
    String igv=request.getParameter("igv");igv = igv==null?"":igv;
    String cliente=request.getParameter("cliente");cliente = cliente==null?"":cliente;//busqueda....
    String opcion = request.getParameter("opcion");opcion = opcion == null ? "Registrar" : opcion;
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
    String id_categoria=request.getParameter("id_categoria");id_categoria = id_categoria == null ? "" : id_categoria;
    String num_comp="";
    
        Persona persona=new Persona();
        PersonaDao dao=new PersonaDaoImpl();
        Venta venta = new Venta();
        VentaDao vd = new VentaDaoImpl();
        DetalleVenta dv = new DetalleVenta();
        Cliente client = new Cliente();
        ComprobanteConfig cc = new ComprobanteConfig();
    
    
    switch(opcion){
        
        case "Iniciar":
                request.getRequestDispatcher("Venta.jsp").forward(request, response);
                break;
        
        case "RegistrarCliente":
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
                            id_cliente=persona.getId_persona();
                        }
                        else if(!ruc.equals("")){
                            persona =dao.ObtenerPersonaRuc(ruc);
                            id_cliente=persona.getId_persona();
                        }            
                    } 
                    
                    client.setIdCliente(id_cliente);
                    client.setIdTipoCliente(id_categoria);
                    if(dao.RegistrarCliente(client)){
                        alert="info";
                        opcion="Registrar";
                        mensaje = "Se registró corerctamente el cliente...";             
                    }
                    else{
                        alert="danger";
                        opcion="Registrar";
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
            request.getRequestDispatcher("Venta.jsp").forward(request, response);
        break;
            
    case "Registrar":       
        if(!id_cliente.equals("")&&!id_configuracion.equals("")
                && !tipo_cliente.equals("") && !id_forma_pago.equals("")){

            venta.setId_usuario(id_usuario);
            venta.setId_configuracion(id_configuracion);
            venta.setId_formaPago(id_forma_pago);
            venta.setId_cliente(id_cliente);
            venta.setIdTipoCliente(tipo_cliente);
            venta.setIgv(Double.parseDouble(igv));

            if(vd.RegistrarVenta(venta) && vd.IniciarVenta(id_configuracion)){
                
                request.setAttribute("id_configuracion", id_configuracion);
                request.setAttribute("id_usuario", id_usuario);
                request.setAttribute("id_cliente", id_cliente);
                request.getRequestDispatcher("sellcustomers").forward(request, response);
                              
            }
            else{
                alert="danger";
                mensaje="No se pudo registrar la venta...";
                request.setAttribute("opcion", opcion);
                request.setAttribute("alert", alert);
                request.setAttribute("mensaje", mensaje);
                request.getRequestDispatcher("Venta.jsp").forward(request, response);
            }
        }
        
        else if(!cliente.equals("")){
            request.setAttribute("cliente", cliente);
            request.getRequestDispatcher("Venta.jsp").forward(request, response);
        }   
        else{
            opcion="Registrar";
            alert="danger";
            mensaje="No se pudo registrar la venta...Faltan registrar algunos datos";
            request.setAttribute("opcion", opcion);
            request.setAttribute("alert", alert);
            request.setAttribute("mensaje", mensaje);
            request.getRequestDispatcher("Venta.jsp").forward(request, response);
        }
            
        break;
    
    case "Actualizar":
        
            request.setAttribute("opcion", "Actualizando");
            request.setAttribute("id_venta", id_venta);
            request.setAttribute("Venta", vd.ObtenerVentaid(id_venta));
            request.getRequestDispatcher("Venta.jsp").forward(request, response);
        break;
        
     case "Actualizando":
            if(!id_cliente.equals("")&&!id_configuracion.equals("")
                && !tipo_cliente.equals("") && !id_forma_pago.equals("")){

            venta.setId_venta(id_venta);
            venta.setId_usuario(id_usuario);
            venta.setId_configuracion(id_configuracion);
            venta.setId_formaPago(id_forma_pago);
            venta.setId_cliente(id_cliente);
            venta.setIdTipoCliente(tipo_cliente);
            venta.setIgv(Double.parseDouble(igv));

            if(vd.UpdateVenta(venta)){
                mensaje="Se actualizo correctamente los datos de la venta";
                alert="success";
                request.setAttribute("alert", alert);
                request.setAttribute("mensaje", mensaje);
                request.setAttribute("buscar_por", "nombre");
                request.setAttribute("buscar", "");
                request.setAttribute("opcion", "Buscar");
                request.setAttribute("id_venta", id_venta);
                request.setAttribute("VentaT", vd.ObtenerDatosVenta(id_venta));
                request.getRequestDispatcher("Venta_detalle_1.jsp").forward(request, response);

            }
            else{
                alert="danger";
                mensaje="No se pudo actualizar los datos de la venta...";
                request.setAttribute("opcion", opcion);
                request.setAttribute("alert", alert);
                request.setAttribute("mensaje", mensaje);
                request.getRequestDispatcher("Venta.jsp").forward(request, response);
            }
        }
        
        else if(!cliente.equals("")){
            request.setAttribute("cliente", cliente);
            request.getRequestDispatcher("Venta.jsp").forward(request, response);
        }   
        else{
            opcion="Registrar";
            alert="danger";
            mensaje="No se pudo actualizar los datos la venta...Faltan registrar algunos datos";
            request.setAttribute("opcion", opcion);
            request.setAttribute("alert", alert);
            request.setAttribute("mensaje", mensaje);
            request.getRequestDispatcher("Venta.jsp").forward(request, response);
        }
            
        break;
    
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
