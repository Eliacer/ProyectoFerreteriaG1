
<%@page import="proy01.modelo.daoImpl.PersonaDaoImpl"%>
<%@page import="proy01.modelo.dao.PersonaDao"%>
<%@page import="proy01.modelo.entidad.Persona"%>
<%@include file="WEB-INF/jspf/top.jspf" %>

<div class="container">  
    <h3 align="center">Reporte de personas</h3>
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10 well">
            <div class="tab-pane">
            <table class="table table-hover table-striped table-bordered">
              <thead>
                <tr>
                  <td width="2%" bgcolor="#FFEFCE"><strong>#</strong></td>
                  <td width="30%" bgcolor="#FFEFCE"><strong>Nombres y Apellidos</strong></td>
                  <td  align="center" width="13%" bgcolor="#FFEFCE"><strong>Doc. Identidad</strong></td>
                  <td  align="center" width="15%" bgcolor="#FFEFCE"><strong>F. de Nacimiento</strong></td>
                  <td  align="center" width="13%" bgcolor="#FFEFCE"><strong>Telefono</strong></td>
                  <td width="30%" bgcolor="#FFEFCE"><strong>Direcci&oacute;n</strong></td>
                </tr>
              </thead>
              <tbody>             
                  <%        
                      int count=0;
                      PersonaDao dao = new PersonaDaoImpl();
                      for(Persona persona: dao.ListarPersona()){
                          count++;                 
                  %>
                <tr>
                  <td><%=count%>.-</td>
                  <td><%=persona.getNombres()%></td>
                  <td  align="center"><%=persona.getNumeroDoc()%></td>
                  <td  align="center"><%=persona.getFechaNac1()%></td>
                  <td  align="center"><%=persona.getTelefono()%></td>
                  <td><%=persona.getDireccion()%></td>
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