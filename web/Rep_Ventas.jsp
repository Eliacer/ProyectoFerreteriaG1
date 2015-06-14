<%@page import="java.text.SimpleDateFormat"%>
<%@page import="proy01.modelo.entidad.Rep_ventas"%>
<%@page import="proy01.modelo.daoImpl.VentaDaoImpl"%>
<%@page import="proy01.modelo.dao.VentaDao"%>
<%@page import="proy01.modelo.entidad.Rep_compras"%>
<%@include file="WEB-INF/jspf/top.jspf"%>

<div class="container">
    <%
        String f_in = request.getParameter("f_in");f_in = f_in == null ? "" : f_in;
        String f_fn = request.getParameter("f_fn");f_fn = f_fn == null ? "" : f_fn;
        SimpleDateFormat formatter = new SimpleDateFormat("dd/mm/yyyy");
        //Date inicio = formatter.parse(f_in);
        //Date fin = formatter.parse(f_fn);
    %>
    
    <div class="row">
        <div class="col-md-12">
            <h3 align="center">Ventas entre dos fechas</h3>
            <form>
                <table align="center">
                    <tbody>
                        <tr>                 
                        <td><label class="col-sm-12 control-label">Fecha inicial</label></td>
                        <td>
                            <div class="col-sm-15">
                                <input type="date" class="form-control" name="f_in" value="<%=f_in%>">
                            </div>
                        </td>
                        <td><label class="col-sm-12 control-label">Fecha final</label></td>
                        <td>
                            <div class="col-sm-15">
                                <input type="date" class="form-control" name="f_fn" value="<%=f_fn%>">
                            </div>
                        </td>
                        <td></td>
                        <td><button type="submit" class="btn btn-primary">Buscar<span class="glyphicon glyphicon-filter" aria-hidden="true"></span></button></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
    </div>
    <br>
<% if(!f_in.equals("")&& !f_fn.equals("")){%>  
    <div class="row">
        <div class="col-md-12">
            <iframe src="Rep_Ventas_1.jsp?f_in=<%=f_in%>&f_fn=<%=f_fn%>" width="100%" height="500">
            </iframe>
        </div>
    </div>
<%}%>
</div>

<%@include file="WEB-INF/jspf/botton.jspf"%>

