<%@page import="proy01.modelo.entidad.Rep_compras"%>
<%@page import="proy01.modelo.entidad.Compra"%>
<%@page import="proy01.modelo.daoImpl.CompraDaoImpl"%>
<%@page import="proy01.modelo.dao.CompraDao"%>
<%@page import="proy01.modelo.daoImpl.ProductoDaoImpl"%>
<%@page import="proy01.modelo.dao.ProductoDao"%>
<%@page import="proy01.modelo.entidad.Producto"%>
<%@include file="WEB-INF/jspf/top.jspf"%>

<div class="container">

<%
    //String buscar_por = request.getParameter("buscar_por");buscar_por = buscar_por==null?"nombre": buscar_por;
    //String buscar = request.getParameter("buscar");buscar = buscar==null?"": buscar;
    String opcion = request.getParameter("opcion");opcion = opcion == null ? "" : opcion;
    String id_producto = request.getParameter("id_producto");id_producto = id_producto == null ? "" : id_producto;
    String mensaje="";
    
    if(opcion.equals("eliminar")){
        
        if(!id_producto.equals("")){
            ProductoDao dao = new ProductoDaoImpl();
            if(dao.DeleteProducto(id_producto)){
                mensaje="Se eliminó correctamente.";
            }
        }
    }

%>
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
                            <td width="3%" bgcolor="#FFEFCE"><strong>#</strong></td>
                            <td width="9%" align="center" bgcolor="#FFEFCE"><strong>F. Compra</strong></td>
                            <td width="22%" bgcolor="#FFEFCE"><strong>Usuario</strong></td>
                            <td width="21%" bgcolor="#FFEFCE"><strong>Proveedor</strong></td>
                            <td width="11%" align="center" bgcolor="#FFEFCE"><strong>Comprobante</strong></td>
                            <td width="13%" align="center" bgcolor="#FFEFCE"><strong>Nro. Comprobante.</strong></td>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        String espacio="  ";
                        int count=0;
                        CompraDao cd = new CompraDaoImpl();
                        for(Rep_compras compra :cd.ListarCompraTotal()){
                             count++;
                        %>
          
                        <tr>     
                            <input type="hidden" name="id_compra"  value="<%=compra.getId_compra()%>" size="10">
                            <td><%=count%>.-</td> 
                            <td align="center"><%=compra.getFecha_compra()%></td>
                            <td><%=compra.getNombre_usuario()%></td>
                            <td align="center"><%=compra.getNombre_proveedor()%></td>
                            <td align="center"><%=compra.getNombre_comprobante()%></td>
                            <td align="center"><%=compra.getNum_com()%></td> 
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

