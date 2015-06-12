
<%@page import="proy01.modelo.entidad.TipoDocumento"%>
<%@page import="proy01.modelo.daoImpl.TipoDocumentoDaoImpl"%>
<%@page import="proy01.modelo.dao.TipoDocumentoDao"%>
<%@page import="proy01.modelo.entidad.Cliente"%>
<%@page import="proy01.modelo.daoImpl.VentaDaoImpl"%>
<%@page import="proy01.modelo.dao.VentaDao"%>
<%@page import="proy01.modelo.dao.CompraDao"%>
<%@page import="proy01.modelo.entidad.ComprobanteConfig"%>
<%@page import="proy01.modelo.entidad.CatCliente"%>
<%@page import="proy01.modelo.entidad.Venta"%>
<%@page import="proy01.modelo.entidad.Compra"%>
<%@page import="proy01.modelo.entidad.TipoMoneda"%>
<%@page import="proy01.modelo.entidad.FormaPago"%>
<%@page import="proy01.modelo.daoImpl.PersonaDaoImpl"%>
<%@page import="proy01.modelo.dao.PersonaDao"%>
<%@page import="proy01.modelo.entidad.Persona"%>
<%@page import="proy01.modelo.entidad.Comprobante"%>
<%@page import="proy01.modelo.daoImpl.CaracteristicasProductoDaoImpl"%>
<%@page import="proy01.modelo.dao.CaracteristicasProductoDao"%>
<%@include file="WEB-INF/jspf/top.jspf" %>

<%
    String id_configuracion=request.getParameter("id_configuracion");id_configuracion = id_configuracion==null?"":id_configuracion;
    String serie=request.getParameter("serie");serie = serie==null?"":serie;
    String id_forma_pago=request.getParameter("id_forma_pago");id_forma_pago = id_forma_pago==null?"":id_forma_pago;
    String id_cliente=request.getParameter("id_cliente");id_cliente = id_cliente==null?"":id_cliente;
    String tipo_cliente=request.getParameter("tipo_cliente");tipo_cliente = tipo_cliente==null?"":tipo_cliente;
    String cliente=request.getParameter("cliente");cliente = cliente==null?"":cliente;//busqueda....
    String opcion = request.getParameter("opcion");opcion = opcion == null ? "Conti" : opcion;
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
    
    if(opcion.equals("Registrar")){
        if((!nombres.equals("") || !razon_social.equals("")) && !t_doc.equals("")&& (!num_doc.equals("")||!ruc.equals(""))){
            
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
            
            if(ppd.InsertarPersona(persona))
            {
                if(!num_doc.equals("")){

                    Cliente clien = new Cliente();

                    persona = ppd.ObtenerPersonaDni(num_doc);
                    id_cliente=persona.getId_persona();   

                    clien.setIdCliente(id_cliente);
                    clien.setIdTipoCliente(id_categoria);
                    if(ppd.RegistrarCliente(clien)){
                        alert="info";
                        opcion="Conti";
                        mensaje = "Se registró corerctamente el cliente...";             
                    }
                    else{
                        alert="danger";
                        opcion="Conti";
                        mensaje = "Ocurrio un error...";             

                    }
                }
            }
            else{
                alert="danger";
                opcion="Conti";
                mensaje = "Ocurrio un error...";             

            }
        }
    }
    
    if(opcion.equals("Continuar")){
        
        if(!id_cliente.equals("")&&!id_configuracion.equals("")
                && !tipo_cliente.equals("") && !id_forma_pago.equals("")){

            Venta venta = new Venta();
            ComprobanteConfig cc = new ComprobanteConfig();
            VentaDao cd = new VentaDaoImpl();
            
            cc = cd.ObtenerCompConfig(id_configuracion);
            out.println("cliente"+cliente);
            
            venta.setId_usuario(id);
            venta.setId_configuracion(id_configuracion);
            venta.setId_formaPago(id_forma_pago);
            venta.setId_cliente(id_cliente);
            venta.setIdTipoCliente(tipo_cliente);

            if(cd.RegistrarVenta(venta) && cd.IniciarVenta(id_configuracion)){
                
                opcion="ok";
                alert="info";
                response.sendRedirect("sellcustomer?id_configuracion="+id_configuracion+"&id_user="+id+"&id_cliente="+id_cliente);        
            }
            else{
                alert="danger";
                mensaje="No se pudo registrar la venta...";
            }
        }
    }
    
