
<%@page import="proy01.modelo.entidad.Proveedor"%>
<%@page import="proy01.modelo.entidad.TipoDocumento"%>
<%@page import="proy01.modelo.dao.TipoDocumentoDao"%>
<%@page import="java.util.*"%>
<%@page import="proy01.modelo.daoImpl.TipoDocumentoDaoImpl"%>
<%@page import="proy01.modelo.daoImpl.CompraDaoImpl"%>
<%@page import="proy01.modelo.dao.CompraDao"%>
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
    String opcion = request.getParameter("opcion");opcion = opcion == null ? "Continuar" : opcion;
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
    
    if(opcion.equals("Registrar")){
        if((!nombres.equals("") || !razon_social.equals("")) && !t_doc.equals("")&& (!num_doc.equals("")||!ruc.equals(""))
            && (!telefono.equals("") || !celular.equals(""))){
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

                    Proveedor proveed = new Proveedor();
                    PersonaDao dao= new PersonaDaoImpl();

                    persona =dao.ObtenerPersonaDni(num_doc);
                    id_proveedor=persona.getId_persona();   

                    proveed.setId_proveedor(id_proveedor);
                    proveed.setCorreo_electronico(correo);
                    proveed.setNum_cuenta(num_cuenta);
                    if(dao.RegistrarProveedor(proveed)){
                        alert="info";
                        opcion="Continuar";
                        mensaje = "Se registró corerctamente el proveedor...";             

                    }
                    else{
                        alert="danger";
                        opcion="Continuar";
                        mensaje = "Ocurrio un error...";             

                    }
                }
            }
        }
    }
    
    if(opcion.equals("Continuar")){
        
        if(!id_proveedor.equals("") && !id_moneda.equals("") &&!id_comprobante.equals("")
                && !num_comp.equals("") && !id_forma_pago.equals("") && !fecha_comp.equals("")){

            Compra compra = new Compra();
            CompraDao cd = new CompraDaoImpl();
            
            igv = igv.equals("")?"0":igv;
            flete = flete.equals("")?"0":flete;
            
            compra.setId_usuario(id);
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
                opcion="ok";
                alert="info";
                response.sendRedirect("buyproducts?num_comp="+num_comp);
               // mensaje="Se registro correctamente la compra...<a href='Detalle_compra.jsp'>[Detallar Compra] </a>";        
            }
            else{
                alert="danger";
                mensaje="No se pudo registrar la compra...";
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
<%if(opcion.equals("Continuar")){%>
<div class="row">
    <div class="col-xs-3 col-sm-3 col-md-3"></div>
    <div class="col-xs-6 col-sm-6 col-md-6 well" id="reg2">
        <h2>Registro de Compra</h2>
        <br><br>
        <form action="Compra.jsp" method="post">
            <table class="table table-condensed">
                <tbody>
                <tr>    
                    <td><label class="col-sm-8 col-md-12 control-label" >Forma de pago:</label></td>
                    <td colspan="3">
                        <input type="hidden" name="id_usuario"  value="<%=id%>" size="10">
                    <select class="form-control" name="id_forma_pago" selected="selected" <%if(id_comprobante.equals("")){%> selected<%}%>><option>[--Selecciona--]</option>                 
                    <%
                        CompraDao CompDao = new CompraDaoImpl();

                        for(FormaPago fp: CompDao.ListarFormapago()){             

                    %>
                    <option value="<%=fp.getIdFormaPago()%>" <%if(id_comprobante.equals(fp.getIdFormaPago())){%> selected<%}%>> <%=fp.getNombre()%></option>
                     <%}%>
                    </select>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-8 col-md-12 control-label" >Tipo de Moneda:</label></td>
                    <td colspan="3">
                        <select class="form-control" name="id_moneda" selected="selected" <%if(id_comprobante.equals("")){%> selected<%}%>><option>[--Selecciona--]</option>                 
                        <%
                           for(TipoMoneda tm: CompDao.ListarMoneda()){             
                        %>
                        <option value="<%=tm.getIdMoneda()%>" <%if(id_comprobante.equals(tm.getIdMoneda())){%> selected<%}%>> <%=tm.getNombre()%></option>
                         <%}%>
                        </select>
                    </td>   
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label" >Comprobante:</label></td>
                    <td colspan="3">
                    <select class="form-control" name="id_comprobante" selected="selected" <%if(id_comprobante.equals("")){%> selected<%}%>><option>[--Selecciona--]</option>                 
                    <%
                        //CompraDao CompDao = new CompraDaoImpl();

                        for(Comprobante c: CompDao.ListarComprobante()){             

                    %>
                    <option value="<%=c.getIdComprobante()%>" <%if(id_comprobante.equals(c.getIdComprobante())){%> selected<%}%>> <%=c.getNombreComprobante()%></option>
                     <%}%>
                    </select>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label" >Numero **: </label></td>
                    <td colspan="3">
                        <div class="col-sm-15">
                            <input type="text" class="form-control" placeholder="N° de Comprobante" name="num_comp" value="<%=num_comp%>">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label" >Buscar Prov.</label></td>
                    <td>
                        <div class="col-sm-15">
                            <input type="text" class="form-control" placeholder="Buscar Proveedor" name="proveedor" value="<%=proveedor%>">
                        </div>
                    </td>
                    <td><button type="submit" class="btn btn-primary">Buscar</button></td>
                    <td><button type="button" class="btn btn-success" data-toggle="modal" data-target="#Modal"><span class="glyphicon glyphicon-edit" aria-hidden="true"></span></button></td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label">Proveedor:</label></td>
                    <td colspan="3">
                        <select class="form-control" name="id_proveedor" selected="selected" <%if(id_proveedor.equals("")){%> selected<%}%>><option>[--Selecciona--]</option>                 
                        <%
                            PersonaDao dao = new PersonaDaoImpl();
                            for(Persona prov: dao.ListarProveedor(proveedor)){             
                            
                        %>
                        <option value="<%=prov.getId_persona()%>" <%if(id_proveedor.equals(prov.getId_persona())){%> selected<%}%>> <%=prov.getRazon_social()%></option>
                         <%}%>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label" >F. Compra:</label></td>
                    <td colspan="3">
                        <div class="col-sm-15">
                            <input type="date" class="form-control" name="fecha_comp" value="<%=fecha_comp%>">
                        </div> 
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label" >IGV:</label></td>
                    <td colspan="3">
                        <div class="col-sm-15">
                            <input type="text" class="form-control" placeholder="IGV" name="igv" value="<%=igv%>">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label" >Flete:</label></td>
                    <td colspan="3">
                        <div class="col-sm-15">
                            <input type="text" class="form-control" placeholder="Flete" name="flete" value="<%=flete%>">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label" >Descripcion:</label></td>
                    <td colspan="3">
                        <div class="col-sm-15">
                            <textarea rows="3" class="form-control" placeholder="Descripcción" name="descripcion" value="<%=descripcion%>"></textarea>
                        </div>
                    </td>
                </tr>
                <tr>
                <td colspan="4" align="center">
                    <input type="submit" class="btn btn-primary" value="<%=opcion%>">
                </td>
                </tr>
                </tbody>
            </table>
        </form>
    </div>
    <div class="col-xs-3 col-sm-3 col-md-3"></div>
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
        <form action="Compra.jsp" method="post"> 
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
                    <td><label class="col-sm-7 control-label">Correo:</label></td>
                    <td>
                        <div class="col-sm-15">
                            <input rows="3" class="form-control" placeholder="Correo Electrónico" name="correo" value="">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-7 control-label">N&deg; Cta. Cte.</label></td>
                    <td>
                        <div class="col-sm-15">
                            <input rows="3" class="form-control" placeholder="Número de Cuenta" name="num_cuenta" value="">
                        </div>
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