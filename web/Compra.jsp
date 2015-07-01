
<%@page import="proy01.modelo.entidad.TipoDocumento"%>
<%@page import="proy01.modelo.daoImpl.TipoDocumentoDaoImpl"%>
<%@page import="proy01.modelo.dao.TipoDocumentoDao"%>
<%@page import="proy01.modelo.entidad.Persona"%>
<%@page import="proy01.modelo.daoImpl.PersonaDaoImpl"%>
<%@page import="proy01.modelo.dao.PersonaDao"%>
<%@page import="proy01.modelo.entidad.Comprobante"%>
<%@page import="proy01.modelo.entidad.TipoMoneda"%>
<%@page import="proy01.modelo.entidad.FormaPago"%>
<%@page import="proy01.modelo.daoImpl.CompraDaoImpl"%>
<%@page import="proy01.modelo.dao.CompraDao"%>
<%@page import="java.util.*"%>
<jsp:useBean id="mensaje" scope="request" class="java.lang.String" />
<jsp:useBean id="id_compra" scope="request" class="java.lang.String" />
<jsp:useBean id="alert" scope="request" class="java.lang.String" />
<jsp:useBean id="proveedor" scope="request" class="java.lang.String" />
<jsp:useBean id="Compra" scope="request" class="proy01.modelo.entidad.Compra" />
<jsp:useBean id="opcion" scope="request" class="java.lang.String" />
<%@include file="WEB-INF/jspf/top.jspf" %>

<%
    if (opcion==null ||opcion.equals("")){opcion="Registrar";}
    
%>

<div class="container">
<div class="row">
    <div class="col-md-1"></div>
    <div class="col-md-10" id="aler">
        <br>
        <%
            if(!mensaje.equals("")){
        %>
        <div class="alert alert-<%=alert%>"><%=mensaje%></div> 
        <%}%>
    </div>
    <div class="col-md-1"></div>
</div>
<%if(opcion.equals("Registrar")||opcion.equals("Actualizando")){%>
<div class="row">
    <div class="col-xs-3 col-sm-3 col-md-3"></div>
    <div class="col-xs-6 col-sm-6 col-md-6 well">
        <h2>Registro de Compra</h2>
        <br><br>
        <form action="controlcompra" method="post">
            <table class="table table-condensed">
                <tbody>
                <tr>    
                    <td width="40%"><label class="col-sm-8 col-md-12 control-label" >Forma de pago:</label></td>
                    <td colspan="3">
                    <input type="hidden" name="opcion"  value="<%=opcion%>" size="10">
                    <input type="hidden" name="id_compra"  value="<%=id_compra%>" size="10">
                    <input type="hidden" name="id_usuario"  value="<%=id_usuario%>" size="10">
                    <select class="form-control" name="id_forma_pago" selected="selected" <%if(Compra.getId_formaPago().equals("")){%> selected<%}%>><option>[--Selecciona--]</option>                 
                    <%
                        CompraDao CompDao = new CompraDaoImpl();

                        for(FormaPago fp: CompDao.ListarFormapago()){             

                    %>
                    <option value="<%=fp.getIdFormaPago()%>" <%if(Compra.getId_formaPago().equals(fp.getIdFormaPago())){%> selected<%}%>> <%=fp.getNombre()%></option>
                     <%}%>
                    </select>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-8 col-md-12 control-label" >Tipo de Moneda:</label></td>
                    <td colspan="3">
                        <select class="form-control" name="id_moneda" selected="selected" <%if(Compra.getId_tipoMoneda().equals("")){%> selected<%}%>><option>[--Selecciona--]</option>                 
                        <%
                           for(TipoMoneda tm: CompDao.ListarMoneda()){             
                        %>
                        <option value="<%=tm.getIdMoneda()%>" <%if(Compra.getId_tipoMoneda().equals(tm.getIdMoneda())){%> selected<%}%>> <%=tm.getNombre()%></option>
                         <%}%>
                        </select>
                    </td>   
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label" >Comprobante:</label></td>
                    <td colspan="3">
                    <select class="form-control" name="id_comprobante" selected="selected" <%if(Compra.getId_comprobante().equals("")){%> selected<%}%>><option>[--Selecciona--]</option>                 
                    <%
                        for(Comprobante c: CompDao.ListarComprobante()){             
                    %>
                    <option value="<%=c.getIdComprobante()%>" <%if(Compra.getId_comprobante().equals(c.getIdComprobante())){%> selected<%}%>> <%=c.getNombreComprobante()%></option>
                     <%}%>
                    </select>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label" >Numero **: </label></td>
                    <td colspan="3">
                        <div class="col-sm-15">
                            <input type="text" class="form-control" placeholder="N° de Comprobante" name="num_comp" value="<%=Compra.getNumComprobante()%>" maxlength="10">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label" >Buscar Prov.</label></td>
                    <td>
                        <div class="col-sm-15">
                            <input type="text" class="form-control" placeholder="Buscar Proveedor" name="proveedor" value="">
                        </div>
                    </td>
                    <td><button type="submit" class="btn btn-primary">Buscar</button></td>
                    <td><button type="button" class="btn btn-success" data-toggle="modal" data-target="#Modal"><span class="glyphicon glyphicon-edit" aria-hidden="true" title="Registrar"></span></button></td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label">Proveedor:</label></td>
                    <td colspan="3">
                        <select multiple class="form-control" name="id_proveedor" selected="selected" >                
                        <%
                            PersonaDao dao = new PersonaDaoImpl();
                            for(Persona prov: dao.ListarProveedor(proveedor)){             
                            
                        %>
                        <option value="<%=prov.getId_persona()%>" <%if(Compra.getId_proveedor().equals(prov.getId_persona())){%> selected<%}%>> <%=prov.getRazon_social()%></option>
                         <%}%>
                        </select>
                    </td>
                </tr>
                <%if(!opcion.equals("Actualizando")){%>
                <tr>
                    <td><label class="col-sm-12 control-label" >F. Compra:</label></td>
                    <td colspan="3">
                        <div class="col-sm-15">
                            <input type="date" class="form-control" name="fecha_comp" value="<%=Compra.getFechaCompra()%>">
                        </div> 
                    </td>
                </tr>
                <%}%>
                <tr>
                    <td><label class="col-sm-12 control-label" >IGV:</label></td>
                    <td colspan="3">
                        <div class="col-sm-15">
                            <input type="text" class="form-control" placeholder="IGV" name="igv" value="<%=Compra.getIgv()%>">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label" >Flete:</label></td>
                    <td colspan="3">
                        <div class="col-sm-15">
                            <input type="text" class="form-control" placeholder="Flete" name="flete" value="<%=Compra.getFlete()%>">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label class="col-sm-12 control-label" >Descripcion:</label></td>
                    <td colspan="3">
                        <div class="col-sm-15">
                            <textarea rows="3" class="form-control" placeholder="Descripcción" name="descripcion" value="<%=Compra.getDescripcion()%>" maxlength="200"></textarea>
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
        <form action="controlcompra" method="post"> 
            <input type="hidden" name="opcion" value="RegistrarProveedor">
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
                    <td><label class="col-sm-7 control-label">Correo:</label></td>
                    <td>
                        <div class="col-sm-15">
                            <input rows="3" class="form-control" placeholder="Correo Electrónico" name="correo" value="" required="">
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