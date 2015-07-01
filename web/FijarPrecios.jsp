<%@page import="java.util.List"%>
<%@page import="proy01.modelo.entidad.DetalleCompra"%>
<jsp:useBean id="Prodcompra" scope="request" type="java.util.List" />
<jsp:useBean id="mensaje" scope="request" class="java.lang.String" />
<jsp:useBean id="alert" scope="request" class="java.lang.String" />
<jsp:useBean id="id_compra" scope="request" class="java.lang.String" />
<%@include file="WEB-INF/jspf/top.jspf" %>

<div class="container">
    <%  
        String sol="S/.  ";
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
                      <td align="center" width="20%" bgcolor="#FFEFCE"><strong>Precio</strong></td>
                    </tr>
                  </thead>
                  <tbody>             
                      <% 
                      String espacio="  ";
                          int count=0;
                          List<DetalleCompra> buy = Prodcompra;
                          for(DetalleCompra compra: buy){
                              count++;
                      %>
                    <tr>
                        <td><%=count%>.-</td>
                        <td><%=compra.getProducto()%></td>
                        <td  align="center"><%=compra.getAbrev()%><%=espacio%><%=compra.getCostoUnidad()%></td>
                        <td  align="center"><%=sol%><%=compra.getPsugerido()%></td>       
                        <td>
                            <form action="controlprecios" method="post">    
                        <div class="col-sm-7">
                            <input type="hidden" name="id_compra"  value="<%=compra.getId_compra()%>" size="10">
                            <input type="hidden" name="id_producto"  value="<%=compra.getId_producto()%>" size="10">
                            <%if (compra.getPf().equals("1")){%>
                            <input type="text" class="form-control" placeholder="Precio" name="precio<%=count%>" value="<%=compra.getPrecio()%>" disabled="">
                            <%}else{%>
                            <input type="text" class="form-control" placeholder="Precio" name="precio" value="<%=compra.getPsugerido()%>">
                            <%}%>
                        </div>
                            <input type="submit" name="opcion" class="btn btn-success" value="Guardar">
                        </form>
                        </td>
                    </tr>
                    <%}%>
                    <tr>
                        <td colspan="5" align="center">
                            <a href="controlprecios?id_compra=<%=id_compra%>&opcion=Terminar"><input type="submit" name="opcion" class="btn btn-primary" value="Finalizar"></a>
                        </td>
                    </tr>
                  </tbody>
                </table>
                </div>         
        </div> 
        <div class="col-md-2"></div>
    </div>
</div>

<%@include file="WEB-INF/jspf/botton.jspf" %>