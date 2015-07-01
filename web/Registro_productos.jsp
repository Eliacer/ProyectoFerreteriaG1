
<%@page import="proy01.modelo.entidad.Ubicacion"%>
<%@page import="proy01.modelo.entidad.Categoria"%>
<%@page import="proy01.modelo.entidad.Marca"%>
<%@page import="proy01.modelo.entidad.UndMedida"%>
<%@page import="proy01.modelo.daoImpl.CaracteristicasProductoDaoImpl"%>
<%@page import="proy01.modelo.dao.CaracteristicasProductoDao"%>
<jsp:useBean id="opcion" scope="request" class="java.lang.String" />
<jsp:useBean id="mensaje" scope="request" class="java.lang.String" />
<jsp:useBean id="alert" scope="request" class="java.lang.String" />
<jsp:useBean id="id_producto" scope="request" class="java.lang.String" />
<jsp:useBean id="Producto" scope="request" class="proy01.modelo.entidad.Producto" />
<%@include file="WEB-INF/jspf/top.jspf" %>

<div class="container">
    
    <%
        String desc=Producto.getDescripcion();desc = desc == null?"": desc;
        String codigo=Producto.getCodigo();codigo = codigo == null?"": codigo;
        String porc_ganan=String.valueOf(Producto.getPorc_ganacia());porc_ganan = porc_ganan.equals("null")?"":porc_ganan;
    %>

<div class="row">
    <div class="col-md-2"></div>
    <div class="col-md-8" id="aler">
        <br>
        <%
            if(!mensaje.equals("")){
        %>
        <div class="alert alert-<%=alert%>"><%=mensaje%></div> 
        <%}%>
    </div>
    <div class="col-md-2"></div>   
</div>     
<% if(opcion.equals("Registrar")||opcion.equals("Actualizando")){%>
<div class="row"> 
    <div class="col-md-3"></div>      
    <div class="col-md-6 well">
        <h2 align="center"><%=opcion%> datos de un producto</h2><br>     
        <form action="controlproducto" method="get">
            <table class="table table-condensed">
                <tbody>
                    <tr>
                        <input type="hidden" name="opcion"  value="<%=opcion%>" size="10">
                        <input type="hidden" name="id_producto"  value="<%=Producto.getIdProducto()%>" size="10">
                        <td width="40%"><label class="col-sm-8 control-label">C&oacute;digo:</label></td>
                        <td>
                            <div class="col-sm-15">
                                <input type="text" class="form-control" placeholder="código del producto" name="codigo" value="<%=codigo%>" maxlength="20">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><label class="col-sm-8 control-label">Nombre:</label></td>
                        <td>
                            <div class="col-sm-15">
                                <input type="text" class="form-control" placeholder="Nombre del Producto" name="nombre" value="<%=Producto.getNombre()%>" required="" maxlength="200">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><label class="col-sm-8 control-label" >Und. de medida:</label></td>
                        <td><select class="form-control" name="und_medida" selected="selected" <%if(Producto.getIdUndMedida().equals("")){%> selected<%}%>><option>[--Selecciona--]</option>                 
                            <%
                                CaracteristicasProductoDao und_med = new CaracteristicasProductoDaoImpl();
                                for(UndMedida um: und_med.ListarUniMedida()){
                            %>
                             <option value="<%=um.getIdUndMedida()%>" <%if(Producto.getIdUndMedida().equals(um.getIdUndMedida())){%> selected<%}%>> <%=um.getNombre()%></option> 
                             <%}%>
                            </select>
                        </td>
                    </tr> 
                    <tr>
                        <td width="43%"><label class="col-sm-8 control-label" >Porc. Ganancia:</label></td>
                        <td>
                            <div class="col-sm-15">
                                <input type="text" class="form-control" placeholder="Porcentaje de Ganancia" name="porc_ganan" value="<%=porc_ganan%>" required="">
                            </div>
                        </td>
                    </tr>                                 
                    <tr>
                        <td><label class="col-sm-8 control-label" >Marca:</label></td>
                            <td>
                                <select class="form-control" name="id_marca">
                                <option value="00001">[--Selecciona--]</option>                 
                                <%
                                    CaracteristicasProductoDao marcaDao = new CaracteristicasProductoDaoImpl();
                                    for(Marca ma: marcaDao.ListarMarca()){             
                                %>
                                 <option value="<%=ma.getIdMarca()%>" <%if(Producto.getId_marca().equals(ma.getIdMarca())){%> selected<%}%>> <%=ma.getNombreMarca()%></option>
                                 <%}%>
                                </select>
                            </td>
                    </tr>
                    <tr>
                        <td><label class="col-sm-8 control-label" >Categor&iacute;a:</label></td>
                            <td>
                                <select class="form-control" name="id_categoria">
                                <option value="00001">[--Selecciona--]</option>                 
                                <%
                                    CaracteristicasProductoDao categoriaDao = new CaracteristicasProductoDaoImpl();
                                    for(Categoria ca: categoriaDao.ListarCategoria()){
                                %>
                                 <option value="<%=ca.getIdCategoria()%>" <%if(Producto.getId_categoria().equals(ca.getIdCategoria())){%> selected<%}%>> <%=ca.getNombreCategoria()%></option>   
                                 <%}%>
                                </select>
                            </td>
                    </tr>
                    <tr>
                        <td><label class="col-sm-8 control-label">Ubicacion</label></td>
                        <td>
                            <select class="form-control" name="id_ubicacion"
                            <option value="00001">[--Selecciona--]</option>                 
                            <%
                                CaracteristicasProductoDao ub = new CaracteristicasProductoDaoImpl();
                                for(Ubicacion ubic: ub.ListarUbicacion()){
                            %>  
                             <option value="<%=ubic.getId_ubicacion()%>" <%if(Producto.getId_ubicacion().equals(ubic.getId_ubicacion())){%> selected<%}%>> <%=ubic.getNombre_ubicacion()%></option>
                             <%}%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><label class="col-sm-8 control-label" >Descripcion:</label></td>
                        <td>
                            <div class="col-sm-15">
                                <textarea rows="3" class="form-control" placeholder="Descripción" name="descripcion" maxlength="300"><%=desc%></textarea>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <input type="submit" class="btn btn-primary" value="<%=opcion%>">
                            <input type="reset" class="btn btn-default" value="Limpiar">
                        </td> 
                    </tr>
                </tbody>
            </table>
        </form>       
    </div>  
    <div class="col-md-3">           
    </div>
</div>
<%}%>
</div>
<%@include file="WEB-INF/jspf/botton.jspf" %>