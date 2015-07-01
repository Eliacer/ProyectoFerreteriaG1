<%@page import="proy01.modelo.daoImpl.CompraDaoImpl"%>
<%@page import="proy01.modelo.dao.CompraDao"%>
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
<jsp:useBean id="id_compra" scope="request" class="java.lang.String" />
<jsp:useBean id="mensaje" scope="request" class="java.lang.String" />
<jsp:useBean id="alert" scope="request" class="java.lang.String" />
<jsp:useBean id="opcion" scope="request" class="java.lang.String" />
<jsp:useBean id="buscar_por" scope="request" class="java.lang.String" />
<jsp:useBean id="buscar" scope="request" class="java.lang.String" />
<jsp:useBean id="CompraT" scope="request" class="proy01.modelo.entidad.Rep_compras" />
<jsp:useBean id="CompraDetalle" scope="request" class="proy01.modelo.entidad.DetalleCompra" />
<jsp:useBean id="ProductoDe" scope="request" class="proy01.modelo.entidad.Producto" />
<div class="container">
    
    <%
    
        if(opcion==null ||opcion.equals("")){opcion="Buscar";}
        if(buscar_por==null ||buscar_por.equals("")){buscar_por="";}
        if(buscar==null ||buscar.equals("")){buscar="";}
        String espacio= "  ";
        String marca="";
        String cant_may=String.valueOf(CompraDetalle.getCantMayor());cant_may = cant_may.equals("null")?"":cant_may;
        String cant_menor=String.valueOf(CompraDetalle.getCantMenor());cant_menor = cant_menor.equals("null")?"":cant_menor;
        String costo=String.valueOf(CompraDetalle.getCostoMayor());costo = costo.equals("null")?"":costo;
        
        
    %>
  
<br>
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
    <div class="col-md-10"><h1 align="center"><%=CompraT.getNombre_proveedor()%></h1></div>
    <div class="col-md-1"></div>
