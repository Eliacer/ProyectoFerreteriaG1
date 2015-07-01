
<%@page import="proy01.modelo.daoImpl.PersonaDaoImpl"%>
<%@page import="proy01.modelo.dao.PersonaDao"%>
<%@page import="proy01.modelo.entidad.Persona"%>
<jsp:useBean id="mensaje" scope="request" class="java.lang.String" />
<jsp:useBean id="alert" scope="request" class="java.lang.String" />
<%@include file="WEB-INF/jspf/top.jspf" %>

<div class="container">    
    <h3 align="center">Reporte de personas</h3>
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
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10 well">
            <div class="tab-pane">
            <table class="table table-hover table-striped table-bordered">
              <thead>
                <tr>
                  <td width="2%" bgcolor="#FFEFCE"><strong>#</strong></td>
                  <td width="26%" bgcolor="#FFEFCE"><strong>Nombres/Razon Soc.</strong></td>
                  <td  align="center" width="12%" bgcolor="#FFEFCE"><strong>DNI</strong></td>
                  <td  align="center" width="12%" bgcolor="#FFEFCE"><strong>Fecha de Nac.</strong></td>
                  <td  align="center" width="12%" bgcolor="#FFEFCE"><strong>Telefono</strong></td>
                  <td width="23%" bgcolor="#FFEFCE"><strong>Direcci&oacute;n</strong></td>
                  <td width="16%" align="center" bgcolor="#FFEFCE" colspan="2"><strong>Opciones</strong></td>
                </tr>
              </thead>
              <tbody>             
                  <%        
                      int count=0;
                      PersonaDao dao = new PersonaDaoImpl();
                      for(Persona persona: dao.ListarPersona()){
                          count++;
                          String espacio="  ";
                          String nombre=persona.getNombres();nombre = nombre == null ? "" : nombre;
                          String num_doc=persona.getNumero_doc();num_doc = num_doc == null ? "" : num_doc;
                          String fecha_nac=persona.getFecha_nac();fecha_nac = fecha_nac == null ? "" : fecha_nac;
                          String telefono=persona.getTelefono();telefono = telefono == null ? "" : telefono; 
                          String direccion=persona.getDireccion();direccion = direccion == null ? "" : direccion;                                     
                  %>
                <tr>
                    <td><%=count%>.-</td>
                    <td><%=nombre%></td>
                    <td  align="center"><%=num_doc%></td>
                    <td  align="center"><%=fecha_nac%></td>
                    <td  align="center"><%=telefono%></td>
                    <td><%=direccion%></td>
                    <td align="center">
                        <a href="controlpersona?opcion=Actualizar&id_persona=<%=persona.getId_persona()%>" title="Actualizar">
                            <button type="button" class="btn btn-info"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span></button><%=espacio%>
                        </a>
                    </td>
                    <td align="center">
                        <a href="controlpersona?opcion=Eliminar&id_persona=<%=persona.getId_persona()%>" title="Eliminar">
                            <button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
                        </a>
                    </td>
                </tr>
                <%}%>
              </tbody>
            </table>
          </div>
        </div>
        <div class="col-md-1"></div>   
    </div>
    
</div>
<%@include file="WEB-INF/jspf/botton.jspf" %>