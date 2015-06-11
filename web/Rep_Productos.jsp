<%@page import="proy01.modelo.entidad.Rep_Inventario"%>
<%@page import="proy01.modelo.daoImpl.ProductoDaoImpl"%>
<%@page import="proy01.modelo.dao.ProductoDao"%>
<%@include file="WEB-INF/jspf/top.jspf"%>

<div class="container">

<%
    String buscar_por = request.getParameter("buscar_por");buscar_por = buscar_por==null?"nombre": buscar_por;
    String buscar = request.getParameter("buscar");buscar = buscar==null?"": buscar;
    String opcion = request.getParameter("opcion");opcion = opcion == null ? "" : opcion;
    String id_producto = request.getParameter("id_producto");id_producto = id_producto == null ? "" : id_producto;
    String mensaje="";

%>
<br><br>

</div>
<div class="container">
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10 well">
            <h3 align="center">Inventario de productos</h3>
            <hr>
            <div class="tab-pane">
                <table class="table table-hover table-striped table-bordered">
                    <thead>
                        <tr>
                            <td width="5%" bgcolor="#FFEFCE"><strong>#</strong></td>
                            <td width="28%" bgcolor="#FFEFCE"><strong>Nombre del Producto</strong></td>
                            <td width="9%" align="center" bgcolor="#FFEFCE"><strong>Stock</strong></td>
                            <td width="9%" align="center" bgcolor="#FFEFCE"><strong>Costo</strong></td>
                            <td width="12%" align="center" bgcolor="#FFEFCE"><strong>Precio</strong></td>
                            <td width="12%" align="center" bgcolor="#FFEFCE"><strong>Utilidad</strong></td>
                        </tr>
                    </thead>
                    <tbody>
                        <%  
                        String porc=" %";
                        String espacio="  ";
                        int count=0;
                        ProductoDao dao = new ProductoDaoImpl();
                        for(Rep_Inventario producto :dao.ListarInventProducto()){
                             count++;
                            
                        %>
          
                        <tr>     
                            <td><%=count%>.-</td> 
                            <td><%=producto.getProducto()%></td>
                            <td align="center"><%=producto.getStock_actual()%></td>
                            <td align="center"><%=producto.getCosto()%></td>
                            <td align="center"><%=producto.getPrecio()%></td>
                            <td align="center"><%=producto.getUtilidad()+porc%></td>
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