</div>
<div class="row"> 
    <div class="col-md-7"> 
        <h4 allign="center"><strong>Registro de Compras</strong></h4>
        <a href="controlcompra?opcion=Actualizar&id_compra=<%=id_compra%>"><input type="submit" class="btn btn-primary" value="Actualizar"></a>
        <table width="550" align="left" class="table-responsive">
            <tbody>
            <tr>
                <td width="15%"><strong>Fecha:</strong></td>
                <td width="45%"><%=CompraT.getFecha_compra()%></td>
                <td width="5%"></td>
                <td width="15%"><strong>Moneda:</strong></td>
                <td width="10%"><%=CompraT.getNombre_tipo_moneda()%></td>
            </tr>
            <tr>
                <td><strong>F. Pago:</strong></td>
                <td><%=CompraT.getNombre_forma_pago()%></td>
                <td></td>
                <td><strong>IGV:</strong></td>
                <td width=""><%=CompraT.getIgv()%></td>
            </tr>
            <tr>
                <td><strong>Usuario:</strong></td>
                <td><%=CompraT.getNombre_usuario()%></td>
                <td></td>
                <td><strong>Flete:</strong></td>
                <td width=""><%=CompraT.getFlete()%></td>
            </tr>
            <tr>
                <td colspan="6"><br><h4 align="center">Productos de la compra</h4><br></td>
            </tr>        
            </tbody>
        </table>   
        <br><br>

        <%if(opcion.equals("Buscar") || opcion.equals("add")|| opcion.equals("Actualizar"))  {%>     
        
        <div class="tab-pane">
            
            <table class="table table-hover table-striped table-bordered">
                <thead>
                    <tr>
                        <td width="4%" bgcolor="#FFEFCE"><strong>Cant</strong></td>
                        <td width="4%" bgcolor="#FFEFCE"><strong>Und</strong></td>
                        <td width="25%" bgcolor="#FFEFCE"><strong>Producto</strong></td>
                        <td width="7%" align="center" bgcolor="#FFEFCE"><strong>Costo</strong></td>
                        <td width="7%" align="center" bgcolor="#FFEFCE"><strong>Importe</strong></td>
                        <td width="13%" align="center" bgcolor="#FFEFCE"><strong>Opciones</strong></td>
                    </tr>
                </thead>
                <tbody>
                    <%
                    
                    int count=0;
                    CompraDao dao = new CompraDaoImpl();
                    for(DetalleCompra dc : dao.ListarProductosCompra(id_compra)){
                         count++;
                    %>
                    <tr> 
                        <td align="center"><%=dc.getCantMayor()%></td>
                        <td align="center"><%=dc.getId_unidad()%></td>
                        <td><%=dc.getProducto()%></td>
                        <td align="center"><%=CompraT.getAbrev_moneda()%><%=espacio%><%=dc.getCostoMayor()%></td> 
                        <td align="center"><%=CompraT.getAbrev_moneda()%><%=espacio%><%=dc.getImporte()%></td>
                        <td>
                            <a href="buyproducts?opcion=Actualizar&id_producto=<%=dc.getId_producto()%>&id_compra=<%=id_compra%>" title="Actualizar">
                                <button type="button" class="btn btn-info">
                                    <span class="glyphicon glyphicon-refresh" aria-hidden="true"></span>
                                </button>
                            </a>
                            <a href="buyproducts?opcion=Eliminar&id_producto=<%=dc.getId_producto()%>&id_compra=<%=id_compra%>" title="Eliminar">
                                <button type="button" class="btn btn-danger">
                                    <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                                </button>
                            </a>
                        </td>
                    </tr>
                    <%}%>                   
                </tbody>
            </table>
            <form action="buyproducts" method="post">
                <table class="table table-hover table-striped table-bordered">
                    <tbody>
                        <tr>
                            <input type="hidden" name="id_compra"  value="<%=id_compra%>" size="10">
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
        <h4 allign="center"><strong>B&uacute;squeda de Productos</strong></h4><br>
        <%if(opcion.equals("Buscar")){%>
            <form class="form-horizontal" action="buyproducts" method="post">  
                
                <table>
                    <tr>
                        <input type="hidden" name="opcion"  value="Buscando" size="10">
                        <input type="hidden" name="id_compra"  value="<%=id_compra%>" size="10">
                        <td width="20%"><strong>Buscar Por:</strong></td>
                        <td width="25%"><select class="form-control" name="buscar_por">
                            <option value="nombre">Nombre</option>
                            <option value="codigo">C&oacute;digo</option>
                        </select></td>
                        <td>
                            <div class="input-group">
                            <input type="text" class="form-control" placeholder="b&uacute;sca aqu&iacute;" name="buscar">
                            <span class="input-group-btn">
                              <button type="submit" class="btn btn-success">Buscar<span class="glyphicon glyphicon-search" aria-hidden="true"></span><%=espacio%></button>
                            </span>
                        </div>
                        </td>        
                    </tr>
                </table>     
            </form>
            <div class="tab-pane" align="center">
                    <table class="table table-hover table-striped table-bordered">
                        <thead>
                        <br>
                            <tr>
                                <td width="3%" bgcolor="#FFEFCE"><strong>#</strong></td>
                                <td width="25%" bgcolor="#FFEFCE"><strong>Producto</strong></td>
                                <td width="15%" bgcolor="#FFEFCE"><strong>Marca</strong></td>
                                <td width="8%" align="center" bgcolor="#FFEFCE"><strong>Stock</strong></td>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            espacio=" ";
                            int count=0;
                            ProductoDao pro = new ProductoDaoImpl();
                            for(Producto producto :pro.BuscarProducto(buscar_por, buscar)){
                                 count++;
                                 marca=producto.getId_marca();marca = marca==null?"":marca; 
                            %>        
                            <tr>     
                                <input type="hidden" name="id_producto"  value="<%=producto.getIdProducto()%>" size="10">
                                <td><%=count%>.-</td> 
                                <td><a class="btn" href="buyproducts?id_producto=<%=producto.getIdProducto()%>&opcion=add&id_compra=<%=id_compra%>">
                                 <%=producto.getNombre()%></a></td>
                                <td><%=marca%></td>
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
            <form action="buyproducts" method="post"> 
                <table class="table table-bordered">
                    <tbody>   
                        <tr>
                            <input type="hidden" name="id_producto"  value="<%=ProductoDe.getIdProducto()%>" size="10">
                            <input type="hidden" name="id_compra"  value="<%=id_compra%>" size="10">
                            <td width="35%">Nombre:</td>
                          <td colspan="2"><div class="col-sm-15"><input type="text" class="form-control" placeholder="Nombre" value="<%=ProductoDe.getNombre()%>" disabled=""></div></td>
                        </tr>
                        <%if(!marca.equals("")){%>
                        <tr>
                          <td>Marca:</td>
                          <td colspan="2"><div class="col-sm-15"><input type="text" class="form-control" placeholder="Marca" value="<%=ProductoDe.getId_marca()%>" disabled=""></div></td>
                        </tr>
                        <%}%>
                        <tr>
                            <td>Unidad compra:</td>
                            <td colspan="2"><select class="form-control" name="unidad" selected="selected" <%if(CompraDetalle.getId_unidad().equals("")){%> selected<%}%>><option>[--Selecciona--]</option>                 
                                <%
                                    CaracteristicasProductoDao und_med = new CaracteristicasProductoDaoImpl();

                                    for(Unidad u: und_med.ListarUnidad()){             
                                %>
                                 <option value="<%=u.getId_unidad()%>" <%if(CompraDetalle.getId_unidad().equals(u.getId_unidad())){%> selected<%}%>> <%=u.getNombre_unidad()%></option> 
                                 <%}%>
                                </select>
                            </td>
                        </tr> 
                        <tr>
                          <td>Cant x Mayor:</td>
                          <td colspan="2"><div class="col-sm-15"><input type="text" class="form-control" placeholder="Cantidad x Mayor" name="cant_may" value="<%=cant_may%>" required></div></td>
                        </tr>
                        <tr>
                          <td>Cant  x Menor</td>
                          <td colspan="2"><div class="col-sm-15"><input type="text" class="form-control" placeholder="Cantidad x menor" name="cant_menor" value="<%=cant_menor%>" required></div></td>
                        </tr>
                        <tr>
                          <td>Costo</td>
                          <td align="center"><%=CompraT.getAbrev_moneda()%></td>
                          <td><div class="col-sm-15"><input type="text" class="form-control" placeholder="Costo" name="costo" value="<%=costo%>" required></div></td>
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
<%@include file="WEB-INF/jspf/botton.jspf" %>