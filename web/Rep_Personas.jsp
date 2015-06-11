
<%@page import="proy01.modelo.daoImpl.PersonaDaoImpl"%>
<%@page import="proy01.modelo.dao.PersonaDao"%>
<%@page import="proy01.modelo.entidad.Persona"%>
<%@include file="WEB-INF/jspf/top.jspf" %>

<div class="container">  
    
    <%
        String id_persona = request.getParameter("id_persona");id_persona = id_persona == null ? "" : id_persona;
        String opcion = request.getParameter("opcion");opcion = opcion == null ? "" : opcion;
        String mensaje="";
        if(opcion.equals("eliminar")){
        
            
            if(!id_persona.equals("")){
                PersonaDao dao = new PersonaDaoImpl();
                if(dao.DeletePersona(id_persona)){
                    mensaje="Se eliminó correctamente.";
                }
            }
        }
    
    %>
    <h3 align="center">Reporte de personas</h3>
    <div class="row">
    <div class="col-md-1"></div>
        <div class="col-md-10" id="aler">
            <br>
            <%
                if(!mensaje.equals("")){
            %>
            <div class="alert alert-danger"><%=mensaje%></div> 
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
                  <td width="22%" bgcolor="#FFEFCE"><strong>Nombres/Razon Soc.</strong></td>
                  <td  align="center" width="12%" bgcolor="#FFEFCE"><strong>N. Documento</strong></td>
                  <td  align="center" width="12%" bgcolor="#FFEFCE"><strong>Fecha de Nac.</strong></td>
                  <td  align="center" width="12%" bgcolor="#FFEFCE"><strong>Telefono</strong></td>
                  <td width="23%" bgcolor="#FFEFCE"><strong>Direcci&oacute;n</strong></td>
                  <td width="18%" align="center" bgcolor="#FFEFCE"><strong>Opciones</strong></td>
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
                  <td>
                        <a href="Registro_personas.jsp?opcion=Actualizar&id_persona=<%=persona.getId_persona()%>">[Actualizar]<%=espacio%></a>
                        <a href="Rep_Personas.jsp?opcion=eliminar&id_persona=<%=persona.getId_persona()%>">[Eliminar]</a>
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