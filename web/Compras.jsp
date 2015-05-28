
<%@page import="proy01.modelo.entidad.Compra"%>
<%@page import="proy01.modelo.entidad.TipoMoneda"%>
<%@page import="proy01.modelo.entidad.FormaPago"%>
<%@page import="proy01.modelo.daoImpl.CompraDaoImpl"%>
<%@page import="proy01.modelo.dao.CompraDao"%>
<%@page import="proy01.modelo.daoImpl.PersonaDaoImpl"%>
<%@page import="proy01.modelo.dao.PersonaDao"%>
<%@page import="proy01.modelo.entidad.Persona"%>
<%@page import="proy01.modelo.entidad.Comprobante"%>
<%@page import="proy01.modelo.daoImpl.CaracteristicasProductoDaoImpl"%>
<%@page import="proy01.modelo.dao.CaracteristicasProductoDao"%>
<%@include file="WEB-INF/jspf/top.jspf" %>

<%
    String id_usuario=request.getParameter("id_usuario");id_usuario = id_usuario==null?"":id_usuario;
    String id_comprobante=request.getParameter("id_comprobante");id_comprobante = id_comprobante==null?"":id_comprobante;
    String num_comp=request.getParameter("num_comp");num_comp = num_comp==null?"":num_comp;
    String id_forma_pago=request.getParameter("id_forma_pago");id_forma_pago = id_forma_pago==null?"":id_forma_pago;
    String id_moneda=request.getParameter("id_moneda");id_moneda = id_moneda==null?"":id_moneda;
    //String id_compra=request.getParameter("id_compra");id_compra = id_compra==null?"":id_compra;
    String id_proveedor=request.getParameter("id_proveedor");id_proveedor = id_proveedor==null?"":id_proveedor;
    String proveedor=request.getParameter("proveedor");proveedor = proveedor==null?"":proveedor;//busqueda....
    String fecha_comp=request.getParameter("fecha_comp");fecha_comp = fecha_comp==null?"":fecha_comp;  
    String igv=request.getParameter("igv");igv = igv==null?"":igv;
    String flete=request.getParameter("flete");flete = flete==null?"":flete;
    String descripcion=request.getParameter("descripcion");descripcion = descripcion==null?"":descripcion;
    String opcion = request.getParameter("opcion");opcion = opcion == null ? "Continuar" : opcion;
    String mensaje="";
    String alert="";
    if(opcion.equals("Continuar")){
        
    id_usuario="P-EL2405201507120733";
        if(!id_usuario.equals("") && !id_proveedor.equals("") && !id_moneda.equals("") &&!id_comprobante.equals("")
                && !num_comp.equals("") && !id_forma_pago.equals("") && !fecha_comp.equals("")){

            Compra compra = new Compra();
            CompraDao cd = new CompraDaoImpl();
            
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
                opcion="ok";
                alert="info";
                mensaje="Se registro correctamente la compra...";        
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
    <div class="col-md-3"></div>
    <div class="col-md-6 well">
        <h2>Registro de Compra</h2>
        <br><br>
        <form action="Compras.jsp" method="get">
            <table class="table table-condensed">
                <tbody>
                <tr>    
                    <td><label class="col-sm-12 control-label" >Forma de pago:</label></td>
                    <td colspan="2">
                        <input type="hidden" name="id_usuario"  value="<%=id_usuario%>" size="10">
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
                    <td><label class="col-sm-12 control-label" >Tipo de Moneda:</label></td>
                    <td colspan="2">
                        <select class="form-control" name="id_moneda" selected="selected" <%if(id_comprobante.equals("")){%> selected<%}%>><option>[--Selecciona--]</option>                 
                        <%
                            //CompraDao CompDao = new CompraDaoImpl();

                            for(TipoMoneda tm: CompDao.ListarMoneda()){             

                        %>
                        <option value="<%=tm.getIdMoneda()%>" <%if(id_comprobante.equals(tm.getIdMoneda())){%> selected<%}%>> <%=tm.getNombre()%></option>
                         <%}%>
                        </select>
                    </td>   
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label" >Comprobante:</label></td>
                    <td colspan="2">
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
                    <td colspan="2">
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
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label">Proveedor:</label></td>
                    <td colspan="2">
                        <select class="form-control" name="id_proveedor" selected="selected" <%if(id_proveedor.equals("")){%> selected<%}%>><option>[--Selecciona--]</option>                 
                        <%
                            PersonaDao dao = new PersonaDaoImpl();

                            for(Persona prov: dao.ListarProveedor(proveedor)){             

                        %>
                        <option value="<%=prov.getId_persona()%>" <%if(id_proveedor.equals(prov.getId_persona())){%> selected<%}%>> <%=prov.getNombre_razon()%></option>
                         <%}%>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label" >F. Compra:</label></td>
                    <td colspan="2">
                        <div class="col-sm-15">
                            <input type="date" class="form-control" name="fecha_comp" value="<%=fecha_comp%>">
                        </div> 
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label" >IGV:</label></td>
                    <td colspan="2">
                        <div class="col-sm-15">
                            <input type="text" class="form-control" placeholder="IGV" name="igv" value="<%=igv%>">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label" >Flete:</label></td>
                    <td colspan="2">
                        <div class="col-sm-15">
                            <input type="text" class="form-control" placeholder="Flete" name="flete" value="<%=flete%>">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label" >Descripcion:</label></td>
                    <td colspan="2">
                        <div class="col-sm-15">
                            <textarea rows="3" class="form-control" placeholder="Descripcción" name="descripcion" value="<%=descripcion%>"></textarea>
                        </div>
                    </td>
                </tr>
                <tr>
                <td colspan="3" align="center">
                    <input type="submit" class="btn btn-primary" value="<%=opcion%>">
                </td>
                </tr>
                </tbody>
            </table>
        </form>
    </div>
    <div class="col-md-3"></div>
</div> 
<%}%>
</div>
<%@include file="WEB-INF/jspf/botton.jspf" %>