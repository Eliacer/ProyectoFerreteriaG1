

<%@page import="proy01.modelo.entidad.Unidad"%>
<%@page import="proy01.modelo.entidad.UndMedida"%>
<%@page import="proy01.modelo.daoImpl.ProductoDaoImpl"%>
<%@page import="proy01.modelo.dao.ProductoDao"%>
<%@page import="proy01.modelo.entidad.Producto"%>
<%@page import="proy01.modelo.daoImpl.CaracteristicasProductoDaoImpl"%>
<%@page import="proy01.modelo.dao.CaracteristicasProductoDao"%>
<%@page import="proy01.modelo.entidad.Ubicacion"%>
<%@page import="proy01.modelo.entidad.Categoria"%>
<%@page import="proy01.modelo.entidad.Marca"%>
<%@include file="WEB-INF/jspf/top.jspf" %>

<div class="container">
    
    <%
    String id_producto=request.getParameter("id_producto");id_producto = id_producto==null?"":id_producto;
    String codigo=request.getParameter("codigo");codigo = codigo==null?"":codigo;
    String nombre=request.getParameter("nombre");nombre = nombre==null?"":nombre;
    String unidad_medida=request.getParameter("und_medida");unidad_medida = unidad_medida==null?"":unidad_medida;
    String porc_ganan=request.getParameter("porc_ganan");porc_ganan = porc_ganan==null?"":porc_ganan;
    String id_marca=request.getParameter("id_marca");id_marca = id_marca==null?"":id_marca;
    String id_categoria=request.getParameter("id_categoria");id_categoria = id_categoria==null?"":id_categoria;
    String id_ubicacion=request.getParameter("id_ubicacion");id_ubicacion = id_ubicacion==null?"":id_ubicacion;
    String descripcion=request.getParameter("descripcion");descripcion = descripcion==null?"":descripcion;
    String opcion = request.getParameter("opcion");opcion = opcion == null ? "Enviar" : opcion;

    String mensaje="";
    String alert="";
    if(opcion.equals("Enviar")||opcion.equals("Actualizando")){
        if(!nombre.equals("") && !porc_ganan.equals("")&& !unidad_medida.equals("")){
            
            Producto producto=new Producto();
            ProductoDao pd=new ProductoDaoImpl();
            producto.setCodigo(codigo);
            producto.setNombre(nombre);
            producto.setIdUndMedida(unidad_medida); 
            producto.setPorc_ganacia(Double.parseDouble(porc_ganan));
            producto.setId_marca(id_marca);
            producto.setId_categoria(id_categoria);
            producto.setId_ubicacion(id_ubicacion);
            producto.setDescripcion(descripcion);
  
            if(opcion.equals("Enviar")){
                if(pd.InsertProducto(producto))
                {        
                    opcion="ok";
                    alert="success";
                    mensaje = "Se añadió corerctamente el producto... <a href='Registro_productos.jsp'>[Seguir Añadiendo] </a><a href='bienvenida.jsp'> [Terminar] </a>";
                }else{
                    alert="danger";
                    mensaje="No se pudo agregar";
                }
            }
            if(opcion.equals("Actualizando")){
                producto.setIdProducto(id_producto);

                if(pd.UpdateProducto(producto)){
                    
                    alert="success";
                    opcion="ok";
                    mensaje = "Se actualizó corerctamente...<a href='Rep_Productos.jsp'>[Reportes] </a>";
                }
                else{
                    alert="warning";
                    mensaje = "No se pudo actualizar";
                }
            
            }
        }
    }
    if(opcion.equals("Actualizar"))
    {      
        if(!id_producto.equals("")){
            Producto producto = new Producto();
            ProductoDao pd=new ProductoDaoImpl();
            producto = pd.ObtenerProducto(id_producto);

            codigo=producto.getCodigo();codigo = codigo==null?"":codigo;
            nombre=producto.getNombre();nombre = nombre==null?"":nombre;
            unidad_medida=producto.getIdUndMedida();unidad_medida = unidad_medida==null?"":unidad_medida;              
            porc_ganan=String.valueOf(producto.getPorc_ganacia());porc_ganan = porc_ganan==null?"":porc_ganan;
            id_marca=producto.getId_marca();id_marca = id_marca==null?"":id_marca;
            id_categoria=producto.getId_categoria();id_categoria = id_categoria==null?"":id_categoria;
            id_ubicacion=producto.getId_ubicacion();id_ubicacion = id_ubicacion==null?"":id_ubicacion;
            descripcion=producto.getDescripcion();descripcion = descripcion==null?"":descripcion;               
            opcion="Actualizando";  
        }
}
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
<% if(opcion.equals("Enviar") ||opcion.equals("Actualizar") || opcion.equals("Actualizando")){%>
<div class="row"> 
    <div class="col-md-3"></div>      
    <div class="col-md-6 well" id="reg2">
        <h2 align="center">Registro de Productos</h2>     
        <form action="Registro_productos.jsp" method="post">
            <table class="table table-condensed">
                <tbody>
                    <tr>
                        <input type="hidden" name="opcion"  value="<%=opcion%>" size="10">
                        <input type="hidden" name="id_producto"  value="<%=id_producto%>" size="10">
                        <td><label class="col-sm-8 control-label">C&oacute;digo:</label></td>
                        <td>
                            <div class="col-sm-15">
                                <input type="text" class="form-control" placeholder="código del producto" name="codigo" value="<%=codigo%>">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><label class="col-sm-8 control-label">Nombre:</label></td>
                        <td>
                            <div class="col-sm-15">
                                <input type="text" class="form-control" placeholder="Nombre del Producto" name="nombre" value="<%=nombre%>" required="" >
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><label class="col-sm-8 control-label" >Und. de medida:</label></td>
                        <td><select class="form-control" name="und_medida" selected="selected" <%if(unidad_medida.equals("")){%> selected<%}%>><option>[--Selecciona--]</option>                 
                            <%
                                CaracteristicasProductoDao und_med = new CaracteristicasProductoDaoImpl();

                                for(UndMedida um: und_med.ListarUniMedida()){

                            %>
                             <option value="<%=um.getIdUndMedida()%>" <%if(unidad_medida.equals(um.getIdUndMedida())){%> selected<%}%>> <%=um.getNombre()%></option> 
                             <%}%>
                            </select>
                        </td>
                    </tr> 
                    <tr>
                        <td width="43%"><label class="col-sm-8 control-label" >Porc. Ganancia:</label></td>
                        <td>
                            <div class="col-sm-15">
                                <input type="text" class="form-control" placeholder="Porcentaje de Ganancia" name="porc_ganan" value="<%=porc_ganan%>">
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
                                 <option value="<%=ma.getIdMarca()%>" <%if(id_marca.equals(ma.getIdMarca())){%> selected<%}%>> <%=ma.getNombreMarca()%></option>
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
                                 <option value="<%=ca.getIdCategoria()%>" <%if(id_categoria.equals(ca.getIdCategoria())){%> selected<%}%>> <%=ca.getNombreCategoria()%></option>   
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
                             <option value="<%=ubic.getId_ubicacion()%>" <%if(id_ubicacion.equals(ubic.getId_ubicacion())){%> selected<%}%>> <%=ubic.getNombre_ubicacion()%></option>
                             <%}%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><label class="col-sm-8 control-label" >Descripcion:</label></td>
                        <td>
                            <div class="col-sm-15">
                                <textarea rows="3" class="form-control" placeholder="Descripción" name="descripcion"><%=descripcion%></textarea>
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