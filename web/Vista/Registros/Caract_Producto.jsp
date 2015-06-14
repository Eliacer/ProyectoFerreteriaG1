
<%@page import="proy01.modelo.daoImpl.CaracteristicasProductoDaoImpl"%>
<%@page import="proy01.modelo.dao.CaracteristicasProductoDao"%>
<%@include file="../../WEB-INF/jspf/top.jspf" %>
<div class="container">
<%
    
    String opcion=request.getParameter("opcion");opcion = opcion==null?"": opcion;
    String nombre=request.getParameter("nombre");nombre = nombre==null?"": nombre;
    String dato=request.getParameter("dato");dato = dato==null?"": dato;
    String mensaje="";
    String alert="";
    
    if(opcion.equals("agregar")){
        
        CaracteristicasProductoDao dao = new CaracteristicasProductoDaoImpl();
        
        if(dao.Add_Caracteristicas(nombre, dato)){
            alert="success";
            mensaje = "Se añadió corerctamente la "+nombre+"... <a href='Caract_Producto.jsp'>[Seguir Añadiendo] </a><a href='bienvenida.jsp'> [Terminar] </a>";
        }
        else{
            alert="warning";
            mensaje = "No se pudo agregar.";
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

<% if(opcion.equals("")){%>
    <div class="row">
        <div class="col-md-4"></div>
        <div class="col-md-5 well">
            <h3 align="center">¿Qu&eacute; desea registrar?</h3>
            <div class="form1_1">
                <form class="form1" action="Caract_Producto.jsp">
                    <div class="form-group">
                        <div class="col-xs-offset-3 col-xs-9">
                            <input type="hidden" name="opcion"  value="registrar" size="10">
                            <input type="submit" class="btn btn-primary" name="nombre" value="Categoria">
                            <input type="submit" class="btn btn-primary" name="nombre" value="Ubicacion">
                            <input type="submit" class="btn btn-primary" name="nombre" value="Marca">
                        </div>                        
                    </div>
                </form>
            </div>
        </div>
        <div class="col-md-3"></div>     
    </div>
<%}%>
<% if(opcion.equals("registrar")){%>
<div class="container">
    <div class="row">
    <div class="col-md-4"></div>
    <div class="col-md-4">
        <h3 align="center">Registrar <%=nombre%></h3>
        <br>
        <form class="form-horizontal" action="Caract_Producto.jsp">
            <div class="form-group">
                <div class="input-group">
                    <input type="hidden" name="opcion"  value="agregar" size="10">
                    <input type="hidden" name="nombre"  value="<%=nombre%>" size="10">
                    <input type="text" class="form-control" placeholder="Nombre de la <%=nombre%>" name="dato">
                        <span class="input-group-btn">
                          <button type="submit" class="btn btn-primary">Agregar</button>
                        </span>
                </div><!-- /input-group -->
            </div>          
        </form>
    </div>
    <div class="col-md-4"></div>
</div>
</div>
<%}%>
<%@include file="../../WEB-INF/jspf/botton.jspf" %>