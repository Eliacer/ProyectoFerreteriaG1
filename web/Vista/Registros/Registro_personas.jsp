<%@page import="proy01.modelo.entidad.Cliente"%>
<%@page import="proy01.modelo.entidad.CatCliente"%>
<%@page import="proy01.modelo.entidad.Proveedor"%>
<%@page import="proy01.modelo.entidad.Usuario"%>
<%@page import="proy01.modelo.entidad.Rol"%>
<%@page import="proy01.modelo.entidad.TipoDocumento"%>
<%@page import="proy01.modelo.dao.TipoDocumentoDao"%>
<%@page import="java.util.*"%>
<%@page import="proy01.modelo.daoImpl.TipoDocumentoDaoImpl"%>
<%@page import="proy01.modelo.entidad.Persona"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="proy01.modelo.daoImpl.PersonaDaoImpl"%>
<%@page import="proy01.modelo.dao.PersonaDao"%>
<%@include file="../../WEB-INF/jspf/top.jspf"%>
<div class="container">
    <%
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
    String pass=request.getParameter("pass");pass = pass == null ? "" : pass;
    String id_rol=request.getParameter("id_rol");id_rol = id_rol == null ? "" : id_rol;
    
    String id_categoria=request.getParameter("id_categoria");id_categoria = id_categoria == null ? "" : id_categoria;
    
    String correo=request.getParameter("correo");correo = correo == null ? "" : correo;
    String num_cuenta=request.getParameter("num_cuenta");num_cuenta = num_cuenta == null ? "" : num_cuenta;
    
    String opcion = request.getParameter("opcion");opcion = opcion == null ? "Continuar" : opcion;
    
    String mensaje="";
    String alert="";
    if(opcion.equals("Continuar")||opcion.equals("Actualizando")){
        if((!nombres.equals("") || !razon_social.equals("")) && !t_doc.equals("")&& (!num_doc.equals("")||!ruc.equals(""))
                && (!telefono.equals("") || !celular.equals(""))){
            
            //out.println("id:"+id_persona);
            //out.println("opcion="+opcion);
            Persona persona=new Persona();
            PersonaDao ppd=new PersonaDaoImpl();
            
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
            
            if(opcion.equals("Continuar")){
                if(ppd.InsertarPersona(persona))
                {
                    opcion="Registrar";
                    alert="info";
                    mensaje = "Se registró corerctamente...";
                }else{
                    alert="warning";
                    mensaje="No se pudo registrar";
                }
            }
            if(opcion.equals("Actualizando")){   
                
                persona.setId_persona(id_persona);
                
                if(ppd.UpdatePersona(persona)){
                    //opcion="Registrar";
                    alert="success";
                    mensaje = "Se actualizó corerctamente...<a href='Rep_Personas.jsp'>[Reportes] </a>";
                }
                else{
                    alert="warning";
                    mensaje = "No se pudo actualizar";
                }
            }
        }
    }    
    if(opcion.equals("Actualizar"))
    {      
        //out.println("Id_persona:"+id_persona); 
        if(!id_persona.equals("")){

                Persona persona=new Persona();
                PersonaDao dao=new PersonaDaoImpl();

                persona = dao.ObtenerPersonaId(id_persona);
                //dao.ObtenerPersonaDni(id_persona);
                nombres=persona.getNombres();nombres = nombres==null?"":nombres;
                apellidos=persona.getApellidos();apellidos = apellidos==null?"":apellidos;
                razon_social=persona.getRazon_social();razon_social = razon_social==null?"":razon_social;
                genero=persona.getGenero();genero = genero==null?"": genero;              
                telefono=persona.getTelefono();telefono = telefono==null?"": telefono;
                celular=persona.getCelular();celular = celular==null?"": celular;
                t_doc=persona.getId_tipo_doc();t_doc = t_doc==null?"": t_doc;
                num_doc=persona.getNumero_doc();num_doc = num_doc==null?"": num_doc;
                ruc=persona.getRuc();ruc = ruc==null?"": ruc;
                direccion=persona.getDireccion();direccion = direccion==null?"": direccion;
                estado=persona.getEstado();estado = estado==null?"": estado;
                opcion="Actualizando";
            
        }
    }    
    if(opcion.equals("Registrar")){
        
        if(!num_doc.equals("")){
            Persona  persona = new Persona();
            PersonaDao dao= new PersonaDaoImpl();
            out.println("num_doc: "+num_doc);
            if(!num_doc.equals("")){
                persona =dao.ObtenerPersonaDni(num_doc);
                id_persona=persona.getId_persona();
                
            }
            if(!ruc.equals("")){
                persona =dao.ObtenerPersonaDni(ruc);
                id_persona=persona.getId_persona();
            
            }
            
        } 
        if(!t_per.equals("") && !id_persona.equals("")){
            
            if(t_per.equals("User")){
                
                if(!login.equals("") && !pass.equals("") && !id_rol.equals("")){
                    Usuario us = new Usuario();
                    PersonaDao dao= new PersonaDaoImpl();
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
                    Proveedor proveedor = new Proveedor();
                    PersonaDao dao= new PersonaDaoImpl();

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
                    PersonaDao dao= new PersonaDaoImpl();
                    Cliente cliente = new Cliente();
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
    }
%>

<div class="row">
    <div class="col-md-12" id="aler">
        <br>
        <%
            if(!mensaje.equals("")){
        %>
        <div class="alert alert-<%=alert%>"><%=mensaje%></div> 
        <%}%>
    </div>
</div>
        
<% if(opcion.equals("Continuar") ||opcion.equals("Actualizar") || opcion.equals("Actualizando")){%>
<div class="row">      
        <div class="col-md-3">           
        </div>
        <div class="col-md-6 well" id="reg2">
            
                <h2 align="center">Registro de personas</h2>
            <br>
                <form action="Registro_personas.jsp" method="get"> 
                <table class="table table-condensed">
                    <tbody>
                <tr>
                    <input type="hidden" name="opcion"  value="<%=opcion%>" size="10">
                    <input type="hidden" name="id_persona"  value="<%=id_persona%>" size="10">
                    <td><label class="col-sm-12 control-label">Nombres:</label> </td> 
                    <td>
                        <div class="col-sm-15">
                            <input type="text" class="form-control" placeholder="Nombres" name="nombres" value="<%=nombres%>">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label">Apellidos:</label></td>
                    <td>
                        <div class="col-sm-15">
                            <input type="text" class="form-control" placeholder="Apellidos" name="apellidos" value="<%=apellidos%>">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label">Raz&oacute;n Social</label></td>
                    <td>
                        <div class="col-sm-15">
                            <input type="text" class="form-control" placeholder="Razón Social" name="razon_social" value="<%=razon_social%>">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label">Tipo Doc.:</label></td>
                    <td>
                        <select class="form-control" name="t_doc" selected="selected" <%if(t_doc.equals("")){%> selected<%}%>>> 
                            <option>Seleciona el tipo de documento</option>
                        <%
                            TipoDocumentoDao tdd = new TipoDocumentoDaoImpl();

                            for(TipoDocumento tipoDoc:tdd.ListarTipoDocumento()){      

                        %>

                         <option value="<%=tipoDoc.getId_tipo_doc()%>" <%if(t_doc.equals(tipoDoc.getId_tipo_doc())){%> selected<%}%>> <%=tipoDoc.getNombre()%></option>
                         <%}%>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label">N&deg; Doc:</label></td>
                    <td>
                        <div class="col-sm-15">
                            <input type="text" class="form-control" placeholder="Numero del documento" name="num_doc" value="<%=num_doc%>">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label">RUC:</label></td>
                    <td>
                        <div class="col-sm-15">
                            <input type="text" class="form-control" placeholder="RUC" name="ruc" value="<%=ruc%>">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label" >Tel&eacute;fono:</label></td>
                    <td>
                        <div class="col-sm-15">
                            <input type="text" class="form-control" placeholder="Telefono" name="telefono" value="<%=telefono%>">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label" >Celular:</label></td>
                    <td>
                        <div class="col-sm-15">
                            <input type="text" class="form-control" placeholder="Celular" name="celular" value="<%=celular%>">
                        </div>
                    </td>
                </tr>  
                <%if(!opcion.equals("Actualizando")){%>
                <tr>
                    <td><label class="col-sm-12 control-label" >F. Nacimiento:</label></td>
                    <td>
                        <div class="col-sm-15">
                            <input type="date" class="form-control" placeholder="Fecha de nacimiento" name="fecha_nac" value="<%=fecha_nacimiento%>">
                        </div>
                    </td>
                </tr>
                <%}%>
                <tr>
                    <td><label class="col-sm-12 control-label">G&eacute;nero:</label></td>
                    <td>
                        <label class="radio-inline">
                            <input type="radio" name="genero" value="M"<%if(genero.equals("M")){%> checked<%}%>> Masculino
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="genero" value="F"<%if(genero.equals("F")){%> checked<%}%>> Femenino
                        </label>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label">Dirección:</label></td>
                    <td>
                        <div class="col-sm-15">
                            <textarea rows="3" class="form-control" placeholder="Dirección" name="direccion"><%=direccion%></textarea>
                        </div>
                    </td>
                </tr>
                <%if(opcion.equals("Actualizando")){%>
                <tr>
                    <td><label class="col-sm-12 control-label">Estado:</label></td>
                    <td>
                        <label class="radio-inline">
                            <input type="radio" name="estado" value="1"<%if(estado.equals("1")){%> checked<%}%>> Activo
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="estado" value="0"<%if(estado.equals("0")){%> checked<%}%>> Inactivo
                        </label>
                    </td>
                </tr>
                <%}%>
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" class="btn btn-primary" value="<%=opcion%>">
                        <input type="reset" class="btn btn-default" value="Limpiar">
                    </td> 
                </tr>
                </tbody>
            </table>
            </form>     
        </div> 
        <div class="col-md-3">           
        </div>
</div>
 <%}%>
 
 <%if(opcion.equals("Registrar")){%>
 <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6 well">
            <h3 align="center">Especificar la funci&oacute;n de la persona</h3>
            <br>
            <form name="form7" method="get" action="Registro_personas.jsp">
                <table width="275" border="0" align="center">
                  <tr>
                    <input type="hidden" name="opcion"  value="<%=opcion%>" size="10">
                    <input type="hidden" name="id_persona"  value="<%=id_persona%>" size="10">
                    <td align="center">Usuario</td>
                    <td align="center">Proveedor</td>
                    <td align="center">Cliente</td>    
                  </tr>
                  <tr>
                    <td align="center"><input type="radio" name="t_per" id="radio6" value="User" <%if(t_per.equals("User")){%> checked<%}%> onclick="submit()"></td>
                    <td align="center"><input type="radio" name="t_per" id="radio9" value="Prov" <%if(t_per.equals("Prov")){%> checked<%}%> onclick="submit()"></td>
                    <td align="center"><input type="radio" name="t_per" id="radio8" value="Cliente" <%if(t_per.equals("Cliente")){%> checked<%}%> onclick="submit()"></td>
                  </tr>
                </table>
            </form>
            <br><br>
            <form action="Registro_personas.jsp" method="get"> 
                <table class="table table-condensed">
                    <tbody>
                        <input type="hidden" name="opcion"  value="<%=opcion%>" size="10">
                        <input type="hidden" name="t_per"  value="<%=t_per%>" size="10">
                        <input type="hidden" name="id_persona"  value="<%=id_persona%>" size="10">
                            
                            <%if(t_per.equals("User")){%>
                            <tr>
                                <td><label class="col-sm-7 control-label">Login:</label></td>
                                <td>
                                    <div class="col-sm-15">
                                        <input rows="3" class="form-control" placeholder="Login" name="login" value="<%=login%>">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td><label class="col-sm-7 control-label">Password:</label></td>
                                <td>
                                    <div class="col-sm-15">
                                        <input rows="3" class="form-control" placeholder="pass" name="password" value="<%=pass%>">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td><label class="col-sm-7 control-label">Rol:</label></td>
                                <td>
                                    <select class="form-control" name="id_rol" selected="selected" <%if(id_rol.equals("")){%> selected<%}%>>> 
                                        <option>Seleciona el rol</option>
                                    <%
                                        TipoDocumentoDao tdd = new TipoDocumentoDaoImpl();

                                        for(Rol rol:tdd.ListarRoles()){
                                    %>
                                     <option value="<%=rol.getIdRol()%>" <%if(t_doc.equals(rol.getIdRol())){%> selected<%}%>> <%=rol.getNombre()%></option>
                                     <%}%>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center">
                                    <input type="submit" class="btn btn-primary" value="<%=opcion%>">
                                    <input type="reset" class="btn btn-default" value="Limpiar">
                                </td> 
                            </tr>
                            <%}%>
                            <%if(t_per.equals("Prov")){%>
                            <tr>
                                <td><label class="col-sm-7 control-label">Correo:</label></td>
                                <td>
                                    <div class="col-sm-15">
                                        <input rows="3" class="form-control" placeholder="Correo Electrónico" name="correo" value="<%=correo%>">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td><label class="col-sm-7 control-label">N&deg; Cta. Cte.</label></td>
                                <td>
                                    <div class="col-sm-15">
                                        <input rows="3" class="form-control" placeholder="Número de Cuenta" name="num_cuenta" value="<%=num_cuenta%>">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center">
                                    <input type="submit" class="btn btn-primary" value="<%=opcion%>">
                                    <input type="reset" class="btn btn-default" value="Limpiar">
                                </td> 
                            </tr>
                            <%}%>
                            <%if(t_per.equals("Cliente")){%>
                            <tr>
                                <td><label class="col-sm-8 control-label">Cat. Cliente:</label></td>
                                <td>
                                    <select class="form-control" name="id_categoria" selected="selected" <%if(id_categoria.equals("")){%> selected<%}%>>> 
                                        <option>Seleciona el rol</option>
                                    <%
                                        TipoDocumentoDao tdd = new TipoDocumentoDaoImpl();

                                        for(CatCliente cc : tdd.ListarCatCliente()){
                                    %>
                                     <option value="<%=cc.getIdCategoria()%>" <%if(t_doc.equals(cc.getIdCategoria())){%> selected<%}%>> <%=cc.getNombre()%></option>
                                     <%}%>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center">
                                    <input type="submit" class="btn btn-primary" value="<%=opcion%>">
                                    <input type="reset" class="btn btn-default" value="Limpiar">
                                </td> 
                            </tr>
                            <%}%>
                    </tbody>
                </table>
            </form>
        </div>
        <div class="col-md-3"></div>     
</div>      
 <%}%>
</div>       
<%@include file="../../WEB-INF/jspf/botton.jspf" %>

