

<%@page import="java.util.List"%>

<%@include file="WEB-INF/jspf/top.jspf" %>
<jsp:useBean id="id_moneda" scope="request" class="java.lang.String" />
<jsp:useBean id="alert" scope="request" class="java.lang.String" />
<jsp:useBean id="mensaje" scope="request" class="java.lang.String" />
<jsp:useBean id="opcion" scope="request" class="java.lang.String" />
<jsp:useBean id="Moneda" scope="request" class="proy01.modelo.entidad.TipoMoneda" />
    
<div class="container">
    <%
        String espacio=" ";
        String nombre=String.valueOf(Moneda.getNombre());nombre=nombre.equals("null")?"" : nombre;
        String abrev=String.valueOf(Moneda.getAbrev());abrev=abrev.equals("null")?"" : abrev;
        String valor_actual=String.valueOf(Moneda.getValorActual());valor_actual=valor_actual.equals("null")?"" : valor_actual;
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
    
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <h3 align="center"><%=opcion%><%=espacio%> Moneda</h3><br>
            <form action="controlmoneda" method="post"> 
            <table class="table table-condensed">
                <tbody>
                    <input type="hidden" name="opcion"  value="<%=opcion%>" size="10">
                    <input type="hidden" name="id_moneda"  value="<%=Moneda.getIdMoneda()%>" size="10">
                    <tr>
                        <td width="45%"><label class="col-sm-7 control-label">Moneda</label></td>
                        <td>
                            <div class="col-sm-15">
                                <input rows="3" class="form-control" placeholder="Moneda" name="nombre_moneda" value="<%=nombre%>" required="">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><label class="col-sm-7 control-label">Abreviatura:</label></td>
                        <td>
                            <div class="col-sm-15">
                                <input rows="3" type="text" class="form-control"  placeholder="Abreviatura" name="abrev" value="<%=abrev%>">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><label class="col-sm-7 control-label">Valor en Soles:</label></td>
                        <td>
                            <div class="col-sm-15">
                                <input rows="3" type="text" class="form-control"  placeholder="Valor Soles" name="valor_actual" value="<%=valor_actual%>" required="">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <input type="submit" class="btn btn-primary" value="<%=opcion%>">
                        </td> 
                    </tr>
                </tbody>
            </table>
            </form>
        </div>
    </div>       
</div>
            
    <%@include file="WEB-INF/jspf/botton.jspf" %>
