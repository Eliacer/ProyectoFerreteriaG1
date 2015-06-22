<%@page import="daoImpl.VentaDaoImpl"%>
<%@page import="dao.VentaDao"%>
<%@page import="bean.Venta"%>
<%@page import="daoImpl.PersonaDaoImpl"%>
<%@page import="dao.PersonaDao"%>
<%@page import="bean.Persona"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="bean.Producto"%>
<%@page import="daoImpl.ProductoDaoImpl"%>
<%@page import="dao.ProductoDao"%>
<jsp:useBean id="ven" class="bean.Venta"/>
<%@include file="WEB-INF/jspf/top.jspf" %>     
<%
        ProductoDao dao = new ProductoDaoImpl();
        Producto producto = new Producto();
        String id_producto = request.getParameter("id_producto");id_producto = id_producto == null ? "" : id_producto;
        String id_venta= request.getParameter("id_venta"); id_venta = id_venta==null?"":id_venta;
        String id_comprobante= request.getParameter("id_comprobante"); id_comprobante = id_comprobante==null?"":id_comprobante;
        String id_cliente = request.getParameter("id_cliente"); id_cliente = id_cliente==null?"":id_cliente;
        String id_usuario = request.getParameter("id_usuario"); id_usuario = id_usuario==null?"":id_usuario;
        String fecha = request.getParameter("fecha"); fecha = fecha==null?"":fecha;
        String nro_comprobante = request.getParameter("nro_comprobante"); nro_comprobante = nro_comprobante==null?"":nro_comprobante;
       
        String nombre = request.getParameter("nombre"); nombre = nombre==null?"":nombre;
        String precio_venta = request.getParameter("precio_venta"); precio_venta = precio_venta==null?"":precio_venta;        

        Venta venta = new Venta();
            VentaDao ventaDao = new VentaDaoImpl();
            venta = ventaDao.DatosVenta(id_venta);
%>
<h3>DETALLE DE VENTA</h3>
<hr color="#666">
<table border="1" width="1006" align="justify" class="table table-bordered">    
    <thead>
        <tr>
            <th>Registro de Ventas</th>
            <th>Buscar Productos</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>          
                <table border="0">
                    <thead align="right">
                        <tr>
                            <td>Cliente: </td>
                            <td width="10"></td>
                            <th><%=venta.getNombre()%></th>
                            <td width="10"></td>
                            <td>Fecha: </td>
                            <td width="10"></td>
                            <th><%=venta.getFecha()%></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td align="right">Vendedor: </td>
                            <td width="10"></td>
                            <th align="left"><%=venta.getId_usuario()%></th>                            
                        </tr>
                        <tr>
                            <td align="right">Comprobante:</td>
                            <td width="10"></td>
                            <th align="left"><%=venta.getId_comprobante()%></th>
                        </tr>
                    </tbody>
                </table>
        <div align="center"> 
        <table class="table table-striped">         
            <tr>
                <th>Cantidad</th>
                <th>Producto descripcion</th>
                <th>SubTotal</th>             
            </tr>
            <tr bgcolor="white" onmouseover="this.style.backgroundColor = 'yellow';" onmouseout="this.style.backgroundColor = 'white';" style="background-color: white;">             
                <td><%=nombre%></td>
                <td><input name="nombre" class="form-control" id="inputfn3" placeholder="Producto" value="<%=producto.getNombre()%>"></td>
                <td><%=producto.getStock()%></td>						
            </tr>           
        </table>               
        </div>
                
            </td>
            <td width="503">                
                <div class="col-md-2"></div>
                <!--Cambiar tamaño de ancho-->
                    <div class="col-md-8">
                        <form class="form-horizontal" role="form"  action="venta_1.jsp">
                            <input type="hidden" name="id_venta" value="<%=id_venta%>"/>
                             <div class="form-group">                                                           
                                 <div class="col-sm-12">
                                     <div class="form-inline">                         
                                         <input type="text" maxlength="8" name="id_producto" class="form-control" id="inputfn3" placeholder="Codigo">
                                         <input type="submit" name="Submit" class="btn btn-success" value="Buscar"> 
                                         <a href="agregarProducto.jsp"><span class="glyphicon glyphicon-pencil"></span></a>     					
                                     </div>
                                 </div>
                             </div>    					
                        </form> 			
                    </div>
                
                <%
if (!id_producto.equals("")) {
    producto = dao.buscarProducto(id_producto);   
    if(producto!=null){
        
            //producto = dao.buscarProducto(id_producto);
%>
<div align="center"> 
        <table class="table table-striped">         
            <tr>
                <th>CODIGO</th>
                <th>PRODUCTO</th>
                <th>STOCK</th>
                <th>PRECIO</th>         
                <th></th>               
            </tr>
            <tr bgcolor="white" onmouseover="this.style.backgroundColor = 'yellow';" onmouseout="this.style.backgroundColor = 'white';" style="background-color: white;">             
                <td><%=producto.getId_producto()%></td>
                <td><%=producto.getNombre()%></td>
                <td><%=producto.getStock()%></td>
                <td>S/.<%=producto.getPrecio_venta()%></td>                              
                <td class="e"><a href="venta_1.jsp?id_venta=<%=id_venta%>&id=<%=producto.getId_producto()%>"><input type="submit" name="Submit" class="btn btn-primary" value="Agregar"></a></td>
                  						
            </tr>           
        </table>      
        <p><br><br/></p>        
            </div>
<%
    }
    }
   
%>
        </td>
        </tr>
    </tbody>
</table>
<br>
<br>

<%@include file="WEB-INF/jspf/bottom.jspf"%>
