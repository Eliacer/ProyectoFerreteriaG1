
<%@page import="proy01.modelo.entidad.Proveedor"%>
<%@page import="proy01.modelo.daoImpl.ProductoDaoImpl"%>
<%@page import="proy01.modelo.dao.ProductoDao"%>
<%@page import="proy01.modelo.entidad.Producto"%>
<%@page import="proy01.modelo.daoImpl.PersonaDaoImpl"%>
<%@page import="proy01.modelo.dao.PersonaDao"%>
<%@page import="proy01.modelo.entidad.Persona"%>
<%@include file="WEB-INF/jspf/top.jspf" %>

<div class="container">  
    
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10">
            <ul class="nav nav-tabs">
                <li class="active"><a href="#cliente" data-toggle="tab">Clientes Potenciales</a></li>
                <li><a href="#producto" data-toggle="tab">Productos Portenciales</a></li>
                <li><a href="#proveedor" data-toggle="tab">Proveedores Protenciales</a></li>
            </ul>
            <div class="tab-content">  
                <div class="tab-pane fade in active" id="cliente">
                    <div class="col-md-1"></div>
                    <div class="col-md-10">
                    <div class="tab-pane">
                    <table class="table table-hover table-striped table-bordered">
                      <thead>
                        <tr>
                          <td width="2%" bgcolor="#FFEFCE"><strong>#</strong></td>
                          <td width="30%" bgcolor="#FFEFCE"><strong>Nombres y Apellidos</strong></td>
                          <td  align="center" width="15%" bgcolor="#FFEFCE"><strong>DNI</strong></td>
                          <td  align="center" width="15%" bgcolor="#FFEFCE"><strong>Telefono</strong></td>
                          <td align="center"width="15%" bgcolor="#FFEFCE"><strong>Monto</strong></td>
                        </tr>
                      </thead>
                      <tbody>             
                          <%        
                              int count=0;
                              PersonaDao dao = new PersonaDaoImpl();
                              for(Persona persona: dao.ListarClientePotencial()){
                                  count++;
                                  String nombre=persona.getNombres();nombre = nombre == null ? "" : nombre;
                                  String num_doc=persona.getNumero_doc();num_doc = num_doc == null ? "" : num_doc;
                                  String telefono=persona.getTelefono();telefono = telefono == null ? "" : telefono; 
                                  String monto=persona.getEstado();monto = monto == null ? "" : monto;                                     
                          %>
                        <tr>
                            <td><%=count%>.-</td>
                            <td><%=nombre%></td>
                            <td  align="center"><%=num_doc%></td>
                            <td  align="center"><%=telefono%></td>
                            <td align="right"><%=monto%></td>
                        </tr>
                        <%}%>
                      </tbody>
                    </table>
                    </div>
                    </div>
                    <div class="col-md-1"></div>
                </div>
                <div class="tab-pane fade" id="producto">
                    <div class="col-sm-1 col-md-2"></div>
                    <div class=" col-sm-10 col-md-8">
                   <div class="tab-pane">
                    <table class="table table-hover table-striped table-bordered">
                      <thead>
                        <tr>
                          <td width="2%" bgcolor="#FFEFCE"><strong>#</strong></td>
                          <td width="25%" bgcolor="#FFEFCE"><strong>Nombre del Producto.</strong></td>
                          <td  align="center" width="9%" bgcolor="#FFEFCE"><strong>Marca</strong></td>
                          <td  align="center" width="11%" bgcolor="#FFEFCE"><strong>Monto</strong></td>
                        </tr>
                      </thead>
                      <tbody>             
                          <%    
                              int c=0;
                              ProductoDao pd = new ProductoDaoImpl();
                              for(Producto producto: pd.ProductosPotencia()){
                                  c++;
                                  String product=producto.getNombre();product = product == null ? "" : product;
                                  String marca=producto.getId_marca();marca = marca == null ? "" : marca;
                                  double monto=producto.getPrecio();monto = monto == 0 ? 0 : monto;
                          %>
                        <tr>
                            <td><%=c%>.-</td>
                            <td><%=product%></td>
                            <td><%=marca%></td>
                            <td  align="right"><%=monto%></td>
                        </tr>
                        <%}%>
                      </tbody>
                    </table>
                    </div> 
                    </div>
                    <div class=" col-sm-1 col-md-2"></div>
                </div>
                <div class="tab-pane fade" id="proveedor">
                    <div class=" col-sm-1 col-md-1"></div>
                    <div class=" col-sm-10 col-md-10">
                    <div class="tab-pane">
                        <table class="table table-hover table-striped table-bordered">
                          <thead>
                            <tr>
                              <td width="2%" bgcolor="#FFEFCE"><strong>#</strong></td>
                              <td width="26%" bgcolor="#FFEFCE"><strong>Razon Social</strong></td>
                              <td align="center" width="10%" bgcolor="#FFEFCE"><strong>RUC</strong></td>
                              <td align="center" width="15%" bgcolor="#FFEFCE"><strong>Correo electr&oacute;nico</strong></td>
                              <td align="center" width="15%" bgcolor="#FFEFCE"><strong>Monto</strong></td>
                            </tr>
                          </thead>
                          <tbody>             
                              <%        
                                  int co=0;
                                  for(Proveedor proveedor : dao.ListarProveedorPotencial()){
                                      co++;
                                      String rz=proveedor.getId_proveedor();rz = rz == null ? "" : rz;
                                      String ruc=proveedor.getNum_cuenta();ruc = ruc == null ? "" : ruc;
                                      String correo=proveedor.getCorreo_electronico();correo = correo == null ? "" : correo; 
                                      String monto=proveedor.getEstado();monto = monto == null ? "" : monto;        
                              %>
                            <tr onmouseover="this.style.backgroundColor = 'pink';" onmouseout="this.style.backgroundColor = 'white';" style="background-color: white ;"> 
                                <td><%=co%>.-</td>
                                <td><%=rz%></td>
                                <td align="center"><%=ruc%></td>
                                <td><%=correo%></td>
                                <td align="right"><%=monto%></td>
                            </tr>
                            <%}%>
                          </tbody>
                        </table>
                    </div>
                    </div>
                    <div class=" col-sm-1 col-md-1"></div>
                </div> 
            </div> 
        </div>
    </div>
</div>
<%@include file="WEB-INF/jspf/botton.jspf" %>