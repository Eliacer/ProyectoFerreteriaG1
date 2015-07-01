<%@page import="proy01.modelo.entidad.KardexProducto"%>
<%@page import="proy01.modelo.daoImpl.FijarPreciosCompraDaoImpl"%>
<%@page import="proy01.modelo.dao.FijarPreciosCompraDao"%>
<%@page import="proy01.modelo.entidad.Rep_Inventario"%>
<%@page import="proy01.modelo.daoImpl.ProductoDaoImpl"%>
<%@page import="proy01.modelo.dao.ProductoDao"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Kardex</title>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
</head>
  <body>     
      <%
          String id_producto=request.getParameter("id_producto");id_producto = id_producto==null?"":id_producto;
      %>
<div class="container">
    <br>
    <div class="row">
        <div class="col-md-12">
            <h3 align="center">Kardex del Producto</h3><br>
            <hr>
            <div class="tab-pane">
                <table class="table table-hover table-striped table-bordered">
                    <thead>
                        <tr>
                            <td width="9%" bgcolor="#FFEFCE"><strong>Fecha</strong></td>
                            <td width="6%" align="center" bgcolor="#FFEFCE"><strong>Mov.</strong></td>
                            <td width="18%" bgcolor="#FFEFCE"><strong>Producto</strong></td>
                            <td width="9%" align="center" bgcolor="#FFEFCE"><strong>Cant</strong></td>
                            <td width="9%" bgcolor="#FFEFCE"><strong>Comprob.</strong></td>
                            <td width="9%" bgcolor="#FFEFCE"><strong>N&deg; Comp.</strong></td>
                            <td width="20%" bgcolor="#FFEFCE"><strong>Proveedor o Cliente </strong></td>
                        </tr>
                    </thead>
                    <tbody>
                        <%  
                        int count=0;
                        FijarPreciosCompraDao dao= new FijarPreciosCompraDaoImpl() ;
                        for(KardexProducto producto:dao.Kardexproducto(id_producto)){
                             count++;                           
                        %>         
                        <tr onmouseover="this.style.backgroundColor = '#ECE0F8';" onmouseout="this.style.backgroundColor = 'white';" style="background-color: white ;">     
                            <td><%=producto.getFecha()%></td>
                            <td align="center"><%=producto.getMovimiento()%></td>
                            <td><%=producto.getProducto()%></td>
                            <td align="center"><%=producto.getCantidad()%><%=producto.getUnd()%></td>
                            <td><%=producto.getComprobante()%></td>
                            <td><%=producto.getNum_comp()%></td>
                            <td><%=producto.getProv_cliente()%></td>
                        </tr>
                        <%}%>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>


