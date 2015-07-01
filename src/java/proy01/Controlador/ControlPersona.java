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
import proy01.modelo.dao.PersonaDao;
import proy01.modelo.daoImpl.PersonaDaoImpl;
import proy01.modelo.entidad.Cliente;
import proy01.modelo.entidad.Persona;
import proy01.modelo.entidad.Proveedor;
import proy01.modelo.entidad.Usuario;

/**
 *
 * @author Eliacer Fernandez
 */
public class ControlPersona extends HttpServlet {

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
        
        String id_persona=request.getParameter("id_persona");id_persona = id_persona==null?"":id_persona;;
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
        String t_per=request.getParameter("t_per");t_per = t_per == null ? "" : t_per;
        String login=request.getParameter("login");login = login == null ? "" : login;
        String pass=request.getParameter("password");pass = pass == null ? "" : pass;
        String id_rol=request.getParameter("id_rol");id_rol = id_rol == null ? "" : id_rol;
        String id_categoria=request.getParameter("id_categoria");id_categoria = id_categoria == null ? "" : id_categoria;
        String correo=request.getParameter("correo");correo = correo == null ? "" : correo;
        String num_cuenta=request.getParameter("num_cuenta");num_cuenta = num_cuenta == null ? "" : num_cuenta;
        String opcion = request.getParameter("opcion");opcion = opcion == null ? "" : opcion;
        String mensaje="";
        String alert="";
        
        Persona persona=new Persona();
        PersonaDao dao=new PersonaDaoImpl();
        Cliente cliente = new Cliente();
        Usuario us = new Usuario();
        Proveedor proveedor = new Proveedor();

        switch(opcion){
            
            case "Iniciar":
                request.setAttribute("opcion", "Registrar");
                request.getRequestDispatcher("Registro_personas.jsp").forward(request, response);
                break;
            case "Registrar":
                
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
                persona.setEstado(estado);
                if(dao.InsertarPersona(persona)){                  
                    if(!num_doc.equals("")||!ruc.equals("")){
                        if(!num_doc.equals("")){
                            persona =dao.ObtenerPersonaDni(num_doc);
                            id_persona=persona.getId_persona();
                        }
                        else if(!ruc.equals("")){
                            persona =dao.ObtenerPersonaRuc(ruc);
                            id_persona=persona.getId_persona();
                        }            
                    } 
                    opcion="Asignar";
                    alert="info";
                    mensaje = "Se registró corerctamente...";
                    }
                else{
                    alert="warning";
                    opcion="Registrar";
                    mensaje="No se pudo registrar";
                    }
                }               
                request.setAttribute("opcion", opcion);
                request.setAttribute("mensaje", mensaje);
                request.setAttribute("alert", alert);
                request.setAttribute("id_persona", id_persona);
                request.getRequestDispatcher("Registro_personas.jsp").forward(request, response);
                break;
            case "Actualizar":
                request.setAttribute("Persona", dao.ObtenerPersonaId(id_persona));
                request.setAttribute("opcion", "Actualizando");
                request.getRequestDispatcher("Registro_personas.jsp").forward(request, response);
                break;
            case "Eliminar":
                
                    if(dao.DeletePersona(id_persona)){
                        alert="success";
                        mensaje="Se eliminó correctamente.";
                    }
                    else{
                        mensaje="¡¡No se puede eliminar...Es posible que estea asignado con alguna funcion!!";
                    }
                request.setAttribute("opcion", "ok");
                request.setAttribute("mensaje", mensaje);
                request.setAttribute("alert", alert);
                request.getRequestDispatcher("Actualizar_Datos.jsp").forward(request, response);break;
            case "Actualizando":
                
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
                    persona.setEstado(estado);
                    persona.setId_persona(id_persona);

                    if(dao.UpdatePersona(persona)){
                        //opcion="Registrar";
                        alert="success";
                        mensaje = "Se actualizó corerctamente..";
                    }
                    else{
                        alert="warning";
                        mensaje = "No se pudo actualizar";
                    }
                }
                
                request.setAttribute("mensaje", mensaje);
                request.setAttribute("alert", alert);
                request.getRequestDispatcher("Actualizar_Datos.jsp").forward(request, response);
                break;
            
            case "Asignar":
                request.setAttribute("opcion", opcion);
                request.setAttribute("t_per", t_per);
                request.setAttribute("id_persona", id_persona);
                request.getRequestDispatcher("Registro_personas.jsp").forward(request, response);
                break;
            case "Asignando":
                 
                if(!t_per.equals("") && !id_persona.equals("")){
            
                    if(t_per.equals("User")){

                        if(!login.equals("") && !pass.equals("") && !id_rol.equals("")){
                            us.setIdUsuario(id_persona);
                            us.setLogin(login);
                            us.setPassword(pass);
                            us.setIdRol(id_rol);

                            if(dao.RegistrarUsuario(us)){

                                opcion="termino";
                                alert="success";
                                mensaje="Se registro el usuario correcamente...";
                            }
                            else{
                                 alert="warning";
                                 mensaje="ocurrio un error al registrar este usuario...";
                            }
                        }  
                    }
                    if(t_per.equals("Prov")){

                        if(!correo.equals("") && !num_cuenta.equals("")){
                            proveedor.setId_proveedor(id_persona);
                            proveedor.setCorreo_electronico(correo);
                            proveedor.setNum_cuenta(num_cuenta);

                            if(dao.RegistrarProveedor(proveedor)){

                                opcion="termino";
                                alert="success";
                                mensaje="Se registro el proveedor correcamente...";
                            }
                            else{
                                alert="warning";
                                mensaje="ocurrio un error al registrar este proveedor...";
                            }
                        }
                    }
                    if(t_per.equals("Cliente")){

                        if(!id_categoria.equals("")){
                            cliente.setIdCliente(id_persona);
                            cliente.setIdTipoCliente(id_categoria);
                            if(dao.RegistrarCliente(cliente)){
                                opcion="termino";
                                alert="success";
                                mensaje="Se registro el cliente correcamente...";
                            }
                            else{
                                alert="warning";
                                mensaje="ocurrio un error al registrar este cliente...";
                            }
                        }
                    }  
                } 
                request.setAttribute("mensaje", mensaje);
                request.setAttribute("alert", alert);
                request.setAttribute("opcion", "ok");
                request.getRequestDispatcher("Registro_personas.jsp").forward(request, response);
                break;
                
            case "Act":
                request.getRequestDispatcher("Actualizar_Datos.jsp").forward(request, response);
            break;
            default: 
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
