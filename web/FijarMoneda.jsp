
<%@page import="proy01.modelo.entidad.TipoMoneda"%>
<%@page import="java.util.List"%>

<%@include file="WEB-INF/jspf/top.jspf" %>
<jsp:useBean id="listar" scope="request" type="java.util.List" />
<jsp:useBean id="id_moneda" scope="request" class="java.lang.String" />
<jsp:useBean id="alert" scope="request" class="java.lang.String" />
<jsp:useBean id="mensaje" scope="request" class="java.lang.String" />
<jsp:useBean id="opcion" scope="request" class="java.lang.String" />

    
<div class="container">
    
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
    <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-8 well">
            <h3 align="center">Lista de Monedas</h3>
            <div class="tab-pane">
                <table class="table table-hover table-striped table-bordered">
                      <thead>
                        <tr>
                          <td width="5%" bgcolor="#FFEFCE"><strong>#</strong></td>
                          <td width="20%" bgcolor="#FFEFCE"><strong>Nombre de la moneda</strong></td>
                          <td align="center" width="15%" bgcolor="#FFEFCE"><strong>Abreviatura</strong></td>
                          <td align="center" width="15%" bgcolor="#FFEFCE"><strong>Valor soles</strong></td>
                          <td colspan="2" align="center" width="20%" bgcolor="#FFEFCE"><strong>Opciones</strong></td>
                        </tr>
                      </thead>
                    <tbody>
                        <%
                            int count=0;
                            List<TipoMoneda> moneda=listar;
                            for(TipoMoneda tm: moneda){
                                count++;

                        %>
                        <tr>
                            <td><%=count%></td>
                            <td><%=tm.getNombre()%></td>
                            <td align="center"><%=tm.getAbrev()%></td>
                            <td align="center"><%=tm.getValorActual()%></td>
                            <td align="center">
                                <a href="controlmoneda?opcion=Actualizar&id_moneda=<%=tm.getIdMoneda()%>">
                                    <button type="button" class="btn btn-info"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span></button>
                                </a>
                            </td>
                            <td align="center">
                                <a href="controlmoneda?opcion=Eliminar&id_moneda=<%=tm.getIdMoneda()%>">
                                    <button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
                                </a>
                            </td>
                        </tr>
                        <%}%>
                        <tr>
                            <td colspan="6" align="center">
                                <a href="controlmoneda?opcion=Agregar">
                                    <input type="button" class="btn btn-primary" value="Agregar">
                                </a>
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
