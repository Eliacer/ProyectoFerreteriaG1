<%@page import="java.text.SimpleDateFormat"%>
<%@page import="proy01.modelo.entidad.Rep_compras"%>
<%@page import="proy01.modelo.entidad.Compra"%>
<%@page import="proy01.modelo.daoImpl.CompraDaoImpl"%>
<%@page import="proy01.modelo.dao.CompraDao"%>
<%@page import="proy01.modelo.daoImpl.ProductoDaoImpl"%>
<%@page import="proy01.modelo.dao.ProductoDao"%>
<%@page import="proy01.modelo.entidad.Producto"%>
<jsp:useBean id="f_in" scope="request" class="java.lang.String" />
<jsp:useBean id="f_fn" scope="request" class="java.lang.String" />
<%@include file="WEB-INF/jspf/top.jspf"%>

<div class="container">

<div class="row">
        <div class="col-md-12">
            <h3 align="center">Compras entre dos fechas</h3>
            <form action="controlreportes?opcion=RcomprasF" method="post">
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
            <iframe src="Rep_Compras_1.jsp?f_in=<%=f_in%>&f_fn=<%=f_fn%>" width="100%" height="500">
            </iframe>
        </div>
    </div>
<%}%>
</div>
<%@include file="WEB-INF/jspf/botton.jspf"%>

