<%@page import="proy01.modelo.entidad.Unidad"%>
<%@page import="proy01.modelo.daoImpl.CaracteristicasProductoDaoImpl"%>
<%@page import="proy01.modelo.dao.CaracteristicasProductoDao"%>
<%@page import="proy01.modelo.entidad.Producto"%>
<%@page import="proy01.modelo.daoImpl.ProductoDaoImpl"%>
<%@page import="proy01.modelo.dao.ProductoDao"%>
<%@page import="proy01.modelo.entidad.DetalleCompra"%>
<%@page import="proy01.modelo.entidad.Rep_compras"%>
<%@page import="proy01.modelo.daoImpl.CompraDaoImpl"%>
<%@page import="proy01.modelo.dao.CompraDao"%>
<%@page import="proy01.modelo.entidad.Compra"%>
<%@include file="WEB-INF/jspf/top.jspf" %>

<div class="container">
    
    <%
        String num_comp=request.getParameter("num_comp");num_comp = num_comp==null?"":num_comp;
        String id_producto=request.getParameter("id_producto");id_producto = id_producto==null?"":id_producto;
        String unidad=request.getParameter("unidad");unidad = unidad==null?"":unidad;
        String cant_may=request.getParameter("cant_may");cant_may = cant_may==null?"":cant_may;
        String cant_menor=request.getParameter("cant_menor");cant_menor = cant_menor==null?"":cant_menor;
        String costo=request.getParameter("costo");costo = costo==null?"":costo;
        String buscar_por = request.getParameter("buscar_por");buscar_por = buscar_por==null?"nombre": buscar_por;
        String buscar = request.getParameter("buscar");buscar = buscar==null?"": buscar;
        String opcion = request.getParameter("opcion");opcion = opcion == null ? "Buscar" : opcion;
        String id_compra=request.getParameter("id_compra");id_compra = id_compra==null?"":id_compra;
        String nombre_proveedor="";
        String nombre_forma_pago="";
        String nombre_tipo_moneda="";
        String nombre_comprobante="";
        String fecha_compra="";
        String nombre_usuario="";
        String direccion_prov="";
        String igv="";
        String flete="";
        String mensaje="";
        String marca1="";
        String nombre_prod="";
        
        if(opcion.equals("Buscar") || opcion.equals("add") || opcion.equals("Agregar") ||opcion.equals("Actualizar")
                || opcion.equals("Actualizando") || opcion.equals("Eliminar")){
            
            if(!num_comp.equals("")){
                
                CompraDao dao = new CompraDaoImpl();
                Rep_compras rep_compras = new Rep_compras();
                
                rep_compras = dao.ListarCompraT(num_comp);

                id_compra=rep_compras.getId_compra();num_comp = num_comp==null?"":num_comp;
                nombre_proveedor=rep_compras.getNombre_proveedor();nombre_proveedor = nombre_proveedor==null?"":nombre_proveedor;
                nombre_forma_pago=rep_compras.getNombre_forma_pago();nombre_forma_pago = nombre_forma_pago==null?"":nombre_forma_pago;
                nombre_tipo_moneda=rep_compras.getNombre_tipo_moneda();nombre_tipo_moneda = nombre_tipo_moneda==null?"":nombre_tipo_moneda;
                nombre_comprobante=rep_compras.getNombre_comprobante();nombre_comprobante = nombre_comprobante==null?"":nombre_comprobante;
                fecha_compra=rep_compras.getFecha_compra();fecha_compra = fecha_compra==null?"":fecha_compra;
                nombre_usuario=rep_compras.getNombre_usuario();nombre_usuario = nombre_usuario==null?"":nombre_usuario;
                direccion_prov=rep_compras.getDireccion_prov();direccion_prov = direccion_prov==null?"":direccion_prov;
                igv=rep_compras.getIgv();igv = igv==null?"":igv;
                flete=rep_compras.getFlete();flete = flete==null?"":flete;
                //opcion="Añadir";
            }    
            if(opcion.equals("add")||opcion.equals("Actualizar")){
                if(!id_producto.equals("")){

                    Producto producto = new Producto();
                    ProductoDao pd=new ProductoDaoImpl();
                    producto = pd.ObtenerDatProducto(id_producto);

                    nombre_prod=producto.getNombre();nombre_prod = nombre_prod==null?"":nombre_prod;                
                    marca1=producto.getId_marca();marca1 = marca1==null?"":marca1;                              
                }    
                if(opcion.equals("Actualizar")){

                    DetalleCompra dc = new DetalleCompra();
                    CompraDao cd = new CompraDaoImpl();
                    dc=cd.ObtenerDetCompra(id_compra, id_producto);
                    id_compra=dc.getId_compra();id_compra = id_compra==null?"":id_compra;   
                    id_producto=dc.getId_producto();id_producto = id_producto==null?"":id_producto;
                    unidad=dc.getId_unidad();unidad = unidad==null?"":unidad;  
                    cant_may=String.valueOf(dc.getCantMayor());cant_may = cant_may==null?"":cant_may;  
                    cant_menor=String.valueOf(dc.getCantMenor());cant_menor = cant_menor==null?"":cant_menor;  
                    costo=String.valueOf(dc.getCostoMayor());costo = costo==null?"":costo; 
                }
            }  
        
        if(opcion.equals("Agregar")){
            if(!id_compra.equals("")&&!id_producto.equals("") && !unidad.equals("")&& !cant_may.equals("")
                    && !cant_menor.equals("")&& !costo.equals("")){
                DetalleCompra detalleCompra = new DetalleCompra();
                CompraDao compraDao = new CompraDaoImpl();
                
                detalleCompra.setId_compra(id_compra);
                detalleCompra.setId_producto(id_producto);
                detalleCompra.setId_unidad(unidad);
                detalleCompra.setCantMayor(Integer.parseInt(cant_may));
                detalleCompra.setCantMenor(Integer.parseInt(cant_menor));
                detalleCompra.setCostoMayor(Double.parseDouble(costo));
                
                if(compraDao.RegistrarDetCompra(detalleCompra)){
                    mensaje="Se añadió el producto...";
                    
                    opcion="Buscar";
                }
                else{
                    mensaje="No se pudo añadir el producto...";
                    opcion="Buscar";
                }             
            }
        }
        
            if(opcion.equals("Actualizando")){
                
            }
            if(opcion.equals("Eliminar")){
                
            }   
        }
        
        if(opcion.equals("Finalizar")){
            out.println("id_compra:"+id_compra);
            if(!id_compra.equals("")){
                CompraDao cd = new CompraDaoImpl();
                if(cd.StockCompra(id_compra)){
                    mensaje="Se registró correctamente la compra...";
                }
                else{
                    mensaje="Ocurrió un error al registrar la compra...";
                }
            }
        }
    %>
  
