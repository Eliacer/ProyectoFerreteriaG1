<%@page import="proy01.modelo.daoImpl.TipoDocumentoDaoImpl"%>
<%@page import="proy01.modelo.entidad.Cliente"%>
<%@page import="proy01.modelo.entidad.CatCliente"%>
<%@page import="proy01.modelo.entidad.Proveedor"%>
<%@page import="proy01.modelo.entidad.Usuario"%>
<%@page import="proy01.modelo.entidad.Rol"%>
<%@page import="proy01.modelo.entidad.TipoDocumento"%>
<%@page import="proy01.modelo.dao.TipoDocumentoDao"%>
<%@page import="java.util.*"%>
<jsp:useBean id="opcion" scope="request" class="java.lang.String" />
<jsp:useBean id="mensaje" scope="request" class="java.lang.String" />
<jsp:useBean id="alert" scope="request" class="java.lang.String" />
<jsp:useBean id="id_persona" scope="request" class="java.lang.String" />
<jsp:useBean id="t_per" scope="request" class="java.lang.String" />
<jsp:useBean id="Persona" scope="request" class="proy01.modelo.entidad.Persona" />
<jsp:useBean id="Usuario" scope="request" class="proy01.modelo.entidad.Usuario" />
<jsp:useBean id="Proveedor" scope="request" class="proy01.modelo.entidad.Proveedor" />
<jsp:useBean id="Cliente" scope="request" class="proy01.modelo.entidad.Cliente" />
<%@include file="WEB-INF/jspf/top.jspf"%>
<div class="container">
    <%
    
    String nombres=Persona.getNombres();nombres = nombres==null?"":nombres;
    String razon_social=Persona.getRazon_social();razon_social = razon_social==null?"":razon_social;
    String apellidos=Persona.getApellidos();apellidos = apellidos==null?"":apellidos;
    String genero=Persona.getGenero();genero = genero==null?"":genero;
    String fecha_nacimiento=Persona.getFecha_nac();fecha_nacimiento = fecha_nacimiento==null?"":fecha_nacimiento;
    String telefono=Persona.getTelefono();telefono = telefono==null?"":telefono;
    String celular=Persona.getCelular();celular = celular==null?"":celular;
    String t_doc=Persona.getId_tipo_doc();t_doc = t_doc==null?"":t_doc;
    String num_doc=Persona.getNumero_doc();num_doc = num_doc==null?"":num_doc;
    String ruc=Persona.getRuc();ruc = ruc==null?"":ruc;
    String direccion=Persona.getDireccion();direccion = direccion==null?"":direccion;
    String estado=Persona.getEstado();estado = estado == null ? "" : estado;
    
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
        
