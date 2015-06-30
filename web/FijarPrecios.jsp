<%@page import="proy01.modelo.daoImpl.ProductoDaoImpl"%>
<%@page import="proy01.modelo.dao.ProductoDao"%>
<%@page import="proy01.modelo.entidad.Producto"%>
<%@page import="proy01.modelo.entidad.DetalleCompra"%>
<%@page import="proy01.modelo.daoImpl.FijarPreciosCompraDaoImpl"%>
<%@page import="proy01.modelo.dao.FijarPreciosCompraDao"%>
<%@page import="proy01.modelo.daoImpl.CompraDaoImpl"%>
<%@page import="proy01.modelo.entidad.Compra"%>
<%@include file="WEB-INF/jspf/top.jspf" %>

<div class="container">
    <%  
    
        String fp="";
        String sol="S/.  ";
        String opcion = request.getParameter("opcion");opcion = opcion == null ? "" : opcion;
        String id_compra = request.getParameter("id_compra");id_compra = id_compra == null ? "" : id_compra;
        String id_producto = request.getParameter("id_producto");id_producto = id_producto == null ? "" : id_producto;
        String precio = request.getParameter("precio");precio = precio == null ? "" : precio;
        String count1 = request.getParameter("count");count1 = count1 == null ? "" : count1;
        String mensaje="",alert="";
        
        if(opcion.equals("Save")){
            Producto producto = new Producto();
            FijarPreciosCompraDao dao = new FijarPreciosCompraDaoImpl();
            
        
                if(!id_producto.equals("")){
                producto.setIdProducto(id_producto);
                producto.setPrecio(Double.parseDouble(precio));
                if(dao.UpdateProdPrecio(producto)&& dao.Updatedetapf(id_compra, id_producto)){
                    
                    ProductoDao pd = new ProductoDaoImpl();
                    producto=pd.ObtenerDatProducto(id_producto);//obtener Producto
                    mensaje="Se actualizó el precio...";
                    alert="success";
                    opcion="fijar";
                }
                else{
                    mensaje="No se actualizó el precio...";
                    alert="warning";
                    opcion="";
                }
                }
            }
        if(opcion.equals("Terminar")){
            Producto producto = new Producto();
            FijarPreciosCompraDao dao = new FijarPreciosCompraDaoImpl();
        
            if(dao.UpdatePrecio(id_compra)){
                mensaje="Se actualizó el precio...";
                response.sendRedirect("bienvenida.jsp");
                alert="success";
                opcion="";
            }
            else{
                mensaje="Ocurrio un error...";
            }
        }    
                
        
    %>
    <div class="row">
    <div class="col-md-3"></div>
    <div class="col-md-6" id="aler">
        <br>
        <%
            if(!mensaje.equals("")){
        %>
        <div class="alert alert-<%=alert%>"><%=mensaje%></div> 
        <%}%>
    </div>
    <div class="col-md-3"></div>   
    </div>
    <%if(opcion.equals("")){%>
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10 well">
            <div class="tab-pane">
            <table class="table table-hover table-striped table-bordered">
              <thead>
                <tr>
                  <td width="2%" bgcolor="#FFEFCE"><strong>#</strong></td>
                  <td align="center" width="9%" bgcolor="#FFEFCE"><strong>Fecha</strong></td>
                  <td align="center" width="11%" bgcolor="#FFEFCE"><strong>Comprobante</strong></td>
                  <td align="center" width="12%" bgcolor="#FFEFCE"><strong>N&deg; Comprob.</strong></td>
                  <td width="27%" bgcolor="#FFEFCE"><strong>Proveedor</strong></td>
                  <td align="center" width="12%" bgcolor="#FFEFCE"><strong>Forma Pago</strong></td>
                  <td width="21%" align="center" bgcolor="#FFEFCE"><strong>Precio Fijado</strong></td>
                </tr>
              </thead>
              <tbody>             
                  <% 
                  String espacio="  ";
                      int count=0;
                      FijarPreciosCompraDao dao = new FijarPreciosCompraDaoImpl();
                      for(Compra compra : dao.ListarComprasNoFijadasPrecios()){
                          count++;
                      fp=compra.getPrecio_fijado();
                      
                  %>
                <tr>
                    <td><%=count%>.-</td>
                    <td><%=compra.getFechaCompra()%></td>
                    <td  align="center"><%=compra.getId_comprobante()%></td>
                    <td  align="center"><%=compra.getNumComprobante()%></td>
                    <td><%=compra.getId_proveedor()%></td>
                    <td align="center"><%=compra.getId_formaPago()%></td>
                    <td align="center">
                        <%if(fp.equals("0")){%>
                            <a href="FijarPrecios.jsp?id_compra=<%=compra.getId_compra()%>&opcion=fijar"><input type="submit" name="opcion" class="btn btn-success" value="Fijar"></a>
                        <%}%>
                        <%if(fp.equals("1")){%>
                        <button type="button" class="btn btn-info">
                            <span class="glyphicon glyphicon-ok" ></span>
                        </button>
                        <%}%>
                    </td>
                </tr>
                <%}%>
              </tbody>
            </table>
          </div>
        </div>
        <div class="col-md-1"></div>   
    </div>
    <%}%>
    <%if(opcion.equals("fijar")){%>
    <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-8 well">
            
                <div class="tab-pane">
                <table class="table table-hover table-striped table-bordered">
                  <thead>
                    <tr>
                      <td width="2%" bgcolor="#FFEFCE"><strong>#</strong></td>
                      <td align="center" width="23%" bgcolor="#FFEFCE"><strong>Producto</strong></td>
                      <td align="center" width="11%" bgcolor="#FFEFCE"><strong>Precio compra</strong></td>
                      <td align="center" width="12%" bgcolor="#FFEFCE"><strong>Precio sugerido</strong></td>
                      <td align="center" width="18%" bgcolor="#FFEFCE"><strong>Precio</strong></td>
                    </tr>
                  </thead>
                  <tbody>             
                      <% 
                      String espacio="  ";
                          int count=0;
                          FijarPreciosCompraDao dao = new FijarPreciosCompraDaoImpl();
                          for(DetalleCompra compra : dao.ListarCompraPrecioSugerido(id_compra)){
                              count++;
                      %>
                    <tr>
                        <td><%=count%>.-</td>
                        <td><%=compra.getProducto()%></td>
                        <td  align="center"><%=compra.getAbrev()%><%=espacio%><%=compra.getCostoUnidad()%></td>
                        <td  align="center"><%=sol%><%=compra.getPsugerido()%></td>       
                        <td>
                            <form action="FijarPrecios.jsp" method="post">    
                        <div class="col-sm-7">
                            <input type="hidden" name="id_compra"  value="<%=id_compra%>" size="10">
                            <input type="hidden" name="id_producto"  value="<%=compra.getId_producto()%>" size="10">
                            <%if (compra.getPf().equals("1")){%>
                            <input type="text" class="form-control" placeholder="Precio" name="precio<%=count%>" value="<%=compra.getPrecio()%>" disabled="">
                            <%}else{%>
                            <input type="text" class="form-control" placeholder="Precio" name="precio" value="<%=compra.getPsugerido()%>">
                            <%}%>
                        </div>
                            <input type="submit" name="opcion" class="btn btn-success" value="Save">
                        </form>
                        </td>
                    </tr>
                    <%}%>
                    <tr>
                        <td colspan="5" align="center">
                            <a href="FijarPrecios.jsp?id_compra=<%=id_compra%>&opcion=Terminar"><input type="submit" name="opcion" class="btn btn-primary" value="Finalizar"></a>
                        </td>
                    </tr>
                  </tbody>
                </table>
                </div>         
        </div>
        </div>  
        <div class="col-md-2"></div>
    <%}%>
</div>

<%@include file="WEB-INF/jspf/botton.jspf" %>