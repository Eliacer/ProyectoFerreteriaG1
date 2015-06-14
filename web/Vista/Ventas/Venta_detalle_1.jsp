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
<%@include file="../../WEB-INF/jspf/top.jspf" %>

<div class="container">
    
    <%
    
        HttpSession se = request.getSession();
        String id_venta=(String)se.getAttribute("id_venta");id_venta = id_venta==null?"":id_venta;
        String id_cliente=(String)se.getAttribute("id_cliente");id_cliente = id_cliente==null?"":id_cliente;
        String num_comp=(String)se.getAttribute("num_comp");num_comp = num_comp==null?"":num_comp;
        String serie=(String)se.getAttribute("serie");serie = serie==null?"":serie;
        String fecha_venta=(String)se.getAttribute("fecha_venta");fecha_venta = fecha_venta==null?"":fecha_venta;
               
        String id_producto=request.getParameter("id_producto");id_producto = id_producto==null?"":id_producto;
        String cant=request.getParameter("cant");cant = cant==null?"":cant;
        String precio=request.getParameter("precio");precio = precio==null?"":precio;
        String buscar_por = request.getParameter("buscar_por");buscar_por = buscar_por==null?"nombre": buscar_por;
        String buscar = request.getParameter("buscar");buscar = buscar==null?"": buscar;
        String opcion = request.getParameter("opcion");opcion = opcion == null ? "Buscar" : opcion;
        
        String nombre_forma_pago="";
        String nombre_comprobante="";
        String nombre_usuario="";
        String nombre_cliente="";
        double descuento=0;
        String igv="";
        String mensaje="";
        String nombre_prod="";
        String marca1="";
        int stock;
        
        if(opcion.equals("Buscar") || opcion.equals("add") || opcion.equals("Agregar") ||opcion.equals("Actualizar")
                || opcion.equals("Actualizando") || opcion.equals("Eliminar")){
            
            VentaDao dao = new VentaDaoImpl();
            Venta repventa = new Venta();
               
            if(id_venta!=null){
                repventa =dao.ObtenerDatosVenta(id_venta);
                
                nombre_cliente=repventa.getId_cliente();nombre_cliente = nombre_cliente==null?"":nombre_cliente;
                nombre_forma_pago=repventa.getId_formaPago();nombre_forma_pago = nombre_forma_pago==null?"":nombre_forma_pago;
                nombre_comprobante=repventa.getId_configuracion();nombre_comprobante = nombre_comprobante==null?"":nombre_comprobante;
                nombre_usuario=repventa.getId_usuario();nombre_usuario = nombre_usuario==null?"":nombre_usuario;  
            }    
            if(opcion.equals("add")||opcion.equals("Actualizar")){
                if(!id_producto.equals("")){

                    Producto producto = new Producto();
                    ProductoDao pd=new ProductoDaoImpl();
                    producto = pd.ObtenerDatProducto(id_producto);

                    nombre_prod=producto.getNombre();nombre_prod = nombre_prod==null?"":nombre_prod;                
                    marca1=producto.getId_marca();marca1 = marca1==null?"":marca1;
                    precio=String.valueOf(producto.getPrecio());
                    
                }    
                if(opcion.equals("Actualizar")){

                    DetalleVenta dv = new DetalleVenta();
                    VentaDao cd = new VentaDaoImpl();
                    dv=cd.ObtenerDetVenta(id_venta, id_producto);
                    id_producto=dv.getId_producto();id_producto = id_producto==null?"":id_producto;
                    precio=String.valueOf(dv.getPreciounitario());precio = precio==null?"":precio; 
                    cant=String.valueOf(dv.getCantidad());cant = cant==null?"":cant;  
                }
            }  
            if(opcion.equals("Agregar")){
                if(!id_venta.equals("")&&!id_producto.equals("")&& !cant.equals("")&& !precio.equals("")){

                    DetalleVenta dventa = new DetalleVenta();
                    CatCliente cc = new CatCliente();
                    VentaDao ventaDao = new VentaDaoImpl();
                    Producto producto = new Producto();
                    ProductoDao pd=new ProductoDaoImpl();
                    producto = pd.ObtenerDatProducto(id_producto);
                    
                    cc=ventaDao.ObtenerDcto(id_venta, id_cliente);//obteniendo descuento...
                    descuento=cc.getDescuento();//dcto en porc
                    stock=producto.getStock_actual();//obtenemos el stock
                    dventa.setId_venta(id_venta);//seteando los datos
                    dventa.setId_producto(id_producto);
                    dventa.setCantidad(Integer.parseInt(cant));
                    dventa.setPreciounitario(Double.parseDouble(precio));
                    dventa.setDescuento(descuento);
                    
                    if(stock>=Double.parseDouble(cant)){
                        if(ventaDao.RegistrarDetVenta(dventa)){
                            mensaje="Se añadió el producto...";
                            opcion="Buscar";
                        }
                        else{
                            mensaje="No se pudo añadir el producto...";
                            opcion="Buscar";
                        } 
                    }
                    else{
                            mensaje="Solo hay: "+stock+" en stock.";
                            opcion="Buscar";
                        } 
                }
            }
            if(opcion.equals("Actualizando")){
                DetalleVenta dv = new DetalleVenta();
                VentaDao act = new VentaDaoImpl();
                CatCliente cc = new CatCliente();
                
                cc=act.ObtenerDcto(id_venta, id_cliente);//obteniendo descuento...
                descuento=cc.getDescuento();//dcto en porc
                
                dv.setId_venta(id_venta);
                dv.setId_producto(id_producto);
                dv.setCantidad(Integer.parseInt(cant));
                dv.setPreciounitario(Double.parseDouble(precio));
                dv.setDescuento(descuento);
                if(act.UpdateDetVenta(dv)){
                    mensaje="Se actualizo correctamente el producto comprado...";
                    opcion="Buscar";
                }
                else{
                    mensaje="Ocurrio un error al actualizar el producto comprado...";
                    opcion="Buscar";
                }
            }
            if(opcion.equals("Eliminar")){
                VentaDao del = new VentaDaoImpl();
                if(del.DeleteProdVenta(id_venta, id_producto)){
                    mensaje="Se elimino correctamente el producto comprado...";
                    opcion="Buscar";
                }
                else{
                    mensaje="Ocurrio un error al eliminar el producto comprado...";
                    opcion="Buscar";
                }
            }   
        }
        if(opcion.equals("Finalizar")){
            if(!id_venta.equals("")){
                VentaDao cd = new VentaDaoImpl();
                if(cd.Stockventa(id_venta)){
                    //opcion="ok";
                    mensaje="Se registró correctamente la venta...";
                }
                else{
                    mensaje="Ocurrió un error al registrar la venta...";
                }
            }
        }
    %>
  
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
<%if(!opcion.equals("Finalizar")){%>
<div class="row">
    <div class="col-md-1"></div>
    <div class="col-md-10">
        <h1 align="center">Ferreter&iacute;a El Arca</h1></div>
        <h5 align="center">JR. TAHUANTINSUYO CDRA. 9</h5>
    <div class="col-md-1"></div>
</div>
<div class="row">
    <div class="col-md-7">
        <h4 allign="center"><strong>Registro de Ventas</strong></h4><br>
        <table width="480" align="left" class="table-responsive">  
            <tbody>
            <tr>
                <td width="10"><strong>Fecha:</strong></td>
                <td width="60"><%=fecha_venta%></td>
                <td width="30"></td>
                <td width="15"><strong>IGV:</strong></td>
                <td width="60"><%=igv%></td>
            </tr>
            <tr>
                <td><strong>Usuario:</strong></td>
                <td><%=nombre_usuario%></td>
                <td></td>
                <td><strong>N&deg;. Comprob:</strong></td>
                <td width="10"><%=serie%>-<%=num_comp%></td>
            </tr>
            <tr>
                <td><strong>Cliente:</strong></td>
                <<td><%=nombre_cliente%></td>
                <td></td>
                <td><strong>F. Pago:</strong></td>
                <td width="10"><%=nombre_forma_pago%></td>
            </tr>
            <br>
            <tr>
                <td colspan="5">
                    <h4 align="center">Productos de la venta</h4>
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
                        <td width="27%" bgcolor="#FFEFCE"><strong>Nombre del Producto</strong></td>
                        <td width="9%" align="center" bgcolor="#FFEFCE"><strong>Costo</strong></td>
                        <td width="9%" align="center" bgcolor="#FFEFCE"><strong>Importe</strong></td>
                        <td width="9%" align="center" bgcolor="#FFEFCE"><strong>Opciones</strong></td>
                    </tr>
                </thead>
                <tbody>
                    <%
                    String espacio="  ";
                    int count=0;
                    VentaDao dao = new VentaDaoImpl();
                    for(DetalleVenta dv : dao.ListarProductosVenta(id_venta)){
                         count++;
                    %>
                    <tr> 
                        <td align="center"><%=dv.getCantidad()%></td>
                        <td><%=dv.getProducto()%></td>
                        <td align="center"><%=dv.getPreciounitario()%></td> 
                        <td align="center"><%=dv.getSubtotal()%></td>
                        <td>
                            <a href="Venta_detalle_1.jsp?opcion=Actualizar&id_producto=<%=dv.getId_producto()%>&id_venta=<%=id_venta%>" title="Actualizar">
                                <button type="button" class="btn btn-info">
                                    <span class="glyphicon glyphicon-refresh" aria-hidden="true"></span>
                                </button>
                            </a>
                            <a href="Venta_detalle_1.jsp?opcion=Eliminar&id_producto=<%=dv.getId_producto()%>&id_venta=<%=id_venta%>" title="Eliminar">
                                <button type="button" class="btn btn-danger">
                                    <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                                </button>
                            </a>
                        </td>
                    </tr>
                    <%}%>                   
                </tbody>
            </table>
            <form action="Venta_detalle_1.jsp">
                <table class="table table-hover table-striped table-bordered">
                    <tbody>
                        <tr>
                            <input type="hidden" name="id_venta"  value="<%=id_venta%>" size="10">
                            <td colspan="6" align="center"><input type="submit" name="opcion" class="btn btn-primary" value="Finalizar"></td>
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
        <form class="form-horizontal" action="Venta_detalle_1.jsp" method="post"> 
            
            <table>
                <tr>
                    <input type="hidden" name="opcion"  value="<%=opcion%>" size="10">  
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
            <div class="form-group">
        </form>       
        <div class="tab-pane">
            <table class="table table-hover table-striped table-bordered">
                <thead>
                <br>
                    <tr>
                        <td width="5%" bgcolor="#FFEFCE"><strong>#</strong></td>
                        <td width="28%" bgcolor="#FFEFCE"><strong>Producto</strong></td>
                        <td width="9%" align="center" bgcolor="#FFEFCE"><strong>Marca</strong></td>
                        <td width="7%" bgcolor="#FFEFCE"><strong>Und</strong></td>
                        <td width="7%" align="center" bgcolor="#FFEFCE"><strong>Costo</strong></td>
                        <td width="7%" align="center" bgcolor="#FFEFCE"><strong>Stock</strong></td>
                    </tr>
                </thead>
                <tbody>
                    <%
                    String espacio="  ";
                    int count=0;
                    ProductoDao pro = new ProductoDaoImpl();
                    for(Producto producto :pro.BuscarProducto(buscar_por, buscar)){
                         count++;
                         String marca=producto.getId_marca();marca = marca==null?"":marca; 
                         nombre_prod=producto.getNombre();
                    %>        
                    <tr>     
                        <td><%=count%>.-</td> 
                        <td><a href="Venta_detalle_1.jsp?id_producto=<%=producto.getIdProducto()%>&opcion=add"><%=producto.getNombre()%></a></td>
                        <td align="center"><%=marca%></td>
                        <td align="center"><%=producto.getIdUndMedida()%></td>
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
        <form action="Venta_detalle_1.jsp" method="get"> 
            <table class="table table-bordered">
                <tbody>   
                    <tr>
                        <input type="hidden" name="id_producto"  value="<%=id_producto%>" size="10">
                        <input type="hidden" name="id_venta"  value="<%=id_venta%>" size="10">
                        <td>Nombre:</td>
                        <td><div class="col-sm-15"><input type="text" class="form-control" placeholder="Nombre" value="<%=nombre_prod%>" disabled=""></div></td>
                    </tr>
                    <%if(!marca1.equals("")){%>
                    <tr>
                        <td>Marca:</td>
                        <td><div class="col-sm-15"><input type="text" class="form-control" placeholder="Marca" value="<%=marca1%>" disabled=""></div></td>
                    </tr>
                    <%}%>
                    <tr>
                        <td>Cantidad:</td>
                        <td><div class="col-sm-15"><input type="text" class="form-control" placeholder="Cantidad" name="cant" value="<%=cant%>" required></div></td>
                    </tr>
                    <tr>
                        <td>Costo:</td>
                        <td><div class="col-sm-15"><input type="text" class="form-control" placeholder="Precio Unitario" name="precio" value="<%=precio%>" required></div></td>
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
<%@include file="../../WEB-INF/jspf/botton.jspf" %>