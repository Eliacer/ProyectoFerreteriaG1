<%@page import="proy01.modelo.entidad.CatCliente"%>
<%@page import="proy01.modelo.daoImpl.VentaDaoImpl"%>
<%@page import="proy01.modelo.dao.VentaDao"%>
<%@page import="proy01.modelo.entidad.DetalleVenta"%>
<%@page import="proy01.modelo.entidad.Venta"%>
<%@page import="proy01.modelo.entidad.Unidad"%>
<%@page import="proy01.modelo.daoImpl.CaracteristicasProductoDaoImpl"%>
<%@page import="proy01.modelo.dao.CaracteristicasProductoDao"%>
<%@page import="proy01.modelo.entidad.Producto"%>
<%@page import="proy01.modelo.daoImpl.ProductoDaoImpl"%>
<%@page import="proy01.modelo.dao.ProductoDao"%>
<%@page import="proy01.modelo.entidad.DetalleCompra"%>
<%@page import="proy01.modelo.entidad.Rep_compras"%>
<%@page import="proy01.modelo.entidad.Compra"%>
<%@include file="WEB-INF/jspf/top.jspf" %>
<jsp:useBean id="id_venta" scope="request" class="java.lang.String" />
<jsp:useBean id="mensaje" scope="request" class="java.lang.String" />
<jsp:useBean id="alert" scope="request" class="java.lang.String" />
<jsp:useBean id="opcion" scope="request" class="java.lang.String" />
<jsp:useBean id="buscar_por" scope="request" class="java.lang.String" />
<jsp:useBean id="buscar" scope="request" class="java.lang.String" />
<jsp:useBean id="VentaT" scope="request" class="proy01.modelo.entidad.Venta" />
<jsp:useBean id="VentaDetalle" scope="request" class="proy01.modelo.entidad.DetalleVenta" />
<jsp:useBean id="ProductoDe" scope="request" class="proy01.modelo.entidad.Producto" />

