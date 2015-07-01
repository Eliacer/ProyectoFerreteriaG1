<%@page import="proy01.modelo.daoImpl.ProductoDaoImpl"%>
<%@page import="proy01.modelo.dao.ProductoDao"%>
<%@page import="proy01.modelo.entidad.Producto"%>
<jsp:useBean id="mensaje" scope="request" class="java.lang.String" />
<jsp:useBean id="alert" scope="request" class="java.lang.String" />
<jsp:useBean id="buscar_por" scope="request" class="java.lang.String" />
<jsp:useBean id="buscar" scope="request" class="java.lang.String" />
<%@include file="WEB-INF/jspf/top.jspf"%>

<div class="container">
<br><br>
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10">
            <form class="form-horizontal" action="controlproducto?opcion=Buscar" method="post">              
                <div class="form-group">
                    <label class="control-label col-xs-3">Buscar Por: </label>
                    <div class="col-xs-3">
                        <select class="form-control" name="buscar_por">
                            <option value="nombre">Nombre del producto</option>
                            <option value="codigo">C&oacute;digo del producto</option>
                        </select>
                    </div>
                    <div class="col-xs-5">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Realiza la b&uacute;squeda aqu&iacute;" name="buscar">
                            <span class="input-group-btn">
                              <button type="submit" class="btn btn-success">Buscar<span class="glyphicon glyphicon-search" aria-hidden="true"></span></button>
                            </span>
                        </div><!-- /input-group -->
                    </div>  
                </div>
            </form>
        </div>
        <div class="col-md-1"></div>
    </div>
<br>
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
</div>
<div class="container">
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10 well">
            <div class="tab-pane">
                <table class="table table-hover table-striped table-bordered">
                    <thead>
                        <tr>
                            <td width="5%" bgcolor="#FFEFCE"><strong>#</strong></td>
                            <td width="30%" bgcolor="#FFEFCE"><strong>Nombre del Producto</strong></td>
                            <td width="10%" align="center" bgcolor="#FFEFCE"><strong>Marca</strong></td>
                            <td width="9%" align="center" bgcolor="#FFEFCE"><strong>Unidad</strong></td>
                            <td width="9%" align="center" bgcolor="#FFEFCE"><strong>Costo</strong></td>
                            <td width="9%" align="center" bgcolor="#FFEFCE"><strong>Stock</strong></td>
                            <td width="12%" align="center" bgcolor="#FFEFCE"><strong>Ubicacion</strong></td>
                            <td width="12%" align="center" bgcolor="#FFEFCE" colspan="2"><strong>Opciones</strong></td>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        String espacio="        ";
                        int count=0;
                        ProductoDao dao = new ProductoDaoImpl();
                        for(Producto producto :dao.BuscarProducto(buscar_por, buscar)){
                             count++;
                             String marca=producto.getId_marca();marca = marca==null?"":marca; 
                        %>
          
                        <tr>     
                            <input type="hidden" name="id_producto"  value="<%=producto.getIdProducto()%>" size="10">
                            <td><%=count%>.-</td> 
                            <td><%=producto.getNombre()%></td>
                            <td align="center"><%=marca%></td>
                            <td align="center"><%=producto.getIdUndMedida()%></td>
                            <td align="center"><%=producto.getPrecio()%></td>
                            <td align="center"><%=producto.getStock_actual()%></td> 
                            <td align="center"><%=producto.getId_ubicacion()%></td>
                            <td align="center">
                                <a href="controlproducto?opcion=Actualizar&id_producto=<%=producto.getIdProducto()%>" title="Actualizar">
                                <button type="button" class="btn btn-info"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span></button><%=espacio%></a>
                            </td>
                            <td>
                                <a href="controlproducto?opcion=Eliminar&id_producto=<%=producto.getIdProducto()%>" title="Eliminar">
                                <button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button></a>
                            </td>
                        </tr>
                        <%}%>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="col-md-1"></div>
    </div>
</div>
<%@include file="WEB-INF/jspf/botton.jspf"%>