<div class="row">
    <div class="col-md-1"></div>
    <div class="col-md-10">
        <table class="table table-condensed">
            <tbody>                        
                <tr><td colspan="2"><h1 align="center"><%=nombre_proveedor%></h1></td></tr>
                <tr><td colspan="2"> <h5 align="center"><%=direccion_prov%></h5></td></tr>
                <tr><td>Fecha:</td><td><%=fecha_compra%></td></tr>
                <tr><td>Forma Pago:</td><td><%=nombre_forma_pago%></td></tr>
                <tr><td>Usuario:</td><td><%=nombre_usuario%></td></tr>
            </tbody>
        </table>
    </div>
    <div class="col-md-1"></div>
</div>
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
 <%if(opcion.equals("Buscar") || opcion.equals("add")|| opcion.equals("Actualizar"))  {%>       
<div class="row">
    <div class="col-md-2"></div>
    <div class="col-md-8 well">
        <h4 align="center">Productos de la compra</h4><br>
        <div class="tab-pane">
            <table class="table table-hover table-striped table-bordered">
                <thead>
                    <tr>
                        <td width="5%" bgcolor="#FFEFCE"><strong>Cant</strong></td>
                        <td width="7%" bgcolor="#FFEFCE"><strong>Unidad</strong></td>
                        <td width="25%" bgcolor="#FFEFCE"><strong>Nombre del Producto</strong></td>
                        <td width="9%" align="center" bgcolor="#FFEFCE"><strong>Costo</strong></td>
                        <td width="9%" align="center" bgcolor="#FFEFCE"><strong>Importe</strong></td>
                        <td width="18%" align="center" bgcolor="#FFEFCE"><strong>Opciones</strong></td>
                    </tr>
                </thead>
                <tbody>
                    <%
                    String espacio="  ";
                    int count=0;
                    CompraDao dao = new CompraDaoImpl();
                    for(DetalleCompra dc : dao.ListarProductosCompra(id_compra)){
                         count++;
                    %>

                    <tr> 
                        
                        <td align="center"><%=dc.getCantMayor()%></td>
                        <td align="center"><%=dc.getId_unidad()%></td>
                        <td><%=dc.getProducto()%></td>
                        <td align="center"><%=dc.getCostoMayor()%></td> 
                        <td align="center"><%=dc.getImporte()%></td>
                        <td>
                            <a href="Detalle_compra.jsp?opcion=Actualizar&id_compra=<%=dc.getId_compra()%>&id_producto=<%=dc.getId_producto()%>&num_comp=<%=num_comp%>">[Actualizar]<%=espacio%></a>
                            <a href="Detalle_compra.jsp?opcion=eliminar&id_compra=<%=dc.getId_compra()%>&id_producto=<%=dc.getId_producto()%>&num_comp=<%=num_comp%>">[Eliminar]</a></td>
                    </tr>
                    <%}%>                   
                </tbody>
            </table>
            <form action="Detalle_compra.jsp">
                <table class="table table-hover table-striped table-bordered">
                    <tbody>
                        <tr>
                            <input type="hidden" name="id_compra"  value="<%=id_compra%>" size="10">
                            <td colspan="6" align="center"><input type="submit" name="opcion" class="btn btn-primary" value="Finalizar"></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
    </div>
    <div class="col-md-2"></div>
</div>
<hr color="#666"><br> 
<div class="row">     
    <div class="col-md-2"></div>
    <div class="col-md-8">
        <%if(opcion.equals("Buscar")){%>
        <form class="form-horizontal" action="Detalle_compra.jsp" method="post">              
            <div class="form-group">
                <label class="control-label col-xs-3">Buscar producto por: </label>
                <input type="hidden" name="num_comp"  value="<%=num_comp%>" size="10">
                <input type="hidden" name="opcion"  value="<%=opcion%>" size="10">        
                <div class="col-xs-3">
                    <select class="form-control" name="buscar_por">
                        <option value="nombre">Nombre</option>
                        <option value="codigo">C&oacute;digo</option>
                    </select>
                </div>
                <div class="col-xs-6">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Realiza la b&uacute;squeda aqu&iacute;" name="buscar">
                        <span class="input-group-btn">
                          <button type="submit" class="btn btn-primary">Buscar</button>
                        </span>
                    </div><!-- /input-group -->
                </div>  
            </div>
        </form>
        <div class="tab-pane">
                <table class="table table-hover table-striped table-bordered">
                    <thead>
                        <tr>
                            <td width="5%" bgcolor="#FFEFCE"><strong>#</strong></td>
                            <td width="28%" bgcolor="#FFEFCE"><strong>Nombre del Producto</strong></td>
                            <td width="10%" align="center" bgcolor="#FFEFCE"><strong>Marca</strong></td>
                            <td width="9%" bgcolor="#FFEFCE"><strong>Und Venta</strong></td>
                            <td width="9%" align="center" bgcolor="#FFEFCE"><strong>Costo</strong></td>
                            <td width="9%" align="center" bgcolor="#FFEFCE"><strong>Stock</strong></td>
                            <td width="12%" align="center" bgcolor="#FFEFCE"><strong>Ubicacion</strong></td>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        espacio="  ";
                        count=0;
                        ProductoDao pro = new ProductoDaoImpl();
                        for(Producto producto :pro.BuscarProducto(buscar_por, buscar)){
                             count++;
                             String marca=producto.getId_marca();marca = marca==null?"":marca; 
                             nombre_prod=producto.getNombre();
                        %>        
                        <tr>     
                            <input type="hidden" name="id_producto"  value="<%=producto.getIdProducto()%>" size="10">
                            <td><%=count%>.-</td> 
                            <td><a href="Detalle_compra.jsp?id_producto=<%=producto.getIdProducto()%>&opcion=add&num_comp=<%=num_comp%>">
                                    <%=producto.getNombre()%></a></td>
                            <td align="center"><%=marca%></td>
                            <td align="center"><%=producto.getIdUndMedida()%></td>
                            <td align="center"><%=producto.getCosto()%></td>
                            <td align="center"><%=producto.getStock_actual()%></td> 
                            <td align="center"><%=producto.getId_ubicacion()%></td>
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
        <form action="Detalle_compra.jsp" method="get"> 
            <table class="table table-bordered">
                <tbody>   
                    <tr>
                        <input type="hidden" name="id_compra"  value="<%=id_compra%>" size="10">
                        <input type="hidden" name="id_producto"  value="<%=id_producto%>" size="10">
                        <input type="hidden" name="num_comp"  value="<%=num_comp%>" size="10">
                      <td><label class="col-sm-6 control-label">Nombre:</label></td>
                      <td><div class="col-sm-15"><input type="text" class="form-control" placeholder="Nombre" value="<%=nombre_prod%>"></div></td>
                    </tr>
                    <tr>
                      <td><label class="col-sm-6 control-label">Marca:</label></td>
                      <td><div class="col-sm-15"><input type="text" class="form-control" placeholder="Marca" value="<%=marca1%>"></div></td>
                    </tr>
                    <tr>
                        <td><label class="col-sm-6 control-label">Unidad de venta:</label></td>
                        <td><select class="form-control" name="unidad" selected="selected" <%if(unidad.equals("")){%> selected<%}%>><option>[--Selecciona--]</option>                 
                            <%
                                CaracteristicasProductoDao und_med = new CaracteristicasProductoDaoImpl();
                                
                                for(Unidad u: und_med.ListarUnidad()){             
                            %>
                             <option value="<%=u.getId_unidad()%>" <%if(unidad.equals(u.getId_unidad())){%> selected<%}%>> <%=u.getNombre_unidad()%></option> 
                             <%}%>
                            </select>
                        </td>
                    </tr> 
                    <tr>
                      <td><label class="col-sm-6 control-label">Cantidad x Mayor</label></td>
                      <td><div class="col-sm-15"><input type="text" class="form-control" placeholder="Cantidad x Mayor" name="cant_may" value="<%=cant_may%>" required=""></div></td>
                    </tr>
                    <tr>
                      <td><label class="col-sm-6 control-label">Cantidad x Menor</label></td>
                      <td><div class="col-sm-15"><input type="text" class="form-control" placeholder="Cantidad x menor" name="cant_menor" value="<%=cant_menor%>" required=""></div></td>
                    </tr>
                    <tr>
                      <td><label class="col-sm-6 control-label">Costo</label></td>
                      <td><div class="col-sm-15"><input type="text" class="form-control" placeholder="Costo" name="costo" value="<%=costo%>" required=""></div></td>
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
    <div class="col-md-2"></div>
</div>
<%}%>
</div>
<%@include file="WEB-INF/jspf/botton.jspf" %>