
<%@page import="proy01.modelo.daoImpl.CompraDaoImpl"%>
<%@page import="proy01.modelo.dao.CompraDao"%>
<%@page import="proy01.modelo.entidad.Rep_compras"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Reportes de Compras</title>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
</head>
  <body>

<div class="container">

<%
    String f_in = request.getParameter("f_in");f_in = f_in == null ? "" : f_in;
    String f_fn = request.getParameter("f_fn");f_fn = f_fn == null ? "" : f_fn;
    String mensaje="";
     

%>

    <div class="row">
        <h3 align="center">Reportes de Compras</h3><br>
        <div class="col-md-12 well">
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
                        for(Rep_compras compra :cd.ListarCompraTotal(f_in, f_fn)){
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
    </div>
</div>
</body>
</html>


