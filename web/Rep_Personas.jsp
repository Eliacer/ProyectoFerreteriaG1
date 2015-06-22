
<%@page import="proy01.modelo.daoImpl.PersonaDaoImpl"%>
<%@page import="proy01.modelo.dao.PersonaDao"%>
<%@page import="proy01.modelo.entidad.Persona"%>
<%@include file="WEB-INF/jspf/top.jspf" %>

<div class="container">  
    
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10">
            <ul class="nav nav-tabs">
                <li class="active"><a href="#usuario" data-toggle="tab">Reportes de Usuarios</a></li>
                <li><a href="#cliente" data-toggle="tab">Reportes de Clientes</a></li>
                <li><a href="#proveedor" data-toggle="tab">Reportes de Proveedores</a></li>
            </ul>
            <div class="tab-content">  
                <div class="tab-pane fade in active" id="usuario">
                    <div class="tab-pane">
                    <table class="table table-hover table-striped table-bordered">
                      <thead>
                        <tr>
                          <td width="2%" bgcolor="#FFEFCE"><strong>#</strong></td>
                          <td width="22%" bgcolor="#FFEFCE"><strong>Nombres y Apellidos</strong></td>
                          <td width="14%" bgcolor="#FFEFCE"><strong>Rol</strong></td>
                          <td  align="center" width="9%" bgcolor="#FFEFCE"><strong>DNI</strong></td>
                          <td  align="center" width="11%" bgcolor="#FFEFCE"><strong>Fecha de Nac.</strong></td>
                          <td  align="center" width="10%" bgcolor="#FFEFCE"><strong>Telefono</strong></td>
                          <td width="20%" bgcolor="#FFEFCE"><strong>Direcci&oacute;n</strong></td>
                        </tr>
                      </thead>
                      <tbody>             
                          <%        
                              int count=0;
                              PersonaDao dao = new PersonaDaoImpl();
                              for(Persona persona: dao.ListarUsuario()){
                                  count++;
                                  String nombre=persona.getNombres();nombre = nombre == null ? "" : nombre;
                                  String rol=persona.getRol();rol = rol == null ? "" : rol;
                                  String num_doc=persona.getNumero_doc();num_doc = num_doc == null ? "" : num_doc;
                                  String fecha_nac=persona.getFecha_nac();fecha_nac = fecha_nac == null ? "" : fecha_nac;
                                  String telefono=persona.getTelefono();telefono = telefono == null ? "" : telefono; 
                                  String direccion=persona.getDireccion();direccion = direccion == null ? "" : direccion;                                     
                          %>
                        <tr>
                            <td><%=count%>.-</td>
                            <td><%=nombre%></td>
                            <td><%=rol%></td>
                            <td  align="center"><%=num_doc%></td>
                            <td  align="center"><%=fecha_nac%></td>
                            <td  align="center"><%=telefono%></td>
                            <td><%=direccion%></td>
                        </tr>
                        <%}%>
                      </tbody>
                    </table>
                    </div>
                </div>
                <div class="tab-pane fade" id="cliente">
                   <div class="tab-pane">
                    <table class="table table-hover table-striped table-bordered">
                      <thead>
                        <tr>
                          <td width="2%" bgcolor="#FFEFCE"><strong>#</strong></td>
                          <td width="25%" bgcolor="#FFEFCE"><strong>Nombres/Razon Soc.</strong></td>
                          <td  align="center" width="9%" bgcolor="#FFEFCE"><strong>DNI</strong></td>
                          <td  align="center" width="11%" bgcolor="#FFEFCE"><strong>Fecha de Nac.</strong></td>
                          <td  align="center" width="10%" bgcolor="#FFEFCE"><strong>Telefono</strong></td>
                          <td width="22%" bgcolor="#FFEFCE"><strong>Direcci&oacute;n</strong></td>
                        </tr>
                      </thead>
                      <tbody>             
                          <%    
                              int c=0;
                              for(Persona persona: dao.ListarCliente()){
                                  c++;
                                  String nombre=persona.getNombres();nombre = nombre == null ? "" : nombre;
                                  String num_doc=persona.getNumero_doc();num_doc = num_doc == null ? "" : num_doc;
                                  String fecha_nac=persona.getFecha_nac();fecha_nac = fecha_nac == null ? "" : fecha_nac;
                                  String telefono=persona.getTelefono();telefono = telefono == null ? "" : telefono; 
                                  String direccion=persona.getDireccion();direccion = direccion == null ? "" : direccion;                                     
                          %>
                        <tr>
                            <td><%=c%>.-</td>
                            <td><%=nombre%></td>
                            <td  align="center"><%=num_doc%></td>
                            <td  align="center"><%=fecha_nac%></td>
                            <td  align="center"><%=telefono%></td>
                            <td><%=direccion%></td>
                        </tr>
                        <%}%>
                      </tbody>
                    </table>
                    </div> 
                </div>
                <div class="tab-pane fade" id="proveedor">
                    <div class="tab-pane">
                        <table class="table table-hover table-striped table-bordered">
                          <thead>
                            <tr>
                              <td width="2%" bgcolor="#FFEFCE"><strong>#</strong></td>
                              <td width="26%" bgcolor="#FFEFCE"><strong>Razon Social</strong></td>
                              <td align="center" width="12%" bgcolor="#FFEFCE"><strong>RUC</strong></td>
                              <td align="center" width="12%" bgcolor="#FFEFCE"><strong>Contactos</strong></td>
                              <td width="20%" bgcolor="#FFEFCE"><strong>Direcci&oacute;n</strong></td>
                              <td width="15%" bgcolor="#FFEFCE"><strong>Correo elect.</strong></td>
                              <td align="center" width="10%" bgcolor="#FFEFCE"><strong>N&deg; Cuenta</strong></td>
                            </tr>
                          </thead>
                          <tbody>             
                              <%        
                                  int co=0;
                                  for(Persona persona: dao.ListarProveedor()){
                                      co++;
                                      String rz=persona.getRazon_social();rz = rz == null ? "" : rz;
                                      String ruc=persona.getRuc();ruc = ruc == null ? "" : ruc;
                                      String telefono=persona.getTelefono();telefono = telefono == null ? "" : telefono; 
                                      String direccion=persona.getDireccion();direccion = direccion == null ? "" : direccion;        
                                      String correo=persona.getCorreo();correo = correo == null ? "" : correo;                                     
                                      String num_cuenta=persona.getNum_cuenta();num_cuenta = num_cuenta == null ? "" : num_cuenta;                                     
                              %>
                            <tr>
                                <td><%=co%>.-</td>
                                <td><%=rz%></td>
                                <td align="center"><%=ruc%></td>
                                <td align="center"><%=telefono%></td>
                                <td align="center"><%=direccion%></td>
                                <td><%=correo%></td>
                                <td align="center"><%=num_cuenta%></td>
                            </tr>
                            <%}%>
                          </tbody>
                        </table>
                    </div>
                </div> 
            </div> 
        </div>
    </div>
</div>
<%@include file="WEB-INF/jspf/botton.jspf" %>