%>

<div class="container">
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
<%if(opcion.equals("Conti")){%>
<div class="row">
    <div class="col-md-3"></div>
    <div class="col-md-6 well">
        <h2>Registrar Ventas</h2>
        <br><br>
        <form action="Venta.jsp" method="get">
            <table class="table table-condensed">
                <tbody>
                <tr>    
                    <td width="30%"><label class="col-sm-20 control-label" >Forma de pago:</label></td>
                    <td colspan="3">
                        <input type="hidden" name="id_usuario"  value="<%=id%>" size="10">
                    <select class="form-control" name="id_forma_pago" selected="selected" <%if(id_forma_pago.equals("")){%> selected<%}%>><option>[--Selecciona--]</option>                 
                    <%
                        VentaDao CompDao = new VentaDaoImpl();

                        for(FormaPago fp: CompDao.ListarFormapago()){             

                    %>
                    <option value="<%=fp.getIdFormaPago()%>" <%if(id_forma_pago.equals(fp.getIdFormaPago())){%> selected<%}%>> <%=fp.getNombre()%></option>
                     <%}%>
                    </select>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-20 control-label" >Comprobante:</label></td>
                    <td colspan="3">
                    <select class="form-control" name="id_configuracion" selected="selected" <%if(id_configuracion.equals("")){%> selected<%}%>><option>[--Selecciona--]</option>                 
                    <%
                        //CompraDao CompDao = new CompraDaoImpl();

                        for(Comprobante c: CompDao.ListarCompVenta()){             

                    %>
                    <option value="<%=c.getIdComprobante()%>" <%if(id_configuracion.equals(c.getIdComprobante())){%> selected<%}%>> <%=c.getNombreComprobante()%></option>
                     <%}%>
                    </select>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-20 control-label" >Buscar Cliente:</label></td>
                    <td>
                        <div class="col-sm-20">
                            <input type="text" class="form-control" placeholder="Buscar cliente por DNI" name="cliente" value="<%=cliente%>">
                        </div>
                    </td>
                    <td><button type="submit" class="btn btn-primary">Buscar DNI</button></td>
                    <td><button type="button" class="btn btn-success" data-toggle="modal" data-target="#Modal"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></button></td>
                </tr>
                <tr>
                    <td><label class="col-sm-20 control-label">Cliente:</label></td>
                    <td colspan="3">
                        <select class="form-control" name="id_cliente" selected="selected" <%if(id_cliente.equals("")){%> selected<%}%>><option>[--Selecciona--]</option>                 
                        <%
                            PersonaDao dao = new PersonaDaoImpl();

                            for(Persona cli: dao.Listarcliente(cliente)){             

                        %>
                        <option value="<%=cli.getId_persona()%>" <%if(id_cliente.equals(cli.getId_persona())){%> selected<%}%>> <%=cli.getRazon_social()%></option>
                         <%}%>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-20 control-label">Cliente:</label></td>
                    <td colspan="3">
                        <select class="form-control" name="tipo_cliente" selected="selected" <%if(tipo_cliente.equals("")){%> selected<%}%>><option>[--Selecciona--]</option>                 
                        <%
                            for(CatCliente cc : dao.ListarCatCliente()){             

                        %>
                        <option value="<%=cc.getIdCategoria()%>" <%if(tipo_cliente.equals(cc.getIdCategoria())){%> selected<%}%>> <%=cc.getNombre()%></option>
                         <%}%>
                        </select>
                    </td>
                </tr>
                <tr>
                <td colspan="3" align="center">
                    <input type="submit" class="btn btn-primary" name="opcion" value="Continuar">
                </td>
                </tr>
                </tbody>
            </table>
        </form>
    </div>
    <div class="col-md-3"></div>
</div> 
<div class="modal fade" id="Modal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header" style="padding:35px 50px;">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4><span class="glyphicon glyphicon-lock"></span> Registrar</h4>
        </div>
        <div class="modal-body" style="padding:40px 50px;">    
        <form action="Venta.jsp" method="get"> 
                <table class="table table-condensed">
                    <tbody>
                <tr>
                    <td><label class="col-sm-12 control-label">Nombres:</label> </td> 
                    <td>
                        <div class="col-sm-15">
                            <input type="text" class="form-control" placeholder="Nombres" name="nombres" value="">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label">Apellidos:</label></td>
                    <td>
                        <div class="col-sm-15">
                            <input type="text" class="form-control" placeholder="Apellidos" name="apellidos" value="">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label">Raz&oacute;n Social</label></td>
                    <td>
                        <div class="col-sm-15">
                            <input type="text" class="form-control" placeholder="Razón Social" name="razon_social" value="">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label">Tipo Doc.:</label></td>
                    <td>
                        <select class="form-control" name="t_doc" selected="selected" >
                            <option>Seleciona el tipo de documento</option>
                        <%
                            TipoDocumentoDao tdd = new TipoDocumentoDaoImpl();

                            for(TipoDocumento tipoDoc:tdd.ListarTipoDocumento()){      

                        %>

                         <option value="<%=tipoDoc.getId_tipo_doc()%>" > <%=tipoDoc.getNombre()%></option>
                         <%}%>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label">N&deg; Doc:</label></td>
                    <td>
                        <div class="col-sm-15">
                            <input type="text" class="form-control" placeholder="Numero del documento" name="num_doc" value="">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label">RUC:</label></td>
                    <td>
                        <div class="col-sm-15">
                            <input type="text" class="form-control" placeholder="RUC" name="ruc" value="">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label" >Tel&eacute;fono:</label></td>
                    <td>
                        <div class="col-sm-15">
                            <input type="text" class="form-control" placeholder="Telefono" name="telefono" value="">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label" >Celular:</label></td>
                    <td>
                        <div class="col-sm-15">
                            <input type="text" class="form-control" placeholder="Celular" name="celular" value="">
                        </div>
                    </td>
                </tr>  
                <tr>
                    <td><label class="col-sm-12 control-label" >F. Nacimiento:</label></td>
                    <td>
                        <div class="col-sm-15">
                            <input type="date" class="form-control" placeholder="Fecha de nacimiento" name="fecha_nac" value="">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label">G&eacute;nero:</label></td>
                    <td>
                        <label class="radio-inline">
                            <input type="radio" name="genero" value="M"> Masculino
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="genero" value="F"> Femenino
                        </label>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label">Dirección:</label></td>
                    <td>
                        <div class="col-sm-15">
                            <textarea rows="3" class="form-control" placeholder="Dirección" name="direccion"></textarea>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-8 control-label">Cat. Cliente:</label></td>
                    <td>
                        <select class="form-control" name="id_categoria" selected="selected" <%if(id_categoria.equals("")){%> selected<%}%>>> 
                            <option>Seleciona el rol</option>
                        <%
                            TipoDocumentoDao td = new TipoDocumentoDaoImpl();

                            for(CatCliente cc : td.ListarCatCliente()){
                        %>
                         <option value="<%=cc.getIdCategoria()%>" <%if(t_doc.equals(cc.getIdCategoria())){%> selected<%}%>> <%=cc.getNombre()%></option>
                         <%}%>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" class="btn btn-primary" name="opcion" value="Registrar">
                        <input type="reset" class="btn btn-default" value="Limpiar">
                    </td> 
                </tr>
                </tbody>
            </table>
        </form>
      </div>
      </div>
    </div>
</div>
<%}%>
</div>
<%@include file="WEB-INF/jspf/botton.jspf" %>