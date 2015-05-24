

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
    String medida=request.getParameter("medida");medida = medida==null?"":medida;
    String p_compra=request.getParameter("p_compra");p_compra = p_compra==null?"":p_compra;
    String igv=request.getParameter("igv");igv = igv==null?"":igv;
    String flete=request.getParameter("flete");flete = flete==null?"":flete;
    String p_mayor=request.getParameter("Mayor");p_mayor = p_mayor==null?"":p_mayor; 
    String p_publico=request.getParameter("Publico");p_publico = p_publico==null?"":p_publico;
    String p_credito=request.getParameter("Credito");p_credito = p_credito==null?"":p_credito;
    String unidad=request.getParameter("unidad");unidad = unidad==null?"":unidad;
    String cantidad=request.getParameter("cantidad");cantidad = cantidad==null?"":cantidad;
    String color=request.getParameter("color");color = color==null?"":color;  
    /*String peso_kg=request.getParameter("peso_kg");peso_kg = peso_kg==null?"":peso_kg;*/
    String id_marca=request.getParameter("id_marca");id_marca = id_marca==null?"":id_marca;
    String id_categoria=request.getParameter("id_categoria");id_categoria = id_categoria==null?"":id_categoria;
    String id_ubicacion=request.getParameter("id_ubicacion");id_ubicacion = id_ubicacion==null?"":id_ubicacion;
    String descripcion=request.getParameter("descripcion");descripcion = descripcion==null?"":descripcion;
    String opcion = request.getParameter("opcion");opcion = opcion == null ? "Enviar" : opcion;

    String mensaje="";
    if(opcion.equals("Enviar")||opcion.equals("Actualizando")){
        if(!nombre.equals("") && !p_mayor.equals("")&& !p_publico.equals("")
          && !p_credito.equals("") && !cantidad.equals("")){
            
            out.println("opcion="+opcion);
            Producto producto=new Producto();
            ProductoDao pd=new ProductoDaoImpl();
            CaracteristicasProductoDao cpd = new CaracteristicasProductoDaoImpl();
            
            double p_may=cpd.GenerarP_Mayor(Double.parseDouble(p_compra), Double.parseDouble(p_mayor),
                        Double.parseDouble(igv),Double.parseDouble(flete));
            double p_cred=cpd.GenerarP_Credito(Double.parseDouble(p_compra), Double.parseDouble(p_credito),
                        Double.parseDouble(igv),Double.parseDouble(flete));
            double p_pub=cpd.GenerarP_Publico(Double.parseDouble(p_compra), Double.parseDouble(p_publico),
                        Double.parseDouble(igv),Double.parseDouble(flete));
            
            producto.setCodigo(codigo);
            producto.setNombre(nombre);
            producto.setUndMedida(unidad_medida);
            producto.setMedida(medida);
            producto.setId_unidad(unidad);
            producto.setCantidad(cantidad);
            producto.setPrecioCompra(Double.parseDouble(p_compra));
            producto.setPrecioMayor(p_may);
            producto.setPrecioPublico(p_pub);
            producto.setPrecioCredito(p_cred);
            producto.setColor(color);
            producto.setId_marca(id_marca);
            producto.setId_categoria(id_categoria);
            producto.setId_ubicacion(id_ubicacion);
            producto.setDescripcion(descripcion);
            producto.setPorc_mayor(Double.parseDouble(p_mayor));
            producto.setPorc_pub(Double.parseDouble(p_publico));
            producto.setPorc_cred(Double.parseDouble(p_credito));
            producto.setIgv(Double.parseDouble(igv));
            producto.setFlete(Double.parseDouble(flete));
            
            if(opcion.equals("Enviar")){
                if(pd.InsertProducto(producto))
                {
                    //opcion="run";
                    mensaje = "Se añadió corerctamente el producto... <a href='Registro_productos.jsp'>[Seguir Añadiendo] </a><a href='bienvenida.jsp'> [Terminar] </a>";


                }else{
                    mensaje="No se pudo agregar";
                }
            }
            if(opcion.equals("Actualizando")){
                producto.setIdProducto(id_producto);

                if(pd.UpdateProducto(producto)){
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
                unidad_medida=producto.getUndMedida();unidad_medida = unidad_medida==null?"":unidad_medida;
                medida=producto.getMedida();medida = medida==null?"":medida;
                p_publico=String.valueOf(producto.getPorc_pub());p_publico = p_publico==null?"":p_publico;
                p_credito=String.valueOf(producto.getPorc_cred());p_credito = p_credito==null?"":p_credito;
                p_mayor=String.valueOf(producto.getPorc_mayor());p_mayor = p_mayor==null?"":p_mayor;
                color=producto.getColor();color = color==null?"":color;
                id_marca=producto.getId_marca();id_marca = id_marca==null?"":id_marca;
                id_categoria=producto.getId_categoria();id_categoria = id_categoria==null?"":id_categoria;
                id_ubicacion=producto.getId_ubicacion();id_ubicacion = id_ubicacion==null?"":id_ubicacion;
                descripcion=producto.getDescripcion();descripcion = descripcion==null?"":descripcion;     
                unidad=producto.getId_unidad();unidad = unidad==null?"":unidad;
                cantidad=producto.getCantidad();cantidad = cantidad==null?"":cantidad;
                p_compra=String.valueOf(producto.getPrecioCompra());p_compra = p_compra==null?"":p_compra;
                igv=String.valueOf(producto.getIgv());igv = igv==null?"":igv;
                flete=String.valueOf(producto.getFlete());flete = flete==null?"":flete;
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
            <div class="form0">
            <div class="col-md-2">     
            </div>
            <div class="col-md-8 well">
                <div class="titleform1">
                <h2>Formulario de Registro de Productos</h2>
                <h6>Campos Obligatorios (**)</h6>
                </div>
                <br>
                <div class="form2">
                    <form class="form-horizontal" action="Registro_productos.jsp">
                    <input type="hidden" name="opcion"  value="<%=opcion%>" size="10">
                    <input type="hidden" name="id_producto"  value="<%=id_producto%>" size="10">
                    <div class="form-group">
                        <label class="control-label col-xs-3">C&oacute;digo del producto:</label>
                        <div class="col-xs-9">
                            <input type="text" class="form-control" placeholder="código del producto" name="codigo" value="<%=codigo%>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3">Nombre producto **:</label>
                        <div class="col-xs-9">
                            <input type="text" class="form-control" placeholder="Nombre del Producto" name="nombre" value="<%=nombre%>" required="" >
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3" >Unidad de medida:</label>
                        <div class="col-xs-4">
                            <select class="form-control" name="und_medida" selected="selected" <%if(unidad_medida.equals("")){%> selected<%}%>><option>[--Selecciona--]</option>                 
                            <%
                                CaracteristicasProductoDao und_med = new CaracteristicasProductoDaoImpl();
                                
                                for(UndMedida um: und_med.ListarUniMedida()){
                                  
                            %>
                             <option value="<%=um.getIdUndMedida()%>" <%if(unidad_medida.equals(um.getIdUndMedida())){%> selected<%}%>> <%=um.getNombre()%></option> 
                             <%}%>
                            </select>
                        </div>
                            <label class="control-label col-xs-2" >Medida:</label>
                        <div class="col-xs-3">
                            <input type="text" class="form-control" placeholder="Medida" name="medida" value="<%=medida%>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3" >Unidad:</label>
                        <div class="col-xs-4">
                            <select class="form-control" name="unidad" selected="selected" <%if(unidad.equals("")){%> selected<%}%>><option>[--Selecciona--]</option>                 
                            <%
                                
                                for(Unidad unid : und_med.ListarUnidad()){
                                  
                            %>
                             <option value="<%=unid.getId_unidad()%>" <%if(unidad.equals(unid.getId_unidad())){%> selected<%}%>> <%=unid.getNombre_unidad()%></option>
                             <%}%>
                            </select>
                        </div>
                        <label class="control-label col-xs-2" >Cantidad **: </label>
                        <div class="col-xs-3">
                            <input type="text" class="form-control" placeholder="Cantidad" name="cantidad" value="<%=cantidad%>" required="">
                        </div>
                    </div>
                        <div class="form-group">
                            <label class="control-label col-xs-3" ></label>
                            <label class="control-label col-xs-3">
                                <div align="center">Precio de compra</div>
                            </label>
                            <label class="control-label col-xs-3" align="center">
                                <div align="center">IGV</div>
                            </label>
                            <label class="control-label col-xs-3" align="center">
                                <div align="center">Flete</div>
                            </label>                     
                            <label class="control-label col-xs-3" ></label>
                            <div class="col-xs-3">
                                <input type="text" class="form-control" placeholder="P. compra" name="p_compra"  value="<%=p_compra%>" required="">
                            </div>
                            <div class="col-xs-3">
                                <input type="text" class="form-control" placeholder="IGV (0-100%)" name="igv"  value="<%=igv%>" required="">
                            </div>
                            <div class="col-xs-3">
                                <input type="text" class="form-control" placeholder="Flete (0-100%)" name="flete"  value="<%=flete%>" required="">
                            </div>
                        </div>
                    <div class="form-group">
                        
                        <label class="control-label col-xs-3" >Porc. de ganancia</label>
                        <label class="control-label col-xs-3">
                            <div align="center">% Mayor</div>
                        </label>
                        <label class="control-label col-xs-3" align="center">
                            <div align="center">% P&uacute;blico</div>
                        </label>
                        <label class="control-label col-xs-3" align="center">
                            <div align="center">% Cr&eacute;dito</div>
                        </label>
                        <label class="control-label col-xs-3" ></label>
                        <div class="col-xs-3">
                            <input type="text" class="form-control" placeholder="% Mayor" name="Mayor"  value="<%=p_mayor%>" required="">
                        </div>
                        <div class="col-xs-3">
                            <input type="text" class="form-control" placeholder="% P&uacute;blico" name="Publico"  value="<%=p_publico%>" required="">
                        </div>
                        <div class="col-xs-3">
                            <input type="text" class="form-control" placeholder="% Cr&eacute;dito" name="Credito"  value="<%=p_credito%>" required="">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3" >Color</label>
                        <div class="col-xs-9">
                            <input type="text" class="form-control" placeholder="Color" name="color" value="<%=color%>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3" >Marca:</label>
                        <div class="col-xs-9">
                            <select class="form-control" name="id_marca" selected="selected" <%if(id_marca.equals("")){%> selected<%}%>><option>[--Selecciona--]</option>                 
                            <%
                                CaracteristicasProductoDao marcaDao = new CaracteristicasProductoDaoImpl();
                                
                                for(Marca ma: marcaDao.ListarMarca()){             
                                  
                            %>
                             <option value="<%=ma.getIdMarca()%>" <%if(id_marca.equals(ma.getIdMarca())){%> selected<%}%>> <%=ma.getNombreMarca()%></option>
                             <%}%>
                            </select>
                        </div>
                    </div>   
                    <div class="form-group">
                        <label class="control-label col-xs-3" >Categor&iacute;a:</label>
                        <div class="col-xs-9">
                            <select class="form-control" name="id_categoria" selected="selected" <%if(id_categoria.equals("")){%> selected<%}%>><option>[--Selecciona--]</option>                 
                            <%
                                CaracteristicasProductoDao categoriaDao = new CaracteristicasProductoDaoImpl();
                                
                                for(Categoria ca: categoriaDao.ListarCategoria()){
                                    
                            %>
                             <option value="<%=ca.getIdCategoria()%>" <%if(id_categoria.equals(ca.getIdCategoria())){%> selected<%}%>> <%=ca.getNombreCategoria()%></option>   
                             <%}%>
                            </select>
                        </div>
                    </div>    
                    <div class="form-group">
                        <label class="control-label col-xs-3">Ubicacion</label>
                        <div class="col-xs-9">
                            <select class="form-control" name="id_ubicacion" selected="selected" <%if(id_ubicacion.equals("")){%> selected<%}%>><option>[--Selecciona--]</option>                 
                            <%
                                CaracteristicasProductoDao ub = new CaracteristicasProductoDaoImpl();
                                
                                for(Ubicacion ubic: ub.ListarUbicacion()){
                                   
                            %>  
                             <option value="<%=ubic.getIdUbicacion()%>" <%if(id_ubicacion.equals(ubic.getIdUbicacion())){%> selected<%}%>> <%=ubic.getNombreUbicacion()%></option>
                             <%}%>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3" >Descripcion:</label>
                        <div class="col-xs-9">
                            <textarea rows="3" class="form-control" placeholder="Dirección" name="descripcion" value="<%=descripcion%>"></textarea>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                    <div class="col-md-2">           
                    </div>
                    <div class="col-md-7">  
                    <div class="form-group">
                        <div class="col-xs-offset-3 col-xs-9">
                            <input type="submit" class="btn btn-primary" value="<%=opcion%>">
                            <input type="reset" class="btn btn-default" value="Limpiar">
                        </div>
                        <br><br><br>
                    </div></div>
                    <div class="col-md-3">           
                    </div>
                    </div>
                </form>
                </div>       
            </div>  
            <div class="col-md-2">           
            </div>
        </div>
    </div>
    <%}%>
</div>
<%@include file="WEB-INF/jspf/botton.jspf" %>