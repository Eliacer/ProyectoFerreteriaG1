

<%@page import="proy01.modelo.entidad.TipoDocumento"%>
<%@page import="proy01.modelo.daoImpl.TipoDocumentoDaoImpl"%>
<%@page import="proy01.modelo.dao.TipoDocumentoDao"%>
<%@page import="proy01.modelo.entidad.CatCliente"%>
<%@page import="proy01.modelo.entidad.Persona"%>
<%@page import="proy01.modelo.daoImpl.PersonaDaoImpl"%>
<%@page import="proy01.modelo.dao.PersonaDao"%>
<%@page import="proy01.modelo.entidad.Comprobante"%>
<%@page import="proy01.modelo.entidad.FormaPago"%>
<%@page import="proy01.modelo.daoImpl.VentaDaoImpl"%>
<%@page import="proy01.modelo.dao.VentaDao"%>
<%@include file="WEB-INF/jspf/top.jspf" %>
<jsp:useBean id="mensaje" scope="request" class="java.lang.String" />
<jsp:useBean id="alert" scope="request" class="java.lang.String" />
<jsp:useBean id="cliente" scope="request" class="java.lang.String" />
<jsp:useBean id="id_venta" scope="request" class="java.lang.String" />
<jsp:useBean id="Cliente" scope="request" class="proy01.modelo.entidad.Cliente" />
<jsp:useBean id="Venta" scope="request" class="proy01.modelo.entidad.Venta" />
<jsp:useBean id="opcion" scope="request" class="java.lang.String" />

<%
    if (opcion==null ||opcion.equals("")){opcion="Registrar";}
    cliente = cliente == null?"" : cliente;
    
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
<%if(opcion.equals("Registrar")||opcion.equals("Actualizando")){%>
<div class="row">
    <div class="col-md-3"></div>
    <div class="col-md-6 well">
        <h2>Registrar Ventas</h2>
        <br><br>
        <form action="controlventa" method="post">
            <table class="table table-condensed">
                <tbody>
                <tr>    
                    <td width="30%"><label class="col-sm-20 control-label" >Forma de pago:</label></td>
                    <td colspan="3">
                    <input type="hidden" name="opcion"  value="<%=opcion%>" size="10">
                    <input type="hidden" name="id_usuario"  value="<%=id_usuario%>" size="10">
                    <input type="hidden" name="id_venta"  value="<%=id_venta%>" size="10">
                    <select class="form-control" name="id_forma_pago" selected="selected" <%if(Venta.getId_formaPago().equals("")){%> selected<%}%>><option>[--Selecciona--]</option>                 
                    <%
                        VentaDao CompDao = new VentaDaoImpl();
                        for(FormaPago fp: CompDao.ListarFormapago()){             
                    %>
                    <option value="<%=fp.getIdFormaPago()%>" <%if(Venta.getId_formaPago().equals(fp.getIdFormaPago())){%> selected<%}%>> <%=fp.getNombre()%></option>
                     <%}%>
                    </select>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-20 control-label" >Comprobante:</label></td>
                    <td colspan="3">
                    <select class="form-control" name="id_configuracion" selected="selected" <%if(Venta.getId_configuracion().equals("")){%> selected<%}%>><option>[--Selecciona--]</option>                 
                    <%
                        for(Comprobante c: CompDao.ListarCompVenta()){             
                    %>
                    <option value="<%=c.getIdComprobante()%>" <%if(Venta.getId_configuracion().equals(c.getIdComprobante())){%> selected<%}%>> <%=c.getNombreComprobante()%></option>
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
                        <select multiple class="form-control" name="id_cliente" selected="selected" >               
                        <%
                            PersonaDao dao = new PersonaDaoImpl();
                            for(Persona cli: dao.Listarcliente(cliente)){             
                        %>
                        <option value="<%=cli.getId_persona()%>" <%if(Venta.getId_cliente().equals(cli.getId_persona())){%> selected<%}%>> <%=cli.getRazon_social()%></option>
                         <%}%>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-20 control-label">Tipo Cliente:</label></td>
                    <td colspan="3">
                        <select class="form-control" name="tipo_cliente" selected="selected" <%if(Venta.getIdTipoCliente().equals("")){%> selected<%}%>><option>[--Selecciona--]</option>                 
                        <%
                            for(CatCliente cc : dao.ListarCatCliente()){             
                        %>
                        <option value="<%=cc.getIdCategoria()%>" <%if(Venta.getIdTipoCliente().equals(cc.getIdCategoria())){%> selected<%}%>> <%=cc.getNombre()%></option>
                         <%}%>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label" >IGV:</label></td>
                    <td colspan="3">
                        <div class="col-sm-15">
                            <input type="text" class="form-control" placeholder="IGV" name="igv" value="<%=Venta.getIgv()%>">
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
<div class="modal fade" id="Modal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header" style="padding:35px 50px;">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4><span class="glyphicon glyphicon-lock"></span> Registrar</h4>
        </div>
        <div class="modal-body" style="padding:40px 50px;">    
        <form action="controlventa" method="post"> 
            <table class="table table-condensed">
                <tbody>
                <input type="hidden" name="opcion" value="RegistrarCliente">    
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
                            <option value="00004">Selecciona el tipo de documento</option>
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
                            <input type="text" class="form-control" placeholder="Numero del documento" name="num_doc" value="" maxlength="8">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label">RUC:</label></td>
                    <td>
                        <div class="col-sm-15">
                            <input type="text" class="form-control" placeholder="RUC" name="ruc" value="" maxlength="11">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label" >Tel&eacute;fono:</label></td>
                    <td>
                        <div class="col-sm-15">
                            <input type="text" class="form-control" placeholder="Telefono" name="telefono" value="" maxlength="10">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label" >Celular:</label></td>
                    <td>
                        <div class="col-sm-15">
                            <input type="text" class="form-control" placeholder="Celular" name="celular" value="" maxlength="9">
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
                        <select class="form-control" name="id_categoria" selected="selected" <%if(Cliente.getIdTipoCliente().equals("")){%> selected<%}%>>> 
                            <option>Seleciona el rol</option>
                        <%
                            TipoDocumentoDao td = new TipoDocumentoDaoImpl();

                            for(CatCliente cc : td.ListarCatCliente()){
                        %>
                         <option value="<%=cc.getIdCategoria()%>" <%if(Cliente.getIdTipoCliente().equals(cc.getIdCategoria())){%> selected<%}%>> <%=cc.getNombre()%></option>
                         <%}%>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" class="btn btn-primary" value="Registrar">
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