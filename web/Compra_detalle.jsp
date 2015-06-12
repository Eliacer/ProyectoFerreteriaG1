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

<div class="container">
    
    <%
    
        HttpSession ses = request.getSession();     
        String num_comp=(String)ses.getAttribute("num_compobante");num_comp = num_comp==null?"":num_comp;
        String id_compra=(String)ses.getAttribute("id_compra");id_compra = id_compra==null?"":id_compra;
        String id_cliente=(String)ses.getAttribute("id_cliente");id_cliente = id_cliente==null?"":id_cliente;   
        String id_producto=request.getParameter("id_producto");id_producto = id_producto==null?"":id_producto;
        String unidad=request.getParameter("unidad");unidad = unidad==null?"":unidad;
        String cant_may=request.getParameter("cant_may");cant_may = cant_may==null?"":cant_may;
        String cant_menor=request.getParameter("cant_menor");cant_menor = cant_menor==null?"":cant_menor;
        String costo=request.getParameter("costo");costo = costo==null?"":costo;
        String buscar_por = request.getParameter("buscar_por");buscar_por = buscar_por==null?"nombre": buscar_por;
        String buscar = request.getParameter("buscar");buscar = buscar==null?"": buscar;
        String opcion = request.getParameter("opcion");opcion = opcion == null ? "Buscar" : opcion;    
        String nombre_proveedor="";
        String nombre_forma_pago="";
        String nombre_tipo_moneda="";
        String nombre_comprobante="";
        String fecha_compra="";
        String nombre_usuario="";
        String direccion_prov="";
        String igv="";
        String flete="";
        String valor_moneda=request.getParameter("valor_moneda");valor_moneda = valor_moneda == null ? "" : valor_moneda;
        String mensaje="";
        String marca1="";
        String nombre_prod="";
        
        String espacio="  ";
        
        if(opcion.equals("Buscar") || opcion.equals("add") || opcion.equals("Agregar") ||opcion.equals("Actualizar")
                || opcion.equals("Actualizando") || opcion.equals("Eliminar")){
            
            if(!id_compra.equals("")){          
                CompraDao dao = new CompraDaoImpl();
                Rep_compras rep_compras = new Rep_compras();
                
                rep_compras = dao.ListarCompraT(id_compra);
                nombre_proveedor=rep_compras.getNombre_proveedor();nombre_proveedor = nombre_proveedor==null?"":nombre_proveedor;
                nombre_forma_pago=rep_compras.getNombre_forma_pago();nombre_forma_pago = nombre_forma_pago==null?"":nombre_forma_pago;
                nombre_tipo_moneda=rep_compras.getNombre_tipo_moneda();nombre_tipo_moneda = nombre_tipo_moneda==null?"":nombre_tipo_moneda;
                nombre_comprobante=rep_compras.getNombre_comprobante();nombre_comprobante = nombre_comprobante==null?"":nombre_comprobante;
                fecha_compra=rep_compras.getFecha_compra();fecha_compra = fecha_compra==null?"":fecha_compra;
                nombre_usuario=rep_compras.getNombre_usuario();nombre_usuario = nombre_usuario==null?"":nombre_usuario;
                direccion_prov=rep_compras.getDireccion_prov();direccion_prov = direccion_prov==null?"":direccion_prov;
                igv=rep_compras.getIgv();igv = igv==null?"":igv;
                flete=rep_compras.getFlete();flete = flete==null?"":flete;
                valor_moneda=String.valueOf(rep_compras.getValor_moneda());valor_moneda = valor_moneda==null?"":valor_moneda;                                
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
                detalleCompra.setValor_moneda(Double.parseDouble(valor_moneda));  
                if(compraDao.RegistrarDetCompra(detalleCompra)){
                    mensaje="Se añadió el producto...";    
                    opcion="Buscar";
                }
                else{
                    mensaje="No se pudo añaadir el producto...";
                    opcion="Buscar";
                }             
            }
        }  
            if(opcion.equals("Actualizando")){
                DetalleCompra dc = new DetalleCompra();
                CompraDao cd = new CompraDaoImpl();
                dc.setId_compra(id_compra);
                dc.setId_producto(id_producto);
                dc.setId_unidad(unidad);
                dc.setCantMayor(Integer.parseInt(cant_may));
                dc.setCantMenor(Integer.parseInt(cant_menor));
                dc.setCostoMayor(Double.parseDouble(costo));
                
                if(cd.UpdateDeompra(dc)){
                    mensaje="Se actualizo correctamente el producto de la compra...";
                    opcion="Buscar";
                }
                else{
                    mensaje="No se pudo actulizar el producto de la compra...";
                    opcion="Buscar";
                }    
            }
            if(opcion.equals("Eliminar")){
                CompraDao cd = new CompraDaoImpl();
                if(cd.DeleteProdCompra(id_compra, id_producto)){
                    mensaje="Se elimino correctamente el producto de la compra...";
                    opcion="Buscar";
                }
                else{
                    mensaje="No se pudo eliminar el producto de la compra...";
                    opcion="Buscar";
                }  
            }   
        }      
        if(opcion.equals("Finalizar")){
            if(!id_compra.equals("")){
                CompraDao cd = new CompraDaoImpl();
                if(cd.StockCompra(id_compra)){
                    mensaje="Se registró correctamente la compra...";
                    response.sendRedirect("FijarPrecios.jsp");
                }
                else{
                    mensaje="Ocurrió un error al registrar la compra...";
                }
            }
        }
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
    
