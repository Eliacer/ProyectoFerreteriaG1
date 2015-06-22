<%@page import="proy01.modelo.entidad.Rep_ventas"%>
<%@page import="proy01.modelo.daoImpl.VentaDaoImpl"%>
<%@page import="proy01.modelo.dao.VentaDao"%>
<%@page import="proy01.modelo.entidad.Rep_compras"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Reportes de Ventas</title>
        <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
</head>
  <body>

<div class="container">

<%
    //String buscar_por = request.getParameter("buscar_por");buscar_por = buscar_por==null?"nombre": buscar_por;
    //String buscar = request.getParameter("buscar");buscar = buscar==null?"": buscar;
    String opcion = request.getParameter("opcion");opcion = opcion == null ? "" : opcion;
    String id_producto = request.getParameter("id_producto");id_producto = id_producto == null ? "" : id_producto;
    String f_in = request.getParameter("f_in");f_in = f_in == null ? "" : f_in;
    String f_fn = request.getParameter("f_fn");f_fn = f_fn == null ? "" : f_fn;
    String mensaje="";
     

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
    <div class="row">
        <h3 align="center">Reportes de Ventas</h3><br>
        <div class="col-md-12 well">
            <div class="tab-pane">
                <table class="table table-hover table-striped table-bordered">
                    <thead>
                        <tr>
                            <td width="3%" bgcolor="#FFEFCE"><strong>#</strong></td>
                            <td width="8%" align="center" bgcolor="#FFEFCE"><strong>F. Venta</strong></td>
                            <td width="23%" bgcolor="#FFEFCE"><strong>Usuario</strong></td>
                            <td width="22%" bgcolor="#FFEFCE"><strong>Cliente</strong></td>
                            <td width="10%" align="center" bgcolor="#FFEFCE"><strong>Comprobante</strong></td>
                            <td width="13%" align="center" bgcolor="#FFEFCE"><strong>Nro. Comprobante.</strong></td>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        String espacio="  ";
                        int count=0;
                        VentaDao cd = new VentaDaoImpl();
                        for(Rep_ventas venta :cd.ListarVentas(f_in, f_fn)){
                             count++;
                        %>
          
                        <tr>     
                            <td><%=count%>.-</td> 
                            <td align="center"><%=venta.getFecha_compra()%></td>
                            <td><%=venta.getNombre_usuario()%></td>
                            <td><%=venta.getNombre_cliente()%></td>
                            <td align="center"><%=venta.getNombre_comprobante()%></td>
                            <td align="center"><%=venta.getNum_com()%></td> 
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


