<%@page import="proy01.modelo.entidad.Rep_Inventario"%>
<%@page import="proy01.modelo.daoImpl.ProductoDaoImpl"%>
<%@page import="proy01.modelo.dao.ProductoDao"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Inventario</title>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
        <link rel="stylesheet" href="css/estilo.css">
</head>
  <body>
<div class="container">
    <br>
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10">
            <h3 align="center">Inventario de productos</h3><br>
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
                            <td><a class="btn" href="Kardex.jsp?id_producto=<%=producto.getId_producto()%>"><%=producto.getProducto()%></a></td>
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
</body>
</html>


