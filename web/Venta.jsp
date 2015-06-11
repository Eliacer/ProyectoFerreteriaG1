
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
    String opcion = request.getParameter("opcion");opcion = opcion == null ? "Continuar" : opcion;
    String mensaje="";
    String alert="";
    
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
<%if(opcion.equals("Continuar")){%>
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
                    <td colspan="2">
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
                    <td colspan="2">
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
                </tr>
                <tr>
                    <td><label class="col-sm-20 control-label">Cliente:</label></td>
                    <td colspan="2">
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
                    <td colspan="2">
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