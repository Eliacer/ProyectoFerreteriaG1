<%@page import="proy01.modelo.entidad.TipoMoneda"%>
<%@page import="proy01.modelo.entidad.Compra"%>
<%@page import="proy01.modelo.daoImpl.CompraDaoImpl"%>
<%@page import="proy01.modelo.dao.CompraDao"%>
<%@include file="WEB-INF/jspf/top.jspf" %>

<div class="container">
    <%  
    
        String fp="";
        String sol="S/.  ";
        String opcion = request.getParameter("opcion");opcion = opcion == null ? "" : opcion;
        String id_moneda = request.getParameter("id_moneda");id_moneda = id_moneda == null ? "" : id_moneda;
        String valor_actual = request.getParameter("valor_actual");valor_actual = valor_actual == null ? "" : valor_actual;
        String count1 = request.getParameter("count");count1 = count1 == null ? "" : count1;
        String mensaje="",alert="";
        
        CompraDao dao = new CompraDaoImpl();
        TipoMoneda moneda= new TipoMoneda();              
        
        if(opcion.equals("Save")){
            
                if(!id_moneda.equals("")){
                moneda.setIdMoneda(id_moneda);
                moneda.setValorActual(Double.parseDouble(valor_actual));
                if(dao.UpdateMoneda(moneda)){
                    
                    mensaje="Se actualizó el valor actual de la moneda...";
                    alert="success";
                    opcion="fijar";
                }
                else{
                    mensaje="Ocurrio un error al actualizar...";
                    alert="warning";
                    opcion="";
                }
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
    <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-8 well">
            <div class="tab-pane">
            <table class="table table-hover table-striped table-bordered">
              <thead>
                <tr>
                  <td width="1%" bgcolor="#FFEFCE"><strong>#</strong></td>
                  <td width="15%" bgcolor="#FFEFCE"><strong>Nombre de la moneda</strong></td>
                  <td align="center" width="10%" bgcolor="#FFEFCE"><strong>Valor soles</strong></td>
                  <td align="center" width="12%" bgcolor="#FFEFCE"><strong>Valor Actual</strong></td>
                </tr>
              </thead>
              <tbody>             
                  <% 
                  String espacio="  ";
                      int count=0;
                      for(TipoMoneda moneda1 : dao.ListarMoneda()){
                          count++;
                  %>
                <tr>
                    <td><%=count%>.-</td>
                    <td><%=moneda1.getNombre()%></td>
                    <td align="center"><%=moneda1.getValorActual()%></td>
                    <td align="center">
                        <form action="FijarMoneda.jsp" method="post">    
                        <div class="col-sm-7">
                            <input type="hidden" name="id_moneda"  value="<%=moneda1.getIdMoneda()%>" size="10">
                            <input type="text" class="form-control" placeholder="Precio" name="valor_actual" value="<%=moneda1.getValorActual()%>">
                        </div>
                            <input type="submit" name="opcion" class="btn btn-success" value="Save">
                        </form>
                    </td>
                </tr>
                <%}%>
              </tbody>
            </table>
          </div>
        </div>
        <div class="col-md-2"></div>   
    </div>  
</div>

<%@include file="WEB-INF/jspf/botton.jspf" %>