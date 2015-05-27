

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
    //SimpleDateFormat formato = new SimpleDateFormat("dd-mm-yyyy");
    
    String id_producto=request.getParameter("id_producto");id_producto = id_producto==null?"":id_producto;
    String codigo=request.getParameter("codigo");codigo = codigo==null?"":codigo;
    String nombre=request.getParameter("nombre");nombre = nombre==null?"":nombre;
    String unidad_medida=request.getParameter("und_medida");unidad_medida = unidad_medida==null?"":unidad_medida;
    String concentracion=request.getParameter("concentracion");concentracion = concentracion==null?"":concentracion;
    //String stock=request.getParameter("stock");stock = stock==null?"":stock;
    //String costo=request.getParameter("costo");costo = costo==null?"":costo;
    String color=request.getParameter("color");color = color==null?"":color;  
    String id_marca=request.getParameter("id_marca");id_marca = id_marca==null?"":id_marca;
    String id_categoria=request.getParameter("id_categoria");id_categoria = id_categoria==null?"":id_categoria;
    String id_ubicacion=request.getParameter("id_ubicacion");id_ubicacion = id_ubicacion==null?"":id_ubicacion;
    String descripcion=request.getParameter("descripcion");descripcion = descripcion==null?"":descripcion;
    String opcion = request.getParameter("opcion");opcion = opcion == null ? "Enviar" : opcion;

    String mensaje="";
    if(opcion.equals("Enviar")||opcion.equals("Actualizando")){
        if(!nombre.equals("") && !concentracion.equals("")&& !unidad_medida.equals("")){
            
            //out.println("opcion="+opcion);
            Producto producto=new Producto();
            ProductoDao pd=new ProductoDaoImpl();
            //CaracteristicasProductoDao cpd = new CaracteristicasProductoDaoImpl();    
             
            producto.setCodigo(codigo);
            producto.setNombre(nombre);
            producto.setIdUndMedida(unidad_medida); 
            producto.setConcentracion(Double.parseDouble(concentracion));
            producto.setColor(color);
            producto.setId_marca(id_marca);
            producto.setId_categoria(id_categoria);
            producto.setId_ubicacion(id_ubicacion);
            producto.setDescripcion(descripcion);
  
            if(opcion.equals("Enviar")){
                if(pd.InsertProducto(producto))
                {
                    opcion="ok";
                    mensaje = "Se añadió corerctamente el producto... <a href='Registro_productos.jsp'>[Seguir Añadiendo] </a><a href='bienvenida.jsp'> [Terminar] </a>";


                }else{
                    mensaje="No se pudo agregar";
                }
            }
            if(opcion.equals("Actualizando")){
                producto.setIdProducto(id_producto);

                if(pd.UpdateProducto(producto)){
                    opcion="ok";
                    mensaje = "Se actualizó corerctamente...<a href='Rep_Productos.jsp'>[Reportes] </a>";
                }
                else{
                    mensaje = "No se pudo actualizar";
                }
            
            }
        }
    }
    
    if(opcion.equals("Actualizar"))
    {      
        //out.println("Id_producto:"+id_producto); 
            if(!id_producto.equals("")){
                
                ProductoDao pd=new ProductoDaoImpl();

                for(Producto producto :pd.ObtenerProducto(id_producto)){

                codigo=producto.getCodigo();codigo = codigo==null?"":codigo;
                //out.println("codigo:"+codigo);
                nombre=producto.getNombre();nombre = nombre==null?"":nombre;
                unidad_medida=producto.getIdUndMedida();unidad_medida = unidad_medida==null?"":unidad_medida;              
                concentracion=String.valueOf(producto.getConcentracion());concentracion = concentracion==null?"":concentracion;
                color=producto.getColor();color = color==null?"":color;
                id_marca=producto.getId_marca();id_marca = id_marca==null?"":id_marca;
                id_categoria=producto.getId_categoria();id_categoria = id_categoria==null?"":id_categoria;
                id_ubicacion=producto.getId_ubicacion();id_ubicacion = id_ubicacion==null?"":id_ubicacion;
                descripcion=producto.getDescripcion();descripcion = descripcion==null?"":descripcion;               
                opcion="Actualizando";
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
        <div class="alert alert-danger"><%=mensaje%></div> 
        <%}%>
    </div>
    <div class="col-md-3"></div>
    
</div>
      
        <% if(opcion.equals("Enviar") ||opcion.equals("Actualizar") || opcion.equals("Actualizando")){%>
        <div class="row"> 
            <div class="col-md-3">     
            </div>
            <div class="col-md-6 well">
                <h2 align="center">Registro de Productos</h2>
                <h6 align="center">Campos Obligatorios (**)</h6>
                
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
                        <td><label class="col-sm-8 control-label" >Concentracion:</label></td>
                        <td>
                            <div class="col-sm-15">
                                <input type="text" class="form-control" placeholder="Concentraci&oacute;n" name="concentracion" value="<%=concentracion%>">
                            </div>
                        </td>
                    </tr>                                 
                    <tr>
                        <td><label class="col-sm-8 control-label" >Color</label></td>
                        <td>
                            <div class="col-sm-15">
                                <input type="text" class="form-control" placeholder="Color" name="color" value="<%=color%>">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><label class="col-sm-8 control-label" >Marca:</label></td>
                            <td>
                                <select class="form-control" name="id_marca" selected="selected" <%if(id_marca.equals("")){%> selected<%}%>><option>[--Selecciona--]</option>                 
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
                                <select class="form-control" name="id_categoria" selected="selected" <%if(id_categoria.equals("")){%> selected<%}%>><option>[--Selecciona--]</option>                 
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
                            <select class="form-control" name="id_ubicacion" selected="selected" <%if(id_ubicacion.equals("")){%> selected<%}%>><option>[--Selecciona--]</option>                 
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