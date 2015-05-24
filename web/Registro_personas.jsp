<%@page import="proy01.modelo.dao.TipoDocumentoDao"%>
<%@page import="java.util.*"%>
<%@page import="proy01.modelo.daoImpl.TipoDocumentoDaoImpl"%>
<%@page import="proy01.modelo.entidad.Persona"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="proy01.modelo.daoImpl.PersonaDaoImpl"%>
<%@page import="proy01.modelo.dao.PersonaDao"%>
<jsp:useBean id="tipoDoc" class="proy01.modelo.entidad.TipoDocumento"/>
<%@include file="WEB-INF/jspf/top.jspf"%>

<div class="container">
    <%
    
    String nombres=request.getParameter("nombres");nombres = nombres==null?"":nombres;
    String apellidos=request.getParameter("apellidos");apellidos = apellidos==null?"":apellidos;
    String genero=request.getParameter("genero");genero = genero==null?"":genero;
    String fecha_nacimiento=request.getParameter("fecha_nac");fecha_nacimiento = fecha_nacimiento==null?"":fecha_nacimiento;
    String telefono=request.getParameter("telefono");telefono = telefono==null?"":telefono;
    String t_doc=request.getParameter("t_doc");t_doc = t_doc==null?"":t_doc;
    String num_doc=request.getParameter("num_doc");num_doc = num_doc==null?"":num_doc; 
    String direccion=request.getParameter("direccion");direccion = direccion==null?"":direccion;
    
    String mensaje="";
    
    if(!nombres.equals("") && !apellidos.equals("") && !fecha_nacimiento.equals("") && !t_doc.equals("")&& !num_doc.equals("")
            && !telefono.equals("") && !genero.equals("")){
        
        Persona persona=new Persona();
        PersonaDao ppd=new PersonaDaoImpl();

        persona.setNombres(nombres);
        persona.setApellidos(apellidos);
        persona.setId_tipoDocum(t_doc);
        persona.setNumeroDoc(num_doc);
        persona.setFechaNac1(fecha_nacimiento);
        persona.setTelefono(telefono);
        persona.setDireccion(direccion);
        persona.setGenero(genero);

        if(ppd.InsertarPersona(persona))
        {
            response.sendRedirect("bienvenida.jsp");
        }else{
            mensaje="No se pudo agregar";
        }
    }    
%>

<div class="row">
    <div class="col-md-12" id="aler">
        <br>
        <%
            if(!mensaje.equals("")){
        %>
        <div class="alert alert-danger"><%=mensaje%></div> 
        <%}%>
    </div>
</div>
    <div class="row">      
            <div class="col-md-2">           
            </div>
            <div class="col-md-8 well">
                <div class="titleform1">
                    <h2>Formulario de Registro</h2>
                </div>
                <br>
                <div class="form1">
                    <form class="form-horizontal" action="Registro_personas.jsp">
                    <div class="form-group">
                        <label class="control-label col-xs-3">Nombres:</label>
                        <div class="col-xs-8">
                            <div class="input-group">
                            <span class="input-group-addon">@</span>
                            <input type="text" class="form-control" placeholder="Nombres" name="nombres">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3">Apellidos:</label>
                        <div class="col-xs-8">
                            <input type="text" class="form-control" placeholder="Apellidos" name="apellidos">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3">Tipo Documento:</label>
                        <div class="col-xs-8">
                            <select class="form-control" name="t_doc">                 
                            <%
                                TipoDocumentoDao tdd = new TipoDocumentoDaoImpl();
                                
                                for(int i=0;i<tdd.ListarTipoDocumento().size();i++){
                                    tipoDoc=tdd.ListarTipoDocumento().get(i);
                                    
                            %>
                                
                             <option value="<%=tipoDoc.getIdTipoDocumento()%>"><%=tipoDoc.getNombre()%></option>
                             <%}%>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3">N&deg; Doc:</label>
                        <div class="col-xs-8">
                            <input type="text" class="form-control" placeholder="Numero del documento" name="num_doc">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="control-label col-xs-3" >Telefono:</label>
                        <div class="col-xs-8">
                            <input type="text" class="form-control" placeholder="Telefono" name="telefono">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3" >F. Nacimiento:</label>
                        <div class="col-xs-8">
                            <input type="date" class="form-control" placeholder="Fecha de nacimiento" name="fecha_nac">

                        </div> 
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3">Dirección:</label>
                        <div class="col-xs-8">
                            <textarea rows="3" class="form-control" placeholder="Dirección" name="direccion"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3">G&eacute;nero:</label>
                        <div class="col-xs-3">
                            <label class="radio-inline">
                                <input type="radio" name="genero" value="M"> Masculino
                            </label>
                        </div>
                        <div class="col-xs-3">
                            <label class="radio-inline">
                                <input type="radio" name="genero" value="F"> Femenino
                            </label>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                    <div class="col-md-2">           
                    </div>
                    <div class="col-md-7">                           
                    <div class="form-group">
                        <div class="col-xs-offset-3 col-xs-9">
                            <input type="submit" class="btn btn-primary" value="Enviar">
                            <input type="reset" class="btn btn-default" value="Limpiar">
                        </div>
                        <br><br><br>            
                    </div>
                    </div>
                    <div class="col-md-3">                       
                    </div>
                    </div>
                </form>
                </div>       
            </div> 
        <%=mensaje%>
            <div class="col-md-2">           
            </div>
    </div>
</div>       
<%@include file="WEB-INF/jspf/botton.jspf" %>