<div class="container">
    
    <%
        if(opcion==null ||opcion.equals("")){opcion="Buscar";}
        if(buscar_por==null ||buscar_por.equals("")){buscar_por="";}
        if(buscar==null ||buscar.equals("")){buscar="";}
        String espacio= "  ";
        String marca="";
        String cant=String.valueOf(VentaDetalle.getCantidad());cant = cant.equals("0")?"":cant;
        String precio=String.valueOf(VentaDetalle.getPreciounitario());precio = precio.equals("0.0")?"":precio;
        double dcto=0.0;
        double subtotal=0.0;
        double total=0.0;
        double igv=0.0;
    %>
  
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
<%if(!opcion.equals("Finalizar")){%>
<div class="row">
    <div class="col-md-1"></div>
    <div class="col-md-10">
        <h1 align="center">Ferreter&iacute;a El Arca</h1>
        <h5 align="center">JR. TAHUANTINSUYO CDRA. 9</h5>
    </div>
    <div class="col-md-1"></div>
</div>
<div class="row">
    <div class="col-md-7">
        <h4 allign="center"><strong>Registro de Ventas</strong></h4>
        <a href="controlventa?opcion=Actualizar&id_venta=<%=id_venta%>"><input type="submit" class="btn btn-primary" value="Actualizar"></a>
        <table width="600" align="left" class="table-responsive">  
            <tbody>
            <tr>
                <td width="15%"><strong>Fecha:</strong></td>
                <td width="37%"><%=VentaT.getFechaventa()%></td>
                <td width="15%"><strong>IGV:</strong></td>
                <td width="20%"><%=VentaT.getIgv()%></td>
            </tr>
            <tr>
                <td><strong>Usuario:</strong></td>
                <td><%=VentaT.getId_usuario()%></td>
                <td><strong>N&deg;. Comp.:</strong></td>
                <td><%=VentaT.getSerie()%>-<%=VentaT.getNumComprobante()%></td>
            </tr>
            <tr>
                <td><strong>Cliente:</strong></td>
                <td><%=VentaT.getId_cliente()%></td>
                <td><strong>F. Pago:</strong></td>
                <td><%=VentaT.getId_formaPago()%></td>
            </tr>
            <br>
            <tr>
                <td colspan="4">
                    <br><h4 align="center">Productos de la venta</h4><br>
                </td>
            </tr>
            </tbody>
        </table>
        <%if(opcion.equals("Buscar") || opcion.equals("add")|| opcion.equals("Actualizar"))  {%>  
        <div class="tab-pane">
            <table class="table table-hover table-striped table-bordered">
                <thead>
                    <tr>
                        <td width="5%" bgcolor="#FFEFCE"><strong>Cant</strong></td>
                        <td width="23%" bgcolor="#FFEFCE"><strong>Nombre del Producto</strong></td>
                        <td width="9%" align="center" bgcolor="#FFEFCE"><strong>Costo</strong></td>
                        <td width="9%" align="center" bgcolor="#FFEFCE"><strong>Importe</strong></td>
                        <td width="8%" align="center" bgcolor="#FFEFCE"><strong>Opciones</strong></td>
                    </tr>
                </thead>
                <tbody>
                    <%
                    int count=0;
                    VentaDao dao = new VentaDaoImpl();
                    for(DetalleVenta dv : dao.ListarProductosVenta(id_venta)){
                         count++;
                         dcto=dcto+dv.getDescuento();
                         subtotal=subtotal+dv.getCantidad()*dv.getPreciounitario();
                         total=subtotal-dcto;
                         
                    %>
                    <tr> 
                        <td align="center"><%=dv.getCantidad()%></td>
                        <td><%=dv.getProducto()%></td>
                        <td align="center"><%=dv.getPreciounitario()%></td> 
                        <td align="center"><%=dv.getSubtotal()%></td>
                        <td>
                            <a href="sellcustomers?opcion=Actualizar&id_producto=<%=dv.getId_producto()%>&id_venta=<%=id_venta%>" title="Actualizar">
                                <button type="button" class="btn btn-info">
                                    <span class="glyphicon glyphicon-refresh" aria-hidden="true"></span>
                                </button>
                            </a>
                            <a href="sellcustomers?opcion=Eliminar&id_producto=<%=dv.getId_producto()%>&id_venta=<%=id_venta%>" title="Eliminar">
                                <button type="button" class="btn btn-danger">
                                    <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                                </button>
                            </a>
                        </td>
                    </tr>
                    <%}%>
                    
                </tbody>
            </table>
            <form class="form-horizontal" action="sellcustomers" method="post">
                <table width="85%">
                    <tbody>
                        <tr>
                            <td colspan="4" width="70%"></td>
                            <td width="23%">Subtotal:</td>
                            <td width="12%" align="right"><input type="text" name="id_venta"  value="<%=subtotal%>" size="10" disabled=""></td>
                        </tr>
                        <tr>
                            <td colspan="4"></td>
                            <td>IGV: </td>
                            <td align="right"><input type="text" name="id_venta"  value="<%=igv%>" size="10" disabled=""></td>
                        </tr>
                        <tr>
                            <td colspan="4"></td>
                            <td>Descuento: </td>
                            <td align="right"><input type="text" name="id_venta"  value="<%=dcto%>" size="10" disabled=""></td>
                        </tr>
                        <tr>
                            <td colspan="4"></td>
                            <td>Total: </td>
                            <td align="right"><input type="text" name="id_venta"  value="<%=total%>" size="10" disabled=""></td>
                        </tr>
                        <tr>
                            <input type="hidden" name="id_venta"  value="<%=id_venta%>" size="10">
                            <input type="hidden" name="opcion"  value="Finalizar" size="10">
                            <td colspan="6" align="center"><input type="submit" class="btn btn-primary" value="Finalizar"></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
        <%}%>
    </div>
    <div class="col-md-5">
        <h4 allign="center"><strong>Buscar Productos</strong></h4><br>
        <%if(opcion.equals("Buscar")){%>
        <form class="form-horizontal" action="sellcustomers" method="post"> 
            
            <table>
                <tr>
                    <input type="hidden" name="opcion"  value="Buscando" size="10">  
                    <input type="hidden" name="id_venta"  value="<%=id_venta%>" size="10">  
                    <td width="20%"><strong>Buscar Por:</strong></td>
                    <td width="25%"><select class="form-control" name="buscar_por">
                        <option value="nombre">Nombre</option>
                        <option value="codigo">C&oacute;digo</option>
                    </select></td>
                    <td>
                        <div class="input-group">
                        <input type="text" class="form-control" placeholder="b&uacute;sca aqu&iacute;" name="buscar">
                        <span class="input-group-btn">
                          <button type="submit" class="btn btn-success">Buscar<span class="glyphicon glyphicon-search" aria-hidden="true"></span></button>
                        </span>
                    </div>
                    </td>        
                </tr>
            </table>
        </form>       
        <div class="tab-pane">
            <table class="table table-hover table-striped table-bordered">
                <thead>
                <br>
                    <tr>
                        <td width="3%" bgcolor="#FFEFCE"><strong>#</strong></td>
                        <td width="15%" bgcolor="#FFEFCE"><strong>Producto</strong></td>
                        <td width="7%" align="center" bgcolor="#FFEFCE"><strong>Costo</strong></td>
                        <td width="7%" align="center" bgcolor="#FFEFCE"><strong>Stock</strong></td>
                    </tr>
                </thead>
                <tbody id="letr">
                
                    <%
                    int count=0;
                    ProductoDao pro = new ProductoDaoImpl();
                    for(Producto producto :pro.BuscarProducto(buscar_por, buscar)){
                         count++;
                         marca=producto.getId_marca();marca = marca==null?"":marca;
                    %>        
                    <tr>     
                        <td><%=count%>.-</td> 
                        <td><a class="btn" href="sellcustomers?id_producto=<%=producto.getIdProducto()%>&opcion=add&id_venta=<%=id_venta%>"><%=producto.getNombre()%></a></td>
                        <td align="center"><%=producto.getPrecio()%></td>
                        <td align="center"><%=producto.getStock_actual()%></td> 
                    </tr>
                    <%}%>
                
                </tbody>
            </table>
        </div>          
       <h1></h1>
        <%}%>
        <%if(opcion.equals("add") || opcion.equals("Actualizar")){%>
        <%if(opcion.equals("add")){%>
        <h4 align="center">Agregando Productos</h4><br>
        <%}%>
        <%if(opcion.equals("Actualizar")){%>
        <h4 align="center">Actualizando Productos</h4><br>
        <%}%>
        <form action="sellcustomers" method="post"> 
            <table class="table table-bordered">
                <tbody>   
                    <tr>
                        <input type="hidden" name="id_producto"  value="<%=ProductoDe.getIdProducto()%>" size="10">
                        <input type="hidden" name="id_venta"  value="<%=id_venta%>" size="10">
                        <td>Nombre:</td>
                        <td><div class="col-sm-15"><input type="text" class="form-control" placeholder="Nombre" value="<%=ProductoDe.getNombre()%>" disabled=""></div></td>
                    </tr>
                    <%if(!marca.equals("")){%>
                    <tr>
                        <td>Marca:</td>
                        <td><div class="col-sm-15"><input type="text" class="form-control" placeholder="Marca" value="<%=ProductoDe.getId_marca()%>" disabled=""></div></td>
                    </tr>
                    <%}%>
                    <tr>
                        <td>Cantidad:</td>
                        <td><div class="col-sm-15"><input type="text" class="form-control" placeholder="Cantidad" name="cant" value="<%=cant%>" required></div></td>
                    </tr>
                    <tr>
                        <td>Costo:</td>
                        <td><div class="col-sm-15"><input type="text" class="form-control" placeholder="Precio Unitario" name="precio" value="<%=ProductoDe.getPrecio()%>" required></div></td>
                    </tr>
                    <%if(opcion.equals("add")){%>
                    <tr>
                      <td colspan="3" align="center"><input type="submit" name="opcion" class="btn btn-primary" value="Agregar"></td>
                    </tr>
                    <%}%>
                    <%if(opcion.equals("Actualizar")){%>
                    <tr>
                      <td colspan="3" align="center"><input type="submit" name="opcion" class="btn btn-primary" value="Actualizando"></td>
                    </tr>
                    <%}%>
                </tbody>
            </table>
        </form>
        <%}%>
        
    </div>
</div>
<%}%>
</div>
</div>
<%@include file="WEB-INF/jspf/botton.jspf" %>