<%if(!opcion.equals("Finalizar")){%>
<div class="row">
    <div class="col-md-1"></div>
    <div class="col-md-10"><h1 align="center"><%=nombre_proveedor%></h1></div>
    <div class="col-md-1"></div>
</div>
<div class="row"> 
    <div class="col-md-7"> 
        <h4 allign="center"><strong>Registro de Compras</strong></h4><br>
        <table width="480" align="left" class="table-responsive">
            <tbody>
            <tr>
                <td width="10"><strong>Fecha:</strong></td>
                <td width="50"><%=fecha_compra%></td>
                <td width="10"></td>
                <td width="15"><strong>Moneda:</strong></td>
                <td width="30"><%=nombre_tipo_moneda%></td>
            </tr>
            <tr>
                <td><strong>F. Pago:</strong></td>
                <td><%=nombre_forma_pago%></td>
                <td></td>
                <td><strong>IGV</strong></td>
                <td width="10"><%=igv%></td>
            </tr>
            <tr>
                <td><strong>Usuario:</strong></td>
                <<td><%=nombre_usuario%></td>
                <td></td>
                <td><strong>Flete:</strong></td>
                <td width="10"><%=flete%></td>
            </tr>
            </tbody>
        </table>   
        <br><br>

        <%if(opcion.equals("Buscar") || opcion.equals("add")|| opcion.equals("Actualizar"))  {%>     
        
        <div class="tab-pane">
            <br><br><h4 align="center">Productos de la compra</h4>
            <table class="table table-hover table-striped table-bordered">
                <thead>
                    <tr>
                        <td width="4%" bgcolor="#FFEFCE"><strong>Cant</strong></td>
                        <td width="4%" bgcolor="#FFEFCE"><strong>Und</strong></td>
                        <td width="25%" bgcolor="#FFEFCE"><strong>Nombre del Producto</strong></td>
                        <td width="7%" align="center" bgcolor="#FFEFCE"><strong>Costo</strong></td>
                        <td width="7%" align="center" bgcolor="#FFEFCE"><strong>Importe</strong></td>
                        <td width="9%" align="center" bgcolor="#FFEFCE"><strong>Opciones</strong></td>
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
                        <td align="center"><%=dc.getCostoMayor()%></td> 
                        <td align="center"><%=dc.getImporte()%></td>
                        <td>
                            <a href="Compra_detalle.jsp?opcion=Actualizar&id_producto=<%=dc.getId_producto()%>" title="Actualizar">
                                <button type="button" class="btn btn-info">
                                    <span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
                                </button>
                            </a>
                            <a href="Compra_detalle.jsp?opcion=Eliminar&id_producto=<%=dc.getId_producto()%>" title="Eliminar">
                                <button type="button" class="btn btn-danger">
                                    <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                                </button>
                            </a>
                        </td>
                    </tr>
                    <%}%>                   
                </tbody>
            </table>
            <form action="Compra_detalle.jsp">
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
        <%}%>
    </div>
    <div class="col-md-5"> 
        <h4 allign="center"><strong>B&uacute;squeda de Productos</strong></h4><br>
        <%if(opcion.equals("Buscar")){%>
            <form class="form-horizontal" action="Compra_detalle.jsp" method="post">  
                
                <table>
                    <tr>
                        <input type="hidden" name="num_comp"  value="<%=num_comp%>" size="10">
                        <input type="hidden" name="opcion"  value="<%=opcion%>" size="10">
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
                                <td width="30%" bgcolor="#FFEFCE"><strong>Nombre del Producto</strong></td>
                                <td width="9%" align="center" bgcolor="#FFEFCE"><strong>Marca</strong></td>
                                <td width="9%" align="center" bgcolor="#FFEFCE"><strong>Precio</strong></td>
                                <td width="9%" align="center" bgcolor="#FFEFCE"><strong>Stock</strong></td>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            espacio=" ";
                            int count=0;
                            ProductoDao pro = new ProductoDaoImpl();
                            for(Producto producto :pro.BuscarProducto(buscar_por, buscar)){
                                 count++;
                                 String marca=producto.getId_marca();marca = marca==null?"":marca; 
                                 nombre_prod=producto.getNombre();

                            %>        
                            <tr>     
                                <input type="hidden" name="id_producto"  value="<%=producto.getIdProducto()%>" size="10">
                                <td><%=count%>.-</td> 
                                <td><a href="Compra_detalle.jsp?id_producto=<%=producto.getIdProducto()%>&opcion=add">
                                 <%=producto.getNombre()%></a></td>
                                <td align="center"><%=marca%></td>
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
            <form action="Compra_detalle.jsp" method="get"> 
                <table class="table table-bordered">
                    <tbody>   
                        <tr>
                            <input type="hidden" name="valor_moneda"  value="<%=valor_moneda%>" size="10">
                            <input type="hidden" name="id_producto"  value="<%=id_producto%>" size="10">
                          <td width="35%">Nombre:</td>
                          <td><div class="col-sm-15"><input type="text" class="form-control" placeholder="Nombre" value="<%=nombre_prod%>" disabled=""></div></td>
                        </tr>
                        <%if(!marca1.equals("")){%>
                        <tr>
                          <td>Marca:</td>
                          <td><div class="col-sm-15"><input type="text" class="form-control" placeholder="Marca" value="<%=marca1%>" disabled=""></div></td>
                        </tr>
                        <%}%>
                        <tr>
                            <td>Und venta:</td>
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
                          <td>Cant x Mayor:</td>
                          <td><div class="col-sm-15"><input type="text" class="form-control" placeholder="Cantidad x Mayor" name="cant_may" value="<%=cant_may%>" required></div></td>
                        </tr>
                        <tr>
                          <td>Cant  x Menor</td>
                          <td><div class="col-sm-15"><input type="text" class="form-control" placeholder="Cantidad x menor" name="cant_menor" value="<%=cant_menor%>" required></div></td>
                        </tr>
                        <tr>
                          <td>Costo</td>
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