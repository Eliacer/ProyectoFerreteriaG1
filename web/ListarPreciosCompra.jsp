<%@page import="java.util.List"%>
<%@page import="proy01.modelo.entidad.Compra"%>
<jsp:useBean id="listar" scope="request" type="java.util.List" />
<jsp:useBean id="mensaje" scope="request" class="java.lang.String" />
<jsp:useBean id="alert" scope="request" class="java.lang.String" />

<%@include file="WEB-INF/jspf/top.jspf" %>

<div class="container">
    <%     
        String fp="";
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
                      List<Compra> com = listar;
                      for(Compra compra : com){
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
                            <a href="controlprecios?id_compra=<%=compra.getId_compra()%>&opcion=Fijar"><input type="submit" class="btn btn-success" value="Fijar"></a>
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
</div>

<%@include file="WEB-INF/jspf/botton.jspf" %>