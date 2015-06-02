<%@page import="proy01.modelo.daoImpl.ProductoDaoImpl"%>
<%@page import="proy01.modelo.dao.ProductoDao"%>
<%@page import="proy01.modelo.entidad.Producto"%>
<%@include file="WEB-INF/jspf/top.jspf"%>

<div class="container">

<%
    String buscar_por = request.getParameter("buscar_por");buscar_por = buscar_por==null?"nombre": buscar_por;
    String buscar = request.getParameter("buscar");buscar = buscar==null?"": buscar;
    String opcion = request.getParameter("opcion");opcion = opcion == null ? "" : opcion;
    String id_producto = request.getParameter("id_producto");id_producto = id_producto == null ? "" : id_producto;
    String mensaje="";
    
    if(opcion.equals("eliminar")){
        
        if(!id_producto.equals("")){
            ProductoDao dao = new ProductoDaoImpl();
            if(dao.DeleteProducto(id_producto)){
                mensaje="Se eliminó correctamente.";
            }
            else{
                mensaje="No se puede eliminar este producto....";
            }
        }
    }

%>
<br><br>
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10">
            <form class="form-horizontal" action="Rep_Productos.jsp" method="post">              
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
                              <button type="submit" class="btn btn-primary">Buscar</button>
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
            <div class="alert alert-danger"><%=mensaje%></div> 
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
                            <td width="28%" bgcolor="#FFEFCE"><strong>Nombre del Producto</strong></td>
                            <td width="10%" align="center" bgcolor="#FFEFCE"><strong>Marca</strong></td>
                            <td width="9%" bgcolor="#FFEFCE"><strong>Concentr.</strong></td>
                            <td width="9%" align="center" bgcolor="#FFEFCE"><strong>Costo</strong></td>
                            <td width="9%" align="center" bgcolor="#FFEFCE"><strong>Stock</strong></td>
                            <td width="12%" align="center" bgcolor="#FFEFCE"><strong>Ubicacion</strong></td>
                            <td width="18%" align="center" bgcolor="#FFEFCE"><strong>Opciones</strong></td>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        String espacio="  ";
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
                            <td align="center"><%=producto.getCosto()%></td>
                            <td align="center"><%=producto.getStock_actual()%></td> 
                            <td align="center"><%=producto.getId_ubicacion()%></td>
                            <td>
                                <a href="Registro_productos.jsp?opcion=Actualizar&id_producto=<%=producto.getIdProducto()%>">[Actualizar]<%=espacio%></a>
                                <a href="Rep_Productos.jsp?opcion=eliminar&id_producto=<%=producto.getIdProducto()%>">[Eliminar]</a></td>
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