<% if(opcion.equals("Registrar")|| opcion.equals("Actualizando")){%>
<div class="row">      
        <div class="col-md-3">           
        </div>
        <div class="col-md-6 well">
            <h2 align="center">Registro de personas</h2>
            <br>
            <form action="controlpersona" method="post"> 
                <table class="table table-condensed">
                    <tbody>
                    <tr>
                        <input type="hidden" name="id_persona"  value="<%=Persona.getId_persona()%>" size="10">
                        <input type="hidden" name="opcion"  value="<%=opcion%>" size="10">
                        <td><label class="col-sm-12 control-label">Nombres:</label> </td> 
                        <td>
                            <div class="col-sm-15">
                                <input type="text" class="form-control" placeholder="Nombres" name="nombres" value="<%=nombres%>" maxlength="80">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><label class="col-sm-12 control-label">Apellidos:</label></td>
                        <td>
                            <div class="col-sm-15">
                                <input type="text" class="form-control" placeholder="Apellidos" name="apellidos" value="<%=apellidos%>" maxlength="80">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><label class="col-sm-12 control-label">Raz&oacute;n Social</label></td>
                        <td>
                            <div class="col-sm-15">
                                <input type="text" class="form-control" placeholder="Razón Social" name="razon_social" value="<%=razon_social%>" maxlength="100">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><label class="col-sm-12 control-label">Tipo Doc.:</label></td>
                        <td>
                            <select class="form-control" name="t_doc" selected="selected">
                                <option value="00004">Selecciona el tipo de documento</option>
                            <%
                                TipoDocumentoDao tdd = new TipoDocumentoDaoImpl();

                                for(TipoDocumento tipoDoc:tdd.ListarTipoDocumento()){      

                            %>

                             <option value="<%=tipoDoc.getId_tipo_doc()%>" <%if(t_doc.equals(tipoDoc.getId_tipo_doc())){%> selected<%}%>> <%=tipoDoc.getNombre()%></option>
                             <%}%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><label class="col-sm-12 control-label">N&deg; Doc:</label></td>
                        <td>
                            <div class="col-sm-15">
                                <input type="text" class="form-control" placeholder="Numero del documento" name="num_doc" value="<%=num_doc%>" maxlength="8">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><label class="col-sm-12 control-label">RUC:</label></td>
                        <td>
                            <div class="col-sm-15">
                                <input type="text" class="form-control" placeholder="RUC" name="ruc" value="<%=ruc%>" maxlength="11">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><label class="col-sm-12 control-label" >Tel&eacute;fono:</label></td>
                        <td>
                            <div class="col-sm-15">
                                <input type="text" class="form-control" placeholder="Telefono" name="telefono" value="<%=telefono%>" maxlength="10">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><label class="col-sm-12 control-label" >Celular:</label></td>
                        <td>
                            <div class="col-sm-15">
                                <input type="text" class="form-control" placeholder="Celular" name="celular" value="<%=celular%>" maxlength="9">
                            </div>
                        </td>
                    </tr>  
                    <%if(!opcion.equals("Actualizando")){%>
                    <tr>
                        <td><label class="col-sm-12 control-label" >F. Nacimiento:</label></td>
                        <td>
                            <div class="col-sm-15">
                                <input type="date" class="form-control" placeholder="Fecha de nacimiento" name="fecha_nac" value="<%=fecha_nacimiento%>">
                            </div>
                        </td>
                    </tr>
                    <%}%>
                    <tr>
                        <td><label class="col-sm-12 control-label">G&eacute;nero:</label></td>
                        <td>
                            <label class="radio-inline">
                                <input type="radio" name="genero" value="M"<%if(genero.equals("M")){%> checked<%}%>> Masculino
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="genero" value="F"<%if(genero.equals("F")){%> checked<%}%>> Femenino
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td><label class="col-sm-12 control-label">Dirección:</label></td>
                        <td>
                            <div class="col-sm-15">
                                <textarea rows="3" class="form-control" placeholder="Dirección" name="direccion" maxlength="200"><%=direccion%></textarea>
                            </div>
                        </td>
                    </tr>
                    <%if(opcion.equals("Actualizando")){%>
                    <tr>
                        <td><label class="col-sm-12 control-label">Estado:</label></td>
                        <td>
                            <label class="radio-inline">
                                <input type="radio" name="estado" value="1"<%if(Persona.getEstado().equals("1")){%> checked<%}%>> Activo
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="estado" value="0"<%if(Persona.getEstado().equals("0")){%> checked<%}%>> Inactivo
                            </label>
                        </td>
                    </tr>
                    <%}%>
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
 
 <%if(opcion.equals("Asignar")){%>
 <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6 well">
            <h3 align="center">Especificar la funci&oacute;n de la persona</h3>
            <br>
            <form method="post" action="controlpersona">
                <table width="275" border="0" align="center">
                  <tr>
                    <input type="hidden" name="opcion"  value="<%=opcion%>" size="10">
                    <input type="hidden" name="id_persona"  value="<%=id_persona%>" size="10">
                    <td align="center">Usuario</td>
                    <td align="center">Proveedor</td>
                    <td align="center">Cliente</td>    
                  </tr>
                  <tr>
                    <td align="center"><input type="radio" name="t_per" id="radio6" value="User" <%if(t_per.equals("User")){%> checked<%}%> onclick="submit()"></td>
                    <td align="center"><input type="radio" name="t_per" id="radio9" value="Prov" <%if(t_per.equals("Prov")){%> checked<%}%> onclick="submit()"></td>
                    <td align="center"><input type="radio" name="t_per" id="radio8" value="Cliente" <%if(t_per.equals("Cliente")){%> checked<%}%> onclick="submit()"></td>
                  </tr>
                </table>
            </form>
            <br><br>
            <form action="controlpersona" method="post"> 
                <table class="table table-condensed">
                    <tbody>
                        <input type="hidden" name="opcion"  value="Asignando" size="10">
                        <input type="hidden" name="t_per"  value="<%=t_per%>" size="10">
                        <input type="hidden" name="id_persona"  value="<%=id_persona%>" size="10">
                            
                            <%if(t_per.equals("User")){%>
                            <tr>
                                <td><label class="col-sm-7 control-label">Login:</label></td>
                                <td>
                                    <div class="col-sm-15">
                                        <input rows="3" class="form-control" placeholder="Login" name="login" value="<%=Usuario.getLogin()%>">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td><label class="col-sm-7 control-label">Password:</label></td>
                                <td>
                                    <div class="col-sm-15">
                                        <input rows="3" type="password" class="form-control"  placeholder="Password" name="password" value="<%=Usuario.getPassword()%>">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td><label class="col-sm-7 control-label">Rol:</label></td>
                                <td>
                                    <select class="form-control" name="id_rol" selected="selected" <%if(Usuario.getIdRol().equals("")){%> selected<%}%>>> 
                                        <option>Seleciona el rol</option>
                                    <%
                                        TipoDocumentoDao tdd = new TipoDocumentoDaoImpl();

                                        for(Rol rol:tdd.ListarRoles()){
                                    %>
                                     <option value="<%=rol.getIdRol()%>" <%if(Usuario.getIdRol().equals(rol.getIdRol())){%> selected<%}%>> <%=rol.getNombre()%></option>
                                     <%}%>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center">
                                    <input type="submit" class="btn btn-primary" value="<%=opcion%>">
                                    <input type="reset" class="btn btn-default" value="Limpiar">
                                </td> 
                            </tr>
                            <%}%>
                            <%if(t_per.equals("Prov")){%>
                            <tr>
                                <td><label class="col-sm-7 control-label">Correo:</label></td>
                                <td>
                                    <div class="col-sm-15">
                                        <input rows="3" class="form-control" placeholder="Correo Electrónico" name="correo" value="<%=Proveedor.getCorreo_electronico()%>">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td><label class="col-sm-7 control-label">N&deg; Cta. Cte.</label></td>
                                <td>
                                    <div class="col-sm-15">
                                        <input rows="3" class="form-control" placeholder="Número de Cuenta" name="num_cuenta" value="<%=Proveedor.getNum_cuenta()%>">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center">
                                    <input type="submit" class="btn btn-primary" value="<%=opcion%>">
                                    <input type="reset" class="btn btn-default" value="Limpiar">
                                </td> 
                            </tr>
                            <%}%>
                            <%if(t_per.equals("Cliente")){%>
                            <tr>
                                <td><label class="col-sm-8 control-label">Cat. Cliente:</label></td>
                                <td>
                                    <select class="form-control" name="id_categoria" selected="selected" <%if(Cliente.getIdTipoCliente().equals("")){%> selected<%}%>>> 
                                        <option>Seleciona el rol</option>
                                    <%
                                        TipoDocumentoDao tdd = new TipoDocumentoDaoImpl();

                                        for(CatCliente cc : tdd.ListarCatCliente()){
                                    %>
                                     <option value="<%=cc.getIdCategoria()%>" <%if(Cliente.getIdTipoCliente().equals(cc.getIdCategoria())){%> selected<%}%>> <%=cc.getNombre()%></option>
                                     <%}%>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center">
                                    <input type="submit" class="btn btn-primary" value="<%=opcion%>">
                                    <input type="reset" class="btn btn-default" value="Limpiar">
                                </td> 
                            </tr>
                            <%}%>
                    </tbody>
                </table>
            </form>
        </div>
        <div class="col-md-3"></div>     
</div>      
 <%}%>
</div>       
<%@include file="WEB-INF/jspf/botton.jspf" %>

