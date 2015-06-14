<%@page import="proy01.modelo.entidad.Rep_Inventario"%>
<%@page import="proy01.modelo.daoImpl.ProductoDaoImpl"%>
<%@page import="proy01.modelo.dao.ProductoDao"%>
<!DOCTYPE html>
<!-- saved from url=(0040)http://getbootstrap.com/examples/signin/ -->
    <html lang="en"><head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">   
    <link rel="shortcut icon" type="image/x-icon" href="recursos/img/favicon.ico"/>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/estilo_1.css" rel="stylesheet">
    <link href="css/estilo.css" rel="stylesheet">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
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
</body>
</html>
<%@include file="WEB-INF/jspf/botton.jspf"%>

